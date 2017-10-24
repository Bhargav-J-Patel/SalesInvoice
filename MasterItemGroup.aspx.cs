using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using App_Code;

public partial class MasterItemGroup : System.Web.UI.Page
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
                    ds = cn.RunSql("sp_listItemGroup 's','','" + Request.QueryString["id"] + "'", "search");

                    TxtItemGroupName.Text = ds.Tables[0].Rows[0]["cItemGroupName"] != DBNull.Value ? ds.Tables[0].Rows[0]["cItemGroupName"].ToString() : "";
                    TxtHsnCode.Text = ds.Tables[0].Rows[0]["cHSNCode"] != DBNull.Value ? ds.Tables[0].Rows[0]["cHSNCode"].ToString() : "";
                    TxtCGSTPer.Text = ds.Tables[0].Rows[0]["cCGSTPer"] != DBNull.Value ? ds.Tables[0].Rows[0]["cCGSTPer"].ToString() : "";
                    TxtSGSTPer.Text = ds.Tables[0].Rows[0]["cSGSTPer"] != DBNull.Value ? ds.Tables[0].Rows[0]["cSGSTPer"].ToString() : "";


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
                    ds = cn.RunSql("sp_additemgroup 'U','" + TxtItemGroupName.Text + "','"+ TxtHsnCode.Text +"','" + TxtCGSTPer.Text + "','" + TxtSGSTPer.Text + "','" + Request.Cookies["CompID"].Value + "','" + Request.QueryString["id"] + "'", "insert");
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "ScuessMsg('U')", true);

                }
                if (Request.QueryString["D"] == "1")
                {
                    if (ddldelete.SelectedValue == "Yes")
                    {
                        ds = cn.RunSql("sp_additemgroup 'D','" + TxtItemGroupName.Text + "','" + TxtHsnCode.Text + "','" + TxtCGSTPer.Text + "','" + TxtSGSTPer.Text + "','" + Request.Cookies["CompID"].Value + "','" + Request.QueryString["id"] + "'", "insert");
                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "ScuessMsg('D')", true);
                    }
                }

            }
            else
            {
                ds = cn.RunSql("sp_additemgroup 'I','" + TxtItemGroupName.Text + "','" + TxtHsnCode.Text + "','" + TxtCGSTPer.Text + "','" + TxtSGSTPer.Text + "','" + Request.Cookies["CompID"].Value + "','" + Request.QueryString["id"] + "'", "insert");
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