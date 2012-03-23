using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Linq;

namespace WebRole1.admin
{
    public partial class geocode : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            dogeocode();
            Response.Redirect("complete.aspx");
        }

        private void dogeocode()
        {
            //距離計算関数
            Func<double, double, double> GetL = (lat, lng) =>
            {
                var lat0 = 37.421467;
                var lng0 = 141.032577;
                var latR0 = lat0 / 180 * Math.PI;
                var lngR0 = lng0 / 180 * Math.PI;
                var a = 6378137.0;
                var b = 6356752.314;
                var latR = lat / 180 * Math.PI;
                var lngR = lng / 180 * Math.PI;
                var dy = latR0 - latR;
                var dx = lngR0 - lngR;
                var mu = (latR0 + latR) / 2.0;
                var e = Math.Sqrt((a * a - b * b) / (a * a));
                var W = Math.Sqrt(1.0 - e * e * Math.Pow(Math.Sin(mu), 2));
                var M = (a * (1 - e * e) / (W * W * W));
                var N = a / W;
                var d = Math.Sqrt(Math.Pow(dy * M, 2) + Math.Pow(dx * N * Math.Cos(mu), 2));
                var L = d / 1000.0;
                return L;
            };

            //距離を計算する関数
            Func<double, double, double> GetDir = (lat, lng) =>
            {
                var lat1 = 37.421467 / 180 * Math.PI;
                var lng1 = 141.032577 / 180 * Math.PI;
                var lat2 = lat / 180 * Math.PI;
                var lng2 = lng / 180 * Math.PI;
                var dx = lng2 - lng1;
                var Y = Math.Cos(lat2) * Math.Sin(dx);
                var X = Math.Cos(lat1) * Math.Sin(lat2) - Math.Sin(lat1) * Math.Cos(lat2) * Math.Cos(dx);
                var Dir = Math.Atan2(Y, X) * 180 / Math.PI;

                return Dir < 0 ? Dir + 360 : Dir;
            };

            // 位置情報の追加
            using (var db = new DataClasses1DataContext())
            {
                var maps = db.Map.Where(x => x.緯度.HasValue == false && x.産地都道府県 != "-" && x.産地市町村 != "-" && x.産地市町村.Length <= 15).ToList();
                var places = db.Place.ToList();

                foreach (var map in maps)
                {
                    if (!places.Any(x => x.県 == map.産地都道府県 && x.市 == map.産地市町村))
                    {
                        var url = String.Format("http://maps.google.com/maps/api/geocode/xml?address={0}&sensor=false", HttpUtility.UrlEncode(map.産地都道府県 + map.産地市町村));
                        var doc = XDocument.Load(url);
                        var response = doc.Element("GeocodeResponse");
                        var status = response.Element("status");
                        if (status.Value == "OK")
                        {
                            var result = response.Element("result");
                            var geometry = result.Element("geometry");
                            var location = geometry.Element("location");
                            var lat = Convert.ToDouble(location.Element("lat").Value); //緯度
                            var lng = Convert.ToDouble(location.Element("lng").Value); //経度

                            var place = new Place
                            {
                                県 = map.産地都道府県,
                                市 = map.産地市町村,
                                緯度 = (float)lat,
                                経度 = (float)lng,
                                距離 = (float)GetL(lat, lng),
                                方位 = (float)GetDir(lat, lng)
                            };

                            db.Place.InsertOnSubmit(place);
                            db.SubmitChanges();
                        }
                        else
                        {
                            var place = new Place
                            {
                                県 = map.産地都道府県,
                                市 = map.産地市町村,
                                緯度 = null,
                                経度 = null,
                            };

                            db.Place.InsertOnSubmit(place);
                            db.SubmitChanges();
                        }
                    }
                }
            }
        }

    }
}