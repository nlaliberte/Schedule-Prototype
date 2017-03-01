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
    public partial class ManageContact : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["contactID"] = "-1";
        }

        protected void grd_contact_RowCommand(Object sender, GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = grd_contact.Rows[index];
            string contactFirstName = row.Cells[3].Text;
            string contactLastName = row.Cells[4].Text;

            string query = "SELECT CONVERT(VARCHAR(3),contact_id) FROM dbo.contact WHERE first_name = '" + contactFirstName + "' AND last_name = '" + contactLastName + "'";
            string contactID = SQLHelper.Exec_SQLScalarString(query);
            Session["contactID"] = contactID;

            if (e.CommandName == "edit")
                Response.Redirect("ContactEdit.aspx");

            if (e.CommandName == "del")
            {
                query = "EXEC dbo.pr_contact_delete " + contactID;
                bool result = SQLHelper.Exec_SQLNonQuery(query);

                string script = "alert(\"" + contactFirstName + " " + contactLastName + " has been Removed.\");";
                ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);

                grd_contact.DataBind();

                Session["ContactID"] = "-1";
            }
        }
    }
}