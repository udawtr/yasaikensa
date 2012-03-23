using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebRole1
{
    /// <summary>
    /// SpecialChartImage の概要の説明
    /// </summary>
    public class SpecialChartImage : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "image/png";

            using (var db = new DataClasses1DataContext())
            {
                db.ObjectTrackingEnabled = false;

                //var op = new System.Data.Linq.DataLoadOptions();
                //op.LoadWith<ShippingRestriction>(x=>x.ShippingRestrictedCity);
                //op.LoadWith<ShippingRestriction>(x=>x.ShippingRestrictedProduct);
                //db.LoadOptions = op;

                IQueryable<YasaiKensa> list = null;
                var code = context.Request["q"];
                switch (code)
                {
                        /*
                    case "fkyuzu1":
                        list = db.YasaiKensa.Where(x => x.産地都道府県 == "福島県" && (x.産地市町村 == "福島市" || x.産地市町村 == "南相馬市") && x.品目 == "ユズ");
                        break;
                    case "fkyuzu2":
                        list = db.YasaiKensa.Where(x => x.産地都道府県 == "福島県" && (x.産地市町村 == "伊達市" || x.産地市町村 == "桑折町") && x.品目 == "ユズ");
                        break;
                    case "fktakenoko":
                        list = db.YasaiKensa.Where(x => x.産地都道府県 == "福島県" && (x.産地市町村 == "伊達市" || x.産地市町村 == "相馬市" || x.産地市町村 == "いわき市" || x.産地市町村 == "三春町" || x.産地市町村 == "天栄村" || x.産地市町村 == "平田村") && x.品目 == "たけのこ");
                        break;
                    case "fkkusasotetu":
                        list = db.YasaiKensa.Where(x => x.産地都道府県 == "福島県" && (x.産地市町村 == "福島市" || x.産地市町村 == "桑折町") && x.品目.StartsWith("くさそてつ"));
                        break;
                    case "ibpaseri": list = db.YasaiKensa.Where(x => x.産地都道府県 == "茨城県" && x.品目 == "パセリ"); break;
                    case "ibkakina": list = db.YasaiKensa.Where(x => x.産地都道府県 == "茨城県" && x.品目 == "かき菜"); break;
                    case "tgkakina": list = db.YasaiKensa.Where(x => x.産地都道府県 == "栃木県" && x.品目 == "かき菜"); break;
                    case "gmkakina": list = db.YasaiKensa.Where(x => x.産地都道府県 == "群馬県" && x.品目 == "かき菜"); break;
                    case "ibmilk": list = db.YasaiKensa.Where(x => x.産地都道府県 == "茨城県" && x.品目 == "原乳"); break;
                    case "fkmilk": list = db.YasaiKensa.Where(x => x.産地都道府県 == "福島県" && x.品目 == "原乳"); break;
                    case "fkmilkex1": list = db.YasaiKensa.Where(x => x.産地都道府県 == "福島県" && (x.産地市町村 == "喜多方市" || x.産地市町村 == "磐梯町" || x.産地市町村 == "猪苗代町" | x.産地市町村 == "三島町" || x.産地市町村 == "会津美里町" || x.産地市町村 == "下郷町" || x.産地市町村.StartsWith("南会津")) && x.品目 == "原乳"); break;
                    case "fkmilkex2": list = db.YasaiKensa.Where(x => x.産地都道府県 == "福島県" &&
                   (x.産地市町村 == "福島市" || x.産地市町村 == "二本松市" || x.産地市町村 == "伊達市"
                   || x.産地市町村 == "本宮市" || x.産地市町村 == "国見町" || x.産地市町村 == "大玉村"
                   || x.産地市町村 == "郡山市" || x.産地市町村 == "須賀川市" || x.産地市町村 == "田村市"
                   || x.産地市町村 == "三春町" || x.産地市町村 == "小野町" || x.産地市町村 == "鏡石町"
                   || x.産地市町村 == "石川町" || x.産地市町村 == "浅川町" || x.産地市町村 == "平田村"
                   || x.産地市町村 == "古殿町" || x.産地市町村 == "白河市" || x.産地市町村 == "矢吹町"
                   || x.産地市町村 == "泉崎村" || x.産地市町村 == "中島村" || x.産地市町村 == "西郷村"
                   || x.産地市町村 == "鮫川村" || x.産地市町村 == "塙町" || x.産地市町村 == "矢祭町"
                   || x.産地市町村 == "いわき市"
                   ) && x.品目 == "原乳"); break;
                    case "fkmilkex3": list = db.YasaiKensa.Where(x => x.産地都道府県 == "福島県"
                    && (x.産地市町村 == "相馬市" || x.産地市町村 == "新地町") && x.品目 == "原乳"); break;
                    case "fkmilkex4": list = db.YasaiKensa.Where(x => x.産地都道府県 == "福島県" &&
                   (x.産地市町村 == "福島市" || x.産地市町村 == "会津若松市" || x.産地市町村 == "桑折町"
                   || x.産地市町村 == "天栄村" || x.産地市町村 == "檜枝岐村" || x.産地市町村 == "只見町"
                   || x.産地市町村 == "北塩原村" || x.産地市町村 == "西会津町" || x.産地市町村 == "会津坂下町"
                   || x.産地市町村 == "湯川村" || x.産地市町村 == "柳津町" || x.産地市町村 == "金山町"
                   || x.産地市町村 == "昭和村" || x.産地市町村 == "棚倉町" || x.産地市町村 == "玉川村"
                   || x.産地市町村 == "広野町" || x.産地市町村 == "楢葉町"
                   ) && x.品目 == "原乳"); break;

                    case "ibrenso": list = db.YasaiKensa.Where(x => x.産地都道府県 == "茨城県" && (x.産地市町村 != "北茨城市" && x.産地市町村 != "高萩市") && x.品目 == "ほうれん草"); break;
                    case "ibrensoex": list = db.YasaiKensa.Where(x => x.産地都道府県 == "茨城県" && (x.産地市町村 == "北茨城市" || x.産地市町村 == "高萩市") && x.品目 == "ほうれん草"); break;
                    case "tgrenso": list = db.YasaiKensa.Where(x => x.産地都道府県 == "栃木県" && (x.産地市町村 == "那須塩原市" || x.産地市町村 == "塩谷町") && x.品目 == "ほうれん草"); break;
                    case "tgrensoex": list = db.YasaiKensa.Where(x => x.産地都道府県 == "栃木県" && (x.産地市町村 != "那須塩原市" && x.産地市町村 != "塩谷町") && x.品目 == "ほうれん草"); break;
                    case "gmrenso": list = db.YasaiKensa.Where(x => x.産地都道府県 == "群馬県" && x.品目 == "ほうれん草"); break;
                    case "tbrensoex": list = db.YasaiKensa.Where(x => x.産地都道府県 == "千葉県" && (x.産地市町村 == "旭市" || x.産地市町村 == "香取市" || x.産地市町村 == "多古町") && x.品目 == "ほうれん草"); break;

                    case "asahipaseri": list = db.YasaiKensa.Where(x => x.産地都道府県 == "千葉県" && x.産地市町村 == "旭市" && x.品目 == "パセリ"); break;
                    case "asahiseruri": list = db.YasaiKensa.Where(x => x.産地都道府県 == "千葉県" && x.産地市町村 == "旭市" && x.品目 == "セルリー"); break;
                    case "asahishungiku": list = db.YasaiKensa.Where(x => x.産地都道府県 == "千葉県" && x.産地市町村 == "旭市" && x.品目 == "春菊"); break;
                    case "asahigensai": list = db.YasaiKensa.Where(x => x.産地都道府県 == "千葉県" && x.産地市町村 == "旭市" && x.品目 == "チンゲンサイ"); break;
                    case "asahisanchu": list = db.YasaiKensa.Where(x => x.産地都道府県 == "千葉県" && x.産地市町村 == "旭市" && x.品目 == "サンチュ"); break;

                    case "fkikanago": list = db.YasaiKensa.Where(x => x.産地都道府県 == "福島県" && x.品目 == "コウナゴ(イカナゴ)"); break;
                    case "fkkabu": list = db.YasaiKensa.Where(x => x.産地都道府県 == "福島県" && x.品目.StartsWith("カブ")); break;
                    case "fkyokeisai":
                        var ediYokeisai = db.edicode.Where(x => x.大分類名 == "葉茎菜類");
                        var etcYokeisai = db.YasaiName.Where(x => x.大分類名 == "葉茎菜類");
                        list = db.YasaiKensa.Where(x => x.産地都道府県 == "福島県" && x.食品カテゴリ == "野菜類"
                            && (ediYokeisai.Any(e => e.大分類名 == x.品目 || e.中分類名 == x.品目 || e.品名表記カナ == x.品目 || e.品名表記漢字 == x.品目)
                            || etcYokeisai.Any(e => e.品目 == x.品目))); break;
                    case "fkume1": list = db.YasaiKensa.Where(x => x.産地都道府県 == "福島県" && (x.産地市町村 == "福島市" || x.産地市町村 == "伊達市" || x.産地市町村 == "桑折") && x.品目 == "ウメ"); break;
                    case "fkume2": list = db.YasaiKensa.Where(x => x.産地都道府県 == "福島県" && (x.産地市町村 == "相馬市" || x.産地市町村 == "南相馬") && x.品目 == "ウメ"); break;
                    case "fkyamame": list = db.YasaiKensa.Where(x => x.産地都道府県 == "福島県" && (x.品目 == "ヤマメ" || x.品目 == "ヤマメ（天然）")); break;
                    case "fkugui": list = db.YasaiKensa.Where(x => x.産地都道府県 == "福島県" && (x.品目 == "ウグイ" || x.品目 == "ウグイ（養殖）" || x.品目 == "ウグイ（天然）")); break;
                    case "fkayu": list = db.YasaiKensa.Where(x => x.産地都道府県 == "福島県" && (x.品目 == "アユ" || x.品目 == "アユ（養殖）" || x.品目 == "アユ（天然）")); break;
                    case "fkgyuniku": list = db.YasaiKensa.Where(x => x.産地都道府県 == "福島県" && x.品目.StartsWith("牛肉")); break;
                    case "iwgyuniku": list = db.YasaiKensa.Where(x => x.産地都道府県 == "岩手県" && x.品目.StartsWith("牛肉")); break;
                    case "mggyuniku": list = db.YasaiKensa.Where(x => x.産地都道府県 == "宮城県" && x.品目.StartsWith("牛肉")); break;
                    case "tggyuniku": list = db.YasaiKensa.Where(x => x.産地都道府県 == "栃木県" && x.品目.StartsWith("牛肉")); break;
                    case "gmcha": list = db.YasaiKensa.Where(x => x.産地都道府県 == "群馬県" && (x.産地市町村 == "渋川市" || x.産地市町村 == "桐生市") && x.野菜品名 == "茶"); break;

                    case "ibcha": list = db.YasaiKensa.Where(x => x.産地都道府県 == "茨城県" && x.野菜品名 == "茶"); break;
                    case "ibcha1": list = db.YasaiKensa.Where(x => x.産地都道府県 == "茨城県" && (x.産地市町村 == "古河市" || x.産地市町村 == "常総市" || x.産地市町村 == "坂東市" || x.産地市町村 == "八千代町" || x.産地市町村 == "境町") && x.野菜品名 == "茶"); break;
                    case "tgcha1": list = db.YasaiKensa.Where(x => x.産地都道府県 == "栃木県" && (x.産地市町村 == "鹿沼市" || x.産地市町村 == "大田原市") && x.野菜品名 == "茶"); break;
                    case "tgcha2": list = db.YasaiKensa.Where(x => x.産地都道府県 == "栃木県" && (x.産地市町村 == "栃木市") && x.野菜品名 == "茶"); break;
                    case "tbcha1": list = db.YasaiKensa.Where(x => x.産地都道府県 == "千葉県" && (x.産地市町村 == "野田市" || x.産地市町村 == "成田市" || x.産地市町村 == "八街市" || x.産地市町村 == "富里市" || x.産地市町村 == "山武市") && x.野菜品名 == "茶"); break;
                    case "tbcha2": list = db.YasaiKensa.Where(x => x.産地都道府県 == "千葉県" && (x.産地市町村 == "勝浦市") && x.野菜品名 == "茶"); break;
                    case "tbcha3": list = db.YasaiKensa.Where(x => x.産地都道府県 == "千葉県" && (x.産地市町村 == "大網白里町") && x.野菜品名 == "茶"); break;
                    case "kncha1": list = db.YasaiKensa.Where(x => x.産地都道府県 == "神奈川県" && (x.産地市町村 == "小田原市" || x.産地市町村 == "真鶴町" || x.産地市町村 == "湯河原町") && x.野菜品名 == "茶"); break;
                    case "kncha5": list = db.YasaiKensa.Where(x => x.産地都道府県 == "神奈川県" && (x.産地市町村 == "愛川町" || x.産地市町村 == "清川村") && x.野菜品名 == "茶"); break;
                    case "kncha2": list = db.YasaiKensa.Where(x => x.産地都道府県 == "神奈川県" && (x.産地市町村 == "相模原市" || x.産地市町村 == "松田町" || x.産地市町村 == "山北町") && x.野菜品名 == "茶"); break;
                    case "kncha3": list = db.YasaiKensa.Where(x => x.産地都道府県 == "神奈川県" && (x.産地市町村 == "中井町") && x.野菜品名 == "茶"); break;
                    case "kncha4": list = db.YasaiKensa.Where(x => x.産地都道府県 == "神奈川県" && (x.産地市町村 == "南足柄市") && x.野菜品名 == "茶"); break;
                    case "fkshitakeroji1": list = db.YasaiKensa.Where(x => x.産地都道府県 == "福島県" && (x.産地市町村 == "伊達市" || x.産地市町村 == "相馬市" || x.産地市町村 == "南相馬市" || x.産地市町村 == "田村市" || x.産地市町村 == "川俣町" || x.産地市町村 == "浪江町" || x.産地市町村 == "双葉町" || x.産地市町村 == "大熊町" || x.産地市町村 == "富岡町" || x.産地市町村 == "楢葉町" || x.産地市町村 == "広野町" || x.産地市町村 == "飯舘村" || x.産地市町村 == "葛尾村" || x.産地市町村 == "川内村") && x.品目 == "原木しいたけ(露地)"); break;
                    case "fkshitakeroji2": list = db.YasaiKensa.Where(x => x.産地都道府県 == "福島県" && (x.産地市町村 == "福島市") && x.品目 == "原木しいたけ(露地)"); break;
                    case "fkshitakeroji3": list = db.YasaiKensa.Where(x => x.産地都道府県 == "福島県" && (x.産地市町村 == "本宮市") && x.品目 == "原木しいたけ(露地)"); break;
                    case "fkshitakeroji4": list = db.YasaiKensa.Where(x => x.産地都道府県 == "福島県" && (x.産地市町村 == "二本松市") && x.品目 == "原木しいたけ(露地)"); break;
                    case "fkshitakegenboku1": list = db.YasaiKensa.Where(x => x.産地都道府県 == "福島県" && (x.産地市町村 == "伊達市") && x.品目 == "原木しいたけ(施設)"); break;
                    case "fkshitakegenboku2": list = db.YasaiKensa.Where(x => x.産地都道府県 == "福島県" && (x.産地市町村 == "新地町") && x.品目 == "原木しいたけ(施設)"); break;
                    case "fkshitakegenboku3": list = db.YasaiKensa.Where(x => x.産地都道府県 == "福島県" && (x.産地市町村 == "本宮市") && x.品目 == "原木しいたけ(施設)"); break;
                    case "fkkinoko": list = db.YasaiKensa.Where(x => x.産地都道府県 == "福島県" && (x.産地市町村 == "棚倉町" || x.産地市町村 == "古殿町") && x.野菜分類 == "きのこ・山菜類"); break;
                    case "fkkinoko1": list = db.YasaiKensa.Where(x => x.産地都道府県 == "福島県" && (x.産地市町村 == "喜多方市") && x.品目 == "野生キノコ"); break;
                    case "tbshitakeroji1": list = db.YasaiKensa.Where(x => x.産地都道府県 == "千葉県" && (x.産地市町村 == "我孫子市" || x.産地市町村 == "君津市") && x.品目 == "原木しいたけ(露地)"); break;
                    case "ibshitakegenboku1": list = db.YasaiKensa.Where(x => x.産地都道府県 == "茨城県" && (x.産地市町村 == "鉾田市" || x.産地市町村 == "土浦市") && (x.品目 == "原木しいたけ(露地)" || x.品目 == "原木しいたけ(施設)")); break;
                    case "ibshitakegenboku2": list = db.YasaiKensa.Where(x => x.産地都道府県 == "茨城県" && (x.産地市町村 == "小美玉市" || x.産地市町村 == "行方市") && x.品目 == "原木しいたけ(露地)"); break;
                        */
                    default:

                        var sr = db.ShippingRestriction.SingleOrDefault(x => x.Code == code);
                        if (sr != null)
                        {
                            list = db.YasaiKensa.Where(x=>x.産地都道府県 == sr.PrefName);

                            if (sr.CityFilterMode == 1)
                            {
                                var cities = db.ShippingRestrictedCity.Where(x => x.ShippingRestrictionCode == code).Select(x=>x.CityName).ToList();
                                list = list.Where(x=>cities.Contains(x.産地市町村));
                            }
                            else if( sr.CityFilterMode == 2 )
                            {
                                var cities = db.ShippingRestrictedCity.Where(x => x.ShippingRestrictionCode == code).Select(x => x.CityName).ToList();
                                list = list.Where(x=>!cities.Contains(x.産地市町村));
                            }

                            if (sr.ProductFilterMode == 10)
                            {
                                var products = db.ShippingRestrictedProduct.Where(x => x.ShippingRestrictionCode == code).Select(x => x.ProductName).ToList();
                                list = list.Where(x => products.Contains(x.品目));
                            }
                            else if (sr.ProductFilterMode == 11)
                            {
                                var products = db.ShippingRestrictedProduct.Where(x => x.ShippingRestrictionCode == code).Select(x => x.ProductName).ToList();
                                foreach (var item in products)
                                {
                                    list = list.Where(x => x.品目.StartsWith(item));
                                }
                            }
                            else if (sr.ProductFilterMode == 20)
                            {
                                var products = db.ShippingRestrictedProduct.Where(x => x.ShippingRestrictionCode == code).Select(x => x.ProductName).ToList();
                                list = list.Where(x => products.Contains(x.野菜品名));
                            }
                            else if (sr.ProductFilterMode == 30)
                            {
                                var products = db.ShippingRestrictedProduct.Where(x => x.ShippingRestrictionCode == code).Select(x => x.ProductName).ToList();
                                list = list.Where(x => products.Contains(x.野菜分類));
                            }
                            else if (sr.ProductFilterMode == 40)
                            {
                                var products = db.ShippingRestrictedProduct.Where(x => x.ShippingRestrictionCode == code).Select(x=>x.ProductName).ToList();

                                var ediYokeisai = db.edicode.Where(x => products.Contains(x.大分類名));
                                var etcYokeisai = db.YasaiName.Where(x => products.Contains(x.大分類名));
                                list = db.YasaiKensa.Where(x => x.食品カテゴリ == "野菜類"
                                    && (ediYokeisai.Any(e => e.大分類名 == x.品目 || e.中分類名 == x.品目 || e.品名表記カナ == x.品目 || e.品名表記漢字 == x.品目)
                                    || etcYokeisai.Any(e => e.品目 == x.品目)));
                            }
                        }

                        break;
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