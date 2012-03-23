using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebRole1
{
    public partial class City : System.Web.UI.Page
    {
        protected IList<YasaiKensa> list;
        protected string prefName;
        protected string cityName;

        protected void Page_Load(object sender, EventArgs e)
        {
            prefName = Request["pref"];
            cityName = Request["city"];
            using (var db = new DataClasses1DataContext())
            {
                var q = from x in db.YasaiKensa
                        where x.産地都道府県 == prefName && x.産地市町村 == cityName
                        orderby x.採取日D descending
                        select x;
                list = q.ToList();
            }

            Title = String.Format("{1}({0}) | 食品の放射能検査データ", prefName, cityName);
        }
    }
}