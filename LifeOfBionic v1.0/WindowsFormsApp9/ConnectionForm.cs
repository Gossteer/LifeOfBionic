using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Net.NetworkInformation;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Windows.Forms.ComboBox;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.ListView;

namespace WindowsFormsApp9
{
    class ConnectionForm
    {
        private static int cdt, cbd;
        private static String[] CDT;
        private static String[] CBD;

        private Form FCon = new Form();
        private Label lab = new Label();
        private TextBox Tb = new TextBox();
        private MaskedTextBox mtb = new MaskedTextBox();
        private ComboBox cb = new ComboBox();
        private Button but = new Button();

        private Font DefFont = new Font("Microsoft Sans Serif", 8);
        private Color DefBackColor = Color.FromName("Control");
        private Color DefTextColor = Color.FromName("ControlText");

        //Позиции                                        //позиции
        private Point locServLabel = new Point(20, 10);  //label сервера
        private Point locServCB = new Point(20, 33);     //ComboBox сервера
        private Point locLoginLabel = new Point(20, 63); //label Логина
        private Point locLoginTB = new Point(20, 86);    //TextBox Логина
        private Point locPassLabel = new Point(20, 116); //label пароля
        private Point locPassTB = new Point(20, 139);    //TextBox пароля
        private Point locBDLabel = new Point(20, 169);   //label источника данных
        private Point locBDCB = new Point(20, 192);      //ComboBox источника данных
        private Point locKeyLabel = new Point(20, 222);  //label Ключа
        private Point locKeyTb = new Point(20, 245);     //ComboBox Ключа

        private Point locProvBut = new Point(20, 310);   //кнопка Проверки
        private Point locConnectBut = new Point(105, 310);//кнопка подключения
        private Point locCanBut = new Point(205, 310);   //кнопка отмены
        private Point locRefBut = new Point(170, 8);     //копка обновления
        private Point locCleBut = new Point(20, 275);    //копка обновления

        //размеры                                        //размеры
        private Size sizeServCB = new Size(250, 20);     //ComboBox сервера
        private Size sizeLoginTB = new Size(250, 20);    //TextBox Логина
        private Size sizePassTB = new Size(250, 20);     //TextBox пароля
        private Size sizeBDCB = new Size(250, 20);       //ComboBox источника
        private Size sizeKeyTb = new Size(250, 20);      //ComboBox Ключа

        private Size sizeProvBut = new Size(75, 30);     //кнопка Проверки
        private Size sizeConnectBut = new Size(95, 30);  //кнопка подключения
        private Size sizeCanBut = new Size(65, 30);      //кнопка отмены
        private Size sizeRefBut = new Size(100, 20);     //кнопка обновления
        private Size sizeCleBut = new Size(250, 30);     //кнопка обновления

        public ConnectionForm()
        {

        }

