using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebRole1
{
    /// <summary>
    /// SearchChartImage の概要の説明
    /// </summary>
    public class SearchChartImage : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "image/png";

            string prefFilter = context.Request["pref"] ?? "全て";
            string cityFilter = context.Request["city"] ?? "全て";
            string categoryFilter = context.Request["category"] ?? "全て";
            string productFilter = context.Request["product"] ?? "全て";
            string publishDayFilter = context.Request["publish"] ?? "全て";
            string pickDayFilter = context.Request["pick"] ?? "全て";
            string sortItem = context.Request["sort"] ?? "1";
            string widthString = context.Request["width"] ?? "";
            string heightString = context.Request["height"] ?? "";

            int width, height;
            if (Int32.TryParse(widthString, out width) == false) width = 600;
            if (Int32.TryParse(heightString, out height) == false) height = 300;
            width = Math.Min(1000, Math.Max(300, width));
            height = Math.Min(600, Math.Max(150, height));

            var list = Common.GetQuery(prefFilter, cityFilter, categoryFilter, productFilter, publishDayFilter, pickDayFilter, sortItem);
            var param = list.Item1.ToList().PrepareChartParam(width, height);

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

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}