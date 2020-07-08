using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApp9
{
    class DataBaseConfiguration
    {
        public static string cds = @"ANTON\AGAVRILOCHEV", cui = "Anton", cpw = "12345678As", baseName = "Life_of_Bionic";
        public static bool connect = false;
        public static int iden = 0;
        public static string key = "";

        private delegate void DeleAddCB(ComboBox CB, DataTable text, Button But);
        private delegate void DeleEnd();

        //запрос строки подключения
        public static string connectString
        {
            get
            {
                return  "Data Source = " + cds +
                "; Initial Catalog =" + baseName + ";" +
                " User ID = " + cui + "; Password = \"" + cpw + "\"";                 
            }
        }

        //проверка подключения
        public static void CheckCon()
        {
            try
            {
                SqlConnection sql = new SqlConnection(connectString);
                sql.Open();
                sql.Close();
                connect = true;
                
                Application.OpenForms[0].BeginInvoke(new DeleEnd(EndCheckCon));
            }
            catch
            {
                MessageBox.Show("Возникла проблема соединения с базой данных.\nПожалуйста обратитесь к администратору");
                cds = "";
                cui = "";
                cpw = "";
                baseName = "";
                connect = false;
                MainForm.shifLogin = "";

                Application.OpenForms[0].BeginInvoke(new DeleEnd(EndCheckCon));
            }
        }
        private static void EndCheckCon()
        {
            if (connect)
                MainForm.t = 5;
            else
            {
                (Application.OpenForms[0] as MainForm).timer1.Enabled = false;
                (Application.OpenForms[0] as MainForm).ConnectionLabel.Enabled = true;
                (Application.OpenForms[0] as MainForm).Form1_Activated((Application.OpenForms[0] as MainForm), new EventArgs());
            }
        }

        //поиск серверов
        public static void searchServers(Form sender, ComboBox CB, Button But)
        {
            SqlDataSourceEnumerator instance = SqlDataSourceEnumerator.Instance;
            DataTable table = instance.GetDataSources();
            try
            {
                (sender as Form).BeginInvoke(new DeleAddCB(AddCB), CB, table, But);
                connect = true;
            }
            catch { }
        }
        private static void AddCB(ComboBox CB, DataTable text, Button But)
        {
            try
            {
                CB.Items.Clear();
                foreach (DataRow r in text.Rows)
                {
                    CB.Items.Add(r[0] + @"\" + r[1]);
                }
                CB.Text = "";
                CB.Enabled = true;
                CB.SelectedIndex = 0;
                But.Enabled = true;
            }
            catch { }
        }
        
        //поиск баз данных
        public static void SearchBases(Form sender, ComboBox CB, Button But, string cds, string cui, string cpw)
        {
            DataBaseConfiguration.cds = cds;
            DataBaseConfiguration.cui = cui;
            DataBaseConfiguration.cpw = cpw;

            DataTable table = new DataTable();
            SqlConnection sql = new SqlConnection("Data Source = " + cds +
                "; Initial Catalog =master;" +
                " User ID = " + cui + "; Password = \"" + cpw + "\"");
            try
            {
                SqlCommand command = new SqlCommand("select name from sys.databases " +
                    "where name not in ('master','tempdb','model','msdb')", sql);
                sql.Open();
                table.Load(command.ExecuteReader());
            }
            catch (SqlException ex)
            {
                MessageBox.Show("\n" + DateTime.Now.ToLongDateString() + ex.Message);
            }
            finally
            {
                sql.Close();
            }
            try
            {
                (sender as Form).BeginInvoke(new DeleAddCB(addItemsCB), CB, table, But);
            }
            catch { }
        }
        private static void addItemsCB(ComboBox CB, DataTable text, Button But)
        {
            CB.Items.Clear();
            try
            {
                foreach (DataRow r in text.Rows)
                {
                    CB.Items.Add(r[0]);
                }
                CB.Text = "";
                CB.Enabled = true;
                CB.SelectedIndex = 0;
                But.Enabled = true;
            }
            catch { }
        }
    }
}
