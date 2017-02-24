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
    public partial class LeagueEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string leagueID = (string)Session["leagueID"];
            string query;

            if (!Page.IsPostBack)
            {

                query = "EXEC dbo.pr_contact_dropdown " + leagueID;
                dd_primaryContact.DataSource = SQLHelper.Exec_SQLReaderDataTable(query);
                dd_primaryContact.DataTextField = "contact_name";
                dd_primaryContact.DataValueField = "contact_id";
                dd_primaryContact.DataBind();

                dd_secondaryContact.DataSource = SQLHelper.Exec_SQLReaderDataTable(query);
                dd_secondaryContact.DataTextField = "contact_name";
                dd_secondaryContact.DataValueField = "contact_id";
                dd_secondaryContact.DataBind();

                query = "EXEC dbo.pr_league_get " + leagueID;
                DataTable leagueSource = SQLHelper.Exec_SQLReaderDataTable(query);
                foreach (DataRow row in leagueSource.Rows)
                {
                    txt_leagueName.Text = row["league_name"].ToString();
                    txt_numberGames.Text = row["number_of_games"].ToString();
                    txt_numberConferences.Text = row["number_of_conferences"].ToString();
                    txt_numberConferenceGames.Text = row["number_of_games_in_conference"].ToString();
                    dd_primaryContact.SelectedValue = row["primary_contact_id"].ToString();
                    dd_secondaryContact.SelectedValue = row["secondary_contact_id"].ToString();
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
            string numberConferences = txt_numberConferences.Text;
            string numberGames = txt_numberGames.Text;
            string numberConferenceGames = txt_numberConferenceGames.Text;
            string primaryContact = dd_primaryContact.SelectedValue;
            string secondaryContact = dd_secondaryContact.SelectedValue;

            string query = "SELECT COUNT(1) FROM dbo.team t INNER JOIN dbo.conference c ON t.conference_id = c.conference_id AND c.league_id = " + leagueID;
            int numberTeams = SQLHelper.Exec_SQLScalarInt(query);

            query = "EXEC dbo.pr_league_update " + leagueID + ", '" + leagueName + "', " + numberTeams + ", " + numberGames + ", " + numberConferences + ", " + numberConferenceGames + ", " + primaryContact + ", " + secondaryContact;
            bool result = SQLHelper.Exec_SQLNonQuery(query);

            Response.Redirect("LeagueHome.aspx");
        }
    }
}