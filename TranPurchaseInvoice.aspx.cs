using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using App_Code;

public partial class TranPurchaseInvoice : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    SqlInvoice cn = new SqlInvoice();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack == false)
        {
            try
            {

                ds = cn.RunSql("sp_getsrno '1','0','" + Request.Cookies["CompID"].Value + "','" + Request.Cookies["BranchID"].Value + "','" + Request.Cookies["AccYear"].Value + "'", "select");
                TxtSRNo.Text = ds.Tables[0].Rows[0]["srno"] != DBNull.Value ? ds.Tables[0].Rows[0]["srno"].ToString() : "";
                ds = cn.RunSql("sp_getaddlesspurchase '2'", "select");
                GvAddLess.DataSource = ds;
                GvAddLess.DataBind();
                if (Request.QueryString["id"] != null)
                {
                    ds = cn.RunSql("sp_listPurchase '" + Request.QueryString["id"] + "','" + Request.Cookies["CompID"].Value + "','" + Request.Cookies["BranchID"].Value + "','" + Request.Cookies["AccYear"].Value + "'", "select");
                    TxtSRNo.Text = ds.Tables[0].Rows[0]["nSrNo"] != DBNull.Value ? ds.Tables[0].Rows[0]["nSrNo"].ToString() : "";
                    TxtDate.Text = ds.Tables[0].Rows[0]["dDate"] != DBNull.Value ? ds.Tables[0].Rows[0]["dDate"].ToString() : "";
                    LblGrossRs.Text = ds.Tables[0].Rows[0]["nGrossRs"] != DBNull.Value ? ds.Tables[0].Rows[0]["nGrossRs"].ToString() : "";
                    TxtVatPer.Text = ds.Tables[0].Rows[0]["nVatPer"] != DBNull.Value ? ds.Tables[0].Rows[0]["nVatPer"].ToString() : "";

                    TxtVatRs.Text = ds.Tables[0].Rows[0]["nCGSTRs"] != DBNull.Value ? ds.Tables[0].Rows[0]["nCGSTRs"].ToString() : "";
                    TxtExtraPer.Text = ds.Tables[0].Rows[0]["nExtraPer"] != DBNull.Value ? ds.Tables[0].Rows[0]["nExtraPer"].ToString() : "";
                    TxtExtraRs.Text = ds.Tables[0].Rows[0]["nSGSTRs"] != DBNull.Value ? ds.Tables[0].Rows[0]["nSGSTRs"].ToString() : "";

                    TxtIGST.Text = ds.Tables[0].Rows[0]["nIGSTRs"] != DBNull.Value ? ds.Tables[0].Rows[0]["nIGSTRs"].ToString() : "";

                    TxtDisPer.Text = ds.Tables[0].Rows[0]["nDiscPer"] != DBNull.Value ? ds.Tables[0].Rows[0]["nDiscPer"].ToString() : "";
                    TxtDisRs.Text = ds.Tables[0].Rows[0]["nDiscRs"] != DBNull.Value ? ds.Tables[0].Rows[0]["nDiscRs"].ToString() : "";
                    LblNetRs.Text = ds.Tables[0].Rows[0]["nNetRs"] != DBNull.Value ? ds.Tables[0].Rows[0]["nNetRs"].ToString() : "";
                    LblAmt.Text = ds.Tables[0].Rows[0]["nAmt"] != DBNull.Value ? ds.Tables[0].Rows[0]["nAmt"].ToString() : "";
                    HifCustomer.Value = ds.Tables[0].Rows[0]["ccustomer"] != DBNull.Value ? ds.Tables[0].Rows[0]["ccustomer"].ToString() : "";
                    TxtCustomer.Text = ds.Tables[0].Rows[0]["cName"] != DBNull.Value ? ds.Tables[0].Rows[0]["cName"].ToString() : "";
                    LblTotalQty.Text = ds.Tables[2].Rows[0]["TotalQty"] != DBNull.Value ? ds.Tables[2].Rows[0]["TotalQty"].ToString() : "";
                    TxtTransporterID.Text = ds.Tables[0].Rows[0]["cTransporterID"] != DBNull.Value ? ds.Tables[0].Rows[0]["cTransporterID"].ToString() : "";
                    TxtTransporterName.Text = ds.Tables[0].Rows[0]["cTransporterName"] != DBNull.Value ? ds.Tables[0].Rows[0]["cTransporterName"].ToString() : "";
                    TxtVehicleNo.Text = ds.Tables[0].Rows[0]["cVehicleNo"] != DBNull.Value ? ds.Tables[0].Rows[0]["cVehicleNo"].ToString() : "";
                    DDLCashCredit.SelectedValue = ds.Tables[0].Rows[0]["nCashCredit"] != DBNull.Value ? Convert.ToBoolean(ds.Tables[0].Rows[0]["nCashCredit"]) == true ? "1" : "0" : "0";
                    LblRoundOff.Text = ds.Tables[0].Rows[0]["nRoundOff"] != DBNull.Value ? ds.Tables[0].Rows[0]["nRoundOff"].ToString() : "";

                    if (LblAmt.Text == "")
                    {
                        LblAmt.Text = ds.Tables[0].Rows[0]["nGrossRs"] != DBNull.Value ? ds.Tables[0].Rows[0]["nGrossRs"].ToString() : "";
                    }
                    GVItem.DataSource = ds.Tables[1];
                    GVItem.DataBind();
                    GvAddLess.DataSource = ds.Tables[4];
                    GvAddLess.DataBind();
                    if (Request.QueryString["cid"] != null)
                    {
                        ds = cn.RunSql("sp_listPurchase '" + Request.QueryString["id"] + "','" + Request.Cookies["CompID"].Value + "','" + Request.Cookies["BranchID"].Value + "','" + Request.Cookies["AccYear"].Value + "','" + Request.QueryString["cid"] + "'", "select");
                        TxtItemGroupName.Text = ds.Tables[3].Rows[0]["cItemGroupName"] != DBNull.Value ? ds.Tables[3].Rows[0]["cItemGroupName"].ToString() : "";
                        TxtItemName.Text = ds.Tables[3].Rows[0]["cItem"] != DBNull.Value ? ds.Tables[3].Rows[0]["cItem"].ToString() : "";
                        HifItemGroup.Value = ds.Tables[3].Rows[0]["itemgrpid"] != DBNull.Value ? ds.Tables[3].Rows[0]["itemgrpid"].ToString() : "";
                        HifItem.Value = ds.Tables[3].Rows[0]["itemid"] != DBNull.Value ? ds.Tables[3].Rows[0]["itemid"].ToString() : "";
                        TxtDescription.Text = ds.Tables[3].Rows[0]["cDescription"] != DBNull.Value ? ds.Tables[3].Rows[0]["cDescription"].ToString() : "";
                        TxtSize.Text = ds.Tables[3].Rows[0]["nSize"] != DBNull.Value ? ds.Tables[3].Rows[0]["nSize"].ToString() : "";
                        TxtMRP.Text = ds.Tables[3].Rows[0]["nSaleRate"] != DBNull.Value ? ds.Tables[3].Rows[0]["nSaleRate"].ToString() : "";
                        txtDiscPerChild.Text = ds.Tables[3].Rows[0]["nDisPer"] != DBNull.Value ? ds.Tables[3].Rows[0]["nDisPer"].ToString() : "";
                        TxtDisRsChild.Text = ds.Tables[3].Rows[0]["nDisRs"] != DBNull.Value ? ds.Tables[3].Rows[0]["nDisRs"].ToString() : "";
                        TxtQty.Text = ds.Tables[3].Rows[0]["nqty"] != DBNull.Value ? ds.Tables[3].Rows[0]["nqty"].ToString() : "";
                        TxtPurchaseRate.Text = ds.Tables[3].Rows[0]["nPurchaseRate"] != DBNull.Value ? ds.Tables[3].Rows[0]["nPurchaseRate"].ToString() : "";
                        LblTotal.Text = ds.Tables[3].Rows[0]["nTotal"] != DBNull.Value ? ds.Tables[3].Rows[0]["nTotal"].ToString() : "";
                    }
                    if (Request.QueryString["D"] != null)
                    {
                        ddldelete.Visible = true;
                        btnsave.Text = "Delete";
                    }

                    TxtItemName.Focus();


                }
            }
            catch (Exception ex)
            {

            }
        }
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
    [System.Web.Script.Services.ScriptMethod()]
    [System.Web.Services.WebMethod]
    public static List<string> SearchItem(string prefixText, int count)
    {
        DataSet ds = new DataSet();
        SqlInvoice cn = new SqlInvoice();
        List<string> zone = new List<string>();
        string cnm = "";
        ds = cn.RunSql("sp_Searchforautocomplete 'Item','" + prefixText + "','" + HttpContext.Current.Request.Cookies["CompID"].Value + "','" + HttpContext.Current.Session["itrmgroupid"] + "'", "select");
        if (ds.Tables[0].Rows.Count > 0)
        {
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                cnm = AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(ds.Tables[0].Rows[i]["cItem"].ToString(), ds.Tables[0].Rows[i]["nid"].ToString());
                zone.Add(cnm);
            }
        }

        return zone;
    }
    [System.Web.Script.Services.ScriptMethod()]
    [System.Web.Services.WebMethod]
    public static List<string> SearchCustomer(string prefixText, int count)
    {
        DataSet ds = new DataSet();
        SqlInvoice cn = new SqlInvoice();
        List<string> zone = new List<string>();
        string cnm = "";
        ds = cn.RunSql("sp_Searchforautocomplete 'Supllier','" + prefixText + "','" + HttpContext.Current.Request.Cookies["CompID"].Value + "',''", "select");
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
    protected void TxtItemName_TextChanged(object sender, EventArgs e)
    {
        try
        {
            ds = cn.RunSql("sp_selectitem '" + HifItem.Value + "',''", "select");
            TxtDescription.Text = ds.Tables[0].Rows[0]["cDescription"] != DBNull.Value ? ds.Tables[0].Rows[0]["cDescription"].ToString() : "";
            TxtSize.Text = ds.Tables[0].Rows[0]["nSize"] != DBNull.Value ? ds.Tables[0].Rows[0]["nSize"].ToString() : "";
            TxtMRP.Text = ds.Tables[0].Rows[0]["nSaleRate"] != DBNull.Value ? ds.Tables[0].Rows[0]["nSaleRate"].ToString() : "";
            TxtPurchaseRate.Text = ds.Tables[0].Rows[0]["nPuRate"] != DBNull.Value ? ds.Tables[0].Rows[0]["nPuRate"].ToString() : "";
            TxtItemGroupName.Text = ds.Tables[0].Rows[0]["cItemGroupName"] != DBNull.Value ? ds.Tables[0].Rows[0]["cItemGroupName"].ToString() : "";
            HifItemGroup.Value = ds.Tables[0].Rows[0]["ignid"] != DBNull.Value ? ds.Tables[0].Rows[0]["ignid"].ToString() : "";
            TxtPurchaseRate.Focus();
        }
        catch (Exception ex)
        {

        }
    }
    protected void TxtQty_TextChanged(object sender, EventArgs e)
    {
        try
        {
            TxtQty.Text = TxtQty.Text == "" ? "0" : TxtQty.Text;
            TxtPurchaseRate.Text = TxtPurchaseRate.Text == "" ? "0" : TxtPurchaseRate.Text;

            LblTotal.Text = (Convert.ToDecimal(TxtQty.Text) * Convert.ToDecimal(Convert.ToDecimal(TxtPurchaseRate.Text) - Convert.ToDecimal(TxtDisRsChild.Text == "" ? "0" : TxtDisRsChild.Text))).ToString("0.00");
            ImgBtnAdd.Focus();
        }
        catch (Exception ex)
        {

        }
    }
    protected void ImgBtnAdd_Click(object sender, ImageClickEventArgs e)
    {
        try
        {

            string str = "";
            for (int i = 0; i < GvAddLess.Rows.Count; i++)
            {
                str = str + (GvAddLess.Rows[i].FindControl("LblNID") as Label).Text + "¥" + (GvAddLess.Rows[i].FindControl("LblAddLess") as Label).Text + "¥" + (GvAddLess.Rows[i].FindControl("TxtAddLessPer") as TextBox).Text + "¥" + (GvAddLess.Rows[i].FindControl("TxtAddLessRs") as TextBox).Text + "¥";
            }


            if (Request.QueryString["id"] != null)
            {
                if (Request.QueryString["cid"] != null)
                {
                    ds = cn.RunSql("sp_addcPurchasetrans 'PUCU','0','" + TxtSRNo.Text + "','" + TxtDate.Text + "','" + HifCustomer.Value + "','" + HifItem.Value + "','" + TxtQty.Text + "','" + LblTotal.Text + "','" + LblGrossRs.Text + "','" + TxtVatPer.Text + "','" + TxtVatRs.Text + "','" + TxtExtraPer.Text + "','" + TxtExtraRs.Text + "','" + TxtDisPer.Text + "','" + TxtDisRs.Text + "','" + LblNetRs.Text + "','" + LblAmt.Text + "','" + Request.QueryString["id"] + "','" + Request.QueryString["cid"] + "','" + Request.Cookies["CompID"].Value + "','" + Request.Cookies["BranchID"].Value + "','" + Request.Cookies["AccYear"].Value + "','" + TxtTransporterID.Text + "','" + TxtTransporterName.Text + "','" + TxtVehicleNo.Text + "','" + TxtPurchaseRate.Text + "','" + txtDiscPerChild.Text + "','" + TxtDisRsChild.Text + "','" + TxtMRP.Text + "','" + DDLCashCredit.SelectedValue + "','" + str + "'", "puci");
                    Response.Redirect("TranPurchaseInvoice.aspx?id=" + ds.Tables[0].Rows[0][0] + "&E=1");
                }
                else
                {
                    ds = cn.RunSql("sp_addcPurchasetrans 'PUCI','0','" + TxtSRNo.Text + "','" + TxtDate.Text + "','" + HifCustomer.Value + "','" + HifItem.Value + "','" + TxtQty.Text + "','" + LblTotal.Text + "','" + LblGrossRs.Text + "','" + TxtVatPer.Text + "','" + TxtVatRs.Text + "','" + TxtExtraPer.Text + "','" + TxtExtraRs.Text + "','" + TxtDisPer.Text + "','" + TxtDisRs.Text + "','" + LblNetRs.Text + "','" + LblAmt.Text + "','" + Request.QueryString["id"] + "','','" + Request.Cookies["CompID"].Value + "','" + Request.Cookies["BranchID"].Value + "','" + Request.Cookies["AccYear"].Value + "','" + TxtTransporterID.Text + "','" + TxtTransporterName.Text + "','" + TxtVehicleNo.Text + "','" + TxtPurchaseRate.Text + "','" + txtDiscPerChild.Text + "','" + TxtDisRsChild.Text + "','" + TxtMRP.Text + "','" + DDLCashCredit.SelectedValue + "','" + str + "'", "puci");
                    Response.Redirect("TranPurchaseInvoice.aspx?id=" + ds.Tables[0].Rows[0][0] + "&E=1");
                }
            }
            else
            {
                ds = cn.RunSql("sp_addcPurchasetrans 'I','0','" + TxtSRNo.Text + "','" + TxtDate.Text + "','" + HifCustomer.Value + "','" + HifItem.Value + "','" + TxtQty.Text + "','" + LblTotal.Text + "','" + LblGrossRs.Text + "','" + TxtVatPer.Text + "','" + TxtVatRs.Text + "','" + TxtExtraPer.Text + "','" + TxtExtraRs.Text + "','" + TxtDisPer.Text + "','" + TxtDisRs.Text + "','" + LblNetRs.Text + "','" + LblAmt.Text + "','','','" + Request.Cookies["CompID"].Value + "','" + Request.Cookies["BranchID"].Value + "','" + Request.Cookies["AccYear"].Value + "','" + TxtTransporterID.Text + "','" + TxtTransporterName.Text + "','" + TxtVehicleNo.Text + "','" + TxtPurchaseRate.Text + "','" + txtDiscPerChild.Text + "','" + TxtDisRsChild.Text + "','" + TxtMRP.Text + "','" + DDLCashCredit.SelectedValue + "','" + str + "'", "puci");
                Response.Redirect("TranPurchaseInvoice.aspx?id=" + ds.Tables[0].Rows[0][0] + "&E=1");
            }
        }
        catch (Exception ex)
        {

        }
        finally
        {
            ds.Dispose();
        }
    }
    protected void ImgDelete1_Click(object sender, EventArgs e)
    {
        try
        {
            ImageButton imgbtn = (ImageButton)sender;
            GridViewRow row = (GridViewRow)imgbtn.NamingContainer;

            string cnid = "";
            string confirmval = "";
            confirmval = Request.Form["confirm_value"];

            string str = "";
            for (int i = 0; i < GvAddLess.Rows.Count; i++)
            {
                str = str + (GvAddLess.Rows[i].FindControl("LblNID") as Label).Text + "¥" + (GvAddLess.Rows[i].FindControl("LblAddLess") as Label).Text + "¥" + (GvAddLess.Rows[i].FindControl("TxtAddLessPer") as TextBox).Text + "¥" + (GvAddLess.Rows[i].FindControl("TxtAddLessRs") as TextBox).Text + "¥";
            }

            if (confirmval == "Yes")
            {
                cnid = GVItem.Rows[row.RowIndex].Cells[0].Text;
                ds = cn.RunSql("sp_addcPurchasetrans 'PUCD','0','" + TxtSRNo.Text + "','" + TxtDate.Text + "','" + HifCustomer.Value + "','" + HifItem.Value + "','" + TxtQty.Text + "','" + LblTotal.Text + "','" + LblGrossRs.Text + "','" + TxtVatPer.Text + "','" + TxtVatRs.Text + "','" + TxtExtraPer.Text + "','" + TxtExtraRs.Text + "','" + TxtDisPer.Text + "','" + TxtDisRs.Text + "','" + LblNetRs.Text + "','" + LblAmt.Text + "','" + Request.QueryString["id"] + "','" + cnid + "','" + Request.Cookies["CompID"].Value + "','" + Request.Cookies["BranchID"].Value + "','" + Request.Cookies["AccYear"].Value + "','" + TxtTransporterID.Text + "','" + TxtTransporterName.Text + "','" + TxtVehicleNo.Text + "','" + TxtPurchaseRate.Text + "','','','','" + DDLCashCredit.SelectedValue + "','" + str + "'", "puci");
                Response.Redirect("TranPurchaseInvoice.aspx?id=" + ds.Tables[0].Rows[0][0] + "");
            }
        }
        catch (Exception ex)
        {

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

            string str = "";
            for (int i = 0; i < GvAddLess.Rows.Count; i++)
            {
                str = str + (GvAddLess.Rows[i].FindControl("LblNID") as Label).Text + "¥" + (GvAddLess.Rows[i].FindControl("LblAddLess") as Label).Text + "¥" + (GvAddLess.Rows[i].FindControl("TxtAddLessPer") as TextBox).Text + "¥" + (GvAddLess.Rows[i].FindControl("TxtAddLessRs") as TextBox).Text + "¥";
            }

            if (Request.QueryString["D"] == "1")
            {
                if (ddldelete.SelectedValue == "Yes")
                {
                    ds = cn.RunSql("sp_addcPurchasetrans 'd','0','" + TxtSRNo.Text + "','" + TxtDate.Text + "','" + HifCustomer.Value + "','" + HifItem.Value + "','" + TxtQty.Text + "','" + LblTotal.Text + "','" + LblGrossRs.Text + "','" + TxtVatPer.Text + "','" + TxtVatRs.Text + "','" + TxtExtraPer.Text + "','" + TxtExtraRs.Text + "','" + TxtDisPer.Text + "','" + TxtDisRs.Text + "','" + LblNetRs.Text + "','" + LblAmt.Text + "','" + Request.QueryString["id"] + "','','" + Request.Cookies["CompID"].Value + "','" + Request.Cookies["BranchID"].Value + "','" + Request.Cookies["AccYear"].Value + "','" + TxtTransporterID.Text + "','" + TxtTransporterName.Text + "','" + TxtVehicleNo.Text + "','" + TxtPurchaseRate.Text + "','" + txtDiscPerChild.Text + "','" + TxtDisRsChild.Text + "','" + TxtMRP.Text + "','" + DDLCashCredit.SelectedValue + "','" + str + "'", "puci");
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "ScuessMsg('D','D')", true);
                    //Response.Redirect("TranPurchaseInvoice.aspx");
                }
            }
            else
            {

                ds = cn.RunSql("sp_addcPurchasetrans 'PU','0','" + TxtSRNo.Text + "','" + TxtDate.Text + "','" + HifCustomer.Value + "','" + HifItem.Value + "','" + TxtQty.Text + "','" + LblTotal.Text + "','" + LblGrossRs.Text + "','" + TxtVatPer.Text + "','" + TxtVatRs.Text + "','" + TxtExtraPer.Text + "','" + TxtExtraRs.Text + "','" + TxtDisPer.Text + "','" + TxtDisRs.Text + "','" + LblNetRs.Text + "','" + LblAmt.Text + "','" + Request.QueryString["id"] + "','','" + Request.Cookies["CompID"].Value + "','" + Request.Cookies["BranchID"].Value + "','" + Request.Cookies["AccYear"].Value + "','" + TxtTransporterID.Text + "','" + TxtTransporterName.Text + "','" + TxtVehicleNo.Text + "','" + TxtPurchaseRate.Text + "','" + txtDiscPerChild.Text + "','" + TxtDisRsChild.Text + "','" + TxtMRP.Text + "','" + DDLCashCredit.SelectedValue + "','" + str + "'", "puci");
                //Response.Redirect("TranPurchaseInvoice.aspx");
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "ScuessMsg('PU','" + Request.QueryString["ID"].ToString() + "')", true);
            }
        }
        catch (Exception ex)
        {

        }
        finally
        {
            ds.Dispose();
        }

    }
    protected void btncancel_Click(object sender, EventArgs e)
    {

    }
    protected void TxtVatPer_TextChanged(object sender, EventArgs e)
    {
        try
        {
            if (TxtExtraRs.Text == "")
            {
                TxtExtraRs.Text = "0";
            }
            if (TxtDisRs.Text == "")
            {
                TxtDisRs.Text = "0";
            }
            TxtVatRs.Text = Convert.ToString(Convert.ToDouble((Convert.ToDouble(LblGrossRs.Text) * Convert.ToDouble(TxtVatPer.Text) / 100)));
            LblAmt.Text = Convert.ToString(Convert.ToDouble(LblGrossRs.Text) + Convert.ToDouble(TxtVatRs.Text) + Convert.ToDouble(TxtExtraRs.Text));
            LblNetRs.Text = Convert.ToString(Convert.ToDouble(LblAmt.Text) - Convert.ToDouble(TxtDisRs.Text));

        }
        catch (Exception ex)
        {

        }
    }
    protected void TxtExtraPer_TextChanged(object sender, EventArgs e)
    {
        try
        {
            if (TxtVatRs.Text == "")
            {
                TxtVatRs.Text = "0";
            }
            if (TxtDisRs.Text == "")
            {
                TxtDisRs.Text = "0";
            }
            TxtExtraRs.Text = Convert.ToString(Convert.ToDouble((Convert.ToDouble(LblGrossRs.Text) * Convert.ToDouble(TxtExtraPer.Text) / 100)));
            LblAmt.Text = Convert.ToString(Convert.ToDouble(LblGrossRs.Text) + Convert.ToDouble(TxtVatRs.Text) + Convert.ToDouble(TxtExtraRs.Text));
            LblNetRs.Text = Convert.ToString(Convert.ToDouble(LblAmt.Text) - Convert.ToDouble(TxtDisRs.Text));
        }
        catch (Exception ex)
        {

        }
    }
    protected void TxtDisPer_TextChanged(object sender, EventArgs e)
    {
        try
        {
            TxtDisRs.Text = Convert.ToString(Convert.ToDouble((Convert.ToDouble(LblAmt.Text) * Convert.ToDouble(TxtDisPer.Text) / 100)));
            LblNetRs.Text = Convert.ToString(Convert.ToDouble(LblAmt.Text) - Convert.ToDouble(TxtDisRs.Text));
        }
        catch (Exception ex)
        {

        }
    }
    protected void TxtItemGroupName_TextChanged(object sender, EventArgs e)
    {
        try
        {
            Session["itrmgroupid"] = HifItemGroup.Value;
            TxtItemName.Focus();
        }
        catch (Exception ex)
        {

        }

    }

    protected void TxtPurchaseRate_TextChanged(object sender, EventArgs e)
    {
        //TxtQty.Text = TxtQty.Text == "" ? "0" : TxtQty.Text;
        TxtPurchaseRate.Text = TxtPurchaseRate.Text == "" ? "0" : TxtPurchaseRate.Text;
        LblTotal.Text = (Convert.ToDecimal(TxtQty.Text == "" ? "0" : TxtQty.Text) * Convert.ToDecimal(Convert.ToDecimal(TxtPurchaseRate.Text) - Convert.ToDecimal(TxtDisRsChild.Text == "" ? "0" : TxtDisRsChild.Text))).ToString("0.00");
        TxtMRP.Focus();
    }

    protected void txtDiscPerChild_TextChanged(object sender, EventArgs e)
    {
        TxtPurchaseRate.Text = TxtPurchaseRate.Text == "" ? "0" : TxtPurchaseRate.Text;
        txtDiscPerChild.Text = txtDiscPerChild.Text == "" ? "0" : txtDiscPerChild.Text;
        TxtDisRsChild.Text = TxtDisRs.Text == "" ? "0" : TxtDisRs.Text;
        TxtQty.Text = TxtQty.Text == "" ? "0" : TxtQty.Text;

        TxtDisRsChild.Text = (Convert.ToDecimal(TxtPurchaseRate.Text) * Convert.ToDecimal(txtDiscPerChild.Text) / 100).ToString("0.00");
        TxtMRP.Text = (Convert.ToDecimal(TxtPurchaseRate.Text) - Convert.ToDecimal(TxtDisRsChild.Text)).ToString("0.00");

        LblTotal.Text = (Convert.ToDecimal(TxtQty.Text) * Convert.ToDecimal(Convert.ToDecimal(TxtPurchaseRate.Text) - Convert.ToDecimal(TxtDisRsChild.Text))).ToString("0.00");
        TxtQty.Focus();
    }
    protected void TxtDisRsChild_TextChanged(object sender, EventArgs e)
    {
        TxtPurchaseRate.Text = TxtPurchaseRate.Text == "" ? "0" : TxtPurchaseRate.Text;
        txtDiscPerChild.Text = txtDiscPerChild.Text == "" ? "0" : txtDiscPerChild.Text;
        TxtDisRsChild.Text = TxtDisRs.Text == "" ? "0" : TxtDisRs.Text;
        TxtQty.Text = TxtQty.Text == "" ? "0" : TxtQty.Text;
        txtDiscPerChild.Text = "0";
        //TxtDisRs.Text = (Convert.ToDecimal(TxtMRP.Text) * Convert.ToDecimal(txtDiscPerChild.Text) / 100).ToString("0.00");
        TxtMRP.Text = (Convert.ToDecimal(TxtMRP.Text) - Convert.ToDecimal(TxtDisRsChild.Text)).ToString("0.00");
        LblTotal.Text = (Convert.ToDecimal(TxtQty.Text) * Convert.ToDecimal(Convert.ToDecimal(TxtPurchaseRate.Text) - Convert.ToDecimal(TxtDisRsChild.Text))).ToString("0.00");
        TxtQty.Focus();
    }

    protected void TxtAddLessPer_TextChanged(object sender, EventArgs e)
    {
        try
        {
            TextBox Txt = (TextBox)sender;
            GridViewRow row = (GridViewRow)(Txt.NamingContainer);

            ((TextBox)GvAddLess.Rows[row.RowIndex].FindControl("TxtAddLessRs")).Text = Convert.ToString(Convert.ToDouble(((TextBox)GvAddLess.Rows[row.RowIndex].FindControl("TxtAddLessPer")).Text) * Convert.ToDouble(LblAmt.Text) / 100);

            Double GTotal = 0;
            for (int i = 0; i < GvAddLess.Rows.Count; i++)
            {
                String total = (GvAddLess.Rows[i].FindControl("TxtAddLessRs") as TextBox).Text;
                if (total == "")
                {
                    total = "0";
                }
                if ((GvAddLess.Rows[i].FindControl("LblAddLess") as Label).Text == "+")
                {
                    GTotal = GTotal + Convert.ToDouble(total);
                }
                if ((GvAddLess.Rows[i].FindControl("LblAddLess") as Label).Text == "-")
                {
                    GTotal = GTotal - Convert.ToDouble(total);
                }
            }
            LblNetRs.Text = Convert.ToString(Convert.ToDouble(LblAmt.Text) + Convert.ToDouble(GTotal));
            LblNetRs.Text = Convert.ToDecimal(LblNetRs.Text).ToString("0.00");

        }
        catch (Exception ex)
        {

        }
    }
}