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
    class MedicamentsForm
    {
        private Form FMedic = new Form();
        private Label lab = new Label();
        private TextBox Tb = new TextBox();
        private MaskedTextBox mtb = new MaskedTextBox();
        private Button but = new Button();
        private ComboBox cb = new ComboBox();

        private Font DefFont = new Font("Microsoft Sans Serif", 10);
        private Color DefBackColor = Color.FromName("Control");
        private Color DefTextColor = Color.FromName("ControlText");

        //Позиции                                               //позиции
        private Point locNameLabel = new Point(20, 10);         //label название лекарства
        private Point locNameTB = new Point(20, 33);            //textBox название лекарства

        private Point locCategoryLabel = new Point(220, 10);     //label категории лекарств
        private Point locCategoryCB = new Point(220, 33);        //ComboBox  категории лекарств

        private Point locManufLabel = new Point(130, 63);        //label выбора производителя
        private Point locManufCB = new Point(130, 86);           //ComboBox  выбора производителя

        private Point locNewManufLabel = new Point(20, 116);     //label создания производителя
        private Point locNewManufTB = new Point(20, 149);        //textBox создания производителя

        private Point locMailLabel = new Point(220, 116);         //label Почта
        private Point locMailTB = new Point(220, 149);            //textBox Почта

        private Point locAddressLabel = new Point(20, 179);      //label  Адрес
        private Point locAddressTB = new Point(20, 202);         //textBox Адрес


        private Point locNewMaufBut = new Point(220, 200);      //кнопка добавления производителя
        private Point locMedicBut = new Point(60, 240);         //кнопка добавления медикаментов
        private Point locCanBut = new Point(230, 240);          //кнопка отмены

        //размеры                                               //размеры
        private Size sizeNameTB = new Size(150, 20);            //textBox название лекарства
        private Size sizeCategoryCB = new Size(150, 20);        //ComboBox категории лекарств
        private Size sizeManufCB = new Size(150, 20);           //ComboBox выбора производителя
        private Size sizeNewManufTB = new Size(150, 20);        //textBox создания производителя
        private Size sizeMailTB = new Size(150, 20);            //textBox Почта
        private Size sizeAddressTB = new Size(150, 20);         //textBox Адрес

        private Size sizeNewMaufBut = new Size(100, 28);        //кнопка добавления производителя
        private Size sizeMedicBut = new Size(100, 30);          //кнопка добавления медикаментов
        private Size sizeCanBut = new Size(100, 30);            //кнопка отмены

        public MedicamentsForm()
        {

        }

        public void NewMedicamentsForm()
        {
            CreateNameLabel();
            CreateNameTB();
            CreateCategoryLabel();
            CreateCategoryCB();
            CreateManufLabel();
            CreateManufCB();
            CreateNewManufLabel();
            CreateNewManufTB();
            CreateMailLabel();
            CreateMailTB();
            CreateAddressLabel();
            CreateAddressTB();
            CreateNewMaufButton();
            CreateMedicButton();
            CreateCancelButton();

            FMedic.Text = "Добавление медикамента";
            FMedic.Size = new Size(405, 325);
            FMedic.FormBorderStyle = FormBorderStyle.FixedSingle;
            FMedic.MaximizeBox = false;
            FMedic.StartPosition = FormStartPosition.CenterScreen;

            FMedic.FormClosing += new FormClosingEventHandler(FormClosing);
            FMedic.Controls["CancelButton"].Click += new EventHandler(CancelButtonClick);
            FMedic.Controls["NewMaufButton"].Click += new EventHandler(NewManufButtonClick);
            FMedic.Controls["MedicButton"].Click += new EventHandler(ApplayButtonClick);

            FMedic.Show();
        }
        //закрытие формы
        private void FormClosing(object sender, EventArgs e)
        {
            Application.OpenForms[0].Enabled = true;
        }
        //кнопка отмены
        private void CancelButtonClick(object sender, EventArgs e)
        {
            DialogResult DR = MessageBox.Show("Вы уверены что хотите отменить создание?\n" +
                "Все веденные данные будут потеряны.", "Закрыть?", MessageBoxButtons.YesNo);
            if (DR == DialogResult.Yes)
                FMedic.Close();
        }
        //кнопка добавить производителя
        private void NewManufButtonClick(object sender, EventArgs e)
        {
            SqlConnection sql = new SqlConnection(DataBaseConfiguration.connectString);
            sql.Open();
            SqlCommand AddManuf = new SqlCommand("Add_Manufacturer", sql);
            AddManuf.CommandType = CommandType.StoredProcedure;
            AddManuf.Parameters.AddWithValue("@N_Manufacturer", (FMedic.Controls["NewManufTextBox"] as TextBox).Text);
            AddManuf.Parameters.AddWithValue("@Adress", (FMedic.Controls["AddressTextBox"] as TextBox).Text);
            AddManuf.Parameters.AddWithValue("@Mail", (FMedic.Controls["MailTextBox"] as TextBox).Text);
            AddManuf.Parameters.AddWithValue("@Manufacturer_Logical_Delete", false);
            AddManuf.ExecuteNonQuery();
            sql.Close();
        }
        //кнопка создать лекарство
        private void ApplayButtonClick(object sender, EventArgs e)
        {
            SqlConnection sql = new SqlConnection(DataBaseConfiguration.connectString);
            sql.Open();
            SqlCommand AddMedi = new SqlCommand("Add_Medicamen]", sql);
            AddMedi.CommandType = CommandType.StoredProcedure;
            AddMedi.Parameters.AddWithValue("@Name_Medicament", (FMedic.Controls["NameTextBox"] as TextBox).Text);
            //AddMedi.Parameters.AddWithValue("@id_Manufacturer", );
            //AddMedi.Parameters.AddWithValue("@id_CategoryOfMedicament", );
            AddMedi.Parameters.AddWithValue("@Medicament_Logical_Delete", false);
            AddMedi.ExecuteNonQuery();
            sql.Close();
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
            FMedic.Controls.Add(lab);
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
            };
            FMedic.Controls.Add(Tb);
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
            FMedic.Controls.Add(lab);
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
            };
            FMedic.Controls.Add(cb);
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
            FMedic.Controls.Add(lab);
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
            };
            FMedic.Controls.Add(cb);
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
            FMedic.Controls.Add(lab);
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
            };
            FMedic.Controls.Add(Tb);
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
            FMedic.Controls.Add(lab);
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
            };
            FMedic.Controls.Add(Tb);
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
            FMedic.Controls.Add(lab);
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
            };
            FMedic.Controls.Add(Tb);
        }
        private void CreateNewMaufButton()
        {
            but = new Button()
            {
                Name = "NewMaufButton",
                Text = "Создать",
                Font = DefFont,
                Visible = true,
                BackColor = DefBackColor,
                ForeColor = DefTextColor,
                Location = locNewMaufBut,
                Size = sizeNewMaufBut,
            };
            FMedic.Controls.Add(but);
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
            FMedic.Controls.Add(but);
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
            FMedic.Controls.Add(but);
        }
    }
}
