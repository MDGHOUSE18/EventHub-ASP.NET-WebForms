using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EventHub.Pages.User
{
    public partial class Profile : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["ConString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if the session is valid and the UserID exists
            if (Session["UserID"] == null)
            {
                // Redirect to the login page if no user is logged in
                Response.Redirect("~/Login.aspx");
            }
            else
            {
                // Optionally log the UserID to verify it's correctly retrieved
                int userId = (int)Session["UserId"];
                GetUser(userId);

                // Bind the GridView with the data source
                if (!IsPostBack)
                {
                    GetUser(userId);
                }
            }
        }

        private void GetUser(int userId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("GetUser", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("userId", userId);

                con.Open();

                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);

                ProfileGridView.DataSource = dt;
                ProfileGridView.DataBind();

                ProfileRepeater.DataSource = dt;
                ProfileRepeater.DataBind();

            }
        }
    }
}