using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Web;

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

                //watermark the image
                string fn = Guid.NewGuid() + Path.GetExtension(FileUpload1.PostedFile.FileName);
                Image upImage = Image.FromStream(FileUpload1.PostedFile.InputStream);
                using (Graphics g = Graphics.FromImage(upImage))
                {
                    //for transparency 
                    int opacity = 128;
                    SolidBrush brush = new SolidBrush(Color.FromArgb(opacity, Color.White));
                    Font font = new Font("Haettenschweiler", 16);
                    g.DrawString(tb_watermark.Text.Trim(), font, brush, new PointF(0, 0));
                    upImage.Save(Path.Combine(Server.MapPath("~/WaterMarking"), fn));
                    string pathName = Path.Combine(Server.MapPath("~/WaterMarking"), fn);
                    Session["path"] = pathName;
                    //Image1.ImageUrl = "~/WaterMarking" + "//" + fn;
                }

                // Read the file and convert it to Byte Array
                string filePath = Session["path"].ToString();
                string filename = Path.GetFileName(filePath);

                FileStream fs = new FileStream(filePath, FileMode.Open, FileAccess.Read);
                BinaryReader br = new BinaryReader(fs);
                Byte[] bytes = br.ReadBytes((Int32)fs.Length);
                br.Close();
                fs.Close();

                // Saving the iamge to DB
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
                    //cmd.Parameters.Add("@imgData", SqlDbType.Image, imgData.Length).Value = imgData; // YP, you're probably saving the unwatermarked image to the DB, not the watermarked version. May be wrong.
                    cmd.Parameters.Add("@imgData", SqlDbType.Binary).Value = bytes;
                    cmd.Parameters.AddWithValue("@imgtype", FileUpload1.PostedFile.ContentType);
                    cmd.Parameters.AddWithValue("@uploadDT", dt);
                    cmd.Parameters.AddWithValue("@accID", Session["accountID"].ToString());

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        alert_placeholder.Visible = true;
                        alert_placeholder.Attributes["class"] = "alert alert-success alert-dismissable";
                        alertText.Text = "Successfully Uploaded!";

                        //lb_EndInfo.Text = "Successfully uploaded!";
                        //String filePath = "~/images/" + FileUpload1.FileName;
                        //FileUpload1.SaveAs(Server.MapPath(filePath));
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
                    alert_placeholder.Visible = true;
                    alert_placeholder.Attributes["class"] = "alert alert-warning alert-dismissable";
                    alertText.Text = "You can only upload jpg or png file.";
                    //lb_EndInfo.Text = "You can only upload jpg or png file.";
                }
            }
            else
            {
                alert_placeholder.Visible = true;
                alert_placeholder.Attributes["class"] = "alert alert-warning alert-dismissable";
                alertText.Text = "Please select image!";
                //lb_EndInfo.Text = "Please Select Image!";
            }
        }

        protected void btn_cancel_Click(object sender, EventArgs e)
        {

        }
    }
}