using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EventHub.Pages.Shared
{
    public partial class Logout : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["ConString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            ChangeIsActiveStatus((int)Session["UserId"]);
            // Clear the session or any authentication cookies
            Session.Abandon();
            HttpContext.Current.Response.Cookies.Clear();

            // Redirect to the login page after logout
            Response.Redirect("../Shared/Signin.aspx");
        }

        private void ChangeIsActiveStatus(int  userId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("ChangeIsActiveStatus", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@UserID",userId);


                con.Open();
                cmd.ExecuteNonQuery();


            }
        }
    }
}