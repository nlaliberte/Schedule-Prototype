using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace Schedule
{
    public partial class LeagueHome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string leagueID = (string)Session["leagueID"];

            Session["teamID"] = "-1";

            string CS = ConfigurationManager.ConnectionStrings["ScheduleConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlCommand cmd = new SqlCommand("EXEC dbo.pr_league_get " + leagueID, con);
                con.Open();
                SqlDataReader leagueSource = cmd.ExecuteReader();
                while (leagueSource.Read())
                {
                    lbl_leagueName.Text = (string)leagueSource.GetValue(1);
                    lbl_numberTeams.Text = (string)leagueSource.GetValue(2).ToString();
                    lbl_numberGames.Text = (string)leagueSource.GetValue(3).ToString();
                    lbl_numberPermits.Text = (string)leagueSource.GetValue(4).ToString();
                    lbl_minimumPermits.Text = "(" + (string)leagueSource.GetValue(5).ToString() + " permits required)";
                    lbl_numberConferences.Text = (string)leagueSource.GetValue(6).ToString();
                    lbl_numberConferenceGames.Text = (string)leagueSource.GetValue(7).ToString();
                    lbl_PrimaryContact.Text = (string)leagueSource.GetValue(9);
                    lbl_PrimaryContactPhone.Text = (string)leagueSource.GetValue(10).ToString();
                    lbl_PrimaryContactEmail.Text = (string)leagueSource.GetValue(11);
                    lbl_secondaryContact.Text = (string)leagueSource.GetValue(13);
                    lbl_secondaryContactPhone.Text = (string)leagueSource.GetValue(14).ToString();
                    lbl_secondaryContactEmail.Text = (string)leagueSource.GetValue(15);
                }
                leagueSource.Close();
                cmd.Dispose();
                con.Close();

            }

           
        }

        protected void btn_editLeague_Click(object sender, EventArgs e)
        {
            Response.Redirect("LeagueEdit.aspx");
        }

        //protected void grd_team_EditButtonClick(object sender, EventArgs e, GridViewCommandEventArgs c)
        //{
        //    int indexID = (int)c.CommandArgument;

        //    GridViewRow row = grd_team.Rows[indexID];

        //    string teamID = row.Cells[0].Text;

        //    Session["teamID"] = teamID;

        //    Response.Redirect("TeamEdit.aspx");
        //}

        protected void grd_team_RowCommand(Object sender, GridViewCommandEventArgs e)
        {
            string leagueID = (string)Session["leagueID"];

            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = grd_team.Rows[index];
            string team_name = row.Cells[1].Text;
            string team_id;

            string CS = ConfigurationManager.ConnectionStrings["ScheduleConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlCommand cmd = new SqlCommand("SELECT CONVERT(VARCHAR(3),team_id) FROM dbo.team WHERE team_name = '" + team_name + "'", con);
                con.Open();
                team_id = (string)cmd.ExecuteScalar();
                cmd.Dispose();
                con.Close();
            }

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
                using (SqlConnection con = new SqlConnection(CS))
                {
                    SqlCommand cmd = new SqlCommand("EXEC dbo.pr_team_delete " + team_id, con);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    cmd.Dispose();
                    con.Close();

                    string script = "alert(\"" + team_name + "has been Removed.\");";
                    ScriptManager.RegisterStartupScript(this, GetType(),
                                      "ServerControlScript", script, true);
                }

                grd_team.DataBind();
            }
        }

        protected void btn_managePermits_Click(object sender, EventArgs e)
        {
            string fieldID = (string)Session["fieldID"];
            string leagueID = (string)Session["leagueID"];

            string CS = ConfigurationManager.ConnectionStrings["ScheduleConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlCommand cmd = new SqlCommand("SELECT CONVERT(VARCHAR(3),MIN(field_id)) FROM dbo.field", con);
                con.Open();
                Session["fieldID"] = cmd.ExecuteScalar();
                cmd.Dispose();
                con.Close();

                cmd.CommandText = "SELECT CONVERT(VARCHAR(3),MIN(t.team_id)) FROM dbo.team t INNER JOIN dbo.conference c ON t.conference_id = c.conference_id AND c.league_id = " + leagueID;
                con.Open();
                Session["teamID"] = cmd.ExecuteScalar();
                cmd.Dispose();
                con.Close();
            }

            Response.Redirect("PermitHomebyField.aspx");
        }

        protected void btn_manageSchedule_Click(object sender, EventArgs e)
        {
            string leagueID = (string)Session["leagueID"];

            string CS = ConfigurationManager.ConnectionStrings["ScheduleConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlCommand cmd = new SqlCommand("SELECT CONVERT(VARCHAR(3),(SELECT MAX(stg_id) FROM matchup WHERE league_id = " + leagueID + "))", con);
                con.Open();
                Session["stgID"] = cmd.ExecuteScalar();
                cmd.Dispose();
                con.Close();
            }
            
            Response.Redirect("Schedule.aspx");
        }






    }
}