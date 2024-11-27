using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EventHub.Pages.Admin
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Name"] != null)
            {
                Response.Write("Welcome to Admin Dashboard " + Session["Name"]);
            }
            else
            {
                Response.Redirect("~/Page/Shared/LoginForm.aspx");
            }
        }

        protected void Logout_Click(object sender, EventArgs e)
        {
            // Clear all session variables
            Session.Clear();

            // Optionally, abandon the session to remove it completely from the server
            Session.Abandon();

            // Redirect the user to the login page or home page
            Response.Redirect("~/Pages/Shared/Signin.aspx");
        }
    }
}