using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Configuration;

namespace InstaKG
{
    public partial class UploadImg : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_Submit_Click(object sender, EventArgs e)
        {
            //string path = Server.MapPath("Images/");

            //check for file selection
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

                if (ext.Equals(".jpg") || ext.Equals(".JPG") || ext.Equals(".PNG") || ext.Equals(".png"))
                {
                    string sql = "Insert into Image(imageTitle, imageDescription, imageData, imageType, uploadDateTime, accountID)";
                    sql = sql + "Values (@imgTitle, @imgDescription, @imgData, @imgType, @uploadDT, @accID)";

                    SqlConnection con = new SqlConnection();
                    con.ConnectionString = ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString;
                    SqlCommand cmd = new SqlCommand(sql, con);

                    //set up parameters
                    cmd.Parameters.AddWithValue("@imgTitle", tb_ImageTitle.Text);
                    cmd.Parameters.AddWithValue("@imgDescription", tb_ImageDescription.Text);
                    cmd.Parameters.Add("@imgData", SqlDbType.Image, imgData.Length).Value = imgData;
                    cmd.Parameters.AddWithValue("@imgtype", FileUpload1.PostedFile.ContentType);
                    cmd.Parameters.AddWithValue("@uploadDT", dt);
                    cmd.Parameters.AddWithValue("@accID", 1);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        lb_EndInfo.Text = "Successfully uploaded!";
                        String filePath = "~/images/" + FileUpload1.FileName;
                        FileUpload1.SaveAs(Server.MapPath(filePath));
                       // Response.Write(filePath);
                      
                        

                    }
                    catch (Exception ex)
                    {
                        lb_EndInfo.Text = "Error: " + ex.Message;
                    }
                    finally
                    {
                        con.Close();
                        con.Dispose();
                        tb_ImageTitle.Text = "";
                        tb_ImageDescription.Text = "";
                    }
                }
                else
                {
                    lb_EndInfo.Text = "You can only upload jpg or png file.";
                }


            }
            else
            {
                lb_EndInfo.Text = "Please Select Image!";
            }
        }

        protected void btn_cancel_Click(object sender, EventArgs e)
        {

        }
    }
}