        public void NewConForm()
        {
            CreateServLabel();
            CreateServCB();
            CreateLoginLabel();
            CreateLoginTB();
            CreatePassLabel();
            CreatePassTB();
            CreateBDLabel();
            CreateBDCB();
            CreateConnectButton();

            CreateKeyLabel();
            CreateKeyTB();

            CreateProvButton();
            CreateCancelButton();
            CreateRefreshButton();
            CreateClearButton();
            
            FCon.FormClosed += new FormClosedEventHandler(FormClosing);
            (FCon.Controls["RefreshButton"] as Button).Click += new EventHandler(ButtonRefreshClick);
            (FCon.Controls["ProvButton"] as Button).Click += new EventHandler(ProvLogin);
            (FCon.Controls["CancelButton"] as Button).Click += new EventHandler(ButtonCancelClick);
            (FCon.Controls["ConnectButton"] as Button).Click += new EventHandler(ButtonConnectClick);

            (FCon.Controls["ServCB"] as ComboBox).KeyPress += new KeyPressEventHandler(KeyPressProv);
            (FCon.Controls["LoginTextBox"] as TextBox).KeyPress += new KeyPressEventHandler(KeyPressProv);
            (FCon.Controls["PassTextBox"] as MaskedTextBox).KeyPress += new KeyPressEventHandler(KeyPressProv);
            (FCon.Controls["ClearButton"] as Button).Click += new EventHandler(ClearButton);

            Enab();

            if (DataBaseConfiguration.connect)
            {
                (FCon.Controls["LoginTextBox"] as TextBox).Text = DataBaseConfiguration.cui;
                (FCon.Controls["PassTextBox"] as MaskedTextBox).Text = DataBaseConfiguration.cpw;

                try
                {
                    for (int i = 0; i < CDT.Length; i++)
                        (FCon.Controls["ServCB"] as ComboBox).Items.Add(CDT[i]);
                }
                catch { }

                (FCon.Controls["ServCB"] as ComboBox).Text = DataBaseConfiguration.cds;

                try
                {
                    for (int i = 0; i < CBD.Length; i++)
                        (FCon.Controls["BDCB"] as ComboBox).Items.Add(CBD[i]);
                }
                catch { }

                (FCon.Controls["BDCB"] as ComboBox).Text = DataBaseConfiguration.baseName;
            }
            else { ButtonRefreshClick(new Button(),new EventArgs()); }

            FCon.Text = "Подключение";
            FCon.Size = new Size(305, 335+53);
            FCon.FormBorderStyle = FormBorderStyle.FixedSingle;
            FCon.MaximizeBox = false;
            FCon.StartPosition = FormStartPosition.CenterScreen;

            FCon.ShowDialog();
        }

        //включение выключение компонентов
        private void Enab()
        {
            (FCon.Controls["RefreshButton"] as Button).Enabled = true;
            (FCon.Controls["ServCB"] as ComboBox).Enabled = true;
            (FCon.Controls["LoginTextBox"] as TextBox).Enabled = true;
            (FCon.Controls["PassTextBox"] as MaskedTextBox).Enabled = true;
            (FCon.Controls["BDCB"] as ComboBox).Enabled = true;
            (FCon.Controls["ProvButton"] as Button).Enabled = true;
            (FCon.Controls["ConnectButton"] as Button).Enabled = true;
            
            if (DataBaseConfiguration.connect)
            {
                (FCon.Controls["RefreshButton"] as Button).Enabled = false;
                (FCon.Controls["ServCB"] as ComboBox).Enabled = false;
                (FCon.Controls["LoginTextBox"] as TextBox).Enabled = false;
                (FCon.Controls["PassTextBox"] as MaskedTextBox).Enabled = false;
                (FCon.Controls["ProvButton"] as Button).Enabled = false;
            }
            else
            {
                (FCon.Controls["BDCB"] as ComboBox).Text = "";
                (FCon.Controls["BDCB"] as ComboBox).Enabled = false;
                (FCon.Controls["ConnectButton"] as Button).Enabled = false;
            }

            if ((FCon.Controls["ServCB"] as ComboBox).Text == "Поиск серверов...")
            {
                (FCon.Controls["ServCB"] as ComboBox).Enabled = false;
                (FCon.Controls["BDCB"] as ComboBox).Enabled = false;
                (FCon.Controls["ConnectButton"] as Button).Enabled = false;
            }
            if ((FCon.Controls["BDCB"] as ComboBox).Text == "Поиск...")
            {
                (FCon.Controls["BDCB"] as ComboBox).Enabled = false;
            }
        }

