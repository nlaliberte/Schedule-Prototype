using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Schedule
{
    public partial class PermitEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

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