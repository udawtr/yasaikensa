using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebRole1.admin
{
    public partial class normalize_datetime : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            using (var db = new DataClasses1DataContext())
            {
                while (true)
                {
                    var list = db.YasaiKensa.Where(x => !x.公表日D.HasValue).OrderByDescending(x=>x.No).Take(100);
                    if (list.Count() == 0) break;
                    foreach (var item in list)
                    {
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
                    }
                    db.SubmitChanges();
                }
            }
        }
    }
}