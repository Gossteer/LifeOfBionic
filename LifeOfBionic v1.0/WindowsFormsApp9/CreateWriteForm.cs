using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApp9
{
    class WriteForm
    {
        public bool FormEnab = true;
        public bool citEnab = true;
        public string id_cit = "";
        public string NameSit = "";
        public string SurSit = "";
        public string PatSit = "";
        public string snils = "";
        public string SeriesPass = "";
        public string NumbPass = "";

        public DateTime DateB = DateTime.Now;
        private DataTable DateRecord = new DataTable();
        private DataTable DataCit = new DataTable();
        private DataTable Type = new DataTable();

        private Form FNewWrite = new Form();
        private Label lab = new Label();
        private TextBox Tb = new TextBox();
        private MaskedTextBox mtb = new MaskedTextBox();
        private Button but = new Button();
        private ComboBox cb = new ComboBox();
        private DateTimePicker DTP = new DateTimePicker();

        private Font DefFont = new Font("Microsoft Sans Serif", 10);
        private Color DefBackColor = Color.FromName("Control");
        private Color DefTextColor = Color.FromName("ControlText");

        //Позиции                                          //позиции
        private Point locCitizenLabel = new Point(100, 10);//label граждана
        private Point locCitizenCB = new Point(100, 33);   //ComboBox граждана
        private Point locSurLabel = new Point(20, 63);     //label фамилии
        private Point locSurTB = new Point(20, 86);        //textBox фамилии
        private Point locNameLabel = new Point(190, 63);   //label имени
        private Point locNameTB = new Point(190, 86);      //textBox имени
        private Point locPatLabel = new Point(20, 119);     //label отчества
        private Point locPatTB = new Point(20, 149);        //textBox отчества
        private Point locDateBLabel = new Point(190, 119);  //label даты рождения
        private Point locDateBTB = new Point(190, 149);     //textBox даты рождения
        private Point locSNILSLabel = new Point(20, 179);  //label снилс
        private Point locSNILSTB = new Point(20, 202);     //textBox снилс
        private Point locSeriesLabel = new Point(190, 179);//label серии пасспорта
        private Point locSeriesTB = new Point(190, 202);   //textBox серии пасспорта
        private Point locNumberLabel = new Point(20, 232); //label номера пасспорта
        private Point locNumberTB = new Point(20, 255);    //textBox номера пасспорта

        private Point locAddBut = new Point(20, 300);      //кнопка добавить
        private Point locExtBut = new Point(200, 300);     //кнопка выход



        private Point locFormLabel = new Point(485, 20);   //label существующих форм
        private Point locFormCB = new Point(485, 43);      //comboBox существующих форм

        private Point locTypeLabel = new Point(400, 73);   //label типа записи
        private Point locTypeCB = new Point(400, 96);      //comboBox типа записи
        private Point locMailLabel = new Point(570, 126);   //label почты
        private Point locMailTB = new Point(570, 149);      //comboBox почты
        private Point locPNumberLabel = new Point(400, 126);//label Телефона
        private Point locPNumberTB = new Point(400, 149);   //comboBox Телефона
        private Point locSiteLabel = new Point(570, 179);   //label Сайта
        private Point locSiteTB = new Point(570, 202);      //comboBox Сайта
        private Point locAddressLabel = new Point(400, 179);//label Адреса
        private Point locAddressTB = new Point(400, 202);   //comboBox Адреса
        private Point locDateLabel = new Point(400, 232);   //label Время записи
        private Point locDateTB = new Point(400, 255);      //DateTimePicker Время записи
        private Point locDateCB = new Point(510, 255);      //comboBox Время записи

        private Point locFormBut = new Point(485, 250);     //кнопка добавить форму

        //размеры                                          //размеры
        private Size sizeCitizenCB = new Size(150, 20);    //comboBox существующих форм
        private Size sizeSurTB = new Size(150, 20);        //textBox фамилии
        private Size sizeNameTB = new Size(150, 20);       //textBox имени
        private Size sizePatTB = new Size(150, 20);        //textBox отчества
        private Size sizeDateBTB = new Size(150, 20);      //textBox даты рождения
        private Size sizeSNILSTB = new Size(150, 20);      //textBox снилс
        private Size sizeSeriesTB = new Size(150, 20);     //textBox серии паспорта
        private Size sizeNumberTB = new Size(150, 20);     //textBox номера пасспорта

        private Size sizeAddBut = new Size(150, 30);       //кнопка добавить
        private Size sizeExtBut = new Size(100, 30);       //кнопка выход


        
        private Size sizeFormCB = new Size(150, 20);       //comboBox существующих форм

        private Size sizeTypeCB = new Size(150, 20);       //comboBox типа записи
        private Size sizeMailTB = new Size(150, 20);       //textBox почты
        private Size sizePNumberTB = new Size(150, 20);    //textBox Телефона
        private Size sizeSiteTB = new Size(150, 20);       //textBox Сайта
        private Size sizeAddressTB = new Size(150, 20);    //textBox Адреса
        private Size sizeDateTB = new Size(100, 20);       //DateTimePicker времени записи
        private Size sizeDateCB = new Size(60, 20);        //ComboBox времени записи

        private Size sizeFormBut = new Size(150, 30);      //кнопка добавить форму



        
        public WriteForm()
        {

        }

        public void NewWrite()
        {
            CreateCitizenLabel();

            CreateSurLabel();
            CreateSurTB();
            CreateNameLabel();
            CreateNameTB();
            CreatePatLabel();
            CreatePatTB();
            CreateDateBLabel();
            CreateDateBTB();
            CreateSNILSLabel();
            CreateSNILSBTB();
            CreateSeriesLabel();
            CreateSeriesTB();
            CreateNumLabel();
            CreateNumTB();
            CreateAddButton();
            CreateExtButton();
            //CreateFormLabel();
            //CreateFormCB();
            CreateTypeLabel();

            CreateMailLabel();
            CreateMailTB();
            CreatePNumberLabel();
            CreatePNumberTB();
            CreateSiteLabel();
            CreateSiteTB();
            CreateAddressLabel();
            CreateAddressTB();
            CreateDateLabel();
            CreateDateTB();
            CreateDateCB();
            //CreateFormButton();

            CreateCitizenCB();
            CreateTypeCB();

            if (FormEnab)
            {
                FNewWrite.Text = "Добавление записи";
                FNewWrite.Controls["AddButton"].Text = "Добавить";
                FNewWrite.Controls["AddButton"].Click += AddButtonClick;
            }
            else
            {
                FNewWrite.Text = "Редактирование записи";
                FNewWrite.Controls["AddButton"].Text = "Редактировать";
                FNewWrite.Controls["AddButton"].Click += UpdButtonClick;
                FNewWrite.Controls["AddButton"].Enabled = true;
            }

            FNewWrite.Size = new Size(760, 400);
            FNewWrite.FormBorderStyle = FormBorderStyle.FixedSingle;
            FNewWrite.MaximizeBox = false;
            FNewWrite.StartPosition = FormStartPosition.CenterScreen;
            

            FNewWrite.ShowDialog();
        }

        private void TypeCB_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (FormEnab)
                switch ((sender as ComboBox).SelectedItem)
                {
                    case "По телефону":
                        {
                            (FNewWrite.Controls["PNumberTextBox"] as MaskedTextBox).Enabled = true;
                            (FNewWrite.Controls["AddressTextBox"] as TextBox).Enabled = false;
                            (FNewWrite.Controls["SiteTextBox"] as TextBox).Enabled = false;
                            (FNewWrite.Controls["MailTextBox"] as MaskedTextBox).Enabled = false;
                            break;
                        }
                    case "Через интернет":
                        {
                            (FNewWrite.Controls["SiteTextBox"] as TextBox).Enabled = true;
                            (FNewWrite.Controls["AddressTextBox"] as TextBox).Enabled = false;
                            (FNewWrite.Controls["PNumberTextBox"] as MaskedTextBox).Enabled = false;
                            (FNewWrite.Controls["MailTextBox"] as MaskedTextBox).Enabled = false;
                            break;
                        }
                    case "По почте":
                        {
                            (FNewWrite.Controls["MailTextBox"] as MaskedTextBox).Enabled = true;
                            (FNewWrite.Controls["AddressTextBox"] as TextBox).Enabled = false;
                            (FNewWrite.Controls["PNumberTextBox"] as MaskedTextBox).Enabled = false;
                            (FNewWrite.Controls["SiteTextBox"] as TextBox).Enabled = false;
                            break;
                        }
                    case "Через больницу":
                        {
                            (FNewWrite.Controls["AddressTextBox"] as TextBox).Enabled = true;
                            (FNewWrite.Controls["PNumberTextBox"] as MaskedTextBox).Enabled = false;
                            (FNewWrite.Controls["SiteTextBox"] as TextBox).Enabled = false;
                            (FNewWrite.Controls["MailTextBox"] as MaskedTextBox).Enabled = false;
                            break;
                        }
                }
        }

        private void Citizen_SelectedIndexChanged(object sender, EventArgs e)
        {
            if ((sender as ComboBox).SelectedItem != "Добавить нового")
            {
                if (FormEnab)
                {
                    (FNewWrite.Controls["NameTextBox"] as TextBox).Enabled = false;
                    (FNewWrite.Controls["SurTextBox"] as TextBox).Enabled = false;
                    (FNewWrite.Controls["PatTextBox"] as TextBox).Enabled = false;
                    (FNewWrite.Controls["SNILSTextBox"] as TextBox).Enabled = false;
                    (FNewWrite.Controls["SeriesTextBox"] as TextBox).Enabled = false;
                    (FNewWrite.Controls["NumberTextBox"] as TextBox).Enabled = false;
                    (FNewWrite.Controls["DateBPicker"] as DateTimePicker).Enabled = false;
                }                
                
                DataRow[] DRCit = DataCit.Select("[ФИО] = '" + (sender as ComboBox).Text + "'");

                SqlParameter[] SP = new SqlParameter[0];
                DataTable DT = DB.GetData("Select_DataCitizen", SP);
                int id = Convert.ToInt32(DRCit[0]["id_Citizen"]);

                DataRow[] DRAllCit = DT.Select("[id_Citizen] = '" + id.ToString() + "'");

                string[] FIOCit = DRAllCit[0]["ФИО"].ToString().Split(new char[] { ' ' });
                string[] Pass = DRAllCit[0]["Серия и номер"].ToString().Split(new char[] { ' ', 'и' });

                (FNewWrite.Controls["SurTextBox"] as TextBox).Text = FIOCit[0];
                (FNewWrite.Controls["NameTextBox"] as TextBox).Text = FIOCit[1];
                (FNewWrite.Controls["PatTextBox"] as TextBox).Text = FIOCit[2];
                (FNewWrite.Controls["SNILSTextBox"] as TextBox).Text = DRAllCit[0]["Снилс"].ToString();
                (FNewWrite.Controls["SeriesTextBox"] as TextBox).Text = Pass[0];
                (FNewWrite.Controls["NumberTextBox"] as TextBox).Text = Pass[1];
                CultureInfo provider = CultureInfo.InvariantCulture;
                (FNewWrite.Controls["DateBPicker"] as DateTimePicker).Value = DateTime.ParseExact(DRAllCit[0]["День рождения"].ToString().Substring(0, 10), "dd.MM.yyyy", provider);
            }
            else
            {
                (FNewWrite.Controls["NameTextBox"] as TextBox).Enabled = true;
                (FNewWrite.Controls["SurTextBox"] as TextBox).Enabled = true;
                (FNewWrite.Controls["PatTextBox"] as TextBox).Enabled = true;
                (FNewWrite.Controls["SNILSTextBox"] as TextBox).Enabled = true;
                (FNewWrite.Controls["SeriesTextBox"] as TextBox).Enabled = true;
                (FNewWrite.Controls["NumberTextBox"] as TextBox).Enabled = true;
                (FNewWrite.Controls["DateBPicker"] as DateTimePicker).Enabled = true;
            }
        }

        //конпка выхода
        private void ExitButtonClick(object sender, EventArgs e)
        {
            FNewWrite.Close();
        }
        //добавить запись
        private void AddButtonClick(object sender, EventArgs e)
        {
            //добавляем форму записи
            int id_FormWrite = 0;
            DataRow[] DRType = Type.Select("[Тип записи] = '" + (FNewWrite.Controls["FormCB"] as ComboBox).Text + "'");
            SqlParameter[] SP = new SqlParameter[]
            {
                new SqlParameter("@id_worker", AutorizForm.id_Worker),
                new SqlParameter("@id_TypeWrite ", DRType[0]["id_TypeWrite"]),
                new SqlParameter("@mail", (FNewWrite.Controls["MailTextBox"] as MaskedTextBox).Text),
                new SqlParameter("@PhoneNumber", (FNewWrite.Controls["PNumberTextBox"] as MaskedTextBox).Text),
                new SqlParameter("@Sites", (FNewWrite.Controls["SiteTextBox"] as TextBox).Text),
                new SqlParameter("@Adress", (FNewWrite.Controls["AddressTextBox"] as TextBox).Text),
            };

            switch (DRType[0]["Тип записи"])
            {
                case "По почте":
                    {
                        SP[3].Value = DBNull.Value;
                        SP[4].Value = DBNull.Value;
                        SP[5].Value = DBNull.Value;
                        break;
                    }
                case "По телефону":
                    {
                        SP[2].Value = DBNull.Value;
                        SP[4].Value = DBNull.Value;
                        SP[5].Value = DBNull.Value;
                        break;
                    }
                case "Через больницу":
                    {
                        SP[2].Value = DBNull.Value;
                        SP[3].Value = DBNull.Value;
                        SP[4].Value = DBNull.Value;
                        break;
                    }
                case "Через интернет":
                    {
                        SP[2].Value = DBNull.Value;
                        SP[3].Value = DBNull.Value;
                        SP[5].Value = DBNull.Value;
                        break;
                    }
            }

            id_FormWrite = DB.WriteData("[Add_FormWrite]", SP);

            //добавляем граждана
            int id_Citizen = 0;
            if (DB.LastWrite)
                if (((FNewWrite.Controls["CitizenCB"] as ComboBox).SelectedItem == "Добавить нового") | ((FNewWrite.Controls["CitizenCB"] as ComboBox).SelectedItem == ""))
                {
                    DateTime res = (FNewWrite.Controls["DateBPicker"] as DateTimePicker).Value;
                    SP = new SqlParameter[7]
                    {
                    new SqlParameter("@NameCit", (FNewWrite.Controls["NameTextBox"] as TextBox).Text),
                    new SqlParameter("@SurnameCit", (FNewWrite.Controls["SurTextBox"] as TextBox).Text),
                    new SqlParameter("@PatronymicCit", (FNewWrite.Controls["PatTextBox"] as TextBox).Text),
                    new SqlParameter("@Snils", (FNewWrite.Controls["SNILSTextBox"] as TextBox).Text),
                    new SqlParameter("@SeriesPassportCit", (FNewWrite.Controls["SeriesTextBox"] as TextBox).Text),
                    new SqlParameter("@NumberPassportCit", (FNewWrite.Controls["NumberTextBox"] as TextBox).Text),
                    new SqlParameter("@DateBirthCit", res),
                    };
                    id_Citizen = DB.WriteData("Add_DataCitizen", SP);
                    UpdBox(1, (FNewWrite.Controls["CitizenCB"] as ComboBox));
                    string ss = (FNewWrite.Controls["SurTextBox"] as TextBox).Text + " " + (FNewWrite.Controls["NameTextBox"] as TextBox).Text + " " + (FNewWrite.Controls["PatTextBox"] as TextBox).Text;
                    //MessageBox.Show(ss);
                    (FNewWrite.Controls["CitizenCB"] as ComboBox).SelectedItem = ss;
                }
                else
                {
                    DataRow[] DRCit = DataCit.Select("[ФИО] = '" + (FNewWrite.Controls["CitizenCB"] as ComboBox).Text + "'");
                    id_Citizen = Convert.ToInt32(DRCit[0]["id_Citizen"]);
                }

            //добавляем запись 
            DataRow[] DRDR = DateRecord.Select("[Record_Time] = '" + (FNewWrite.Controls["DateCB"] as ComboBox).Text + "'");
            SP = new SqlParameter[]
            {
                new SqlParameter("@times", (FNewWrite.Controls["DatePicker"] as DateTimePicker).Value.Date),
                new SqlParameter("@id_Day_of_the_week", DRDR[0]["id_Day_of_the_week"]),
                new SqlParameter("@id_Citizen", id_Citizen),
                new SqlParameter("@id_FormWrite", id_FormWrite),
            };
            if (DB.LastWrite)
                DB.WriteData("[Add_WriteAppointment]", SP);

            if (DB.LastWrite)
                FNewWrite.Close();
        }
        //Изменить запись
        private void UpdButtonClick(object sender, EventArgs e)
        {
            DateTime res = (FNewWrite.Controls["DateBPicker"] as DateTimePicker).Value;
            SqlParameter[] SP = new SqlParameter[]
            {
                new SqlParameter("@id_Citizen", id_cit),
                new SqlParameter("@NameCit", (FNewWrite.Controls["NameTextBox"] as TextBox).Text),
                new SqlParameter("@SurnameCit", (FNewWrite.Controls["SurTextBox"] as TextBox).Text),
                new SqlParameter("@PatronymicCit", (FNewWrite.Controls["PatTextBox"] as TextBox).Text),
                new SqlParameter("@Snils", (FNewWrite.Controls["SNILSTextBox"] as TextBox).Text),
                new SqlParameter("@SeriesPassportCit", (FNewWrite.Controls["SeriesTextBox"] as TextBox).Text),
                new SqlParameter("@NumberPassportCit", (FNewWrite.Controls["NumberTextBox"] as TextBox).Text),
                new SqlParameter("@DateBirthCit", res),
            };
            DB.UpdData("[UPD_DataCitizen]", SP);

            if (DB.LastUpd)
                FNewWrite.Close();
        }
        private void DatePickerValueChanged(object sender, EventArgs e)
        {
            UpdBox(2,FNewWrite.Controls["DateCB"] as ComboBox);
        }

        private void Form_TextChanged(object sender, EventArgs e)
        {
            try
            {
                (FNewWrite.Controls["AddButton"] as Button).Enabled = ((sender as TextBox).Text != "");
            }
            catch { }

            try
            {
                (FNewWrite.Controls["AddButton"] as Button).Enabled = ((sender as MaskedTextBox).Text != "");
            }
            catch { }
        }

        private void UpdBox(int n, ComboBox cb)
        {
            switch (n)
            {
                case 1:
                    {
                        SqlParameter[] SP = new SqlParameter[0];
                        DataCit = DB.GetData("Select_DataCitizen_ONLI_FIO", SP);
                        DataRow RW;

                        cb.Items.Clear();
                        cb.Text = "";
                        cb.Items.Add("Добавить нового");
                        for (int i = 0; i < DataCit.Rows.Count; i++)
                        {
                            RW = DataCit.Rows[i];
                            cb.Items.Add(RW["ФИО"]);
                        }
                        cb.SelectedIndex = 0;

                        break;
                    }
                case 2:
                    {
                        SqlParameter[] SP = new SqlParameter[]
                        {
                            new SqlParameter("@Date",  (FNewWrite.Controls["DatePicker"] as DateTimePicker).Value.Date),
                        };
                        DateRecord = DB.GetData("Select_Date_Appointment", SP);
                        DataRow RW;

                        for (int i = 0; i < DateRecord.Rows.Count; i++)
                        {
                            DateRecord.Rows[i]["Record_Time"] = DateRecord.Rows[i]["Record_Time"].ToString()/*.Substring(0, 5)*/;
                        }

                        cb.Items.Clear();
                        cb.Text = "";
                        for (int i = 0; i < DateRecord.Rows.Count; i++)
                        {
                            RW = DateRecord.Rows[i];
                            cb.Items.Add(RW["Record_Time"]);
                        }
                        try
                        {
                            cb.SelectedIndex = 0;
                        }
                        catch { }

                        break;
                    }
            }

        }


        private void CreateCitizenLabel()
        {
            lab = new Label()
            {
                Name = "CitizenLabel",
                Text = "Граждан: ",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locCitizenLabel,
                AutoSize = true,
                Enabled = citEnab,
            };
            FNewWrite.Controls.Add(lab);
        }
        private void CreateCitizenCB()
        {
            cb = new ComboBox()
            {
                Name = "CitizenCB",
                Text = "",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locCitizenCB,
                Size = sizeCitizenCB,
                AutoCompleteMode = AutoCompleteMode.SuggestAppend,
                AutoCompleteSource = AutoCompleteSource.ListItems,
                Enabled = FormEnab,
            };
            cb.SelectedIndexChanged += Citizen_SelectedIndexChanged;

            UpdBox(1, cb);

            if (NameSit != "")
            {
                DataRow[] DRSit = DataCit.Select("[ФИО] LIKE '%" + SurSit + " " +  NameSit + " " + PatSit + "%'");
                cb.SelectedItem = DRSit[0]["ФИО"].ToString();
            }

            FNewWrite.Controls.Add(cb);
        }
        private void CreateSurLabel()
        {
            lab = new Label()
            {
                Name = "SurLabel",
                Text = "Фамилия: ",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locSurLabel,
                AutoSize = true,
            };
            FNewWrite.Controls.Add(lab);
        }
        private void CreateSurTB()
        {
            Tb = new TextBox()
            {
                Name = "SurTextBox",
                Text = "",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locSurTB,
                Size = sizeSurTB,
                MaxLength = 50,
            };
            FNewWrite.Controls.Add(Tb);
        }
        private void CreateNameLabel()
        {
            lab = new Label()
            {
                Name = "NameLabel",
                Text = "Имя: ",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locNameLabel,
                AutoSize = true,
            };
            FNewWrite.Controls.Add(lab);
        }
        private void CreateNameTB()
        {
            Tb = new TextBox()
            {
                Name = "NameTextBox",
                Text = "",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locNameTB,
                Size = sizeNameTB,
                MaxLength = 50,
            };
            FNewWrite.Controls.Add(Tb);
        }
        private void CreatePatLabel()
        {
            lab = new Label()
            {
                Name = "PatLabel",
                Text = "Отчество: ",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locPatLabel,
                AutoSize = true,
            };
            FNewWrite.Controls.Add(lab);
        }
        private void CreatePatTB()
        {
            Tb = new TextBox()
            {
                Name = "PatTextBox",
                Text = "",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locPatTB,
                Size = sizePatTB,
                MaxLength = 50,
            };
            FNewWrite.Controls.Add(Tb);
        }
        private void CreateDateBLabel()
        {
            lab = new Label()
            {
                Name = "DateBLabel",
                Text = "Дата рождения: ",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locDateBLabel,
                AutoSize = true,
            };
            FNewWrite.Controls.Add(lab);
        }
        private void CreateDateBTB()
        {
            DTP = new DateTimePicker()
            {
                Name = "DateBPicker",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locDateBTB,
                Size = sizeDateBTB,
                Format = DateTimePickerFormat.Custom,
                CustomFormat = "dd.MM.yyyy",
                Value = new DateTime(2000, 1, 1),
            };
            FNewWrite.Controls.Add(DTP);
        }
        private void CreateSNILSLabel()
        {
            lab = new Label()
            {
                Name = "SNILSLabel",
                Text = "Снилс: ",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locSNILSLabel,
                AutoSize = true,
            };
            FNewWrite.Controls.Add(lab);
        }
        private void CreateSNILSBTB()
        {
            Tb = new TextBox()
            {
                Name = "SNILSTextBox",
                Text = "",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locSNILSTB,
                Size = sizeSNILSTB,
                MaxLength = 11,
            };
            FNewWrite.Controls.Add(Tb);
        }
        private void CreateSeriesLabel()
        {
            lab = new Label()
            {
                Name = "SeriesLabel",
                Text = "Серия пасспорта: ",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locSeriesLabel,
                AutoSize = true,
            };
            FNewWrite.Controls.Add(lab);
        }
        private void CreateSeriesTB()
        {
            Tb = new TextBox()
            {
                Name = "SeriesTextBox",
                Text = "",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locSeriesTB,
                Size = sizeSeriesTB,
                MaxLength = 4,
            };
            FNewWrite.Controls.Add(Tb);
        }
        private void CreateNumLabel()
        {
            lab = new Label()
            {
                Name = "NumberLabel",
                Text = "Номер пасспорта: ",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locNumberLabel,
                AutoSize = true,
            };
            FNewWrite.Controls.Add(lab);
        }
        private void CreateNumTB()
        {
            Tb = new TextBox()
            {
                Name = "NumberTextBox",
                Text = "",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locNumberTB,
                Size = sizeNumberTB,
                MaxLength = 6,
            };
            FNewWrite.Controls.Add(Tb);
        }

        private void CreateAddButton()
        {
            but = new Button()
            {
                Name = "AddButton",
                Text = "Добавить",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locAddBut,
                Size = sizeAddBut,
                Enabled = false,
            };
            FNewWrite.Controls.Add(but);
        }
        private void CreateExtButton()
        {
            but = new Button()
            {
                Name = "ExtButton",
                Text = "Выйти",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locExtBut,
                Size = sizeExtBut,
            };
            but.Click += ExitButtonClick;
            FNewWrite.Controls.Add(but);
        }



        //private void CreateFormLabel()
        //{
        //    lab = new Label()
        //    {
        //        Name = "FormLabel",
        //        Text = "Существующие формы: ",
        //        Font = DefFont,
        //        Visible = true,
        //        BackColor = DefBackColor,
        //        ForeColor = DefTextColor,
        //        Location = locFormLabel,
        //        AutoSize = true,
        //    };
        //    FNewWrite.Controls.Add(lab);
        //}
        //private void CreateFormCB()
        //{
        //    cb = new ComboBox()
        //    {
        //        Name = "FormCB",
        //        Text = "",
        //        Font = DefFont,
        //        Visible = true,
        //        BackColor = DefBackColor,
        //        ForeColor = DefTextColor,
        //        Location = locFormCB,
        //        Size = sizeFormCB,
        //        AutoCompleteMode = AutoCompleteMode.SuggestAppend,
        //        AutoCompleteSource = AutoCompleteSource.ListItems,
        //    };
        //    FNewWrite.Controls.Add(cb);
        //}
        private void CreateTypeLabel()
        {
            lab = new Label()
            {
                Name = "TypeLabel",
                Text = "Тип записи",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locTypeLabel,
                AutoSize = true,
            };
            FNewWrite.Controls.Add(lab);
        }
        private void CreateTypeCB()
        {
            cb = new ComboBox()
            {
                Name = "FormCB",
                Text = "",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locTypeCB,
                Size = sizeTypeCB,
                AutoCompleteMode = AutoCompleteMode.SuggestAppend,
                AutoCompleteSource = AutoCompleteSource.ListItems,
                Enabled = FormEnab,
            };
            cb.SelectedIndexChanged += TypeCB_SelectedIndexChanged;

            SqlParameter[] SP = new SqlParameter[0];
            Type = DB.GetData("Celect_TypeWrite", SP);
            DataRow RW;

            cb.Items.Clear();
            cb.Text = "";
            for (int i = 0; i < Type.Rows.Count; i++)
            {
                RW = Type.Rows[i];
                cb.Items.Add(RW["Тип записи"]);
            }
            try
            {
                cb.SelectedIndex = 0;
            }
            catch { }

            FNewWrite.Controls.Add(cb);
        }
        private void CreateMailLabel()
        {
            lab = new Label()
            {
                Name = "MailLabel",
                Text = "Почта: ",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locMailLabel,
                AutoSize = true,
            };
            FNewWrite.Controls.Add(lab);
        }
        private void CreateMailTB()
        {
            mtb = new MaskedTextBox()
            {
                Name = "MailTextBox",
                Text = "",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locMailTB,
                Size = sizeMailTB,
                MaxLength = 50,
                Enabled = false,
            };
            mtb.TextChanged += Form_TextChanged;
            FNewWrite.Controls.Add(mtb);
        }
        private void CreatePNumberLabel()
        {
            lab = new Label()
            {
                Name = "PNumberLabel",
                Text = "Номер телефона: ",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locPNumberLabel,
                AutoSize = true,
            };
            FNewWrite.Controls.Add(lab);
        }
        private void CreatePNumberTB()
        {
            mtb = new MaskedTextBox()
            {
                Name = "PNumberTextBox",
                Text = "",

                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locPNumberTB,
                Size = sizePNumberTB,
                Enabled = false,
                Mask = "+0(000)000-00-00",
            };
            mtb.TextChanged += Form_TextChanged;
            FNewWrite.Controls.Add(mtb);
        }
        private void CreateSiteLabel()
        {
            lab = new Label()
            {
                Name = "SiteLabel",
                Text = "Сайт: ",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locSiteLabel,
                AutoSize = true,
            };
            FNewWrite.Controls.Add(lab);
        }
        private void CreateSiteTB()
        {
            Tb = new TextBox()
            {
                Name = "SiteTextBox",
                Text = "",

                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locSiteTB,
                Size = sizeSiteTB,
                MaxLength = 100,
                Enabled = false,
            };
            Tb.TextChanged += Form_TextChanged;
            FNewWrite.Controls.Add(Tb);
        }
        private void CreateAddressLabel()
        {
            lab = new Label()
            {
                Name = "AddressLabel",
                Text = "Адрес: ",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locAddressLabel,
                AutoSize = true,
            };
            FNewWrite.Controls.Add(lab);
        }
        private void CreateAddressTB()
        {
            Tb = new TextBox()
            {
                Name = "AddressTextBox",
                Text = "",

                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locAddressTB,
                Size = sizeAddressTB,
                MaxLength = 100,
                Enabled = false,
            };
            Tb.TextChanged += Form_TextChanged;
            FNewWrite.Controls.Add(Tb);
        }
        private void CreateDateLabel()
        {
            lab = new Label()
            {
                Name = "DateLabel",
                Text = "Время записи: ",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locDateLabel,
                AutoSize = true,
            };
            FNewWrite.Controls.Add(lab);
        }
        private void CreateDateTB()
        {
            DTP = new DateTimePicker()
            {
                Name = "DatePicker",
                Text = "",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locDateTB,
                Size = sizeDateTB,
                Format = DateTimePickerFormat.Custom,
                CustomFormat = "dd.MM.yyyy",
                Enabled = FormEnab,
            };
            DTP.ValueChanged += new EventHandler(DatePickerValueChanged);
            FNewWrite.Controls.Add(DTP);
        }
        private void CreateDateCB()
        {
            cb = new ComboBox()
            {
                Name = "DateCB",
                Text = "",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locDateCB,
                Size = sizeDateCB,
                AutoCompleteMode = AutoCompleteMode.SuggestAppend,
                AutoCompleteSource = AutoCompleteSource.ListItems,
                DropDownStyle = ComboBoxStyle.DropDownList,
                Enabled = FormEnab,
            };

            UpdBox(2,cb);

            FNewWrite.Controls.Add(cb);
        }
        //private void CreateFormButton()
        //{
        //    but = new Button()
        //    {
        //        Name = "FormButton",
        //        Text = "Добавить форму",
        //        Font = DefFont,
        //        Visible = true,
        //        BackColor = DefBackColor,
        //        ForeColor = DefTextColor,
        //        Location = locFormBut,
        //        Size = sizeFormBut,
        //    };
        //    FNewWrite.Controls.Add(but);
        //}
    }
}
