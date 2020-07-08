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
    class DeliMediForm
    {
        public bool RedactPost = false;
        public bool RedactMedi = false;
        public int id_Med = 0;
        public string Medicament = "";
        public int kol_vo = 0;
        public DateTime Date = DateTime.Now;

        public int id_Spot = 0;
        public string Category = "";
        public string manuf = "";

        private DataTable Medicaments;
        private DataTable Spot;
        private DataTable Categpry;
        private DataTable Manuf;

        private Form FDeli = new Form();
        private Label lab = new Label();
        private TextBox Tb = new TextBox();
        private MaskedTextBox mtb = new MaskedTextBox();
        private ComboBox cb = new ComboBox();
        private Button but = new Button();

        private Font DefFont = new Font("Microsoft Sans Serif", 10);
        private Color DefBackColor = Color.FromName("Control");
        private Color DefTextColor = Color.FromName("ControlText");

        //Позиции                                               //позиции
        private Point locMedicLabel = new Point(20, 10);        //Label ячейки склада
        private Point locMedicCB = new Point(20, 33);           //ComboBox ячейки склада

        private Point locSpotLabel = new Point(20, 63);         //Label ячейки склада
        private Point locSpotCB = new Point(20, 86);            //ComboBox ячейки склада
        private Point locNewBut = new Point(180, 86);           //кнопка Создать

        private Point locAmountLabel = new Point(20, 116);      //Label Кол-во
        private Point locAmountTB = new Point(20, 139);         //TextBox Кол-во

        private Point locDateLabel = new Point(20, 168);        //Label Дата поставки
        private Point locDateTB = new Point(20, 192);           //TextBox Дата поставки

        private Point locApplyBut = new Point(20, 230);         //кнопка принять 
        private Point locCanBut = new Point(280, 230);          //кнопка отменить


        //размеры                                               //размеры
        private Size sizeMedicCB = new Size(150, 20);           //ComboBox ячейки склада
        private Size sizeSpotCB = new Size(150, 20);            //ComboBox ячейки склада
        private Size sizeNewBut = new Size(70, 26);             //кнопка Создать
        private Size sizeAmountTB = new Size(60, 20);           //TextBox Кол-во
        private Size sizeDateTB = new Size(100, 20);            //TextBox Дата поставки
        private Size sizeApplyBut = new Size(150, 30);          //кнопка принять
        private Size sizeCanBut = new Size(70, 30);             //кнопка отменить



        //Позиции                                               //позиции
        private Point locNameLabel = new Point(320, 10);        //label название лекарства
        private Point locNameTB = new Point(320, 33);           //textBox название лекарства

        private Point locCategoryLabel = new Point(520, 10);    //label категории лекарств
        private Point locCategoryCB = new Point(520, 33);       //ComboBox  категории лекарств

        private Point locManufLabel = new Point(410, 63);       //label выбора производителя
        private Point locManufCB = new Point(410, 86);          //ComboBox  выбора производителя

        private Point locNewManufLabel = new Point(320, 116);   //label создания производителя
        private Point locNewManufTB = new Point(320, 139);      //textBox создания производителя

        private Point locMailLabel = new Point(520, 116);       //label Почта
        private Point locMailTB = new Point(520, 139);          //textBox Почта

        private Point locAddressLabel = new Point(320, 169);    //label Адрес
        private Point locAddressTB = new Point(320, 192);       //textBox Адрес

        private Point locNewMaufBut = new Point(520, 190);      //кнопка добавления производителя
        private Point locMedicBut = new Point(390, 230);        //кнопка добавления медикаментов

        //размеры                                               //размеры
        private Size sizeNameTB = new Size(150, 20);            //textBox название лекарства
        private Size sizeCategoryCB = new Size(150, 20);        //ComboBox категории лекарств
        private Size sizeManufCB = new Size(170, 20);           //ComboBox выбора производителя
        private Size sizeNewManufTB = new Size(150, 20);        //textBox создания производителя
        private Size sizeMailTB = new Size(150, 20);            //textBox Почта
        private Size sizeAddressTB = new Size(150, 20);         //textBox Адрес

        private Size sizeNewMaufBut = new Size(150, 28);        //кнопка добавления производителя
        private Size sizeMedicBut = new Size(210, 30);          //кнопка добавления медикаментов





        public DeliMediForm()
        {

        }

        public void NewDeliveryForm()
        {
            CreateMedicLabel();
            
            CreateSpotLabel();
            
            CreateNewButton();
            CreateAmountLabel();
            CreateAmountTB();
            CreateDateLabel();
            CreateDateTB();
            CreateApplyButton();
            CreateCancelButton();

            CreateNameLabel();
            CreateNameTB();
            CreateCategoryLabel();
            CreateCategoryCB();
            CreateManufLabel();
            
            CreateNewManufLabel();
            CreateNewManufTB();
            CreateMailLabel();
            CreateMailTB();
            CreateAddressLabel();
            CreateAddressTB();
            CreateNewMaufButton();
            CreateMedicButton();
            CreateCancelButton();

            CreateMedicCB();
            CreateSpotCB();
            CreateManufCB();

            FDeli.Text = "Новая поставка";
            FDeli.Size = new Size(705, 320);
            FDeli.FormBorderStyle = FormBorderStyle.FixedSingle;
            FDeli.MaximizeBox = false;
            FDeli.StartPosition = FormStartPosition.CenterScreen;

            FDeli.Controls["CancelButton"].Click += new EventHandler(CancelButtonClick);
            FDeli.Controls["ApplyButton"].Click += new EventHandler(ApplyButtonClick);
            (FDeli.Controls["MedicCB"] as ComboBox).TextChanged += MedicTextChange;
            (FDeli.Controls["ManufCB"] as ComboBox).TextChanged += ManufTextChange;
            (FDeli.Controls["SpotCB"] as ComboBox).SelectedIndexChanged += SpotSelectedChange;
            (FDeli.Controls["MedicButton"] as Button).Click += CreateMedicButton;
            (FDeli.Controls["NewMaufButton"] as Button).Click += ManufButtonClick;

            MedicTextChange((FDeli.Controls["MedicCB"] as ComboBox), new EventArgs());
            ManufTextChange((FDeli.Controls["ManufCB"] as ComboBox), new EventArgs());

            FDeli.ShowDialog();
        }
        //кнопка создания ячейки
        private void CreateSpotButton(object sender, EventArgs e)
        {
            switch ((sender as Button).Text)
            {
                case "Изменить":
                    {
                        DataRow[] DRSpot = Spot.Select("[Ячейка склада] = '" + (FDeli.Controls["SpotCB"] as ComboBox).Text + "'");

                        EditDelForm.EditData = (FDeli.Controls["SpotCB"] as ComboBox).Text;
                        EditDelForm.NewMess("Изменить", "Удалить", 2);
                        if (EditDelForm.LastResult == "Изменить")
                        {
                            SqlParameter[] SP = new SqlParameter[]
                            {
                                new SqlParameter("@id_Spot", DRSpot[0]["id_spot"]),
                                new SqlParameter("@Amount", EditDelForm.EditData)
                            };
                            DB.UpdData("[UPD_Storage]", SP);
                        }
                        if (EditDelForm.LastResult == "Удалить")
                        {
                            DataTable DT = DB.Funk("Answer_Select_Active_Storage({0})", new object[] { DRSpot[0]["id_spot"] });
                            DataRow DR = DT.Rows[0];
                            bool ActivSpot = Convert.ToBoolean(DR[0]);
                            MessageBox.Show(ActivSpot.ToString());
                            if (ActivSpot)
                            {
                                EditDelForm.NewKolVo("Введите номер ячейки в которую перенаправленны медикаменты");
                                if (EditDelForm.kolVo != 0)
                                {
                                    SqlParameter[] SP = new SqlParameter[]
                                    {
                                        new SqlParameter("@id_Spot_OLD", DRSpot[0]["id_spot"]),
                                        new SqlParameter("@id_Spot_New", EditDelForm.kolVo),
                                    };
                                    DB.LogDelData("[logdel_Storage]", SP);
                                }
                            }
                            else
                            {
                                SqlParameter[] SP = new SqlParameter[]
                                {
                                    new SqlParameter("@id_Spot", DRSpot[0]["id_spot"]),
                                };
                                DB.LogDelData("[logdel_Storage_If_AmountZero]", SP);
                            }
                        }
                        break;
                    }
                case "Создать":
                    {
                        string Text = (FDeli.Controls["SpotCB"] as ComboBox).Text;

                        EditDelForm.NewKolVo("Сколько места на новой ячейке");                        
                        SqlParameter[] SP = new SqlParameter[]
                        {
                            new SqlParameter("@Amount", EditDelForm.kolVo),
                        };
                        DB.WriteData("[Add_Storage]", SP);
                        break;
                    }
            }
            UpdBox(3,(FDeli.Controls["SpotCB"] as ComboBox));
        }
        //кнопка отмены
        private void CancelButtonClick(object sender, EventArgs e)
        {
            FDeli.Close();
        }
        //кнопка принять поставку
        private void ApplyButtonClick(object sender, EventArgs e)
        {
            SqlParameter[] SP = new SqlParameter[]
            {
                new SqlParameter("@User_Nick",AutorizForm.Nick),
            };
            DataTable DT = DB.GetData("SELECT_Profile_Personal", SP);

            DateTime res = (FDeli.Controls["DateTextBox"] as DateTimePicker).Value;
            string dat = res.ToString("yyyy.MM.dd");

            DataRow[] DRMedi = Medicaments.Select("[Name_Medicament] = '" + (FDeli.Controls["MedicCB"] as ComboBox).SelectedItem + "'");
            DataRow[] DRSpot = Spot.Select("[Ячейка склада] = '" + (FDeli.Controls["SpotCB"] as ComboBox).SelectedItem + "'");
            try
            {
                SP = new SqlParameter[]
                {
                    new SqlParameter("@Amount", (FDeli.Controls["AmountTextBox"] as TextBox).Text),
                    new SqlParameter("@DateOfDelivery", dat),
                    new SqlParameter("@id_Medicament", DRMedi[0]["id_Medicament"]),
                    new SqlParameter("@id_worker", DT.Rows[0]["id_worker"]),
                    new SqlParameter("@id_spot", DRSpot[0]["id_spot"]),
                };
            }
            catch
            {
                MessageBox.Show("Неудалось добавить данные.\nПожалуйста проверьте правильность введенных данных.", "Ошибка ввода");
            }
            
            DB.WriteData("Add_DeliveryMedicament", SP);
            if (DB.LastWrite)
                FDeli.Close();
        }
        //добавить производителя
        private void ManufButtonClick(object sender, EventArgs e)
        {
            SqlParameter[] SP = new SqlParameter[]
            {
                new SqlParameter("@Name_Manufacturer",(FDeli.Controls["NewManufTextBox"] as TextBox).Text),
                new SqlParameter("@Adress",(FDeli.Controls["AddressTextBox"] as TextBox).Text),
                new SqlParameter("@Mail",(FDeli.Controls["MailTextBox"] as TextBox).Text),
            };
            DataTable DT = DB.GetData("Add_Manufacturer", SP);
            UpdBox(2, (FDeli.Controls["ManufCB"] as ComboBox));
        }
        //Добавление лекарств
        private void CreateMedicButton(object sender, EventArgs e)
        {
            if (!RedactMedi)
            {
                DataRow[] DRMan = Manuf.Select("[Name_Manufacturer] = '" + (FDeli.Controls["ManufCB"] as ComboBox).Text + "'");
                DataRow[] DRCateg = Categpry.Select("[Name_MedCategory] = '" + (FDeli.Controls["CategoryCB"] as ComboBox).Text + "'");

                SqlParameter[] SP = new SqlParameter[]
                {
                    new SqlParameter("@Name_Medicament", (FDeli.Controls["NameTextBox"] as TextBox).Text),
                    new SqlParameter("@id_Manufacturer ", DRMan[0]["id_Manufacturer"]),
                    new SqlParameter("@id_CategoryOfMedicament ", DRCateg[0]["id_CategoryOfMedicament"]),
                };
                DB.WriteData("Add_Medicament", SP);
                UpdBox(1, (FDeli.Controls["MedicCB"] as ComboBox));
            }
            else
            {
                DataRow[] DRMan = Manuf.Select("[Name_Manufacturer] = '" + (FDeli.Controls["ManufCB"] as ComboBox).Text + "'");
                DataRow[] DRCateg = Categpry.Select("[Name_MedCategory] = '" + (FDeli.Controls["CategoryCB"] as ComboBox).Text + "'");

                SqlParameter[] SP = new SqlParameter[]
                {
                    new SqlParameter("@id_Medicament ", id_Med),
                    new SqlParameter("@Name_Medicament", (FDeli.Controls["NameTextBox"] as TextBox).Text),
                    new SqlParameter("@id_Manufacturer ", DRMan[0]["id_Manufacturer"]),
                    new SqlParameter("@id_CategoryOfMedicament ", DRCateg[0]["id_CategoryOfMedicament"]),
                };
                DB.WriteData("[UPD_Medicament]", SP);
                if(DB.LastWrite)
                {
                    UpdBox(1, (FDeli.Controls["MedicCB"] as ComboBox));
                    FDeli.Close();
                }
            }            
        }

        //выбор производителя
        private void ManufTextChange(object sender, EventArgs e)
        {
            bool Enab = ((sender as ComboBox).Text == "Новый производитель")&!(RedactPost);
            (FDeli.Controls["NewManufTextBox"] as TextBox).Enabled = Enab;
            (FDeli.Controls["MailTextBox"] as TextBox).Enabled = Enab;
            (FDeli.Controls["AddressTextBox"] as TextBox).Enabled = Enab;
            (FDeli.Controls["NewMaufButton"] as Button).Enabled = Enab;
            (FDeli.Controls["MedicButton"] as Button).Enabled = ((sender as ComboBox).Text != "Новый производитель");
        }
        //выбор лекарства
        private void MedicTextChange(object sender, EventArgs e)
        {
            if (!RedactMedi)
            {
                bool Enab = (((sender as ComboBox).Text == "Новое лекарство"));

                (FDeli.Controls["NameTextBox"] as TextBox).Enabled = Enab;
                (FDeli.Controls["CategoryCB"] as ComboBox).Enabled = Enab;
                (FDeli.Controls["ManufCB"] as ComboBox).Enabled = Enab;
                (FDeli.Controls["NewManufTextBox"] as TextBox).Enabled = Enab;
                (FDeli.Controls["MailTextBox"] as TextBox).Enabled = Enab;
                (FDeli.Controls["AddressTextBox"] as TextBox).Enabled = Enab;
                (FDeli.Controls["NewMaufButton"] as Button).Enabled = Enab;
                (FDeli.Controls["MedicButton"] as Button).Enabled = Enab;

                (FDeli.Controls["NewManufTextBox"] as TextBox).Enabled = Enab;
                (FDeli.Controls["MailTextBox"] as TextBox).Enabled = Enab;
                (FDeli.Controls["AddressTextBox"] as TextBox).Enabled = Enab;
                (FDeli.Controls["NewMaufButton"] as Button).Enabled = Enab;

                //ManufTextChange((FDeli.Controls["ManufCB"] as ComboBox), new EventArgs());

                //if (!Enab & !RedactPost)
                //{
                //    SqlParameter[] SP = new SqlParameter[0];
                //    DataTable DT = DB.GetData("[Select_Medicament_FOR_Storage]", SP);
                //    DataRow[] DRMed = DT.Select("[Название] = '" + (sender as ComboBox).Text + "'");

                //    (FDeli.Controls["NameTextBox"] as TextBox).Text = DRMed[0]["Название"].ToString();
                //    (FDeli.Controls["CategoryCB"] as ComboBox).Text = DRMed[0]["Категория"].ToString();
                //    (FDeli.Controls["ManufCB"] as ComboBox).Text = DRMed[0]["Производитель"].ToString();
                //}

                try
                {
                    if ((FDeli.Controls["SpotCB"] as ComboBox).SelectedIndex > 0)
                        (FDeli.Controls["ApplyButton"] as Button).Enabled = !Enab;
                    else
                        (FDeli.Controls["ApplyButton"] as Button).Enabled = false;
                }
                catch { }
            }
        }
        //выбор Ячейки
        private void SpotSelectedChange(object sender, EventArgs e)
        {
            string SText = (sender as ComboBox).Text;
            FDeli.Controls["NewButton"].Enabled = (SText != "");

            if ((sender as ComboBox).SelectedIndex == 0)
            {
                FDeli.Controls["NewButton"].Text = "Создать";
            }
            else
            {
                FDeli.Controls["NewButton"].Text = "Изменить";
            }

            bool Enab = ((sender as ComboBox).SelectedItem == "Новая ячейка");
            if ((FDeli.Controls["MedicCB"] as ComboBox).SelectedIndex > 0)
                (FDeli.Controls["ApplyButton"] as Button).Enabled = !Enab;
            else
                (FDeli.Controls["ApplyButton"] as Button).Enabled = false;
        }

        //обновление ComboBox
        private void UpdBox(int Numb, ComboBox CB)
        {
            switch (Numb)
            {
                case 1: //Medic
                    {
                        SqlParameter[] SP = new SqlParameter[0];
                        Medicaments = DB.GetData("[Select_Medicament]", SP);
                        DataRow RW;

                        CB.Items.Clear();
                        CB.Items.Add("Новое лекарство");
                        CB.SelectedIndex = 0;
                        for (int i = 0; i < Medicaments.Rows.Count; i++)
                        {
                            RW = Medicaments.Rows[i];
                            CB.Items.Add(RW[1]);
                        }
                        break;
                    }
                case 2: //Manuf
                    {
                        SqlParameter[] SP = new SqlParameter[0];
                        Manuf = DB.GetData("[Select_Manufacturer]", SP);
                        DataRow RW;

                        CB.Items.Clear();
                        CB.Items.Add("Новый производитель");
                        CB.SelectedIndex = 0;
                        for (int i = 0; i < Manuf.Rows.Count; i++)
                        {
                            RW = Manuf.Rows[i];
                            CB.Items.Add(RW[1]);
                        }
                        break;
                    }
                case 3: //Spot
                    {
                        SqlParameter[] SP = new SqlParameter[0];
                        Spot = DB.GetData("[Select_Storage_Id]", SP);
                        DataRow RW;

                        CB.Items.Clear();
                        CB.Items.Add("Новая ячейка");
                        CB.SelectedIndex = 0;
                        for (int i = 0; i < Spot.Rows.Count; i++)
                        {
                            RW = Spot.Rows[i];
                            CB.Items.Add(RW[1]);
                        }
                        break;
                    }
            }
        }

        private void CreateMedicLabel()
        {
            lab = new Label()
            {
                Name = "MedicLabel",
                Text = "Лекарство:",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                AutoSize = true,
                Location = locMedicLabel,
            };
            FDeli.Controls.Add(lab);
        }
        private void CreateMedicCB()
        {
            cb = new ComboBox()
            {
                Name = "MedicCB",
                Text = "",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locMedicCB,
                Size = sizeMedicCB,
                AutoCompleteMode = AutoCompleteMode.SuggestAppend,
                AutoCompleteSource = AutoCompleteSource.ListItems,
                Enabled = !RedactMedi,
            };

            UpdBox(1, cb);

            if (Medicament != "")
            {
                DataRow[] DRMedi = Medicaments.Select("[Name_Medicament] LIKE '%" + Medicament + "%'");
                string s = DRMedi[0]["Name_Medicament"].ToString();
                cb.Text = s;
            }

            FDeli.Controls.Add(cb);
        }
        private void CreateSpotLabel()
        {
            lab = new Label()
            {
                Name = "SpotLabel",
                Text = "Ячейка склада: ",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                AutoSize = true,
                Location = locSpotLabel,
            };
            FDeli.Controls.Add(lab);
        }
        private void CreateSpotCB()
        {
            cb = new ComboBox()
            {
                Name = "SpotCB",
                Text = "",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locSpotCB,
                Size = sizeSpotCB,
                AutoCompleteMode = AutoCompleteMode.SuggestAppend,
                AutoCompleteSource = AutoCompleteSource.ListItems,
                DropDownStyle = ComboBoxStyle.DropDownList,
                Enabled = !RedactMedi,
            };

            UpdBox(3, cb);

            if (id_Spot != 0)
            {
                DataRow[] DRSpot = Spot.Select("[id_spot] = '" + id_Spot + "'");
                string s = DRSpot[0]["Ячейка склада"].ToString();
                cb.Text = s;
            }

            FDeli.Controls.Add(cb);
        }
        private void CreateNewButton()
        {
            but = new Button()
            {
                Name = "NewButton",
                Text = "Создать",
                Font = new Font("Microsoft Sans Serif", 9),
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locNewBut,
                Size = sizeNewBut,
                Enabled = (!RedactMedi)
            };
            but.Click += CreateSpotButton;
            FDeli.Controls.Add(but);
        }
        private void CreateAmountLabel()
        {
            lab = new Label()
            {
                Name = "AmountLabel",
                Text = "Кол-во: ",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                AutoSize = true,
                Location = locAmountLabel,
            };
            FDeli.Controls.Add(lab);
        }
        private void CreateAmountTB()
        {
            Tb = new TextBox()
            {
                Name = "AmountTextBox",
                Text = kol_vo.ToString(),
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locAmountTB,
                Size = sizeAmountTB,
                MaxLength = 3,
                Enabled = !RedactMedi,
            };

            Tb.Text = kol_vo.ToString();

            FDeli.Controls.Add(Tb);
        }
        private void CreateDateLabel()
        {
            lab = new Label()
            {
                Name = "DateLabel",
                Text = "Дата поставки: ",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                AutoSize = true,
                Location = locDateLabel,
            };
            FDeli.Controls.Add(lab);
        }
        private void CreateDateTB()
        {
            DateTimePicker DTP = new DateTimePicker()
            {
                Name = "DateTextBox",
                Text = "",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locDateTB,
                Size = sizeDateTB,
                Format = DateTimePickerFormat.Custom,
                CustomFormat = "dd.MM.yyyy",
                Enabled = !(RedactPost|RedactMedi)
            };

            DTP.Value = Date;

            FDeli.Controls.Add(DTP);
        }

        private void CreateApplyButton()
        {
            but = new Button()
            {
                Name = "ApplyButton",
                Text = "Принять поставку",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locApplyBut,
                Size = sizeApplyBut,
                Enabled = false,
            };

            if (RedactPost)
                but.Text = "Изменить поставку";

            FDeli.Controls.Add(but);
        }
        private void CreateCancelButton()
        {
            but = new Button()
            {
                Name = "CancelButton",
                Text = "Выход",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locCanBut,
                Size = sizeCanBut,
            };
            FDeli.Controls.Add(but);
        }

        private void CreateNameLabel()
        {
            lab = new Label()
            {
                Name = "NameLabel",
                Text = "Название лекарства: ",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locNameLabel,
                AutoSize = true,
            };
            FDeli.Controls.Add(lab);
        }
        private void CreateNameTB()
        {
            Tb = new TextBox()
            {
                Name = "NameTextBox",
                Text = Medicament,
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locNameTB,
                Size = sizeNameTB,
                MaxLength = 100,
                Enabled = !RedactPost,
            };
            FDeli.Controls.Add(Tb);
        }
        private void CreateCategoryLabel()
        {
            lab = new Label()
            {
                Name = "CategoryLabel",
                Text = "Категория: ",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locCategoryLabel,
                AutoSize = true,
            };
            FDeli.Controls.Add(lab);
        }
        private void CreateCategoryCB()
        {
            cb = new ComboBox()
            {
                Name = "CategoryCB",
                Text = "",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locCategoryCB,
                Size = sizeCategoryCB,
                AutoCompleteMode = AutoCompleteMode.SuggestAppend,
                AutoCompleteSource = AutoCompleteSource.ListItems,
                Enabled = !RedactPost,
            };

            SqlParameter[] SP = new SqlParameter[0];
            Categpry = DB.GetData("[Select_CategoryOfMedicament]", SP);
            DataRow RW;

            for (int i = 0; i < Categpry.Rows.Count; i++)
            {
                RW = Categpry.Rows[i];
                cb.Items.Add(RW[1]);
            }

            if (Category != "")
            {
                DataRow[] DRCategory = Categpry.Select("[Name_MedCategory] LIKE '%" + Category + "%'");
                string s = DRCategory[0]["Name_MedCategory"].ToString();
                cb.Text = s;
            }

            FDeli.Controls.Add(cb);
        }

        private void CreateManufLabel()
        {
            lab = new Label()
            {
                Name = "ManufLabel",
                Text = "Производитель: ",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locManufLabel,
                AutoSize = true,
            };
            FDeli.Controls.Add(lab);
        }
        private void CreateManufCB()
        {
            cb = new ComboBox()
            {
                Name = "ManufCB",
                Text = "",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locManufCB,
                Size = sizeManufCB,
                AutoCompleteMode = AutoCompleteMode.SuggestAppend,
                AutoCompleteSource = AutoCompleteSource.ListItems,
                Enabled = !RedactPost,
            };

            UpdBox(2, cb);

            if (manuf != "")
            {
                DataRow[] DRManuf = Manuf.Select("[Name_Manufacturer] LIKE '%" + manuf + "%'");
                string s = DRManuf[0]["Name_Manufacturer"].ToString();
                cb.Text = s;
            }

            FDeli.Controls.Add(cb);
        }
        private void CreateNewManufLabel()
        {
            lab = new Label()
            {
                Name = "NewManufLabel",
                Text = "Название производителя: ",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locNewManufLabel,
                AutoSize = true,
            };
            FDeli.Controls.Add(lab);
        }
        private void CreateNewManufTB()
        {
            Tb = new TextBox()
            {
                Name = "NewManufTextBox",
                Text = "",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locNewManufTB,
                Size = sizeNewManufTB,
                MaxLength = 100,
            };
            FDeli.Controls.Add(Tb);
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
            FDeli.Controls.Add(lab);
        }
        private void CreateMailTB()
        {
            Tb = new TextBox()
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
            };
            FDeli.Controls.Add(Tb);
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
            FDeli.Controls.Add(lab);
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
            };
            FDeli.Controls.Add(Tb);
        }

        private void CreateNewMaufButton()
        {
            but = new Button()
            {
                Name = "NewMaufButton",
                Text = "Добавить производителя",
                Font = new Font("Microsoft Sans Serif", 8),
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locNewMaufBut,
                Size = sizeNewMaufBut,
            };

            FDeli.Controls.Add(but);
        }
        private void CreateMedicButton()
        {
            but = new Button()
            {
                Name = "MedicButton",
                Text = "Добавить лекарство",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locMedicBut,
                Size = sizeMedicBut,
            };

            if (RedactMedi)
                but.Text = "Применить редактирование";

            FDeli.Controls.Add(but);
        }
    }
}
