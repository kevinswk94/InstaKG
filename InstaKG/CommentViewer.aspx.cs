using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace InstaKG
{
    public partial class CommentViewer_Test : System.Web.UI.Page
    {
        string imageID = "";
        protected string imageTitle = "";
        protected string imageDescription = "";
        protected string fName = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            imageID = Request.QueryString["imageID"];
            //string imageUrl = "~/ImageViewerHandler.ashx?id=" + ddl_imageTitle.SelectedValue.ToString();
            string imageUrl = "~/ImageViewerHandler.ashx?id=" + imageID;
            img_selectedImage.ImageUrl = Page.ResolveUrl(imageUrl);

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString))
            {
                con.Open();
                string sql = "SELECT Image.imageTitle, Image.imageDescription, Image.accountID, Account.accountID, Account.fName FROM Image INNER JOIN Account ON Image.accountID = Account.accountID WHERE (Image.imageID = @ImageID)";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("ImageID", imageID);
                //cmd.Prepare();
                
                SqlDataReader dr = cmd.ExecuteReader();
                dr.Read();
                imageTitle = dr["imageTitle"].ToString();
                imageDescription = dr["imageDescription"].ToString();
                fName = dr["fName"].ToString();
                
                dr.Close();
                cmd.Dispose();
                con.Close();
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString))
                {
                    string sql = "INSERT INTO dbo.Comment(commentDateTime, commentContent, commentAuthor, flag, imageID) VALUES (@CommentDateTime, @CommentContent, @CommentAuthor, @Flag, @ImageID)";
                    string commentContent = Server.HtmlEncode(tb_commentContent.Text);

                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@CommentDateTime", DateTime.Now);
                    cmd.Parameters.AddWithValue("@CommentContent", commentContent);
                    cmd.Parameters.AddWithValue("@CommentAuthor", Session["accountID"].ToString());
                    cmd.Parameters.AddWithValue("@Flag", 0);
                    cmd.Parameters.AddWithValue("@ImageID", imageID);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    con.Dispose();

                    alert_placeholder.Visible = true;
                    alert_placeholder.Attributes["class"] = "alert alert-success alert-dismissable";
                    alertText.Text = "Comment successfully posted!";
                    this.gv_comments.DataBind();

                    tb_commentContent.Text = String.Empty;
                }
            }
            else
            {
                alert_placeholder.Visible = true;
                alert_placeholder.Attributes["class"] = "alert alert-danger alert-dismissable";
                alertText.Text = "Username already taken. Please use another one.";
            }
        }

        protected void btn_cancel_Click(object sender, EventArgs e)
        {
            tb_commentContent.Text = String.Empty;
        }
    }
}