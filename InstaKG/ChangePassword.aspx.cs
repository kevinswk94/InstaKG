using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

namespace InstaKG.Account
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btn_Change_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                //get username
                string username = getUsername(Session["accountID"].ToString());

                //retrieve salt of user
                string salt = RetrieveSalt(username);

                //check for current password
                if (AuthenticatePassword(tb_CurrentPassword.Text, salt))
                {
                    //valid

                    //check for consistant new password
                    if (tb_NewPassword.Text.Trim().Equals(tb_ConfirmPassword.Text.Trim()))
                    {
                        if (updatePassword(tb_ConfirmPassword.Text, Session["accountID"].ToString(), salt))
                        {
                            alert_placeholder.Visible = true;
                            alert_placeholder.Attributes["class"] = "alert alert-success alert-dismissable";
                            alertText.Text = "Successfully updated!";
                            
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
                        alertText.Text = "Inconsistent new password";
                    }
                }
                else
                {
                    alert_placeholder.Visible = true;
                    alert_placeholder.Attributes["class"] = "alert alert-danger alert-dismissable";
                    alertText.Text = "Invalid Password";
                   
                }
            }

            //clear
            tb_CurrentPassword.Text = string.Empty;
            tb_NewPassword.Text = string.Empty;
            tb_ConfirmPassword.Text = string.Empty;
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

        private static bool updatePassword(string password, string accID, string salt)
        {
            bool isValid = false;
            //Generate hash from salted password
            var hash = new SHA1Managed().ComputeHash(Encoding.UTF8.GetBytes(salt + password));
            string hashedPwd = Convert.ToBase64String(hash);

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString))
            {
                string sql = "UPDATE dbo.AccCreds SET passwordHash=@passwordHash WHERE accountID=@accID";
                SqlCommand cmd = new SqlCommand(sql, con);

                cmd.Parameters.AddWithValue("@passwordHash", hashedPwd);
                cmd.Parameters.AddWithValue("@accID", accID);
                System.Diagnostics.Debug.WriteLine("ID" + accID + "/==");
                System.Diagnostics.Debug.WriteLine("hash" + hashedPwd + "/==");

                con.Open();

                int count;
                count = Convert.ToInt32(cmd.ExecuteScalar());
                System.Diagnostics.Debug.WriteLine(count);
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

        private static bool AuthenticatePassword(string password, string salt)
        {
            bool isValid = false;
            //Generate hash from salted password
            var hash = new SHA1Managed().ComputeHash(Encoding.UTF8.GetBytes(salt + password));
            string hashedPwd = Convert.ToBase64String(hash);

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InstaKG"].ConnectionString))
            {
                string sql = "SELECT COUNT(*) FROM dbo.AccCreds WHERE passwordHash=@password";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@password", hashedPwd);

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
                System.Diagnostics.Debug.WriteLine(name);

                con.Close();
                con.Dispose();
                return name;
            }
        }
    }
}