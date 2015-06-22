using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace InstaKG
{
    public partial class Profile1 : System.Web.UI.Page
    {
        private string constr = ConfigurationManager.ConnectionStrings["InstaKGConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Repeater1.DataSource = FetchAllImagesInfo();
                Repeater1.DataBind();
            }
        }

        private DataTable FetchAllImagesInfo()
        {
            DataTable dt = new DataTable();
            SqlConnection con = new SqlConnection(constr);
            SqlDataAdapter sda = new SqlDataAdapter();

            //Dummy session of a particular user id
            //Session["accountID"] = 1;
            int accId = (int)(Session["accountID"]);
            string strQuery = "Select * from Image where accountID= @ID";

            SqlCommand cmd = new SqlCommand(strQuery);
            cmd.Parameters.AddWithValue("@ID", accId);
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
        }
    }
}