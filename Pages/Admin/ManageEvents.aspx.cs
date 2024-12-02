using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EventHub.Pages.Admin
{
    public partial class ManageEvents : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["ConString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack )
            {
                GetEvents();
            }
            
        }



        // Method to fetch and display all events
        private void GetEvents()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("GetAllEvents", con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                sda.Fill(ds);

                ManageEventsGrid.DataSource = ds;
                ManageEventsGrid.DataBind();
            }
        }

        // RowCommand event for handling Edit and Delete actions
        protected void ManageEventsGrid_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EventDetails")
            {
                int eventId = Convert.ToInt32(e.CommandArgument);

                // Load event details into modal
                LoadEventDetails(eventId);

                // Show the modal using JavaScript
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", "$('#eventDetailsModal').modal('show');", true);

            }
            else if (e.CommandName == "EditEvent")
            {
                int eventId = Convert.ToInt32(e.CommandArgument);

                // Load event details into modal
                LoadEventDetailsForEdit(eventId);

                // Show the modal using JavaScript
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", "$('#editEventModal').modal('show');", true);

            }
            else if (e.CommandName == "DeleteEvent")
            {
                int eventId = Convert.ToInt32(e.CommandArgument);

                // Call method to delete the event
                DeleteEvent(eventId);
            }
        }
        private void LoadEventDetails(int eventId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("GetEvent", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EventID", eventId);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    hfEventID.Value = Convert.ToInt32(reader["EventID"]).ToString();
                    LiteralEventName.Text = reader["EventName"].ToString();
                    LiteralEventDate.Text = Convert.ToDateTime(reader["EventDate"]).ToString("yyyy-MM-dd");
                    LiteralDescription.Text = reader["Description"].ToString();
                    LiteralLocation.Text = reader["Location"].ToString();
                    ImageEvent.ImageUrl = reader["Images"].ToString();

                    
                }
                con.Close();
            }
        }
        private void LoadEventDetailsForEdit(int eventId)
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
                    hfEventID.Value = Convert.ToInt32(reader["EventID"]).ToString();
                    txtEventName.Text = reader["EventName"].ToString();
                    txtEventDate.Text = Convert.ToDateTime(reader["EventDate"]).ToString("yyyy-MM-dd");
                    txtDescription.Text = reader["Description"].ToString();
                    txtLocation.Text = reader["Location"].ToString();
                }
                con.Close();
            }
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string imagePath = string.Empty;
            if (fileUploadEventImage.HasFile)
            {
                // Define a folder path to store the images (ensure the folder exists)
                string folderPath = Server.MapPath("~/EventImages/");
                string fileName = Path.GetFileName(fileUploadEventImage.PostedFile.FileName);
                imagePath = "~/EventImages/" + fileName;

                // Save the file to the server
                fileUploadEventImage.SaveAs(Path.Combine(folderPath, fileName));
            }

            int eventId = Convert.ToInt32(hfEventID.Value);
            int result = 0;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("UpdateEvent", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EventID", eventId);
                cmd.Parameters.AddWithValue("@EventName", txtEventName.Text);
                cmd.Parameters.AddWithValue("@EventDate", DateTime.Parse(txtEventDate.Text));
                cmd.Parameters.AddWithValue("@Description", txtDescription.Text);
                cmd.Parameters.AddWithValue("@Location", txtLocation.Text);
                cmd.Parameters.AddWithValue("@EventImage", imagePath);

                con.Open();
                result = cmd.ExecuteNonQuery();
                con.Close();
            }
            // Check if the update was successful
            if (result > 0)
            {
                // Show success message
                ScriptManager.RegisterStartupScript(this, this.GetType(), "SuccessAlert",
                    "alert('Event updated successfully!');", true);
                // Reload events after update
                GetEvents();
            }
            else
            {
                // Show failure message
                ScriptManager.RegisterStartupScript(this, this.GetType(), "FailureAlert",
                    "alert('Event update failed. Please try again.');", true);
            }
            
        }


        // Method to delete an event
        private void DeleteEvent(int eventId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("DeleteEvent", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EventID", eventId);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

            // Reload events after deletion
            GetEvents();
        }
        protected void ManageEventsGrid_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //if (e.Row.RowType == DataControlRowType.DataRow)
            //{
            //    // Get the image URL from the data item
            //    string imageUrl = DataBinder.Eval(e.Row.DataItem, "Images").ToString();

            //    // Get the Image control from the TemplateField
            //    Image imgEventImage = (Image)e.Row.FindControl("imgEventImage");

            //    // Set the Image URL dynamically
            //    if (string.IsNullOrEmpty(imageUrl))
            //    {
            //        imgEventImage.ImageUrl = "~/images/default-image.jpg"; // Default image if NULL
            //    }
            //    else
            //    {
            //        imgEventImage.ImageUrl = ResolveUrl(imageUrl); // Image from database
            //    }
            //}
        }

        protected void ManageEventsGrid_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
        protected void ManageEventsGrid_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            ManageEventsGrid.PageIndex = e.NewPageIndex;
            GetEvents();
        }

        protected void AddEvent_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", "$('#addEventModal').modal('show');", true);
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string imagePath = string.Empty;
            if (fileUpload1.HasFile)
            {
                // Define a folder path to store the images (ensure the folder exists)
                string folderPath = Server.MapPath("~/EventImages/");
                string fileName = Path.GetFileName(fileUpload1.PostedFile.FileName);
                imagePath = "~/EventImages/" + fileName;

                // Save the file to the server
                fileUpload1.SaveAs(Path.Combine(folderPath, fileName));
            }
            DateTime eventDate = DateTime.Parse(TextBox2.Text);
            int result = 0;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("AddEvent", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EventName", TextBox1.Text);
                cmd.Parameters.AddWithValue("@EventDate", eventDate);
                cmd.Parameters.AddWithValue("@Description", TextBox3.Text);
                cmd.Parameters.AddWithValue("@Location", TextBox4.Text);
                cmd.Parameters.AddWithValue("@EventImage", imagePath);

                con.Open();
                result = cmd.ExecuteNonQuery();
                con.Close();
            }
            // Check if the update was successful
            if (result > 0)
            {
                // Show success message
                ScriptManager.RegisterStartupScript(this, this.GetType(), "SuccessAlert",
                    "alert('Event added successfully!');", true);
                // Reload events after update
                GetEvents();
            }
            else
            {
                // Show failure message
                ScriptManager.RegisterStartupScript(this, this.GetType(), "FailureAlert",
                    "alert('Event added failed. Please try again.');", true);
            }

        }
        protected void Dashboard_Click(object sender, EventArgs e)
        {
            Response.Redirect("Dashboard.aspx");
        }

    }
}
