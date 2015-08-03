using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace InstaKG
{
    public partial class test : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            btn_Use.Enabled = false;
            if (!IsPostBack)
            {
                Tab1.CssClass = "Clicked";
                MainView.ActiveViewIndex = 0;
            }
        }

        protected void Tab1_Click(object sender, EventArgs e)
        {
            Tab1.CssClass = "Clicked";
            Tab2.CssClass = "Initial";
            MainView.ActiveViewIndex = 0;
        }

        protected void Tab2_Click(object sender, EventArgs e)
        {
            Tab1.CssClass = "Initial";
            Tab2.CssClass = "Clicked";
            MainView.ActiveViewIndex = 1;
            btn_Use.Enabled = true;
        }

        //capture img from live cam
        protected void Button2_Click(object sender, EventArgs e)
        {
            string h = HiddenField1.Value;
            byte[] data = Convert.FromBase64String(HiddenField1.Value);

            string imageName = DateTime.Now.ToString();
            string imagePath = string.Format("~/Register/" + Session["username"].ToString() + ".jpeg", imageName);
            //string imagePath1 = string.Format("~/Register/" + "test123.jpeg", imageName);
            string url = "~/Register/" + Session["username"].ToString() + ".jpeg";
            
            File.WriteAllBytes(Path.Combine(Server.MapPath(imagePath)), data);

            Image1.Attributes["src"] = Page.ResolveUrl(url);
            Session["url"] = Path.Combine(Server.MapPath(imagePath));
            btn_Use.Enabled = true;
        }

        //upload img from live cam capture
        protected void btn_Use_Click(object sender, EventArgs e)
        {
            // Read the file and convert it to Byte Array
            string filePath = Session["url"].ToString();
            string filename = Path.GetFileName(filePath);

            FileStream fs = new FileStream(filePath, FileMode.Open, FileAccess.Read);
            BinaryReader br = new BinaryReader(fs);
            Byte[] bytes = br.ReadBytes((Int32)fs.Length);
            
            br.Close();
            fs.Close();

            // update the image to DB
            string sql = "Update ProfilePic set profilePic=@profilepic where accountID=@accountID";

            //Response.Write(sql);
            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString;
            SqlCommand cmd = new SqlCommand(sql, con);

            //set up parameters
            cmd.Parameters.Add("@profilepic", SqlDbType.Binary).Value = bytes;
            cmd.Parameters.AddWithValue("@accountID",Session["accountID"].ToString());
            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
                alert_placeholder.Visible = true;
                alert_placeholder.Attributes["class"] = "alert alert-success alert-dismissable";
                alertText.Text = "Success! Redirectly to View Profile...";
                //delete file from folder
                FileInfo file = new FileInfo(filePath);
                if (file.Exists)//check file exsit or not
                {
                    file.Delete();
                }

                Response.AddHeader("REFRESH", "3;URL=ViewProfile.aspx?name=" + Session["username"].ToString());
                

            }
            catch (Exception ex)
            {
                alert_placeholder.Visible = true;
                alert_placeholder.Attributes["class"] = "alert alert-success alert-dismissable";
                alertText.Text = ex.Message;
                //Response.Redirect("Error.aspx");
            }
            finally
            {
                con.Close();
            }
        }

        //upload img from user's selection from own device
        protected void btn_UseFromCom_Click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile)
            {
                //get the current datetime
                DateTime dt = DateTime.Now;

                //create byte array with size corresponding to the currently selected file
                byte[] imgData = new byte[FileUpload1.PostedFile.ContentLength];

                //store the currently selected file in memory
                HttpPostedFile img = FileUpload1.PostedFile;

                //store the image binary data of the selected file in the imgBin byte array
                img.InputStream.Read(imgData, 0, (int)FileUpload1.PostedFile.ContentLength);

                //get file extension
                string ext = Path.GetExtension(FileUpload1.FileName);

                // Saving the iamge to DB
                if (ext.ToLower().Equals(".jpg") || ext.ToLower().Equals(".png") || ext.ToLower().Equals(".jpeg") || ext.ToLower().Equals(".gif"))
                {
                    // update the image to DB
                    string sql = "Update ProfilePic set profilePic=@profilepic where accountID=@accountID";

                    //Response.Write(sql);
                    SqlConnection con = new SqlConnection();
                    con.ConnectionString = ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString;
                    SqlCommand cmd = new SqlCommand(sql, con);

                    //set up parameters
                    cmd.Parameters.Add("@profilepic", SqlDbType.Binary).Value = imgData;
                    cmd.Parameters.AddWithValue("@accountID", Session["accountID"].ToString());
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        alert_placeholder.Visible = true;
                        alert_placeholder.Attributes["class"] = "alert alert-success alert-dismissable";
                        alertText.Text = "Success! Redirectly to View Profile...";
                        //Response.Write(Session["username"].ToString());
                        Response.AddHeader("REFRESH", "3;URL=ViewProfile.aspx?name=" + Session["username"].ToString());
                    }
                    catch (Exception ex)
                    {
                        alert_placeholder.Visible = true;
                        alert_placeholder.Attributes["class"] = "alert alert-success alert-dismissable";
                        alertText.Text = ex.Message;
                        //Response.Redirect("Error.aspx");
                    }
                    finally
                    {
                        con.Close();
                    }
                }
            }
        }
    }
}