﻿using InstaKG.Entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
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
    public partial class ViewProfile : System.Web.UI.Page
    {
        DOA data = new DOA();
        private string constr = ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) //first time load
            {
                displayProfile();
                getProfileImg();
                ///////////////////////////
                Repeater1.DataSource = FetchAllImagesInfo();
                Repeater1.DataBind();
            }
        }

        public string queryUsername()
        {
            return Request.QueryString["name"];
            //return Session["username"].ToString();
        }

        public void displayProfile()
        {

            string[] creds; 

            if(queryUsername() == null)
            {
                creds = getCreds(Session["username"].ToString());
            }
            else
            {
                creds = getCreds(queryUsername());
            }


            //int id = data.retrieveIDByUsername(queryUsername());
             
            //get accID
            string id = creds[1];
            //Response.Write("id for display profile: " + id);
            string genderValue = null;

            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString;

            string sql = "SELECT fName,lName,email,birthdate,gender FROM Account WHERE accountID=@id";

            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@id", id);

            SqlDataReader dr;

            DataTable dt = new DataTable();

            con.Open();
            dr = cmd.ExecuteReader();

            dt.Load(dr);

            lbl_fname_value.Text = dt.Rows[0]["fName"].ToString();
            lbl_lname_value.Text = dt.Rows[0]["lName"].ToString();
            lbl_email_value.Text = dt.Rows[0]["email"].ToString();
            genderValue = dt.Rows[0]["gender"].ToString();

            if (genderValue.Length == 0)
            {
                lbl_gender_value.Visible = false;
                lbl_gender.Visible = false;
            }
            else
            {
                if (genderValue.Equals("0"))
                {
                    lbl_gender_value.Text = "Male";
                }
                else
                {
                    lbl_gender_value.Text = "Female";
                }
            }

            con.Close();

        }

        ////////////////////////////////////////////////////

        private DataTable FetchAllImagesInfo()
        {
            DataTable dt = new DataTable();
            SqlConnection con = new SqlConnection(constr);
            SqlDataAdapter sda = new SqlDataAdapter();

            //Dummy session of a particular user id
            //Session["accountID"] = 1;
            //int accId = data.retrieveIDByUsername(queryUsername());

            string[] creds;

            if (queryUsername() == null)
            {
                creds = getCreds(Session["username"].ToString());
            }
            else
            {
                creds = getCreds(queryUsername());
            }
            //get accID
            string accId = creds[1];
            //Response.Write("id for fetch all img: " + accId);
            string strQuery = "Select TOP 3 * from Image where accountID= @ID ORDER BY imageID DESC";

            SqlCommand cmd = new SqlCommand(strQuery);
            cmd.Parameters.AddWithValue("@ID", accId);
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;

            try
            {
                con.Open();
                sda.SelectCommand = cmd;
                sda.Fill(dt);
                return dt;
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
                return null;
            }
        }

        protected void lb_gallery_Click(object sender, EventArgs e)
        {
            string url = "ViewGallery.aspx?name=" + queryUsername();

            Response.Redirect(url);
        }



        protected List<object[]> returnGPSdata()
        {
            // Gets all coordinates from DB, puts them in a list and then displays them to screen

            List<object[]> imageProperties = new List<object[]>();
            List<object[]> coordinates = new List<object[]>();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString))
            {
                con.Open();
                string sql = "SELECT imageID, imageTitle, imageData FROM Image WHERE (accountID=@AccountID)";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@AccountID", data.retrieveIDByUsername(queryUsername()));
                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    imageProperties.Add(new object[] { dr["imageID"], dr["imageTitle"].ToString(), (byte[])dr["imageData"] });
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

        //protected void ChangeProf_Click(object sender, EventArgs e)
        //{
        //    Response.Redirect("FaceReco.aspx");
        //}

        private void getProfileImg()
        {
            string[] creds;

            if (queryUsername() == null)
            {
                creds = getCreds(Session["username"].ToString());
            }
            else
            {
                creds = getCreds(queryUsername());
            }
            //get accID
            string id = creds[1];
            //Response.Write("id for prof img: " + id);
           
            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString;

            string sql = "SELECT profilePic FROM ProfilePic WHERE accountID=@id";

            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@id", Int32.Parse(id));

            SqlDataReader dr;

            DataTable dt = new DataTable();

            con.Open();
            dr = cmd.ExecuteReader();

            dt.Load(dr);

            byte[] pic = (byte[])dt.Rows[0]["profilePic"];
            img_profImg.Attributes["src"] = "data:image/jpg;base64," + Convert.ToBase64String(pic);
            con.Close();
            con.Dispose();
        }

        private string[] getCreds(string username)
        {
            //get credentials by username
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString))
            {
                string query = "SELECT * FROM dbo.AccCreds WHERE username=@username";
                string[] creds = new string[3];

                con.Open();
                SqlCommand cmd1 = new SqlCommand(query, con);
                cmd1.Parameters.AddWithValue("@username", username);
                SqlDataReader dr = cmd1.ExecuteReader();

                //save creds to array
                while (dr.Read())
                {
                    creds[0] = (string)dr["username"];
                    creds[1] = dr["accountID"].ToString();
                    creds[2] = (string)dr["passwordHash"];
                }
                dr.Close();
                con.Close();
                con.Dispose();

                return creds;
            }
        }
    }
}