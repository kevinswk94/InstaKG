using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace InstaKG
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindDataList();
        }
   



        private void BindDataList()
    {
        string sqlCmd = "SELECT imageid FROM Image where accountID = 1 ";
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


 }
}