using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebRole1
{
    public partial class special : System.Web.UI.Page
    {
        protected List<ShippingRestriction> RestrictList;

        protected void Page_Load(object sender, EventArgs e)
        {
            using (var db = new DataClasses1DataContext())
            {
                db.ObjectTrackingEnabled = false;
                RestrictList = db.ShippingRestriction.ToList();
            }
        }
    }
}