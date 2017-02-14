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
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                Session["leagueID"] = -1;

                string leagueID;
                string primaryContact;
                string secondaryContact;

                string CS = ConfigurationManager.ConnectionStrings["ScheduleConnectionString"].ConnectionString;
                using (SqlConnection con = new SqlConnection(CS))
                {
                    SqlCommand cmd = new SqlCommand("SELECT league_id = CONVERT(VARCHAR(3),MIN(league_id)) FROM dbo.league", con);
                    con.Open();
                    leagueID = (string)cmd.ExecuteScalar();
                    con.Close();

                    con.Open();
                    cmd.CommandText = "SELECT primary_contact = c.first_name + ' ' + ISNULL(c.last_name,'') FROM dbo.league l LEFT JOIN dbo.contact c ON l.primary_contact_id = c.contact_id WHERE l.league_id =" + leagueID;
                    primaryContact = (string)cmd.ExecuteScalar();
                    con.Close();

                    con.Open();
                    cmd.CommandText = "SELECT secondary_contact = c.first_name + ' ' + ISNULL(c.last_name,'') FROM dbo.league l LEFT JOIN dbo.contact c ON l.secondary_contact_id = c.contact_id WHERE l.league_id =" + leagueID;
                    secondaryContact = (string)cmd.ExecuteScalar();
                    con.Close();
                }


                dd_league.SelectedValue = leagueID;
                lbl_primaryContactValue.Text = primaryContact;
                lbl_secondaryContactValue.Text = secondaryContact;
            }
        }

        protected void dd_league_SelectedIndexChanged(object sender, EventArgs e)
        {
            string leagueID = dd_league.SelectedValue;
            string primaryContact;
            string secondaryContact;

            string CS = ConfigurationManager.ConnectionStrings["ScheduleConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlCommand cmd = new SqlCommand("SELECT primary_contact = c.first_name + ' ' + ISNULL(c.last_name,'') FROM dbo.league l LEFT JOIN dbo.contact c ON l.primary_contact_id = c.contact_id WHERE l.league_id =" + leagueID, con);
                con.Open();
                primaryContact = (string)cmd.ExecuteScalar();
                con.Close();

                cmd.CommandText = "SELECT secondary_contact = c.first_name + ' ' + ISNULL(c.last_name,'') FROM dbo.league l LEFT JOIN dbo.contact c ON l.secondary_contact_id = c.contact_id WHERE l.league_id =" + leagueID;
                con.Open();
                secondaryContact = (string)cmd.ExecuteScalar();
                cmd.Dispose();
                con.Close();
            }

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