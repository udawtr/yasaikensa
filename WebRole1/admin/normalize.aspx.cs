using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebRole1.admin
{
    public partial class normalize : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //donormalize();
            Response.Redirect("geocode.aspx");
        }

        private void donormalize()
        {
            using (var db = new DataClasses1DataContext())
            {
                foreach (var yn in db.YasaiName)
                {
                    if (yn.大分類名 != null && !yn.大分類名.IsNormalized(System.Text.NormalizationForm.FormC))
                    {
                        yn.大分類名 = yn.大分類名.Normalize(System.Text.NormalizationForm.FormC);
                    }
                    if (yn.中分類名 != null && !yn.中分類名.IsNormalized(System.Text.NormalizationForm.FormC))
                    {
                        yn.中分類名 = yn.中分類名.Normalize(System.Text.NormalizationForm.FormC);
                    }
                    //if (yn.品目 != null && !yn.品目.IsNormalized(System.Text.NormalizationForm.FormC))
                    //{
                    //    yn.品目 = yn.品目.Normalize(System.Text.NormalizationForm.FormC);
                    //}
                    if (yn.別名 != null && !yn.別名.IsNormalized(System.Text.NormalizationForm.FormC))
                    {
                        yn.別名 = yn.別名.Normalize(System.Text.NormalizationForm.FormC);
                    }
                    if (yn.補正 != null && !yn.補正.IsNormalized(System.Text.NormalizationForm.FormC))
                    {
                        yn.補正 = yn.補正.Normalize(System.Text.NormalizationForm.FormC);
                    }
                }
                db.SubmitChanges();

                var namedic = db.YasaiName.Select(x => new
                {
                    品目 = x.品目.Normalize(System.Text.NormalizationForm.FormC).Trim(),
                    大分類名 = x.大分類名.Trim(),
                    中分類名 = x.中分類名.Trim(),
                    別名 = x.別名.Trim(),
                    補正 = x.補正.Trim(),
                }).ToList();
                foreach (var item in db.YasaiKensa)
                {
                    //品目名
                    if (!item.品目.IsNormalized(System.Text.NormalizationForm.FormC))
                    {
                        item.品目 = item.品目.Normalize(System.Text.NormalizationForm.FormC);
                    }

                    decimal tmp;
                    if (Decimal.TryParse(item.結果ヨウ素131, out tmp))
                    {
                        if (item.ヨウ素131D != tmp)
                        {
                            item.ヨウ素131D = tmp;
                        }
                    }
                    else if (item.結果ヨウ素131 == "ND")
                    {
                        if (item.ヨウ素131D != 0)
                        {
                            item.ヨウ素131D = 0;
                        }
                    }
                    else
                    {
                        if (item.ヨウ素131D != null)
                        {
                            item.ヨウ素131D = null;
                        }
                    }

                    if (Decimal.TryParse(item.結果セシウム, out tmp))
                    {
                        if (item.セシウムD != tmp)
                        {
                            item.セシウムD = tmp;
                        }
                    }
                    else if (item.結果セシウム == "ND")
                    {
                        if (item.セシウムD != 0)
                        {
                            item.セシウムD = 0;
                        }
                    }
                    else
                    {
                        if (item.セシウムD != null)
                        {
                            item.セシウムD = null;
                        }
                    }

                    if (Decimal.TryParse(item.結果セシウム134, out tmp))
                    {
                        if (item.セシウム134D != tmp)
                        {
                            item.セシウム134D = tmp;
                        }
                    }
                    else if (item.結果セシウム134 == "ND")
                    {
                        if (item.セシウム134D != 0)
                        {
                            item.セシウム134D = 0;
                        }
                    }
                    else
                    {
                        if (item.セシウム134D != null)
                        {
                            item.セシウム134D = null;
                        }
                    }

                    if (Decimal.TryParse(item.結果セシウム137, out tmp))
                    {
                        if (item.セシウム137D != tmp)
                        {
                            item.セシウム137D = tmp;
                        }
                    }
                    else if (item.結果セシウム134 == "ND")
                    {
                        if (item.セシウム137D != 0)
                        {
                            item.セシウム137D = 0;
                        }
                    }
                    else
                    {
                        if (item.セシウム137D != null)
                        {
                            item.セシウム137D = null;
                        }
                    }

                    if (item.採取日D.HasValue == false)
                    {
                        item.採取日D = item.採取日.ToDateTime();
                    }
                    if (item.公表日D.HasValue == false)
                    {
                        item.公表日D = item.厚生省発表日.ToDateTime();
                    }
                    if (item.判明日D.HasValue == false)
                    {
                        item.判明日D = item.結果判明日.ToDateTime();
                    }

                    if (item.産地市町村 == null || item.産地市町村 == "")
                    {
                        item.産地市町村 = "-";
                    }

                    if (item.検査機関 == null || item.検査機関 == "")
                    {
                        item.検査機関 = "-";
                    }

                    if (item.食品カテゴリ == "野菜類")
                    {
                        const string otherYasaiCategoryName = "その他";
                        var kanadic = new Dictionary<char, char>();

                        string hira = "あいうえおかきくけこさしすせそたちつてとなにぬねのはまやらわをんがぎぐげござじずぜぞだぢづでど";
                        string kana = "アイウエノカキクケコサシスセソタチツテトナニヌネノハマヤワラヲンガギグゲゴザジズゼゾタヂヅデド";
                        for (int i = 0; i < hira.Count(); i++)
                        {
                            kanadic[hira[i]] = kana[i];
                        }

                        Func<string, string> tokana = (s1) =>
                        {
                            if (s1 == null) return null;
                            System.Text.StringBuilder sb = new System.Text.StringBuilder(s1);
                            for (int i = 0; i < s1.Length; i++)
                            {
                                if (kanadic.ContainsKey(s1[i])) sb[i] = kanadic[s1[i]];
                            }
                            return sb.ToString();
                        };

                        var yasaiCategoryName = otherYasaiCategoryName;
                        var yasaiName = item.品目.Trim().Replace("（", "(").Replace("）", ")");
                        while (yasaiName.Contains('(') && yasaiName.Contains(')'))
                        {
                            int idx1 = yasaiName.IndexOf('(');
                            int idx2 = yasaiName.IndexOf(')');
                            yasaiName = (yasaiName.Substring(0, idx1) + yasaiName.Substring(idx2 + 1)).Trim();
                        }

                        var dicentry = namedic.FirstOrDefault(x =>
                             tokana(x.品目) == tokana(yasaiName)
                            || tokana(x.別名) == tokana(yasaiName));
                        if (dicentry != null)
                        {
                            yasaiCategoryName = dicentry.大分類名;
                            var temp = dicentry.補正;
                            yasaiName = temp;
                        }
                        else
                        {
                            var edi = db.edicode.FirstOrDefault(x => x.大分類名 == yasaiName || x.中分類名 == yasaiName || x.品名表記カナ == yasaiName || x.品名表記漢字 == yasaiName);
                            if (edi != null)
                            {
                                yasaiCategoryName = edi.大分類名;
                            }
                        }

                        if (item.野菜品名 != yasaiName)
                        {
                            item.野菜品名 = yasaiName;
                        }
                        if (item.野菜分類 != yasaiCategoryName)
                        {
                            item.野菜分類 = yasaiCategoryName;
                        }
                    }
                }
                db.SubmitChanges();
            }
        }
    }
}