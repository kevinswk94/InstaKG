using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace InstaKG.Entity
{
    public class Images
    {
        private int ID;
        private string title;
        private string desc;
        private string content;
        private string type;
        private DateTime creation;

        private List<Images> imageList = new List<Images>();
        private List<Images> titleList = new List<Images>();
        User u = new User();

        public List<Images> ImageList
        {
            set
            {
                imageList = value;
            }
            get
            {
                return imageList;
            }
        }
        public List<Images> TitleList
        {
            set
            {
                titleList = value;
            }
            get
            {
                return titleList;
            }
        }
        public int ImageID
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

        public string ImageTitle
        {
            set
            {
                this.title = value;
            }
            get
            {
                return title;
            }
        }

        public string Description
        {
            set
            {
                this.desc = value;
            }
            get
            {
                return desc;
            }
        }

        public string Content
        {
            set
            {
                this.content = value;
            }
            get
            {
                return content;
            }
        }

        public string ImageType
        {
            set
            {
                this.type = value;
            }
            get
            {
                return type;
            }
        }

        public DateTime Creation
        {
            set
            {
                this.creation = value;
            }
            get
            {
                return creation;
            }
        }

        public Images()
        {
            this.TitleList = new DOA().retrieveImageTitleList();
            this.ImageList = new DOA().retrieveImageList();
        }

        public Images(string title)
        {
            this.ImageTitle = title;
        }

        public Images(int id, string title, string descript)
        {
            this.ID = id;
            this.ImageTitle = title;
            this.Description = descript;
        }

        public Images(int id, string title, string descript, string type)
        {
            this.ID = id;
            this.ImageTitle = title;
            this.Description = descript;
            this.ImageType = type;
        }
        public Images(int id, string title, string descript, string type, DateTime create)
        {
            this.ID = id;
            this.ImageTitle = title;
            this.Description = descript;
            this.ImageType = type;
            this.Creation = create;
        }

        public Images(int id, string title, string descript, string content, string type, DateTime create)
        {
            this.ID = id;
            this.ImageTitle = title;
            this.Description = descript;
            this.Content = content;
            this.ImageType = type;
            this.Creation = create;
        }
        public Images(int id, string title, string descript, string content, string type, DateTime create, int accID)
        {
            this.ID = id;
            this.ImageTitle = title;
            this.Description = descript;
            this.Content = content;
            this.ImageType = type;
            this.Creation = create;
            u.AccountID = accID;
        }

        public List<Images> retrieveImageList()
        {
            return ImageList;
        }
    }
}