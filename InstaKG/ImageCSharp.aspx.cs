using System;
using System.Data;
using System.Data.SqlClient ;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class _Default : System.Web.UI.Page 
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["AccountID"] != null)
        {
            string strQuery = "select imageTitle, imageType, imageData from Image where accountID=@id";
            SqlCommand cmd = new SqlCommand(strQuery);
            cmd.Parameters.Add("@id", SqlDbType.Int).Value = Convert.ToInt32(Request.QueryString["AccountID"]);
            DataTable dt = GetData(cmd);
            if (dt != null)
            {

                        Byte[] bytes = (Byte[])dt.Rows[i]["imageData"];
                        Response.Buffer = true;
                        Response.Charset = "";
                        Response.Cache.SetCacheability(HttpCacheability.NoCache);


                        Response.ContentType = dt.Rows[i]["imageType"].ToString();
                        Response.AddHeader("content-disposition", "attachment;filename=" + dt.Rows[i]["imageTitle"].ToString());
                        Response.BinaryWrite(bytes);
                        Response.Flush();
                        Response.End();
                
            }
        }
    }
    private DataTable GetData(SqlCommand cmd)
    {
        DataTable dt = new DataTable();
        String strConnString = System.Configuration.ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
        SqlConnection con = new SqlConnection(strConnString);
        SqlDataAdapter sda = new SqlDataAdapter();
        cmd.CommandType = CommandType.Text;
        cmd.Connection = con;
        try
        {
            con.Open();
            sda.SelectCommand = cmd;
            sda.Fill(dt);
            return dt;

        }
        catch
        {
            return null;
        }
        finally
        {
            con.Close();
            sda.Dispose();
            con.Dispose();
        }

    }
}
