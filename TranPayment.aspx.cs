using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using App_Code;

public partial class TranPayment : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    SqlInvoice cn = new SqlInvoice();

    protected void Page_Load(object sender, EventArgs e)
    {
        ds = cn.RunSql("sp_getsrno '3','0','" + Request.Cookies["CompID"].Value + "','" + Request.Cookies["BranchID"].Value + "','" + Request.Cookies["AccYear"].Value + "'", "select");
        TxtSRNo.Text = ds.Tables[0].Rows[0]["srno"] != DBNull.Value ? ds.Tables[0].Rows[0]["srno"].ToString() : "";

        if (IsPostBack == false)
        {

            if (Request.QueryString["id"] != null)
            {

                ds = cn.RunSql("sp_listReceipt '" + Request.QueryString["id"] + "','" + Request.Cookies["CompID"].Value + "','" + Request.Cookies["BranchID"].Value + "','" + Request.Cookies["AccYear"].Value + "'", "select");
                TxtSRNo.Text = ds.Tables[0].Rows[0]["nVouchNo"] != DBNull.Value ? ds.Tables[0].Rows[0]["nVouchNo"].ToString() : "";
                TxtDate.Text = ds.Tables[0].Rows[0]["dVochDate"] != DBNull.Value ? ds.Tables[0].Rows[0]["dVochDate"].ToString() : "";
                DDLCType.SelectedValue = ds.Tables[0].Rows[0]["cCashBank"] != DBNull.Value ? ds.Tables[0].Rows[0]["cCashBank"].ToString() : "";
                TxtCustomer.Text = ds.Tables[0].Rows[0]["cName"] != DBNull.Value ? ds.Tables[0].Rows[0]["cName"].ToString() : "";
                HifCustomer.Value = ds.Tables[0].Rows[0]["cAcPay"] != DBNull.Value ? ds.Tables[0].Rows[0]["cAcPay"].ToString() : "";
                LblNetRs.Text = ds.Tables[0].Rows[0]["nTotalAmt"] != DBNull.Value ? ds.Tables[0].Rows[0]["nTotalAmt"].ToString() : "";

                GVItem.DataSource = ds.Tables[1];
                GVItem.DataBind();


                if (Request.QueryString["cid"] != null)
                {
                    ds = cn.RunSql("sp_listReceipt '" + Request.QueryString["id"] + "','" + Request.Cookies["CompID"].Value + "','" + Request.Cookies["BranchID"].Value + "','" + Request.Cookies["AccYear"].Value + "','" + Request.QueryString["cid"] + "'", "select");
                    HIFAccount.Value = ds.Tables[2].Rows[0]["cAccID"] != DBNull.Value ? ds.Tables[2].Rows[0]["cAccID"].ToString() : "";
                    TxtAccount.Text = ds.Tables[2].Rows[0]["cName"] != DBNull.Value ? ds.Tables[2].Rows[0]["cName"].ToString() : "";
                    TxtAmount.Text = ds.Tables[2].Rows[0]["nAmount"] != DBNull.Value ? ds.Tables[2].Rows[0]["nAmount"].ToString() : "";
                    DDLAgainstBill.SelectedValue = ds.Tables[2].Rows[0]["cAgainstBill"] != DBNull.Value ? ds.Tables[2].Rows[0]["cAgainstBill"].ToString() : "";
                    TxtKasar.Text = ds.Tables[2].Rows[0]["nKasar"] != DBNull.Value ? ds.Tables[2].Rows[0]["nKasar"].ToString() : "";
                    TxtTDS.Text = ds.Tables[2].Rows[0]["nTDS"] != DBNull.Value ? ds.Tables[2].Rows[0]["nTDS"].ToString() : "";
                    TxtRefNO.Text = ds.Tables[2].Rows[0]["nRefNo"] != DBNull.Value ? ds.Tables[2].Rows[0]["nRefNo"].ToString() : "";
                    TxtRefdate.Text = ds.Tables[2].Rows[0]["dRefDate"] != DBNull.Value ? ds.Tables[2].Rows[0]["dRefDate"].ToString() : "";
                    TxtRemarks.Text = ds.Tables[2].Rows[0]["cRemark"] != DBNull.Value ? ds.Tables[2].Rows[0]["cRemark"].ToString() : "";


                }
                if (Request.QueryString["D"] != null)
                {
                    ddldelete.Visible = true;
                    btnsave.Text = "Delete";
                }
            }
        }

    }
    protected void ImgBtnAdd_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            TxtAmount.Text = TxtAmount.Text == "" ? "0" : TxtAmount.Text;
            TxtKasar.Text = TxtKasar.Text == "" ? "0" : TxtKasar.Text;
            TxtTDS.Text = TxtTDS.Text == "" ? "0" : TxtTDS.Text;




            if (HifCustomer.Value == "")
            {
                return;
            }

            if (Request.QueryString["id"] != null)
            {
                if (Request.QueryString["cid"] != null)
                {
                    ds = cn.RunSql("sp_addpayment 'PUCU','0','" + TxtSRNo.Text + "','" + TxtDate.Text + "','" + DDLCType.SelectedValue + "','" + HifCustomer.Value + "','" + HIFAccount.Value + "','" + TxtAmount.Text + "','" + DDLAgainstBill.SelectedValue + "','" + TxtKasar.Text + "','" + TxtTDS.Text + "','" + TxtRefNO.Text + "','" + TxtRefdate.Text + "','" + TxtRemarks.Text + "','" + Request.QueryString["id"] + "','" + Request.QueryString["cid"] + "','" + Request.Cookies["CompID"].Value + "','" + Request.Cookies["BranchID"].Value + "','" + Request.Cookies["AccYear"].Value + "','" + Request.Cookies["loginid"].Value + "'", "puci");
                    Response.Redirect("TranPayment.aspx?id=" + ds.Tables[0].Rows[0][0] + "&E=1");
                }
                else
                {
                    ds = cn.RunSql("sp_addpayment 'PUCI','0','" + TxtSRNo.Text + "','" + TxtDate.Text + "','" + DDLCType.SelectedValue + "','" + HifCustomer.Value + "','" + HIFAccount.Value + "','" + TxtAmount.Text + "','" + DDLAgainstBill.SelectedValue + "','" + TxtKasar.Text + "','" + TxtTDS.Text + "','" + TxtRefNO.Text + "','" + TxtRefdate.Text + "','" + TxtRemarks.Text + "','" + Request.QueryString["id"] + "','','" + Request.Cookies["CompID"].Value + "','" + Request.Cookies["BranchID"].Value + "','" + Request.Cookies["AccYear"].Value + "','" + Request.Cookies["loginid"].Value + "'", "puci");
                    Response.Redirect("TranPayment.aspx?id=" + ds.Tables[0].Rows[0][0] + "&E=1");
                }
            }
            else
            {
                ds = cn.RunSql("sp_addpayment 'I','0','" + TxtSRNo.Text + "','" + TxtDate.Text + "','" + DDLCType.SelectedValue + "','" + HifCustomer.Value + "','" + HIFAccount.Value + "','" + TxtAmount.Text + "','" + DDLAgainstBill.SelectedValue + "','" + TxtKasar.Text + "','" + TxtTDS.Text + "','" + TxtRefNO.Text + "','" + TxtRefdate.Text + "','" + TxtRemarks.Text + "','','','" + Request.Cookies["CompID"].Value + "','" + Request.Cookies["BranchID"].Value + "','" + Request.Cookies["AccYear"].Value + "','" + Request.Cookies["loginid"].Value + "'", "puci");
                Response.Redirect("TranPayment.aspx?id=" + ds.Tables[0].Rows[0][0] + "&E=1");
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
            if (confirmval == "Yes")
            {
                TxtAmount.Text = TxtAmount.Text == "" ? "0" : TxtAmount.Text;
                TxtKasar.Text = TxtKasar.Text == "" ? "0" : TxtKasar.Text;
                TxtTDS.Text = TxtTDS.Text == "" ? "0" : TxtTDS.Text;


                cnid = GVItem.Rows[row.RowIndex].Cells[0].Text;
                ds = cn.RunSql("sp_addpayment 'PUCD','0','" + TxtSRNo.Text + "','" + TxtDate.Text + "','" + DDLCType.SelectedValue + "','" + HifCustomer.Value + "','','','','','','','','','" + Request.QueryString["id"] + "','" + cnid + "','" + Request.Cookies["CompID"].Value + "','" + Request.Cookies["BranchID"].Value + "','" + Request.Cookies["AccYear"].Value + "','" + Request.Cookies["loginid"].Value + "'", "puci");
                Response.Redirect("TranPayment.aspx?id=" + ds.Tables[0].Rows[0][0] + "");
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
            TxtAmount.Text = TxtAmount.Text == "" ? "0" : TxtAmount.Text;
            TxtKasar.Text = TxtKasar.Text == "" ? "0" : TxtKasar.Text;
            TxtTDS.Text = TxtTDS.Text == "" ? "0" : TxtTDS.Text;



            if (Request.QueryString["D"] == "1")
            {
                if (ddldelete.SelectedValue == "Yes")
                {

                    ds = cn.RunSql("sp_addpayment 'd','0','" + TxtSRNo.Text + "','" + TxtDate.Text + "','" + DDLCType.SelectedValue + "','" + HifCustomer.Value + "','" + HIFAccount.Value + "','" + TxtAmount.Text + "','" + DDLAgainstBill.SelectedValue + "','" + TxtKasar.Text + "','" + TxtTDS.Text + "','" + TxtRefNO.Text + "','" + TxtRefdate.Text + "','" + TxtRemarks.Text + "','" + Request.QueryString["id"] + "','','" + Request.Cookies["CompID"].Value + "','" + Request.Cookies["BranchID"].Value + "','" + Request.Cookies["AccYear"].Value + "','" + Request.Cookies["loginid"].Value + "'", "puci");
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "ScuessMsg('D','D')", true);

                }
            }
            else
            {


                ds = cn.RunSql("sp_addpayment 'PU','0','" + TxtSRNo.Text + "','" + TxtDate.Text + "','" + DDLCType.SelectedValue + "','" + HifCustomer.Value + "','','','','','','','','','" + Request.QueryString["id"] + "','','" + Request.Cookies["CompID"].Value + "','" + Request.Cookies["BranchID"].Value + "','" + Request.Cookies["AccYear"].Value + "','" + Request.Cookies["loginid"].Value + "'", "puci");
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
    [System.Web.Script.Services.ScriptMethod()]
    [System.Web.Services.WebMethod]
    public static List<string> SearchAccount(string prefixText, int count)
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
    [System.Web.Script.Services.ScriptMethod()]
    [System.Web.Services.WebMethod]
    public static List<string> SearchCustomer(string prefixText, int count)
    {
        DataSet ds = new DataSet();
        SqlInvoice cn = new SqlInvoice();
        List<string> zone = new List<string>();
        string cnm = "";
        ds = cn.RunSql("sp_Searchforautocomplete 'Account','" + prefixText + "','" + HttpContext.Current.Request.Cookies["CompID"].Value + "',''", "select");
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