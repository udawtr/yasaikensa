using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebRole1
{
    public partial class map : System.Web.UI.Page
    {
        protected string MapDataURL;

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("default.aspx");


            UpdateMapDataURL();
        }

        private void UpdateMapDataURL()
        {
            MapDataURL = String.Format("MapDataHandler.ashx?d={0}&v={1}", dateFilter.SelectedValue, valueFilter.SelectedValue);
        }

        protected void dateFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            UpdateMapDataURL();
        }

        protected void valueFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            UpdateMapDataURL();
        }
    }
}