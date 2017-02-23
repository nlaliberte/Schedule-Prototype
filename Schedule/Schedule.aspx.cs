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
    public partial class Schedule : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        { 
            if (!Page.IsPostBack)
            {
                txt_numSchedule.Text = "10";

                string leagueID = (string)Session["leagueID"];
                string stgID = (string)Session["stgID"];

                string CS = ConfigurationManager.ConnectionStrings["ScheduleConnectionString"].ConnectionString;
                using (SqlConnection con = new SqlConnection(CS))
                {
                    SqlCommand cmd = new SqlCommand("SELECT CONVERT(VARCHAR(3),MIN(t.team_id)) FROM dbo.team t INNER JOIN dbo.conference c ON t.conference_id = c.conference_id AND c.league_id = " + leagueID, con);
                    con.Open();
                    Session["teamID"] = cmd.ExecuteScalar();
                    cmd.Dispose();
                    con.Close();
                }

                ddl_team.SelectedValue = (string)Session["teamID"];

                lbl_stgID.Text = "Schedule ID: " + stgID + " (Currently Selected)";
                
            }
        }

        protected void grd_schedule_RowCommand(Object sender, GridViewCommandEventArgs e)
        {
            string leagueID = (string)Session["leagueID"];

            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = grd_schedule.Rows[index];
            string stgID = row.Cells[3].Text;

            if (e.CommandName == "select")
            {
                Session["stgID"] = stgID;

                string CS = ConfigurationManager.ConnectionStrings["ScheduleConnectionString"].ConnectionString;
                using (SqlConnection con = new SqlConnection(CS))
                {
                    SqlCommand cmd = new SqlCommand("EXEC dbo.sch_stg_select " + leagueID + ", " + stgID, con);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    cmd.Dispose();
                    con.Close();
                }

                grd_scheduleChosen.DataBind();
                grd_schedule.DataBind();

                lbl_stgID.Text = "Schedule ID: " + stgID + " (Currently Selected)";
                grd_scheduleByTeam.DataBind();
            }

            if(e.CommandName == "preview")
            {
                Session["stgID"] = stgID;
                lbl_stgID.Text = "Schedule ID: " + stgID;
                grd_scheduleByTeam.DataBind();
                Response.Redirect("Schedule.aspx" + "#preview", false);
            }

            
        }

        protected void btn_createSchedule_Click(object sender, EventArgs e)
        {
            string leagueID = (string)Session["leagueID"];
            string numSchedule = txt_numSchedule.Text;

            if (
                    numSchedule != "1" 
                    & numSchedule != "2"
                    & numSchedule != "3"
                    & numSchedule != "4"
                    & numSchedule != "5"
                    & numSchedule != "6"
                    & numSchedule != "7"
                    & numSchedule != "8"
                    & numSchedule != "9"
                    & numSchedule != "10"
                )
            {
                txt_numSchedule.BackColor = System.Drawing.Color.LightPink;

                string script = "alert(\"Please enter a valid number between 1 and 10\");";
                ScriptManager.RegisterStartupScript(this, GetType(),
                                      "ServerControlScript", script, true);
            }
            else
            {
                txt_numSchedule.BackColor = System.Drawing.Color.White;
                
                string CS = ConfigurationManager.ConnectionStrings["ScheduleConnectionString"].ConnectionString;
                using (SqlConnection con = new SqlConnection(CS))
                {
                    SqlCommand cmd = new SqlCommand("EXEC dbo.run_schedule_stg " + leagueID + ", " + numSchedule + ", 0", con);
                    cmd.CommandTimeout = 1200;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    cmd.Dispose();
                    con.Close();
                }

                string script = "alert(\"" + numSchedule + " Schedule(s) Created!\");";
                ScriptManager.RegisterStartupScript(this, GetType(),
                                      "ServerControlScript", script, true);

                grd_schedule.DataBind();
            }
        }

        protected void ddl_team_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["teamID"] = ddl_team.SelectedValue;
            grd_scheduleByTeam.DataBind();
        }

        protected void grd_scheduleChosen_RowCommand(Object sender, GridViewCommandEventArgs e)
        {
            string leagueID = (string)Session["leagueID"];

            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = grd_scheduleChosen.Rows[index];
            string stgID = row.Cells[1].Text;

            if(e.CommandName == "preview")
            {
                Session["stgID"] = stgID;
                lbl_stgID.Text = "Schedule ID: " + stgID + " (Currently Selected)";
                grd_scheduleByTeam.DataBind();
                Response.Redirect("Schedule.aspx" + "#preview", false);
            }
        }


    }
}