using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebRole1.admin
{
    public partial class srlist : System.Web.UI.Page
    {
        protected List<ShippingRestriction> SRList;
        protected List<ShippingRestrictedProduct> SRProducts;
        protected List<ShippingRestrictedCity> SRCities;

        protected void Page_Load(object sender, EventArgs e)
        {
            using (var db = new DataClasses1DataContext())
            {
                SRList =  db.ShippingRestriction.ToList();
                SRProducts=  db.ShippingRestrictedProduct.ToList();
                SRCities = db.ShippingRestrictedCity.ToList();
            }
        }
    }
}