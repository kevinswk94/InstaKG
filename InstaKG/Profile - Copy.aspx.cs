using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Web;

namespace InstaKG
{
    public partial class Profile : System.Web.UI.Page
    {
        private string strConnString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindDataList();



            //if (Request.QueryString["AccountID"] != null)
            //{
            //    string strQuery = "select imageTitle, imageType, imageData from Image where accountID=@id";
            //    SqlCommand cmd = new SqlCommand(strQuery);
            //    cmd.Parameters.Add("@id", SqlDbType.Int).Value = Convert.ToInt32(Request.QueryString["AccountID"]);
            //    DataTable dt = GetData(cmd);
            //    if (dt != null)
            //    {
            //        Byte[] bytes = (Byte[])dt.Rows[0]["Data"];
            //        Response.Buffer = true;
            //        Response.Charset = "";
            //        Response.Cache.SetCacheability(HttpCacheability.NoCache);
            //        Response.ContentType = dt.Rows[0]["ContentType"].ToString();
            //        Response.AddHeader("content-disposition", "attachment;filename=" + dt.Rows[0]["Name"].ToString());
            //        Response.BinaryWrite(bytes);
            //        Response.Flush();
            //        Response.End();
            //    }
            //}



        }



        //private DataTable GetData(SqlCommand cmd)
        //{
        //    DataTable dt = new DataTable();
        //    String strConnString = System.Configuration.ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
        //    SqlConnection con = new SqlConnection(strConnString);
        //    SqlDataAdapter sda = new SqlDataAdapter();
        //    cmd.CommandType = CommandType.Text;
        //    cmd.Connection = con;
        //    try
        //    {
        //        con.Open();
        //        sda.SelectCommand = cmd;
        //        sda.Fill(dt);
        //        return dt;
        //    }
        //    catch
        //    {
        //        return null;
        //    }
        //    finally
        //    {
        //        con.Close();
        //        sda.Dispose();
        //        con.Dispose();
        //    }
        //}

























        private void BindDataList()
        {
            string sqlCmd = "SELECT 1 FROM Image";
            DataBaseHelper DBHelper = new DataBaseHelper();
            DataTable dt = DBHelper.GetTable(sqlCmd);
            //adding new column to disply image
            DataColumn imageCol = new DataColumn("images", typeof(string));
            dt.Columns.Add(imageCol);

            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    dt.Rows[i][imageCol] = string.Format("<img src='Handler.ashx?id={0}' alt='' style='width:100px' />", dt.Rows[i][0].ToString());
                }
            }
            DataList1.DataSource = dt;
            DataList1.DataBind();
        }

















































        //public Image GetImageById(int accountID)
        //{
        //    Image result = null;
        //    SqlDataReader imageReader;

        //    SqlConnection conn = new SqlConnection(strConnString);// your connection string  DON'T HARDLY WRITE IT, pass it as argument or add it in application configuration 

        //    string selectString = "SELECT * FROM Image where accountID = @ID";
        //    SqlCommand selectCommand = new SqlCommand(selectString, conn);
        //    selectCommand.CommandType = CommandType.StoredProcedure;

        //    selectCommand.Parameters.AddWithValue("@ID", accountID.ToString());

        //    conn.Open();

        //    imageReader = selectCommand.ExecuteReader(CommandBehavior.CloseConnection);

        //    while (imageReader.Read())
        //    {
        //        result = Image.FromStream(new MemoryStream((byte[])imageReader.GetValue(1)));
        //    }

        //    return result;
        //}


        //private void BindDataList()
        //{
        //    SqlConnection con = new SqlConnection(strConnString);
        //    con.Open();
        //    string cmd = "SELECT * FROM Image where accountID = 1";

        //    SqlCommand _SqlCommand;
        //    SqlDataAdapter _sqlDataAdapter;

        //    //creating new instance of Datatable
        //    DataTable dataTable = new DataTable();
        //    _SqlCommand = new SqlCommand(cmd, con);
        //    //Open SQL Connection
        //    try
        //    {
        //        _sqlDataAdapter = new SqlDataAdapter(_SqlCommand);
        //        _sqlDataAdapter.Fill(dataTable);
        //    }
        //    catch
        //    { }
        //    finally
        //    {
        //        //Closing Sql Connection
        //        con.Close();
        //    }
        //    //adding new column to disply image
        //    DataColumn imageCol = new DataColumn("images", typeof(string));
        //    dataTable.Columns.Add(imageCol);

        //    if (dataTable.Rows.Count > 0)
        //    {
        //        for (int i = 0; i < dataTable.Rows.Count; i++)
        //        {
        //            dataTable.Rows[i][imageCol] = string.Format("<img src='Handler.ashx?id={0}' alt='' style='width:100px' />", dataTable.Rows[i][0].ToString());
        //        }
        //    }
        //    DataList1.DataSource = dataTable;
        //    DataList1.DataBind();
        //}
    }
}