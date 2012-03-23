using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebRole1
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Page.User.Identity.IsAuthenticated)
            {
                //NavigationMenu.Items.Add(new MenuItem
                //{
                //    NavigateUrl = "~/Edit.aspx",
                //    Text = "データ編集"
                //});
                //NavigationMenu.Items.Add(new MenuItem
                //{
                //    NavigateUrl = "~/Add.aspx",
                //    Text = "データ登録"
                //});
                NavigationMenu.Items.Add(new MenuItem { 
                    NavigateUrl="~/admin/upload.aspx",
                    Text = "アップロード"
                });
            }
        }
    }
}
