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
                string script = $"console.log('Username: {UserTextBox.Text.ToString()}'); console.log('Password: {hashedPassword}');";
                ClientScript.RegisterStartupScript(this.GetType(), "consoleLog", script, true);


                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        Session["UserId"] = Convert.ToInt32(reader["UserId"]);
                        Session["Email"] = reader["Email"].ToString();
                        Session["Name"] = reader["FullName"].ToString();
                        Session["Role"] = reader["Role"].ToString();
                    }

                    reader.Close();

                    Page.ClientScript.RegisterStartupScript(this.GetType(), "Scripts", "<script>alert('Login Successful!')</script>");

                    if (Session["Role"].ToString().ToLower() == "admin")
                    {
                        Response.Redirect("~/Pages/Admin/Dashboard.aspx");
                    }
                    else
                    {
                        Response.Redirect("~/Pages/User/Home.aspx");
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