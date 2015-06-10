using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace InstaKG
{
    public partial class Profile1 : System.Web.UI.Page
    {
        private string con = ConfigurationManager.ConnectionStrings["InstaKGConnectionString"].ConnectionString;
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
            string accId= "2";
            string sql = "Select * from Image where accountID=" + accId;
            //sqlCmd.Parameters.AddWithValue("@ID", accountID.ToString());
            SqlDataAdapter da = new SqlDataAdapter(sql, con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            return dt;
        }
    }
}