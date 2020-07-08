using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApp9
{
    static class DB
    {
        public static bool LogIn = false;

        public static bool LastWrite = false;
        public static bool LastLogDel = false;
        public static bool LastGet = false;
        public static bool LastUpd = false;
        public static bool LastFunk = false;

        public static DataTable GetData(string ProcName, SqlParameter[] SP)
        {
            try
            {
                SqlConnection sql = new SqlConnection(DataBaseConfiguration.connectString);
                sql.Open();
                SqlCommand GetData = new SqlCommand(ProcName, sql);
                GetData.CommandType = CommandType.StoredProcedure;
                for (int i = 0; i < SP.Length; i++)
                {
                    GetData.Parameters.Add(SP[i]);
                }
                DataTable DT = new DataTable();
                SqlDataReader DR = GetData.ExecuteReader();
                DT.Load(DR);
                sql.Close();

                LastGet = true;
                return DT;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                LastGet = false;
                return null;
            }
        }
        public static int WriteData(string ProcName, SqlParameter[] SP)
        {
            try
            {
                SqlConnection sql = new SqlConnection(DataBaseConfiguration.connectString);
                sql.Open();
                SqlCommand AddCitizen = new SqlCommand(ProcName, sql);
                AddCitizen.CommandType = CommandType.StoredProcedure;
                for (int i = 0; i < SP.Length; i++)
                {
                    AddCitizen.Parameters.Add(SP[i]);
                }
                var id = AddCitizen.ExecuteNonQuery();
                sql.Close();

                LastWrite = true;
                return (int)id;
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());

                LastWrite = false;
                return -10;
            }
        }
        //public static void DelData(int id)
        //{
            
        //}
        public static void LogDelData(string ProcName, SqlParameter[] SP)
        {
            try
            {
                SqlConnection sql = new SqlConnection(DataBaseConfiguration.connectString);
                sql.Open();
                SqlCommand UpdData = new SqlCommand(ProcName, sql);
                UpdData.CommandType = CommandType.StoredProcedure;
                for (int i = 0; i < SP.Length; i++)
                {
                    UpdData.Parameters.Add(SP[i]);
                }            
                UpdData.ExecuteNonQuery();
                sql.Close();

                LastLogDel = true;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
                LastLogDel = false;
            }
        }
        public static void UpdData(string ProcName, SqlParameter[] SP)
        {
            try
            {
                SqlConnection sql = new SqlConnection(DataBaseConfiguration.connectString);
                sql.Open();
                SqlCommand UpdData = new SqlCommand(ProcName, sql);
                UpdData.CommandType = CommandType.StoredProcedure;
                for (int i = 0; i < SP.Length; i++)
                {
                    UpdData.Parameters.Add(SP[i]);
                }
                UpdData.ExecuteNonQuery();
                sql.Close();

                LastUpd = true;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
                LastUpd = false;
            }
        }
        public static DataTable Funk(string FunkName, object[] vs)
        {
            DataTable DT = new DataTable();
            SqlConnection sql = new SqlConnection(DataBaseConfiguration.connectString);
            string query = string.Format("SELECT dbo." + FunkName, vs[0]);
            SqlCommand cmd = new SqlCommand(query, sql);
            try
            {
                sql.Open();
                SqlDataReader DR = cmd.ExecuteReader();
                DT.Load(DR);
                sql.Close();



                LastFunk = true;
                return DT;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
                LastFunk = false;
                return null;
            }

        }
    }
}
