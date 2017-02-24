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

    public partial class Default : System.Web.UI.Page
    {
   

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                Session["leagueID"] = -1;

                string query = "SELECT league_id = CONVERT(VARCHAR(3),MIN(league_id)) FROM dbo.league";
                string leagueID = SQLHelper.Exec_SQLScalarString(query);

                query = "SELECT primary_contact = c.first_name + ' ' + ISNULL(c.last_name,'') FROM dbo.league l LEFT JOIN dbo.contact c ON l.primary_contact_id = c.contact_id WHERE l.league_id =" + leagueID;
                string primaryContact = SQLHelper.Exec_SQLScalarString(query);

                query = "SELECT secondary_contact = c.first_name + ' ' + ISNULL(c.last_name,'') FROM dbo.league l LEFT JOIN dbo.contact c ON l.secondary_contact_id = c.contact_id WHERE l.league_id =" + leagueID;
                string secondaryContact = SQLHelper.Exec_SQLScalarString(query);

                dd_league.SelectedValue = leagueID;
                lbl_primaryContactValue.Text = primaryContact;
                lbl_secondaryContactValue.Text = secondaryContact;
            }
        }

        protected void dd_league_SelectedIndexChanged(object sender, EventArgs e)
        {
            string leagueID = dd_league.SelectedValue;

            string query = "SELECT primary_contact = c.first_name + ' ' + ISNULL(c.last_name,'') FROM dbo.league l LEFT JOIN dbo.contact c ON l.primary_contact_id = c.contact_id WHERE l.league_id =" + leagueID;
            string primaryContact = SQLHelper.Exec_SQLScalarString(query);

            query = "SELECT secondary_contact = c.first_name + ' ' + ISNULL(c.last_name,'') FROM dbo.league l LEFT JOIN dbo.contact c ON l.secondary_contact_id = c.contact_id WHERE l.league_id =" + leagueID;
            string secondaryContact = SQLHelper.Exec_SQLScalarString(query);

            lbl_primaryContactValue.Text = primaryContact;
            lbl_secondaryContactValue.Text = secondaryContact;
        }

        protected void btn_manage_Click(object sender, EventArgs e)
        {
            Session["leagueID"] = dd_league.SelectedValue;
            Response.Redirect("LeagueHome.aspx");
        }
    }
}