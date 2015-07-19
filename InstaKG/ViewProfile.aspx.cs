using InstaKG.Entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace InstaKG
{
    public partial class ViewProfile : System.Web.UI.Page
    {
        DOA data = new DOA();
        private string constr = ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) //first time load
            {
                displayProfile();

                ///////////////////////////
                Repeater1.DataSource = FetchAllImagesInfo();
                Repeater1.DataBind();
            }
        }

        public string queryUsername()
        {
            return Request.QueryString["name"];
        }

        public void displayProfile()
        {
            int id = data.retrieveIDByUsername(queryUsername());

            string genderValue = null;

            System.Diagnostics.Debug.WriteLine("what is my id: " + id);

            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString;

            string sql = "SELECT fName,lName,email,birthdate,gender FROM Account WHERE accountID=@id";

            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@id", id);

            SqlDataReader dr;

            DataTable dt = new DataTable();

            con.Open();
            dr = cmd.ExecuteReader();

            dt.Load(dr);

            lbl_fname_value.Text = dt.Rows[0]["fName"].ToString();
            lbl_lname_value.Text = dt.Rows[0]["lName"].ToString();
            lbl_email_value.Text = dt.Rows[0]["email"].ToString();
            genderValue = dt.Rows[0]["gender"].ToString();

            System.Diagnostics.Debug.WriteLine(genderValue);

            if(genderValue.Length == 0)
            {
                lbl_gender_value.Visible = false;
                lbl_gender.Visible = false;
            }
            else
            {
                if (genderValue.Equals("0"))
                {
                    lbl_gender_value.Text = "Male";
                }
                else
                {
                    lbl_gender_value.Text = "Female";
                }
            }
            
            con.Close();

        }

        ////////////////////////////////////////////////////

        private DataTable FetchAllImagesInfo()
        {
            DataTable dt = new DataTable();
            SqlConnection con = new SqlConnection(constr);
            SqlDataAdapter sda = new SqlDataAdapter();

            //Dummy session of a particular user id
            //Session["accountID"] = 1;
            int accId = data.retrieveIDByUsername(queryUsername());
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

        protected void lb_gallery_Click(object sender, EventArgs e)
        {
            string url = "ViewGallery.aspx?name=" + queryUsername();

            Response.Redirect(url);
        }
    }
}