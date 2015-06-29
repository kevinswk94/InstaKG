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
        protected void Page_Load(object sender, EventArgs e)
        {
            string imageUrl = "~/ImageViewerHandler.ashx?id=" + ddl_imageTitle.SelectedValue.ToString();
            img_selectedImage.ImageUrl = Page.ResolveUrl(imageUrl);
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
                    cmd.Parameters.AddWithValue("@ImageID", ddl_imageTitle.SelectedValue);

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