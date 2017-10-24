using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using App_Code;

public partial class MasterGroup : System.Web.UI.Page
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
                    ds = cn.RunSql("sp_listGroup '" + Request.QueryString["id"] + "'", "search");

                    TxtGroupName.Text = ds.Tables[0].Rows[0]["cGroupName"] != DBNull.Value ? ds.Tables[0].Rows[0]["cGroupName"].ToString() : "";
                    TxtGroupCode.Text = ds.Tables[0].Rows[0]["cGroupCode"] != DBNull.Value ? ds.Tables[0].Rows[0]["cGroupCode"].ToString() : "";
                    TxtGroupPosition.Text = ds.Tables[0].Rows[0]["nGroupPosition"] != DBNull.Value ? ds.Tables[0].Rows[0]["nGroupPosition"].ToString() : "";
                    DDLAccType.SelectedValue = ds.Tables[0].Rows[0]["cAccType"] != DBNull.Value ? ds.Tables[0].Rows[0]["cAccType"].ToString() : "";


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
                    ds = cn.RunSql("sp_addgroup 'U','" + TxtGroupName.Text + "','" + TxtGroupCode.Text + "','" + TxtGroupPosition.Text + "','" + DDLAccType.Text + "','" + Request.Cookies["CompID"].Value + "','" + Request.QueryString["id"] + "'", "insert");
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "ScuessMsg('U')", true);

                }
                if (Request.QueryString["D"] == "1")
                {
                    if (ddldelete.SelectedValue == "Yes")
                    {
                        ds = cn.RunSql("sp_addgroup 'D','" + TxtGroupName.Text + "','" + TxtGroupCode.Text + "','" + TxtGroupPosition.Text + "','" + DDLAccType.Text + "','" + Request.Cookies["CompID"].Value + "','" + Request.QueryString["id"] + "'", "insert");
                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "ScuessMsg('D')", true);
                    }
                }

            }
            else
            {
                ds = cn.RunSql("sp_addgroup 'I','" + TxtGroupName.Text + "','" + TxtGroupCode.Text + "','" + TxtGroupPosition.Text + "','" + DDLAccType.Text + "','" + Request.Cookies["CompID"].Value + "',''", "insert");
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