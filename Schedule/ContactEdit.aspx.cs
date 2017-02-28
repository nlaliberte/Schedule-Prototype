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
    public partial class ContactEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string contactID = (string)Session["contactID"];

            if(!Page.IsPostBack)
            {
                string query = "EXEC dbo.pr_contact_get " + contactID;
                DataTable contactSource = SQLHelper.Exec_SQLReaderDataTable(query);
                foreach (DataRow row in contactSource.Rows)
                {
                    txt_firstName.Text = row["first_name"].ToString();
                    txt_lastName.Text = row["last_name"].ToString();
                    txt_phone.Text = row["phone"].ToString();
                    txt_email.Text = row["email"].ToString();
                }
            }
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            string contactID = (string)Session["contactID"];
            string query;
            bool result;

            string phone = txt_phone.Text;
            string email = txt_email.Text;

            if(contactID != "-1")
            {
                query = "EXEC dbo.pr_contact_update " + (string)Session["contactID"] + ", '" + txt_firstName.Text + "', '" + txt_lastName.Text + "', '" + phone + "', '" + email + "'";
                result = SQLHelper.Exec_SQLNonQuery(query);
            }
            else
            {
                query = "SELECT CONVERT(VARCHAR(3),MAX(contact_id) + 1) FROM dbo.contact";
                contactID = SQLHelper.Exec_SQLScalarString(query);

                query = "EXEC dbo.pr_contact_insert " + contactID + ", " + (string)Session["leagueID"] + ", '" + txt_firstName.Text + "', '" + txt_lastName.Text + "', '" + phone + "', '" + email + "'";
                result = SQLHelper.Exec_SQLNonQuery(query);
            }

            if (!result)
            {
                string warning = "alert(\"Was not able to Insert/Update the Contact. Is it possible a contact by this name already exists?\");";
                ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", warning, true);
                return;
            }
            else
            {
                Response.Redirect("ManageContact.aspx");
            }
            
        }

        protected void btn_cancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ManageContact.aspx");
        }



    }
}