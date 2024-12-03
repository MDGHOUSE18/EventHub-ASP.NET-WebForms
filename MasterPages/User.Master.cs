using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web.Security;
using System.Security.Cryptography;
using System.Text;

namespace EventHub.MasterPages
{
    public partial class User : System.Web.UI.MasterPage
    {
        string cs = ConfigurationManager.ConnectionStrings["ConString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                // Redirect to the login page if no user is logged in
                Response.Redirect("~/Pages/Shared/Signin.aspx");
            }
            else
            {
                

                // Bind the GridView with the data source
                if (!IsPostBack)
                {
                    GetUser();
                }
            }
        }
        private void GetUser()
        {
            int userId = (int)Session["UserId"];
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("GetUser", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("userId", userId);

                con.Open();

                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    FullName.Text = reader["FullName"].ToString();
                    Email.Text = reader["Email"].ToString();
                    Phone.Text = reader["PhoneNumber"].ToString();
                    Gender.Text = reader["Gender"].ToString();
                    Role.Text = reader["Role"].ToString();

                    // Populate Edit Modal fields
                    txtFullName.Text = FullName.Text;
                    txtEmail.Text = Email.Text;
                    txtPhone.Text = Phone.Text;
                    if (!string.IsNullOrEmpty(Gender.Text))
                    {
                        ddlGender.SelectedValue = Gender.Text;
                    }
                }



            }
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int userId = (int)Session["UserId"];
            string fullName = txtFullName.Text;
            string email = txtEmail.Text;
            string phone = txtPhone.Text;
            string gender = ddlGender.SelectedValue;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "UPDATE Users SET FullName = @FullName, Email = @Email, PhoneNumber = @Phone,Gender=@Gender WHERE UserID = @UserID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@FullName", fullName);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Phone", phone);
                cmd.Parameters.AddWithValue("@UserID", userId);
                cmd.Parameters.AddWithValue("@Gender", gender);
                con.Open();
                cmd.ExecuteNonQuery();

            }

            // Refresh the profile modal details
            GetUser();

            // Optionally, display a success message
            ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Profile updated successfully!');", true);
        }



    }
}