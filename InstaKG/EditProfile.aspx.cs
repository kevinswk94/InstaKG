using InstaKG.Entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace InstaKG
{
    public partial class EditProfile : System.Web.UI.Page
    {
        DOA data = new DOA();

        protected void Page_Load(object sender, EventArgs e)
        {
            getProfileImg();
            if (!IsPostBack)
            {
                string []value = loadData();

                tb_email.Text = value[0];
                tb_fname.Text = value[1];
                tb_lname.Text = value[2];

                if (value[3].Equals("0"))
                {
                    rbl_gender.SelectedValue = "Male";
                }
                else if (value[3].Equals("1"))
                {
                    rbl_gender.SelectedValue = "Female";
                }
            }

        }
        public string[] loadData()
        {
            //int id = data.retrieveIDByUsername(Session["username"].ToString());
            string[] creds = getCreds(Session["username"].ToString());
            //get accID
            string id = creds[1];
            //Response.Write("id for loadData" + id);
            string []value = new string[4];

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

            value[0] = dt.Rows[0]["email"].ToString();
            value[1] = dt.Rows[0]["fname"].ToString();
            value[2] = dt.Rows[0]["lname"].ToString();
            value[3] = dt.Rows[0]["gender"].ToString();

            con.Close();

            return value;
        }

        protected void btn_update_user_Click(object sender, EventArgs e)
        {
            string []value = loadData();

            string []updateValue = new string[3];
            
            bool check1 = false;
            bool check2 = false;
            bool check3 = false;

            bool updateCheck = false;

            if(value[1].Equals(tb_fname.Text))
            {
                updateValue[0] = value[1];
                check1 = true;
            }
            else
            {
                updateValue[0] = tb_fname.Text;                
            }

            if(value[2].Equals(tb_lname.Text))
            {
                updateValue[1] = value[2];
                check2 = true;             
            }
            else
            {
                updateValue[1] = tb_lname.Text;
            }
                        
            if(value[3].Equals(null))
            {                
                updateValue[2] = rbl_gender.SelectedValue;
            }
            else
            {
                updateValue[2] = rbl_gender.SelectedValue;
            }

            ///////////////////////////////////////////////////////////////

            if (updateValue[2].Equals("Male"))
            {
                updateValue[2] = "0";           //Male
            }
            else
            {
                updateValue[2] = "1";           //Female
            }

            if(value[3].Equals(updateValue[2]))
            {
                check3 = true;
            }           
            
            //////////////////////////////////////////////

            if (check1 == true && check2 == true && check3 == true)
            {
                alert_placeholder.Visible = true;
                alert_placeholder.Attributes["class"] = "alert alert-dismissible alert-info";
                alertText.Text = "No update done";
            }
            else
            {
                updateCheck = updateAllDetails(updateValue[0], updateValue[1], updateValue[2]);

                if(updateCheck == true)
                {
                    alert_placeholder.Visible = true;
                    alert_placeholder.Attributes["class"] = "alert alert-dismissible alert-success";
                    alertText.Text = "Update Successfully";
                }
                else
                {
                    alert_placeholder.Visible = true;
                    alert_placeholder.Attributes["class"] = "alert alert-dismissible alert-dismissable";
                    alertText.Text = "Update Error";
                }

                
            }

            
        }
        public bool updateAllDetails(string fname, string lname, string gender)
        {
            bool check = false;
            string[] creds = getCreds(Session["username"].ToString());
            //get accID
            string id = creds[1];

            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString;

            string sql = "UPDATE Account SET fName=@fname,lname=@lname,gender=@gender WHERE accountID=@id";

            SqlCommand cmd = new SqlCommand(sql, con);
            
            cmd.Parameters.AddWithValue("@fname", fname);
            cmd.Parameters.AddWithValue("@lname", lname);
            cmd.Parameters.AddWithValue("@gender", gender);
            cmd.Parameters.AddWithValue("@id", id);
            //Response.Write("id for update all details: " + id);


            con.Open();

            int count;

            count = Convert.ToInt32(cmd.ExecuteScalar());

            if (count == 0)
            {
                check = true;
            }
            else
            {
                check = false;
            }

            con.Close();
            con.Dispose();


            return check;
        }


        ////////////////////////////////////////////////


        protected void btn_update_pw_Click(object sender, EventArgs e)
        {
            
            if(Page.IsValid)
            {
                string username = Session["Username"].ToString();

                string salt = retrieveSalt(username);

                string[] creds = getCreds(Session["username"].ToString());
                //get accID
                string id = creds[1];

                //match the current password
                if(authenticatePassword(tb_currentpw.Text, salt))
                {
                    if (tb_newpw.Text.Trim().Equals(tb_confirmpw.Text.Trim()))
                    {
                        if(updatePassword(tb_confirmpw.Text, Int32.Parse(id),salt))
                        {
                            //Response.Write("id for update password: " + id);
                            alert_placeholder.Visible = true;
                            alert_placeholder.Attributes["class"] = "alert alert-success alert-dismissable";
                            alertText.Text = "Successfully Updated";
                        }
                        else
                        {
                            Response.Redirect("Error.aspx");
                        }                       
                    }
                    else
                    {
                        alert_placeholder.Visible = true;
                        alert_placeholder.Attributes["class"] = "alert alert-danger alert-dismissable";
                        alertText.Text = "Inconsistent New Password";
                    }
                }
                else
                {
                    alert_placeholder.Visible = true;
                    alert_placeholder.Attributes["class"] = "alert alert-danger alert-dismissable";
                    alertText.Text = "Invalid Password";
                }
            }

            tb_currentpw.Text = string.Empty;
            tb_newpw.Text = string.Empty;
            tb_confirmpw.Text = string.Empty;
        }

        private static string retrieveSalt(string username)
        {
            string salt = "";

            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString;

            string sql = "SELECT passwordSalt FROM AccCreds WHERE username=@username";

            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@username", username);

            con.Open();

            object result = cmd.ExecuteScalar();

            if (result == null)
            {
                salt = "-1";
            }
            else
            {
                salt = result.ToString();
            }

            return salt;
        }

        private static bool authenticatePassword(string password, string salt)
        {
            bool valid = false;

            var hash = new SHA1Managed().ComputeHash(Encoding.UTF8.GetBytes(salt + password));

            string hashPassword = Convert.ToBase64String(hash);

            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString;

            string sql = "SELECT COUNT(*) FROM AccCreds WHERE passwordHash=@password";

            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@password", hashPassword);

            con.Open();

            int result = int.Parse(cmd.ExecuteScalar().ToString());

            if (result == 1)
            {
                valid = true;
            }
            else
            {
                valid = false;
            }

            con.Close();
            con.Dispose();

            return valid;
        }

        private static bool updatePassword(string password, int id, string salt)
        {
            bool valid = false;

            var hash = new SHA1Managed().ComputeHash(Encoding.UTF8.GetBytes(salt + password));

            string hashPasword = Convert.ToBase64String(hash);

            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString;

            string sql = "UPDATE AccCreds SET passwordHash=@hash WHERE accountID=@id";

            SqlCommand cmd = new SqlCommand(sql, con);

            cmd.Parameters.AddWithValue("@hash", hashPasword);
            cmd.Parameters.AddWithValue("id", id);

            con.Open();

            int count;

            count = Convert.ToInt32(cmd.ExecuteScalar());

            if(count == 0)
            {
                valid = true;
            }
            else
            {
                valid = false;
            }

            con.Close();
            con.Dispose();

            return valid;

        }

        protected void ChangeProf_Click(object sender, EventArgs e)
        {
            Response.Redirect("FaceReco.aspx");
        }

        private void getProfileImg()
        {
            string[] creds = getCreds(Session["username"].ToString());
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