        //закрытие формы
        private void FormClosing(object sender, EventArgs e)
        {
            if (DataBaseConfiguration.connect)
            {
                AutorizForm AF = new AutorizForm();
                AF.NewAutorizForm();
            }
        }
        //кнопка сброса реестра
        private void ClearButton(object sender, EventArgs e)
        {
            try
            {
                Regedit.Reestr.DelKey("LifeOfBionic");
            }
            catch
            {
                MessageBox.Show("Реестр уже очищен");
            }
        }
        //кнопка проверки
        private void ProvLogin(object sender, EventArgs e)
        {
            DataBaseConfiguration.connect = true;
            Enab();
            (FCon.Controls["ConnectButton"] as Button).Enabled = false;

            ComboBox CB = (FCon.Controls["BDCB"] as ComboBox);
            string cds = (FCon.Controls["ServCB"] as ComboBox).Text;
            string cui = (FCon.Controls["LoginTextBox"] as TextBox).Text;
            string cpw = (FCon.Controls["PassTextBox"] as MaskedTextBox).Text;
            CB.Enabled = false;
            CB.Text = "Поиск...";
            Thread t = new Thread(() => DataBaseConfiguration.SearchBases(FCon, CB, (FCon.Controls["ConnectButton"] as Button), cds, cui, cpw));
            t.Start();
        }
        //обновление списка серверов
        private void ButtonRefreshClick(object sender, EventArgs e)
        {
            (FCon.Controls["ProvButton"] as Button).Enabled = false;
            ComboBox CB = (FCon.Controls["ServCB"] as ComboBox);
            CB.Text = "Поиск серверов...";
            CB.Enabled = false;
            Thread t = new Thread(() => DataBaseConfiguration.searchServers(FCon, CB, (FCon.Controls["ProvButton"] as Button)));
            t.Start();
        }
        //кнопка отмены
        private void ButtonCancelClick(object sender, EventArgs e)
        {
            if (!DataBaseConfiguration.connect)
            {
                FCon.Close();
            }
            else
            {
                DataBaseConfiguration.connect = false;
                Enab();
            }
        }
        //кнопка подключиться
        private void ButtonConnectClick(object sender, EventArgs e)
        {
            (FCon.Controls["BDCB"] as ComboBox).Enabled = false;

            DataBaseConfiguration.cds = (FCon.Controls["ServCB"] as ComboBox).Text;
            DataBaseConfiguration.cui = (FCon.Controls["LoginTextBox"] as TextBox).Text;
            DataBaseConfiguration.cpw = (FCon.Controls["PassTextBox"] as MaskedTextBox).Text;
            DataBaseConfiguration.baseName = (FCon.Controls["BDCB"] as ComboBox).Text;

            CDT = new string[(FCon.Controls["ServCB"] as ComboBox).Items.Count];
            CBD = new string[(FCon.Controls["BDCB"] as ComboBox).Items.Count];
            for(int i = 0; i< (FCon.Controls["ServCB"] as ComboBox).Items.Count;i++)
                CDT[i] = (FCon.Controls["ServCB"] as ComboBox).Items[i].ToString();
            cdt = (FCon.Controls["ServCB"] as ComboBox).SelectedIndex;
            for (int i = 0; i < (FCon.Controls["BDCB"] as ComboBox).Items.Count; i++)
                CBD[i] = (FCon.Controls["BDCB"] as ComboBox).Items[i].ToString();
            cbd = (FCon.Controls["BDCB"] as ComboBox).SelectedIndex;

            if (DataBaseConfiguration.key == "")
            {
                MaskedTextBox MTB = (FCon.Controls["KeyTextBox"] as MaskedTextBox);
                DataBaseConfiguration.key = MTB.Text;
            }

            SqlParameter[] SP = new SqlParameter[]
            {
                new SqlParameter("@Code_Licence", DataBaseConfiguration.key),
                new SqlParameter("@MAC_Adress", DataBaseConfiguration.iden),
            };
            DB.UpdData("Active_Lisense", SP);
            if (!DB.LastUpd)
                return;
            
            MainForm.Shifr();

            FCon.Close();
        }
        //Esc и Enter 
        private void KeyPressProv(object sender, KeyPressEventArgs e)
        {
            switch (e.KeyChar)
            {
                case (char)13:
                    {
                        if ((FCon.Controls["ProvButton"] as Button).Enabled)
                            ProvLogin(new Button(), new EventArgs());
                        break;
                    }
                case (char)27:
                    {
                        if ((FCon.Controls["CancelButton"] as Button).Enabled)
                            ButtonCancelClick(new Button(), new EventArgs());
                        break;
                    }
            }
        }

