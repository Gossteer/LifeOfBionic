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
    class DiagForm
    {
        private DataTable Medicaments;
        private DataTable Disease;
        private DataTable Deportaments;
        private DataTable TypeUse;

        public string id_Diag = "";
        public string NameMeca = "";
        public string NameDise = "";
        public string TimeHeal = "";
        public string AmounMed = "";
        public string NumbDeprot = "";
        public string TypeDise = "";

        public string CaptionButton = "Создать";

        private Form FDiag = new Form();
        private Label lab = new Label();
        private TextBox Tb = new TextBox();
        private MaskedTextBox mtb = new MaskedTextBox();
        private ComboBox cb = new ComboBox();
        private Button but = new Button();

        private Font DefFont = new Font("Microsoft Sans Serif", 10);
        private Color DefBackColor = Color.FromName("Control");
        private Color DefTextColor = Color.FromName("ControlText");
        
        //Позиции                                               //позиции
        private Point locMedicamentLabel = new Point(20, 10);   //label лекарств
        private Point locMedicamentCB = new Point(20, 33);      //ComboBox лекарств
        private Point locDiseaseLabel = new Point(20, 63);      //label болезней
        private Point locDiseaseCB = new Point(20, 86);         //ComboBox болезней
        private Point locDiseaseBut = new Point(180, 86);       //кнопка болезней 
        private Point locTimeLabel = new Point(20, 116);        //label срок лечения
        private Point locTimeTB = new Point(20, 139);           //TextBox срок лечения 

        private Point locAmountLabel = new Point(20, 169);      //label кол-во лекарств
        private Point locAmountTB = new Point(20, 192);         //textBox кол-во лекарств
        private Point locRoomLabel = new Point(20, 222);        //label выбор палаты
        private Point locRoomCB = new Point(20, 245);           //ComboBox выбор палаты

        private Point locUseLabel = new Point(20, 275);         //label тип потребления
        private Point locUseCB = new Point(20, 298);            //ComboBox тип потребления
        private Point locUseBut = new Point(180, 298);          //кнопка типов потребления

        private Point locApplyBut = new Point(20, 338);         //кнопка Создать
        private Point locCanBut = new Point(150, 338);          //кнопка Отмена

        //размеры                                               //размеры
        private Size sizeMedicamentCB = new Size(200, 20);      //ComboBox лекарств
        private Size sizeDiseaseCB = new Size(150, 20);         //ComboBox болезней
        private Size sizeDiseaseBut = new Size(75, 25);         //кнопка болезней
        private Size sizeTimeTB = new Size(100, 20);            //TextBox срок лечения

        private Size sizeAmountTB = new Size(50, 20);           //textBox кол-во лекарств
        private Size sizeRoomCB = new Size(200, 20);            //ComboBox выбор палаты
        private Size sizeUseCB = new Size(150, 20);             //ComboBox тип потребления
        private Size sizeUseBut = new Size(75, 25);             //кнопка типов потребления

        private Size sizeApplyBut = new Size(100, 30);          //кнопка Создать
        private Size sizeCanBut = new Size(100, 30);            //кнопка Отмена

        public void NewDiagForm()
        {
            CreateMedicamentLabel();
            CreateMedicamentCB();
            CreateDiseaseLabel();
            CreateDiseaseCB();
            CreateDiseaseButton();
            CreateTimeLabel();
            CreateTimeTB();
            CreateAmountLabel();
            CreateAmountTB();
            CreateRoomLabel();
            CreateRoomCB();
            CreateUseLabel();
            CreateUseCB();
            CreateUseBut();
            CreateApplyButton();
            CreateCanButton();

            FDiag.Text = "Создание диагноза";
            FDiag.Size = new Size(280, 425);
            FDiag.FormBorderStyle = FormBorderStyle.FixedSingle;
            FDiag.MaximizeBox = false;
            FDiag.StartPosition = FormStartPosition.CenterScreen;

            FDiag.FormClosing += new FormClosingEventHandler(FormClosing);
            FDiag.Controls["CanButton"].Click += new EventHandler(CancelButtonClick);
            if ((FDiag.Controls["ApplyButton"] as Button).Text == "Создать")
                FDiag.Controls["ApplyButton"].Click += new EventHandler(ApplyButtonClick);
            else
                FDiag.Controls["ApplyButton"].Click += new EventHandler(DiagnozButtonClick);

            FDiag.Controls["DiseaseCB"].TextChanged += DiseaseTextChange;
            FDiag.Controls["DiseaseButton"].Click += DiseasiButton;
            FDiag.Controls["UseCB"].TextChanged += TypeUseTextChange;
            FDiag.Controls["UseButton"].Click += TypeButtonClick;

            FDiag.ShowDialog();
        }
        //закрытие формы
        private void FormClosing(object sender, EventArgs e)
        {
            (Application.OpenForms[0] as MainForm).UpdGrids(2);
        }
        //отмена
        private void CancelButtonClick(object sender, EventArgs e)
        {
            DialogResult DR = MessageBox.Show("Вы уверены что хотите отменить создание?\n" +
                "Все веденные данные будут потеряны.", "Закрыть?", MessageBoxButtons.YesNo);
            if (DR == DialogResult.Yes)
                FDiag.Close();
        }
        //кнопка создать
        private void ApplyButtonClick(object sender, EventArgs e)
        {
            DataRow[] DRDerp = Deportaments.Select("[Терапевтическое отделение] = '"+ (FDiag.Controls["RoomCB"] as ComboBox).Text + "'");
            DataRow[] DRType = TypeUse.Select("[Name_Use] = '" + (FDiag.Controls["UseCB"] as ComboBox).Text + "'");
            DataRow[] DRMedi = Medicaments.Select("[Name_Medicament] = '" + (FDiag.Controls["MedicamentCB"] as ComboBox).Text + "'");
            DataRow[] DRDise = Disease.Select("[Name_Disease] = '" + (FDiag.Controls["DiseaseCB"] as ComboBox).Text + "'");

            try
            {
                SqlParameter[] SP = new SqlParameter[6]
                {
                    new SqlParameter ("@TimeDisease", (FDiag.Controls["TimeTextBox"] as TextBox).Text),
                    new SqlParameter ("@Amount", (FDiag.Controls["AmountTextBox"] as TextBox).Text),
                    new SqlParameter ("@ID_Room", DRDerp[0]["id_Room"]),
                    new SqlParameter ("@id_TypeUse", DRType[0]["id_TypeUse"]),
                    new SqlParameter ("@id_Medicament", DRMedi[0]["id_Medicament"]),
                    new SqlParameter ("@id_Disease", DRDise[0]["id_Disease"]),
                };
                DB.WriteData("Add_Diagnosis", SP);
            }
            catch
            {
                MessageBox.Show("Неудалось добавить введенные данные.\nПожалуйста проверьте правильность введенных данных.");
            }
            
            if (DB.LastWrite)
                FDiag.Close();
        }
        //кнопка изменить Диагноз
        private void DiagnozButtonClick(object sender, EventArgs e)
        {
            DataRow[] DRDerp = Deportaments.Select("[Терапевтическое отделение] = '" + (FDiag.Controls["RoomCB"] as ComboBox).Text + "'");
            DataRow[] DRType = TypeUse.Select("[Name_Use] = '" + (FDiag.Controls["UseCB"] as ComboBox).Text + "'");
            DataRow[] DRMedi = Medicaments.Select("[Name_Medicament] = '" + (FDiag.Controls["MedicamentCB"] as ComboBox).Text + "'");
            DataRow[] DRDise = Disease.Select("[Name_Disease] = '" + (FDiag.Controls["DiseaseCB"] as ComboBox).Text + "'");

            try
            {
                SqlParameter[] SP = new SqlParameter[]
                {
                    new SqlParameter("@id_Diagnoz", id_Diag),
                    new SqlParameter("@TimeDisease", (FDiag.Controls["TimeTextBox"] as TextBox).Text),
                    new SqlParameter("@Amount", (FDiag.Controls["AmountTextBox"] as TextBox).Text),
                    new SqlParameter("@ID_Room", DRDerp[0]["id_Room"]),
                    new SqlParameter ("@id_TypeUse", DRType[0]["id_TypeUse"]),
                    new SqlParameter ("@id_Medicament", DRMedi[0]["id_Medicament"]),
                    new SqlParameter ("@id_Disease", DRDise[0]["id_Disease"]),
                    new SqlParameter("@Diagnosis_Logical_Deletebit", false),
                };
                DB.UpdData("UPD_Diagnosis", SP);
            }
            catch
            {
                MessageBox.Show("Неудалось добавить введенные данные.\nПожалуйста проверьте правильность введенных данных.");
            }
            
            if (DB.LastWrite)
                FDiag.Close();
        }

        //кнопка изменения болзени
        private void DiseasiButton(object sender, EventArgs e)
        {
            switch ((sender as Button).Text)
            {
                case "Изменить":
                    {
                        DataRow[] DRDise = Disease.Select("[Name_Disease] = '" + (FDiag.Controls["DiseaseCB"] as ComboBox).Text + "'");

                        EditDelForm.EditData = (FDiag.Controls["DiseaseCB"] as ComboBox).Text;
                        EditDelForm.NewMess("Изменить", "Удалить", 2);
                        if (EditDelForm.LastResult == "Изменить")
                        {
                            SqlParameter[] SP = new SqlParameter[]
                            {
                                new SqlParameter("@id_Disease", DRDise[0]["id_Disease"]),
                                new SqlParameter("@Name_Disease", EditDelForm.EditData)
                            };
                            DB.UpdData("[UPD_DirectoryDisease]", SP);
                        }
                        if (EditDelForm.LastResult == "Удалить")
                        {
                            SqlParameter[] SP = new SqlParameter[]
                            {
                                new SqlParameter("@id_Disease", DRDise[0]["id_Disease"]),
                            };
                            DB.LogDelData("[logdel_DirectoryDisease]", SP);
                        }
                        break;
                    }
                case "Создать":
                    {
                        string Text = (FDiag.Controls["DiseaseCB"] as ComboBox).Text;

                        SqlParameter[] SP = new SqlParameter[]
                        {
                            new SqlParameter("@Name_Disease", Text),
                        };
                        DB.WriteData("[Add_DirectoryDisease]", SP);
                        break;
                    }
            }
            UpdDisease((FDiag.Controls["DiseaseCB"] as ComboBox));
        }
        //кнопка создания типов потребления
        private void TypeButtonClick(object sender, EventArgs e)
        {
            switch ((sender as Button).Text)
            {
                case "Изменить":
                    {
                        DataRow[] DRType = TypeUse.Select("[Name_Use] = '" + (FDiag.Controls["UseCB"] as ComboBox).Text + "'");

                        EditDelForm.EditData = (FDiag.Controls["UseCB"] as ComboBox).Text;
                        EditDelForm.NewMess("Изменить", "Удалить", 2);
                        if (EditDelForm.LastResult == "Изменить")
                        {
                            SqlParameter[] SP = new SqlParameter[]
                            {
                                new SqlParameter("@id_TypeUse", DRType[0]["id_TypeUse"]),
                                new SqlParameter("@NameUse", EditDelForm.EditData)
                            };
                            DB.UpdData("[UPD_TypeUse]", SP);
                        }
                        if (EditDelForm.LastResult == "Удалить")
                        {
                            SqlParameter[] SP = new SqlParameter[]
                            {
                                new SqlParameter("@id_TypeUse", DRType[0]["id_TypeUse"]),
                            };
                            DB.LogDelData("[logdel_TypeUse]", SP);
                        }
                        break;
                    }
                case "Создать":
                    {
                        string Text = (FDiag.Controls["UseCB"] as ComboBox).Text;

                        SqlParameter[] SP = new SqlParameter[]
                        {
                            new SqlParameter("@NameUse", Text),
                        };
                        DB.WriteData("[Add_TypeUse]", SP);
                        break;
                    }
            }
            UpdType((FDiag.Controls["UseCB"] as ComboBox));
        }

        //Выбор болезни
        private void DiseaseTextChange(object sender, EventArgs e)
        {
            string SText = (sender as ComboBox).Text;
            FDiag.Controls["DiseaseButton"].Enabled = (SText != "");
            
            if ((sender as ComboBox).SelectedIndex == -1)
            {
                FDiag.Controls["DiseaseButton"].Text = "Создать";
            }
            else
            {
                FDiag.Controls["DiseaseButton"].Text = "Изменить";
            }


        }
        //выбор типов потреблениия
        private void TypeUseTextChange(object sender, EventArgs e)
        {
            string SText = (sender as ComboBox).Text;
            FDiag.Controls["UseButton"].Enabled = (SText != "");

            if ((sender as ComboBox).SelectedIndex == -1)
            {
                FDiag.Controls["UseButton"].Text = "Создать";
            }
            else
            {
                FDiag.Controls["UseButton"].Text = "Изменить";
            }
        }

        //обновление Болезней
        private void UpdDisease(ComboBox cb)
        {
            SqlParameter[] SP = new SqlParameter[0];
            Disease = DB.GetData("Select_Name_Disease", SP);
            DataRow RW;

            cb.Items.Clear();
            cb.Text = "";
            for (int i = 0; i < Disease.Rows.Count; i++)
            {
                RW = Disease.Rows[i];
                cb.Items.Add(RW["Name_Disease"]);
            }
        }
        //обновление типов потребления
        private void UpdType(ComboBox cb)
        {
            SqlParameter[] SP = new SqlParameter[0];
            TypeUse = DB.GetData("Select_TypeUse", SP);
            DataRow RW;

            cb.Items.Clear();
            cb.Text = "";
            for (int i = 0; i < TypeUse.Rows.Count; i++)
            {
                RW = TypeUse.Rows[i];
                cb.Items.Add(RW["Name_Use"]);
            }
        }

        private void CreateMedicamentLabel()
        {
            lab = new Label()
            {
                Name = "MedicamentLabel",
                Text = "Лекарство: ",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locMedicamentLabel,
                AutoSize = true,
            };
            FDiag.Controls.Add(lab);
        }
        private void CreateMedicamentCB()
        {
            cb = new ComboBox()
            {
                Name = "MedicamentCB",
                Text = "",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locMedicamentCB,
                Size = sizeMedicamentCB,
                AutoCompleteMode = AutoCompleteMode.SuggestAppend,
                AutoCompleteSource = AutoCompleteSource.ListItems,
            };

            SqlParameter[] SP = new SqlParameter[0];
            Medicaments = DB.GetData("Select_Medicament", SP);
            DataRow RW;

            for (int i = 0; i < Medicaments.Rows.Count; i++)
            {
                RW = Medicaments.Rows[i];
                cb.Items.Add(RW[1]);
            }

            if (NameMeca != "")
            {
                DataRow[] DRMedi = Medicaments.Select("[Name_Medicament] LIKE '%" + NameMeca + "%'");
                string s = DRMedi[0]["Name_Medicament"].ToString();
                cb.Text = s;
            }

            FDiag.Controls.Add(cb);
        }//id колонки
        private void CreateDiseaseLabel()
        {
            lab = new Label()
            {
                Name = "DiseaseLabel",
                Text = "Название болезни: ",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locDiseaseLabel,
                AutoSize = true,
            };
            FDiag.Controls.Add(lab);
        }
        private void CreateDiseaseCB()
        {
            cb = new ComboBox()
            {
                Name = "DiseaseCB",
                Text = "",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locDiseaseCB,
                Size = sizeDiseaseCB,
                AutoCompleteMode = AutoCompleteMode.SuggestAppend,
                AutoCompleteSource = AutoCompleteSource.ListItems,
            };

            UpdDisease(cb);

            if (NameDise != "")
            {
                DataRow[] DRDise = Disease.Select("[Name_Disease] LIKE '%" + NameDise + "%'");
                string s = DRDise[0]["Name_Disease"].ToString();
                cb.Text = s;
            }

            FDiag.Controls.Add(cb);
        }
        private void CreateDiseaseButton()
        {
            but = new Button()
            {
                Name = "DiseaseButton",
                Text = "Изменить",
                Font = new Font("Microsoft Sans Serif", 9),
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locDiseaseBut,
                Size = sizeDiseaseBut,
                Enabled = false,
            };
            FDiag.Controls.Add(but);
        }
        private void CreateTimeLabel()
        {
            lab = new Label()
            {
                Name = "TimeLabel",
                Text = "Срок лечения: ",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locTimeLabel,
                AutoSize = true,
            };
            FDiag.Controls.Add(lab);
        }
        private void CreateTimeTB()
        {
            Tb = new TextBox()
            {
                Name = "TimeTextBox",
                Text = TimeHeal,
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locTimeTB,
                Size = sizeTimeTB,
                MaxLength = 3,
            };
            FDiag.Controls.Add(Tb);
        }
        private void CreateAmountLabel()
        {
            lab = new Label()
            {
                Name = "AmountLabel",
                Text = "Кол-во лекарств: ",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locAmountLabel,
                AutoSize = true,
            };
            FDiag.Controls.Add(lab);
        }
        private void CreateAmountTB()
        {
            Tb = new TextBox()
            {
                Name = "AmountTextBox",
                Text = AmounMed,
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locAmountTB,
                Size = sizeAmountTB,
                MaxLength = 3,
            };
            FDiag.Controls.Add(Tb);
        }
        private void CreateRoomLabel()
        {
            lab = new Label()
            {
                Name = "RoomLabel",
                Text = "Выбор палаты: ",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locRoomLabel,
                AutoSize = true,
            };
            FDiag.Controls.Add(lab);
        }
        private void CreateRoomCB()
        {
            cb = new ComboBox()
            {
                Name = "RoomCB",
                Text = "",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locRoomCB,
                Size = sizeRoomCB,
                AutoCompleteMode = AutoCompleteMode.SuggestAppend,
                AutoCompleteSource = AutoCompleteSource.ListItems,
            };

            SqlParameter[] SP = new SqlParameter[0];
            Deportaments = DB.GetData("Select_Id_Departament", SP);
            DataRow RW;

            for (int i = 0; i < Deportaments.Rows.Count; i++)
            {
                RW = Deportaments.Rows[i];
                cb.Items.Add(RW["Терапевтическое отделение"]);
            }

            if (NumbDeprot != "")
            {
                DataRow[] DRDerp = Deportaments.Select("[Терапевтическое отделение] LIKE '%" + NumbDeprot + "%'");
                string s = DRDerp[0]["Терапевтическое отделение"].ToString();
                cb.Text = s;
            }

            FDiag.Controls.Add(cb);
        }
        private void CreateUseLabel()
        {
            lab = new Label()
            {
                Name = "UseLabel",
                Text = "Тип потребления: ",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locUseLabel,
                AutoSize = true,
            };
            FDiag.Controls.Add(lab);
        }
        private void CreateUseCB()
        {
            cb = new ComboBox()
            {
                Name = "UseCB",
                Text = "",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locUseCB,
                Size = sizeUseCB,

            };

            UpdType(cb);

            if (TypeDise != "")
            {
                DataRow[] DRType = TypeUse.Select("[Name_Use] LIKE '%" + TypeDise + "%'");
                string s = DRType[0]["Name_Use"].ToString();
                cb.Text = s;
            }

            FDiag.Controls.Add(cb);
        }
        private void CreateUseBut()
        {
            but = new Button()
            {
                Name = "UseButton",
                Text = "Создать",
                Font = new Font("Microsoft Sans Serif", 8),
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locUseBut,
                Size = sizeUseBut,
                Enabled = false,
            };
            FDiag.Controls.Add(but);
        }

        private void CreateApplyButton()
        {
            but = new Button()
            {
                Name = "ApplyButton",
                Text = CaptionButton,
                Font = new Font("Microsoft Sans Serif", 9),
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locApplyBut,
                Size = sizeApplyBut,
            };
            FDiag.Controls.Add(but);
        }
        private void CreateCanButton()
        {
            but = new Button()
            {
                Name = "CanButton",
                Text = "Отмена",
                Font = new Font("Microsoft Sans Serif", 9),
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locCanBut,
                Size = sizeCanBut,
            };
            FDiag.Controls.Add(but);
        }
    }
}
