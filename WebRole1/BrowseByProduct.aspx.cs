using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebRole1
{
    public partial class BrowseByProduct : System.Web.UI.Page
    {
        protected Dictionary<string, int> categoryList;

        protected void Page_Load(object sender, EventArgs e)
        {
            using (var db = new DataClasses1DataContext())
            {
                var q = from x in db.YasaiKensa group x by x.食品カテゴリ into grp select new { name = grp.Key, count = grp.Count() };
                categoryList = new Dictionary<string, int>();
                foreach (var item in q.OrderByDescending(x => x.count))
                {
                    categoryList.Add(item.name, item.count);
                }
            }
        }
    }
}