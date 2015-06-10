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
            string constr = ConfigurationManager.ConnectionStrings["InstaKGConnectionString"].ConnectionString;

            DataTable dt = new DataTable();
            SqlConnection con = new SqlConnection(constr);
            SqlDataAdapter sda = new SqlDataAdapter();

            //Dummy data of a particular user id
            string accId= "1";
            string strQuery = "Select * from Image where accountID= @ID";
            
            SqlCommand cmd = new SqlCommand(strQuery);
            cmd.Parameters.AddWithValue("@ID", accId.Trim());
            //("@ID", accId.Text.Trim()
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;

            try
            {
                con.Open();
                sda.SelectCommand = cmd;
                sda.Fill(dt);
                return dt;
            }

            catch (Exception ex)
            {
                Response.Write(ex.Message);
                return null;
            }

            ////Backup of the basic
            ////string accId= "1";
            //string sql = "Select * from Image where accountID= @ID";
            ////sqlCmd.Parameters.AddWithValue("@ID", accountID.ToString());
            //SqlDataAdapter da = new SqlDataAdapter(sql, con);
            //DataTable dt = new DataTable();
            //da.Fill(dt);
            //return dt;
        }
    }
}