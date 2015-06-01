using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Web;

namespace InstaKG
{




    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {


                ddlImages.DataSource = GetData("SELECT imageID, accountID FROM Image");
                ddlImages.DataTextField = "accountID";
                ddlImages.DataValueField = "accountID";
                ddlImages.DataBind();


            }
       


        }

        private DataTable GetData(string query)
        {
            DataTable dt = new DataTable();
            string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.CommandType = CommandType.Text;
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        sda.Fill(dt);
                    }
                }
                return dt;
            }
        }

        protected void FetchImage(object sender, EventArgs e)
        {
            string id = ddlImages.SelectedItem.Value;
            Image1.Visible = id != "0";
            if (id != "0")
            {


               
                byte[] bytes = (byte[])GetData("SELECT imageData FROM Image WHERE accountID =" + id).Rows[0]["imageData"];
                string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);
                Image1.ImageUrl = "data:image/png;base64," + base64String;

               

            }
        }

      
    }










































    //public partial class Profile : System.Web.UI.Page
    //{
    //    protected void Page_Load(object sender, EventArgs e)
    //    {
    //        if (!this.IsPostBack)
    //        {
    //            ddlImages.DataSource = GetData("SELECT imageID, imageTitle FROM Image");
    //            ddlImages.DataTextField = "imageTitle";
    //            ddlImages.DataValueField = "imageID";
    //            ddlImages.DataBind();
    //        }



    //    }

    //    private DataTable GetData(string query)
    //    {
    //        DataTable dt = new DataTable();
    //        string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
    //        using (SqlConnection con = new SqlConnection(constr))
    //        {
    //            using (SqlCommand cmd = new SqlCommand(query))
    //            {
    //                using (SqlDataAdapter sda = new SqlDataAdapter())
    //                {
    //                    cmd.CommandType = CommandType.Text;
    //                    cmd.Connection = con;
    //                    sda.SelectCommand = cmd;
    //                    sda.Fill(dt);
    //                }
    //            }
    //            return dt;
    //        }
    //    }

    //    protected void FetchImage(object sender, EventArgs e)
    //    {
    //        string id = ddlImages.SelectedItem.Value;
    //        Image1.Visible = id != "0";
    //        if (id != "0")
    //        {
    //            byte[] bytes = (byte[])GetData("SELECT imageData FROM Image WHERE imageID =" + id).Rows[0]["imageData"];
    //            string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);
    //            Image1.ImageUrl = "data:image/png;base64," + base64String;
    //        }
    //    }


    //}


}