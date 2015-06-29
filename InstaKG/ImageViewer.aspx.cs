using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace InstaKG
{
    public partial class ImageViewer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string imageUrl = "~/ImageViewerHandler.ashx?id=" + ddl_imageTitle.SelectedValue.ToString();
            img_selectedImage.ImageUrl = Page.ResolveUrl(imageUrl);
        }
    }
}