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
        public List<User> retriveUsername()         //ONLY USERNAME
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

        public List<Images> retrieveImageTitle()             //ONLY IMAGE TITLE
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
                    System.Diagnostics.Debug.WriteLine(dr[0].ToString() + " hello");
                    System.Diagnostics.Debug.WriteLine(dr[1].ToString() + " hello");
                    System.Diagnostics.Debug.WriteLine(dr[2].ToString() + " hello");
                    System.Diagnostics.Debug.WriteLine(dr[3].ToString() + " hello");
                    System.Diagnostics.Debug.WriteLine(dr[4].ToString() + " hello");
                    System.Diagnostics.Debug.WriteLine(dr[5].ToString() + " hello");

                    imageList.Add(new Images(Int32.Parse(dr[0].ToString())
                        , dr[1].ToString()
                        , dr[2].ToString()
                        , dr[3].ToString()
                        , dr[4].ToString()
                        , DateTime.Parse(dr[5].ToString()))); //System.Globalization.CultureInfo.InvariantCulture
                   
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
    }
}