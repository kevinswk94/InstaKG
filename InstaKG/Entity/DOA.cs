using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace InstaKG.Entity
{
    public class DOA
    {
        public List<User> retriveUsernameList()         //ONLY USERNAME
        {
            List<User> usernameList = new List<User>();

            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString;

            string sql = "SELECT username FROM AccCreds";

            SqlCommand cmd = new SqlCommand(sql, con);

            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    usernameList.Add(new User(dr[0].ToString()));
                }

            }
            catch (Exception e)
            {
                System.Diagnostics.Debug.WriteLine("Error Occurred: " + e);
            }
            finally
            {
                con.Close();
            }

            return usernameList;
        }

        public List<User> retrieveUserList()                //ALL 2 ITEMS
        {
            List<User> userList = new List<User>();

            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString;

            string sql = "SELECT * FROM AccCreds";

            SqlCommand cmd = new SqlCommand(sql, con);

            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    userList.Add(new User(Int32.Parse(dr[0].ToString()), dr[1].ToString()));
                }

            }
            catch (Exception e)
            {
                System.Diagnostics.Debug.WriteLine("Error Occurred: " + e);
            }
            finally
            {
                con.Close();
            }

            return userList;
        }

        public List<Images> retrieveImageTitleList()             //ONLY IMAGE TITLE
        {
            List<Images> titleList = new List<Images>();

            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString;

            string sql = "SELECT imageTitle FROM Image";

            SqlCommand cmd = new SqlCommand(sql, con);

            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    titleList.Add(new Images(dr[0].ToString()));
                }

            }
            catch (Exception e)
            {
                System.Diagnostics.Debug.WriteLine("Error Occurred: " + e);
            }
            finally
            {
                con.Close();
            }

            return titleList;
        }

        public List<Images> retrieveImageList()              // ALL 7 ITEMS
        {
            List<Images> imageList = new List<Images>();

            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString;

            string sql = "SELECT * FROM Image";

            SqlCommand cmd = new SqlCommand(sql, con);

            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    imageList.Add(new Images(Int32.Parse(dr[0].ToString())
                        , dr[1].ToString()
                        , dr[2].ToString()
                        , dr[3].ToString()
                        , dr[4].ToString()
                        , DateTime.Parse(dr[5].ToString())
                        , Int32.Parse(dr[6].ToString()))); //System.Globalization.CultureInfo.InvariantCulture
                   
                }

            }
            catch (Exception e)
            {
                System.Diagnostics.Debug.WriteLine("Error Occurred: " + e);
            }
            finally
            {
                con.Close();
            }


            return imageList;
        }

        //////////////////////////////////////////////////////////////////

        public string retrieveUsernameByID(int ID)
        {
            string username = null;

            try
            {
                SqlConnection con = new SqlConnection();
                con.ConnectionString = ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString;

                string sql = "SELECT username FROM AccCreds where accCredID=@id";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@id", ID);

                con.Open();
                username = Convert.ToString(cmd.ExecuteScalar());
                con.Close();

                
            }
            catch(Exception e)
            {
                System.Diagnostics.Debug.WriteLine(e.Message);
            }

            return username;

        }

        public int retrieveIDByUsername(string username)
        {
            int id = 0;

            try
            {
                SqlConnection con = new SqlConnection();
                con.ConnectionString = ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString;

                string sql = "SELECT accCredID FROM AccCreds WHERE username=@username";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@username", username);

                con.Open();
                id = Convert.ToInt32(cmd.ExecuteScalar());
                con.Close();
            }
            catch(Exception e)
            {
                System.Diagnostics.Debug.Write(e.Message);
            }

            return id;
        }

        public int retrieveAccIDByImageID(int imageID)
        {
            int id = 0;
            
            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString;

            string sql = "SELECT accountID FROM Image WHERE imageID=@id";

            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@id", imageID);

            con.Open();
            id = Convert.ToInt32(cmd.ExecuteScalar());
            con.Close();

            return id;
        }

    }
}