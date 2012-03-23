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
    public partial class Search : System.Web.UI.Page
    {
        protected IList<YasaiKensa> list;
        protected string TweetMessage;


        protected void Page_Load(object sender, EventArgs e)
        {
            list = new List<YasaiKensa>();

            if (!Page.IsPostBack)
            {
                UpdateFilterList();

                bool doSearch  =false;
                if (Request["pref"] != null)
                {
                    var li = prefFilterList.Items.FindByValue(Request["pref"]);
                    if (li != null)
                    {
                        prefFilterList.ClearSelection();
                        li.Selected = true;
                        doSearch = true;
                        UpdateCityFilterList();
                    }
                }
                var category = Request["category"];
                //if (category == null) category = "野菜類";
                if (category != null)
                {
                    var li = categoryFilterList.Items.FindByValue(category);
                    if (li != null)
                    {
                        categoryFilterList.ClearSelection();
                        li.Selected = true;
                        doSearch = true;
                        UpdateProductFilterList();

                        var product = Request["product"];
                        //if (product == null) product = "ほうれん草";
                        if (product != null)
                        {
                            li = productFilterList.Items.FindByValue(product);
                            if (li != null)
                            {
                                productFilterList.ClearSelection();
                                li.Selected = true;
                                doSearch = true;
                            }
                        }
                    }
                }
                if (doSearch)
                {
                    UpdateQueryResult();
                }
            }

            //UpdateQueryResult();
        }

        protected void prefFilterList_SelectedIndexChanged(object sender, EventArgs e)
        {
            UpdateCityFilterList();
            UpdateCategoryList();
        }

        protected void cityFilterList_SelectedIndexChanged(object sender, EventArgs e)
        {
            //UpdateQueryResult();
            UpdateCategoryList();
        }

        protected void categoryFilterList_SelectedIndexChanged(object sender, EventArgs e)
        {
            UpdateProductFilterList();
        }

        protected void productFilterList_SelectedIndexChanged(object sender, EventArgs e)
        {
            //UpdateQueryResult();
        }

        IList<YasaiKensa> GetQueryResult()
        {
            string prefFilter = prefFilterList.SelectedIndex > 0 ? prefFilterList.SelectedValue : "全て";
            string cityFilter = cityFilterList.SelectedIndex > 0 ? cityFilterList.SelectedValue : "全て";
            string categoryFilter = categoryFilterList.SelectedIndex > 0 ? categoryFilterList.SelectedValue : "全て";
            string productFilter = productFilterList.SelectedIndex > 0 ? productFilterList.SelectedValue : "全て";
            string publishDayFilter = publishDayFilerList.SelectedIndex > 0 ? publishDayFilerList.SelectedValue : "全て";
            string pickDayFilter = pickDayFilterList.SelectedIndex > 0 ? pickDayFilterList.SelectedValue : "全て";
            var ret = Common.GetQuery(prefFilter, cityFilter, categoryFilter, productFilter, publishDayFilter, pickDayFilter, sortItem.SelectedValue);

            bqByDayImage.ImageUrl = String.Format("SearchChartImage.ashx?width=800&pref={0}&city={1}&category={2}&product={3}&publish={4}&pick={5}&sort={6}",
                HttpUtility.UrlEncode(prefFilter),
                HttpUtility.UrlEncode(cityFilter),
                HttpUtility.UrlEncode(categoryFilter),
                HttpUtility.UrlEncode(productFilter),
                HttpUtility.UrlEncode(publishDayFilter),
                HttpUtility.UrlEncode(pickDayFilter),
                HttpUtility.UrlEncode(sortItem.SelectedValue)
                );

            TweetMessage = ret.Item2;
            return ret.Item1;
        }

        void UpdateQueryResult()
        {
            var q = GetQueryResult();
            list = q;

            UpdatePanel2.Visible = true;

            //bqByDayImage.ImageUrl = list.PrepareChartURL();
            prefImage.ImageUrl = list.PreparePrefURL();
        }

        void UpdateFilterList()
        {
            using (var db = new DataClasses1DataContext())
            {
                var dataSet = db.YasaiKensa;
                var pref = dataSet.Select(x => x.産地都道府県).Distinct().ToList();
                pref.Insert(0, "全て");
                prefFilterList.DataSource = pref;
                prefFilterList.SelectedIndex = 0;
                prefFilterList.DataBind();
                UpdateCityFilterList();

                UpdateCategoryList();

                var publishDay = dataSet.Select(x => x.厚生省発表日).Distinct().OrderBy(x => x).ToList();
                publishDay.Insert(0, "全て");
                publishDay.Insert(1, "3週間以内");
                publishDayFilerList.DataSource = publishDay;
                publishDayFilerList.SelectedIndex = 1;
                publishDayFilerList.DataBind();
            }
        }

        void UpdateCategoryList()
        {
            using (var db = new DataClasses1DataContext())
            {
                var currentValue = categoryFilterList.SelectedValue;

                var dataSet = db.YasaiKensa;
                var qCategory = dataSet.AsQueryable();
                if (prefFilterList.SelectedIndex > 0)
                {
                    qCategory = qCategory.Where(s => s.産地都道府県 == (string)prefFilterList.SelectedValue);
                    if (cityFilterList.SelectedIndex > 0)
                    {
                        qCategory = qCategory.Where(s => s.産地市町村 == (string)cityFilterList.SelectedValue);
                    }
                }
                var category = qCategory.
                    GroupBy(x => x.食品カテゴリ).
                    OrderByDescending(x=>x.Count()).
                    Select(x => new ListItem(String.Format("{0}[{1}]", x.Key, x.Count()), x.Key))
                    .ToList();
                category.Insert(0, new ListItem("全て", ""));
                categoryFilterList.DataSource = category;
                categoryFilterList.DataBind();
                if (category.Any(x => x.Value == currentValue))
                {
                    categoryFilterList.SelectedValue = currentValue;
                }
                else
                {
                    categoryFilterList.SelectedIndex = 0;
                }
                UpdateProductFilterList();
            }
        }

        void UpdateCityFilterList()
        {
            if (prefFilterList.SelectedIndex <= 0)
            {
                cityFilterList.Enabled = false;
                productFilterList.DataSource = new string[] { };
                cityFilterList.DataBind();
            }
            else
            {
                cityFilterList.Enabled = true;

                using (var db = new DataClasses1DataContext())
                {
                    var dataSet = db.YasaiKensa;
                    var city = dataSet
                        .Where(x => x.産地都道府県 == (string)prefFilterList.SelectedValue)
                        .Select(x => x.産地市町村).Distinct().ToList();
                    city.Insert(0, "全て");
                    cityFilterList.DataSource = city;
                    cityFilterList.DataBind();
                    cityFilterList.SelectedIndex = 0;
                }
            }
        }

        void UpdateProductFilterList()
        {
            if (categoryFilterList.SelectedIndex <= 0)
            {
                productFilterList.Enabled = false;
                productFilterList.DataSource = new string[]{};
                productFilterList.DataBind();
            }
            else
            {
                productFilterList.Enabled = true;

                using (var db = new DataClasses1DataContext())
                {
                    var currentValue = productFilterList.SelectedValue;

                    var dataSet = db.YasaiKensa;
                    var q = dataSet.AsQueryable();
                    if (prefFilterList.SelectedIndex > 0)
                    {
                        q = q.Where(s => s.産地都道府県 == (string)prefFilterList.SelectedValue);
                        if (cityFilterList.SelectedIndex > 0)
                        {
                            q = q.Where(s => s.産地市町村 == (string)cityFilterList.SelectedValue);
                        }
                    }

                    var category = (string)categoryFilterList.SelectedValue;
                    if (category == "野菜類")
                    {
                        var product = q
                            .Where(x => x.食品カテゴリ == category)
                            .GroupBy(x => x.野菜品名)
                            .OrderByDescending(x => x.Count())
                            .Select(x => new ListItem(String.Format("{0}[{1}]", x.Key, x.Count()), x.Key))
                            .ToList();
                        product.Insert(0, new ListItem("全て", ""));
                        productFilterList.DataSource = product;
                        productFilterList.DataBind();
                        if (product.Any(x => x.Value == currentValue))
                        {
                            productFilterList.SelectedValue = currentValue;
                        }
                        else
                        {
                            productFilterList.SelectedIndex = 0;
                        }
                    }
                    else
                    {
                        var product = q
                            .Where(x => x.食品カテゴリ == category)
                            .GroupBy(x => x.品目)
                            .OrderByDescending(x => x.Count())
                            .Select(x => new ListItem(String.Format("{0}[{1}]", x.Key, x.Count()), x.Key))
                            .ToList();
                        product.Insert(0, new ListItem("全て", ""));
                        productFilterList.DataSource = product;
                        productFilterList.DataBind();
                        if (product.Any(x => x.Value == currentValue))
                        {
                            productFilterList.SelectedValue = currentValue;
                        }
                        else
                        {
                            productFilterList.SelectedIndex = 0;
                        }
                    }
                }
            }
        }

        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            UpdateQueryResult();
        }
    }
}
