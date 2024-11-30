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
    public partial class UserDashboard1 : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["ConString"].ConnectionString;
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
                SqlCommand cmd = new SqlCommand("GetAllEvents", con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                sda.Fill(ds);

                //UserGrid.DataSource = ds;
                //UserGrid.DataBind();

                UserRepeater.DataSource = ds;
                UserRepeater.DataBind();
            }
        }

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
            else if (e.CommandName == "Register")
            {
                int eventId = Convert.ToInt32(e.CommandArgument);

                // Call method to delete the event
                //DeleteEvent(eventId);
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
                    //hfEventID.Value = Convert.ToInt32(reader["EventID"]).ToString();
                    LiteralEventName.Text = reader["EventName"].ToString();
                    LiteralEventDate.Text = Convert.ToDateTime(reader["EventDate"]).ToString("yyyy-MM-dd");
                    LiteralDescription.Text = reader["Description"].ToString();
                    LiteralLocation.Text = reader["Location"].ToString();
                    ImageEvent.ImageUrl = reader["Images"].ToString();


                }
                con.Close();
            }
        }

        protected void ManageEventsGrid_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
        protected void ManageEventsGrid_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            //UserGrid.PageIndex = e.NewPageIndex;
            GetEvents();
        }
    }
}