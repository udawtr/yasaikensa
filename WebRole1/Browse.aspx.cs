using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebRole1
{
    public partial class Browse : System.Web.UI.Page
    {
        protected Dictionary<string,int> prefList;

        protected void Page_Load(object sender, EventArgs e)
        {
            using (var db = new DataClasses1DataContext())
            {
                var q = from x in db.YasaiKensa group x by x.産地都道府県 into grp select new { name=grp.Key, count=grp.Count() };
                prefList = new Dictionary<string, int>();
                foreach (var item in q.OrderByDescending(x=>x.count))
                {
                    prefList.Add(item.name, item.count);
                }
            }
        }

        protected int GetCoount(string prefName)
        {
            if (prefList.ContainsKey(prefName)) return prefList[prefName];
            else return 0;
        }
    }
}