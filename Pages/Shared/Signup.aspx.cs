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
    public partial class Signup : System.Web.UI.Page
    {
        String cs = ConfigurationManager.ConnectionStrings["ConString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {

            }
        }





        protected void Register_Click(object sender, EventArgs e)
        {
            string hashedPassword = HashPassword(PassTextBox.Text);
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("Register", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@name", FullNameTextBox.Text);
                cmd.Parameters.AddWithValue("@email", UserTextBox.Text);
                cmd.Parameters.AddWithValue("@password", hashedPassword);
                // Inject JavaScript to log to browser console
                string script = $"console.log('Username: {UserTextBox.Text.ToString()}'); console.log('Password: {hashedPassword}');";
                ClientScript.RegisterStartupScript(this.GetType(), "consoleLog", script, true);
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Account created successfully!');", true);
                    //Response.Redirect("LoginForm.aspx");
                    UserTextBox.Text = null;
                    FullNameTextBox.Text = null;
                    PassTextBox.Text = null;
                    ConfirmPassTextBox.Text = null;
                }
                catch (Exception ex)
                {

                    Page.ClientScript.RegisterStartupScript(this.GetType(), "Scripts", $"<script>alert('Error: {ex.Message}')</script>");
                }
            }
        }


        private static string HashPassword(string password)
        {
            using (SHA256 sha256Hash = SHA256.Create())
            {
                byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(password));

                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < bytes.Length; i++)
                {
                    builder.Append(bytes[i].ToString("x2"));
                }
                return builder.ToString();
            }
        }

    }
}