        private void CreateServLabel()
        {
            lab = new Label()
            {
                Name = "ServLabel",
                Text = "Сервер: ",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locServLabel,
                AutoSize = true,
            };
            FCon.Controls.Add(lab);
        }
        private void CreateServCB()
        {
            cb = new ComboBox()
            {
                Name = "ServCB",
                Text = "",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locServCB,
                Size = sizeServCB,
            };
            FCon.Controls.Add(cb);
        }
        private void CreateLoginLabel()
        {
            lab = new Label()
            {
                Name = "LoginLabel",
                Text = "Логин сервера: ",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locLoginLabel,
                AutoSize = true,
            };
            FCon.Controls.Add(lab);
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
                Location = locLoginTB,
                Size = sizeLoginTB,
            };
            FCon.Controls.Add(Tb);
        }
        private void CreatePassLabel()
        {
            lab = new Label()
            {
                Name = "PassLabel",
                Text = "Пароль сервера: ",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locPassLabel,
                AutoSize = true,
            };
            FCon.Controls.Add(lab);
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
            FCon.Controls.Add(mtb);
        }
        private void CreateBDLabel()
        {
            lab = new Label()
            {
                Name = "BDLabel",
                Text = "Источник данных: ",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locBDLabel,
                AutoSize = true,
            };
            FCon.Controls.Add(lab);
        }
        private void CreateBDCB()
        {
            cb = new ComboBox()
            {
                Name = "BDCB",
                Text = "",
                Font = DefFont,
                Visible = true,
                Enabled = false,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locBDCB,
                Size = sizeBDCB,
                AutoCompleteMode = AutoCompleteMode.SuggestAppend,
                AutoCompleteSource = AutoCompleteSource.ListItems,
            };
            FCon.Controls.Add(cb);
        }
        
        private void CreateKeyLabel()
        {
            lab = new Label()
            {
                Name = "KeyLabel",
                Text = "Ключ активации: ",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locKeyLabel,
                AutoSize = true,
            };
            FCon.Controls.Add(lab);
        }
        private void CreateKeyTB()
        {
            mtb = new MaskedTextBox()
            {
                Name = "KeyTextBox",
                Text = "",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locKeyTb,
                Size = sizeKeyTb,
                Mask = "AAAA-AAAA-AAAA-AAAA",
            };
            //mtb.UseSystemPasswordChar = true;
            FCon.Controls.Add(mtb);
        }

        private void CreateConnectButton()
        {
            but = new Button()
            {
                Name = "ConnectButton",
                Text = "Подключиться",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locConnectBut,
                Size = sizeConnectBut,
            };
            FCon.Controls.Add(but);
        }
        private void CreateProvButton()
        {
            but = new Button()
            {
                Name = "ProvButton",
                Text = "Проверка",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locProvBut,
                Size = sizeProvBut,
                Enabled = false,
            };
            FCon.Controls.Add(but);
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
            FCon.Controls.Add(but);
        }
        private void CreateRefreshButton()
        {
            but = new Button()
            {
                Name = "RefreshButton",
                Text = "Обновить",
                Font = new Font("Microsoft Sans Serif", 7),
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locRefBut,
                Size = sizeRefBut,
            };
            FCon.Controls.Add(but);
        }
        private void CreateClearButton()
        {
            but = new Button()
            {
                Name = "ClearButton",
                Text = "Забыть данные о подключении",
                Font = new Font("Microsoft Sans Serif", 9),
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locCleBut,
                Size = sizeCleBut,
            };
            FCon.Controls.Add(but);
        }
    }
}
