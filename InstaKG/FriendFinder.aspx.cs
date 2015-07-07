using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace InstaKG
{
    public partial class FriendFinder : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private DataTable RetrieveUsers()
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