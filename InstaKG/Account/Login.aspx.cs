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

namespace InstaKG
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string salt = RetrieveSalt(tb_username.Text);
                if (salt.Equals("-1"))
                {
                    alert_placeholder.Visible = true;
                    alert_placeholder.Attributes["class"] = "alert alert-danger alert-dismissable";
                    alertText.Text = "Username or password is incorrect";
                }
                else
                {
                    if (AuthenticateUser(tb_username.Text, tb_password.Text, salt))
                    {
                        // Perform a redirect to Home page
                        Session["username"] = tb_username.Text;
                        FormsAuthentication.RedirectFromLoginPage(tb_username.Text, true);

                        //alert_placeholder.Visible = true;
                        //alert_placeholder.Attributes["class"] = "alert alert-success alert-dismissable";
                        //alertText.Text = "Login successful!";
                    }
                    else
                    {
                        alert_placeholder.Visible = true;
                        alert_placeholder.Attributes["class"] = "alert alert-danger alert-dismissable";
                        alertText.Text = "Username or password is incorrect";
                    }
                }
            }
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

        private static bool AuthenticateUser(string username, string password, string salt)
        {
            bool isValid = false;
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString))
            {
                 //Generate hash from salted password
                 var hash = new SHA1Managed().ComputeHash(Encoding.UTF8.GetBytes(salt + password));
                 string hashedPwd = Convert.ToBase64String(hash);

                string sql = "SELECT COUNT(*) FROM dbo.AccCreds WHERE username=@username AND passwordHash=@passwordHash";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@username", username);
                cmd.Parameters.AddWithValue("@passwordHash", hashedPwd);

                con.Open();
                int result = int.Parse(cmd.ExecuteScalar().ToString());
                if (result == 1)
                    isValid = true;
                else
                    isValid = false;
            }
            return isValid;
        }

        protected void btn_clear_Click(object sender, EventArgs e)
        {
            tb_username.Text = string.Empty;
            tb_password.Text = string.Empty;
        }
    }
}