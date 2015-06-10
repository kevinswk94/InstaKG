using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace InstaKG
{
    public partial class Profile1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GridView1.DataSource = FetchAllImagesInfo();
                GridView1.DataBind();
            }
        }

        private DataTable FetchAllImagesInfo()
        {
            SqlConnection con = new
            SqlConnection(ConfigurationManager.ConnectionStrings["InstaKGConnectionString"].ToString());
            
            string sql = "Select * from Image";
            SqlDataAdapter da = new SqlDataAdapter(sql, con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            return dt;
        }
    }
}