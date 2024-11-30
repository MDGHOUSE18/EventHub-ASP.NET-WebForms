using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace EventHub.Pages.Admin
{
    public partial class Reports : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["ConString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            GetAttendeesCount();
            GetAttendees();
            GetAttendeesCountForEachEvent();
        }
        private void GetAttendeesCount()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("GetTotalAttendessCount", con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    AttendeesCount.Text = reader["TotalAttendess"].ToString();
                }
            }
        }
        private void GetAttendees()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("GetAttendess",con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                sda.Fill(ds);

                AttendessGrid.DataSource = ds;
                AttendessGrid.DataBind();
            }

        }
        private void GetAttendeesCountForEachEvent()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("GetAttendeesCountForEachEvent", con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                sda.Fill(ds);

                AttendeesCountGrid.DataSource = ds;
                AttendeesCountGrid.DataBind();
            }

        }
        protected void AttendessGrid_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            AttendessGrid.PageIndex = e.NewPageIndex;
            GetAttendees();
        }
        protected void AttendeesCountGrid_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            AttendeesCountGrid.PageIndex = e.NewPageIndex;
            GetAttendees();
        }
    }
}