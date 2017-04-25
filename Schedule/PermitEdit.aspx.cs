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
    public partial class PermitEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Page.IsPostBack)
            {
                string permitBy = (string)Session["permitBy"];
                if (permitBy == "team")
                {
                    lnk_PermitHome.Text = "Return to Permit Home by Team";
                    lnk_PermitHome.NavigateUrl = "~/PermitHomebyTeam.aspx";
                }
                else
                {
                    lnk_PermitHome.Text = "Return to Permit Home by Field";
                    lnk_PermitHome.NavigateUrl = "~/PermitHomebyField.aspx";
                }

                string permitID = (string)Session["permitID"];
                dd_field.DataBind();
                dd_team.DataBind();

                string query = "EXEC dbo.pr_permit_get " + permitID;
                DataTable permitSource = SQLHelper.Exec_SQLReaderDataTable(query);
                foreach (DataRow row in permitSource.Rows)
                {
                    txt_date.Text = row["permit_date"].ToString();
                    txt_time.Text = row["permit_time"].ToString();
                    dd_ampm.SelectedValue = row["permit_ampm"].ToString();
                    dd_field.SelectedValue = row["field_id"].ToString();
                    dd_team.SelectedValue = row["team_id"].ToString();
                }
            }
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            string leagueID = (string)Session["leagueID"];
            string permitID = (string)Session["permitID"];
            string permitBy = (string)Session["permitBy"];
            string fieldID = dd_field.SelectedValue;
            string teamID = dd_team.SelectedValue;
            string permitDate = txt_date.Text;
            string permitTime = txt_time.Text;
            string permitAMPM = dd_ampm.SelectedValue;

            bool valid = WarningHelper.val_DateTime(permitDate, permitTime);
            if (valid == false)
            {
                WarningHelper.Warning_Notification("Please enter a valid Date (mm/dd/yyyy) and Time (hh:mm).", this);

                txt_date.BackColor = System.Drawing.Color.LightPink;
                txt_time.BackColor = System.Drawing.Color.LightPink;
                return;
            }

            string query = "EXEC dbo.pr_permit_update " + permitID + ", " + leagueID + ", '" + permitDate + "', '" + permitTime + "', '" + permitAMPM + "', " + fieldID + ", " + teamID;
            bool result = SQLHelper.Exec_SQLNonQuery(query);

            if(result == true)
            {
                WarningHelper.Warning_Notification("The Permit has been Updated", this);
                return_PermitHome();
            }
            else
            {
                WarningHelper.Warning_Notification("The Permit could not be updated. A permit may already exist for this Field/Date.", this);
                return;
            }  
        }


        protected void btn_cancel_Click(object sender, EventArgs e)
        {
            return_PermitHome();           
        }


        protected void return_PermitHome()
        {
            string permitBy = (string)Session["permitBy"];

            if (permitBy == "team")
            {
                Response.Redirect("PermitHomebyTeam.aspx");
            }
            else
            {
                Response.Redirect("PermitHomebyField.aspx");
            }
        }
    }
}