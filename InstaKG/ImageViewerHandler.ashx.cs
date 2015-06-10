using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;

namespace InstaKG
{
    /// <summary>
    /// Summary description for ImageViewerHandler
    /// </summary>
    public class ImageViewerHandler : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            SqlConnection con = new
            SqlConnection(ConfigurationManager.ConnectionStrings["InstaKGConnectionString"].ToString());

            con.Open();
            string sql = "Select * from Image where imageID=@imageID";
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.Add("@imageID", SqlDbType.Int).Value = context.Request.QueryString["id"];
            cmd.Prepare();
            SqlDataReader dr = cmd.ExecuteReader();
            dr.Read();

            context.Response.ContentType = dr["imageType"].ToString();
            context.Response.BinaryWrite((byte[])dr["imageData"]);

            dr.Close();
            con.Close();
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}