using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebRole1
{
    public partial class category : System.Web.UI.Page
    {
        protected Dictionary<string, int> productList;
        protected Dictionary<string, List<string>> yasaiCategoryList;
        protected string categoryName;

        protected void Page_Load(object sender, EventArgs e)
        {
            categoryName = Request["q"];
            using (var db = new DataClasses1DataContext())
            {
                if (categoryName == "野菜類")
                {
                    var q = from x in db.YasaiKensa
                            where x.食品カテゴリ == categoryName
                            group x by new { name = x.野菜品名, category = x.野菜分類 }
                                into grp
                                select new { name = grp.Key.name, category = grp.Key.category, count = grp.Count() };

                    productList = new Dictionary<string, int>();
                    foreach (var item in q.OrderBy(x => x.name))
                    {
//                        if( productList.ContainsKey(Strings.StrConv(item.name, VbStrConv.Katakana)) == false )
                        {
                        productList.Add(item.name, item.count);
                        }
                    }

                    var qq = from s in db.edicode group s by new { Id = s.大分類コード, Name = s.大分類名 } into grp orderby grp.Key.Id select grp.Key.Name;
                    yasaiCategoryList = new Dictionary<string, List<string>>();
                    qq.ToList().ForEach(x => yasaiCategoryList.Add(x, new List<string>()));
                    q.GroupBy(x => x.category)
                        .ToList()
                        .ForEach(x=>yasaiCategoryList[x.Key].AddRange(x.Select(xx=>xx.name)));
                    foreach (var item in yasaiCategoryList.Keys.ToList())
                    {
                        if (yasaiCategoryList[item].Count == 0)
                        {
                            yasaiCategoryList.Remove(item);
                        }
                    }
                }
                else
                {
                    var q = from x in db.YasaiKensa
                            where x.食品カテゴリ == categoryName
                            group x by x.品目
                                into grp
                                select new { name = grp.Key, count = grp.Count() };
                    productList = new Dictionary<string, int>();
                    foreach (var item in q.OrderBy(x => x.name))
                    {
                        productList.Add(item.name, item.count);
                    }
                }
            }
            Title = String.Format("{0} | 食品の放射能検査データ", categoryName);
        }
    }
}