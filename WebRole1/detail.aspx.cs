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
    public partial class detail : System.Web.UI.Page
    {
        protected IList<YasaiKensa> list;
        protected YasaiKensa data;

        protected void Page_Load(object sender, EventArgs e)
        {
            int no = 0;
            data = null;
            list = new List<YasaiKensa>();
            if (Int32.TryParse(Request["no"], out no))
            {
                using (var db = new DataClasses1DataContext())
                {
                    var dlo = new System.Data.Linq.DataLoadOptions();
                    dlo.LoadWith<YasaiKensa>(x => x.Place);
                    db.ObjectTrackingEnabled = false;
                    db.LoadOptions = dlo;
                    data = db.YasaiKensa.SingleOrDefault(x => x.No == no);
                    if (data != null)
                    {
                        list = db.YasaiKensa.Where(x => x.産地都道府県 == data.産地都道府県 && x.産地市町村 == data.産地市町村 && x.食品カテゴリ == data.食品カテゴリ && x.品目 == data.品目).ToList();
                    }

                    bqByDayImage.ImageUrl = "DetailChartImage.ashx?no="+no.ToString();
                }
            }
        }

        protected string GetURL()
        {
            if (data != null)
            {
                using (var db = new DataClasses1DataContext())
                {
                    var inspector = db.Inspector.SingleOrDefault(x => x.Name == data.検査機関);
                    if (inspector != null)
                    {
                        return inspector.URL;
                    }
                }
            }
            return null;
        }

        protected void DeleteButton_Click(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
            {
                int no;
                if (Int32.TryParse(Request["no"], out no))
                {
                    using (var db = new DataClasses1DataContext())
                    {
                        var item = db.YasaiKensa.Single(x => x.No == no);
                        db.YasaiKensa.DeleteOnSubmit(item);
                        db.SubmitChanges();
                    }
                }
            }
        }
    }
}