using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace InstaKG
{
    public partial class Chat : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected string getDecryptedMessage()
    {
        // you can do more processing here
        //bool privateChat = ChatHub.inPrivate;
        //bool privateChat = true;

        JavaScriptSerializer jSerializer;
        string decryptedMessage;

        
            //decryptedMessage = ChatHub.decryptedOTR;
        decryptedMessage = ChatHub.decryptedOTR;
            jSerializer = new JavaScriptSerializer();
            // processes in decrypting
            return jSerializer.Serialize(decryptedMessage);
        
       

        // use serializer class which provides serialization and deserialization functionality for AJAX-enabled applications.


        // serialize your object and return a serialized string

    }

    }
}