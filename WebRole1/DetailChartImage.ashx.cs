using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebRole1
{
    /// <summary>
    /// DetailChartImage の概要の説明
    /// </summary>
    public class DetailChartImage : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "image/png";

            int no;
            if (Int32.TryParse(context.Request["no"], out no))
            {
                using (var db = new DataClasses1DataContext())
                {
                    var dlo = new System.Data.Linq.DataLoadOptions();
                    dlo.LoadWith<YasaiKensa>(x => x.Place);
                    db.ObjectTrackingEnabled = false;
                    db.LoadOptions = dlo;
                    var data = db.YasaiKensa.SingleOrDefault(x => x.No == no);
                    if (data != null)
                    {
                        var list = db.YasaiKensa.Where(x => x.産地都道府県 == data.産地都道府県 && x.産地市町村 == data.産地市町村 && x.食品カテゴリ == data.食品カテゴリ && x.品目 == data.品目);
                        var param = list.ToList().PrepareChartParam(700, 300);

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