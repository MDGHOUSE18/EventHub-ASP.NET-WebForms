using EventHub.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EventHub.Pages.Shared
{
    public partial class Signin : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["ConString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Login_Click(object sender, EventArgs e)
        {
            string hashedPassword = HashPassword(PassTextBox.Text);
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("Login", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@email", UserTextBox.Text);
                cmd.Parameters.AddWithValue("@password", hashedPassword);
                // Inject JavaScript to log to browser console
                string script = $"console.log('Username: {UserTextBox.Text.ToString()}'); console.log('Password: {hashedPassword}');";
                ClientScript.RegisterStartupScript(this.GetType(), "consoleLog", script, true);

                // Declare the output parameter
                //SqlParameter resultParam = new SqlParameter("@Result", SqlDbType.Int);
                //resultParam.Direction = ParameterDirection.Output;

                // Add the output parameter to the command
                //cmd.Parameters.Add(resultParam);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                //cmd.ExecuteNonQuery();
                //cmd.ExecuteScalar();
                //int result = Convert.ToInt32(resultParam.Value);
                if (reader.HasRows)
                {
                    // Loop through the result set (though there should only be one row)
                    while (reader.Read())
                    {
                        // Directly retrieve the user details from the reader
                        Session["Email"] = reader["Email"].ToString();
                        Session["Name"] = reader["FullName"].ToString();
                        Session["Role"] = reader["Role"].ToString();
                    }

                    // Close the reader
                    reader.Close();

                    // Show success message
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "Scripts", "<script>alert('Login Successful!')</script>");

                    // Redirect user based on role
                    if (Session["Role"].ToString().ToLower() == "admin")
                    {
                        //Response.Redirect("~/Pages/Admin/AdminDashboard.aspx");
                        Response.Redirect("~/Pages/Admin/ManageEvents.aspx");
                    }
                    else
                    {
                        Response.Redirect("~/Pages/User/UserDashboard.aspx");
                    }

                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "Scripts", "<script>alert('Login Failed! Invalid username or password.')</script>");
                }
            }
        }
        private string HashPassword(string password)
        {
            using (SHA256 sha256Hash = SHA256.Create())
            {
                byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder builder = new StringBuilder();
                foreach (byte b in bytes)
                {
                    builder.Append(b.ToString("x2"));
                }

                return builder.ToString();
            }
        }
        private void GetUser(string username)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("GetUserByEmail", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@email", username);

                con.Open();

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    Session["email"] = reader["Email"].ToString() ?? "";
                    Session["name"] =   reader["FullName"].ToString();
                    Session["role"] = reader["Role"].ToString().ToLower();
                }
            }
        }
    }
}