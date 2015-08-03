using System;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;

namespace InstaKG
{        
    public partial class Chat : System.Web.UI.Page,IPostBackEventHandler
    {

        public static string  decryptedMessage = "too early execution";
        public int privateCounter = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected string getDecryptedMessage()
        {
            privateCounter++;
            // you can do more processing here
            //bool privateChat = ChatHub.inPrivate;
            //bool privateChat = true;

            JavaScriptSerializer jSerializer;

            decryptedMessage = refreshingDecryption();
            
            jSerializer = new JavaScriptSerializer();
            // processes in decrypting
            return jSerializer.Serialize(decryptedMessage);

            // use serializer class which provides serialization and deserialization functionality for AJAX-enabled applications.

            // serialize your object and return a serialized string
        }

        [WebMethod]
        public static string  refreshingDecryption()
        {

            decryptedMessage = ChatHub.decryptedOTR;
            return decryptedMessage;

        }


        public void RaisePostBackEvent(string eventArgument)
        {
            decryptedMessage = ChatHub.decryptedOTR;
        }
    }
}