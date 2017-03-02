﻿using System;
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
    public partial class FixedMatchupEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string fixedMatchupID = (string)Session["fixedMatchupID"];

            if (!Page.IsPostBack)
            {
                if(fixedMatchupID != "-1")
                { 
                    string query = "EXEC dbo.pr_fixed_matchup_get " + fixedMatchupID;
                    DataTable fixedMatchupSource = SQLHelper.Exec_SQLReaderDataTable(query);
                    foreach (DataRow row in fixedMatchupSource.Rows)
                    {
                        dd_homeTeam.SelectedValue = row["home_team_id"].ToString();
                        dd_awayTeam.SelectedValue = row["away_team_id"].ToString();
                        txt_date.Text = row["matchup_date"].ToString();
                        txt_time.Text = row["matchup_time"].ToString();
                        dd_ampm.SelectedValue = row["matchup_ampm"].ToString();
                        dd_field.SelectedValue = row["field_id"].ToString();
                    }
                }
                else
                {
                    dd_homeTeam.SelectedIndex = 0;
                    dd_awayTeam.SelectedIndex = 1;
                }
            }
        }

        protected void btn_cancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ManageFixedMatchup.aspx");
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            string fixedMatchupID = (string)Session["fixedMatchupID"];
            string warning;
            string query;
            bool result;

            string matchupDate = txt_date.Text;
            string matchupTime = txt_time.Text;
            bool valid = WarningHelper.val_DateTime(matchupDate, matchupTime);
            if (valid == false)
            {
                warning = "alert(\"Please enter a valid Date (mm/dd/yyyy) and Time (hh:mm).\");";
                ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", warning, true);

                txt_date.BackColor = System.Drawing.Color.LightPink;
                txt_time.BackColor = System.Drawing.Color.LightPink;
                return;
            }

            if (fixedMatchupID != "-1")
            {
                query = "EXEC dbo.pr_fixed_matchup_update " + fixedMatchupID + ", " + dd_homeTeam.SelectedValue + ", " + dd_awayTeam.SelectedValue + ", " + dd_field.SelectedValue + ", '" + matchupDate + "', '" + matchupTime + "', '" + dd_ampm.SelectedValue + "'";
                result = SQLHelper.Exec_SQLNonQuery(query);
            }
            else
            {
                query = "EXEC dbo.pr_fixed_matchup_insert " + (string)Session["leagueID"] + ", " + dd_homeTeam.SelectedValue +", " + dd_awayTeam.SelectedValue + ", " + dd_field.SelectedValue + ", '" + txt_date.Text + "', '" + txt_time.Text + "', '" + dd_ampm.SelectedValue + "'";
                result = SQLHelper.Exec_SQLNonQuery(query);
            }

            if (!result)
            {
                warning = "alert(\"Was not able to Insert/Update the Fixed Matchup. Is it possible a Matchup for these values already exists?\");";
                ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", warning, true);
                return;
            }
            else
            {
                Response.Redirect("ManageFixedMatchup.aspx");
            }
        }

        protected void dd_homeTeam_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (dd_homeTeam.SelectedValue == dd_awayTeam.SelectedValue)
            { 
                if(dd_homeTeam.SelectedIndex == 0)
                {
                    dd_awayTeam.SelectedIndex = 1;
                }
                else
                {
                    dd_awayTeam.SelectedIndex = 0;
                }
            }
        }

        protected void dd_awayTeam_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (dd_homeTeam.SelectedValue == dd_awayTeam.SelectedValue)
            {
                if (dd_awayTeam.SelectedIndex == 0)
                {
                    dd_homeTeam.SelectedIndex = 1;
                }
                else
                {
                    dd_homeTeam.SelectedIndex = 0;
                }
            }
        }
    }
}