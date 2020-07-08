using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.Sql;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Threading;
using System.Data.OleDb;
using System.Globalization;
using System.IO;

namespace WindowsFormsApp9
{
    public partial class MainForm : Form
    {
        public LinkLabel LastLabel = new LinkLabel();
        private string backText = "Поиск";

        public MainForm()
        {
            InitializeComponent();
        }

        //подключение
        private void linkLabel2_LinkClicked_1(object sender, LinkLabelLinkClickedEventArgs e)
        {
            ConnectionForm CF = new ConnectionForm();
            CF.NewConForm();
        }
        //вход
        private void AutorizLabelClick(object sender, LinkLabelLinkClickedEventArgs e)
        {
            AutorizForm af = new AutorizForm();
            af.NewAutorizForm();
        }
        //регистрация
        private void SignUpLabel_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            RegForm rf = new RegForm();
            rf.NewRegForm();
        }
        //личный кабинет
        private void LogOutLabel_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            ProfileForm.NewProfileForm();            
        }



        //запись на прием
        private void linkLabel1_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            DelControls();
            SearchPanel.Visible = true;
            LastLabel = (sender as LinkLabel);
            (sender as LinkLabel).Enabled = false;

            DataPanel.Visible = true;
            dataGridView1.Visible = true;
            DataGridPanel2.Visible = true;
            ButtonPrint.Text = "Печать талона";
            ButtonPrint.Width = 100;
            ButtonPrint.Visible = true;
            SearchPanel.Controls["ButtonPrint"].Click += new EventHandler(PrintButton);

            CreateButton(ControlPanel, "OpenForm", "Добавить запись", 70, 30, 220, 50, 12);
            ControlPanel.Controls["OpenForm"].Click += new EventHandler(NewWrite);
            CreateButton(ControlPanel, "CancelWrite", "Отменить запись", 70, 90, 220, 50, 12);
            ControlPanel.Controls["CancelWrite"].Click += new EventHandler(DelWrite);

            CreateButton(ControlPanel, "Visit", "Посетил", 70, 150, 90, 30, 10);
            ControlPanel.Controls["Visit"].Click += new EventHandler(VisitButton);
            (ControlPanel.Controls["Visit"] as Button).Enabled = false;
            CreateButton(ControlPanel, "Hospitalized", "Госпитализирован", 165, 150, 125, 30, 8);
            ControlPanel.Controls["Hospitalized"].Click += new EventHandler(HospitalizedButton);
            (ControlPanel.Controls["Hospitalized"] as Button).Enabled = false;

            SearchComboBox.Items.Add("Граждане");
            SearchComboBox.Items.Add("Записи по имени");
            SearchComboBox.SelectedIndex = 0;

            UpdDataGridsWrite(1);
            UpdDataGridsWrite(2);
            Form1_Activated(this, new EventArgs());
        }
        //новая запись
        private void NewWrite(object sender, EventArgs e)
        {
            WriteForm WF = new WriteForm();
            WF.NewWrite();
            UpdDataGridsWrite(1);
            UpdDataGridsWrite(2);
        }
        //отмена записи
        private void DelWrite(object sender, EventArgs e)
        {
            DataRow DR = ((DataRowView)dataGridView2.CurrentRow.DataBoundItem).Row; //перевод строки
            SqlParameter[] SP = new SqlParameter[]
            {
                new SqlParameter("@id_WriteAppointment", DR["id_WriteAppointment"]),
            };
            DB.LogDelData("[logdel_WriteAppointment]", SP);
            UpdDataGridsWrite(1);
            UpdDataGridsWrite(2);
        }
        //печать
        private void PrintButton(object sender, EventArgs e)
        {
            DataRow DatRow = ((DataRowView)dataGridView2.CurrentRow.DataBoundItem).Row; //перевод строки
            SqlConnection sql = new SqlConnection(DataBaseConfiguration.connectString);
            SqlCommand cmd = new SqlCommand("USE [Life_of_Bionic]SELECT [Номер талона],[ФИО пациента],[Снилс],[Адрес],[Сайт],[Номер телефона],[Почтовый ящик],[Было ли посещение],[Дата записи] FROM [dbo].[Talon] where [Номер талона] = " + DatRow["id_WriteAppointment"], sql);
            DataTable DT = new DataTable();
            sql.Open();
            SqlDataReader SDR = cmd.ExecuteReader();
            DT.Load(SDR);
            sql.Close();
            DataRow data = DT.Rows[0];
            string type = "";
            switch (Convert.ToInt32(DatRow["id_FormWrite"]))
            {
                case 1:
                    {
                        type = data["Номер телефона"].ToString();
                        break;
                    }
                case 2:
                    {
                        type = data["Сайт"].ToString();
                        break;
                    }
                case 3:
                    {
                        type = data["Почтовый ящик"].ToString();
                        break;
                    }
                case 4:
                    {
                        type = data["Адрес"].ToString();
                        break;
                    }
            }

            DocumentOutPut.PrintWriteAppointment(Convert.ToInt32(DatRow["id_WriteAppointment"]), data["ФИО пациента"].ToString(), type, data["Снилс"].ToString(), data["Дата записи"].ToString());
        }
        //кнопка посетил
        private void VisitButton(object sender, EventArgs e)
        {
            DataRow DR = ((DataRowView)dataGridView2.CurrentRow.DataBoundItem).Row;
            SqlParameter[] SP = new SqlParameter[]
            {
                new SqlParameter("@id_WriteAppointment", DR["id_WriteAppointment"]),
                new SqlParameter("@id_Day_of_the_week", DR["id_Day_of_the_week"]),
                new SqlParameter("@visit", true),
                new SqlParameter("@id_Citizen", DR["id_Citizen"]),
                new SqlParameter("@SentToTreatment", DR["Посетил"]),
                new SqlParameter("@times", DR["times"]),
                new SqlParameter("@id_FormWrite", DR["id_FormWrite"]),
            };
            DB.UpdData("UPD_WriteAppointment", SP);
            UpdDataGridsWrite(2);
        }
        //кнопка госпитализирован
        private void HospitalizedButton(object sender, EventArgs e)
        {
            if (dataGridView2.CurrentRow != null)
            {
                DataRow DR = ((DataRowView)dataGridView2.CurrentRow.DataBoundItem).Row; //перевод строки

                if ((Convert.ToBoolean(DR["Посетил"]) == true)&(Convert.ToBoolean(DR["Положили"]) == false))
                {
                    EditDelForm.ComboForm("Выберите диагноз для госпитализации.");

                    if (EditDelForm.LastBox != "")
                    {
                        DataRow[] DRD = EditDelForm.DTDiagnoz.Select("[Диагнозыыы] = '" + EditDelForm.LastBox + "'");

                        SqlParameter[] SSP = new SqlParameter[3]
                        {
                            new SqlParameter("@id_WriteAppointment", DR["id_WriteAppointment"]),
                            new SqlParameter("@id_Diagnoz", DRD[0]["id_Diagnoz"]),
                            new SqlParameter("@Name_SpecialityPersonal", AutorizForm.Spec),
                        };
                        DB.WriteData("Add_CardTreatments", SSP);

                        SqlParameter[] SP = new SqlParameter[]
                        {
                            new SqlParameter("@id_WriteAppointment", DR["id_WriteAppointment"]),
                            new SqlParameter("@id_Day_of_the_week", DR["id_Day_of_the_week"]),
                            new SqlParameter("@visit", true),
                            new SqlParameter("@id_Citizen", DR["id_Citizen"]),
                            new SqlParameter("@SentToTreatment", true),
                            new SqlParameter("@times", DR["times"]),
                            new SqlParameter("@id_FormWrite", DR["id_FormWrite"]),
                        };
                        if (DB.LastWrite)
                        DB.UpdData("UPD_WriteAppointment", SP);
                        if (DB.LastUpd)
                        UpdDataGridsWrite(2);
                    }                    
                }
            }            
        }
        //обновление DataGrid's
        private void UpdDataGridsWrite(int n)
        {
            switch (n)
            {
                case 1:
                    {
                        SqlParameter[] SP = new SqlParameter[0];
                        DataTable DT = DB.GetData("Select_DataCitizen", SP);

                        dataGridView1.DataSource = DT;
                        dataGridView1.Columns["id_Citizen"].Visible = false;

                        break;
                    }
                case 2:
                    {
                        SqlParameter[] SP = new SqlParameter[0];
                        DataTable DT = DB.GetData("Select_WriteAppointment", SP);

                        dataGridView2.DataSource = DT;
                        dataGridView2.Columns["id_Citizen"].Visible = false;
                        dataGridView2.Columns["id_worker"].Visible = false;
                        dataGridView2.Columns["id_WriteAppointment"].Visible = false;
                        dataGridView2.Columns["id_FormWrite"].Visible = false;
                        dataGridView2.Columns["id_Day_of_the_week"].Visible = false;
                        dataGridView2.Columns["times"].Visible = false;                       

                        break;
                    }
            }
        }

        //Карта лечения
        private void linkLabel2_LinkClicked_2(object sender, LinkLabelLinkClickedEventArgs e)
        {
            DelControls();
            SearchPanel.Visible = true;
            LastLabel = (sender as LinkLabel);
            (sender as LinkLabel).Enabled = false;

            DataPanel.Visible = true;
            dataGridView1.Visible = true;
            CreateButton(SearchPanel, "AddDiag", "Добавить диагноз", 335, 13, 110, 23, 8);
            (SearchPanel.Controls["AddDiag"] as Button).Click += new EventHandler(AddDiag);
            (SearchPanel.Controls["AddDiag"] as Button).Enabled = false;

            CreateButton(SearchPanel, "Discharge", "Выписки", 455, 13, 75, 23, 8);
            (SearchPanel.Controls["Discharge"] as Button).Click += new EventHandler(Discharge);
            (SearchPanel.Controls["Discharge"] as Button).Enabled = false;

            ControlTopPanel.Visible = true;
            CreateButton(ControlTopPanel, "NewDiag", "Новый диагноз", 40, 10, 150, 26, 10);
            (ControlTopPanel.Controls["NewDiag"] as Button).Click += new EventHandler(NewDiag);

            CreateButton(ControlTopPanel, "Cured", "Изменить", 200, 10, 140, 26, 7); 
             (ControlTopPanel.Controls["Cured"] as Button).Click += new EventHandler(Cured);
            (ControlTopPanel.Controls["Cured"] as Button).Enabled = false;

            DataGridPanel2.Height = (ControlPanel.Height - ControlTopPanel.Height) / 2;
            CreateDataGrid(ControlPanel, "dataGridView3");
            ((ControlPanel.Controls["DataGridPanel"] as Panel).Controls["dataGridView3"] as DataGridView).Click += new EventHandler(dataGridView3Click);

            SearchComboBox.Items.Clear();
            SearchComboBox.Items.Add("Пациенты");
            SearchComboBox.Items.Add("Список диагнозов");
            SearchComboBox.SelectedIndex = 0;

            Form1_Activated(this, new EventArgs());

            UpdGrids(1);
            UpdGrids(2);
            UpdGrids(3);
        }
        //добавить диагноз пациенту
        private void AddDiag(object sender, EventArgs e)
        {
            DataRow DRW = ((DataRowView)dataGridView1.CurrentRow.DataBoundItem).Row;
            DataRow DRD = ((DataRowView)dataGridView2.CurrentRow.DataBoundItem).Row;
            SqlParameter[] SP = new SqlParameter[3]
            {
                new SqlParameter("@id_WriteAppointment", DRW["id_WriteAppointment"]),
                new SqlParameter("@id_Diagnoz", DRD["id_Diagnoz"]),
                new SqlParameter("@Name_SpecialityPersonal", AutorizForm.Spec),                
            };
            DB.WriteData("Add_CardTreatments", SP);
            UpdGrids(1);
            UpdGrids(3);
        }
        private int LastClickGrid = 0;
        //кнопка вылечен
        private void Cured(object sender, EventArgs e)
        {
            switch (LastClickGrid)
            {
                case 1:
                    {
                        EditDelForm.NewMess("Изменить", "Удалить", 0);
                        DataRow DR = ((DataRowView)dataGridView1.CurrentRow.DataBoundItem).Row;
                        if (EditDelForm.LastResult == "Изменить")
                        {
                            string id = DR["id_WriteAppointment"].ToString();

                            SqlParameter[] SP = new SqlParameter[0];
                            DataTable DT = DB.GetData("[Select_WriteAppointment]", SP);
                            DataRow[] DRW = DT.Select("[id_Citizen] = '"+ id + "'");

                            WriteForm FW = new WriteForm();
                            string[] FIO = DR["ФИО"].ToString().Split(new char[] { ' ' }); //имя фамилия отчество
                            FW.id_cit = DR["id_Citizen"].ToString();
                            FW.NameSit = FIO[0];
                            FW.SurSit = FIO[1];
                            FW.PatSit = FIO[2];
                            FW.FormEnab = false;
                            FW.snils = DR["СНИЛС"].ToString();
                            FW.NewWrite();
                        }
                        if (EditDelForm.LastResult == "Удалить")
                        {
                            int id = Convert.ToInt32(DR["id_WriteAppointment"]);
                            DataTable DT = DB.Funk("Answer_ZeroAmount_CardTreatments({0})", new object[] { id });
                            DataRow DRF = DT.Rows[0];
                            bool Cured = Convert.ToBoolean(DRF[0]);
                            MessageBox.Show(Cured.ToString());

                            if (Cured)
                            {
                                DialogResult result = MessageBox.Show("У выбранного пациента есть пометки о не вылеченных диагнозах\nПациент полностью здоров?", "Здоров?", MessageBoxButtons.YesNo);
                                if (result == DialogResult.Yes)
                                {
                                    SqlParameter[] SP = new SqlParameter[]
                                    {
                                        new SqlParameter("@id_WriteAppointment", id)
                                    };
                                    DB.UpdData("Cured_All_CardTreatmens", SP);
                                    SP = new SqlParameter[]
                                    {
                                        new SqlParameter("@id_WriteAppointment", id),
                                    };
                                    DB.LogDelData("logdel_WriteAppointment", SP);
                                }
                            }
                        }

                        UpdGrids(1);
                        break;
                    }
                case 2:
                    {
                        EditDelForm.NewMess("Изменить", "Удалить", 0);
                        if (EditDelForm.LastResult == "Изменить")
                        {
                            DataRow DR = ((DataRowView)dataGridView2.CurrentRow.DataBoundItem).Row;
                            DiagForm DF = new DiagForm();
                            DF.id_Diag = DR["id_Diagnoz"].ToString();
                            DF.NameMeca = DR["Название лекарства"].ToString();
                            DF.NameDise = DR["Название болезни"].ToString();
                            DF.TimeHeal = DR["Период лечения (в днях)"].ToString();
                            DF.AmounMed = DR["Количество медикаментов"].ToString();
                            DF.NumbDeprot = "№" + DR["Номер палаты"].ToString();
                            DF.TypeDise = DR["Применение"].ToString();
                            DF.CaptionButton = "Изменить";
                            DF.NewDiagForm();
                        }
                        if (EditDelForm.LastResult == "Удалить")
                        {
                            DataRow DR = ((DataRowView)dataGridView2.CurrentRow.DataBoundItem).Row;
                            SqlParameter[] SP = new SqlParameter[]
                            {
                                new SqlParameter("@id_Diagnoz", DR["id_Diagnoz"]),
                            };
                            DB.LogDelData("logdel_Diagnosis", SP);
                        }
                        UpdGrids(2);
                        break;
                    }
                case 3:
                    {
                        if ((sender as Button).Text == "Вылечен/Удалить")
                        {
                            EditDelForm.NewMess("Вылечен", "Удалить диагноз",0);
                            if (EditDelForm.LastResult == "Вылечен")
                            {
                                DataRow DRW = ((DataRowView)dataGridView1.CurrentRow.DataBoundItem).Row;
                                DataRow DRD = ((DataRowView)((ControlPanel.Controls["DataGridPanel"] as Panel).Controls["dataGridView3"] as DataGridView).CurrentRow.DataBoundItem).Row;
                                SqlParameter[] SP = new SqlParameter[3]
                                {
                                    new SqlParameter("@id_WriteAppointment", DRW["id_WriteAppointment"]),
                                    new SqlParameter("@id_Diagnoz", DRD["id_Diagnoz"]),
                                    new SqlParameter("@Cured", true),
                                };

                                DB.UpdData("UPD_CardTreatments", SP);
                            }
                            if (EditDelForm.LastResult == "Удалить диагноз")
                            {
                                EditDelForm.NewKolVo("Сколько лекарство было израсходованно \nв процессе лечения этого диагноза?");
                                if (EditDelForm.LastResult == "ОК")
                                {
                                    DataRow DR = ((DataRowView)((ControlPanel.Controls["DataGridPanel"] as Panel).Controls["dataGridView3"] as DataGridView).CurrentRow.DataBoundItem).Row;
                                    SqlParameter[] SP = new SqlParameter[]
                                    {
                                    new SqlParameter("@id_card", DR["id_card"].ToString()),
                                    new SqlParameter("@Amount_Use", EditDelForm.kolVo.ToString()),
                                    };
                                    DB.LogDelData("logdel_CardTreatments", SP);
                                }
                            }
                        }
                        else
                        {
                            DialogResult result = MessageBox.Show("Вы уверены что хотите удалить выбранный диагноз?", "Подтвердите", MessageBoxButtons.YesNo);
                            if (result == DialogResult.Yes)
                            {
                                DataRow DR = ((DataRowView)((ControlPanel.Controls["DataGridPanel"] as Panel).Controls["dataGridView3"] as DataGridView).CurrentRow.DataBoundItem).Row;
                                SqlParameter[] SP = new SqlParameter[]
                                {
                                    new SqlParameter("@id_card", DR["id_card"].ToString()), 
                                    new SqlParameter("@Amount_Use", DR["Количество"].ToString()),
                                };
                                DB.LogDelData("logdel_CardTreatments", SP);
                            }
                        }
                        UpdGrids(3);
                        break;
                    }
            }
        }
        //создать новый диагноз
        private void NewDiag(object sender, EventArgs e)
        {
            DiagForm DF = new DiagForm();
            DF.NewDiagForm();
        }
        //Открыть форму с выписками
        private void Discharge(object sender, EventArgs e)
        {
            DischargeForm DF = new DischargeForm();
            DataRow DR;

            DR = ((DataRowView)dataGridView1.CurrentRow.DataBoundItem).Row; //перевод строки
            DF.NewDischForm((int)DR["id_WriteAppointment"]);
        }
        //обновление grid'ов
        public void UpdGrids(int n)
        {
            switch (n)
            {
                case 1:
                    {
                        SqlParameter[] SP = new SqlParameter[0];
                        DataTable DT = DB.GetData("Select_CardTreatments", SP);
                        dataGridView1.DataSource = DT;
                        dataGridView1.Columns["id_WriteAppointment"].Visible = false;
                        dataGridView1.Columns["id_Citizen"].Visible = false;

                        break;                       
                    }

                case 2:
                    {
                        SqlParameter[] SP = new SqlParameter[0];
                        DataTable DT = new DataTable();
                        DT = DB.GetData("Select_All_Diagnos", SP);
                        DataGridPanel2.Visible = true;
                        dataGridView2.ReadOnly = true;
                        dataGridView2.DataSource = DT;
                        dataGridView2.Columns["id_Diagnoz"].Visible = false;

                        break;
                    }

                case 3:
                    {
                        DataRow DR;
                        if (dataGridView1.CurrentRow != null)
                        {
                            DR = ((DataRowView)dataGridView1.CurrentRow.DataBoundItem).Row;

                            SqlParameter[] SP = new SqlParameter[]
                            {
                                new SqlParameter("@id_WriteAppointment", DR[0]),
                            };
                            DataTable DT = DB.GetData("CardTreatments_Diagnoz_Select", SP);

                            ((ControlPanel.Controls["DataGridPanel"] as Panel).Controls["dataGridView3"] as DataGridView).DataSource = DT;
                            ((ControlPanel.Controls["DataGridPanel"] as Panel).Controls["dataGridView3"] as DataGridView).Columns[0].Visible = false;
                            ((ControlPanel.Controls["DataGridPanel"] as Panel).Controls["dataGridView3"] as DataGridView).Columns[1].Visible = false;
                            ((ControlPanel.Controls["DataGridPanel"] as Panel).Controls["dataGridView3"] as DataGridView).Columns[2].Visible = false;
                        }

                        break;
                    }
            }
            Form1_Activated(this, new EventArgs());
            SearchTextBox_TextChanged(SearchTextBox, new EventArgs());
        }
        //клик по 3-му гриду
        private void dataGridView3Click(object sender, EventArgs e)
        {
            if ((sender as DataGridView).CurrentRow != null)
            {
                LastClickGrid = 3;
                (ControlTopPanel.Controls["Cured"] as Button).Text = "Вылечен/удалить";
                Form1_Activated(this, new EventArgs());
            }
        }


        //склад
        private void linkLabel3_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            DelControls();
            SearchPanel.Visible = true;
            LastLabel = (sender as LinkLabel);
            (sender as LinkLabel).Enabled = false;

            DataPanel.Visible = true;
            dataGridView1.Visible = true;
            DataGridPanel2.Height = 310;
            //CreateDataGrid(ControlPanel, "dataGridView3");
            DataGridPanel2.Visible = true;
            
            CreateButton(SearchPanel, "PrintButton", "Печать", 340, 13, 70, 23, 8);
            (SearchPanel.Controls["PrintButton"] as Button).Click += new EventHandler(Print);
            //CreateButton(SearchPanel, "NewDeliveryButton", "Новая поставка", 420, 13, 110, 23, 8);
            //(SearchPanel.Controls["NewDeliveryButton"] as Button).Click += new EventHandler(NewDeliveryButton);

            CreateButton(ControlPanel, "AddDeliButton", "Добавить постаку", 85, 30, 200, 30, 12);
            (ControlPanel.Controls["AddDeliButton"] as Button).Click += new EventHandler(NewDeliveryButton);
            CreateButton(ControlPanel, "EditDeliButton", "Изменить поставку", 85, 80, 200, 30, 10);
            (ControlPanel.Controls["EditDeliButton"] as Button).Click += new EventHandler(EditDeliveryButton);

            //ControlTopPanel.Visible = true;
            //CreateButton(ControlTopPanel, "NewMedicamentButton", "Создать лекарство", 40, 10, 170, 26, 10);
            //(ControlTopPanel.Controls["NewMedicamentButton"] as Button).Click += new EventHandler(NewMedicamentButton);
            //CreateButton(ControlTopPanel, "DelButton", "Удалить", 230, 10, 100, 26, 10);
            //(ControlTopPanel.Controls["DelButton"] as Button).Click += new EventHandler(DelButton);
            Form1_Activated(this, new EventArgs());

            SearchComboBox.Items.Add("Поставки");
            SearchComboBox.Items.Add("Медикаменты");
            SearchComboBox.SelectedIndex = 0;

            UpdGridsSup(1);
            UpdGridsSup(2);
        }
        //печать
        private void Print(object sender, EventArgs e)
        {
            EditDelForm.Caption = "Печать"; 
            EditDelForm.NewMess("Поставок", "Статус", 0);
            EditDelForm.Caption = "Изменение"; 
            if (EditDelForm.LastResult == "Поставок")
            {
                SqlConnection sql = new SqlConnection(DataBaseConfiguration.connectString);
                SqlCommand cmd = new SqlCommand("USE [Life_of_Bionic] SELECT [Производитель],[Наименование лекарства],[Категория лекарства],[Поступившее количество],[Дата поставки],[ФИО сотрудника],[Ячейка склада],[Места в ячейке],[Занятно места] FROM [dbo].[DocumentForDeliveryMEdicament]", sql);
                sql.Open();
                DataTable DT = new DataTable();
                SqlDataReader SDR = cmd.ExecuteReader();
                DT.Load(SDR);
                sql.Close();
                string[,] ss = new string[999,9];

                for (int i = 0; i < DT.Rows.Count; i++)
                {
                    DataRow DR = DT.Rows[i];
                    ss[i, 0] = DR["Производитель"].ToString();
                    ss[i, 1] = DR["Наименование лекарства"].ToString();
                    ss[i, 2] = DR["Категория лекарства"].ToString();
                    ss[i, 3] = DR["Поступившее количество"].ToString();
                    ss[i, 4] = Convert.ToDateTime(DR["Дата поставки"]).ToShortDateString();
                    ss[i, 5] = DR["ФИО сотрудника"].ToString();
                    ss[i, 6] = DR["Ячейка склада"].ToString();
                    ss[i, 7] = DR["Места в ячейке"].ToString();
                    ss[i, 8] = DR["Занятно места"].ToString();
                }
                Thread t = new Thread(() => DocumentOutPut.PrintDelivery(ss));
                t.Start();
            }
            else
            if (EditDelForm.LastResult == "Статус")
            {
                SqlConnection sql = new SqlConnection(DataBaseConfiguration.connectString);
                SqlCommand cmd = new SqlCommand("USE [Life_of_Bionic] SELECT [Номер ячейки склада],[Название медикамента],[Общее количество места],[Занято места]FROM [dbo].[StorageStatus]", sql);
                sql.Open();
                DataTable DT = new DataTable();
                SqlDataReader SDR = cmd.ExecuteReader();
                DT.Load(SDR);
                sql.Close();
                string[,] ss = new string[999, 4];

                for (int i = 0; i < DT.Rows.Count; i++)
                {
                    DataRow DR = DT.Rows[i];
                    ss[i, 0] = DR["Номер ячейки склада"].ToString();
                    ss[i, 1] = DR["Общее количество места"].ToString();
                    ss[i, 2] = DR["Занято места"].ToString();
                    ss[i, 3] = DR["Название медикамента"].ToString();
                }

                Thread t = new Thread(() => DocumentOutPut.PrintReportSup(ss));
                t.Start();                
            }
        }
        //Новая поставка
        private void NewDeliveryButton(object sender, EventArgs e)
        {
            DeliMediForm DF = new DeliMediForm();
            DF.NewDeliveryForm();
            UpdGridsSup(1);
            UpdGridsSup(2);
        }
        //Создать лекарство
        //private void NewMedicamentButton(object sender, EventArgs e)
        //{
        //    MedicamentsForm MF = new MedicamentsForm();
        //    MF.NewMedicamentsForm();
        //}

        //редактировать/удалить поставку    
        private void EditDeliveryButton(object sender, EventArgs e)
        {
            switch (LastClickGrid)
            {
                case 1://меняем медикамент
                    {
                        EditDelForm.NewMess("Изменить", "Удалить", 0);
                        if (EditDelForm.LastResult == "Изменить")
                        {
                            DataRow DR = ((DataRowView)dataGridView1.CurrentRow.DataBoundItem).Row;
                            DeliMediForm DMF = new DeliMediForm();
                            DMF.RedactMedi = true;
                            DMF.Medicament = DR["Название"].ToString();
                            DMF.Category = DR["Категория"].ToString();
                            DMF.manuf = DR["Производитель"].ToString();
                            DMF.id_Med = Convert.ToInt32(DR["id_Medicament"]);

                            DMF.NewDeliveryForm();
                        }
                        else
                        if (EditDelForm.LastResult == "Удалить")
                        {
                            if (EditDelForm.LastResult != "Cancel")
                            {
                                DataRow DR = ((DataRowView)dataGridView1.CurrentRow.DataBoundItem).Row;
                                SqlParameter[] SP = new SqlParameter[]
                                {
                                    new SqlParameter("@id_Medicament", DR["id_Medicament"]),
                                };
                                DB.LogDelData("[logdel_Medicament]", SP);
                            }
                        }
                        UpdGridsSup(1);
                        UpdGridsSup(2);
                        break;
                    }
                case 2://меняем поставку
                    {
                        EditDelForm.NewMess("Изменить", "Удалить", 0);
                        if (EditDelForm.LastResult == "Изменить")
                        {
                            DataRow DR = ((DataRowView)dataGridView2.CurrentRow.DataBoundItem).Row;                            

                            DeliMediForm DMF = new DeliMediForm();
                            DMF.RedactPost = true;
                            DMF.Medicament = DR["Лекарство"].ToString();
                            DMF.kol_vo = Convert.ToInt32(DR["Количество"]);
                            DMF.Date = Convert.ToDateTime(DR["Дата поставки"]);
                            DMF.id_Spot = Convert.ToInt32(DR["id_spot"]);

                            DMF.NewDeliveryForm();
                        }
                        if (EditDelForm.LastResult == "Удалить")
                        {
                            EditDelForm.NewKolVo("Введите кол-во использованного медикамента");
                            if (EditDelForm.LastResult != "Cancel")
                            {
                                DataRow DR = ((DataRowView)dataGridView2.CurrentRow.DataBoundItem).Row;
                                SqlParameter[] SP = new SqlParameter[]
                                {
                                    new SqlParameter("@id_DeliveryMedicament", DR["id_DeliveryMedicament"]),
                                    new SqlParameter("@id_Medicament", DR["id_Medicament"]),
                                    new SqlParameter("@Amount_Use", EditDelForm.kolVo),
                                };
                                DB.LogDelData("[logdel_DeliveryMedicament]", SP);
                            }
                        }
                        UpdGridsSup(1);
                        UpdGridsSup(2);
                        break;
                    }
            }
            
        }
        //обновление гридов
        private void UpdGridsSup(int n)
        {
            switch (n)
            {
                case 1:
                    {
                        SqlParameter[] SP = new SqlParameter[0];
                        DataTable DT = DB.GetData("Select_Medicament_FOR_Storage", SP);
                        dataGridView1.DataSource = DT;
                        try
                        {
                            dataGridView1.Columns["id_Medicament"].Visible = false;
                        }
                        catch { }
                        break;
                    }
                case 2:
                    {
                        SqlParameter[] SP = new SqlParameter[0];
                        DataTable DT = DB.GetData("Select_DeliveryMedicament", SP);
                        dataGridView2.DataSource = DT;
                        try
                        {
                            dataGridView2.Columns["id_DeliveryMedicament"].Visible = false;
                            dataGridView2.Columns["id_spot"].Visible = false;
                            dataGridView2.Columns["id_Medicament"].Visible = false;
                        }
                        catch { }
                        break;
                    }
            }
            
        }



        //терапевтическое отделение
        DataTable CatDis = new DataTable();
        private void linkLabel4_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            DelControls();
            SearchPanel.Visible = true;
            LastLabel = (sender as LinkLabel);
            (sender as LinkLabel).Enabled = false;

            DataPanel.Visible = true;
            dataGridView1.Visible = true;
            DataGridPanel2.Height = 270;
            DataGridPanel2.Visible = true;

            CreateButton(SearchPanel, "ButtonChange", "Изменить", 350, 13, 170, 23, 9);
            (SearchPanel.Controls["ButtonChange"] as Button).Click += ButtonChange;

            CreateLabel(ControlPanel, "CategoryLabel", "Категория болезней", 50, 20, 10);
            CreateComboBox(ControlPanel, "CategoryCB", 50, 43, 150, 20, 10);
            (ControlPanel.Controls["CategoryCB"] as ComboBox).TextChanged += Category_TextChanged;
            CreateButton(ControlPanel, "CategoryButton", "Изменить", 210, 42, 100, 26, 10);
            (ControlPanel.Controls["CategoryButton"] as Button).Click += CategoryButton;

            CreateLabel(ControlPanel, "AmountLabel", "Кол-во мест на отделение", 50, 73, 10);
            CreateTextBox(ControlPanel, "AmountTextBox", 50, 96, 150, 20, 3, 10);
            (ControlPanel.Controls["AmountTextBox"] as TextBox).KeyPress += AmountTextChange;

            CreateButton(ControlPanel, "NewOtdel", "Создать отделение", 80, 135, 215, 26, 10);
            (ControlPanel.Controls["NewOtdel"] as Button).Click += NewOtdel;
            
            UpdGrids_Deport(1);
            UpdGrids_Deport(2);
            UpdGrids_Deport(3);

            SearchComboBox.Items.Add("Отделение по номеру");
            SearchComboBox.Items.Add("Персонал");
            SearchComboBox.SelectedIndex = 0;

            Category_TextChanged((ControlPanel.Controls["CategoryCB"] as ComboBox), new EventArgs());
            Form1_Activated(this, new EventArgs());
        }
        //выбор категории
        private void Category_TextChanged(object sender, EventArgs e)
        {
            if ((sender as ComboBox).SelectedIndex != -1)
            {
                (ControlPanel.Controls["CategoryButton"] as Button).Text = "Изменить";
            }
            else
            {
                (ControlPanel.Controls["CategoryButton"] as Button).Text = "Создать";
            }
            Form1_Activated(this, new EventArgs());
        }
        //изменение категории болезней
        private void CategoryButton(object sender, EventArgs e)
        {
            if ((sender as Button).Text == "Изменить")
            {
                DataRow[] DRCat = CatDis.Select("[Name_CategoriesDisease] = '" + (ControlPanel.Controls["CategoryCB"] as ComboBox).Text + "'");

                EditDelForm.NewMess("Редактировать", "Удалить", 2);
                if (EditDelForm.LastResult == "Редактировать")
                {
                    SqlParameter[] SP = new SqlParameter[]
                    {
                        new SqlParameter("@id_CategoriesDisease", DRCat[0]["id_CategoriesDisease"]),
                        new SqlParameter("@Name_CategoriesDisease", EditDelForm.EditData),
                    };
                    DB.UpdData("[UPD_CategoriesDisease]", SP);
                    UpdGrids_Deport(3);
                }
                else
                if (EditDelForm.LastResult == "Удалить")
                {
                    SqlParameter[] SP = new SqlParameter[]
                    {
                        new SqlParameter("@id_CategoriesDisease", DRCat[0]["id_CategoriesDisease"])
                    };
                    DB.LogDelData("[logdel_CategoriesDisease]", SP);
                    UpdGrids_Deport(3);
                }
            }
            else
            if ((sender as Button).Text == "Создать")
            {
                SqlParameter[] SP = new SqlParameter[]
                {
                    new SqlParameter("@Name_CategoriesDisease", (ControlPanel.Controls["CategoryCB"] as ComboBox).Text),
                };
                DB.WriteData("[Add_CategoriesDisease]", SP);
                UpdGrids_Deport(3);
            }
        }
        //Запрет ввода букв в текстбокс кол-ва мест
        private void AmountTextChange(object sender, KeyPressEventArgs e)
        {
            e.Handled = true;
            switch (e.KeyChar)
            {
                case '1': e.Handled = false; break;
                case '2': e.Handled = false; break;
                case '3': e.Handled = false; break;
                case '4': e.Handled = false; break;
                case '5': e.Handled = false; break;
                case '6': e.Handled = false; break;
                case '7': e.Handled = false; break;
                case '8': e.Handled = false; break;
                case '9': e.Handled = false; break;
                case '0': e.Handled = false; break;
                case (char)8: e.Handled = false; break;
            }
        }
        //редактирование отделения 
        private void ButtonChange(object sender, EventArgs e)
        {
            DataRow DR = ((DataRowView)dataGridView1.CurrentRow.DataBoundItem).Row; //перевод строки

            if ((sender as Button).Text == "Изменить")
            {
                EditDelForm.NewMess("Редактировать", "Удалить", 0);
                if (EditDelForm.LastResult == "Редактировать")
                {
                    dataGridView1.Enabled = false;
                    (sender as Button).Text = "Отмена редактирования";
                    (ControlPanel.Controls["CategoryCB"] as ComboBox).Text = DR["Категория болезни"].ToString();
                    (ControlPanel.Controls["AmountTextBox"] as TextBox).Text = DR["Всего мест"].ToString();

                    (ControlPanel.Controls["NewOtdel"] as Button).Click -= NewOtdel;
                    (ControlPanel.Controls["NewOtdel"] as Button).Click += UpdOtdel;
                    (ControlPanel.Controls["NewOtdel"] as Button).Text = "Применить редактирование";
                }
                else
                if (EditDelForm.LastResult == "Удалить")
                {
                    SqlParameter[] SP = new SqlParameter[]
                    {
                    new SqlParameter("@id_Room", DR["Номер отделения"]),
                    };
                    DB.LogDelData("[logdel_TherapeuticDepartament]", SP);
                    UpdGrids_Deport(1);
                }
            }
            else
            if ((sender as Button).Text == "Отмена редактирования")
            {
                (sender as Button).Text = "Изменить";
                (ControlPanel.Controls["CategoryCB"] as ComboBox).Text = "";
                (ControlPanel.Controls["AmountTextBox"] as TextBox).Text = "";

                (ControlPanel.Controls["NewOtdel"] as Button).Click -= UpdOtdel;
                (ControlPanel.Controls["NewOtdel"] as Button).Click += NewOtdel;
                (ControlPanel.Controls["NewOtdel"] as Button).Text = "Создать отделение";
                dataGridView1.Enabled = true;
            }
        }
        //Создать отделение
        private void NewOtdel(object sender, EventArgs e)
        {
            DataRow[] DRCat = CatDis.Select("[Name_CategoriesDisease] = '" + (ControlPanel.Controls["CategoryCB"] as ComboBox).Text + "'");

            SqlParameter[] SP = new SqlParameter[]
            {
                new SqlParameter("@amountRooms", (ControlPanel.Controls["AmountTextBox"] as TextBox).Text),
                new SqlParameter("@id_worker", AutorizForm.id_Worker),
                new SqlParameter("@id_CategoriesDisease", DRCat[0]["id_CategoriesDisease"]),
            };
            DB.WriteData("[Add_TherapeuticDepartament]", SP);
            UpdGrids_Deport(1);
        }
        //Редактировать отделение
        private void UpdOtdel(object sender, EventArgs e)
        {
            DataRow[] DRCat = CatDis.Select("[Name_CategoriesDisease] = '" + (ControlPanel.Controls["CategoryCB"] as ComboBox).Text + "'");
            DataRow DR = ((DataRowView)dataGridView1.CurrentRow.DataBoundItem).Row; //перевод строки

            SqlParameter[] SP = new SqlParameter[]
            {
                new SqlParameter("@id_Room", DR["Номер отделения"]),
                new SqlParameter("@amountRooms", (ControlPanel.Controls["AmountTextBox"] as TextBox).Text),
                new SqlParameter("@id_worker", AutorizForm.id_Worker),
                new SqlParameter("@id_CategoriesDisease", DRCat[0]["id_CategoriesDisease"]),
            };
            DB.UpdData("[UPD_TherapeuticDepartament]", SP);
            
            if (DB.LastUpd)
            {
                (SearchPanel.Controls["ButtonChange"] as Button).Text = "Изменить";
                (ControlPanel.Controls["CategoryCB"] as ComboBox).Text = "";
                (ControlPanel.Controls["AmountTextBox"] as TextBox).Text = "";

                (ControlPanel.Controls["NewOtdel"] as Button).Click -= UpdOtdel;
                (ControlPanel.Controls["NewOtdel"] as Button).Click += NewOtdel;
                (ControlPanel.Controls["NewOtdel"] as Button).Text = "Создать отделение";
                dataGridView1.Enabled = true;
                UpdGrids_Deport(1);
            }            
        }
        //Обновление гридов
        private void UpdGrids_Deport(int n)
        {
            switch (n)
            {
                case 1:
                    {
                        SqlParameter[] SP = new SqlParameter[0];
                        DataTable DT = DB.GetData("Select_TherapeuticDepartament", SP);

                        dataGridView1.DataSource = DT;

                        break;
                    }
                case 2:
                    {
                        SqlParameter[] SP = new SqlParameter[0];
                        DataTable DT = DB.GetData("Select_Personal_Like_Category", SP);

                        dataGridView2.DataSource = DT;
                        dataGridView2.Columns["id_worker"].Visible = false; 

                        break;
                    }
                case 3:
                    {
                        SqlParameter[] SP = new SqlParameter[0];
                        CatDis = DB.GetData("Select_CategoriesDisease", SP);

                        (ControlPanel.Controls["CategoryCB"] as ComboBox).Items.Clear();
                        for (int i = 0; i < CatDis.Rows.Count; i++)
                            (ControlPanel.Controls["CategoryCB"] as ComboBox).Items.Add(CatDis.Rows[i][1]);

                        break;
                    }
            }
        }



        //Адмистративная панель
        DataTable Schedule = new DataTable();
        DataTable SpecTable = new DataTable();
        private void linkLabel5_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            DelControls();
            SearchPanel.Visible = true;
            LastLabel = (sender as LinkLabel);
            (sender as LinkLabel).Enabled = false;

            DataPanel.Visible = true;
            dataGridView1.Visible = true;
            
            CreateButton(SearchPanel, "RoleButton","Изменение роли", 360, 13, 150, 23, 8);
            (SearchPanel.Controls["RoleButton"] as Button).Enabled = false;
            (SearchPanel.Controls["RoleButton"] as Button).Click += RoleButton;


            ControlTopPanel.Visible = true;
            CreateLabel(ControlTopPanel, "ScheduleLabel", "График персонала", 40, 4, 8);
            CreateComboBox(ControlTopPanel,"ScheduleCB", 40, 18, 100, 20, 10);
            (ControlTopPanel.Controls["ScheduleCB"] as ComboBox).TextChanged += ScheduleTextChanged;
            CreateButton(ControlTopPanel, "ScheduleButton", "Изменить", 155, 16, 75, 25, 8);
            (ControlTopPanel.Controls["ScheduleButton"] as Button).Enabled = false;
            (ControlTopPanel.Controls["ScheduleButton"] as Button).Click += new EventHandler(ScheduleButton);
            CreateButton(ControlTopPanel, "SetScheduleButton", "Назначить", 235, 16, 75, 25, 8);
            (ControlTopPanel.Controls["SetScheduleButton"] as Button).Enabled = false;
            (ControlTopPanel.Controls["SetScheduleButton"] as Button).Click += SetShedulePersonal;


            DataGridPanel2.Height = 240;
            DataGridPanel2.Visible = true;

            
            CreateCheckBox(ControlPanel, "WriteCheckBox", "Запись", 20, 60, false, 10);
            CreateCheckBox(ControlPanel, "RegRecordCheck", "Оформление карт", 200, 60, false, 10);            
            CreateCheckBox(ControlPanel, "IntakeMedicCheckBox", "Приём медикаментов", 20, 90, false, 9);
            //CreateCheckBox(ControlPanel, "StatementMedicCheckBox", "Выписка медикаментов", 200, 90, 150, 20, false, 8);            
            CreateCheckBox(ControlPanel, "PermissionStatementCheckBox", "Разрешение на выписку", 200, 90, false, 8);
            CreateCheckBox(ControlPanel, "AdmissionCheckBox", "Приём пациентов", 20, 120, false, 10);

            CreateLabel(ControlPanel, "SpecLabel","Специальность", 20, 150, 10);
            CreateComboBox(ControlPanel, "SpecComboBox", 20, 173, 150, 20, 10);
            (ControlPanel.Controls["SpecComboBox"] as ComboBox).TextChanged += SpecTextChanged;
            CreateButton(ControlPanel, "SpecBut", "Изменить", 175, 172, 80, 26, 8);
            (ControlPanel.Controls["SpecBut"] as Button).Enabled = false;
            (ControlPanel.Controls["SpecBut"] as Button).Click += new EventHandler(SpecButton);

            CreateButton(ControlPanel, "CreateRoleButton", "Создать роль", 200, 121, 150, 20, 8);
            (ControlPanel.Controls["CreateRoleButton"] as Button).Enabled = false;
            (ControlPanel.Controls["CreateRoleButton"] as Button).Click += CreateRoleButton;

            CreateButton(ControlPanel, "SetRoleButton", "Назначить роль", 200, 145, 150, 20, 8);
            (ControlPanel.Controls["SetRoleButton"] as Button).Enabled = false;
            (ControlPanel.Controls["SetRoleButton"] as Button).Click += SetRolePersonal;

            CreateButton(ControlPanel, "LogsButton", "Логи", 260, 170, 95, 30, 8);
            (ControlPanel.Controls["LogsButton"] as Button).Click += LogsClick;

            

            SearchComboBox.Items.Add("Сотрудники");
            SearchComboBox.Items.Add("Роли");
            SearchComboBox.SelectedIndex = 0;

            UpdGrid_Admin(1);
            UpdGrid_Admin(2);
            UpdGrid_Admin(3);
            UpdGrid_Admin(4);

            Form1_Activated(this, new EventArgs());
        }
        //вызов формы с логами
        private void LogsClick(object sender, EventArgs e)
        {
            Form LogsForm = new Form()
            {
                Text = "Изменения в базе",
                StartPosition = FormStartPosition.CenterScreen,
                Size = new Size(600, 400),
            };
            DataGridView a = new DataGridView()
            {
                Name = "DGVLogs",
                Visible = true,
                Enabled = true,
                Dock = DockStyle.Fill,
                BackgroundColor = Color.FromName("Control"),
                AllowUserToAddRows = false,
                AllowUserToOrderColumns = false,
                AllowUserToDeleteRows = false,
                AllowUserToResizeColumns = true,
                AllowUserToResizeRows = true,
                MultiSelect = false,
                ScrollBars = ScrollBars.Both,
                ReadOnly = true,
                BorderStyle = BorderStyle.None,
                AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.DisplayedCells,
            };
            SqlParameter[] SP = new SqlParameter[0];
            DataTable DT = DB.GetData("LogChange_View", SP);
            if (DB.LastGet)
            {
                a.DataSource = DT;
                LogsForm.Controls.Add(a);
                LogsForm.ShowDialog();
            }            
        }
        //Изменение текста в ComboBox графика
        private void ScheduleTextChanged(object sender, EventArgs e)
        {
            if ((sender as ComboBox).SelectedIndex != -1)
            {
                (ControlTopPanel.Controls["ScheduleButton"] as Button).Text = "Изменить";
            }
            else
            {
                (ControlTopPanel.Controls["ScheduleButton"] as Button).Text = "Создать";
            }
            Form1_Activated(this, new EventArgs());
        }
        //кнопка Изменить график
        private void ScheduleButton(object sender, EventArgs e)
        {
            if ((sender as Button).Text == "Изменить")
            {
                DataRow[] DRSched = Schedule.Select("[График] = '" + (ControlTopPanel.Controls["ScheduleCB"] as ComboBox).Text + "'");

                EditDelForm.NewMess("Редактировать", "Удалить", 2);
                if (EditDelForm.LastResult == "Редактировать")
                {
                    SqlParameter[] SP = new SqlParameter[]
                    {
                        new SqlParameter("@id_WorkSchedule", DRSched[0]["id_WorkSchedule"]),
                        new SqlParameter("@weekdays", EditDelForm.EditData),
                    };
                    DB.UpdData("[UPD_WorkSchedule]", SP);
                    UpdGrid_Admin(3);
                }
                else
                if (EditDelForm.LastResult == "Удалить")
                {
                    SqlParameter[] SP = new SqlParameter[]
                    {
                        new SqlParameter("@id_WorkSchedule", DRSched[0]["id_WorkSchedule"])
                    };
                    DB.LogDelData("[logdel_WorkSchedule]", SP);
                    UpdGrid_Admin(3);
                }
            }
            else
            if ((sender as Button).Text == "Создать")
            {
                SqlParameter[] SP = new SqlParameter[]
                {
                    new SqlParameter("@weekdays", (ControlTopPanel.Controls["ScheduleCB"] as ComboBox).Text),
                };
                DB.WriteData("[Add_WorkSchedule]", SP);
                UpdGrid_Admin(3);
            }
        }
        //Изменение текста в ComboBox специальности
        private void SpecTextChanged(object sender, EventArgs e)
        {
            if ((sender as ComboBox).SelectedIndex != -1)
            {
                (ControlPanel.Controls["SpecBut"] as Button).Text = "Изменить";
            }
            else
            {
                (ControlPanel.Controls["SpecBut"] as Button).Text = "Создать";
            }
            Form1_Activated(this, new EventArgs());
        }
        //кнопка изменения специальности
        private void SpecButton(object sender, EventArgs e)
        {
            if ((sender as Button).Text == "Изменить")
            {
                DataRow[] DRSpec = SpecTable.Select("[Специализация] = '" + (ControlPanel.Controls["SpecComboBox"] as ComboBox).Text + "'");

                EditDelForm.NewMess("Редактировать", "Удалить", 2);
                if (EditDelForm.LastResult == "Редактировать")
                {
                    SqlParameter[] SP = new SqlParameter[]
                    {
                        new SqlParameter("@id_SpecialityPersonal", DRSpec[0]["id_SpecialityPersonal"]),
                        new SqlParameter("@Name_SpecialityPersonal", EditDelForm.EditData),
                    };
                    DB.UpdData("[UPD_SpecialityPersonal]", SP);
                    UpdGrid_Admin(4);
                }
                else
                if (EditDelForm.LastResult == "Удалить")
                {
                    SqlParameter[] SP = new SqlParameter[]
                    {
                        new SqlParameter("@id_SpecialityPersonal", DRSpec[0]["id_SpecialityPersonal"])
                    };
                    DB.LogDelData("[logdel_SpecialityPersonal]", SP);
                    UpdGrid_Admin(4);
                }
            }
            else
           if ((sender as Button).Text == "Создать")
            {
                SqlParameter[] SP = new SqlParameter[]
                {
                    new SqlParameter("@Name_SpecialityPersonal", (ControlPanel.Controls["SpecComboBox"] as ComboBox).Text),
                };
                DB.WriteData("[Add_SpecialityPersonal]", SP);
                UpdGrid_Admin(4);
            }
        }
        //кнопка изменение роли
        private void RoleButton(object sender, EventArgs e)
        {
            DataRow DR = ((DataRowView)dataGridView2.CurrentRow.DataBoundItem).Row; //перевод строки

            if ((sender as Button).Text == "Изменение роли")
            {
                EditDelForm.NewMess("Редактировать", "Удалить", 0);
                if (EditDelForm.LastResult == "Редактировать")
                {
                    dataGridView2.Enabled = false;
                    (sender as Button).Text = "Отмена редактирования";

                    (ControlPanel.Controls["WriteCheckBox"] as CheckBox).Checked = Convert.ToBoolean(DR["Запись"]);
                    (ControlPanel.Controls["RegRecordCheck"] as CheckBox).Checked = Convert.ToBoolean(DR["Оформление карт"]);
                    (ControlPanel.Controls["IntakeMedicCheckBox"] as CheckBox).Checked = Convert.ToBoolean(DR["Приём лекарств"]);
                    (ControlPanel.Controls["PermissionStatementCheckBox"] as CheckBox).Checked = Convert.ToBoolean(DR["Выписка пациентов"]);
                    (ControlPanel.Controls["AdmissionCheckBox"] as CheckBox).Checked = Convert.ToBoolean(DR["Приём пациентов"]);
                    (ControlPanel.Controls["SpecComboBox"] as ComboBox).Text = DR["Специализация"].ToString();

                    (ControlPanel.Controls["CreateRoleButton"] as Button).Click -= CreateRoleButton;
                    (ControlPanel.Controls["CreateRoleButton"] as Button).Click += UpdRoleButton;
                    (ControlPanel.Controls["CreateRoleButton"] as Button).Text = "Редактировать";
                }
                else
                if (EditDelForm.LastResult == "Удалить")
                {
                    SqlParameter[] SP = new SqlParameter[]
                    {
                    new SqlParameter("@id_Role", DR["Номер роли"]),
                    };
                    DB.LogDelData("[logdel_Role]", SP);
                    UpdGrid_Admin(2);
                }
            }
            else
            if ((sender as Button).Text == "Отмена редактирования")
            {
                (sender as Button).Text = "Изменение роли";

                (ControlPanel.Controls["WriteCheckBox"] as CheckBox).Checked = false;
                (ControlPanel.Controls["RegRecordCheck"] as CheckBox).Checked = false;
                (ControlPanel.Controls["IntakeMedicCheckBox"] as CheckBox).Checked = false;
                (ControlPanel.Controls["PermissionStatementCheckBox"] as CheckBox).Checked = false;
                (ControlPanel.Controls["AdmissionCheckBox"] as CheckBox).Checked = false;
                (ControlPanel.Controls["SpecComboBox"] as ComboBox).SelectedIndex = -1;

                (ControlPanel.Controls["CreateRoleButton"] as Button).Click -= UpdRoleButton;
                (ControlPanel.Controls["CreateRoleButton"] as Button).Click += CreateRoleButton;
                (ControlPanel.Controls["CreateRoleButton"] as Button).Text = "Добавление роли";
                dataGridView2.Enabled = true;
            }
        }
        //кнопка создания роли
        private void CreateRoleButton(object sender, EventArgs e)
        {
            DataRow[] DRSpec = SpecTable.Select("[Специализация] = '" + (ControlPanel.Controls["SpecComboBox"] as ComboBox).Text + "'");

            SqlParameter[] SP = new SqlParameter[]
            {
                new SqlParameter("@Write", (ControlPanel.Controls["WriteCheckBox"] as CheckBox).Checked),
                new SqlParameter("@CardDesign", (ControlPanel.Controls["RegRecordCheck"] as CheckBox).Checked),
                new SqlParameter("@AcceptanceMedication", (ControlPanel.Controls["IntakeMedicCheckBox"] as CheckBox).Checked),
                new SqlParameter("@ResolutionStatement", (ControlPanel.Controls["PermissionStatementCheckBox"] as CheckBox).Checked),
                new SqlParameter("@AdmissionPatient",  (ControlPanel.Controls["AdmissionCheckBox"] as CheckBox).Checked),
                new SqlParameter("@id_SpecialityPersonal",  DRSpec[0]["id_SpecialityPersonal"]),
            };
            DB.WriteData("[Add_Role]", SP);
            UpdGrid_Admin(2);
        }
        //кнопка редактирования роли
        private void UpdRoleButton(object sender, EventArgs e)
        {
            DataRow[] DRSpec = SpecTable.Select("[Специализация] = '" + (ControlPanel.Controls["SpecComboBox"] as ComboBox).Text + "'");
            DataRow DR = ((DataRowView)dataGridView2.CurrentRow.DataBoundItem).Row; //перевод строки

            SqlParameter[] SP = new SqlParameter[]
            {
                new SqlParameter("@id_Role", DR["Номер роли"]),
                new SqlParameter("@Write", (ControlPanel.Controls["WriteCheckBox"] as CheckBox).Checked),
                new SqlParameter("@CardDesign", (ControlPanel.Controls["RegRecordCheck"] as CheckBox).Checked),
                new SqlParameter("@AcceptanceMedication", (ControlPanel.Controls["IntakeMedicCheckBox"] as CheckBox).Checked),
                new SqlParameter("@ResolutionStatement", (ControlPanel.Controls["PermissionStatementCheckBox"] as CheckBox).Checked),
                new SqlParameter("@AdmissionPatient",  (ControlPanel.Controls["AdmissionCheckBox"] as CheckBox).Checked),
                new SqlParameter("@id_SpecialityPersonal",  DRSpec[0]["id_SpecialityPersonal"]),
            };
            DB.UpdData("[UPD_Role]", SP);

            if (DB.LastUpd)
            {
                (SearchPanel.Controls["RoleButton"] as Button).Text = "Изменение роли";

                (ControlPanel.Controls["WriteCheckBox"] as CheckBox).Checked = false;
                (ControlPanel.Controls["RegRecordCheck"] as CheckBox).Checked = false;
                (ControlPanel.Controls["IntakeMedicCheckBox"] as CheckBox).Checked = false;
                (ControlPanel.Controls["PermissionStatementCheckBox"] as CheckBox).Checked = false;
                (ControlPanel.Controls["AdmissionCheckBox"] as CheckBox).Checked = false;
                (ControlPanel.Controls["SpecComboBox"] as ComboBox).SelectedIndex = -1;

                (ControlPanel.Controls["CreateRoleButton"] as Button).Click -= UpdRoleButton;
                (ControlPanel.Controls["CreateRoleButton"] as Button).Click += CreateRoleButton;
                (ControlPanel.Controls["CreateRoleButton"] as Button).Text = "Добавление роли";
                dataGridView2.Enabled = true;

                UpdGrid_Admin(2);
            }            
        }
        //Кнопка назначения роли
        private void SetRolePersonal(object sender, EventArgs e)
        {
            DataRow DR1 = ((DataRowView)dataGridView1.CurrentRow.DataBoundItem).Row; //перевод строки
            DataRow DR2 = ((DataRowView)dataGridView2.CurrentRow.DataBoundItem).Row; //перевод строки
            DataRow[] DRSched = Schedule.Select("[График] = '" + DR1["Рабочий график"] + "'");

            string[] FIO = DR1["ФИО"].ToString().Split(new char[] { ' ' });
            string[] SerNumbPass = DR1["Серия и номер"].ToString().Split(new char[] { ' ', 'и' });

            SqlParameter S = new SqlParameter();
            if (DR1["Рабочий график"].ToString() == "Не назначен")
                S = new SqlParameter("@id_WorkSchedule", DBNull.Value);
            else
                S = new SqlParameter("@id_WorkSchedule", DRSched[0]["id_WorkSchedule"]);
            SqlParameter[] SP = new SqlParameter[]
            {
                new SqlParameter("@id_worker", DR1["id_worker"].ToString()),
                new SqlParameter("@NamePers", FIO[1]),
                new SqlParameter("@SurnamePers", FIO[0]),
                new SqlParameter("@PatronymicPers", FIO[2]),
                new SqlParameter("@SeriesPassportPers", SerNumbPass[0]),
                new SqlParameter("@NumberPassportPers",  SerNumbPass[1]),
                new SqlParameter("@User_Nick",  DR1["Логин"]),
                new SqlParameter("@ID_Role",  DR2["Номер роли"]),
                S,
            };
            DB.UpdData("[UPD_Personal_For_Admin]", SP);
            if (DB.LastUpd)
                UpdGrid_Admin(1);
        }
        //Кнопка назначения графику
        private void SetShedulePersonal(object sender, EventArgs e)
        {
            DataRow DR1 = ((DataRowView)dataGridView1.CurrentRow.DataBoundItem).Row; //перевод строки
            DataRow DR2 = ((DataRowView)dataGridView2.CurrentRow.DataBoundItem).Row; //перевод строки
            DataRow[] DRSched = Schedule.Select("[График] = '" + (ControlTopPanel.Controls["ScheduleCB"] as ComboBox).Text + "'");

            string[] FIO = DR1["ФИО"].ToString().Split(new char[] { ' ' });
            string[] SerNumbPass = DR1["Серия и номер"].ToString().Split(new char[] { ' ', 'и' });
            
            SqlParameter[] SP = new SqlParameter[]
            {
                new SqlParameter("@id_worker", DR1["id_worker"].ToString()),
                new SqlParameter("@NamePers", FIO[1]),
                new SqlParameter("@SurnamePers", FIO[0]),
                new SqlParameter("@PatronymicPers", FIO[2]),
                new SqlParameter("@SeriesPassportPers", SerNumbPass[0]),
                new SqlParameter("@NumberPassportPers",  SerNumbPass[1]),
                new SqlParameter("@User_Nick",  DR1["Логин"]),
                new SqlParameter("@ID_Role",  DR1["id_Role"]),
                new SqlParameter("@id_WorkSchedule", DRSched[0]["id_WorkSchedule"]),
            };
            DB.UpdData("[UPD_Personal_For_Admin]", SP);
            if (DB.LastUpd)
                UpdGrid_Admin(1);
        }
        //обновление Grid 
        private void UpdGrid_Admin(int n)
        {
            switch (n)
            {
                case 1:
                    {
                        SqlParameter[] SP = new SqlParameter[0];
                        DataTable DT = DB.GetData("Select_Personal", SP);
                        dataGridView1.DataSource = DT;

                        dataGridView1.Columns["id_Role"].Visible = false;
                        dataGridView1.Columns["id_Worker"].Visible = false;

                        break;
                    }
                case 2:
                    {
                        SqlParameter[] SP = new SqlParameter[0];
                        DataTable DT = DB.GetData("[Select_Role]", SP);
                        dataGridView2.DataSource = DT;

                        break;
                    }
                case 3:
                    {
                        SqlParameter[] SP = new SqlParameter[0];
                        Schedule = DB.GetData("[Select_WorkSchedule]", SP);

                        (ControlTopPanel.Controls["ScheduleCB"] as ComboBox).Items.Clear();
                        (ControlTopPanel.Controls["ScheduleCB"] as ComboBox).Text = "";
                        for (int i = 0; i < Schedule.Rows.Count; i++)
                        {
                            (ControlTopPanel.Controls["ScheduleCB"] as ComboBox).Items.Add(Schedule.Rows[i][1].ToString());
                        }

                        break;
                    }
                case 4:
                    {
                        SqlParameter[] SP = new SqlParameter[0];
                        SpecTable = DB.GetData("[Select_SpecialityPersonal]", SP);

                        (ControlPanel.Controls["SpecComboBox"] as ComboBox).Items.Clear();
                        (ControlPanel.Controls["SpecComboBox"] as ComboBox).Text = "";
                        for (int i = 0; i < SpecTable.Rows.Count; i++)
                        {
                            (ControlPanel.Controls["SpecComboBox"] as ComboBox).Items.Add(SpecTable.Rows[i][1].ToString());
                        }

                        break;
                    }
            }
        }
        


        //уничтожение созданных объектов
        public void DelControls()
        {
            SearchPanel.Visible = false;
            backText = "Поиск";
            SearchTextBox.Text = backText;
            SearchTextBox.ForeColor = Color.Gray;
            SearchComboBox.Items.Clear();
            SearchComboBox.Text = "";
            LastLabel = new LinkLabel();
            SearchComboBox.Items.Clear();
            dataGridView1.DataSource = "";
            dataGridView2.DataSource = "";
            DataGridPanel2.Height = 245;
            DataGridPanel2.Visible = false;
            linkLabel1.Enabled = true;
            linkLabel2.Enabled = true;
            linkLabel3.Enabled = true;
            linkLabel4.Enabled = true;
            linkLabel5.Enabled = true;
            DataPanel.Visible = false;
            dataGridView1.Visible = false;
            ControlTopPanel.Visible = false;
            ButtonPrint.Visible = false;
            SearchPanel.Visible = true;
            ControlPanel.Visible = true;
            try
            {
                (ControlPanel.Controls["OpenForm"] as Button).Dispose();
                (ControlPanel.Controls["CancelWrite"] as Button).Dispose();
                (ControlPanel.Controls["Visit"] as Button).Dispose();
                (ControlPanel.Controls["Hospitalized"] as Button).Dispose();
                ButtonPrint.Visible = false;
            }
            catch { }
            try
            {
                (SearchPanel.Controls["AddDiag"] as Button).Dispose();
                (ControlTopPanel.Controls["Cured"] as Button).Dispose();
                (ControlTopPanel.Controls["NewDiag"] as Button).Dispose();
                (SearchPanel.Controls["Discharge"] as Button).Dispose();
                ((ControlPanel.Controls["DataGridPanel"] as Panel).Controls["dataGridView3"] as DataGridView).Dispose();
                (ControlPanel.Controls["DataGridPanel"] as Panel).Dispose();
            }
            catch { }
            try
            {
                (ControlPanel.Controls["AddDeliButton"] as Button).Dispose();
                (ControlPanel.Controls["EditDeliButton"] as Button).Dispose();

                //((ControlPanel.Controls["DataGridPanel"] as Panel).Controls["dataGridView3"] as DataGridView).Dispose();
                //(ControlPanel.Controls["DataGridPanel"] as Panel).Dispose();
                //(SearchPanel.Controls["NewDeliveryButton"] as Button).Dispose();
                //(ControlTopPanel.Controls["NewMedicamentButton"] as Button).Dispose();
                //(ControlTopPanel.Controls["DelButton"] as Button).Dispose();
                (SearchPanel.Controls["PrintButton"] as Button).Dispose();
            }
            catch { }
            try
            {
                (SearchPanel.Controls["ButtonChange"] as Button).Dispose();
                (ControlPanel.Controls["CategoryLabel"] as Label).Dispose();
                (ControlPanel.Controls["CategoryCB"] as ComboBox).Dispose();
                (ControlPanel.Controls["CategoryButton"] as Button).Dispose();
                (ControlPanel.Controls["AmountLabel"] as Label).Dispose();
                (ControlPanel.Controls["AmountTextBox"] as TextBox).Dispose();
                (ControlPanel.Controls["NewOtdel"] as Button).Dispose();
            }
            catch { }
            try
            {
                (SearchPanel.Controls["RoleButton"] as Button).Dispose();
                (ControlTopPanel.Controls["ScheduleLabel"] as Label).Dispose();
                (ControlTopPanel.Controls["ScheduleCB"] as ComboBox).Dispose();
                (ControlTopPanel.Controls["ScheduleButton"] as Button).Dispose();
                (ControlTopPanel.Controls["SetScheduleButton"] as Button).Dispose();

                (ControlPanel.Controls["WriteCheckBox"] as CheckBox).Dispose();
                (ControlPanel.Controls["RegRecordCheck"] as CheckBox).Dispose();
                (ControlPanel.Controls["IntakeMedicCheckBox"] as CheckBox).Dispose();
                //(ControlPanel.Controls["StatementMedicCheckBox"] as CheckBox).Dispose();
                (ControlPanel.Controls["PermissionStatementCheckBox"] as CheckBox).Dispose();
                (ControlPanel.Controls["AdmissionCheckBox"] as CheckBox).Dispose();

                (ControlPanel.Controls["SpecLabel"] as Label).Dispose();
                (ControlPanel.Controls["SpecComboBox"] as ComboBox).Dispose();
                (ControlPanel.Controls["SpecBut"] as Button).Dispose();
                (ControlPanel.Controls["CreateRoleButton"] as Button).Dispose();
                (ControlPanel.Controls["SetRoleButton"] as Button).Dispose();
                (ControlPanel.Controls["LogsButton"] as Button).Dispose();
            }
            catch { }
        }


        public static void CreateButton(object control, string name, string text, int x, int y, int w, int h, int FontSize)
        {
            Button a = new Button()
            {
                Name = name,
                Visible = true,
                Enabled = true,
                Location = new Point(x, y),
                Size = new Size(w, h),
                Text = text,
                Font = new Font("Microsoft Sans Serif", FontSize),
            };
            (control as Panel).Controls.Add(a);
        }
        public static void CreateLabel(object control, string name, string text, int x, int y, int FontSize)
        {
            Label a = new Label()
            {
                Name = name,
                Visible = true,
                Enabled = true,
                Location = new Point(x, y),
                Text = text,
                Font = new Font("Microsoft Sans Serif", FontSize),
                AutoSize = true,
            };
            (control as Panel).Controls.Add(a);
        }
        public static void CreateComboBox(object control, string name, int x, int y, int w, int h, int FontSize)
        {
            ComboBox a = new ComboBox()
            {
                Name = name,
                Visible = true,
                Enabled = true,
                Location = new Point(x, y),
                Size = new Size(w, h),
                Font = new Font("Microsoft Sans Serif", FontSize),
            };
            (control as Panel).Controls.Add(a);
        }
        public static void CreateTextBox(object control, string name, int x, int y, int w, int h, int AmounChar, int FontSize)
        {
            TextBox a = new TextBox()
            {
                Name = name,
                Visible = true,
                Enabled = true,
                Location = new Point(x, y),
                Size = new Size(w, h),
                Font = new Font("Microsoft Sans Serif", FontSize),
                MaxLength = AmounChar,
            };
            (control as Panel).Controls.Add(a);
        }
        public static void CreateCheckBox(object control, string name, string text, int x, int y, bool check, int FontSize)
        {
            CheckBox a = new CheckBox()
            {
                Name = name,
                Text = text,
                Visible = true,
                Enabled = true,
                Location = new Point(x, y),
                Font = new Font("Microsoft Sans Serif", FontSize),
                Checked = check,
                AutoSize = true,
            };
            (control as Panel).Controls.Add(a);
        }
        private void CreateDataGrid(object control, string name)
        {
            Panel Pl = new Panel()
            {
                Name = "DataGridPanel",
                BorderStyle = BorderStyle.FixedSingle,
                Visible = true,
                Enabled = true,
                Dock = DockStyle.None,
                Location = new Point(0, ControlTopPanel.Height),
                Size = new Size(ControlPanel.Width, ControlPanel.Height - ControlTopPanel.Height - DataGridPanel2.Height),
            };

            DataGridView a = new DataGridView()
            {
                Name = name,
                Visible = true,
                Enabled = true,
                Dock = DockStyle.Fill,
                BackgroundColor = Color.FromName("Control"),
                AllowUserToAddRows = false,
                AllowUserToOrderColumns = false,
                AllowUserToDeleteRows = false,
                AllowUserToResizeColumns = true,
                AllowUserToResizeRows = true,
                MultiSelect = false,
                ScrollBars = ScrollBars.Both,
                ReadOnly = true,
                BorderStyle = BorderStyle.None,
                AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.DisplayedCells,
            };
            Pl.Controls.Add(a);
            (control as Panel).Controls.Add(Pl);
        }

        //надпись поиск на заднем фоне
        private void SearchTextBox_Enter(object sender, EventArgs e)
        {
            if ((sender as TextBox).ForeColor == Color.Gray)
            {
                (sender as TextBox).Text = "";
                (sender as TextBox).ForeColor = Color.FromName("WindowText");
            }
        }
        private void SearchTextBox_Leave(object sender, EventArgs e)
        {
            if (((sender as TextBox).ForeColor == Color.FromName("WindowText"))&((sender as TextBox).Text == ""))
            {
                (sender as TextBox).ForeColor = Color.Gray;
                (sender as TextBox).Text = backText;
            }
        }
        //Выход из поиска и запрет на ввод неправильных символов
        private void SearchTextBox_KeyPress(object sender, KeyPressEventArgs e)
        {
            switch (e.KeyChar)
            {
                case (char)13: break;
                case (char)27:
                    {
                        this.ActiveControl = SearchPanel;
                        SearchTextBox.ForeColor = Color.Gray;
                        SearchTextBox.Text = backText;
                        if (LastLabel == linkLabel1)
                        {
                            UpdDataGridsWrite(1);
                            UpdDataGridsWrite(2);
                        }
                        if (LastLabel == linkLabel2)
                        {
                            UpdGrids(1);
                            UpdGrids(2);
                            UpdGrids(3);
                        }
                        if (LastLabel == linkLabel3)
                        {
                            UpdGridsSup(1);
                            UpdGridsSup(2);
                        }
                        if (LastLabel == linkLabel4)
                        {
                            UpdGrids_Deport(1);
                            UpdGrids_Deport(2);
                        }
                        if (LastLabel == linkLabel5)
                        {
                            UpdGrid_Admin(1);
                            UpdGrid_Admin(2);
                        }
                        break;
                    }
            }

            //запрет на ввод цифр/букв
            switch (SearchComboBox.SelectedItem.ToString())
            {
                //запись на прием
                case "Граждане":
                    {
                        e.Handled = false;
                        switch (e.KeyChar)
                        {
                            case '1': e.Handled = true; break;
                            case '2': e.Handled = true; break;
                            case '3': e.Handled = true; break;
                            case '4': e.Handled = true; break;
                            case '5': e.Handled = true; break;
                            case '6': e.Handled = true; break;
                            case '7': e.Handled = true; break;
                            case '8': e.Handled = true; break;
                            case '9': e.Handled = true; break;
                            case '0': e.Handled = true; break;
                        }
                        break;
                    }
                case "Записи по имени":
                    {
                        e.Handled = false;
                        switch (e.KeyChar)
                        {
                            case '1': e.Handled = true; break;
                            case '2': e.Handled = true; break;
                            case '3': e.Handled = true; break;
                            case '4': e.Handled = true; break;
                            case '5': e.Handled = true; break;
                            case '6': e.Handled = true; break;
                            case '7': e.Handled = true; break;
                            case '8': e.Handled = true; break;
                            case '9': e.Handled = true; break;
                            case '0': e.Handled = true; break;
                        }
                        break;
                    }
                //карты лечения
                case "Пациенты":
                    {
                        e.Handled = true;
                        switch (e.KeyChar)
                        {
                            case '1': e.Handled = false; break;
                            case '2': e.Handled = false; break;
                            case '3': e.Handled = false; break;
                            case '4': e.Handled = false; break;
                            case '5': e.Handled = false; break;
                            case '6': e.Handled = false; break;
                            case '7': e.Handled = false; break;
                            case '8': e.Handled = false; break;
                            case '9': e.Handled = false; break;
                            case '0': e.Handled = false; break;
                        }
                        break;
                    }
                case "Список диагнозов":
                    {
                        e.Handled = false;
                        switch (e.KeyChar)
                        {
                            case '1': e.Handled = true; break;
                            case '2': e.Handled = true; break;
                            case '3': e.Handled = true; break;
                            case '4': e.Handled = true; break;
                            case '5': e.Handled = true; break;
                            case '6': e.Handled = true; break;
                            case '7': e.Handled = true; break;
                            case '8': e.Handled = true; break;
                            case '9': e.Handled = true; break;
                            case '0': e.Handled = true; break;
                        }
                        break;
                    }
                //склад
                case "Поставки":
                    {
                        e.Handled = true;
                        switch (e.KeyChar)
                        {
                            case '1': e.Handled = false; break;
                            case '2': e.Handled = false; break;
                            case '3': e.Handled = false; break;
                            case '4': e.Handled = false; break;
                            case '5': e.Handled = false; break;
                            case '6': e.Handled = false; break;
                            case '7': e.Handled = false; break;
                            case '8': e.Handled = false; break;
                            case '9': e.Handled = false; break;
                            case '0': e.Handled = false; break;
                        }
                        break;
                    }
                case "Медикаменты":
                    {
                        e.Handled = false;
                        switch (e.KeyChar)
                        {
                            case '1': e.Handled = true; break;
                            case '2': e.Handled = true; break;
                            case '3': e.Handled = true; break;
                            case '4': e.Handled = true; break;
                            case '5': e.Handled = true; break;
                            case '6': e.Handled = true; break;
                            case '7': e.Handled = true; break;
                            case '8': e.Handled = true; break;
                            case '9': e.Handled = true; break;
                            case '0': e.Handled = true; break;
                        }
                        break;
                    }
                //Терапевтическое отделение
                case "Отделение по номеру":
                    {
                        e.Handled = true;
                        switch (e.KeyChar)
                        {
                            case '1': e.Handled = false; break;
                            case '2': e.Handled = false; break;
                            case '3': e.Handled = false; break;
                            case '4': e.Handled = false; break;
                            case '5': e.Handled = false; break;
                            case '6': e.Handled = false; break;
                            case '7': e.Handled = false; break;
                            case '8': e.Handled = false; break;
                            case '9': e.Handled = false; break;
                            case '0': e.Handled = false; break;
                        }
                        break;
                    }
                case "Персонал":
                    {
                        e.Handled = false;
                        switch (e.KeyChar)
                        {
                            case '1': e.Handled = true; break;
                            case '2': e.Handled = true; break;
                            case '3': e.Handled = true; break;
                            case '4': e.Handled = true; break;
                            case '5': e.Handled = true; break;
                            case '6': e.Handled = true; break;
                            case '7': e.Handled = true; break;
                            case '8': e.Handled = true; break;
                            case '9': e.Handled = true; break;
                            case '0': e.Handled = true; break;
                        }
                        break;
                    }
                //административная панель
                case "Сотрудники":
                    {
                        e.Handled = false;
                        switch (e.KeyChar)
                        {
                            case '1': e.Handled = true; break;
                            case '2': e.Handled = true; break;
                            case '3': e.Handled = true; break;
                            case '4': e.Handled = true; break;
                            case '5': e.Handled = true; break;
                            case '6': e.Handled = true; break;
                            case '7': e.Handled = true; break;
                            case '8': e.Handled = true; break;
                            case '9': e.Handled = true; break;
                            case '0': e.Handled = true; break;
                        }
                        break;
                    }
                case "Роли":
                    {
                        e.Handled = false;
                        switch (e.KeyChar)
                        {
                            case '1': e.Handled = true; break;
                            case '2': e.Handled = true; break;
                            case '3': e.Handled = true; break;
                            case '4': e.Handled = true; break;
                            case '5': e.Handled = true; break;
                            case '6': e.Handled = true; break;
                            case '7': e.Handled = true; break;
                            case '8': e.Handled = true; break;
                            case '9': e.Handled = true; break;
                            case '0': e.Handled = true; break;
                        }
                        break;
                    }
            }            
        }
        //Поиск
        private void SearchTextBox_TextChanged(object sender, EventArgs e)
        {
            if (((sender as TextBox).Text != "") & ((sender as TextBox).Text != backText) & ((sender as TextBox).ForeColor != Color.Gray))
            {
                DataTable DT;

                switch (SearchComboBox.Text)
                {
                    //запись на прием
                    case "Граждане":
                        {
                            SqlParameter[] SP = new SqlParameter[]
                            {
                                new SqlParameter("@Name_DateCitizen", (sender as TextBox).Text),
                            };
                            DT = DB.GetData("[Search_DataCitizen]", SP);
                            dataGridView1.DataSource = DT;
                            dataGridView1.Columns["id_Citizen"].Visible = false;

                            break;
                        }
                    case "Записи по имени":
                        {
                            SqlParameter[] SP = new SqlParameter[]
                            {
                                new SqlParameter("@Name_DateCitizen", (sender as TextBox).Text),
                            };
                            DT = DB.GetData("[Search_WriteAppointment]", SP);
                            dataGridView2.DataSource = DT;
                            dataGridView2.Columns["id_Citizen"].Visible = false;
                            dataGridView2.Columns["id_worker"].Visible = false;
                            dataGridView2.Columns["id_WriteAppointment"].Visible = false;
                            dataGridView2.Columns["id_FormWrite"].Visible = false;

                            break;
                        }

                    //карты лечения
                    case "Пациенты":
                        {
                            SqlParameter[] SP = new SqlParameter[1]
                            {
                                    new SqlParameter("@Snils", (sender as TextBox).Text)
                            };
                            DT = DB.GetData("[Search_CardTreatments]", SP);
                            dataGridView1.DataSource = DT;
                            break;
                        }
                    case "Список диагнозов":
                        {
                            SqlParameter[] SP = new SqlParameter[1]
                            {
                                    new SqlParameter("@Name_Disease", (sender as TextBox).Text)
                            };
                            DT = DB.GetData("Select_Diagnos_For_Name_Disease", SP);
                            dataGridView2.DataSource = DT;
                            break;
                        }
                        //склад
                    case "Поставки":
                        {
                            SqlParameter[] SP = new SqlParameter[1]
                            {
                                    new SqlParameter("@Date_DeliveryMedicament", (sender as TextBox).Text)
                            };
                            DT = DB.GetData("[Search_DeliveryMedicamen]", SP);
                            dataGridView1.DataSource = DT;
                            break;
                        }
                    case "Медикаменты":
                        {
                            SqlParameter[] SP = new SqlParameter[1]
                            {
                                    new SqlParameter("@Name_Medicament", (sender as TextBox).Text)
                            };
                            DT = DB.GetData("Search_Medicament", SP);
                            dataGridView2.DataSource = DT;
                            break;
                        }
                    //Терапевтическое отделение
                    case "Отделение по номеру":
                        {
                            SqlParameter[] SP = new SqlParameter[1]
                               {
                                    new SqlParameter("@id_Room", (sender as TextBox).Text)
                               };
                            DT = DB.GetData("Search_TherapeuticDepartament", SP);
                            dataGridView1.DataSource = DT;
                            break;
                        }
                    case "Персонал":
                        {
                            SqlParameter[] SP = new SqlParameter[1]
                            {
                                new SqlParameter("@Name_Personal", (sender as TextBox).Text)
                            };
                            DT = DB.GetData("Search_Personal_Like_Category", SP);
                            dataGridView2.DataSource = DT;
                            break;
                        }
                    //административная панель
                    case "Сотрудники":
                        {
                            SqlParameter[] SP = new SqlParameter[1]
                            {
                                new SqlParameter("@Name_Personal", (sender as TextBox).Text)
                            };
                            DT = DB.GetData("Search__Personal_For_Admin", SP);
                            dataGridView1.DataSource = DT;
                            break;
                        }
                    case "Роли":
                        {
                            SqlParameter[] SP = new SqlParameter[1]
                            {
                                new SqlParameter("@Name_SpecialityPersonal", (sender as TextBox).Text)
                            };
                            DT = DB.GetData("Search_Role_SpecialityPesonal", SP);
                            dataGridView2.DataSource = DT;
                            break;
                        }
                }
            }
        }
        private void SearchComboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            //SearchTextBox.KeyPress 
            switch ((sender as ComboBox).SelectedItem.ToString())
            {
                //запись на прием
                case "Граждане":
                    {
                        backText = "Введите имя гражданина";
                        break;
                    }
                case "Записи по имени":
                    {
                        backText = "Введите имя записонного";
                        break;
                    }
                    //карты лечения
                case "Пациенты":
                    {
                        backText = "Введите СНИЛС";
                        break;
                    }
                case "Список диагнозов":
                    {
                        backText = "Введите название диагноза";
                        break;
                    }
                    //склад
                case "Поставки":
                    {
                        backText = "Введите дату поставки";
                        break;
                    }
                case "Медикаменты":
                    {
                        backText = "Введите название лекарства";
                        break;
                    }
                //Терапевтическое отделение
                case "Отделение по номеру":
                    {
                        backText = "Введите номер отделения";
                        break;
                    }
                case "Персонал":
                    {
                        backText = "Введите ФИО персонала";
                        break;
                    }
                //административная панель
                case "Сотрудники":
                    {
                        backText = "Введите фио сотрудника";
                        break;
                    }
                case "Роли":
                    {
                        backText = "Введите специальность";
                        break;
                    }
            }

            SearchTextBox.Text = backText;
        }
        //зашифровываем
        public static void Shifr()
        {
            string shifServ = Shifrovanie.Shifrovanie.Encrypt(DataBaseConfiguration.cds, "qwertyServ");
            string shifUser = Shifrovanie.Shifrovanie.Encrypt(DataBaseConfiguration.cui, "qwertyUser");
            string shifPass = Shifrovanie.Shifrovanie.Encrypt(DataBaseConfiguration.cpw, "qwertyPass");
            string shifBase = Shifrovanie.Shifrovanie.Encrypt(DataBaseConfiguration.baseName, "qwertyBase");
            DataBaseConfiguration.key = Shifrovanie.Shifrovanie.Encrypt(DataBaseConfiguration.key, "qwertyKey");
            string shifIden = Shifrovanie.Shifrovanie.Encrypt(DataBaseConfiguration.iden.ToString(), "qwertyIden");

            Regedit.Reestr.Write("LifeOfBionic", "cds", shifServ);
            Regedit.Reestr.Write("LifeOfBionic", "cui", shifUser);
            Regedit.Reestr.Write("LifeOfBionic", "cpw", shifPass);
            Regedit.Reestr.Write("LifeOfBionic", "base", shifBase);
            Regedit.Reestr.Write("LifeOfBionicKey", "Key", DataBaseConfiguration.key);
            Regedit.Reestr.Write("LifeOfBionicKey", "Iden", shifIden);
        }
        public static string shifLogin = "";
        //расшифровываем
        private void unShifr()
        {
            //ищем данные в реестре
            try
            {
                string shifServ = Regedit.Reestr.Read("LifeOfBionic", "cds");
                string shifUser = Regedit.Reestr.Read("LifeOfBionic", "cui");
                string shifPass = Regedit.Reestr.Read("LifeOfBionic", "cpw");
                string shifBase = Regedit.Reestr.Read("LifeOfBionic", "base");
                string shifIden = Regedit.Reestr.Read("LifeOfBionicKey", "Iden");
                string shiKey = Regedit.Reestr.Read("LifeOfBionicKey", "Key");

                shifUser = Shifrovanie.Shifrovanie.Decrypt(shifUser, "qwertyUser");
                shifPass = Shifrovanie.Shifrovanie.Decrypt(shifPass, "qwertyPass");
                shifBase = Shifrovanie.Shifrovanie.Decrypt(shifBase, "qwertyBase");
                shifIden = Shifrovanie.Shifrovanie.Decrypt(shifIden, "qwertyIden");
                shifServ = Shifrovanie.Shifrovanie.Decrypt(shifServ, "qwertyServ");
                shiKey = Shifrovanie.Shifrovanie.Decrypt(shiKey, "qwertyKey");

                if ((shifServ != "") & (shifUser != "") & (shifPass != "") & (shifBase != "") & (shifIden != ""))
                {
                    DataBaseConfiguration.cds = shifServ;
                    DataBaseConfiguration.cui = shifUser;
                    DataBaseConfiguration.cpw = shifPass;
                    DataBaseConfiguration.baseName = shifBase;
                    DataBaseConfiguration.connect = true;
                    DataBaseConfiguration.iden = Convert.ToInt32(shifIden);
                }
            }
            catch //если первый вход
            {
                MessageBox.Show("Похоже это ваш первый запуск этого приложения.\n" +
                    "Подключитесь к базе данных Sql server", "Добро пожаловать!", MessageBoxButtons.OK);

                DataBaseConfiguration.cds = "";
                DataBaseConfiguration.cui = "";
                DataBaseConfiguration.cpw = "";
                DataBaseConfiguration.baseName = "";
                DataBaseConfiguration.connect = false;        
                Random Rnd = new Random();
                int iden = Rnd.Next(0, 999999999);
                DataBaseConfiguration.iden = iden;

                ConnectionForm CF = new ConnectionForm();
                CF.NewConForm();
                return;
            }

            try
            {
                shifLogin = Regedit.Reestr.Read("LifeOfBionic", "login");
                shifLogin = Shifrovanie.Shifrovanie.Decrypt(shifLogin, "qwerty555");
            }
            catch { }

            ConnectionLabel.Enabled = false;
            ConnectionLabel.Visible = true;
            ConnectionLabel.Text = "Идет подключение к базе...";
            ConnectionLabel.Left = this.Width - ConnectionLabel.Width - 25;
            timer1.Enabled = true;
            Thread T = new Thread(DataBaseConfiguration.CheckCon);
            T.Start();
        }

        public void Form1_Activated(object sender, EventArgs e)
        {
            try
            {
                CaptionPanel.BackColor = ProfileForm.UColor;
                MenuPanel.BackColor = ProfileForm.UColor;
                ControlPanel.BackColor = ProfileForm.UColor;
                ControlTopPanel.BackColor = ProfileForm.UColor;
                SearchComboBox.BackColor = ProfileForm.UColor;
                StatusPanel.BackColor = ProfileForm.UColor;
                MainPanel.BackColor = ProfileForm.UColor;
            }
            catch { }

            ButtonPrint.Enabled = (dataGridView2.CurrentRow != null);

            if (LastLabel == linkLabel5)
            {
                (ControlTopPanel.Controls["SetScheduleButton"] as Button).Enabled = (dataGridView2.CurrentRow != null);
                (ControlPanel.Controls["CreateRoleButton"] as Button).Enabled = ((ControlPanel.Controls["SpecComboBox"] as ComboBox).SelectedIndex != -1);
                (SearchPanel.Controls["RoleButton"] as Button).Enabled = ((dataGridView2.CurrentRow != null));
                (ControlTopPanel.Controls["ScheduleButton"] as Button).Enabled = ((ControlTopPanel.Controls["ScheduleCB"] as ComboBox).Text != "");
                (ControlTopPanel.Controls["SetScheduleButton"] as Button).Enabled = ((ControlTopPanel.Controls["ScheduleCB"] as ComboBox).SelectedIndex != -1);
                (ControlPanel.Controls["SpecBut"] as Button).Enabled = ((ControlPanel.Controls["SpecComboBox"] as ComboBox).Text != "");
                (ControlPanel.Controls["SetRoleButton"] as Button).Enabled = ((dataGridView1.CurrentRow != null) & (dataGridView2.CurrentRow != null));
            }

            //если БД подключенно
            bool Enab;
            if (DataBaseConfiguration.connect)
            {
                try
                {
                    (MainPanel.Controls["PB"] as PictureBox).Visible = false;
                }
                catch { }

                Enab = true;
                ConnectionLabel.Visible = false;
                ConnectionLabel.Text = "Переподключить БД";
            }
            else
            {
                try
                {
                    (MainPanel.Controls["PB"] as PictureBox).Visible = true;
                }
                catch { }

                DataPanel.Visible = false;
                ControlPanel.Visible = false;
                SearchPanel.Visible = false;
                Enab = false;
                ConnectionLabel.Visible = false;
                ConnectionLabel.Text = "Подключить БД";
                DB.LogIn = false;
                AutorizForm.Nick = "";
            }
            ConnectionLabel.Location = new Point(this.Width - ConnectionLabel.Width - 25, 46);
            linkLabel1.Enabled = Enab;
            linkLabel2.Enabled = Enab;
            linkLabel3.Enabled = Enab;
            linkLabel4.Enabled = Enab;
            linkLabel5.Enabled = Enab;
            LogInLabel.Enabled = Enab;
            SignUpLabel.Enabled = Enab;
            

            //если вход выполнен
            if (DB.LogIn)
            {
                linkLabel1.Enabled = true;
                linkLabel2.Enabled = true;
                linkLabel3.Enabled = true;
                linkLabel4.Enabled = true;
                linkLabel5.Enabled = true;
                LastLabel.Enabled = false;
                
                ControlPanel.Visible = true;

                LogInLabel.Visible = false;
                SignUpLabel.Visible = false;
                LogOutLabel.Visible = true;
                LogOutLabel.Text = AutorizForm.Nick;
                LogOutLabel.Location = new Point(this.Width - LogOutLabel.Width - 30, 23);

                (MainPanel.Controls["PB"] as PictureBox).Visible = false;
            }
            else
            {
                linkLabel1.Enabled = false;
                linkLabel2.Enabled = false;
                linkLabel3.Enabled = false;
                linkLabel4.Enabled = false;
                linkLabel5.Enabled = false;
                
                ControlPanel.Visible = false;

                LogInLabel.Visible = true;
                SignUpLabel.Visible = true;
                LogOutLabel.Visible = false;
            }

            //если есть права на запись на прием
            if (AutorizForm.role[0])
            {
                //если выбран пункт меню "Запись на прием"
                if (LastLabel == linkLabel1)
                {
                    (ControlPanel.Controls["OpenForm"] as Button).Enabled = true;
                    (ControlPanel.Controls["CancelWrite"] as Button).Enabled = (dataGridView2.CurrentRow != null);
                }
            }
            else
            {
                //если выбран пункт меню "Запись на прием"
                if (LastLabel == linkLabel1)
                {
                    (ControlPanel.Controls["OpenForm"] as Button).Enabled = false;
                    (ControlPanel.Controls["CancelWrite"] as Button).Enabled = false;
                }
            }

            //если есть права на оформление карт
            if (AutorizForm.role[1])
            {
                //если выбран пункт меню "Карты лечения"
                if (LastLabel == linkLabel2)
                {
                    if ((dataGridView1.CurrentRow != null) &(dataGridView2.CurrentRow != null))
                    (SearchPanel.Controls["AddDiag"] as Button).Enabled = true;
                    else
                        (SearchPanel.Controls["AddDiag"] as Button).Enabled = false;

                    DataGridView DGV3 = ((ControlPanel.Controls["DataGridPanel"] as Panel).Controls["dataGridView3"] as DataGridView);
                    if ((DGV3.CurrentRow != null)|(dataGridView1.CurrentRow != null)|(dataGridView2.CurrentRow != null))
                    {
                        if ((LastClickGrid == 3) & (DGV3.CurrentRow != null))
                        {
                            (ControlTopPanel.Controls["Cured"] as Button).Enabled = true;
                            DataRow DR = ((DataRowView)DGV3.CurrentRow.DataBoundItem).Row;
                            if ((bool)DR["Состояние"] != true)
                                (ControlTopPanel.Controls["Cured"] as Button).Text = "Вылечен/Удалить";
                            else
                                (ControlTopPanel.Controls["Cured"] as Button).Text = "Удалить";
                        }
                        else
                            if ((LastClickGrid != 0) & (LastClickGrid != 3))
                            (ControlTopPanel.Controls["Cured"] as Button).Enabled = true;
                        else
                            (ControlTopPanel.Controls["Cured"] as Button).Enabled = false;
                    }
                    else
                        (ControlTopPanel.Controls["Cured"] as Button).Enabled = false;


                    (ControlTopPanel.Controls["NewDiag"] as Button).Enabled = true;
                }
            }
            else
            {
                //если выбран пункт меню "Карты лечения"
                if (LastLabel == linkLabel2)
                {
                    (SearchPanel.Controls["AddDiag"] as Button).Enabled = false;
                    (ControlTopPanel.Controls["Cured"] as Button).Enabled = false;
                    (ControlTopPanel.Controls["NewDiag"] as Button).Enabled = false;
                }
            }

            //Если есть права на прием медикаментов
            if (AutorizForm.role[2])
            {
                //если выбран пункт "Склад"
                if (LastLabel == linkLabel3)
                {
                    (ControlPanel.Controls["AddDeliButton"] as Button).Enabled = true;
                    (ControlPanel.Controls["EditDeliButton"] as Button).Enabled = ((dataGridView1.CurrentRow != null)|(dataGridView2.CurrentRow != null));
                }
            }
            else
            {
                //если выбран пункт "Склад"
                if (LastLabel == linkLabel3)
                {
                    (ControlPanel.Controls["AddDeliButton"] as Button).Enabled = false;
                    (ControlPanel.Controls["EditDeliButton"] as Button).Enabled = false;
                }
            }

            //если есть разрешение на выписки
            if (AutorizForm.role[3])
            {
                //если выбран пункт "Карты лечения"
                if (LastLabel == linkLabel2)
                {
                    (SearchPanel.Controls["Discharge"] as Button).Enabled = (dataGridView1.CurrentRow != null);
                }
            }
            else
            {
                //если выбран пункт "Карты лечения"
                if (LastLabel == linkLabel2)
                {
                    (SearchPanel.Controls["Discharge"] as Button).Enabled = false;
                }
            }

            //если есть разрешение на прием пациентов
            if (AutorizForm.role[4])
            {
                //если выбран пункт "Запись на приём"
                if (LastLabel == linkLabel1)
                {
                    (ControlPanel.Controls["Visit"] as Button).Enabled = (dataGridView2.CurrentRow != null);
                    (ControlPanel.Controls["Hospitalized"] as Button).Enabled = (dataGridView2.CurrentRow != null);
                }
            }
            else
            {
                //если выбран пункт "Запись на приём"
                if (LastLabel == linkLabel1)
                {
                    (ControlPanel.Controls["Visit"] as Button).Enabled = false;
                    (ControlPanel.Controls["Hospitalized"] as Button).Enabled = false;
                }
            }

            //если админ
            if (AutorizForm.Spec == "Админ")
            {
                linkLabel5.Visible = true;
            }
            else
            {
                linkLabel5.Visible = false;
            }

            //если Глав врач
            if (AutorizForm.Spec == "Главный врач")
            {
                //если выбран пункт "Терапевтическое отделение"
                if (LastLabel == linkLabel4)
                {
                    (ControlPanel.Controls["NewOtdel"] as Button).Enabled = ((ControlPanel.Controls["CategoryCB"] as ComboBox).SelectedIndex != -1);
                    (SearchPanel.Controls["ButtonChange"] as Button).Enabled = (dataGridView1.CurrentRow != null);
                    (ControlPanel.Controls["CategoryButton"] as Button).Enabled = ((ControlPanel.Controls["CategoryCB"] as ComboBox).Text != "");
                }
            }
            else
            {
                //если выбран пункт "Терапевтическое отделение"
                if (LastLabel == linkLabel4)
                {
                    (ControlPanel.Controls["NewOtdel"] as Button).Enabled = false;
                    (SearchPanel.Controls["ButtonChange"] as Button).Enabled = false;
                    (ControlPanel.Controls["CategoryButton"] as Button).Enabled = false;
                }
            }
        }

        private void dataGridView1_Click(object sender, EventArgs e)
        {
            LastClickGrid = 1;
            DataTable DT = new DataTable();
            DataRow DR;
            SqlParameter[] SP = new SqlParameter[0];            

            //карты лечения
            if (LastLabel == linkLabel2)
            {
                if (dataGridView1.CurrentRow != null)
                {
                    (ControlTopPanel.Controls["Cured"] as Button).Text = "Данные пациента";

                    DR = ((DataRowView)dataGridView1.CurrentRow.DataBoundItem).Row;

                    SP = new SqlParameter[]
                    {
                        new SqlParameter("@id_WriteAppointment", DR["id_WriteAppointment"]),
                    };
                    DT = DB.GetData("CardTreatments_Diagnoz_Select", SP);

                    ((ControlPanel.Controls["DataGridPanel"] as Panel).Controls["dataGridView3"] as DataGridView).DataSource = DT;
                    ((ControlPanel.Controls["DataGridPanel"] as Panel).Controls["dataGridView3"] as DataGridView).Columns["id_card"].Visible = false;
                    ((ControlPanel.Controls["DataGridPanel"] as Panel).Controls["dataGridView3"] as DataGridView).Columns["id_WriteAppointment"].Visible = false;
                    ((ControlPanel.Controls["DataGridPanel"] as Panel).Controls["dataGridView3"] as DataGridView).Columns["id_Diagnoz"].Visible = false;
                }
            }

            //Склад
            if (LastLabel == linkLabel3)
            {
                if (dataGridView1.CurrentRow != null)
                {
                    (ControlPanel.Controls["EditDeliButton"] as Button).Text = "Изменить лекарство";
                }
            }

            //Терапефтическое отделение
            if (LastLabel == linkLabel4)
            {

            }

            //Административная панель
            if (LastLabel == linkLabel5)
            {

            }

            Form1_Activated(this, new EventArgs());
        }
        private void dataGridView2_Click(object sender, EventArgs e)
        {
            LastClickGrid = 2;
            if ((dataGridView2.CurrentRow != null)&(LastLabel == linkLabel2))
            {
                (ControlTopPanel.Controls["Cured"] as Button).Text = "Редактировать диагноз";
            }
            if ((dataGridView2.CurrentRow != null) & (LastLabel == linkLabel3))
            {
                (ControlPanel.Controls["EditDeliButton"] as Button).Text = "Изменить поставку";
            }
            Form1_Activated(this, new EventArgs());
        }

        private void Form1_Shown(object sender, EventArgs e)
        {
            //Directory.GetFiles(Application.StartupPath, "itextsharp.dll", SearchOption.AllDirectories);

            StreamReader streamReader1;
            label1.Visible = true;
            label1.Text = "Поиск билбиотек";
            if (File.Exists("itextsharp.dll"))
            {
                streamReader1 = new StreamReader("itextsharp.dll");
            }
            else
            {
                MessageBox.Show("Файл itextsharp.xtra.dll не найден\nОбратитесь к абминистрации");
                Application.Exit();
            }
            
            if (File.Exists("itextsharp.pdfa.dll"))
            {
                streamReader1 = new StreamReader("itextsharp.pdfa.dll");
            }
            else
            {
                MessageBox.Show("Файл itextsharp.xtra.dll не найден\nОбратитесь к абминистрации");
                Application.Exit();
            }
            
            if (File.Exists("itextsharp.xtra.dll"))
            {
                streamReader1 = new StreamReader("itextsharp.xtra.dll");
            }
            else
            {
                MessageBox.Show("Файл itextsharp.xtra.dll не найден\nОбратитесь к абминистрации");
                Application.Exit();
            }
            
            if (File.Exists("Regedit.dll"))
            {
                streamReader1 = new StreamReader("Regedit.dll");
            }
            else
            {
                MessageBox.Show("Файл itextsharp.xtra.dll не найден\nОбратитесь к абминистрации");
                Application.Exit();
            }
            
            if (File.Exists("Shifrovanie.dll"))
            {
                streamReader1 = new StreamReader("Shifrovanie.dll");
            }
            else
            {
                MessageBox.Show("Файл itextsharp.xtra.dll не найден\nОбратитесь к абминистрации");
                Application.Exit();
            }
            label1.Visible = false;

            unShifr();

            PictureBox PB = new PictureBox()
            {
                Name = "PB",
                Dock = DockStyle.Fill,
                SizeMode = PictureBoxSizeMode.Zoom,
                Image = Properties.Resources.Doctors,

            };
            PB.SizeMode = PictureBoxSizeMode.Zoom;
            PB.Visible = true;
            DataPanel.Visible = false;
            MainPanel.Controls.Add(PB);
        }

        private int k = 0;
        public static int t = 60;
        private void timer1_Tick(object sender, EventArgs e)
        {
            ConnectionLabel.Text = "Идет подключение к базе";
            for (int i = 0; i < k; i++)
            {
                ConnectionLabel.Text += ".";
            }
            ConnectionLabel.Left = this.Width - ConnectionLabel.Width - 25;
            if (k != 3)
                k++;
            else
                k = 0;

            if (t <= 5)
            {
                t--;
                if (t == 0)
                { 
                    this.ConnectionLabel.Enabled = true;
                    this.Form1_Activated((Application.OpenForms[0] as MainForm), new EventArgs());
                    AutorizForm AF = new AutorizForm();
                    AF.NewAutorizForm();
                    timer1.Enabled = false;
                }
            }
        }

        private void MainForm_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Control && e.KeyCode == Keys.F12)
            {
                ConnectionForm CF = new ConnectionForm();
                CF.NewConForm();
                // Выполнить нужное действие, например, открыть форму
                e.SuppressKeyPress = true;
            }
        }
    }
}
