using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebRole1
{
    public partial class Pref : System.Web.UI.Page
    {
        protected IList<YasaiKensa> list;

        protected Dictionary<string, int> cityList;
        protected Dictionary<string, int> portList;

        protected string prefName;

        protected void Page_Load(object sender, EventArgs e)
        {
            prefName = Request["q"];
            using (var db = new DataClasses1DataContext())
            {
                var q = from x in db.YasaiKensa where x.産地都道府県 == prefName && x.産地市町村 != "-" && x.食品カテゴリ != "水産物"
                        group x by x.産地市町村 into grp select new { name = grp.Key, count = grp.Count() };
                cityList = new Dictionary<string, int>();
                foreach (var item in q.OrderByDescending(x => x.count))
                {
                    cityList.Add(item.name, item.count);
                }

                var q2 = from x in db.YasaiKensa
                        where x.産地都道府県 == prefName && x.産地市町村 != "-" && x.食品カテゴリ == "水産物"
                        group x by x.産地市町村 into grp
                        select new { name = grp.Key, count = grp.Count() };
                portList = new Dictionary<string, int>();
                foreach (var item in q2.OrderByDescending(x => x.count))
                {
                    portList.Add(item.name, item.count);
                }

                list = db.YasaiKensa.Where(x => x.産地都道府県 == prefName && x.産地市町村 == "-").OrderByDescending(x=>x.採取日D).ToList();

                bqByDayImage.ImageUrl = String.Format("SearchChartImage.ashx?pref={0}&city=-&width=800", HttpUtility.UrlEncode(prefName)) ;

                Title = String.Format("{0} | 食品の放射能検査データ", prefName);
            }
        }
    }
}