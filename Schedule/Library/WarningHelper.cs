using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace Schedule.Library
{
    public static class WarningHelper
    {
        //public static void Warning_Notification(string message, System.Web.UI.Page page)
        //{
        //    string script = "alert(\"" + message + "\");";
        //    ScriptManager.RegisterStartupScript(page, GetType(), "ServerControlScript", script, true);
        //}


        public static bool val_DateTime(string date, string time)
        {
            if (date == "")
            { return false; }

            if (time == "")
            { return false; }

            return true;
        }

    }
}