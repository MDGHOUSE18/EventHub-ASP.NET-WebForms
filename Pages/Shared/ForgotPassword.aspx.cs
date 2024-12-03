using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EventHub.Pages.Shared
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["ConString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Reset_Click(object sender, EventArgs e)
        {
            string email = UserTextBox.Text;
            string newPassword = HashPassword(PassTextBox.Text);

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "UPDATE Users SET PasswordHash = @PasswordHash WHERE Email = @Email";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@PasswordHash", newPassword); // Ideally, hash the password before storing it
                    cmd.Parameters.AddWithValue("@Email", email);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            // Show success message and optionally close the modal
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Password reset successfully!');", true);
            //Response.Redirect("Signin.aspx");
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