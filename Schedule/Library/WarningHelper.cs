using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Text.RegularExpressions;

namespace Schedule.Library
{
    public static class WarningHelper
    {
        public static void Warning_Notification(string message, System.Web.UI.Page page)
        {
            string script = "alert(\"" + message + "\");";
            ScriptManager.RegisterStartupScript(page, page.GetType(), "ServerControlScript", script, true);
        }


        public static bool val_DateTime(string date, string time)
        {
            if (!Regex.IsMatch(date, "^(0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])[- /.](19|20)\\d\\d$"))
            { return false; }

            if (!Regex.IsMatch(time, "^*(1[0-2]|[1-9]):[0-5][0-9]$"))
            { return false; }

            return true;
        }

    }
}