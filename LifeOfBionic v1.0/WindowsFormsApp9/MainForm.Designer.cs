namespace WindowsFormsApp9
{
    partial class MainForm
    {
        /// <summary>
        /// Обязательная переменная конструктора.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Освободить все используемые ресурсы.
        /// </summary>
        /// <param name="disposing">истинно, если управляемый ресурс должен быть удален; иначе ложно.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Код, автоматически созданный конструктором форм Windows

        /// <summary>
        /// Требуемый метод для поддержки конструктора — не изменяйте 
        /// содержимое этого метода с помощью редактора кода.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(MainForm));
            this.CaptionLabel = new System.Windows.Forms.Label();
            this.CaptionPanel = new System.Windows.Forms.Panel();
            this.ConnectionLabel = new System.Windows.Forms.LinkLabel();
            this.CaptionPicture = new System.Windows.Forms.PictureBox();
            this.MenuPanel = new System.Windows.Forms.Panel();
            this.LogOutLabel = new System.Windows.Forms.LinkLabel();
            this.linkLabel4 = new System.Windows.Forms.LinkLabel();
            this.linkLabel5 = new System.Windows.Forms.LinkLabel();
            this.linkLabel3 = new System.Windows.Forms.LinkLabel();
            this.linkLabel2 = new System.Windows.Forms.LinkLabel();
            this.linkLabel1 = new System.Windows.Forms.LinkLabel();
            this.LogInLabel = new System.Windows.Forms.LinkLabel();
            this.SignUpLabel = new System.Windows.Forms.LinkLabel();
            this.StatusPanel = new System.Windows.Forms.Panel();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.MainPanel = new System.Windows.Forms.Panel();
            this.DataPanel = new System.Windows.Forms.Panel();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.SearchPanel = new System.Windows.Forms.Panel();
            this.ButtonPrint = new System.Windows.Forms.Button();
            this.SearchComboBox = new System.Windows.Forms.ComboBox();
            this.SearchTextBox = new System.Windows.Forms.TextBox();
            this.ControlPanel = new System.Windows.Forms.Panel();
            this.DataGridPanel2 = new System.Windows.Forms.Panel();
            this.dataGridView2 = new System.Windows.Forms.DataGridView();
            this.ControlTopPanel = new System.Windows.Forms.Panel();
            this.timer1 = new System.Windows.Forms.Timer(this.components);
            this.CaptionPanel.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.CaptionPicture)).BeginInit();
            this.MenuPanel.SuspendLayout();
            this.StatusPanel.SuspendLayout();
            this.MainPanel.SuspendLayout();
            this.DataPanel.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            this.SearchPanel.SuspendLayout();
            this.ControlPanel.SuspendLayout();
            this.DataGridPanel2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView2)).BeginInit();
            this.SuspendLayout();
            // 
            // CaptionLabel
            // 
            this.CaptionLabel.AutoSize = true;
            this.CaptionLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 15.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.CaptionLabel.Location = new System.Drawing.Point(69, 24);
            this.CaptionLabel.Name = "CaptionLabel";
            this.CaptionLabel.Size = new System.Drawing.Size(167, 25);
            this.CaptionLabel.TabIndex = 0;
            this.CaptionLabel.Text = "Medicine For All";
            // 
            // CaptionPanel
            // 
            this.CaptionPanel.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.CaptionPanel.Controls.Add(this.ConnectionLabel);
            this.CaptionPanel.Controls.Add(this.CaptionLabel);
            this.CaptionPanel.Controls.Add(this.CaptionPicture);
            this.CaptionPanel.Dock = System.Windows.Forms.DockStyle.Top;
            this.CaptionPanel.Location = new System.Drawing.Point(0, 0);
            this.CaptionPanel.Name = "CaptionPanel";
            this.CaptionPanel.Size = new System.Drawing.Size(922, 74);
            this.CaptionPanel.TabIndex = 2;
            // 
            // ConnectionLabel
            // 
            this.ConnectionLabel.AutoSize = true;
            this.ConnectionLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.ConnectionLabel.Location = new System.Drawing.Point(780, 46);
            this.ConnectionLabel.Name = "ConnectionLabel";
            this.ConnectionLabel.Size = new System.Drawing.Size(134, 16);
            this.ConnectionLabel.TabIndex = 4;
            this.ConnectionLabel.TabStop = true;
            this.ConnectionLabel.Text = "Подключиться к БД";
            this.ConnectionLabel.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(this.linkLabel2_LinkClicked_1);
            // 
            // CaptionPicture
            // 
            this.CaptionPicture.Image = global::WindowsFormsApp9.Properties.Resources.Medic;
            this.CaptionPicture.Location = new System.Drawing.Point(12, 12);
            this.CaptionPicture.Name = "CaptionPicture";
            this.CaptionPicture.Size = new System.Drawing.Size(50, 50);
            this.CaptionPicture.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.CaptionPicture.TabIndex = 1;
            this.CaptionPicture.TabStop = false;
            // 
            // MenuPanel
            // 
            this.MenuPanel.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.MenuPanel.Controls.Add(this.LogOutLabel);
            this.MenuPanel.Controls.Add(this.linkLabel4);
            this.MenuPanel.Controls.Add(this.linkLabel5);
            this.MenuPanel.Controls.Add(this.linkLabel3);
            this.MenuPanel.Controls.Add(this.linkLabel2);
            this.MenuPanel.Controls.Add(this.linkLabel1);
            this.MenuPanel.Controls.Add(this.LogInLabel);
            this.MenuPanel.Controls.Add(this.SignUpLabel);
            this.MenuPanel.Dock = System.Windows.Forms.DockStyle.Top;
            this.MenuPanel.Location = new System.Drawing.Point(0, 74);
            this.MenuPanel.Name = "MenuPanel";
            this.MenuPanel.Size = new System.Drawing.Size(922, 48);
            this.MenuPanel.TabIndex = 3;
            // 
            // LogOutLabel
            // 
            this.LogOutLabel.AutoSize = true;
            this.LogOutLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.LogOutLabel.Location = new System.Drawing.Point(861, 23);
            this.LogOutLabel.Name = "LogOutLabel";
            this.LogOutLabel.Size = new System.Drawing.Size(48, 16);
            this.LogOutLabel.TabIndex = 7;
            this.LogOutLabel.TabStop = true;
            this.LogOutLabel.Text = "Выход";
            this.LogOutLabel.Visible = false;
            this.LogOutLabel.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(this.LogOutLabel_LinkClicked);
            // 
            // linkLabel4
            // 
            this.linkLabel4.AutoSize = true;
            this.linkLabel4.Enabled = false;
            this.linkLabel4.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.linkLabel4.LinkColor = System.Drawing.Color.FromArgb(((int)(((byte)(90)))), ((int)(((byte)(90)))), ((int)(((byte)(90)))));
            this.linkLabel4.Location = new System.Drawing.Point(298, 15);
            this.linkLabel4.Name = "linkLabel4";
            this.linkLabel4.Size = new System.Drawing.Size(200, 16);
            this.linkLabel4.TabIndex = 7;
            this.linkLabel4.TabStop = true;
            this.linkLabel4.Text = "Терапевтическое отделение";
            this.linkLabel4.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(this.linkLabel4_LinkClicked);
            // 
            // linkLabel5
            // 
            this.linkLabel5.AutoSize = true;
            this.linkLabel5.Enabled = false;
            this.linkLabel5.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.linkLabel5.LinkColor = System.Drawing.Color.FromArgb(((int)(((byte)(90)))), ((int)(((byte)(90)))), ((int)(((byte)(90)))));
            this.linkLabel5.Location = new System.Drawing.Point(504, 15);
            this.linkLabel5.Name = "linkLabel5";
            this.linkLabel5.Size = new System.Drawing.Size(184, 16);
            this.linkLabel5.TabIndex = 5;
            this.linkLabel5.TabStop = true;
            this.linkLabel5.Text = "Административная панель";
            this.linkLabel5.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(this.linkLabel5_LinkClicked);
            // 
            // linkLabel3
            // 
            this.linkLabel3.AutoSize = true;
            this.linkLabel3.Enabled = false;
            this.linkLabel3.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.linkLabel3.LinkColor = System.Drawing.Color.FromArgb(((int)(((byte)(90)))), ((int)(((byte)(90)))), ((int)(((byte)(90)))));
            this.linkLabel3.Location = new System.Drawing.Point(244, 15);
            this.linkLabel3.Name = "linkLabel3";
            this.linkLabel3.Size = new System.Drawing.Size(48, 16);
            this.linkLabel3.TabIndex = 4;
            this.linkLabel3.TabStop = true;
            this.linkLabel3.Text = "Склад";
            this.linkLabel3.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(this.linkLabel3_LinkClicked);
            // 
            // linkLabel2
            // 
            this.linkLabel2.AutoSize = true;
            this.linkLabel2.Enabled = false;
            this.linkLabel2.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.linkLabel2.LinkColor = System.Drawing.Color.FromArgb(((int)(((byte)(90)))), ((int)(((byte)(90)))), ((int)(((byte)(90)))));
            this.linkLabel2.Location = new System.Drawing.Point(133, 15);
            this.linkLabel2.Name = "linkLabel2";
            this.linkLabel2.Size = new System.Drawing.Size(105, 16);
            this.linkLabel2.TabIndex = 3;
            this.linkLabel2.TabStop = true;
            this.linkLabel2.Text = "Карта лечения";
            this.linkLabel2.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(this.linkLabel2_LinkClicked_2);
            // 
            // linkLabel1
            // 
            this.linkLabel1.AutoSize = true;
            this.linkLabel1.Enabled = false;
            this.linkLabel1.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.linkLabel1.LinkColor = System.Drawing.Color.FromArgb(((int)(((byte)(90)))), ((int)(((byte)(90)))), ((int)(((byte)(90)))));
            this.linkLabel1.Location = new System.Drawing.Point(9, 15);
            this.linkLabel1.Name = "linkLabel1";
            this.linkLabel1.Size = new System.Drawing.Size(118, 16);
            this.linkLabel1.TabIndex = 2;
            this.linkLabel1.TabStop = true;
            this.linkLabel1.Text = "Запись на приём";
            this.linkLabel1.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(this.linkLabel1_LinkClicked);
            // 
            // LogInLabel
            // 
            this.LogInLabel.AutoSize = true;
            this.LogInLabel.Enabled = false;
            this.LogInLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.LogInLabel.Location = new System.Drawing.Point(777, 23);
            this.LogInLabel.Name = "LogInLabel";
            this.LogInLabel.Size = new System.Drawing.Size(39, 16);
            this.LogInLabel.TabIndex = 1;
            this.LogInLabel.TabStop = true;
            this.LogInLabel.Text = "Вход";
            this.LogInLabel.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(this.AutorizLabelClick);
            // 
            // SignUpLabel
            // 
            this.SignUpLabel.AutoSize = true;
            this.SignUpLabel.Enabled = false;
            this.SignUpLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.SignUpLabel.Location = new System.Drawing.Point(822, 23);
            this.SignUpLabel.Name = "SignUpLabel";
            this.SignUpLabel.Size = new System.Drawing.Size(92, 16);
            this.SignUpLabel.TabIndex = 0;
            this.SignUpLabel.TabStop = true;
            this.SignUpLabel.Text = "Регистрация";
            this.SignUpLabel.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(this.SignUpLabel_LinkClicked);
            // 
            // StatusPanel
            // 
            this.StatusPanel.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.StatusPanel.Controls.Add(this.label1);
            this.StatusPanel.Controls.Add(this.label2);
            this.StatusPanel.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.StatusPanel.Location = new System.Drawing.Point(0, 579);
            this.StatusPanel.Name = "StatusPanel";
            this.StatusPanel.Size = new System.Drawing.Size(922, 32);
            this.StatusPanel.TabIndex = 4;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(446, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(35, 13);
            this.label1.TabIndex = 1;
            this.label1.Text = "label1";
            this.label1.Visible = false;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(800, 9);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(113, 13);
            this.label2.TabIndex = 0;
            this.label2.Text = "2018 - 2019 LifeBionic";
            // 
            // MainPanel
            // 
            this.MainPanel.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.MainPanel.Controls.Add(this.DataPanel);
            this.MainPanel.Controls.Add(this.SearchPanel);
            this.MainPanel.Dock = System.Windows.Forms.DockStyle.Fill;
            this.MainPanel.Location = new System.Drawing.Point(0, 122);
            this.MainPanel.Name = "MainPanel";
            this.MainPanel.Size = new System.Drawing.Size(922, 457);
            this.MainPanel.TabIndex = 5;
            // 
            // DataPanel
            // 
            this.DataPanel.Controls.Add(this.dataGridView1);
            this.DataPanel.Dock = System.Windows.Forms.DockStyle.Left;
            this.DataPanel.Location = new System.Drawing.Point(0, 48);
            this.DataPanel.Name = "DataPanel";
            this.DataPanel.Size = new System.Drawing.Size(545, 407);
            this.DataPanel.TabIndex = 2;
            // 
            // dataGridView1
            // 
            this.dataGridView1.AllowUserToAddRows = false;
            this.dataGridView1.AllowUserToDeleteRows = false;
            this.dataGridView1.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.DisplayedCells;
            this.dataGridView1.BackgroundColor = System.Drawing.SystemColors.Control;
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dataGridView1.Location = new System.Drawing.Point(0, 0);
            this.dataGridView1.MultiSelect = false;
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.ReadOnly = true;
            this.dataGridView1.Size = new System.Drawing.Size(545, 407);
            this.dataGridView1.TabIndex = 0;
            this.dataGridView1.Click += new System.EventHandler(this.dataGridView1_Click);
            // 
            // SearchPanel
            // 
            this.SearchPanel.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.SearchPanel.Controls.Add(this.ButtonPrint);
            this.SearchPanel.Controls.Add(this.SearchComboBox);
            this.SearchPanel.Controls.Add(this.SearchTextBox);
            this.SearchPanel.Dock = System.Windows.Forms.DockStyle.Top;
            this.SearchPanel.Location = new System.Drawing.Point(0, 0);
            this.SearchPanel.Name = "SearchPanel";
            this.SearchPanel.Size = new System.Drawing.Size(920, 48);
            this.SearchPanel.TabIndex = 1;
            this.SearchPanel.Visible = false;
            // 
            // ButtonPrint
            // 
            this.ButtonPrint.Location = new System.Drawing.Point(334, 13);
            this.ButtonPrint.Name = "ButtonPrint";
            this.ButtonPrint.Size = new System.Drawing.Size(109, 23);
            this.ButtonPrint.TabIndex = 3;
            this.ButtonPrint.Text = "Печать талона";
            this.ButtonPrint.UseVisualStyleBackColor = true;
            this.ButtonPrint.Visible = false;
            // 
            // SearchComboBox
            // 
            this.SearchComboBox.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.SuggestAppend;
            this.SearchComboBox.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.SearchComboBox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.SearchComboBox.FormattingEnabled = true;
            this.SearchComboBox.Location = new System.Drawing.Point(195, 14);
            this.SearchComboBox.Name = "SearchComboBox";
            this.SearchComboBox.Size = new System.Drawing.Size(133, 21);
            this.SearchComboBox.TabIndex = 2;
            this.SearchComboBox.SelectedIndexChanged += new System.EventHandler(this.SearchComboBox_SelectedIndexChanged);
            // 
            // SearchTextBox
            // 
            this.SearchTextBox.ForeColor = System.Drawing.Color.Gray;
            this.SearchTextBox.Location = new System.Drawing.Point(10, 14);
            this.SearchTextBox.MaxLength = 100;
            this.SearchTextBox.Name = "SearchTextBox";
            this.SearchTextBox.Size = new System.Drawing.Size(179, 20);
            this.SearchTextBox.TabIndex = 0;
            this.SearchTextBox.Text = "Поиск";
            this.SearchTextBox.TextChanged += new System.EventHandler(this.SearchTextBox_TextChanged);
            this.SearchTextBox.Enter += new System.EventHandler(this.SearchTextBox_Enter);
            this.SearchTextBox.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.SearchTextBox_KeyPress);
            this.SearchTextBox.Leave += new System.EventHandler(this.SearchTextBox_Leave);
            // 
            // ControlPanel
            // 
            this.ControlPanel.BackColor = System.Drawing.SystemColors.Control;
            this.ControlPanel.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.ControlPanel.Controls.Add(this.DataGridPanel2);
            this.ControlPanel.Controls.Add(this.ControlTopPanel);
            this.ControlPanel.Dock = System.Windows.Forms.DockStyle.Right;
            this.ControlPanel.Location = new System.Drawing.Point(546, 122);
            this.ControlPanel.Name = "ControlPanel";
            this.ControlPanel.Size = new System.Drawing.Size(376, 457);
            this.ControlPanel.TabIndex = 6;
            this.ControlPanel.Visible = false;
            // 
            // DataGridPanel2
            // 
            this.DataGridPanel2.Controls.Add(this.dataGridView2);
            this.DataGridPanel2.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.DataGridPanel2.Location = new System.Drawing.Point(0, 252);
            this.DataGridPanel2.Name = "DataGridPanel2";
            this.DataGridPanel2.Size = new System.Drawing.Size(374, 203);
            this.DataGridPanel2.TabIndex = 4;
            this.DataGridPanel2.Visible = false;
            // 
            // dataGridView2
            // 
            this.dataGridView2.AllowUserToAddRows = false;
            this.dataGridView2.AllowUserToDeleteRows = false;
            this.dataGridView2.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.DisplayedCells;
            this.dataGridView2.BackgroundColor = System.Drawing.SystemColors.Control;
            this.dataGridView2.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dataGridView2.Location = new System.Drawing.Point(0, 0);
            this.dataGridView2.MultiSelect = false;
            this.dataGridView2.Name = "dataGridView2";
            this.dataGridView2.ReadOnly = true;
            this.dataGridView2.Size = new System.Drawing.Size(374, 203);
            this.dataGridView2.TabIndex = 0;
            this.dataGridView2.Click += new System.EventHandler(this.dataGridView2_Click);
            // 
            // ControlTopPanel
            // 
            this.ControlTopPanel.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.ControlTopPanel.Dock = System.Windows.Forms.DockStyle.Top;
            this.ControlTopPanel.Location = new System.Drawing.Point(0, 0);
            this.ControlTopPanel.Name = "ControlTopPanel";
            this.ControlTopPanel.Size = new System.Drawing.Size(374, 48);
            this.ControlTopPanel.TabIndex = 3;
            this.ControlTopPanel.Visible = false;
            // 
            // timer1
            // 
            this.timer1.Interval = 1000;
            this.timer1.Tick += new System.EventHandler(this.timer1_Tick);
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(922, 611);
            this.Controls.Add(this.ControlPanel);
            this.Controls.Add(this.MainPanel);
            this.Controls.Add(this.StatusPanel);
            this.Controls.Add(this.MenuPanel);
            this.Controls.Add(this.CaptionPanel);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.KeyPreview = true;
            this.MaximizeBox = false;
            this.Name = "MainForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "MedicineForAll";
            this.Activated += new System.EventHandler(this.Form1_Activated);
            this.Shown += new System.EventHandler(this.Form1_Shown);
            this.KeyDown += new System.Windows.Forms.KeyEventHandler(this.MainForm_KeyDown);
            this.CaptionPanel.ResumeLayout(false);
            this.CaptionPanel.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.CaptionPicture)).EndInit();
            this.MenuPanel.ResumeLayout(false);
            this.MenuPanel.PerformLayout();
            this.StatusPanel.ResumeLayout(false);
            this.StatusPanel.PerformLayout();
            this.MainPanel.ResumeLayout(false);
            this.DataPanel.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            this.SearchPanel.ResumeLayout(false);
            this.SearchPanel.PerformLayout();
            this.ControlPanel.ResumeLayout(false);
            this.DataGridPanel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView2)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Label CaptionLabel;
        private System.Windows.Forms.PictureBox CaptionPicture;
        private System.Windows.Forms.Panel CaptionPanel;
        private System.Windows.Forms.Panel MenuPanel;
        private System.Windows.Forms.LinkLabel linkLabel1;
        private System.Windows.Forms.LinkLabel LogInLabel;
        private System.Windows.Forms.LinkLabel SignUpLabel;
        private System.Windows.Forms.Panel StatusPanel;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Panel MainPanel;
        private System.Windows.Forms.Panel ControlPanel;
        private System.Windows.Forms.LinkLabel linkLabel4;
        private System.Windows.Forms.LinkLabel linkLabel5;
        private System.Windows.Forms.LinkLabel linkLabel3;
        private System.Windows.Forms.LinkLabel linkLabel2;
        private System.Windows.Forms.TextBox SearchTextBox;
        private System.Windows.Forms.ComboBox SearchComboBox;
        private System.Windows.Forms.Button ButtonPrint;
        private System.Windows.Forms.LinkLabel LogOutLabel;
        private System.Windows.Forms.Panel ControlTopPanel;
        private System.Windows.Forms.Panel DataGridPanel2;
        private System.Windows.Forms.DataGridView dataGridView2;
        public System.Windows.Forms.LinkLabel ConnectionLabel;
        public System.Windows.Forms.Timer timer1;
        private System.Windows.Forms.Panel DataPanel;
        private System.Windows.Forms.DataGridView dataGridView1;
        public System.Windows.Forms.Panel SearchPanel;
        private System.Windows.Forms.Label label1;
    }
}

