using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml;

namespace WebRole1
{
    /// <summary>
    /// MapDataHandler の概要の説明
    /// </summary>
    public class MapDataHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/xml";

            var pd = context.Request["d"];
            var pv = context.Request["v"];

            using (var db = new DataClasses1DataContext())
            using(var xtw = new XmlTextWriter(context.Response.Output))
            {
                var dlo = new System.Data.Linq.DataLoadOptions();
                dlo.LoadWith<YasaiKensa>(x => x.Place);
                db.LoadOptions = dlo;
                db.ObjectTrackingEnabled = false;

                var dt = DateTime.Today.AddDays(-27.0);
                var q = from s in db.YasaiKensa
                        where s.Place.緯度.HasValue && s.Place.経度.HasValue && s.公表日D.HasValue
                        && (pd == "ALL" || s.公表日D.Value > dt)
                        group s by new { s.産地都道府県, s.産地市町村, s.Place} into g
                        select new
                        {
                            pref = g.Key.産地都道府県,
                            city = g.Key.産地市町村,
                            lat = g.Key.Place.緯度,
                            lng = g.Key.Place.経度,
                            Cs = g.Max(x => x.セシウム134D.GetValueOrDefault() + x.セシウム137D.GetValueOrDefault() + x.セシウムD.GetValueOrDefault()),
                            I = g.Max(x => x.ヨウ素131D.GetValueOrDefault()),
                            count = g.Count()
                        };


                xtw.WriteStartDocument();
                xtw.WriteStartElement("markers");
                foreach (var item in q)
                {
                    xtw.WriteStartElement("marker");
                    xtw.WriteAttributeString("pref", item.pref);
                    xtw.WriteAttributeString("city", item.city);
                    xtw.WriteAttributeString("lat", Convert.ToString(item.lat));
                    xtw.WriteAttributeString("lng", Convert.ToString(item.lng));
                    xtw.WriteAttributeString("bq", Convert.ToString(pv == "I" ? item.I : item.Cs));
                    xtw.WriteEndElement();
                }
                xtw.WriteEndElement();
                xtw.WriteEndDocument();
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