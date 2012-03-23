using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebRole1
{
    /// <summary>
    /// ProductChartImage の概要の説明
    /// </summary>
    public class ProductChartImage : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "image/png";

            var categoryName = context.Request["category"];
            var productName = context.Request["product"];
            using (var db = new DataClasses1DataContext())
            {
                IList<YasaiKensa> list;
                if (categoryName == "野菜類")
                {
                    var q = from x in db.YasaiKensa
                            where x.食品カテゴリ == categoryName && x.野菜品名 == productName
                            orderby x.採取日D descending
                            select x;
                    list = q.ToList();
                }
                else
                {
                    var q = from x in db.YasaiKensa
                            where x.食品カテゴリ == categoryName && x.品目 == productName
                            orderby x.採取日D descending
                            select x;
                    list = q.ToList();
                }

                var param = list.ToList().PrepareChartParam(600, 300);

                using (var cl = new System.Net.WebClient())
                {
                    var values = new System.Collections.Specialized.NameValueCollection();
                    foreach (var item in param)
                    {
                        values.Add(item.Substring(0, item.IndexOf('=')), item.Substring(item.IndexOf('=') + 1));
                    }
                    var resdata = cl.UploadValues("http://chart.googleapis.com/chart?chid=1", values);
                    context.Response.OutputStream.Write(resdata, 0, resdata.Length);
                }
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}