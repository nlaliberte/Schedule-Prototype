using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using Schedule.Library;


namespace Schedule
{
    public partial class FieldEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string fieldID = (string)Session["fieldID"];

            if (!Page.IsPostBack)
            {
                string query = "EXEC dbo.pr_field_get " + fieldID;
                DataTable fieldSource = SQLHelper.Exec_SQLReaderDataTable(query);
                foreach (DataRow row in fieldSource.Rows)
                {
                    txt_fieldName.Text = row["field_name"].ToString();
                    txt_addr1.Text = row["addr"].ToString();
                    txt_city.Text = row["city"].ToString();
                    txt_state.Text = row["state_code"].ToString();
                    txt_zip.Text = row["zip"].ToString();
                }
            }
        }

        protected void btn_cancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ManageField.aspx");
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            string fieldID = (string)Session["fieldID"];
            string query;
            bool result;

            if (fieldID != "-1")
            {
                query = "EXEC dbo.pr_field_update " + fieldID + ", '" + txt_fieldName.Text + "', '" + txt_addr1.Text + "', '" + txt_city.Text + "', '" + txt_state.Text + "', '" + txt_zip.Text + "'";
                result = SQLHelper.Exec_SQLNonQuery(query);
            }
            else
            {
                query = "EXEC dbo.pr_field_insert '" + txt_fieldName.Text + "', '" + txt_addr1.Text + "', '" + txt_city.Text + "', '" + txt_state.Text + "', '" + txt_zip.Text + "'";
                result = SQLHelper.Exec_SQLNonQuery(query);
            }

            if (!result)
            {
                string warning = "alert(\"Was not able to Insert/Update the Field. Is it possible a field by this name already exists?\");";
                ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", warning, true);
                return;
            }
            else
            {
                Response.Redirect("ManageField.aspx");
            }
        }

   
    }
}