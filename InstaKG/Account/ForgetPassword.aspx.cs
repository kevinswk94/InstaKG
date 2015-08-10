using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Security.Cryptography;
using System.Text;
using System.Web.Security;
using System.Web.UI.HtmlControls;
using System.Net;
using System.IO;
using System.Web.Script.Serialization;

namespace InstaKG
{
    public partial class ForgetPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Response.Redirect("~/ChangePassword.aspx");
            
        }

        protected void btn_Reset_Click(object sender, EventArgs e)
        {
            //get new random password
            string newPass = randomString();

            // Found a way to patch validation of ReCAPTCHA
            // https://stackoverflow.com/questions/27764692/validating-recaptcha-2-no-captcha-recaptcha-in-asp-nets-server-side

            if (tb_UsernameOrEmail.Text != null && tb_UsernameOrEmail.Text != "")
            {
                //have input
                //check for recaptcha validation
                //string EncodedResponse = Request.Form["g-Recaptcha-Response"];
                //bool IsCaptchaValid = (ReCaptchaClass.Validate(EncodedResponse) == "True" ? true : false);

                if (Validate())
                {
                    //Valid Request
                    if (AuthenticateUsername(tb_UsernameOrEmail.Text))
                    {
                        //valid username
                        //retrieve salt
                        string salt = RetrieveSalt(tb_UsernameOrEmail.Text);

                        //get creds of user
                        string[] creds = getCreds(tb_UsernameOrEmail.Text);

                        //get email address of user, creds[1] = accountID
                        string email = getEmail(creds[1]);

                        if (updatePassword(newPass, tb_UsernameOrEmail.Text, salt))
                        {
                            //sent email if valid
                            sentMail(newPass, email, tb_UsernameOrEmail.Text);

                            alert_placeholder.Visible = true;
                            alert_placeholder.Attributes["class"] = "alert alert-success alert-dismissable";
                            alertText.Text = "Please check email for new password.";
                            Response.AddHeader("REFRESH", "3;URL=../ChangePassword.aspx");

                        }
                        else
                        {
                            alert_placeholder.Visible = true;
                            alert_placeholder.Attributes["class"] = "alert alert-danger alert-dismissable";
                            alertText.Text = "ERROR! Please try again later.";
                            tb_UsernameOrEmail.Text = "";
                        }



                    }
                    else if (AuthenticateEmail(tb_UsernameOrEmail.Text))
                    {
                        //valid email

                        //get creds of user
                        string[] creds = getCreds1(tb_UsernameOrEmail.Text);

                        //get username, creds[1] = accID
                        string username = getUsername(creds[1]);

                        //get accID
                        string accID = creds[1];

                        //retrieve salt
                        string salt = RetrieveSalt(username);
                        

                        if (updatePassword(newPass, username, salt))
                        {
                            //sent mail if valid
                            sentMail(newPass, tb_UsernameOrEmail.Text, username);
                            

                            alert_placeholder.Visible = true;
                            alert_placeholder.Attributes["class"] = "alert alert-success alert-dismissable";
                            alertText.Text = "Please check email for new password.";

                            Response.AddHeader("REFRESH", "3;URL=../ChangePassword.aspx");


                        }
                        else
                        {
                            //alert_placeholder.Visible = true;
                            //alert_placeholder.Attributes["class"] = "alert alert-danger alert-dismissable";
                            //alertText.Text = "ERROR! Please try again later.";
                            //tb_UsernameOrEmail.Text = "";
                            Response.Write("~/Error.aspx");
                        }

                    }
                    else
                    {
                        //invalid
                        alert_placeholder.Visible = true;
                        alert_placeholder.Attributes["class"] = "alert alert-warning alert-dismissable";
                        alertText.Text = "Invalid username or email address.";
                        tb_UsernameOrEmail.Text = "";
                    }
                }

                

            }
            else
            {
                //no input
                alert_placeholder.Visible = true;
                alert_placeholder.Attributes["class"] = "alert alert-danger alert-dismissable";
                alertText.Text = "Please enter username or email address";
                tb_UsernameOrEmail.Text = "";
            }
        }

        public bool Validate()
        {
            string Response = Request["g-recaptcha-response"];//Getting Response String Append to Post Method
            bool Valid = false;
            //Request to Google Server
            HttpWebRequest req = (HttpWebRequest)WebRequest.Create
            (" https://www.google.com/recaptcha/api/siteverify?secret=6LdLjPYSAAAAAANviWnkDupG2Cp5j-8au4hH4qD2&response=" + Response);
            try
            {
                //Google recaptcha Response
                using (WebResponse wResponse = req.GetResponse())
                {

                    using (StreamReader readStream = new StreamReader(wResponse.GetResponseStream()))
                    {
                        string jsonResponse = readStream.ReadToEnd();

                        JavaScriptSerializer js = new JavaScriptSerializer();
                        MyObject data = js.Deserialize<MyObject>(jsonResponse);// Deserialize Json

                        Valid = Convert.ToBoolean(data.success);
                    }
                }

                return Valid;
            }
            catch (WebException ex)
            {
                throw ex;
            }
        }

        public class MyObject
        {
            public string success { get; set; }


        }

        private static bool AuthenticateUsername(string username)
        {
            bool isValid = false;
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString))
            {
                string sql = "SELECT COUNT(*) FROM dbo.AccCreds WHERE username=@username";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@username", username);

                con.Open();
                int result = int.Parse(cmd.ExecuteScalar().ToString());
                if (result == 1)
                {
                    isValid = true;
                    con.Close();
                    con.Dispose();
                }

                else
                {
                    isValid = false;
                    con.Close();
                    con.Dispose();
                }

            }

            return isValid;
        }

        private static bool AuthenticateEmail(string email)
        {
            bool isValid = false;
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString))
            {
                string sql = "SELECT COUNT(*) FROM dbo.Account WHERE email=@email";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@email", email);

                con.Open();
                int result = int.Parse(cmd.ExecuteScalar().ToString());
                if (result == 1)
                {
                    isValid = true;
                    con.Close();
                    con.Dispose();
                }

                else
                {
                    isValid = false;
                    con.Close();
                    con.Dispose();
                }
            }
            return isValid;
        }

        private string randomString()
        {
            var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz!@#$";
            var random = new Random();
            var result = new string(
                Enumerable.Repeat(chars, 8)
                          .Select(s => s[random.Next(s.Length)]).ToArray());

            return result;
        }

        private static bool updatePassword(string password, string username, string salt)
        {
            bool isValid = false;
            //Generate hash from salted password
            var hash = new SHA1Managed().ComputeHash(Encoding.UTF8.GetBytes(salt + password));
            string hashedPwd = Convert.ToBase64String(hash);

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString))
            {
                string sql = "UPDATE dbo.AccCreds SET passwordHash=@passwordHash WHERE username=@username";
                SqlCommand cmd = new SqlCommand(sql, con);

                cmd.Parameters.AddWithValue("@passwordHash", hashedPwd);
                cmd.Parameters.AddWithValue("@username", username);

                con.Open();

                int count;
                count = Convert.ToInt32(cmd.ExecuteScalar());
                // updated: count == 0
                if (count == 0)
                {
                    isValid = true;
                    con.Close();
                    con.Dispose();
                }
                else
                {
                    isValid = false;
                    con.Close();
                    con.Dispose();
                }
            }

            return isValid;
        }


        private static string RetrieveSalt(string username)
        {
            string salt = "";
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString))
            {
                string sql = "SELECT passwordSalt FROM dbo.AccCreds WHERE username=@username";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@username", username);

                con.Open();
                object result = cmd.ExecuteScalar();

                if (result == null)
                    salt = "-1";
                else
                    salt = result.ToString();
            }
            return salt;
        }

        private static void sentMail(string newPass, string email, string username)
        {
            System.Net.Mail.MailMessage message = new System.Net.Mail.MailMessage();
            message.To.Add(email);
            message.Subject = "Reset Password";
            message.From = new System.Net.Mail.MailAddress("forprojectonly1@hotmail.com");
            message.Body = "Hi " + username + ", \n" + "Your new random password is: " + newPass + "\n" + "Please use this password to change your current password.";
            System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient("smtp.live.com");
            smtp.Port = 587;
            smtp.EnableSsl = true;
            smtp.UseDefaultCredentials = false;
            smtp.Credentials = new System.Net.NetworkCredential("forprojectonly1@hotmail.com", "4project0nly1");
            smtp.Send(message);
        }

        private static string getEmail(string accID)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString))
            {
                string query = "SELECT * FROM dbo.Account WHERE accountID=@accID";
                string[] email = new string[1];

                con.Open();
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@accID", accID);
                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    email[0] = (string)dr["email"];
                }

                string add = email[0].ToString();

                con.Close();
                con.Dispose();
                return add;
            }

        }

        private static string getUsername(string accID)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString))
            {
                string query = "SELECT * FROM dbo.AccCreds WHERE accountID=@accID";
                string[] username = new string[1];

                con.Open();
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@accID", accID);
                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    username[0] = (string)dr["username"];
                }
                string name = username[0].ToString();

                con.Close();
                con.Dispose();
                return name;
            }

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

        private string[] getCreds1(string email)
        {
            //get creds by email
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString))
            {
                string query = "SELECT * FROM dbo.Account WHERE email=@email";
                string[] creds = new string[2];

                con.Open();
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@email", email);
                SqlDataReader dr = cmd.ExecuteReader();

                //save creds
                while (dr.Read())
                {
                    creds[0] = (string)dr["email"];
                    creds[1] = dr["accountID"].ToString();
                }

                dr.Close();
                con.Close();
                con.Dispose();

                return creds;
            }
        }
    }
}