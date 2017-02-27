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
                string permitID = (string)Session["permitID"];
                dd_field.DataBind();
                dd_team.DataBind();

                string query = "EXEC dbo.pr_permit_get " + permitID;
                DataTable permitSource = SQLHelper.Exec_SQLReaderDataTable(query);
                foreach (DataRow row in permitSource.Rows)
                {
                    txt_date.Text = row["permit_date"].ToString();
                    txt_time.Text = row["permit_time"].ToString();
                    dd_field.SelectedValue = row["field_id"].ToString();
                    dd_team.SelectedValue = row["team_id"].ToString();
                }

            }
            



        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            int fieldID = dd_field.SelectedIndex;
            int teamID = dd_team.SelectedIndex;
            string permitDate = txt_date.Text;
            string permitTime = txt_time.Text;

           


        }
    }
}