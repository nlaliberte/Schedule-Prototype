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
    public partial class LeagueHome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string leagueID = (string)Session["leagueID"];
            string query;
  
            if (!Page.IsPostBack)
            {
                Session["teamID"] = "-1";

                query = "EXEC dbo.pr_league_get " + leagueID;
                DataTable leagueSource = SQLHelper.Exec_SQLReaderDataTable(query);
                foreach (DataRow row in leagueSource.Rows)
                {
                    lbl_leagueName.Text = row["league_name"].ToString();
                    lbl_numberTeams.Text = row["number_of_teams"].ToString();
                    lbl_numberGames.Text = row["number_of_games"].ToString();
                    lbl_numberPermits.Text = row["number_of_permits"].ToString();
                    lbl_minimumPermits.Text = "(" + row["minimum_number_of_permits"].ToString() +" permits required)";
                    lbl_numberConferences.Text = row["number_of_conferences"].ToString();
                    lbl_numberConferenceGames.Text = row["number_of_games_in_conference"].ToString();
                    lbl_PrimaryContact.Text = row["primary_contact"].ToString();
                    lbl_PrimaryContactPhone.Text = row["primary_contact_phone"].ToString();
                    lbl_PrimaryContactEmail.Text = row["primary_contact_email"].ToString();
                    lbl_secondaryContact.Text = row["secondary_contact"].ToString();
                    lbl_secondaryContactPhone.Text = row["secondary_contact_phone"].ToString();
                    lbl_secondaryContactEmail.Text = row["secondary_contact_email"].ToString();
                }
            }
           
        }

        protected void btn_editLeague_Click(object sender, EventArgs e)
        {
            Response.Redirect("LeagueEdit.aspx");
        }


        protected void grd_team_RowCommand(Object sender, GridViewCommandEventArgs e)
        {
            string leagueID = (string)Session["leagueID"];

            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = grd_team.Rows[index];
            string team_name = row.Cells[1].Text;

            string query = "SELECT CONVERT(VARCHAR(3),team_id) FROM dbo.team WHERE team_name = '" + team_name + "'";
            string team_id = SQLHelper.Exec_SQLScalarString(query);
            Session["teamID"] = team_id;

            if (e.CommandName == "Permits")
            {
                Session["permitBy"] = "team";
                Response.Redirect("PermitHomeByTeam.aspx");
            }

            if (e.CommandName == "Edit")
                Response.Redirect("TeamEdit.aspx");

            if (e.CommandName == "Del")
            {
                query = "EXEC dbo.pr_team_delete " + team_id;
                bool result = SQLHelper.Exec_SQLNonQuery(query);

                string script = "alert(\"" + team_name + "has been Removed.\");";
                ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);

                grd_team.DataBind();
            }
        }

        protected void btn_managePermits_Click(object sender, EventArgs e)
        {
            string fieldID = (string)Session["fieldID"];
            string leagueID = (string)Session["leagueID"];

            string query = "SELECT CONVERT(VARCHAR(3),MIN(field_id)) FROM dbo.field";
            Session["fieldID"] = SQLHelper.Exec_SQLScalarString(query);

            query = "SELECT CONVERT(VARCHAR(3),MIN(t.team_id)) FROM dbo.team t INNER JOIN dbo.conference c ON t.conference_id = c.conference_id AND c.league_id = " + leagueID;
            Session["teamID"] = SQLHelper.Exec_SQLScalarString(query);

            Response.Redirect("PermitHomebyField.aspx");
        }

        protected void btn_manageSchedule_Click(object sender, EventArgs e)
        {
            string leagueID = (string)Session["leagueID"];

            string query = "SELECT CONVERT(VARCHAR(3),ISNULL((SELECT MAX(stg_id) FROM matchup WHERE league_id = " + leagueID + "),-1))";
            Session["stgID"] = SQLHelper.Exec_SQLScalarString(query);

            Response.Redirect("Schedule.aspx");
        }


        protected void btn_manageFields_Click(object sender, EventArgs e)
        {
            Response.Redirect("ManageField.aspx");
        }

        protected void btn_manageContacts_Click(object sender, EventArgs e)
        {
            Response.Redirect("ManageContact.aspx");
        }



    }
}