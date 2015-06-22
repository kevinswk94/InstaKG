using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace InstaKG
{
    public partial class Test : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            alert_placeholder.Visible = true;
            alert_placeholder.Attributes["class"] = "alert alert-success alert-dismissable";
            alertText.Text = "Account ID is " + Session["accountID"].ToString();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Session["username"] = "kevin";
            Response.Redirect("TestNavBar.aspx");
        }
    }
}