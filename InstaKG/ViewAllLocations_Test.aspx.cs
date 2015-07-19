using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
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
            //printArray();
            //getTitleArray();
            //returnGPS();
        }

        private void pullTitles()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString))
            {
                con.Open();
                string sql = "SELECT Image.imageTitle FROM Image";

                SqlCommand cmd = new SqlCommand(sql, con);
                SqlDataReader dr = cmd.ExecuteReader();

                // While reading from dr, print out image title
                while (dr.Read())
                {
                    // If title euqals "Jorji", skip printing it to screen
                    if (dr["imageTitle"].ToString().Equals("Jorji"))
                        continue;
                    else
                        Response.Write(dr["imageTitle"].ToString() + "<br />");
                }

                dr.Close();
                cmd.Dispose();
                con.Close();
            }
        }

        private void getTitleList()
        {
            // Gets all titles from DB, puts them in a list and then displays them to screen

            List<string> titleList = new List<string>();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString))
            {
                con.Open();
                string sql = "SELECT Image.imageTitle FROM Image";

                SqlCommand cmd = new SqlCommand(sql, con);
                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    titleList.Add(dr["imageTitle"].ToString());
                }

                dr.Close();
                cmd.Dispose();
                con.Close();
            }

            foreach (string str in titleList)
            {
                if (str.Equals("Jorji"))
                    continue;
                else
                    Response.Write(str + "<br />");
            }
        }

        private void getTitleArray()
        {
            string[] titleArray = new string[20];

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString))
            {
                con.Open();
                string sql = "SELECT Image.imageTitle FROM Image";

                SqlCommand cmd = new SqlCommand(sql, con);
                SqlDataReader dr = cmd.ExecuteReader();
                int i = 0;
                while (dr.Read())
                {
                    titleArray[i] = (dr["imageTitle"].ToString());
                    i++;
                }


                dr.Close();
                cmd.Dispose();
                con.Close();
            }

            for (int i = 0; i < titleArray.Length; i++)
            {
                if (titleArray[i] == null)
                    continue;
                else
                    Response.Write(titleArray[i].ToString() + "<br />");
            }
        }

        public string[] returnTitleArray()
        {
            TitleArray = new string[20];

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString))
            {
                con.Open();
                string sql = "SELECT Image.imageTitle FROM Image";

                SqlCommand cmd = new SqlCommand(sql, con);
                SqlDataReader dr = cmd.ExecuteReader();
                int i = 0;
                while (dr.Read())
                {
                    TitleArray[i] = (dr["imageTitle"].ToString());
                    i++;
                }


                dr.Close();
                cmd.Dispose();
                con.Close();
            }

            return TitleArray;
        }

        protected void returnGPS()
        {
            // Gets all titles from DB, puts them in a list and then displays them to screen

            List<byte[]> imageDataList = new List<byte[]>();
            List<double?[]> coordinates = new List<double?[]>();
            

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString))
            {
                con.Open();
                string sql = "SELECT imageData FROM Image";

                SqlCommand cmd = new SqlCommand(sql, con);
                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    imageDataList.Add((byte[])dr["imageData"]);
                }

                dr.Close();
                cmd.Dispose();
                con.Close();

            }

            foreach (byte[] bt in imageDataList)
            {
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

                coordinates.Add(new double?[] {latitude, longitude});
            }

            foreach (double?[] dou in coordinates)
            {
                Response.Write("Latitude: " + dou[0] + ", Longitude: " + dou[1] + "<br />");
            }
        }

        protected List<double?[]> returnGPS2()
        {
            // Gets all titles from DB, puts them in a list and then displays them to screen

            List<byte[]> imageDataList = new List<byte[]>();
            List<double?[]> coordinates = new List<double?[]>();


            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString))
            {
                con.Open();
                string sql = "SELECT imageData FROM Image";

                SqlCommand cmd = new SqlCommand(sql, con);
                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    imageDataList.Add((byte[])dr["imageData"]);
                }

                dr.Close();
                cmd.Dispose();
                con.Close();

            }

            foreach (byte[] bt in imageDataList)
            {
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
                    latitude = 0.0;
                    //continue;
                }

                // Retrieve longitude from Image data and write to page
                longitude = GetLongitude(img2);
                if (!longitude.Equals(null))
                {
                    longitude = Convert.ToDouble(String.Format("{0:0.###}", longitude));
                }
                else
                {
                    longitude = 0.0;
                    //continue;
                }

                coordinates.Add(new double?[] { latitude, longitude });
            }

            return coordinates;
        }

        public string[,] returnTitles2()
        {
            string[,] strArray = new string[2, 2];
            strArray[0, 0] = "Hello";
            strArray[0, 1] = "Can";
            strArray[1, 0] = "You";
            strArray[1, 1] = "Read";

            return strArray;
        }

        public List<string[]> returnTitles3()
        {
            List<string[]> array2d = new List<string[]>();
            array2d.Add(new string[] { "Hello", "World" });
            array2d.Add(new string[] { "Can", "You" });
            array2d.Add(new string[] { "Read", "Me" });

            return array2d;
        }

        // Most likely to use for parsing gps data
        protected List<double[]> returnGPSdata()
        {
            List<double[]> data = new List<double[]>();
            data.Add(new double[] { -33.856, 151.22 });
            data.Add(new double[] { 39.739, -104.99 });
            data.Add(new double[] { 39.739, -104.992 });

            return data;
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
    }
}