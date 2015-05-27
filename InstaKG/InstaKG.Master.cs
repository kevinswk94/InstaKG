using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace InstaKG
{
    public partial class InstaKG : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void logout(Object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Response.Redirect("/Account/Login.aspx");
        }
    }
}