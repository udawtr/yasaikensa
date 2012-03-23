using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Linq;

namespace WebRole1.admin
{
    public partial class confirm : System.Web.UI.Page
    {
        protected List<Temp_YasaiKensa> list;

        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Page.IsPostBack == false)
            {
                using (var db = new DataClasses1DataContext())
                {
                    list = db.Temp_YasaiKensa.ToList();
                }
            }
        }

        protected void Publish_Click(object sender, EventArgs e)
        {
            using (var db = new DataClasses1DataContext())
            {
                db.ExecuteCommand("DELETE FROM YasaiKensa WHERE No IN (SELECT No FROM Temp_YasaiKensa);");
                db.ExecuteCommand("INSERT INTO YasaiKensa SELECT * FROM Temp_YasaiKensa;");
                db.ExecuteCommand("DELETE FROM Temp_YasaiKensa");
            }
            Response.Redirect("complete.aspx");
        }
    }
}