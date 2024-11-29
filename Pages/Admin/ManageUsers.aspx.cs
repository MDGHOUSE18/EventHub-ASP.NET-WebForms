using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EventHub.Pages.Admin
{
    public partial class ManageUsers : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["ConString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetUsers();
            }
        }
        
        private void GetUsers()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("GetUsers",con);
                cmd.CommandType = CommandType.StoredProcedure;

                con.Open();

                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataSet dataSet = new DataSet();

                sda.Fill(dataSet);

                UsersGrid.DataSource = dataSet;
                UsersGrid.DataBind();   

            }
        }
    }
}