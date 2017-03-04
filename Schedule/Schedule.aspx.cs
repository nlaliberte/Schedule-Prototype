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
    public partial class Schedule : System.Web.UI.Page
    {     

        protected void Page_Load(object sender, EventArgs e)
        { 
            if (!Page.IsPostBack)
            {
                txt_numSchedule.Text = "10";

                string leagueID = (string)Session["leagueID"];
                string stgID = (string)Session["stgID"];

                string query = "SELECT CONVERT(VARCHAR(3),MIN(t.team_id)) FROM dbo.team t INNER JOIN dbo.conference c ON t.conference_id = c.conference_id AND c.league_id = " + leagueID;
                string teamID = SQLHelper.Exec_SQLScalarString(query);

                Session["teamID"] = teamID;

                ddl_team.SelectedValue = (string)Session["teamID"];

                lbl_stgID.Text = "Schedule ID: " + stgID + " (Currently Selected)";

                nullScheduleWarnings(stgID);
            }
        }

        protected void nullScheduleWarnings(string stgID)
        {
            string leagueID = (string)Session["leagueID"];

            string query = "SELECT ISNULL(COUNT(DISTINCT stg_id),0) FROM dbo.stg_stats WHERE league_id = " + leagueID;
            int stgCount = SQLHelper.Exec_SQLScalarInt(query);

            query = "SELECT CASE WHEN MAX(stg_id) IS NULL THEN 0 ELSE 1 END FROM dbo.matchup WHERE league_id = " + leagueID;
            int stgChosenCount = SQLHelper.Exec_SQLScalarInt(query);

            if(stgID == "-1")
            {
                lbl_noChosenSchedule.Visible = true;
                pnl_scheduleChosen.Visible = false;
             
            }
            else
            {
                lbl_noChosenSchedule.Visible = false;
                pnl_scheduleChosen.Visible = true;
            }

            if(stgCount - stgChosenCount <= 0)
            {
                lbl_noPotentialSchedule.Visible = true;
                pnl_schedulePotential.Visible = false;
            }
            else
            {
                lbl_noPotentialSchedule.Visible = false;
                pnl_schedulePotential.Visible = true;
            }

        }


        protected void grd_schedule_RowCommand(Object sender, GridViewCommandEventArgs e)
        {
            string leagueID = (string)Session["leagueID"];

            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = grd_schedule.Rows[index];
            string stgID = row.Cells[3].Text;
            string query;

            if (e.CommandName == "select")
            {
                Session["stgID"] = stgID;

                query = "EXEC dbo.sch_stg_select " + leagueID + ", " + stgID;
                bool result = SQLHelper.Exec_SQLNonQuery(query);

                grd_scheduleChosen.DataBind();
                grd_schedule.DataBind();

                lbl_stgID.Text = "Schedule ID: " + stgID;
                grd_scheduleByTeam.DataBind();

                nullScheduleWarnings(stgID);
            }

            if(e.CommandName == "preview")
            {
                Session["stgID"] = stgID;
                lbl_stgID.Text = "Schedule ID: " + stgID;
                grd_scheduleByTeam.DataBind();
                Response.Redirect("Schedule.aspx" + "#preview", false);
            }

            if(e.CommandName == "del")
            {
                query = "EXEC dbo.sch_stg_delete " + leagueID + ", " + stgID;
                bool result = SQLHelper.Exec_SQLNonQuery(query);

                WarningHelper.Warning_Notification("Potential Schedule ID: " + stgID + " has been Removed.", this);

                grd_schedule.DataBind();

                nullScheduleWarnings((string)Session["stgID"]);
            }
    
        }

        protected void btn_createSchedule_Click(object sender, EventArgs e)
        {
            string leagueID = (string)Session["leagueID"];
            string numSchedule = txt_numSchedule.Text;
            string stgID = (string)Session["stgID"];
            string query;
            Page page = (Page)HttpContext.Current.Handler;

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

                WarningHelper.Warning_Notification("Please enter a valid number between 1 and 10.", this);
            }
            else
            {
                txt_numSchedule.BackColor = System.Drawing.Color.White;

                query = "EXEC dbo.run_schedule_stg " + leagueID + ", " + numSchedule + ", 0";
                bool result = SQLHelper.Exec_SQLNonQuery(query);

                WarningHelper.Warning_Notification(numSchedule + " Schedule(s) Created!", this);

                grd_schedule.DataBind();
            }

            nullScheduleWarnings(stgID);
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
            string stgID = row.Cells[2].Text;

            if(e.CommandName == "preview")
            {
                Session["stgID"] = stgID;
                lbl_stgID.Text = "Schedule ID: " + stgID + " (Currently Selected)";
                grd_scheduleByTeam.DataBind();
                Response.Redirect("Schedule.aspx" + "#preview", false);
            }

            if(e.CommandName == "export")
            {
                DataTable dt = new DataTable();

                string CS = ConfigurationManager.ConnectionStrings["ScheduleConnectionString"].ConnectionString;
                using (SqlConnection con = new SqlConnection(CS))
                {
                    SqlDataAdapter sda = new SqlDataAdapter("EXEC dbo.sch_stg_export " + leagueID + ", " + stgID, con);
                    con.Open();
                    sda.Fill(dt);
                    sda.Dispose();
                    con.Close();
                }

                Page page = (Page)HttpContext.Current.Handler;

                string filename;
                int exportCount = (int)Session["exportCount"];

                if (exportCount == 1)
                {
                    filename = "Schedule";
                }
                else
                {
                    filename = "Schedule(" + exportCount + ")";
                }                

                SQLHelper.Exec_SQLExcelExport(dt, page, filename);

                Session["exportCount"] = exportCount + 1;
                
            }

        }

    }
}