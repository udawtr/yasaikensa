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
    public static class Common
    {


        public static Tuple<IList<YasaiKensa>, string> GetQuery(string prefFilter, string cityFilter, string categoryFilter, string productFilter, string publishDayFiler, string pickDayFilter, string sortItem)
        {
            using (var db = new DataClasses1DataContext())
            {
                IEnumerable<YasaiKensa> q = db.YasaiKensa;
                var TweetMessage = "";
                if (prefFilter != "全て")
                {
                    q = q.Where(s => s.産地都道府県 == prefFilter.Normalize(System.Text.NormalizationForm.FormC).Trim());
                    TweetMessage += prefFilter;
                    if (cityFilter != "全て")
                    {
                        q = q.Where(s => s.産地市町村 == cityFilter.Normalize(System.Text.NormalizationForm.FormC).Trim());
                        TweetMessage += cityFilter;
                    }
                    TweetMessage += "の";
                }
                else
                {
                    TweetMessage += "全国の";
                }
                if (categoryFilter != "全て")
                {
                    q = q.Where(s => s.食品カテゴリ == categoryFilter.Normalize(System.Text.NormalizationForm.FormC).Trim());
                    if (productFilter != "全て")
                    {
                        if (categoryFilter == "野菜類")
                        {
                            q = q.Where(s => s.野菜品名 == productFilter.Normalize(System.Text.NormalizationForm.FormC).Trim());
                        }
                        else
                        {
                            q = q.Where(s => s.品目 == productFilter.Normalize(System.Text.NormalizationForm.FormC).Trim());
                        } 
                        TweetMessage += productFilter;
                    }
                    else
                    {
                        TweetMessage += categoryFilter;
                    }
                    TweetMessage += "の";
                }
                TweetMessage += "放射能検査データ";
                if (publishDayFiler != "全て" && publishDayFiler != "ALL")
                {
                    if (publishDayFiler == "3週間以内" || publishDayFiler=="3W")
                    {
                        q = q.Where(s => s.公表日D >= DateTime.Now.AddDays(-21.0));
                    }
                    else
                    {
                        q = q.Where(s => s.厚生省発表日 == publishDayFiler);
                    }
                    TweetMessage += "(" + publishDayFiler + "発表)";
                }
                if (pickDayFilter == "3w")
                {
                    q = q.Where(s => s.採取日D.HasValue && s.採取日D >= DateTime.Now.AddDays(-21.0));
                    TweetMessage += "(3週間以内採取)";
                }
                TweetMessage += "は";

                if (sortItem == "1")
                {
                    q = q.OrderByDescending(x => x.採取日D);
                }
                else if (sortItem == "2")
                {
                    q = from x in q orderby x.公表日D descending, x.No select x;
                }

                var list = q.ToList();

                TweetMessage += String.Format("{0}件。暫定規制値を超えたのは{1}件。", list.Count(), list.Count(x => x.Is暫定規制値Over));

                return new Tuple<IList<YasaiKensa>,string>(list, TweetMessage);
            }
        }

        public static string ToCityFilterModeString(ShippingRestriction sr)
        {
            if (sr.CityFilterMode == 0)
            {
                return "全て";
            }
            else if (sr.CityFilterMode == 1)
            {
                return "市区町村";
            }
            else if (sr.CityFilterMode == 2)
            {
                return "市区町村除く";
            }
            return "";
        }

        public static string ToProductFilterModeString(ShippingRestriction sr)
        {
            if (sr.ProductFilterMode == 0)
            {
                return "全て";
            }
            else if (sr.ProductFilterMode == 10)
            {
                return "品目";
            }
            else if (sr.ProductFilterMode == 11)
            {
                return "品目先頭一致";
            }
            else if (sr.ProductFilterMode == 20)
            {
                return "野菜品名";
            }
            else if (sr.ProductFilterMode == 30)
            {
                return "野菜分類";
            }
            else if (sr.ProductFilterMode == 40)
            {
                return "EDI分類";
            }
            return "";
        }

        public static string ToDate(this string s)
        {
            int temp;
            if (Int32.TryParse(s, out temp))
            {
                var dt = new DateTime(1900, 1, 1).AddDays(temp-2);
                return String.Format("H{0}.{1}.{2}", dt.Year-1988, dt.Month, dt.Day);
            }
            return s;
        }

        public static DateTime? ToDateTime(this string s)
        {
            //認識すべき年月日フォーマットを指定する
            string[] expectedDateFormats = {"yyyy/MM/dd", "yyyy/M/d", "yyyy年MM月dd日", "yyyy年M月d日" };

            DateTime d;
            bool res;

            res = System.DateTime.TryParseExact(
                        s.Replace("H23","2011").Replace("H24", "2012").Replace(".","/"),
                        expectedDateFormats,
                        System.Globalization.DateTimeFormatInfo.InvariantInfo,
                        System.Globalization.DateTimeStyles.None, out d);

            if (res) return d;
            else return null;
        }

        public static string PreparePrefURL(this IList<YasaiKensa> list)
        {
            return PreparePrefURL(list, 150, 150);
        }


        public static string PreparePrefURL(this IList<YasaiKensa> list, int width ,int height)
        {
            using (var db = new DataClasses1DataContext())
            {
                var prefnames = list.GroupBy(x => x.産地都道府県).Select(x => x.Key);
                var prefcodes = db.PrefCode.Where(x => prefnames.Contains(x.Name)).Select(x => String.Format("JP-{0:00}", x.No)).ToList();
                var colors = new string[prefcodes.Count + 1];
                for (int i = 1; i < colors.Length; i++)
                {
                    colors[i] = "0000FF";
                }
                colors[0] = "B3BCC0";

                var baseurl = "https://chart.googleapis.com/chart?";
                var cht = "map:fixed=31,130,45,146";
                var chs = String.Format("{0}x{1}", width, height);
                var chld = String.Join("|", prefcodes);
                var chco = String.Join("|", colors);
                var url = String.Format("{0}cht={1}&chs={2}&chld={3}&chco={4}", baseurl, cht, chs, chld, chco);

                return url;
            }
        }

        public static string PrepareChartURL(this IList<YasaiKensa> list)
        {
            return PrepareChartURL(list, 600, 300);
        }

        public static string PrepareChartURL(this IList<YasaiKensa> list, int width, int height)
        {
            string baseurl = "https://chart.googleapis.com/chart?";
            var param = PrepareChartParam(list, width, height);
            var url = baseurl + String.Join("&", param);
            return url;
        }

        public static string PrepareChartForm(this IList<YasaiKensa> list, int width, int height)
        {
            var param = PrepareChartParam(list, width, height);

            var form = "<form action='https://chart.googleapis.com/chart' method='POST' id='post_form'" +
          "onsubmit=\"this.action = 'https://chart.googleapis.com/chart?chid=' + (new Date()).getMilliseconds(); return true;\">" +
           String.Join("", param.Select(x => String.Format("<input type='hidden' name='{0}' value='{1}'/>",
               x.Substring(0, x.IndexOf('=') - 1)
               , x.Substring(x.IndexOf('=') + 1)))) + "<input type='submit'/></form>";

            return form;
        }

        public static List<string> PrepareChartParam(this IList<YasaiKensa> list, int width, int height)
        {
            var chs = String.Format("{0}x{1}", width, height);
            string cht = "lc";

            //Chart Legend
            string chdl = "ヨウ素|セシウム";

            //Chart Legend Option
            string chdlp = "b";

            //Series Color
            string chco = "FF9900,0099FF";

            //Axis Labels
            string chxl = "2:||採取日(H23.3.11からの経過日数)||3:||Bq/kg||4:|セシウム規制値|ヨウ素規制値";


            DateTime baseDate = new DateTime(2011, 3, 11);
            int maxday = (int)DateTime.Now.Subtract(baseDate).Days;


            var listLimitI = list.GroupBy(x => x.ヨウ素基準値).ToList();
            var listLimitCS = list.GroupBy(x => x.セシウム基準値).ToList();

            double limitCs = listLimitCS.Count == 1 ? (double)listLimitCS[0].Key : 0.0;
            double limitI = listLimitI.Count == 1 ? (double)listLimitI[0].Key : 0.0;
            bool showLimit = limitCs > 0 && limitI > 0;
            double maxbq =  list.Count == 0 ? 0 : list.Max(x => Math.Max((double)x.セシウム合計, (double)x.ヨウ素131D.GetValueOrDefault()));

            //Custom Scaling
            var ymax =  Math.Pow(10.0, Math.Ceiling(Math.Log(maxbq, 10)));
            var ymaxa = Math.Max(100.0, ymax / 2 > maxbq ? ymax / 2 : ymax);
            ymaxa = Math.Max(100.0, ymaxa / 2 > maxbq ? ymaxa / 2 : ymaxa);
            string chds = String.Format("0,{0}", ymaxa);

            //Grid lines
            string chg = String.Format("{0:0.####},{1:0.####},3,3", 100.0 / maxday, ymaxa);

            // Axis
            var listAxis = new[] { new {Id=0, Type="x"},  new {Id=1, Type="y"}, new {Id=2, Type="x"}, new {Id=3, Type="y"}, new {Id=4, Type="r"}};
            var axisX = listAxis[0];
            var axisY = listAxis[1];
            var axisXForLabel = listAxis[2];
            var axisYForLabel = listAxis[3];
            var axisYForLimit = listAxis[4];
            string chxt = "x,y,x,y" + (showLimit ? ",r" : "");

            // Axis Range
            string chxr = String.Format("{0},0,{1}|{2},0,{3}", axisX.Id, maxday, axisY.Id, ymaxa) +
                (showLimit ? String.Format("|{0},0,{1}", axisYForLimit.Id, ymaxa) : "");

            // Axis Label Positions
            string chxp =　limitCs > 0 && limitI > 0 ? String.Format("{0},{1},{2}", axisYForLimit.Id, limitCs, limitI) : "";

            // Axis Label Style
            string chxs = String.Format("{0},0000dd,10,-1,t,FF0000", axisYForLimit.Id);

            // Axis tick mark Style
            string chxtc = String.Format("{0},-1000", axisYForLimit.Id);

            var Imax = new string[maxday + 1];
            var Imin = new string[maxday + 1];
            var Imid = new string[maxday + 1];
            var Csmax = new string[maxday + 1];
            var Csmin = new string[maxday + 1];
            var Csmid = new string[maxday + 1];
            for (int i = 0; i < maxday+1; i++)
            {
                Imax[i] = Imin[i] = Imid[i] = Csmax[i] = Csmin[i] = Csmid[i] = "-1";
            }

            foreach (var group in list.GroupBy(x => x.採取日D.GetValueOrDefault()).Where(x=>x.Key < DateTime.Now))
            {
                if (group.Key != null)
                {
                    var day = (int)group.Key.Subtract(baseDate).Days;
                    if (day >= 0)
                    {
                        {
                            var sublist = group.Where(x => x.ヨウ素131D.HasValue).ToList();
                            if (sublist.Count() > 0)
                            {
                                var max = (double)sublist.Max(x => x.ヨウ素131D.Value);
                                var min = (double)sublist.Min(x => x.ヨウ素131D.Value);
                                var mid = (max + min) / 2;
                                Imax[day] = max.ToString("0.##");
                                Imin[day] = min.ToString("0.##");
                                Imid[day] = mid.ToString("0.##");
                            }
                        }
                        {
                            var sublist = group.Where(x => (x.セシウム134D.HasValue && x.セシウム137D.HasValue) || x.セシウムD.HasValue).ToList();
                            if (sublist.Count() > 0)
                            {
                                var max = (double)sublist.Max(x => x.セシウム合計);
                                var min = (double)sublist.Min(x => x.セシウム合計);
                                var mid = (max + min) / 2;
                                Csmax[day] = max.ToString("0.##");
                                Csmin[day] = min.ToString("0.##");
                                Csmid[day] = mid.ToString("0.##");
                            }
                        }
                    }
                }
            }

            //Data
            var datalist = new List<string>{
                String.Join(",",Imin),
                String.Join(",",Imax),
                String.Join(",",Imid),
                String.Join(",",Csmin),
                String.Join(",",Csmax),
                String.Join(",",Csmid)
            };
            string chd = String.Format("t0:{0}", String.Join("|", datalist));

            //Candlestick markers
            string chm = String.Format("E,FF9900,0,1:40,1|s,FF9900,2,-1,7|E,0099FF,3,-1,1|c,0099FF,5,-1,7"
                );

            //Make URL
            var param = new List<string>
            {
                "chs="+chs,
                "cht="+cht,
                "chd="+chd,
                "chds="+chds,
                "chxr="+chxr,
                "chm="+chm,
                "chxt="+chxt,
                "chxl="+chxl,
                "chxs="+chxs,
                "chxtc="+chxtc,
                "chg="+chg,
                "chdlp="+chdlp,
                "chdl="+chdl,
                "chco="+chco
            };
            if (chxp != "") param.Add("chxp=" + chxp);
            return param;
        }

        public static void PrepareData(this Chart Chart1, IList<YasaiKensa> list)
        {
            Series sヨウ素 = Chart1.Series["ヨウ素"];
            Series sセシウム = Chart1.Series["セシウム"];
            Series sヨウ素規制値 = Chart1.Series["ヨウ素規制値"];
            Series sセシウム規制値 = Chart1.Series["セシウム規制値"];

            sヨウ素.Color = System.Drawing.Color.Red;
            sヨウ素規制値.Color = System.Drawing.Color.DarkRed;
            sセシウム.Color = System.Drawing.Color.Blue;
            sセシウム規制値.Color = System.Drawing.Color.DarkBlue;

            DateTime baseDate = new DateTime(2011, 3, 11);
            double maxday = (double)DateTime.Now.Subtract(baseDate).Days;
            Chart1.ChartAreas[0].AxisX.Maximum = maxday;

            var listヨウ素規制値 = list.GroupBy(x => x.ヨウ素基準値).ToList();
            if (listヨウ素規制値.Count == 1)
            {
                sヨウ素規制値.Points.AddXY(0.0, listヨウ素規制値[0].Key);
                sヨウ素規制値.Points.AddXY(maxday, listヨウ素規制値[0].Key);
                sヨウ素規制値.LegendText = String.Format("ヨウ素規制値={0}[Bq/kg]", listヨウ素規制値[0].Key);
            }
            else
            {
                Chart1.Series.Remove(sヨウ素規制値);
            }

            var listセシウム規制値 = list.GroupBy(x => x.セシウム基準値).ToList();
            if (listセシウム規制値.Count == 1)
            {
                sセシウム規制値.Points.AddXY(0.0, listセシウム規制値[0].Key);
                sセシウム規制値.Points.AddXY(maxday, listセシウム規制値[0].Key);
                sセシウム規制値.LegendText = String.Format("セシウム規制値={0}[Bq/kg]", listセシウム規制値[0].Key);
            }
            else
            {
                Chart1.Series.Remove(sセシウム規制値);
            }

            foreach (var group in list.GroupBy(x => x.採取日D.GetValueOrDefault()))
            {
                if (group.Key != null)
                {
                    var day = (double)group.Key.Subtract(baseDate).Days;
                    {
                        var sublist = group.Where(x => x.ヨウ素131D.HasValue).ToList();
                        if (sublist.Count() > 0)
                        {
                            var max = (double)sublist.Max(x => x.ヨウ素131D.Value);
                            var min = (double)sublist.Min(x => x.ヨウ素131D.Value);
                            var mid = (max + min) / 2;
                            var dp = new DataPoint(day, new double[] { mid, min, max });
                            dp.ToolTip = String.Format("ヨウ素131={0}～{1}[Bq/kg]({2}件)", min == 0.0 ? "ND" : min.ToString(), max == 0.0 ? "ND" : max.ToString(), group.Count());
                            sヨウ素.Points.Add(dp);
                        }
                    }
                    {
                        var sublist = group.Where(x => (x.セシウム134D.HasValue && x.セシウム137D.HasValue) || x.セシウムD.HasValue).ToList();
                        if( sublist.Count() > 0 )
                        {
                            var max = (double)sublist.Max(x=> x.セシウム134D.GetValueOrDefault() + x.セシウム137D.GetValueOrDefault() + x.セシウムD.GetValueOrDefault());
                            var min = (double)sublist.Min(x=> x.セシウム134D.GetValueOrDefault() + x.セシウム137D.GetValueOrDefault() + x.セシウムD.GetValueOrDefault());
                            var mid = (max + min) / 2;
                            var dp = new DataPoint(day, new double[] { mid, min, max });
                            dp.ToolTip = String.Format("セシウム={0}～{1}[Bq/kg]({2}件)", min == 0.0 ? "ND" : min.ToString(), max == 0.0 ? "ND" : max.ToString(), group.Count());
                            sセシウム.Points.Add(dp);
                        }
                     }
                }
            }
        }
    }
}