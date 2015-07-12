using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Web;

namespace InstaKG
{
    public partial class ImgLocation : System.Web.UI.Page
    {
        protected double? latitude;
        protected double? longitude;

        protected int imageID = 9;

        // To test pulling EXIF data from file on disk
        //protected static string dir = HttpContext.Current.Request.PhysicalApplicationPath.ToString();
        //System.Drawing.Image img = System.Drawing.Image.FromFile(dir + "1024-2006_1011_093752.jpg");
        protected void Page_Load(object sender, EventArgs e)
        {
            // Getting image data from InstaKG DB
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString);
            con.Open();
            string sql = "Select * from Image where imageID=@imageID";
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@imageID", imageID); // Getting data from image ID
            SqlDataReader dr = cmd.ExecuteReader();
            dr.Read();

            // Retrieve imageData from DataReader and convert into byte array
            byte[] imgBytes = (byte[])dr["imageData"];
            
            //byte[] imageType = System.Text.Encoding.UTF8.GetBytes(dr["imageType"].ToString());
            //byte[] data = Combine(imageType, imgBytes);
            //Response.Write(imgBytes.ToString());
            //Response.Write(strBytes);

            // Close data reader and connection string
            dr.Close();
            con.Close();

            // Convert imgBytes byte array into stream
            Stream stream = new MemoryStream(imgBytes);

            // Create Drawing.Image from stream data
            System.Drawing.Image img2 = Image.FromStream(stream);

            //double? latitude = GetLatitude(img);
            //latitude = Convert.ToDouble(String.Format("{0:0.##}", latitude));
            //Response.Write(latitude);

            //double? longitude = GetLongitude(img);
            //longitude = Convert.ToDouble(String.Format("{0:0.##}", longitude));
            //Response.Write(longitude);

            // Retrieve latitude from Image data and write to page
            latitude = GetLatitude(img2);
            if (!latitude.Equals(null))
            {
                latitude = Convert.ToDouble(String.Format("{0:0.###}", latitude));
                Response.Write("Latitude: " + latitude + "<br />");
            }
            else
            {
                latitude = 0.0;
                Response.Write("Latitude: Not Found <br />");
            }
            
            // Retrieve longitude from Image data and write to page
            longitude = GetLongitude(img2);
            if (!longitude.Equals(null))
            {
                longitude = Convert.ToDouble(String.Format("{0:0.###}", longitude));
                Response.Write("Longitude: " + longitude + "<br />");
            }
            else
            {
                longitude = 0.0;
                Response.Write("Longitude: Not Found <br />");
            }
            
            //Image1.ImageUrl = "http://maps.google.com/maps/api/staticmap?center=151.21,-33.85&zoom=8&size=400x300&sensor=false"; <---- Kept as backup to remember url structure
            
            // Displays map of coordinates taken from the image from DB
            //Image1.ImageUrl = "http://maps.google.com/maps/api/staticmap?center=" + latitude +  "," + longitude + "&zoom=9&size=400x300&sensor=false";
        }

        public static double? GetLatitude(Image targetImg)
        {
            try
            {
                //Property Item 0x0001 - PropertyTagGpsLatitudeRef
                PropertyItem propItemRef = targetImg.GetPropertyItem(0x0001);
                //Property Item 0x0002 - PropertyTagGpsLatitude
                PropertyItem propItemLat = targetImg.GetPropertyItem(0x0002);
                return ExifGpsToDouble(propItemRef, propItemLat);
            }
            catch (ArgumentException)
            {
                return null;
            }
        }
        public static double? GetLongitude(Image targetImg)
        {
            try
            {
                //Property Item 0x0003 - PropertyTagGpsLongitudeRef
                PropertyItem propItemRef = targetImg.GetPropertyItem(0x0003);
                //Property Item 0x0004 - PropertyTagGpsLongitude
                PropertyItem propItemLong = targetImg.GetPropertyItem(0x0004);
                return ExifGpsToDouble(propItemRef, propItemLong);
            }
            catch (ArgumentException)
            {
                return null;
            }
        }

        // Convert EXIF data to double
        private static double ExifGpsToDouble(PropertyItem propItemRef, PropertyItem propItem)
        {
            double degreesNumerator = BitConverter.ToUInt32(propItem.Value, 0);
            double degreesDenominator = BitConverter.ToUInt32(propItem.Value, 4);
            double degrees = degreesNumerator / (double)degreesDenominator;

            double minutesNumerator = BitConverter.ToUInt32(propItem.Value, 8);
            double minutesDenominator = BitConverter.ToUInt32(propItem.Value, 12);
            double minutes = minutesNumerator / (double)minutesDenominator;

            double secondsNumerator = BitConverter.ToUInt32(propItem.Value, 16);
            double secondsDenominator = BitConverter.ToUInt32(propItem.Value, 20);
            double seconds = secondsNumerator / (double)secondsDenominator;


            double coorditate = degrees + (minutes / 60d) + (seconds / 3600d);
            string gpsRef = System.Text.Encoding.ASCII.GetString(new byte[1] { propItemRef.Value[0] }); //N, S, E, or W
            if (gpsRef == "S" || gpsRef == "W")
                coorditate = coorditate * -1;
            return coorditate;
        }

        // Convert EXIF data to float (not in use ATM)
        private static float ExifGpsToFloat(PropertyItem propItemRef, PropertyItem propItem)
        {
            uint degreesNumerator = BitConverter.ToUInt32(propItem.Value, 0);
            uint degreesDenominator = BitConverter.ToUInt32(propItem.Value, 4);
            float degrees = degreesNumerator / (float)degreesDenominator;

            uint minutesNumerator = BitConverter.ToUInt32(propItem.Value, 8);
            uint minutesDenominator = BitConverter.ToUInt32(propItem.Value, 12);
            float minutes = minutesNumerator / (float)minutesDenominator;

            uint secondsNumerator = BitConverter.ToUInt32(propItem.Value, 16);
            uint secondsDenominator = BitConverter.ToUInt32(propItem.Value, 20);
            float seconds = secondsNumerator / (float)secondsDenominator;

            float coorditate = degrees + (minutes / 60f) + (seconds / 3600f);
            string gpsRef = System.Text.Encoding.ASCII.GetString(new byte[1] { propItemRef.Value[0] }); //N, S, E, or W
            if (gpsRef == "S" || gpsRef == "W")
                coorditate = 0 - coorditate;
            return coorditate;
        }

        private byte[] Combine(byte[] a1, byte[] a2)
        {
            byte[] ret = new byte[a1.Length + a2.Length];
            Array.Copy(a1, 0, ret, 0, a1.Length);
            Array.Copy(a2, 0, ret, a1.Length, a2.Length);
            return ret;
        }
    }
}