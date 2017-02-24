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
    public partial class PermitHomebyField : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string leagueID = (string)Session["leagueID"];
            string fieldID = (string)Session["fieldID"];

            Session["teamID"] = "-1";
            Session["permitBy"] = "field";
            
            if(!Page.IsPostBack)
            {
                dd_field.DataBind();
                dd_field.SelectedValue = fieldID;
            }

            string query = "SELECT CONVERT(VARCHAR(3),COUNT(1)) FROM dbo.permit WHERE field_id = " + fieldID;
            lbl_numberofPermits.Text = SQLHelper.Exec_SQLScalarString(query);
            lbl_field.Text = dd_field.SelectedItem.Text + ": ";

            grd_permitDetail.DataBind();
            grd_permitDetail.Sort("permit_date", SortDirection.Ascending);
        }

        protected void dd_field_SelectedIndexChanged(object sender, EventArgs e)
        {
            string fieldID = dd_field.SelectedValue;
            Session["fieldID"] = fieldID;

            string query = "SELECT CONVERT(VARCHAR(3),COUNT(1)) FROM dbo.permit WHERE field_id = " + fieldID;
            lbl_numberofPermits.Text = SQLHelper.Exec_SQLScalarString(query);
            lbl_field.Text = dd_field.SelectedItem.Text + ": ";

            grd_permitDetail.DataBind();
            grd_permitDetail.Sort("permit_date", SortDirection.Ascending);
        }

        protected void lnk_permitsAdd_Click(object sender, EventArgs e)
        {
            string fieldID = dd_field.SelectedValue;
            Session["fieldID"] = fieldID;
            Session["permitBy"] = "field";
            Response.Redirect("PermitNew.aspx");
        }

        protected void grd_permitDetail_RowCommand(Object sender, GridViewCommandEventArgs e)
        {
            string leagueID = (string)Session["leagueID"];
            string fieldID = (string)Session["fieldID"];

            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = grd_permitDetail.Rows[index];
            string date = row.Cells[3].Text;
            string teamName = row.Cells[5].Text;

            string query = "SELECT CONVERT(VARCHAR(3),p.permit_id) FROM dbo.permit p INNER JOIN dbo.team t ON p.home_team_id = t.team_id AND t.team_name = '" + @teamName + "' WHERE CONVERT(DATE,p.permit_date) = CONVERT(DATE,'" + @date + "')";
            string permitID = SQLHelper.Exec_SQLScalarString(query);

            Session["permitID"] = permitID;

            if (e.CommandName == "Edit")
                Response.Redirect("PermitEdit.aspx");

            if (e.CommandName == "Del")
            {
                query = "EXEC dbo.pr_permit_delete " + permitID;
                bool result = SQLHelper.Exec_SQLNonQuery(query);

                string script = "alert(\"The permit for " + teamName + " on " + date + " has been Removed.\");";
                ScriptManager.RegisterStartupScript(this, GetType(),"ServerControlScript", script, true);
            }
        }


    }
}