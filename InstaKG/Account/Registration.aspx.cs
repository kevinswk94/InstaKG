using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

namespace InstaKG.Account
{
    public partial class Registration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                /*
                 * Explamation behind logic:
                 * 
                 * If usernameValid and emailValid are both true, then result = 3 (1 + 2)
                 * If only usernameValid is true, result = 1
                 * If only emailValid is true, result = 2
                 * 
                 * React accordingly to results
                 */

                int usernameValid = UsernameValid(tb_username.Text);
                int emailValid = EmailValid(tb_email.Text);

                // If both checks are true
                if (usernameValid + emailValid == 3)
                {
                    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString))
                    {
                        string sql = "INSERT INTO dbo.Account(fName, lName, email, role) VALUES (@fName, @lName, @email, 0);";

                        SqlCommand cmd = new SqlCommand(sql, con);
                        cmd.Parameters.AddWithValue("@fName", tb_fName.Text);
                        cmd.Parameters.AddWithValue("@lName", tb_lName.Text);
                        cmd.Parameters.AddWithValue("@email", tb_email.Text);

                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();

                        // Generate random salt
                        RandomNumberGenerator rng = new RNGCryptoServiceProvider();
                        byte[] tokenData = new byte[4];
                        rng.GetBytes(tokenData);
                        string salt = Convert.ToBase64String(tokenData);

                        // Generate hash from salted password
                        var hash = new SHA1Managed().ComputeHash(Encoding.UTF8.GetBytes(salt+tb_password.Text));
                        string hashedPwd = Convert.ToBase64String(hash);

                        string sql2 = "INSERT INTO dbo.AccCreds(username, passwordSalt, passwordHash, accountID) VALUES (@Username, @PasswordSalt, @PasswordHash, @accountID);";
                        cmd = new SqlCommand(sql2, con);

                        cmd.Parameters.AddWithValue("@Username", tb_username.Text);
                        cmd.Parameters.AddWithValue("@PasswordSalt", salt);
                        cmd.Parameters.AddWithValue("@PasswordHash", hashedPwd);
                        cmd.Parameters.AddWithValue("@accountID", retrieveAccID(tb_email.Text));

                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        con.Dispose();
                        cmd.Dispose();

                        alert_placeholder.Visible = true;
                        alert_placeholder.Attributes["class"] = "alert alert-success alert-dismissable";
                        alertText.Text = "User account successfully created! You will be redirected to the login page shortly.";

                        Response.AddHeader("REFRESH", "3;URL=/Account/Login.aspx");
                    }
                }
                else if (usernameValid + emailValid == 2)
                {
                    alert_placeholder.Visible = true;
                    alert_placeholder.Attributes["class"] = "alert alert-danger alert-dismissable";
                    alertText.Text = "Username already taken. Please use another one.";
                }
                else if (usernameValid + emailValid == 1)
                {
                    alert_placeholder.Visible = true;
                    alert_placeholder.Attributes["class"] = "alert alert-danger alert-dismissable";
                    alertText.Text = "Email already taken. Please use another one.";
                }
                else
                {
                    alert_placeholder.Visible = true;
                    alert_placeholder.Attributes["class"] = "alert alert-danger alert-dismissable";
                    alertText.Text = "Username or email already taken. Please use another one.";
                }
                
            }
        }

        protected void btn_cancel_Click(object sender, EventArgs e)
        {
            // Resets all form fields
            tb_username.Text = String.Empty;
            tb_fName.Text = String.Empty;
            tb_lName.Text = String.Empty;
            tb_email.Text = String.Empty;
            tb_password.Text = String.Empty;
            tb_rePassword.Text = String.Empty;
        }

        private static int UsernameValid(string username)
        {
            int valid = 0;

            using ( SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString) )
            {
                SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM dbo.AccCreds WHERE username=@username", con);
                cmd.Parameters.AddWithValue("@username", username);
                con.Open();

                int result = int.Parse(cmd.ExecuteScalar().ToString());

                if (result == 0)
                    valid = 1;
                else
                    valid = 0;

                con.Close();
                con.Dispose();
                cmd.Dispose();
            }
            return valid;
        }

        private static int EmailValid(string email)
        {
            int valid = 0;

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM dbo.Account WHERE email=@email", con);
                cmd.Parameters.AddWithValue("@email", email);
                con.Open();

                int result = int.Parse(cmd.ExecuteScalar().ToString());

                if (result == 0)
                    valid = 2;
                else
                    valid = 0;

                con.Close();
                con.Dispose();
                cmd.Dispose();
            }
            return valid;
        }

        private static int retrieveAccID(string email)
        {
            int result = new int();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString))
            {
                string sql = "SELECT accountID FROM dbo.Account WHERE email=@email";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@email", email);

                con.Open();
                result = int.Parse(cmd.ExecuteScalar().ToString());
                con.Close();
                con.Dispose();
                cmd.Dispose();
            }
            return result;
        }
    }
}