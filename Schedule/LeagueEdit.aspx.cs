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
    public partial class LeagueEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string leagueID = (string)Session["leagueID"];

            if (!Page.IsPostBack)
            {
                string CS = ConfigurationManager.ConnectionStrings["ScheduleConnectionString"].ConnectionString;
                using (SqlConnection con = new SqlConnection(CS))
                {
                    SqlCommand cmd = new SqlCommand("EXEC dbo.pr_contact_dropdown " + leagueID, con);
                    con.Open();
                    dd_primaryContact.DataSource = cmd.ExecuteReader();
                    dd_primaryContact.DataTextField = "contact_name";
                    dd_primaryContact.DataValueField = "contact_id";
                    dd_primaryContact.DataBind();
                    con.Close();

                    con.Open();
                    dd_secondaryContact.DataSource = cmd.ExecuteReader();
                    dd_secondaryContact.DataTextField = "contact_name";
                    dd_secondaryContact.DataValueField = "contact_id";
                    dd_secondaryContact.DataBind();
                    cmd.Dispose();
                    con.Close();

                    cmd.CommandText = "EXEC dbo.pr_league_get " + leagueID;
                    con.Open();
                    SqlDataReader leagueSource = cmd.ExecuteReader();
                    while (leagueSource.Read())
                    {
                        txt_leagueName.Text = (string)leagueSource.GetValue(1);
                        txt_numberGames.Text = (string)leagueSource.GetValue(3).ToString();
                        txt_numberConferences.Text = (string)leagueSource.GetValue(6).ToString();
                        txt_numberConferenceGames.Text = (string)leagueSource.GetValue(7).ToString();
                        dd_primaryContact.SelectedValue = (string)leagueSource.GetValue(8).ToString();
                        dd_secondaryContact.SelectedValue = (string)leagueSource.GetValue(12).ToString();
                    }
                    leagueSource.Close();
                    cmd.Dispose();
                    con.Close();
                }
            }
        }

        protected void btn_cancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("LeagueHome.aspx");
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            string leagueID = (string)Session["leagueID"];
            string leagueName = txt_leagueName.Text;
            int numberTeams;
            string numberConferences = txt_numberConferences.Text;
            string numberGames = txt_numberGames.Text;
            string numberConferenceGames = txt_numberConferenceGames.Text;
            string primaryContact = dd_primaryContact.SelectedValue;
            string secondaryContact = dd_secondaryContact.SelectedValue;

            string CS = ConfigurationManager.ConnectionStrings["ScheduleConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlCommand cmd = new SqlCommand("SELECT COUNT(1) FROM dbo.team t INNER JOIN dbo.conference c ON t.conference_id = c.conference_id AND c.league_id = " + leagueID, con);
                con.Open();
                numberTeams = (int)cmd.ExecuteScalar();
                cmd.Dispose();
                con.Close();                    
                    
                con.Open();
                cmd.CommandText = "EXEC dbo.pr_league_update " + leagueID + ", '" + leagueName + "', " + numberTeams + ", " + numberGames + ", " + numberConferences + ", " + numberConferenceGames + ", " + primaryContact + ", " + secondaryContact;
                cmd.ExecuteNonQuery();
                cmd.Dispose();
                con.Close();                
            }

            Response.Redirect("LeagueHome.aspx");
        }
    }
}