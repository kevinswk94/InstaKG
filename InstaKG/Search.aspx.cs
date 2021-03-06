﻿using InstaKG.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace InstaKG
{
    public partial class Search : System.Web.UI.Page
    {
        User u = new User();
        Images i = new Images();
        DOA data = new DOA();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Tab1.CssClass = "clicked";
                MainView.ActiveViewIndex = 0;
            }

            tb_searchWord.Attributes.Add("OnKeyUp", "javascript:this.blur();javascript:this.focus();");
            tb_searchWord.Attributes.Add("OnFocus", "javascript:SetEnd(this);");

            updateImagesList();
            updateUserList();
        }

        protected void tab1_click(object sender, EventArgs e)
        {
            Tab1.CssClass = "clicked";
            Tab2.CssClass = "initial";
            MainView.ActiveViewIndex = 0;
        }

        protected void tab2_click(object sender, EventArgs e)
        {
            Tab1.CssClass = "initial";
            Tab2.CssClass = "clicked";
            MainView.ActiveViewIndex = 1;
        }

        public int updateImagesList()
        {
            List<Images> list = new List<Images>();


            foreach (Images item in i.retrieveImageList())
            {
                bool check = false;

                if (item.ImageTitle.ToLower().Contains(tb_searchWord.Text.ToLower()))
                {
                    list.Add(item);
                    check = true;
                }
                if (item.Description.ToLower().Contains(tb_searchWord.Text.ToLower()))
                {
                    if (!check)
                    {
                        list.Add(item);
                    }
                }
                if (getUsernameByAccountID(getAccountIDByImageID(item.ImageID)).Contains(tb_searchWord.Text))
                {
                    if (!check)
                    {
                        list.Add(item);
                    }
                }
            }

            lv_ImageResult.DataSource = list;
            lv_ImageResult.DataBind();

            return list.Count;
        }

        public int updateUserList()
        {
            List<User> list = new List<User>();

            foreach (User item in u.retrieveUserList())
            {
                if (item.Username.Contains(tb_searchWord.Text))
                {
                    list.Add(item);
                }
            }

            lv_UserResult.DataSource = list;
            lv_UserResult.DataBind();

            return list.Count;
        }

        protected void tb_searchWord_TextChanged(object sender, EventArgs e)
        {
            int valueI = 0;
            int valueU = 0;

            valueI = updateImagesList();
            valueU = updateUserList();

            ImageResult.Visible = true;
            UserResult.Visible = true;

            ImageValue.Text = valueI.ToString();
            UserValue.Text = valueU.ToString();

            tb_searchWord.Focus();
        }

        /// /////////////////////////////////

        public string getAccountIDByImageID(object id)
        {
            return data.retrieveAccIDByImageID(Convert.ToInt32(id)).ToString();
        }

        public string getUsernameByAccountID(string id)
        {
            return data.retrieveUsernameByID(Convert.ToInt32(id)).ToString();
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)(sender);

            string imageID= btn.CommandArgument;

            string accID = getAccountIDByImageID(imageID);

            string username = getUsernameByAccountID(accID);

            string url = "ViewProfile.aspx?name=" + username;

            Response.Redirect(url);
        }
        public double dateDifference(object date)
        {
            double value;

            TimeSpan difference = DateTime.Now - DateTime.Parse(date.ToString());

            var days = difference.TotalDays;

            value = Math.Ceiling(Convert.ToDouble(days));

            return value;
        }
    }
}