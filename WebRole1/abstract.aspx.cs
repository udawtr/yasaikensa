using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebRole1
{
    public partial class _abstract : System.Web.UI.Page
    {
        protected IList<YasaiKensa> list;
        protected IList<Category> categoryList;

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("default.aspx");

            using (var db = new DataClasses1DataContext())
            {
                string publish = publishDayFilter.SelectedValue;
                var res = Common.GetQuery("全て", "全て", "全て", "全て", publish, "全て", "1");
                list = res.Item1.ToList();
                categoryList = db.Category.OrderBy(x=>x.No).ToList();

                bqByDayImage.ImageUrl = "SearchChartImage.ashx?width=800&height=300&publish="+publish;
            }
        }

        protected void publishDayFilter_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}