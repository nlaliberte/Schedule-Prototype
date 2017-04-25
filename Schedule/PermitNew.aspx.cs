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
    public partial class PermitNew : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string teamID = (string)Session["teamID"];
            string fieldID = (string)Session["fieldID"];
            string leagueID = (string)Session["leagueID"];
            string permitBy = (string)Session["permitBy"];
            if (!Page.IsPostBack)
            {
                if (permitBy == "team")
                {
                    dd_team1.DataBind();
                    dd_team2.DataBind();
                    dd_team3.DataBind();
                    dd_team4.DataBind();
                    dd_team5.DataBind();
                    dd_team6.DataBind();
                    dd_team7.DataBind();
                    dd_team8.DataBind();
                    dd_team9.DataBind();
                    dd_team10.DataBind();
                    dd_team11.DataBind();
                    dd_team12.DataBind();
                    dd_team13.DataBind();
                    dd_team14.DataBind();
                    dd_team15.DataBind();
                    dd_team16.DataBind();
                    dd_team17.DataBind();
                    dd_team18.DataBind();
                    dd_team19.DataBind();
                    dd_team20.DataBind();

                    dd_team1.SelectedValue = teamID;
                    dd_team2.SelectedValue = teamID;
                    dd_team3.SelectedValue = teamID;
                    dd_team4.SelectedValue = teamID;
                    dd_team5.SelectedValue = teamID;
                    dd_team6.SelectedValue = teamID;
                    dd_team7.SelectedValue = teamID;
                    dd_team8.SelectedValue = teamID;
                    dd_team9.SelectedValue = teamID;
                    dd_team10.SelectedValue = teamID;
                    dd_team11.SelectedValue = teamID;
                    dd_team12.SelectedValue = teamID;
                    dd_team13.SelectedValue = teamID;
                    dd_team14.SelectedValue = teamID;
                    dd_team15.SelectedValue = teamID;
                    dd_team16.SelectedValue = teamID;
                    dd_team17.SelectedValue = teamID;
                    dd_team18.SelectedValue = teamID;
                    dd_team19.SelectedValue = teamID;
                    dd_team20.SelectedValue = teamID;
                }
                else
                {
                    dd_field1.DataBind();
                    dd_field2.DataBind();
                    dd_field3.DataBind();
                    dd_field4.DataBind();
                    dd_field5.DataBind();
                    dd_field6.DataBind();
                    dd_field7.DataBind();
                    dd_field8.DataBind();
                    dd_field9.DataBind();
                    dd_field10.DataBind();
                    dd_field11.DataBind();
                    dd_field12.DataBind();
                    dd_field13.DataBind();
                    dd_field14.DataBind();
                    dd_field15.DataBind();
                    dd_field16.DataBind();
                    dd_field17.DataBind();
                    dd_field18.DataBind();
                    dd_field19.DataBind();
                    dd_field20.DataBind();

                    dd_field1.SelectedValue = fieldID;
                    dd_field2.SelectedValue = fieldID;
                    dd_field3.SelectedValue = fieldID;
                    dd_field4.SelectedValue = fieldID;
                    dd_field5.SelectedValue = fieldID;
                    dd_field6.SelectedValue = fieldID;
                    dd_field7.SelectedValue = fieldID;
                    dd_field8.SelectedValue = fieldID;
                    dd_field9.SelectedValue = fieldID;
                    dd_field10.SelectedValue = fieldID;
                    dd_field11.SelectedValue = fieldID;
                    dd_field12.SelectedValue = fieldID;
                    dd_field13.SelectedValue = fieldID;
                    dd_field14.SelectedValue = fieldID;
                    dd_field15.SelectedValue = fieldID;
                    dd_field16.SelectedValue = fieldID;
                    dd_field17.SelectedValue = fieldID;
                    dd_field18.SelectedValue = fieldID;
                    dd_field19.SelectedValue = fieldID;
                    dd_field20.SelectedValue = fieldID;
                }
            }
        }

        protected void btn_back_Click(object sender, EventArgs e)
        {
            string permitBy = (string)Session["permitBy"];

            if(permitBy == "team")
            {
                Response.Redirect("PermitHomeByTeam.aspx");
            }
            else
            {
                Response.Redirect("PermitHomeByField.aspx");
            }
        }

        protected bool db_InsertNewPermit(string leagueID, string date, string time, string am_pm, string fieldID, string teamID)
        {

            string query = "EXEC dbo.pr_permit_insert " + leagueID + ", '" + date + "', '" + time + "', '" + am_pm + "', " + fieldID + ", " + teamID + ", " + teamID;
            bool result = SQLHelper.Exec_SQLNonQuery(query);

            return result;
        }


        protected void resetRow(DropDownList dd_team, TextBox txt_date, TextBox txt_time, DropDownList dd_ampm, DropDownList dd_field, Label lbl_error)
        {
            string permitBy = (string)Session["permitBy"];

            txt_date.Text = "";
            txt_date.BackColor = System.Drawing.Color.White;
            txt_time.Text = "";
            txt_time.BackColor = System.Drawing.Color.White;
            lbl_error.Text = "";
            dd_ampm.SelectedValue = "PM";
            dd_field.BackColor = System.Drawing.Color.White;
            if (permitBy == "team")
            {
                dd_field.SelectedValue = "-1";
            }
            else
            {
                dd_team.SelectedValue = "-2";
            }
        }


        protected void add_Permit(DropDownList dd_team, TextBox txt_date, TextBox txt_time, DropDownList dd_ampm, DropDownList dd_field, Label lbl_error, int permitCount)
        {
            string leagueID = (string)Session["leagueID"];
            string permitBy = (string)Session["permitBy"];
            string teamID = dd_team.SelectedValue;
            string date = txt_date.Text;
            string time = txt_time.Text;
            string am_pm = dd_ampm.SelectedValue;
            string fieldID = dd_field.SelectedValue;

            if (dd_field.SelectedIndex == 0 || dd_team.SelectedIndex == 0)
            { 
                return;
            }

            bool valid = WarningHelper.val_DateTime(date, time);
            if (valid == false)
            {
                lbl_error.Text = "Please enter a valid Date/Time.";
                txt_date.BackColor = System.Drawing.Color.LightPink;
                txt_time.BackColor = System.Drawing.Color.LightPink;
                return;
            }

            bool success = db_InsertNewPermit(leagueID, date, time, am_pm, fieldID, fieldID);
            if (success == true)
            {
                permitCount = permitCount + 1;
                resetRow(dd_team, txt_date, txt_time, dd_ampm, dd_field, lbl_error);
            }
            else
            {
                lbl_error.Text = "Either a permit already exists for this Field/Date/Time, or you did not enter a valid Date (mm/dd/yyyy) and/or Time (hh:mm)";
                txt_date.BackColor = System.Drawing.Color.LightPink;
                txt_time.BackColor = System.Drawing.Color.LightPink;
                dd_field.BackColor = System.Drawing.Color.LightPink;
            }
            
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            int permitCount = 0;
            string leagueID = (string)Session["leagueID"];
            string permitBy = (string)Session["permitBy"];

            add_Permit(dd_team1, txt_date1, txt_time1, dd_ampm1, dd_field1, lbl_error1, permitCount);
            add_Permit(dd_team2, txt_date2, txt_time2, dd_ampm2, dd_field2, lbl_error2, permitCount);
            add_Permit(dd_team3, txt_date3, txt_time3, dd_ampm3, dd_field3, lbl_error3, permitCount);
            add_Permit(dd_team4, txt_date4, txt_time4, dd_ampm4, dd_field4, lbl_error4, permitCount);
            add_Permit(dd_team5, txt_date5, txt_time5, dd_ampm5, dd_field5, lbl_error5, permitCount);
            add_Permit(dd_team6, txt_date6, txt_time6, dd_ampm6, dd_field6, lbl_error6, permitCount);
            add_Permit(dd_team7, txt_date7, txt_time7, dd_ampm7, dd_field7, lbl_error7, permitCount);
            add_Permit(dd_team8, txt_date8, txt_time8, dd_ampm8, dd_field8, lbl_error8, permitCount);
            add_Permit(dd_team9, txt_date9, txt_time9, dd_ampm9, dd_field9, lbl_error9, permitCount);
            add_Permit(dd_team10, txt_date10, txt_time10, dd_ampm10, dd_field10, lbl_error10, permitCount);
            add_Permit(dd_team11, txt_date11, txt_time11, dd_ampm11, dd_field11, lbl_error11, permitCount);
            add_Permit(dd_team12, txt_date12, txt_time12, dd_ampm12, dd_field12, lbl_error12, permitCount);
            add_Permit(dd_team13, txt_date13, txt_time13, dd_ampm13, dd_field13, lbl_error13, permitCount);
            add_Permit(dd_team14, txt_date14, txt_time14, dd_ampm14, dd_field14, lbl_error14, permitCount);
            add_Permit(dd_team15, txt_date15, txt_time15, dd_ampm15, dd_field15, lbl_error15, permitCount);
            add_Permit(dd_team16, txt_date16, txt_time16, dd_ampm16, dd_field16, lbl_error16, permitCount);
            add_Permit(dd_team17, txt_date17, txt_time17, dd_ampm17, dd_field17, lbl_error17, permitCount);
            add_Permit(dd_team18, txt_date18, txt_time18, dd_ampm18, dd_field18, lbl_error18, permitCount);
            add_Permit(dd_team19, txt_date19, txt_time19, dd_ampm19, dd_field19, lbl_error19, permitCount);
            add_Permit(dd_team20, txt_date20, txt_time20, dd_ampm20, dd_field20, lbl_error20, permitCount);

            if (permitCount == 0)
            {
                WarningHelper.Warning_Notification("No Permits to Add.",this);
            }
            else
            {
                WarningHelper.Warning_Notification(permitCount.ToString() + " Permits Added!", this);
            }
        }

        protected void btn_reset_Click(object sender, EventArgs e)
        {
            resetRow(dd_team1, txt_date1, txt_time1, dd_ampm1, dd_field1, lbl_error1);
            resetRow(dd_team2, txt_date2, txt_time2, dd_ampm2, dd_field2, lbl_error2);
            resetRow(dd_team3, txt_date3, txt_time3, dd_ampm3, dd_field3, lbl_error3);
            resetRow(dd_team4, txt_date4, txt_time4, dd_ampm4, dd_field4, lbl_error4);
            resetRow(dd_team5, txt_date5, txt_time5, dd_ampm5, dd_field5, lbl_error5);
            resetRow(dd_team6, txt_date6, txt_time6, dd_ampm6, dd_field6, lbl_error6);
            resetRow(dd_team7, txt_date7, txt_time7, dd_ampm7, dd_field7, lbl_error7);
            resetRow(dd_team8, txt_date8, txt_time8, dd_ampm8, dd_field8, lbl_error8);
            resetRow(dd_team9, txt_date9, txt_time9, dd_ampm9, dd_field9, lbl_error9);
            resetRow(dd_team10, txt_date10, txt_time10, dd_ampm10, dd_field10, lbl_error10);
            resetRow(dd_team11, txt_date11, txt_time11, dd_ampm11, dd_field11, lbl_error11);
            resetRow(dd_team12, txt_date12, txt_time12, dd_ampm12, dd_field12, lbl_error12);
            resetRow(dd_team13, txt_date13, txt_time13, dd_ampm13, dd_field13, lbl_error13);
            resetRow(dd_team14, txt_date14, txt_time14, dd_ampm14, dd_field14, lbl_error14);
            resetRow(dd_team15, txt_date15, txt_time15, dd_ampm15, dd_field15, lbl_error15);
            resetRow(dd_team16, txt_date16, txt_time16, dd_ampm16, dd_field16, lbl_error16);
            resetRow(dd_team17, txt_date17, txt_time17, dd_ampm17, dd_field17, lbl_error17);
            resetRow(dd_team18, txt_date18, txt_time18, dd_ampm18, dd_field18, lbl_error18);
            resetRow(dd_team19, txt_date19, txt_time19, dd_ampm19, dd_field19, lbl_error19);
            resetRow(dd_team20, txt_date20, txt_time20, dd_ampm20, dd_field20, lbl_error20);
        }

       
    }
}