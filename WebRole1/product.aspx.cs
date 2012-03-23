using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.DataVisualization;
using System.Web.UI.DataVisualization.Charting;

namespace WebRole1
{
    public partial class product : System.Web.UI.Page
    {
        protected IList<YasaiKensa> list;
        protected string categoryName;
        protected string productName;
        protected IList<YasaiName> yasaiName;
        protected edicode EDIData;

        protected void Page_Load(object sender, EventArgs e)
        {
            categoryName = Request["category"];
            productName = Request["product"];
            using (var db = new DataClasses1DataContext())
            {
                if (categoryName == "野菜類")
                {
                    var q = from x in db.YasaiKensa
                            where x.食品カテゴリ == categoryName.Normalize() && x.野菜品名 == productName.Normalize()
                            orderby x.採取日D descending
                            select x;
                    list = q.ToList();
                }
                else
                {
                    var q = from x in db.YasaiKensa
                            where x.食品カテゴリ == categoryName.Normalize() && x.品目 == productName.Normalize()
                            orderby x.採取日D descending
                            select x;
                    list = q.ToList();
                }

                bqByDayImage.ImageUrl = String.Format("ProductChartImage.ashx?category={0}&product={1}", HttpUtility.UrlEncode(categoryName), HttpUtility.UrlEncode(productName));
                prefImage.ImageUrl = list.PreparePrefURL(300,300);
            }
            Title = String.Format("{0}({1}) | 食品の放射能検査データ", productName, categoryName);
        }
    }
}