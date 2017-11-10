using System;

public partial class BillMaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
            LblCompanyNm.Text = Request.Cookies["CompName"].Value;
        
    }
}
