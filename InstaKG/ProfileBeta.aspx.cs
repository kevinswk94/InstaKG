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


        }

        private void BindDataList()
        {
            string sqlCmd = "SELECT imageID FROM Image where accountID= @ID";
            sqlCmd.Parameters.AddWithValue("@ID", accountID.ToString());
            DataBaseHelper DBHelper = new DataBaseHelper();
            DataTable dt = DBHelper.GetTable(sqlCmd);
            //adding new column to disply image
            DataColumn imageCol = new DataColumn("images", typeof(string));
            dt.Columns.Add(imageCol);

            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    dt.Rows[i][imageCol] = string.Format("<img src='Handler.ashx?id={}' alt='' style='width:100px' />", dt.Rows[i][0].ToString());
                }
            }
            DataList.DataSource = dt;
            DataList.DataBind();
        }
    }


}