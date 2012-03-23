using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebRole1.admin
{
    public partial class srnew : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Create_Click(object sender, EventArgs e)
        {
            using (var db = new DataClasses1DataContext())
            {

                ShippingRestriction rest = new ShippingRestriction();
                rest.Code = Code.Text;
                rest.Caption = Caption.Text;
                rest.Comment = Comment.Text;
                rest.CityFilterMode = Convert.ToInt32(CityFilterMode.SelectedValue);
                rest.ProductFilterMode = Convert.ToInt32(ProductFilterMode.SelectedValue);
                rest.PrefName = PrefName.Text;
                DateTime dt;
                if (DateTime.TryParse(BeginDate.Text, out dt))
                {
                    rest.BeginDate = dt;
                }
                if (DateTime.TryParse(EndDate.Text, out dt))
                {
                    rest.EndDate = dt;
                }

                var products = new List<ShippingRestrictedProduct>();
                foreach (var item in Products.Text.Split(new char[] { ' ', '\t', ',', '、' }).Select(x => x.Trim()))
                {
                    products.Add(new ShippingRestrictedProduct() { ProductName = item, ShippingRestrictionCode = rest.Code });
                }

                var cities = new List<ShippingRestrictedCity>();
                foreach (var item in Cities.Text.Split(new char[] { ' ', '\t', ',', '、' }).Select(x => x.Trim()))
                {
                    cities.Add(new ShippingRestrictedCity() { CityName = item, ShippingRestrictionCode = rest.Code });
                }

                db.ShippingRestriction.InsertOnSubmit(rest);
                db.ShippingRestrictedProduct.InsertAllOnSubmit(products);
                db.ShippingRestrictedCity.InsertAllOnSubmit(cities);

                db.SubmitChanges();

                ClientScript.RegisterStartupScript(typeof(String), "msg", "alert('追加しました。')", true);
            }
        }
    }
}