using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EventHub.Pages.Shared
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Clear the session or any authentication cookies
            Session.Abandon();
            HttpContext.Current.Response.Cookies.Clear();

            // Redirect to the login page after logout
            Response.Redirect("../Shared/Signin.aspx");
        }
    }
}