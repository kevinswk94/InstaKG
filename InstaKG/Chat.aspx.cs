using System;
using System.Text;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;

namespace InstaKG
{        
    public partial class Chat : System.Web.UI.Page
    {

        public static string decryptedMessage = null;

        protected void Page_Load(object sender, EventArgs e)
        {
 
            
        }

        [WebMethod]
        public static string refreshingDecryption()
        {

            // Getting the decrypted value
            decryptedMessage = ChatHub.GetDecryptedOTR();
            return decryptedMessage;

        }

    }
}