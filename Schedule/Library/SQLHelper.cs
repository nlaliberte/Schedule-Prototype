using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace Schedule.Library
{
    public static class SQLHelper
    {

        public static bool Exec_SQLNonQuery(string query)
        {
            string CS = ConfigurationManager.ConnectionStrings["ScheduleConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.CommandTimeout = 1200;
                con.Open();
                try
                {
                    cmd.ExecuteNonQuery();
                    return true;
                }
                catch 
                { 
                    return false; 
                }
                finally 
                { 
                    cmd.Dispose();
                    con.Close();
                }
                
            }
        }

        public static string Exec_SQLScalarString(string query)
        {
            string result;

            string CS = ConfigurationManager.ConnectionStrings["ScheduleConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.CommandTimeout = 1200;
                con.Open();
                result = (string)cmd.ExecuteScalar();
                cmd.Dispose();
                con.Close();
            }

            return result;
        }

        public static int Exec_SQLScalarInt(string query)
        {
            int result;

            string CS = ConfigurationManager.ConnectionStrings["ScheduleConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.CommandTimeout = 1200;
                con.Open();
                result = (int)cmd.ExecuteScalar();
                cmd.Dispose();
                con.Close();
            }

            return result;
        }

        public static void Exec_SQLExcelExport(DataTable dt, System.Web.UI.Page page, string filename)
        {
            string attach = "attachment;filename=" + filename + ".xls";

            page.Response.ClearContent();
            page.Response.AddHeader("content-disposition", attach);
            page.Response.ContentType = "application/ms-excel";

            if (dt != null)
            {
                foreach (DataColumn dc in dt.Columns)
                {
                    page.Response.Write(dc.ColumnName + "\t");
                    //sep=";";
                }
                page.Response.Write(System.Environment.NewLine);
                foreach (DataRow dr in dt.Rows)
                {
                    for (int i = 0; i < dt.Columns.Count; i++)
                    {
                        page.Response.Write(dr[i].ToString() + "\t");
                    }
                    page.Response.Write("\n");
                }
            }

            page.Response.Flush();
            page.Response.SuppressContent = true;
            HttpContext.Current.ApplicationInstance.CompleteRequest();

            return;
        }

        public static DataTable Exec_SQLReaderDataTable(string query)
        {
            DataTable result = new DataTable();

            string CS = ConfigurationManager.ConnectionStrings["ScheduleConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlDataAdapter sda = new SqlDataAdapter(query, con);
                con.Open();
                sda.Fill(result);
                sda.Dispose();
                con.Close();
            }

            return result;
        }

    }
}