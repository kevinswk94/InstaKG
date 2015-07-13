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
            //BindData();
            RetrieveImages2();

            // Below codes no longer needed as now using paging

            //gv_browseImages.DataSource = RetrieveImages();
            //gv_browseImages.DataSource = BindData();
            //gv_browseImages.DataBind();
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

        private void RetrieveImages2()
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

            gv_browseImages.DataSource = dt;
            gv_browseImages.DataBind();
        }

        private void BindData()
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString);

            string sql = "SELECT DISTINCT Image.imageID, Image.imageTitle, Image.uploadDateTime, Account.fName FROM Image INNER JOIN Account ON Image.accountID = Account.accountID ORDER BY uploadDateTime";
            SqlCommand cmd = new SqlCommand(sql, con);
            DataSet ds = new DataSet();
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            sda.Fill(ds);

            sda.Dispose();
            cmd.Dispose();
            con.Close();

            gv_browseImages.DataSource = ds;
            gv_browseImages.DataBind();
        }

        protected void gv_browseImages_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gv_browseImages.PageIndex = e.NewPageIndex;
            BindData();
            //RetrieveImages2();
        }
    }
}