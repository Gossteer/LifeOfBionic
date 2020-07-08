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
    class ProfileForm
    {
        public static Color UColor = Color.FromName("Control");

        private static Form FProf = new Form();
        private static Panel FPanel = new Panel()
        {
            Dock = DockStyle.Fill
        };
        private static string FIO = "";
        private static string Spec = "Неопределена";
        private static string Shedul = "Неопределен";
        private static string Prav = "Сдесь должны быть правила оказания услуг";
        private static string SeriesPass = "";
        private static string NumberPass = "";

        public static void NewProfileForm()
        {
            SqlParameter[] SP = new SqlParameter[]
            {
                new SqlParameter("@User_Nick", AutorizForm.Nick),
            };
            DataTable DT = DB.GetData("[SELECT_Profile_Personal]", SP);
            try
            {
                DataRow DR = DT.Rows[0];
                FIO = DR["SurnamePers"] + " " + DR["NamePers"] + " " + DR["PatronymicPers"];
                Spec = DR["Name_SpecialityPersonal"].ToString();
                Shedul = DR["График"].ToString();
                SeriesPass = DR["SeriesPassportPers"].ToString();
                NumberPass = DR["NumberPassportPers"].ToString();
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
                return;
            }

            SP = new SqlParameter[]
            {
                new SqlParameter("@User_Nick", AutorizForm.Nick),
            };
            DT = DB.GetData("SELECT_Regulation", SP);
            try
            {
                Prav = DT.Rows[0]["TextRegulation"].ToString();
            }
            catch { }

            FProf = new Form();
            FProf.Controls.Add(FPanel);

            FProf.Text = "Профиль " + AutorizForm.Nick;
            FProf.FormBorderStyle = FormBorderStyle.FixedSingle;
            FProf.MaximizeBox = false;
            FProf.StartPosition = FormStartPosition.CenterScreen;
     
            MainForm.CreateLabel(FPanel, "LogInLabel", "Пользователь: "+AutorizForm.Nick, 20, 20, 16);
            MainForm.CreateLabel(FPanel, "FIOLabel", "ФИО: "+FIO, 20, 60, 10);
            MainForm.CreateLabel(FPanel, "SpecLabel", "Специальность: "+Spec, 20, 90, 10);
            MainForm.CreateLabel(FPanel, "ShedulLabel", "График: " + Shedul, 20, 120, 10);
            MainForm.CreateButton(FPanel, "ExitButton", "Выход из системы", 20, 480 - 95, 175, 30, 10);
            FPanel.Controls["ExitButton"].Click += ExitButton;

            int maxWidth = 0;
            for (int i = 0; i < FPanel.Controls.Count; i++)
            {
                if (maxWidth < FPanel.Controls[i].Width)
                    maxWidth = FPanel.Controls[i].Width;
            }
            FProf.Width = maxWidth + 50;
            FProf.Height = 460;

            CreateTabControl();

            FProf.ShowDialog();            
        }
        private static void TextChange(object sender, EventArgs e)
        {
            bool Redy1 = ((((FPanel.Controls["TabC"] as TabControl).Controls["PassPage"] as TabPage).Controls["OldPassTB"] as MaskedTextBox).Text != "");
            bool Redy2 = ((((FPanel.Controls["TabC"] as TabControl).Controls["PassPage"] as TabPage).Controls["NewPassTB"] as MaskedTextBox).Text != "");
            bool Redy3 = ((((FPanel.Controls["TabC"] as TabControl).Controls["PassPage"] as TabPage).Controls["ApplyNewPassTB"] as MaskedTextBox).Text != "");
            ((((FPanel.Controls["TabC"] as TabControl).Controls["PassPage"] as TabPage).Controls["PassBut"] as Button).Enabled) = ((Redy1) & (Redy2) & (Redy3));
        }

        private static void PassButton(object sender, EventArgs e)
        {
            string OldPass = (((FPanel.Controls["TabC"] as TabControl).Controls["PassPage"] as TabPage).Controls["OldPassTB"] as MaskedTextBox).Text;
            string NewPass = (((FPanel.Controls["TabC"] as TabControl).Controls["PassPage"] as TabPage).Controls["NewPassTB"] as MaskedTextBox).Text;
            string AcceptNewPass = (((FPanel.Controls["TabC"] as TabControl).Controls["PassPage"] as TabPage).Controls["ApplyNewPassTB"] as MaskedTextBox).Text;
            
            if (NewPass == AcceptNewPass)
            {
                SqlParameter[] SP = new SqlParameter[]
                {
                    new SqlParameter("@SeriesPassportPers", SeriesPass),
                    new SqlParameter("@NumberPassportPers", NumberPass),
                    new SqlParameter("@User_Pass", OldPass),
                    new SqlParameter("@New_User_Pass", NewPass),
                };
                DB.UpdData("[UPD_Personal]", SP);

                (((FPanel.Controls["TabC"] as TabControl).Controls["PassPage"] as TabPage).Controls["OldPassTB"] as MaskedTextBox).Text = "";
                (((FPanel.Controls["TabC"] as TabControl).Controls["PassPage"] as TabPage).Controls["NewPassTB"] as MaskedTextBox).Text = "";
                (((FPanel.Controls["TabC"] as TabControl).Controls["PassPage"] as TabPage).Controls["ApplyNewPassTB"] as MaskedTextBox).Text = "";

                MessageBox.Show("Пароль успешно изменен");
            }
            else
            {
                MessageBox.Show("Новые пароли должны совпадать!", "Ошибка ввода!");
            }
        }
        private static void ExitButton(object sender, EventArgs e)
        {
            Form F = Application.OpenForms[0];
            (F as MainForm).LastLabel = new LinkLabel();
            (F as MainForm).DelControls();
            (F as MainForm).SearchPanel.Visible = false;
            AutorizForm.Spec = "";
            DB.LogIn = false;
            (F as MainForm).Form1_Activated(F, new EventArgs());
            FProf.Close();
        }

        private static void CreateTabControl()
        {
            TabControl tab = new TabControl()
            {
                Name = "TabC",
                Location = new Point(20, 150),
                Width = FProf.Width - 50,
                Height = FProf.Height - 230,
            };

            tab.TabPages.Add("Правила оказания услуг");
            TextBox TB = new TextBox()
            {
                Name = "tabTB",
                Text = Prav,
                Multiline = true,
                Dock = DockStyle.Fill,
                ReadOnly = true,
                ScrollBars = ScrollBars.Both,
            };
            tab.TabPages[0].Controls.Add(TB);



            TabPage Tp = new TabPage()
            {
                Name = "PassPage",
                Text = "Смена пароля",
            };
            tab.TabPages.Add(Tp);
            Label Lb = new Label()
            {
                Name = "OldPassLabel",
                Text = "Введите предыдущий пароль",
                Location = new Point(20, 10),
                AutoSize = true,
            };
            MaskedTextBox MTB = new MaskedTextBox()
            {
                Name = "OldPassTB",
                Location = new Point(20, 33),
                Size = new Size(150, 20),
            };
            MTB.TextChanged += TextChange;
            MTB.UseSystemPasswordChar = true;
            tab.TabPages[1].Controls.Add(Lb);
            tab.TabPages[1].Controls.Add(MTB);

            Lb = new Label()
            {
                Name = "NewPassLabel",
                Text = "Введите новый пароль",
                Location = new Point(20, 33+30),
                AutoSize = true,
            };
            MTB = new MaskedTextBox()
            {
                Name = "NewPassTB",
                Location = new Point(20, 63+23),
                Size = new Size(150, 20),
            };
            MTB.TextChanged += TextChange;
            MTB.UseSystemPasswordChar = true;
            tab.TabPages[1].Controls.Add(Lb);
            tab.TabPages[1].Controls.Add(MTB);

            Lb = new Label()
            {
                Name = "ApplyNewPassLabel",
                Text = "Подтвердите новый пароль",
                Location = new Point(20, 63+23+30),
                AutoSize = true,
            };
            MTB = new MaskedTextBox()
            {
                Name = "ApplyNewPassTB",
                Location = new Point(20, 63 + 23 + 30 + 23),
                Size = new Size(150, 20),
            };
            MTB.TextChanged += TextChange;
            MTB.UseSystemPasswordChar = true;
            tab.TabPages[1].Controls.Add(Lb);
            tab.TabPages[1].Controls.Add(MTB);

            Button B = new Button()
            {
                Name = "PassBut",
                Text = "Сменить пароль",
                Location = new Point(20, 63 + 23 + 30 + 23+30),    
                Size = new Size(150,30),
                Enabled = false,
            };
            tab.TabPages[1].Controls.Add(B);
            B.Click += PassButton;
            FPanel.Controls.Add(tab);


            TabPage Tp3 = new TabPage()
            {
                Name = "ColorPage",
                Text = "Смена интерфейса",
            };
            Button But = new Button()
            {
                Location = new Point(20,10),
                Size = new Size(150,30),
                Text = "Сменить цвет",
            };
            But.Click += ColorClick;
            Tp3.Controls.Add(But);
            tab.TabPages.Add(Tp3);
        }
        private static void ColorClick(object sender, EventArgs e)
        {
            ColorDialog CDG = new ColorDialog();
            
            if (CDG.ShowDialog() == DialogResult.Cancel)
                return;

            UColor = CDG.Color;
            SqlParameter[] SP = new SqlParameter[]
            {
                new SqlParameter("@id_worker", AutorizForm.id_Worker),
                new SqlParameter("@color", CDG.Color.Name),
            };
            DB.WriteData("UPD_Personal", SP);

            (Application.OpenForms[0] as MainForm).Form1_Activated((Application.OpenForms[0] as MainForm), new EventArgs());
        }
    }
}
