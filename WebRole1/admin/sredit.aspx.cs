using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebRole1.admin
{
    public partial class sredit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack == false)
            {
                var code = Request["code"];
                using (var db = new DataClasses1DataContext())
                {
                    db.ObjectTrackingEnabled = false;

                    PrefName.Items.AddRange(db.PrefCode.Select(x=>new ListItem(x.Name)).ToArray());

                    if (code != "new")
                    {
                        var Model = db.ShippingRestriction.FirstOrDefault(x => x.Code == code);
                        if (Model == null)
                        {
                            Response.Redirect("/");
                        }

                        var products = db.ShippingRestrictedProduct.Where(x => x.ShippingRestrictionCode == code);
                        var cities = db.ShippingRestrictedCity.Where(x => x.ShippingRestrictionCode == code);

                        Code.Text = Model.Code;
                        Caption.Text = Model.Caption;
                        PrefName.Text = Model.PrefName;
                        CityFilterMode.SelectedValue = Convert.ToString(Model.CityFilterMode);
                        ProductFilterMode.SelectedValue = Convert.ToString(Model.ProductFilterMode);
                        BeginDate.Text = Model.BeginDate.HasValue ? Model.BeginDate.Value.ToShortDateString() : "-";
                        EndDate.Text = Model.EndDate.HasValue ? Model.EndDate.Value.ToShortDateString() : "-";
                        Comment.Text = Model.Comment;
                        Products.Text = String.Join(",", products.Select(x => x.ProductName).ToArray());
                        Cities.Text = String.Join(",", cities.Select(x => x.CityName).ToArray());

                        Insert.Visible = false;
                    }
                    else
                    {
                        Code.Text = "新しいコードを入力してください";
                        Code.ReadOnly = false;
                        Code.Enabled = true;
                        Update.Visible = false;
                    }
                }
            }
        }

        protected void Update_Click(object sender, EventArgs e)
        {
            var code = Code.Text;

            using (var db = new DataClasses1DataContext())
            {
                var Model = db.ShippingRestriction.FirstOrDefault(x => x.Code == code);
                if (Model == null)
                {
                    Response.Redirect("/");
                }
                var products_now = db.ShippingRestrictedProduct.Where(x => x.ShippingRestrictionCode == code).ToList();
                var cities_now = db.ShippingRestrictedCity.Where(x => x.ShippingRestrictionCode == code).ToList();

                Model.Caption = Caption.Text.Trim();
                Model.PrefName = PrefName.Text.Trim();
                Model.CityFilterMode = Convert.ToInt32(CityFilterMode.Text);
                Model.ProductFilterMode = Convert.ToInt32(ProductFilterMode.Text);
                Model.Comment = Comment.Text.Trim();
                
                DateTime dt;
                if (DateTime.TryParse(BeginDate.Text, out dt))
                {
                    Model.BeginDate = dt;
                }
                else
                {
                    Model.BeginDate = null;
                }
                if (DateTime.TryParse(EndDate.Text, out dt))
                {
                    Model.EndDate = dt;
                }
                else
                {
                    Model.EndDate = null;
                }

                var products_edit = Products.Text.Split(new char[] { ',' }).Select(x => x.Trim()).ToArray();
                var cities_edit = Cities.Text.Split(new char[] { ',' }).Select(x => x.Trim()).ToArray();
                foreach (var item in products_edit)
                {
                    //Insert
                    if (products_now.All(x => x.ProductName != item))
                    {
                        db.ShippingRestrictedProduct.InsertOnSubmit(new ShippingRestrictedProduct() { 
                            ProductName = item,
                            ShippingRestrictionCode = code
                        });
                    }
                }
                foreach (var item in products_now)
                {
                    //Remove
                    if (products_edit.All(x => x != item.ProductName))
                    {
                        db.ShippingRestrictedProduct.DeleteOnSubmit(item);
                    }
                }

                foreach (var item in cities_edit)
                {
                    //Insert
                    if (cities_now.All(x => x.CityName != item))
                    {
                        db.ShippingRestrictedCity.InsertOnSubmit(new ShippingRestrictedCity()
                        {
                            CityName = item,
                            ShippingRestrictionCode = code
                        });
                    }
                }
                foreach (var item in cities_now)
                {
                    //Remove
                    if (cities_edit.All(x => x != item.CityName))
                    {
                        db.ShippingRestrictedCity.DeleteOnSubmit(item);
                    }
                }

                db.SubmitChanges();

                Response.Redirect("srdetail.aspx?code=" + code);
            }
        }

        protected void Insert_Click(object sender, EventArgs e)
        {
            var code = Code.Text;

            using (var db = new DataClasses1DataContext())
            {
                var Model = db.ShippingRestriction.FirstOrDefault(x => x.Code == code);
                if (Model != null)
                {
                    ClientScript.RegisterClientScriptBlock(typeof(String), "msg", "alert('すでに使用されているコードが指定されました')", true);
                    return;
                }

                Model = new ShippingRestriction();
                Model.Code = code;
                Model.Caption = Caption.Text.Trim();
                Model.PrefName = PrefName.Text.Trim();
                Model.CityFilterMode = Convert.ToInt32(CityFilterMode.Text);
                Model.ProductFilterMode = Convert.ToInt32(ProductFilterMode.Text);
                Model.Comment = Comment.Text.Trim();

                DateTime dt;
                if (DateTime.TryParse(BeginDate.Text, out dt))
                {
                    Model.BeginDate = dt;
                }
                else
                {
                    Model.BeginDate = null;
                }
                if (DateTime.TryParse(EndDate.Text, out dt))
                {
                    Model.EndDate = dt;
                }
                else
                {
                    Model.EndDate = null;
                }

                var products_edit = Products.Text.Split(new char[] { ',' }).Select(x => x.Trim()).ToArray();
                var cities_edit = Cities.Text.Split(new char[] { ',' }).Select(x => x.Trim()).ToArray();
                foreach (var item in products_edit)
                {
                    db.ShippingRestrictedProduct.InsertOnSubmit(new ShippingRestrictedProduct()
                    {
                        ProductName = item,
                        ShippingRestrictionCode = code
                    });
                }
                foreach (var item in cities_edit)
                {
                    db.ShippingRestrictedCity.InsertOnSubmit(new ShippingRestrictedCity()
                    {
                        CityName = item,
                        ShippingRestrictionCode = code
                    });
                }

                db.ShippingRestriction.InsertOnSubmit(Model);
                db.SubmitChanges();

                Response.Redirect("srdetail.aspx?code=" + code);
            }
        }

        protected void PrefName_SelectedIndexChanged(object sender, EventArgs e)
        {
            using (var db = new DataClasses1DataContext())
            {
                var tmp = db.YasaiKensa.Where(x => x.産地都道府県 == PrefName.SelectedValue).Select(x => x.産地市町村).Distinct().ToArray();
                if (tmp.Length > 0)
                {
                    PrefNameTips.Text = "市町村名候補:" + String.Join(",", tmp);
                    PrefNameTips.Visible = true;
                }
                else
                {
                    PrefNameTips.Visible = false;
                }
            }
        }

        protected void CityFilterMode_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (CityFilterMode.SelectedValue == "0")
            {
                Cities.Enabled = false;
            }
            else
            {
                Cities.Enabled = true;
            }
        }

        protected void ProductFilterMode_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ProductFilterMode.SelectedValue == "0")
            {
                Products.Enabled = false;
            }
            else
            {
                Products.Enabled = true;
            }

        }
    }
}