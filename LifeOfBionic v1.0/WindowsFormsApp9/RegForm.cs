using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApp9
{
    class RegForm
    {
        private Form FReg = new Form();
        private Label lab = new Label();
        private TextBox Tb = new TextBox();
        private MaskedTextBox mtb = new MaskedTextBox();
        private ComboBox cb = new ComboBox();
        private Button but = new Button();

        private Font DefFont = new Font("Microsoft Sans Serif", 10);
        private Color DefBackColor = Color.FromName("Control");
        private Color DefTextColor = Color.FromName("ControlText");

        //Позиции                                           //позиции
        private Point locSurLabel = new Point(20, 10);      //label фамилии
        private Point locSurTB = new Point(20, 33);         //textBox фамилии
        private Point locNameLabel = new Point(200, 10);    //label имени
        private Point locNameTB = new Point(200, 33);       //textBox имени
        private Point locPatLabel = new Point(20, 63);      //label отчества
        private Point locPatTB = new Point(20, 86);         //textBox отчества
        private Point locAutLabel = new Point(200, 63);     //label логина
        private Point locAutTB = new Point(200, 86);        //TextBox логина
        private Point locPassLabel = new Point(20, 116);    //label пароля
        private Point locPassTB = new Point(20, 139);       //TextBox пароля
        private Point locAgPassLabel = new Point(200, 116); //label повтора пароля
        private Point locAgPassTB = new Point(200, 139);    //TextBox повтора пароля    
        private Point locSeriesLabel = new Point(20, 169);  //label серии пасспорта
        private Point locSeriesTB = new Point(20, 192);     //textBox серии пасспорта
        private Point locNumberLabel = new Point(200, 169); //label номера пасспорта
        private Point locNumberTB = new Point(200, 192);    //textBox номера пасспорта
        private Point locRegBut = new Point(20, 230);       //кнопка вход
        private Point locCanBut = new Point(200, 230);      //кнопка отмены

        //размеры                                           //размеры
        private Size sizeSurTB = new Size(150, 20);         //textBox фамилии
        private Size sizeNameTB = new Size(150, 20);        //textBox имени
        private Size sizePatTB = new Size(150, 20);         //textBox отчества
        private Size sizeAutTB = new Size(150, 20);         //TextBox логина
        private Size sizePassTB = new Size(150, 20);        //TextBox пароля
        private Size sizeAgPassTB = new Size(150, 20);      //TextBox повтора пароля
        private Size sizeSeriesTB = new Size(150, 20);      //textBox серии паспорта
        private Size sizeNumberTB = new Size(150, 20);      //textBox номера пасспорта
        private Size sizeRegBut = new Size(150, 30);        //кнопка вход
        private Size sizeCanBut = new Size(150, 30);        //кнопка отмены

        public RegForm()
        {

        }

        public void NewRegForm()
        {
            CreateSurLabel();
            CreateSurTB();
            CreateNameLabel();
            CreateNameTB();
            CreatePatLabel();
            CreatePatTB();
            CreateRegButton();
            CreateCancelButton();

            CreateLoginLabel();
            CreateLoginTB();
            CreatePassLabel();
            CreatePassTB();
            CreateAgainPassTB();
            CreateAgainPassLabel();

            CreateSeriesTB();
            CreateSeriesLabel();
            CreateNumLabel();
            CreateNumTB();

            FReg.Text = "Регистрация";
            FReg.Size = new Size(385, 310);
            FReg.FormBorderStyle = FormBorderStyle.FixedSingle;
            FReg.MaximizeBox = false;
            FReg.StartPosition = FormStartPosition.CenterScreen;

            FReg.FormClosing += new FormClosingEventHandler(FormClosing);
            FReg.Controls["RegButton"].Click += new EventHandler(RegButtonClick);
            FReg.Controls["CancelButton"].Click += new EventHandler(CancelButtonClick);
            FReg.Controls["PassTextBox"].TextChanged += new EventHandler(AggPassTextChange);
            FReg.Controls["PassAgainTextBox"].TextChanged += new EventHandler(AggPassTextChange);

            FReg.ShowDialog();
        }
        //закрытие формы
        private void FormClosing(object sender, EventArgs e)
        {
        }
        //кнопка зарегистрироваться
        private void RegButtonClick(object sender, EventArgs e)
        {
            if (aggPass)
            {

                SqlParameter[] SP = new SqlParameter[7]
                {
                new SqlParameter("@SurnamePers",(FReg.Controls["SurTextBox"] as TextBox).Text),
                new SqlParameter("@NamePers",(FReg.Controls["NameTextBox"] as TextBox).Text),
                new SqlParameter("@PatronymicPers",(FReg.Controls["PatTextBox"] as TextBox).Text),
                new SqlParameter("@SeriesPassportPers",(FReg.Controls["SeriesTextBox"] as TextBox).Text),
                new SqlParameter("@NumberPassportPers",(FReg.Controls["NumberTextBox"] as TextBox).Text),
                new SqlParameter("@User_Nick",(FReg.Controls["LoginTextBox"] as TextBox).Text),
                new SqlParameter("@User_Pass",(FReg.Controls["PassTextBox"] as MaskedTextBox).Text),
                };
                int id = DB.WriteData("Add_Personal", SP);
                if (id != -10)
                {
                    FReg.Close();
                }
            }
            else
            {
                MessageBox.Show("Указанные пароли должны совпадать!","Ошибка ввода!");
            }
        }
        //кнопка отмены
        private void CancelButtonClick(object sender, EventArgs e)
        {
            FReg.Close();
        }
        //при измнении текста 
        bool aggPass = false;
        private void AggPassTextChange(object sender, EventArgs e)
        {
            MaskedTextBox Pass = (FReg.Controls["PassTextBox"] as MaskedTextBox);
            MaskedTextBox AggPass = (FReg.Controls["PassAgainTextBox"] as MaskedTextBox);
            
            if (Pass.Text != AggPass.Text)
            {
                Pass.BackColor = Color.Red;
                AggPass.BackColor = Color.Red;
                aggPass = false;
            }
            else
            {
                Pass.BackColor = Color.FromName("Control");
                AggPass.BackColor = Color.FromName("Control");
                aggPass = true;
            }
        }

        private void CreateLoginLabel()
        {
            lab = new Label()
            {
                Name = "LoginLabel",
                Text = "Логин: ",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locAutLabel,
                AutoSize = true,
            };
            FReg.Controls.Add(lab);
        }
        private void CreateLoginTB()
        {
            Tb = new TextBox()
            {
                Name = "LoginTextBox",
                Text = "",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locAutTB,
                Size = sizeAutTB,
                MaxLength = 50,
            };
            FReg.Controls.Add(Tb);
        }
        private void CreatePassLabel()
        {
            lab = new Label()
            {
                Name = "PassLabel",
                Text = "Пароль: ",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locPassLabel,
                AutoSize = true,
            };
            FReg.Controls.Add(lab);
        }
        private void CreatePassTB()
        {
            mtb = new MaskedTextBox()
            {
                Name = "PassTextBox",
                Text = "",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locPassTB,
                Size = sizePassTB,
                MaxLength = 30,
            };
            mtb.UseSystemPasswordChar = true;
            FReg.Controls.Add(mtb);
        }
        private void CreateAgainPassLabel()
        {
            lab = new Label()
            {
                Name = "PassAgainLabel",
                Text = "Повторите пароль: ",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locAgPassLabel,
                AutoSize = true,
            };
            FReg.Controls.Add(lab);
        }
        private void CreateAgainPassTB()
        {
            mtb = new MaskedTextBox()
            {
                Name = "PassAgainTextBox",
                Text = "",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locAgPassTB,
                Size = sizeAgPassTB,
                MaxLength = 30,
            };
            mtb.UseSystemPasswordChar = true;
            FReg.Controls.Add(mtb);
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
            FReg.Controls.Add(lab);
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
            FReg.Controls.Add(Tb);
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
            FReg.Controls.Add(lab);
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
            FReg.Controls.Add(Tb);
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
            FReg.Controls.Add(lab);
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
            FReg.Controls.Add(Tb);
        }
        private void CreateRegButton()
        {
            but = new Button()
            {
                Name = "RegButton",
                Text = "Зарегистрироваться",
                Font = new Font("Microsoft Sans Serif", 9),
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locRegBut,
                Size = sizeRegBut,
            };
            FReg.Controls.Add(but);
        }
        private void CreateCancelButton()
        {
            but = new Button()
            {
                Name = "CancelButton",
                Text = "Отмена",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locCanBut,
                Size = sizeCanBut,
            };
            FReg.Controls.Add(but);
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
            FReg.Controls.Add(lab);
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
            FReg.Controls.Add(Tb);
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
            FReg.Controls.Add(lab);
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
            FReg.Controls.Add(Tb);
        }
    }
}
