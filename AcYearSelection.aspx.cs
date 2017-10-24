using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using App_Code;
using System.Data;

public partial class AcYearSelection : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    SqlInvoice cn = new SqlInvoice();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack == false)
        {
            ds = cn.RunSql("sp_getbranch '" + Request.Cookies["CompID"].Value + "'", "select");
            DDLBranch.DataSource = ds;
            DDLBranch.DataBind();
        }
    }
    protected void BtnSave_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Cookies["BranchID"].Value = DDLBranch.SelectedValue;
            Response.Cookies["AccYear"].Value = DDLYear.SelectedValue;
            Response.Redirect("Home.aspx");
        }
        catch (Exception ex)
        {

        }
    }
}
