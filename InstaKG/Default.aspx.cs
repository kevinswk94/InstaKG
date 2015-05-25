using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;



using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace InstaKG
{
    public partial class Default : System.Web.UI.Page
    {

        string strConnString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlCommand cmd;

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                BindRepeaterData();
            }



        }


        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(strConnString);
            con.Open();
            SqlCommand cmd = new SqlCommand("insert into [Commentary] (commentaryID,commentaryAuthor,commentaryContent,commentaryDateTime) values(@subject,@userName,@comment,@postedDate)", con);
            cmd.Parameters.AddWithValue("@subject", txtSubject.Text);
            cmd.Parameters.AddWithValue("@userName", txtName.Text);
            cmd.Parameters.AddWithValue("@comment", txtComment.Text);
            cmd.Parameters.AddWithValue("@postedDate", DateTime.Now);
            cmd.ExecuteNonQuery();
            con.Close();
            txtName.Text = string.Empty;
            txtComment.Text = string.Empty;
            BindRepeaterData();
        }
        protected void BindRepeaterData()
        {
            SqlConnection con = new SqlConnection(strConnString);
            con.Open();
            SqlCommand cmd = new SqlCommand("select * from [Commentary] Order By commentaryDateTime desc", con);
            DataSet ds = new DataSet();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                RepDetails.Visible = true;
                RepDetails.DataSource = ds;
                RepDetails.DataBind();
            }
            else
            {
                RepDetails.Visible = false;
            }

            con.Close();
        }


    }
}