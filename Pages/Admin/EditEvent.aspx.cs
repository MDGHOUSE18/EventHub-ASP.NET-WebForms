using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EventHub.Pages.Admin
{
    public partial class EditEvent : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["ConString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Get EventID from query string
                int eventId = Convert.ToInt32(Request.QueryString["EventID"]);
                LoadEventDetails(eventId);
            }
        }

        // Method to load event details into the form
        private void LoadEventDetails(int eventId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("GetEventById", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EventID", eventId);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    txtEventName.Text = reader["EventName"].ToString();
                    txtEventDate.Text = Convert.ToDateTime(reader["EventDate"]).ToString("yyyy-MM-dd");
                    txtDescription.Text = reader["Description"].ToString();
                    txtLocation.Text = reader["Location"].ToString();
                }
                con.Close();
            }
        }

        // Method to update event details
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int eventId = Convert.ToInt32(Request.QueryString["EventID"]);

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("UpdateEvent", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EventID", eventId);
                cmd.Parameters.AddWithValue("@EventName", txtEventName.Text);
                cmd.Parameters.AddWithValue("@EventDate", DateTime.Parse(txtEventDate.Text));
                cmd.Parameters.AddWithValue("@Description", txtDescription.Text);
                cmd.Parameters.AddWithValue("@Location", txtLocation.Text);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

            // Redirect back to ManageEvents page after successful update
            Response.Redirect("~/Pages/Admin/ManageEvents.aspx");
        }
    }
}