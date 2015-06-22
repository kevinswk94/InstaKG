using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace InstaKG.Entity
{
    public class User
    {
        private int ID;
        private string name;

        private List<User> usernamelist;
        private List<User> userlist;

        public List<User> UsernameList
        {
            set
            {
                usernamelist = value;
            }
            get
            {
                return usernamelist;
            }
        }

        public List<User> UserList
        {
            set
            {
                userlist = value;
            }
            get
            {
                return userlist;
            }
        }

        ////////////////////////////////////////

        public int AccountID
        {
            set
            {
                this.ID = value;
            }
            get
            {
                return ID;
            }
        }

        public string Username
        {
            set
            {
                this.name = value;
            }
            get
            {
                return name;
            }
        }

        ////////////////////////////////////////////////

        public User()
        {
            this.UsernameList = new DOA().retriveUsername();
            this.UserList = new DOA().retrieveUserList();
        }

        public User(string name)
        {
            this.Username = name;
        }

        public User(int id, string name)
        {
            this.ID = id;
            this.Username = name;
        }


        public string retrieveUsernameByID(int id)
        {
            string name = null;

            foreach(User item in retrieveUserList())
            {
                if(item.AccountID.Equals(id))
                {
                    name = item.Username;
                }
            }

            return name;
        }

        public List<User> retrieveUserList()
        {
            return UserList;
        }
    }
}