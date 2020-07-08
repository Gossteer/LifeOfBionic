using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApp9
{
    class DischargeForm
    {
        private int ID_Write;
        private DataTable DT;

        private Form FDisch = new Form();
        private TextBox Tb = new TextBox();
        private MaskedTextBox mtb = new MaskedTextBox();
        private ComboBox cb = new ComboBox();
        private Button but = new Button();

        private Font DefFont = new Font("Microsoft Sans Serif", 10);
        private Color DefBackColor = Color.FromName("Control");
        private Color DefTextColor = Color.FromName("ControlText");

        //Позиции                                               //позиции
        private Point locTypeCB = new Point(40, 15);            //ComboBox тип выписки
        private Point locNewBut = new Point(200, 15);            //кнопка Создать
        private Point locDelBut = new Point(315, 15);            //кнопка Создать
        private Point locPrintBut = new Point(430, 15);        //кнопка Печать

        //размеры                                               //размеры
        private Size sizeTypeCB = new Size(150, 30);            //ComboBox тип выписки
        private int sizeDG =                    300;            //DataGridView выписки
        private Size sizeNewBut = new Size(100, 27);            //кнопка Создать
        private Size sizeDelBut = new Size(100, 27);            //кнопка Создать
        private Size sizePrintBut = new Size(100, 27);          //кнопка печать

        public DischargeForm()
        {

        }

        //выписки
        public void NewDischForm(int idWrite)
        {
            Application.OpenForms[0].Enabled = false;
            

            CreateTypeCB();
            CreateNewButton();
            CreateDelButton();
            CreatePrintButton();
            CreateDataGrid(idWrite);

            FDisch.Text = "Выписки";
            FDisch.Size = new Size(600, 400);
            FDisch.FormBorderStyle = FormBorderStyle.FixedSingle;
            FDisch.MaximizeBox = false;
            FDisch.StartPosition = FormStartPosition.CenterScreen;

            FDisch.FormClosing += new FormClosingEventHandler(FormClosing);
            (FDisch.Controls["NewButton"] as Button).Click += new EventHandler(ApplyButtonClick);
            (FDisch.Controls["DelButton"] as Button).Click += new EventHandler(DelButtonClick);
            (FDisch.Controls["PrintButton"] as Button).Click += new EventHandler(PrintButtonClick);
            (FDisch.Controls["dataGrid1"] as DataGridView).Click += new EventHandler(Enab);
            (FDisch.Controls["TypeCB"] as ComboBox).SelectedIndexChanged += new EventHandler(Enab);

            FDisch.Show();
            (FDisch.Controls["dataGrid1"] as DataGridView).Columns["id_Discharge"].Visible = false;
            Enab(new Button(), new EventArgs());
        }
        //закрытие формы
        private void FormClosing(object sender, EventArgs e)
        {
            Application.OpenForms[0].Enabled = true;
        }
        //кнопка создать
        private void ApplyButtonClick(object sender, EventArgs e)
        {
            DateTime res = DateTime.Now;
            string dat = res.ToString("yyyy.MM.dd");

            DataRow[] DR_Type = DT.Select("[NameDischarge] = '" + (FDisch.Controls["TypeCB"] as ComboBox).Text + "'");
            SqlParameter[] SP = new SqlParameter[3]
            {
                new SqlParameter("@DateDischarge", dat),
                new SqlParameter("@ID_WriteAppointment", ID_Write),
                new SqlParameter("@id_TypeDischarge", DR_Type[0]["id_TypeDischarge"]),
            };
            DB.WriteData("Add_Discharge", SP);
            UpdGrid();
        }
        //кнопка удалить
        private void DelButtonClick(object sender, EventArgs e)
        {
            DataRow DR = ((DataRowView)(FDisch.Controls["dataGrid1"] as DataGridView).CurrentRow.DataBoundItem).Row; //перевод строки

            SqlParameter[] SP = new SqlParameter[]
            {
                new SqlParameter("@id_Discharge", DR["id_Discharge"]),
            };
            DB.LogDelData("logdel_Discharge", SP);
            UpdGrid();
        }
        //кнопка печать
        private void PrintButtonClick(object sender, EventArgs e)
        {
            DataRow DatRow = ((DataRowView)(FDisch.Controls["dataGrid1"] as DataGridView).CurrentRow.DataBoundItem).Row; //перевод строки
            if (DatRow["Тип выписки"].ToString() == "В учебное заведение")
            {
                SqlConnection sql = new SqlConnection(DataBaseConfiguration.connectString);
                SqlCommand cmd = new SqlCommand("USE [Life_of_Bionic]SELECT [Номер выписки],[Наименование выписки],[ФИО пациента],[Дата рождения],[Болезнь],[Срок лечения],[Статус лечения],[Дата поступления],[Дата выписки]FROM [dbo].[DischargeOnSchool] where [Номер выписки] = " + DatRow["id_Discharge"], sql);
                DataTable DT = new DataTable();
                sql.Open();
                SqlDataReader SDR = cmd.ExecuteReader();
                DT.Load(SDR);
                sql.Close();
                DataRow data = DT.Rows[0];

                string status = "";
                if (Convert.ToBoolean(data["Статус лечения"]))
                    status = "Вылечен";
                else
                    status = "На лечении";

                string dateB = Convert.ToDateTime(data["Дата рождения"]).ToShortDateString();
                
                string datePost = Convert.ToDateTime(data["Дата поступления"]).Date.ToShortDateString();

                string dateDescharge = Convert.ToDateTime(data["Дата выписки"]).Date.ToShortDateString();

                Thread t = new Thread(() => DocumentOutPut.PrintSchoolDischarge(data["ФИО пациента"].ToString(), data["Наименование выписки"].ToString(), dateB, data["Болезнь"].ToString(), datePost, Convert.ToInt32(data["Срок лечения"]), status, dateDescharge));
                t.Start();
            }   
            else
            if (DatRow["Тип выписки"].ToString() == "Рабочая выписка")
            {
                SqlConnection sql = new SqlConnection(DataBaseConfiguration.connectString);
                SqlCommand cmd = new SqlCommand("USE [Life_of_Bionic]SELECT [id_Discharge],[Наименование выписки],[ФИО пациента],[Серия,номер паспорта],[Дата рождения],[Название заболевания],[Дата поступления],[Срок лечения],[Статус лечения],[Дата выписки],[ФИО врача]FROM [dbo].[DischargeOnWork] where [id_Discharge] = " + DatRow["id_Discharge"], sql);
                DataTable DT = new DataTable();
                sql.Open();
                SqlDataReader SDR = cmd.ExecuteReader();
                DT.Load(SDR);
                sql.Close();
                DataRow data = DT.Rows[0];

                string status = "";
                if (Convert.ToBoolean(data["Статус лечения"]))
                    status = "Вылечен";
                else
                    status = "На лечении";

                string dateB = Convert.ToDateTime(data["Дата рождения"]).ToShortDateString();

                string datePost = Convert.ToDateTime(data["Дата поступления"]).Date.ToShortDateString();

                string dateDescharge = Convert.ToDateTime(data["Дата выписки"]).Date.ToShortDateString();

                Thread t = new Thread(() => DocumentOutPut.PrintWorkDischarge(data["ФИО пациента"].ToString(), Convert.ToInt32(data["id_Discharge"]), data["Наименование выписки"].ToString(), dateB, data["Серия,номер паспорта"].ToString(), data["Название заболевания"].ToString(), datePost, Convert.ToInt32(data["Срок лечения"]), status, data["ФИО врача"].ToString(), dateDescharge));
                t.Start();
            }
        }
        //обновление грида
        private void UpdGrid()
        {
            SqlParameter[] SP = new SqlParameter[1]
            {
                new SqlParameter("@ID_WriteAppointment", ID_Write),
            };
            DataTable DT = DB.GetData("Select_Discharge", SP);
            (FDisch.Controls["dataGrid1"] as DataGridView).DataSource = DT;
        }
        //вкл выкл кнопок
        private void Enab(object sender, EventArgs e)
        {
            (FDisch.Controls["NewButton"] as Button).Enabled = ((FDisch.Controls["TypeCB"] as ComboBox).SelectedIndex != -1);
            (FDisch.Controls["DelButton"] as Button).Enabled = ((FDisch.Controls["dataGrid1"] as DataGridView).CurrentRow != null);

            (FDisch.Controls["PrintButton"] as Button).Enabled = ((FDisch.Controls["dataGrid1"] as DataGridView).CurrentRow != null);
        }

        private void CreateTypeCB()
        {
            cb = new ComboBox()
            {
                Name = "TypeCB",
                Text = "",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locTypeCB,
                Size = sizeTypeCB,
                AutoCompleteMode = AutoCompleteMode.SuggestAppend,
                AutoCompleteSource = AutoCompleteSource.ListItems,
            };

            SqlParameter[] SP = new SqlParameter[0];
            DT = DB.GetData("Select_TypeDischarge_Name_NameDischarge", SP);
            DataRow RW;

            for (int i = 0; i < DT.Rows.Count; i++)
            {
                RW = DT.Rows[i];
                cb.Items.Add(RW["NameDischarge"]);
            }

            FDisch.Controls.Add(cb);
        }
        private void CreateNewButton()
        {
            but = new Button()
            {
                Name = "NewButton",
                Text = "Создать",
                Font = new Font("Microsoft Sans Serif", 10),
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locNewBut,
                Size = sizeNewBut,
            };
            FDisch.Controls.Add(but);
        }
        private void CreateDelButton()
        {
            but = new Button()
            {
                Name = "DelButton",
                Text = "Удалить",
                Font = new Font("Microsoft Sans Serif", 10),
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locDelBut,
                Size = sizeDelBut,
            };
            FDisch.Controls.Add(but);
        }
        private void CreatePrintButton()
        {
            but = new Button()
            {
                Name = "PrintButton",
                Text = "Печать",
                Font = new Font("Microsoft Sans Serif", 9),
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locPrintBut,
                Size = sizePrintBut,
                Enabled = false,
            };
            FDisch.Controls.Add(but);
        }
        private void CreateDataGrid(int ID_Write)
        {
            this.ID_Write = ID_Write;
            DataGridView a = new DataGridView()
            {
                Name = "dataGrid1",
                Visible = true,
                Enabled = true,
                Dock = DockStyle.Bottom,
                Height = sizeDG,
                BackgroundColor = Color.FromName("Control"),
                AllowUserToAddRows = false,
                AllowUserToOrderColumns = false,
                AllowUserToDeleteRows = false,
                AllowUserToResizeColumns = true,
                AllowUserToResizeRows = true,
                MultiSelect = false,
                ScrollBars = ScrollBars.Both,
                ReadOnly = true,
                BorderStyle = BorderStyle.FixedSingle,
                AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill,
            };

            SqlParameter[] SP = new SqlParameter[1]
            {
                new SqlParameter("@ID_WriteAppointment", ID_Write),
            };
            DataTable DT = DB.GetData("Select_Discharge", SP);
            a.DataSource = DT;

            FDisch.Controls.Add(a);
        }
    }
}

