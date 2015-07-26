using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Runtime.Serialization.Formatters.Binary;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace InstaKG
{
    public partial class ViewAllLocations_Test : System.Web.UI.Page
    {
        protected string[] TitleArray;
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected List<object[]> returnGPSdata()
        {
            // Gets all coordinates from DB, puts them in a list and then displays them to screen

            List<object[]> imageProperties = new List<object[]>();
            List<object[]> coordinates = new List<object[]>();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString))
            {
                con.Open();
                string sql = "SELECT imageID, imageTitle, imageData FROM Image";

                SqlCommand cmd = new SqlCommand(sql, con);
                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    imageProperties.Add(new object[] { dr["imageID"], dr["imageTitle"].ToString() ,(byte[])dr["imageData"] });
                }

                dr.Close();
                cmd.Dispose();
                con.Close();

            }

            int i = 0;
            foreach (object[] ob in imageProperties)
            {
                byte[] bt = (byte[])ob[2];
                double? latitude;
                double? longitude;

                Stream stream = new MemoryStream(bt);
                System.Drawing.Image img2 = System.Drawing.Image.FromStream(stream);

                latitude = GetLatitude(img2);
                
                if (!latitude.Equals(null))
                {
                    latitude = Convert.ToDouble(String.Format("{0:0.###}", latitude));
                }
                else
                {
                    //latitude = 0.0;
                    continue;
                }

                // Retrieve longitude from Image data and write to page
                longitude = GetLongitude(img2);
                if (!longitude.Equals(null))
                {
                    longitude = Convert.ToDouble(String.Format("{0:0.###}", longitude));
                }
                else
                {
                    //longitude = 0.0;
                    continue;
                }

                coordinates.Add(new object[] { latitude, longitude, ob[1], ob[0] });
                i++;
            }

            return coordinates;
        }

        protected static string Serialize(object o)
        {
            JavaScriptSerializer js = new JavaScriptSerializer();
            return js.Serialize(o);
        }

        public static double? GetLatitude(System.Drawing.Image targetImg)
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
        public static double? GetLongitude(System.Drawing.Image targetImg)
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

        private byte[] ObjectToByteArray(Object obj)
        {
            if (obj == null)
                return null;
            BinaryFormatter bf = new BinaryFormatter();
            using (MemoryStream ms = new MemoryStream())
            {
                bf.Serialize(ms, obj);
                return ms.ToArray();
            }
        }
    }
}