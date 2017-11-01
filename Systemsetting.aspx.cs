using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
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
            if (ds.Tables[1].Rows.Count > 0)
            {
                HIDTxtCGSTAccount.Value = ds.Tables[1].Rows[0]["cValue"] != DBNull.Value ? ds.Tables[1].Rows[0]["cValue"].ToString() : "";
                TxtCGSTAccount.Text = ds.Tables[1].Rows[0]["cName"] != DBNull.Value ? ds.Tables[1].Rows[0]["cName"].ToString() : "";
            }
            if (ds.Tables[2].Rows.Count > 0)
            {
                HIDTxtSGSTAccount.Value = ds.Tables[2].Rows[0]["cValue"] != DBNull.Value ? ds.Tables[2].Rows[0]["cValue"].ToString() : "";
                TxtSGSTAccount.Text = ds.Tables[2].Rows[0]["cName"] != DBNull.Value ? ds.Tables[2].Rows[0]["cName"].ToString() : "";
            }
            if (ds.Tables[3].Rows.Count > 0)
            {
                HIDTxtIGSTAccount.Value = ds.Tables[3].Rows[0]["cValue"] != DBNull.Value ? ds.Tables[3].Rows[0]["cValue"].ToString() : "";
                TxtIGSTAccount.Text = ds.Tables[3].Rows[0]["cName"] != DBNull.Value ? ds.Tables[3].Rows[0]["cName"].ToString() : "";
            }
            if (ds.Tables[4].Rows.Count > 0)
            {
                HIDTxtCashAccount.Value = ds.Tables[4].Rows[0]["cValue"] != DBNull.Value ? ds.Tables[4].Rows[0]["cValue"].ToString() : "";
                TxtCashAccount.Text = ds.Tables[4].Rows[0]["cName"] != DBNull.Value ? ds.Tables[4].Rows[0]["cName"].ToString() : "";
            }
            if (ds.Tables[5].Rows.Count > 0)
            {
                HIDRoundoffAccount.Value = ds.Tables[5].Rows[0]["cValue"] != DBNull.Value ? ds.Tables[5].Rows[0]["cValue"].ToString() : "";
                TxtRoundOffAccount.Text = ds.Tables[5].Rows[0]["cName"] != DBNull.Value ? ds.Tables[5].Rows[0]["cName"].ToString() : "";
            }

        }
    }
    protected void btnsave_Click(object sender, EventArgs e)
    {
        try
        {
            ds = cn.RunSql("sp_addsystemsetting '" + Txtstatecode.Text + "','" + HIDTxtCGSTAccount.Value + "','" + HIDTxtSGSTAccount.Value + "','" + HIDTxtIGSTAccount.Value + "','" + HIDTxtCashAccount.Value + "','"+ HIDRoundoffAccount.Value +"','" + Request.Cookies["CompID"].Value + "'", "select");
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

    [System.Web.Script.Services.ScriptMethod()]
    [System.Web.Services.WebMethod]
    public static List<string> SearchGSTAccount(string prefixText, int count)
    {
        DataSet ds = new DataSet();
        SqlInvoice cn = new SqlInvoice();
        List<string> zone = new List<string>();
        string cnm = "";
        ds = cn.RunSql("sp_Searchforautocomplete 'GST','" + prefixText + "','" + HttpContext.Current.Request.Cookies["CompID"].Value + "'", "select");
        if (ds.Tables[0].Rows.Count > 0)
        {
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                cnm = AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(ds.Tables[0].Rows[i]["cName"].ToString(), ds.Tables[0].Rows[i]["nid"].ToString());
                zone.Add(cnm);
            }
        }

        return zone;
    }

    [System.Web.Script.Services.ScriptMethod()]
    [System.Web.Services.WebMethod]
    public static List<string> SearchCashAccount(string prefixText, int count)
    {
        DataSet ds = new DataSet();
        SqlInvoice cn = new SqlInvoice();
        List<string> zone = new List<string>();
        string cnm = "";
        ds = cn.RunSql("sp_Searchforautocomplete 'Cash','" + prefixText + "','" + HttpContext.Current.Request.Cookies["CompID"].Value + "'", "select");
        if (ds.Tables[0].Rows.Count > 0)
        {
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                cnm = AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(ds.Tables[0].Rows[i]["cName"].ToString(), ds.Tables[0].Rows[i]["nid"].ToString());
                zone.Add(cnm);
            }
        }

        return zone;
    }
}