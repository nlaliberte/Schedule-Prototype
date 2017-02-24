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
    public partial class TeamEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string teamID = (string)Session["teamID"];
            string leagueID = (string)Session["leagueID"];

            if (!Page.IsPostBack)
            {
                if (teamID == "-1")
                {
                    txt_leagueName.Text = "";
                    dd_primaryContact.SelectedValue = "-1";
                    dd_secondaryContact.SelectedValue = "-1";
                }
                else
                {
                    string query = "EXEC dbo.pr_team_get " + teamID;
                    DataTable teamResults = SQLHelper.Exec_SQLReaderDataTable(query);
                    foreach (DataRow row in teamResults.Rows)
                    {
                        txt_leagueName.Text = row["team_name"].ToString();
                        dd_conference.SelectedValue = row["conference_id"].ToString();
                        dd_primaryContact.SelectedValue = row["contact_id"].ToString();
                        dd_secondaryContact.SelectedValue = row["contact_id2"].ToString();
                    }
                }

                if(grd_HomeField.Rows.Count == 0)
                {
                    lbl_homeField.Text = "No Home Fields Exist! (Please add a Home Field)";
                }

                if(grd_offDay.Rows.Count == 0)
                {
                    lbl_dayOff.Text = "No Days off Requested.";
                }

            }



        }

        protected void btn_cancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("LeagueHome.aspx");
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            string teamID = (string)Session["teamID"];
            string teamName = txt_leagueName.Text;
            string conferenceID = dd_conference.SelectedValue;
            string primaryContactID = dd_primaryContact.SelectedValue;
            string secondaryContactID = dd_secondaryContact.SelectedValue;
            string query;
            bool result;

            if (teamID == "-1")
            {
                //insert new team
                query = "EXEC dbo.pr_team_insert '" + teamName + "', " + conferenceID + ", " + primaryContactID + ", " + secondaryContactID;
                result = SQLHelper.Exec_SQLNonQuery(query);

                query = "SELECT CONVERT(VARCHAR(3),MAX(team_id) + 1) FROM dbo.team WHERE team_name = '" + teamName + "'";
                teamID = SQLHelper.Exec_SQLScalarString(query);

                string script = "alert(\"" + teamName + " has been Added!\");";
                ScriptManager.RegisterStartupScript(this, GetType(),"ServerControlScript", script, true);
            }
            else
            {
                query = "EXEC dbo.pr_team_update " + teamID + ", '" + teamName + "', " + conferenceID + ", " + primaryContactID + ", " + secondaryContactID;
                result = SQLHelper.Exec_SQLNonQuery(query);

                string script = "alert(\"Team Updated!\");";
                ScriptManager.RegisterStartupScript(this, GetType(),"ServerControlScript", script, true);
            }

            Session["teamID"] = teamID;
        }

        protected void grd_homeField_RowCommand(Object sender, GridViewCommandEventArgs e)
        {
            string teamID = (string)Session["teamID"];
            string leagueID = (string)Session["leagueID"];

            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = grd_HomeField.Rows[index];
            string fieldName = row.Cells[3].Text;

            string query = "SELECT field_id FROM dbo.field WHERE field_name = '" + fieldName + "'";
            int fieldID = SQLHelper.Exec_SQLScalarInt(query);

            query = "EXEC dbo.pr_home_field_delete " + teamID + ", " + fieldID;
            bool result = SQLHelper.Exec_SQLNonQuery(query);

            grd_HomeField.DataBind();
            dd_field.DataBind();

            if (grd_HomeField.Rows.Count == 0)
            {
                lbl_homeField.Text = "No Home Fields Exist! (Please add a Home Field)";
            }
        }

        protected void btn_addField_Click(object sender, EventArgs e)
        {
            string teamID = (string)Session["teamID"];
            string leagueID = (string)Session["leagueID"];
            string fieldID = dd_field.SelectedValue;

            string query = "EXEC dbo.pr_home_field_insert " + teamID + ", " + fieldID;
            bool result = SQLHelper.Exec_SQLNonQuery(query);

            lbl_homeField.Text = "";
            grd_HomeField.DataBind();
            dd_field.DataBind();
        }

        protected void grd_offDay_RowCommand(Object sender, GridViewCommandEventArgs e)
        {
            string teamID = (string)Session["teamID"];

            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = grd_offDay.Rows[index];
            string offDay = row.Cells[1].Text;

            if (e.CommandName == "remove")
            {
                string query = "EXEC dbo.pr_off_day_delete " + teamID + ", '" + offDay + "'";
                bool result = SQLHelper.Exec_SQLNonQuery(query);
            }

            grd_offDay.DataBind();
            
            if (grd_offDay.Rows.Count == 0)
            {
                lbl_dayOff.Text = "No Days off Requested.";
            }
        }

        protected bool db_InsertNewOffDay(string teamID, string offDay)
        {
            string query = "EXEC dbo.pr_off_day_insert " + teamID + ", '" + offDay + "'";
            bool result = SQLHelper.Exec_SQLNonQuery(query);

            return result;
        }

        protected void btn_addOffDay_Click(object sender, EventArgs e)
        {
            string teamID = (string)Session["teamID"];
            string offDay = txt_offDay.Text;

            if (offDay == "")
            {
                lbl_dayOff.Text = "Please enter a Date.";
                return;
            }

            bool success = db_InsertNewOffDay(teamID, offDay);

            if (success == true)
            {
                lbl_dayOff.Text = "";
                txt_offDay.Text = "";
                grd_offDay.DataBind();
                txt_offDay.BackColor = System.Drawing.Color.White;
            }
            else
            {
                lbl_dayOff.Text = "The Date entered already exists for this team or is in the incorrect format (mm/dd/yyyy).";
                txt_offDay.BackColor = System.Drawing.Color.LightPink;
            }
            
        }
    

    }
}   
