using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace InstaKG
{
    public partial class BrowseImages : System.Web.UI.Page
    {
        public string test = "1";
        protected void Page_Load(object sender, EventArgs e)
        {
            gv_browseImages.DataSource = RetrieveImages();
            gv_browseImages.DataBind();
        }

        private DataTable RetrieveImages()
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString);

            DataTable dt = new DataTable();
            SqlDataAdapter sda = new SqlDataAdapter();

            string sql = "SELECT DISTINCT Image.imageID, Image.imageTitle, Image.uploadDateTime, Account.fName FROM Image INNER JOIN Account ON Image.accountID = Account.accountID ORDER BY uploadDateTime";
            SqlCommand cmd = new SqlCommand(sql, con);

            con.Open();
            sda.SelectCommand = cmd;
            sda.Fill(dt);

            sda.Dispose();
            cmd.Dispose();
            con.Close();
            return dt;
        }
    }
}