using System;
using System.Web.UI;
using System.Data;
using App_Code;

public partial class Systemsetting : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    SqlInvoice cn = new SqlInvoice();


    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack == false)
        {
            ds = cn.RunSql("sp_searchsystemsetting '"+ Request.Cookies["CompID"].Value +"'", "select");
            if (ds.Tables[0].Rows.Count > 0)
            {

                Txtstatecode.Text = ds.Tables[0].Rows[0]["cValue"] != DBNull.Value ? ds.Tables[0].Rows[0]["cValue"].ToString() : "";
            }
        }
    }
    protected void btnsave_Click(object sender, EventArgs e)
    {
        try
        {
            ds = cn.RunSql("sp_addsystemsetting '" + Txtstatecode.Text + "','" + Request.Cookies["CompID"].Value + "'", "select");
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "ScuessMsg('U')", true);

        }
        catch (Exception ex)
        {

        }
    }
    protected void btncancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("Systemsetting.aspx");
    }
}