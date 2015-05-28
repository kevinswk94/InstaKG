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
                string salt = RetrieveSalt();
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

                        alert_placeholder.Visible = true;
                        alert_placeholder.Attributes["class"] = "alert alert-success alert-dismissable";
                        alertText.Text = "Login successful!";
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

        private string RetrieveSalt()
        {
            string conStr = ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand("spRetrieveSalt", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@Username", tb_username.Text);

                con.Open();

                string result = (string)cmd.ExecuteScalar();
                
                con.Close();
                con.Dispose();
                
                return result;
            }
        }

        private bool AuthenticateUser(string username, string password, string salt)
        {
            string conStr = ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand("spAuthenticateUser", con);
                cmd.CommandType = CommandType.StoredProcedure;

                // Generate hash from salted password
                var hash = new SHA1Managed().ComputeHash(Encoding.UTF8.GetBytes(salt + password));
                string hashedPwd = Convert.ToBase64String(hash);
                
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Password", hashedPwd);

                con.Open();

                int result = (int)cmd.ExecuteScalar();
                con.Close();
                con.Dispose();
                if (result == 1)
                {
                    // Account exists
                    return true;
                }
                else
                {
                    // Account does not exist
                    return false;
                }
            }
        }

        protected void btn_clear_Click(object sender, EventArgs e)
        {

        }
    }
}