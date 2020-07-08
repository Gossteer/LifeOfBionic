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
    class AutorizForm
    {
        public static int id_Worker = 0;
        public static string Nick = "";
        public static string Spec = "";
        public static bool[] role = new bool[5];
                        //0 - запись
                        //1 - оформление карт
                        //2 - прием медикаментов
                        //3 - разрешение на выписку
                        //4 - прием пациентов

        private Form FAutoriz = new Form();
        private Label lab = new Label();
        private TextBox Tb = new TextBox();
        private MaskedTextBox mtb = new MaskedTextBox();
        private Button but = new Button();

        private Font DefFont = new Font("Microsoft Sans Serif", 10);
        private Color DefBackColor = Color.FromName("Control");
        private Color DefTextColor = Color.FromName("ControlText");

        //Позиции                                         //позиции
        private Point locAutLabel =  new Point(20, 10);   //label логина
        private Point locAutTB =     new Point(20, 33);   //TextBox логина
        private Point locPassLabel = new Point(20, 63);   //label пароля
        private Point locPassTB =    new Point(20, 86);   //TextBox пароля
        private Point locEntBut =    new Point(20, 116);  //кнопка вход
        private Point locCanBut =    new Point(90, 116);  //кнопка отмены

        //размеры                                         //размеры
        private Size sizeAutTB =  new Size(150, 20);      //TextBox логина
        private Size sizePassTB = new Size(150, 20);      //TextBox пароля
        private Size sizeEntBut = new Size(70, 30);       //кнопка вход
        private Size sizeCanBut = new Size(80, 30);       //кнопка отмены
        
        public void NewAutorizForm()
        {
            CreateLoginLabel();
            CreateLoginTB();
            CreatePassLabel();
            CreatePassTB();
            CreateEnterButton();
            CreateCancelButton();

            FAutoriz.Text = "Вход";
            FAutoriz.Size = new Size(205,195);
            FAutoriz.FormBorderStyle = FormBorderStyle.FixedSingle;
            FAutoriz.MaximizeBox = false;
            FAutoriz.StartPosition = FormStartPosition.CenterScreen;

            (FAutoriz.Controls["LoginTextBox"] as TextBox).Text = MainForm.shifLogin;
            if((FAutoriz.Controls["LoginTextBox"] as TextBox).Text != "")
            {
                FAutoriz.ActiveControl = (FAutoriz.Controls["PassTextBox"] as MaskedTextBox);
            }
            
            FAutoriz.Controls["EnterButton"].Click += new EventHandler(ButtonEnterClick);
            FAutoriz.Controls["CancelButton"].Click += new EventHandler(ButtonCancelClick);

            FAutoriz.ShowDialog(); 
        }
        //кнопка вход
        private void ButtonEnterClick(object sender, EventArgs e)
        {
            DataTable DT = new DataTable();
            DataRow DR;
            DB.LogIn = false;

            //Выгружаем список разрешений пользователя
            SqlParameter[] SP = new SqlParameter[]
            {
                new SqlParameter("@User_Nick", (FAutoriz.Controls["LoginTextBox"]as TextBox).Text),
                new SqlParameter("@User_Pass", (FAutoriz.Controls["PassTextBox"] as MaskedTextBox).Text),
            };
            DT = DB.GetData("Select_Role_Percon", SP);

            //если нет ролей
            if (DB.LastGet)
                if (DT.Rows.Count == 0)
                {
                    MessageBox.Show("У вас нет прав на просмотр и изменение каких либо данных.\nПожалуйста обратитесь к администратору для получения прав.");
                    DB.LogIn = false;
                    return;
                }
                else
                {
                    Nick = (FAutoriz.Controls["LoginTextBox"] as TextBox).Text;

                    //запоминаем роли
                    if (DT.Rows.Count != 0)
                    {
                        DR = DT.Rows[0];
                        for (int i = 0; i < role.Length; i++)
                        {
                            role[i] = (bool)DR[i + 1];
                        }
                        DB.LogIn = true;
                    }
                    try
                    {
                        SP = new SqlParameter[]
                        {
                            new SqlParameter("@User_Nick", Nick),
                        };
                        DT = DB.GetData("SELECT_Profile_Personal", SP);
                        id_Worker = Convert.ToInt32(DT.Rows[0]["id_worker"]);
                    }
                    catch
                    {
                        MessageBox.Show("Что то пошло не так.\nПопробуйте снова.", "Ошибка");
                        Nick = "";
                        DB.LogIn = false;
                        return;
                    }                    

                    //выгружаем специальность
                    SP = new SqlParameter[1]
                    {
                        new SqlParameter("@User_Nick", (FAutoriz.Controls["LoginTextBox"]as TextBox).Text),
                    };
                    DT = DB.GetData("Select_Spesialization_For_Personal", SP);

                    //запоминаем специальность
                    if (DT.Rows.Count != 0)
                    {
                        DR = DT.Rows[0];
                        Spec = DR[0].ToString();
                    }
                }

            if (DB.LogIn)
            {
                string Login = Shifrovanie.Shifrovanie.Encrypt(Nick, "qwerty555");
                Regedit.Reestr.Write("LifeOfBionic", "login", Login);

                SP = new SqlParameter[]
                {
                    new SqlParameter("@id_worker", id_Worker),
                };
                DT = DB.GetData("Select_Personal_Color", SP);
                if (DT.Rows[0]["color"] != DBNull.Value)
                    ProfileForm.UColor = Color.FromName(DT.Rows[0]["color"].ToString());

                FAutoriz.Close();
            }
        }
        //кнопка отмена
        private void ButtonCancelClick(object sender, EventArgs e)
        {
            FAutoriz.Close();
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
            FAutoriz.Controls.Add(lab);
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
            };
            FAutoriz.Controls.Add(Tb);
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
            FAutoriz.Controls.Add(lab);
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
            };
            mtb.UseSystemPasswordChar = true;
            FAutoriz.Controls.Add(mtb);
        }
        private void CreateEnterButton()
        {
            but = new Button()
            {
                Name = "EnterButton",
                Text = "Вход",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locEntBut,
                Size = sizeEntBut,
            };
            FAutoriz.Controls.Add(but);
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
            FAutoriz.Controls.Add(but);
        }
    }
}
