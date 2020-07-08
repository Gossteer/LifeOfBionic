using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApp9
{
    static class EditDelForm
    {
        private static Form FEditDel = new Form();
        public static int Type = 0;
        public static string Pick1 = "";
        public static string Pick2 = "";
        public static string LastBox { get; private set; } = "";
        public static string Caption = "Изменение";
        public static DataTable DTDiagnoz = new DataTable();

        public static string EditData { get; set; } = "";
        public static string LastResult { get; private set; } = "";
        public static int kolVo { get; private set; } = 0;
                
        public static void ComboForm(string Mess)
        {
            LastBox = "";
            FEditDel = new Form();

            Label L = new Label()
            {
                Name = "MessageLabel",
                Text = Mess,
                Visible = true,
                Location = new Point(20, 10),
                AutoSize = true,
                Font = new Font("Microsoft Sans Serif", 10),
            };
            FEditDel.Controls.Add(L);
            ComboBox Cb = new ComboBox()
            {
                Name = "DiagnozCB",
                Visible = true,
                Enabled = true,
                Location = new Point(20, 45),
                Size = new Size(250, 20),
            };
            FEditDel.Controls.Add(Cb);

            SqlParameter[] SP = new SqlParameter[0];
            DTDiagnoz = DB.GetData("Select_Diagnos_ForPosa", SP);

            for (int i = 0; i<DTDiagnoz.Rows.Count; i++)
            {
                DataRow DR = DTDiagnoz.Rows[i];
                Cb.Items.Add(DR[1]);
            }

            FEditDel.Text = "Госпитализация";
            FEditDel.Size = new Size(L.Width + 12 + 20 + 20, L.Height + 60 + 30);
            FEditDel.FormBorderStyle = FormBorderStyle.FixedSingle;
            FEditDel.MaximizeBox = false;
            FEditDel.StartPosition = FormStartPosition.CenterScreen;

            if (FEditDel.Width < 400)
                FEditDel.Width = 400;
            if (FEditDel.Height < 150)
                FEditDel.Height = 150;

            Button CancelBut = new Button()
            {
                Name = "EditButton",
                Text = "Отмена",
                Visible = true,
                Enabled = true,
                Size = new Size(75, 25),
                Location = new Point(FEditDel.Width - 75 - 30,
                    FEditDel.Height - 30 - 6 - 28 - 10),
            };
            FEditDel.Controls.Add(CancelBut);
            Button OkBut = new Button()
            {
                Name = "OkButton",
                Text = "Ввод",
                Visible = true,
                Enabled = true,
                Size = new Size(75, 25),
                Location = new Point(CancelBut.Left - 75 - 5,
                    FEditDel.Height - 30 - 6 - 28 - 10),
            };
            FEditDel.Controls.Add(OkBut);

            OkBut.Click += OkBut_Click;
            CancelBut.Click += Cancel;

            FEditDel.ShowDialog();
        }
        private static void OkBut_Click(object sender, EventArgs e)
        {
            try
            {
                LastBox = (FEditDel.Controls["DiagnozCB"] as ComboBox).SelectedItem.ToString();
                FEditDel.Close();
            }
            catch
            {
                MessageBox.Show("Нельзя госпитализировать без диагноза.\nПожалуйста выберите диагноз");
            }
        }

        public static void NewKolVo(string Mess)
        {
            kolVo = 0;
            LastResult = "";

            Label L = new Label()
            {
                Name = "MessageLabel",
                Text = Mess,
                Visible = true,
                Location = new Point(20, 10),
                AutoSize = true,
                Font = new Font("Microsoft Sans Serif", 10),
            };
            FEditDel = new Form();
            FEditDel.Controls.Add(L);
            TextBox Tb = new TextBox()
            {
                Name = "KolVoTB",
                Visible = true,
                Enabled = true,
                Location = new Point(20, 45),
                Size = new Size(100, 20),
            };
            FEditDel.Controls.Add(Tb);

            FEditDel.Text = "Ввод";
            FEditDel.Size = new Size(L.Width + 12 + 20 + 20,
            FEditDel.Controls["MessageLabel"].Height + 60 + 30);
            FEditDel.FormBorderStyle = FormBorderStyle.FixedSingle;
            FEditDel.MaximizeBox = false;
            FEditDel.StartPosition = FormStartPosition.CenterScreen;

            if (FEditDel.Width < 400)
                FEditDel.Width = 400;
            if (FEditDel.Height < 150)
                FEditDel.Height = 150;

            Button CancelBut = new Button()
            {
                Name = "EditButton",
                Text = "Отмена",
                Visible = true,
                Enabled = true,
                Size = new System.Drawing.Size(75, 25),
                Location = new System.Drawing.Point(FEditDel.Width - 75 - 30,
                    FEditDel.Height - 30 - 6 - 28 - 10),
            };
            FEditDel.Controls.Add(CancelBut);
            Button OkBut = new Button()
            {
                Name = "OkButton",
                Text = "Ввод",
                Visible = true,
                Enabled = true,
                Size = new System.Drawing.Size(75, 25),
                Location = new System.Drawing.Point(CancelBut.Left - 75 - 5,
                    FEditDel.Height - 30 - 6 - 28 - 10),
            };
            FEditDel.Controls.Add(OkBut);

            OkBut.Click += new EventHandler(OkButton);
            CancelBut.Click += new EventHandler(Cancel);

            FEditDel.ShowDialog();
        }
        private static void OkButton(object sender, EventArgs e)
        {
            kolVo = Convert.ToInt32(FEditDel.Controls["KolVoTB"].Text);
            FEditDel.Close();
        }
            
        public static void NewMess(string Pick1, string Pick2, int Type)
        {
            FEditDel = new Form();

            if (Type !=2)
                EditData = "";
            EditDelForm.Type = Type;
            EditDelForm.Pick1 = Pick1;
            EditDelForm.Pick2 = Pick2;
            LastResult = "";

            if (Type == 0)
            {
                Label L = new Label()
                {
                    Name = "MessageLabel",
                    Text = Pick1 + " или " + Pick2,
                    Visible = true,
                    Location = new Point(20, 10),
                    AutoSize = true,
                    Font = new Font("Microsoft Sans Serif", 10),
                };
                FEditDel.Controls.Add(L);
                FEditDel.Size = new Size(L.Width + 12 + 20 + 20,
                     FEditDel.Controls["MessageLabel"].Height + 60 + 30);
            }

            FEditDel.Text = "Изменение";
            if (Type == 2)
                FEditDel.Size = new Size(12 + 20 + 20, 60 + 30);
            FEditDel.FormBorderStyle = FormBorderStyle.FixedSingle;
            FEditDel.MaximizeBox = false;
            FEditDel.StartPosition = FormStartPosition.CenterScreen;

            if (Type == 2)
            {
                TextBox TB = new TextBox()
                {
                    Name = "EditTB",
                    Text = EditData,
                    Location = new Point(20, 23),
                    Size = new Size(200, 20),
                };
                FEditDel.Controls.Add(TB);
            }

            if (FEditDel.Width < 300)
                FEditDel.Width = 300;
            if (FEditDel.Height < 130)
                FEditDel.Height = 130;

            Button CancelBut = new Button()
            {
                Name = "EditButton",
                Text = "Отмена",
                Visible = true,
                Enabled = true,
                Size = new System.Drawing.Size(75, 25),
                Location = new System.Drawing.Point(FEditDel.Width - 75 - 30,
                    FEditDel.Height - 30 - 6 - 28 - 10),
            };
            FEditDel.Controls.Add(CancelBut);
            Button DelBut = new Button()
            {
                Name = "DelButton",
                Text = Pick2,
                Visible = true,
                Enabled = true,
                Size = new System.Drawing.Size(75, 25),
                Location = new System.Drawing.Point(CancelBut.Left - 75 - 5,
                    FEditDel.Height - 30 - 6 - 28 - 10),
            };
            FEditDel.Controls.Add(DelBut);
            Button EditBut = new Button()
            {
                Name = "EditButton",
                Text = Pick1,
                Visible = true,
                Enabled = true,
                Size = new System.Drawing.Size(100, 25),
                Location = new System.Drawing.Point(DelBut.Left - 100 - 5,
                    FEditDel.Height - 30 - 6 - 28 - 10),
            };
            FEditDel.Controls.Add(EditBut);
            
            DelBut.Click += new EventHandler(ButtonClick);
            EditBut.Click += new EventHandler(ButtonClick);
            CancelBut.Click += new EventHandler(Cancel);

            FEditDel.ShowDialog();
        }
        //кнопки
        private static void ButtonClick(object sender, EventArgs e)
        {
            switch ((sender as Button).Name)
            {
                case "DelButton":
                    {
                        LastResult = Pick2;
                        FEditDel.Close();
                        break;
                    }
                case "EditButton":
                    {
                        if (Type == 2)
                        {
                            EditData = FEditDel.Controls["EditTB"].Text;
                        }
                        LastResult = Pick1;
                        FEditDel.Close();
                        break;
                    }
            }
        }
        private static void Cancel(object sender, EventArgs e)
        {
            LastResult = "Cancel";
            FEditDel.Close();
        }
    }
}
