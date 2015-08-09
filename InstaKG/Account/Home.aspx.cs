using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace InstaKG
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void logout(Object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            //Session["username"] = null;
            //Session["accountID"] = null;
            Session.RemoveAll();
            Response.Redirect("/Account/Login.aspx", true);
        }
    }
}