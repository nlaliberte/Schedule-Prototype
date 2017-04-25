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

    public partial class ManageField : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["fieldID"] = "-1";
        }

        protected void grd_field_RowCommand(Object sender, GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = grd_field.Rows[index];
            string fieldName = row.Cells[3].Text;

            string query = "SELECT CONVERT(VARCHAR(3),field_id) FROM dbo.field WHERE field_name = '" + fieldName + "'";
            string fieldID = SQLHelper.Exec_SQLScalarString(query);
            Session["fieldID"] = fieldID;

            if (e.CommandName == "edit")
                Response.Redirect("FieldEdit.aspx");

            if (e.CommandName == "del")
            {
                query = "EXEC dbo.pr_field_delete " + fieldID;
                bool result = SQLHelper.Exec_SQLNonQuery(query);

                WarningHelper.Warning_Notification(fieldName + " has been Removed along with all it's associated Permits and Home Field records.", this);

                grd_field.DataBind();

                Session["fieldID"] = "-1";
            }
        }

    }
}