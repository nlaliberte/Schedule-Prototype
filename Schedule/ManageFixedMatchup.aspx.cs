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
    public partial class ManageFixedMatchup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["fixedMatchupID"] = "-1";
        }

        protected void grd_fixedMatchup_RowCommand(Object sender, GridViewCommandEventArgs e)
        {
            string query;
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = grd_fixedMatchup.Rows[index];

            string homeTeam = row.Cells[4].Text;
            string awayTeam = row.Cells[6].Text;
            string fixedMatchupID = row.Cells[2].Text;
            Session["fixedMatchupID"] = fixedMatchupID;

            if (e.CommandName == "edit")
                Response.Redirect("FixedMatchupEdit.aspx");

            if (e.CommandName == "del")
            {
                query = "EXEC dbo.pr_fixed_matchup_delete " + fixedMatchupID;
                bool result = SQLHelper.Exec_SQLNonQuery(query);

                string script = "alert(\"The Fixed Matchup between " + homeTeam + " and " + awayTeam + " has been Removed.\");";
                ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);

                grd_fixedMatchup.DataBind();

                Session["fixedMatchupID"] = "-1";
            }
        }
    }
}