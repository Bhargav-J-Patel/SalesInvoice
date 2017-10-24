using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using App_Code;

public partial class MasterAcccount : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    SqlInvoice cn = new SqlInvoice();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (IsPostBack == false)
            {

                ds = cn.RunSql("sp_srchaccgroup","selct");
                DDLAcGroup.DataSource = ds;
                DDLAcGroup.DataBind();

                if (Request.QueryString["id"] != null)
                {
                    ds = cn.RunSql("sp_listCustomer 's','','" + Request.QueryString["id"] + "'", "search");

                    TxtCustName.Text = ds.Tables[0].Rows[0]["cName"] != DBNull.Value ? ds.Tables[0].Rows[0]["cName"].ToString() : "";
                    TxtConPName.Text = ds.Tables[0].Rows[0]["cCoName"] != DBNull.Value ? ds.Tables[0].Rows[0]["cCoName"].ToString() : "";
                    TxtAddress.Text = ds.Tables[0].Rows[0]["cAddress"] != DBNull.Value ? ds.Tables[0].Rows[0]["cAddress"].ToString() : "";
                    TxtCity.Text = ds.Tables[0].Rows[0]["cCity"] != DBNull.Value ? ds.Tables[0].Rows[0]["cCity"].ToString() : "";
                    TxtPinCode.Text = ds.Tables[0].Rows[0]["cPinCode"] != DBNull.Value ? ds.Tables[0].Rows[0]["cPinCode"].ToString() : "";
                    TxtState.Text = ds.Tables[0].Rows[0]["cState"] != DBNull.Value ? ds.Tables[0].Rows[0]["cState"].ToString() : "";
                    TxtCountry.Text = ds.Tables[0].Rows[0]["cCountry"] != DBNull.Value ? ds.Tables[0].Rows[0]["cCountry"].ToString() : "";
                    TxtcContactNo.Text = ds.Tables[0].Rows[0]["cConNo"] != DBNull.Value ? ds.Tables[0].Rows[0]["cConNo"].ToString() : "";
                    TxtEmailID.Text = ds.Tables[0].Rows[0]["cEmailID"] != DBNull.Value ? ds.Tables[0].Rows[0]["cEmailID"].ToString() : "";
                    TxtTinNo.Text = ds.Tables[0].Rows[0]["cTinNo"] != DBNull.Value ? ds.Tables[0].Rows[0]["cTinNo"].ToString() : "";
                    TxtVatNo.Text = ds.Tables[0].Rows[0]["cVatNo"] != DBNull.Value ? ds.Tables[0].Rows[0]["cVatNo"].ToString() : "";
                    TxtcPANNo.Text = ds.Tables[0].Rows[0]["cPanNo"] != DBNull.Value ? ds.Tables[0].Rows[0]["cPanNo"].ToString() : "";
                    TxtOtherDetail.Text = ds.Tables[0].Rows[0]["cOtherDetail"] != DBNull.Value ? ds.Tables[0].Rows[0]["cOtherDetail"].ToString() : "";
                    TxtBankName.Text = ds.Tables[0].Rows[0]["cBankName"] != DBNull.Value ? ds.Tables[0].Rows[0]["cBankName"].ToString() : "";
                    TxtIFSCCode.Text = ds.Tables[0].Rows[0]["cIFSCCode"] != DBNull.Value ? ds.Tables[0].Rows[0]["cIFSCCode"].ToString() : "";
                    TxtAccount.Text = ds.Tables[0].Rows[0]["cAccNo"] != DBNull.Value ? ds.Tables[0].Rows[0]["cAccNo"].ToString() : "";
                    TxtBranch.Text = ds.Tables[0].Rows[0]["cBranchName"] != DBNull.Value ? ds.Tables[0].Rows[0]["cBranchName"].ToString() : "";
                    DDLAcGroup.SelectedValue = ds.Tables[0].Rows[0]["cAccGroup"] != DBNull.Value ? ds.Tables[0].Rows[0]["cAccGroup"].ToString() : "";
                    DDLAcType.SelectedValue = ds.Tables[0].Rows[0]["cType"] != DBNull.Value ? ds.Tables[0].Rows[0]["cType"].ToString() : "";



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
            if (Request.QueryString["id"] != null)
            {
                if (Request.QueryString["E"] == "1")
                {
                    ds = cn.RunSql("sp_addcustomer 'U','" + TxtCustName.Text + "','" + TxtConPName.Text + "','" + TxtAddress.Text + "','" + TxtCity.Text + "','" + TxtPinCode.Text + "','" + TxtState.Text + "','" + TxtCountry.Text + "','" + TxtcContactNo.Text + "','" + TxtEmailID.Text + "','" + TxtTinNo.Text + "','" + TxtVatNo.Text + "','" + TxtcPANNo.Text + "','" + TxtOtherDetail.Text + "','" + Request.Cookies["CompID"].Value + "','" + DDLAcType.SelectedValue + "','" + TxtBankName.Text + "','" + TxtIFSCCode.Text + "','" + TxtAccount.Text + "','" + TxtBranch.Text + "','" + Request.QueryString["ID"] + "','" + DDLAcGroup.SelectedValue + "'", "insert");
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "ScuessMsg('U')", true);

                }
                if (Request.QueryString["D"] == "1")
                {
                    if (ddldelete.SelectedValue == "Yes")
                    {
                        ds = cn.RunSql("sp_addcustomer 'D','" + TxtCustName.Text + "','" + TxtConPName.Text + "','" + TxtAddress.Text + "','" + TxtCity.Text + "','" + TxtPinCode.Text + "','" + TxtState.Text + "','" + TxtCountry.Text + "','" + TxtcContactNo.Text + "','" + TxtEmailID.Text + "','" + TxtTinNo.Text + "','" + TxtVatNo.Text + "','" + TxtcPANNo.Text + "','" + TxtOtherDetail.Text + "','" + Request.Cookies["CompID"].Value + "','" + DDLAcType.SelectedValue + "','" + TxtBankName.Text + "','" + TxtIFSCCode.Text + "','" + TxtAccount.Text + "','" + TxtBranch.Text + "','" + Request.QueryString["Id"] + "','" + DDLAcGroup.SelectedValue + "'", "insert");
                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "ScuessMsg('D')", true);
                    }
                }

            }
            else
            {
                ds = cn.RunSql("sp_addcustomer 'I','" + TxtCustName.Text + "','" + TxtConPName.Text + "','" + TxtAddress.Text + "','" + TxtCity.Text + "','" + TxtPinCode.Text + "','" + TxtState.Text + "','" + TxtCountry.Text + "','" + TxtcContactNo.Text + "','" + TxtEmailID.Text + "','" + TxtTinNo.Text + "','" + TxtVatNo.Text + "','" + TxtcPANNo.Text + "','" + TxtOtherDetail.Text + "','" + Request.Cookies["CompID"].Value + "','" + DDLAcType.SelectedValue + "','" + TxtBankName.Text + "','" + TxtIFSCCode.Text + "','" + TxtAccount.Text + "','" + TxtBranch.Text + "','','" + DDLAcGroup.SelectedValue + "'", "insert");
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
}