using InstaKG.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace InstaKG
{
    public partial class BrowseImg : System.Web.UI.Page
    {
        DOA data = new DOA();

        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public double dateDifference(object date)
        {
            double value;

            TimeSpan difference = DateTime.Now - DateTime.Parse(date.ToString());

            var days = difference.TotalDays;

            value = Math.Ceiling(Convert.ToDouble(days));
            System.Diagnostics.Debug.WriteLine(value);

            return value;
        }
        public string getUsernameByAccountID(string id)
        {
            return data.retrieveUsernameByID(Convert.ToInt32(id)).ToString();
        }
    }
}