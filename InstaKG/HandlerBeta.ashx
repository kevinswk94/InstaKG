<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;
using System.Collections;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO;
public class Handler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        HttpRequest request = context.Request;
        if (!string.IsNullOrEmpty(request.QueryString["id"]))
        {
            //this hash table contain the SP parameter
            Hashtable hash = new Hashtable();
            hash.Add("@imageID", request.QueryString["id"]);
            DataBaseHelper DBHelper = new DataBaseHelper();

            //DBHelper.SQLExecuteNonQuery(procedure_name,command_parameters) return the object data.
            // casting return value to byte[]
            byte[] imageByte = (byte[])DBHelper.SQLExecuteNonQuery("sp_getImage", hash);
            //checking byte[] 
            if (imageByte != null && imageByte.Length > 0)
            {
                
                    context.Response.ContentType = "image/jpeg";
                    context.Response.BinaryWrite(imageByte);
                
            }


            #region Method2
            ////creating object of image
            //System.Drawing.Image b;
            ////creating object of bitmap
            //Bitmap bitMap = null;
            ////checking byte[] 
            //if (imageByte != null && imageByte.Length > 0)
            //{
            //    //creating memoryStream object
            //    using (MemoryStream mm = new MemoryStream())
            //    {
            //        //wrting to memoryStream
            //        mm.Write(imageByte, 0, imageByte.Length);
            //        b = System.Drawing.Image.FromStream(mm);
            //        bitMap = new System.Drawing.Bitmap(b, b.Width, b.Height);
            //        //creating graphic object, to produce High Quality images.
            //        using (Graphics g = Graphics.FromImage(bitMap))
            //        {
            //            g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
            //            g.SmoothingMode = SmoothingMode.HighQuality;
            //            g.CompositingQuality = System.Drawing.Drawing2D.CompositingQuality.HighQuality;
            //            g.DrawImage(bitMap, 0, 0, b.Width, b.Height);
            //            g.Dispose(); b.Dispose(); mm.Dispose();
            //            //changing content type of handler page
            //            context.Response.ContentType = "image/jpeg";
            //            //saving bitmap image
            //            bitMap.Save(context.Response.OutputStream, System.Drawing.Imaging.ImageFormat.Jpeg);
            //            bitMap.Dispose();
            //        }
            //    }
            //}
            #endregion



        }
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}