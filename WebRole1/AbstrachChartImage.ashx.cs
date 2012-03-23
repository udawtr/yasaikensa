using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;

namespace WebRole1
{
    /// <summary>
    /// AbstrachChartImage の概要の説明
    /// </summary>
    public class AbstrachChartImage : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "image/png";

            using (var db = new DataClasses1DataContext())
            {
                var list = db.YasaiKensa.ToList();
                var param = list.PrepareChartParam(600, 300);

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