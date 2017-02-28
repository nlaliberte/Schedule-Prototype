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
    public partial class PermitHomebyTeam : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string leagueID = (string)Session["leagueID"];
            string teamID = (string)Session["teamID"];

            Session["permityBy"] = "team";
            Session["fieldID"] = "-1";

            if(!Page.IsPostBack)
            {
                dd_team.DataBind();
                dd_team.SelectedValue = teamID;
            }

            string query = "SELECT CONVERT(VARCHAR(3),COUNT(1)) FROM dbo.permit WHERE home_team_id = " + teamID;
            lbl_numberofPermits.Text = SQLHelper.Exec_SQLScalarString(query);
            lbl_team.Text = dd_team.SelectedItem.Text + ": ";

            grd_permitDetail.DataBind();
            grd_permitDetail.Sort("permit_date", SortDirection.Ascending);
        }

        protected void dd_team_SelectedIndexChanged(object sender, EventArgs e)
        {
            string teamID =  dd_team.SelectedValue;
            Session["teamID"] = teamID;

            string query = "SELECT CONVERT(VARCHAR(3),COUNT(1)) FROM dbo.permit WHERE home_team_id = " + teamID;
            lbl_numberofPermits.Text = SQLHelper.Exec_SQLScalarString(query);
            lbl_team.Text = dd_team.SelectedItem.Text + ": ";

            grd_permitDetail.DataBind();
            grd_permitDetail.Sort("permit_date", SortDirection.Ascending);
        }

        protected void lnk_permitsAdd_Click(object sender, EventArgs e)
        {
            string teamID = dd_team.SelectedValue;
            Session["teamID"] = teamID;
            Session["permitBy"] = "team";
            Response.Redirect("PermitNew.aspx");
        }

        protected void grd_permitDetail_RowCommand(Object sender, GridViewCommandEventArgs e)
        {
            string leagueID = (string)Session["leagueID"];
            string teamID = (string)Session["teamID"];

            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = grd_permitDetail.Rows[index];
            string date = row.Cells[2].Text;
            string fieldName = row.Cells[5].Text;

            string query = "SELECT CONVERT(VARCHAR(3),p.permit_id) FROM dbo.permit p INNER JOIN dbo.team t ON p.home_team_id = t.team_id AND t.team_id = '" + teamID + "' INNER JOIN dbo.field f ON p.field_id = f.field_id AND f.field_name = '" + fieldName + "' WHERE CONVERT(DATE,p.permit_date) = CONVERT(DATE,'" + date + "')";
            string permitID = SQLHelper.Exec_SQLScalarString(query);

            Session["permitID"] = permitID;

            if (e.CommandName == "edit")
                Response.Redirect("PermitEdit.aspx");

            if (e.CommandName == "del")
            {
                query = "EXEC dbo.pr_permit_delete " + permitID;
                bool result = SQLHelper.Exec_SQLNonQuery(query);

                string script = "alert(\"The permit for " + fieldName + " on " + date + " has been Removed.\");";
                ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
            }
        }
    }
}