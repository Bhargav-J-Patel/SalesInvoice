using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using App_Code;

public partial class MasterItem : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    SqlInvoice cn = new SqlInvoice();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (IsPostBack == false)
            {
                if (Request.QueryString["id"] != null)
                {
                    ds = cn.RunSql("sp_listItem 's','','" + Request.QueryString["id"] + "'", "search");

                    TxtItemGroupName.Text = ds.Tables[0].Rows[0]["cItemGroupName"] != DBNull.Value ? ds.Tables[0].Rows[0]["cItemGroupName"].ToString() : "";
                    HifItemGroup.Value = ds.Tables[0].Rows[0]["cItemGroup"] != DBNull.Value ? ds.Tables[0].Rows[0]["cItemGroup"].ToString() : "";
                    TxtItemName.Text = ds.Tables[0].Rows[0]["cItem"] != DBNull.Value ? ds.Tables[0].Rows[0]["cItem"].ToString() : "";
                    TxtDescription.Text = ds.Tables[0].Rows[0]["cDescription"] != DBNull.Value ? ds.Tables[0].Rows[0]["cDescription"].ToString() : "";
                    TxtSize.Text = ds.Tables[0].Rows[0]["nSize"] != DBNull.Value ? ds.Tables[0].Rows[0]["nSize"].ToString() : "";
                    TxtPurRate.Text = ds.Tables[0].Rows[0]["nPuRate"] != DBNull.Value ? ds.Tables[0].Rows[0]["nPuRate"].ToString() : "";
                    TxtSaleRate.Text = ds.Tables[0].Rows[0]["nSaleRate"] != DBNull.Value ? ds.Tables[0].Rows[0]["nSaleRate"].ToString() : "";
                    TxtMarginPer.Text = ds.Tables[0].Rows[0]["nMarginPer"] != DBNull.Value ? ds.Tables[0].Rows[0]["nMarginPer"].ToString() : "";
                    TxtMarginRs.Text = ds.Tables[0].Rows[0]["nMarginRs"] != DBNull.Value ? ds.Tables[0].Rows[0]["nMarginRs"].ToString() : "";
                    TxtDiscPer.Text = ds.Tables[0].Rows[0]["nDiscPer"] != DBNull.Value ? ds.Tables[0].Rows[0]["nDiscPer"].ToString() : "";
                    TxtDiscRS.Text = ds.Tables[0].Rows[0]["nDiscRs"] != DBNull.Value ? ds.Tables[0].Rows[0]["nDiscRs"].ToString() : "";
                    TxtHSNCode.Text = ds.Tables[0].Rows[0]["cHSNCode"] != DBNull.Value ? ds.Tables[0].Rows[0]["cHSNCode"].ToString() : "";
                    TxtMrp.Text  = ds.Tables[0].Rows[0]["nMRP"] != DBNull.Value ? ds.Tables[0].Rows[0]["nMRP"].ToString() : "0";
                    TxtOpeningQty.Text = ds.Tables[0].Rows[0]["nOpeningQty"] != DBNull.Value ? ds.Tables[0].Rows[0]["nOpeningQty"].ToString() : "0";
                    TxtcBrand.Text = ds.Tables[0].Rows[0]["cBrand"] != DBNull.Value ? ds.Tables[0].Rows[0]["cBrand"].ToString() : "";

                    if (Request.QueryString["D"] == "1")
                    {
                        ddldelete.Visible = true;
                        btnsave.Text = "Delete";
                    }

                }
            }
        }
        catch (Exception ex)
        {
            //lblerror.Text = ex.Message;
            //diverror.Visible = true;
        }
        finally
        {
            ds.Dispose();
        }
    }
    protected void btnsave_Click(object sender, EventArgs e)
    {
        try
        {
            TxtMrp.Text = TxtMrp.Text == "" ? "0" : TxtMrp.Text;
            if (Request.QueryString["id"] != null)
            {
                if (Request.QueryString["E"] == "1")
                {
                    ds = cn.RunSql("sp_additem 'U','" + HifItemGroup.Value + "','" + TxtItemName.Text + "','" + TxtHSNCode.Text + "','" + TxtDescription.Text + "','" + TxtSize.Text + "','" + TxtPurRate.Text + "','" + TxtSaleRate.Text + "','" + TxtMarginPer.Text + "','" + TxtMarginRs.Text + "','" + TxtDiscPer.Text + "','" + TxtDiscRS.Text + "','" + Request.Cookies["CompID"].Value + "','" + Request.QueryString["id"] + "','" + TxtMrp.Text + "','" + TxtOpeningQty.Text + "','"+ TxtcBrand.Text + "'", "insert");
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "ScuessMsg('U')", true);

                }
                if (Request.QueryString["D"] == "1")
                {
                    if (ddldelete.SelectedValue == "Yes")
                    {
                        ds = cn.RunSql("sp_additem 'D','" + HifItemGroup.Value + "','" + TxtItemName.Text + "','" + TxtHSNCode.Text + "','" + TxtDescription.Text + "','" + TxtSize.Text + "','" + TxtPurRate.Text + "','" + TxtSaleRate.Text + "','" + TxtMarginPer.Text + "','" + TxtMarginRs.Text + "','" + TxtDiscPer.Text + "','" + TxtDiscRS.Text + "','" + Request.Cookies["CompID"].Value + "','" + Request.QueryString["id"] + "','" + TxtMrp.Text + "','" + TxtOpeningQty.Text + "','" + TxtcBrand.Text + "'", "insert");
                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "ScuessMsg('D')", true);
                    }
                }

            }
            else
            {
                ds = cn.RunSql("sp_additem 'I','" + HifItemGroup.Value + "','" + TxtItemName.Text + "','" + TxtHSNCode.Text + "','" + TxtDescription.Text + "','" + TxtSize.Text + "','" + TxtPurRate.Text + "','" + TxtSaleRate.Text + "','" + TxtMarginPer.Text + "','" + TxtMarginRs.Text + "','" + TxtDiscPer.Text + "','" + TxtDiscRS.Text + "','" + Request.Cookies["CompID"].Value + "','','" + TxtMrp.Text + "','" + TxtOpeningQty.Text + "','" + TxtcBrand.Text + "'", "insert");
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "ScuessMsg('I')", true);

            }
        }
        catch (Exception ex)
        {

        }
    }
    protected void btncancel_Click(object sender, EventArgs e)
    {

    }
    [System.Web.Script.Services.ScriptMethod()]
    [System.Web.Services.WebMethod]
    public static List<string> SearchItemGroup(string prefixText, int count)
    {
        DataSet ds = new DataSet();
        SqlInvoice cn = new SqlInvoice();
        List<string> zone = new List<string>();
        string cnm = "";
        ds = cn.RunSql("sp_Searchforautocomplete 'I','" + prefixText + "','" + HttpContext.Current.Request.Cookies["CompID"].Value + "'", "select");
        if (ds.Tables[0].Rows.Count > 0)
        {
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                cnm = AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(ds.Tables[0].Rows[i]["cItemGroupName"].ToString(), ds.Tables[0].Rows[i]["nid"].ToString());
                zone.Add(cnm);
            }
        }

        return zone;
    }

    protected void TxtItemGroupName_TextChanged(object sender, EventArgs e)
    {
        try
        {
            ds = cn.RunSql("sp_gethsn '"+ HifItemGroup.Value +"'", "select");
            TxtHSNCode.Text = ds.Tables[0].Rows[0]["cHSNCode"] != DBNull.Value ? ds.Tables[0].Rows[0]["cHSNCode"].ToString() : "";
        }
        catch(Exception ex)
        {

        }
    }
}