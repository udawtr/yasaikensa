using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebRole1.admin
{
    public partial class srdetail : System.Web.UI.Page
    {
        protected ShippingRestriction SR;
        protected List<ShippingRestrictedProduct> SRProducts;
        protected List<ShippingRestrictedCity> SRCities;

        protected void Page_Load(object sender, EventArgs e)
        {
            var code = Request["code"];

            using (var db = new DataClasses1DataContext())
            {
                SR = db.ShippingRestriction.Single(x => x.Code == code);
                SRProducts = db.ShippingRestrictedProduct.Where(x => x.ShippingRestrictionCode == code).ToList();
                SRCities = db.ShippingRestrictedCity.Where(x => x.ShippingRestrictionCode == code).ToList();
            }
        }
    }
}