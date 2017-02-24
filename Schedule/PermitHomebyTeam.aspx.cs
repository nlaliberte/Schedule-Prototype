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

            if (!Page.IsPostBack)
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

        protected void dd_field_SelectedIndexChanged(object sender, EventArgs e)
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
    }
}