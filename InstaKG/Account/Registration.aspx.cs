using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Web.Security;
using System.Security.Cryptography;
using System.Text;

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
                string conStr = ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString;
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    SqlCommand cmd = new SqlCommand("spRegisterUser", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    // Generate random salt
                    RandomNumberGenerator rng = new RNGCryptoServiceProvider();
                    byte[] tokenData = new byte[4];
                    rng.GetBytes(tokenData);
                    string salt = Convert.ToBase64String(tokenData);

                    // Generate hash from salted password
                    var hash = new SHA1Managed().ComputeHash(Encoding.UTF8.GetBytes(salt+tb_password.Text));
                    string hashedPwd = Convert.ToBase64String(hash);

                    //SqlParameter username = new SqlParameter("@Username", tb_username.Text);
                    //SqlParameter fName = new SqlParameter("@FirstName", tb_fName.Text);
                    //SqlParameter lName = new SqlParameter("@LastName", tb_lName.Text);
                    //SqlParameter email = new SqlParameter("@Email", tb_email.Text);
                    //SqlParameter passwordSalt = new SqlParameter("@PasswordSalt", salt);
                    //SqlParameter passwordHash = new SqlParameter("@PasswordHash", hashedPwd);

                    //cmd.Parameters.Add(username);
                    //cmd.Parameters.Add(fName);
                    //cmd.Parameters.Add(lName);
                    //cmd.Parameters.Add(email);
                    //cmd.Parameters.Add(passwordSalt);
                    //cmd.Parameters.Add(passwordHash);

                    cmd.Parameters.AddWithValue("@Username", tb_username.Text);
                    cmd.Parameters.AddWithValue("@FirstName", tb_fName.Text);
                    cmd.Parameters.AddWithValue("@LastName", tb_lName.Text);
                    cmd.Parameters.AddWithValue("@Email", tb_email.Text);
                    cmd.Parameters.AddWithValue("@PasswordSalt", salt);
                    cmd.Parameters.AddWithValue("@PasswordHash", hashedPwd);

                    con.Open();
                    int ReturnCode = (int)cmd.ExecuteScalar();
                    if (ReturnCode == -1)
                    {
                        alert_placeholder.Visible = true;
                        alert_placeholder.Attributes["class"] = "alert alert-danger alert-dismissable";
                        alertText.Text = "Username or email already taken. Please use another one.";
                    }
                    else
                    {
                        alert_placeholder.Visible = true;
                        alert_placeholder.Attributes["class"] = "alert alert-success alert-dismissable";
                        alertText.Text = "User account successfully created!";
                    }
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

        
    }
}