using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EventHub.MasterPages;

namespace EventHub.Pages.User
{
    public partial class UserDashboard1 : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["ConString"].ConnectionString;

        // Properties for pagination
        private int PageSize = 8; // Number of events per page
        private int PageIndex
        {
            get { return ViewState["PageIndex"] != null ? (int)ViewState["PageIndex"] : 0; }
            set { ViewState["PageIndex"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetEvents();
            }
        }

        private void GetEvents()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // Query to get the total count of records
                string countQuery = "SELECT COUNT(*) FROM Events";
                SqlCommand countCmd = new SqlCommand(countQuery, con);
                con.Open();
                int totalRecords = (int)countCmd.ExecuteScalar();
                con.Close();

                // Calculate the total number of pages
                int totalPages = (int)Math.Ceiling((double)totalRecords / PageSize);

                // Query to fetch paginated data
                string query = @"
                SELECT * FROM (
                    SELECT ROW_NUMBER() OVER (ORDER BY EventDate DESC) AS RowNum, *
                    FROM Events
                ) AS RowConstrainedResult
                WHERE RowNum > @StartIndex AND RowNum <= @EndIndex
                ORDER BY RowNum";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@StartIndex", PageIndex * PageSize);
                cmd.Parameters.AddWithValue("@EndIndex", (PageIndex + 1) * PageSize);

                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);

                // Bind data to the Repeater
                UserRepeater.DataSource = dt;
                UserRepeater.DataBind();

                // Update pagination controls
                UpdatePaginationControls(totalRecords, totalPages);
            }
        }

        private void UpdatePaginationControls(int totalRecords, int totalPages)
        {
            // Enable/Disable pagination buttons
            btnPrevious.Enabled = PageIndex > 0;
            btnNext.Enabled = PageIndex < totalPages - 1;

            // Update page info
            lblPageInfo.Text = $"Page {PageIndex + 1} of {totalPages}";
        }



        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            if (PageIndex > 0)
            {
                PageIndex--;
                GetEvents();
            }
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            PageIndex++;
            GetEvents();
        }

        protected void UserRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            if (e.CommandName == "EventDetails")
            {
                int eventId = Convert.ToInt32(e.CommandArgument);

                // Load event details into modal
                LoadEventDetails(eventId);

                // Show the modal using JavaScript
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", "$('#eventDetailsModal').modal('show');", true);
            }
            else if (e.CommandName == "EventRegister")
            {
                int eventId = Convert.ToInt32(e.CommandArgument);

                
                RegisterEvent(userId,eventId);
                GetEvents();

            }
        }

        private void RegisterEvent(int userId,int eventId)
        {
            try { 
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("RegisterEvent", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EventID", eventId);
                cmd.Parameters.AddWithValue ("userId", userId);

                con.Open();
                cmd.ExecuteNonQuery();
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Scripts", "<script>alert('Event registration successful!')</script>");

            }
            }
            catch (Exception ex)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Scripts", "<script>alert('Error: " + ex.Message + "')</script>");
            }
        }

        private void LoadEventDetails(int eventId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM Events WHERE EventID = @EventID", con);
                cmd.Parameters.AddWithValue("@EventID", eventId);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    LiteralEventName.Text = reader["EventName"].ToString();
                    LiteralEventDate.Text = Convert.ToDateTime(reader["EventDate"]).ToString("yyyy-MM-dd");
                    LiteralDescription.Text = reader["Description"].ToString();
                    LiteralLocation.Text = reader["Location"].ToString();
                    ImageEvent.ImageUrl = reader["Images"].ToString();
                }
            }
        }
        protected void UserRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            // Check if it's a data item (not a header or footer)
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                // Get the event ID and user ID
                int eventId = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "EventID"));
                int userId = Convert.ToInt32(Session["UserID"]); // Assuming userID is stored in the session

                // Check if the user is already registered for this event
                if (IsUserRegisteredForEvent(userId, eventId))
                {
                    // Hide the register button and show the "Already Registered" label
                    Label alreadyRegisteredLabel = (Label)e.Item.FindControl("AlreadyRegisteredLabel");
                    alreadyRegisteredLabel.Visible = true;

                    Button registerButton = (Button)e.Item.FindControl("Register");
                    registerButton.Visible = false;
                }
                else
                {
                    // Show the register button
                    Button registerButton = (Button)e.Item.FindControl("Register");
                    registerButton.Visible = true;

                    Label alreadyRegisteredLabel = (Label)e.Item.FindControl("AlreadyRegisteredLabel");
                    alreadyRegisteredLabel.Visible = false;
                }
            }
        }

        private bool IsUserRegisteredForEvent(int userId, int eventId)
        {
            // Your logic to check if the user is already registered for the event.
            // Example: Query the database to check if a record exists in the registration table.
            bool isRegistered = false;

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("CheckUserRegistration", con);  // Assuming you have a stored procedure that checks if the user is registered.
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@UserID", userId);
                cmd.Parameters.AddWithValue("@EventID", eventId);

                con.Open();
                isRegistered = Convert.ToBoolean(cmd.ExecuteScalar());
            }

            return isRegistered;
        }

    }

}