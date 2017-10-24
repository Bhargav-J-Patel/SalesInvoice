using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using App_Code;

public partial class TranStock : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    SqlInvoice cn = new SqlInvoice();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack == false)
        {
            try
            {

                ds = cn.RunSql("sp_getsrno '2','" + Request.Cookies["CompID"].Value + "','" + Request.Cookies["BranchID"].Value + "','" + Request.Cookies["AccYear"].Value + "'", "select");
                TxtSRNo.Text = ds.Tables[0].Rows[0]["srno"] != DBNull.Value ? ds.Tables[0].Rows[0]["srno"].ToString() : "";

                if (Request.QueryString["id"] != null)
                {
                    ds = cn.RunSql("sp_liststock '" + Request.QueryString["id"] + "','" + Request.Cookies["CompID"].Value + "','" + Request.Cookies["BranchID"].Value + "','" + Request.Cookies["AccYear"].Value + "'", "select");
                    TxtSRNo.Text = ds.Tables[0].Rows[0]["nSrNo"] != DBNull.Value ? ds.Tables[0].Rows[0]["nSrNo"].ToString() : "";
                    TxtDate.Text = ds.Tables[0].Rows[0]["dDate"] != DBNull.Value ? ds.Tables[0].Rows[0]["dDate"].ToString() : "";
                    
                    GVItem.DataSource = ds.Tables[1];
                    GVItem.DataBind();

                    if (Request.QueryString["cid"] != null)
                    {
                        ds = cn.RunSql("sp_liststock '" + Request.QueryString["id"] + "','" + Request.Cookies["CompID"].Value + "','" + Request.Cookies["BranchID"].Value + "','" + Request.Cookies["AccYear"].Value + "','" + Request.QueryString["cid"] + "'", "select");
                        TxtItemGroupName.Text = ds.Tables[3].Rows[0]["cItemGroupName"] != DBNull.Value ? ds.Tables[3].Rows[0]["cItemGroupName"].ToString() : "";
                        TxtItemName.Text = ds.Tables[3].Rows[0]["cItem"] != DBNull.Value ? ds.Tables[3].Rows[0]["cItem"].ToString() : "";
                        HifItemGroup.Value = ds.Tables[3].Rows[0]["itemgrpid"] != DBNull.Value ? ds.Tables[3].Rows[0]["itemgrpid"].ToString() : "";
                        HifItem.Value = ds.Tables[3].Rows[0]["itemid"] != DBNull.Value ? ds.Tables[3].Rows[0]["itemid"].ToString() : "";
                        TxtTotalQty.Text = ds.Tables[3].Rows[0]["nqty"] != DBNull.Value ? ds.Tables[3].Rows[0]["nqty"].ToString() : "";
                        
                    }
                    if (Request.QueryString["D"] != null)
                    {
                        ddldelete.Visible = true;
                        btnsave.Text = "Delete";
                    }
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
    protected void ImgBtnAdd_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            if (Request.QueryString["id"] != null)
            {
                if (Request.QueryString["cid"] != null)
                {
                    ds = cn.RunSql("sp_addstock 'PUCU','1','" + TxtSRNo.Text + "','" + TxtDate.Text + "','" + HifItem.Value + "','" + TxtTotalQty.Text + "','" + Request.QueryString["id"] + "','" + Request.QueryString["cid"] + "','" + Request.Cookies["CompID"].Value + "','" + Request.Cookies["BranchID"].Value + "','" + Request.Cookies["AccYear"].Value + "'", "puci");
                    Response.Redirect("TranStock.aspx?id=" + ds.Tables[0].Rows[0][0] + "&E=1");
                }
                else
                {
                    ds = cn.RunSql("sp_addstock 'PUCI','1','" + TxtSRNo.Text + "','" + TxtDate.Text + "','" + HifItem.Value + "','" + TxtTotalQty.Text + "','" + Request.QueryString["id"] + "','','" + Request.Cookies["CompID"].Value + "','" + Request.Cookies["BranchID"].Value + "','" + Request.Cookies["AccYear"].Value + "'", "puci");
                    Response.Redirect("TranStock.aspx?id=" + ds.Tables[0].Rows[0][0] + "&E=1");
                }
            }
            else
            {
                ds = cn.RunSql("sp_addstock 'I','1','" + TxtSRNo.Text + "','" + TxtDate.Text + "','" + HifItem.Value + "','" + TxtTotalQty.Text + "','','','" + Request.Cookies["CompID"].Value + "','" + Request.Cookies["BranchID"].Value + "','" + Request.Cookies["AccYear"].Value + "'", "puci");
                Response.Redirect("TranStock.aspx?id=" + ds.Tables[0].Rows[0][0] + "&E=1");
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
                cnid = GVItem.Rows[row.RowIndex].Cells[0].Text;
                ds = cn.RunSql("sp_addstock 'PUCD','1','" + TxtSRNo.Text + "','" + TxtDate.Text + "','" + HifItem.Value + "','" + TxtTotalQty.Text + "','" + Request.QueryString["id"] + "','" + cnid + "','" + Request.Cookies["CompID"].Value + "','" + Request.Cookies["BranchID"].Value + "','" + Request.Cookies["AccYear"].Value + "'", "puci");
                Response.Redirect("TranStock.aspx?id=" + ds.Tables[0].Rows[0][0] + "");
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
            if (Request.QueryString["D"] == "1")
            {
                if (ddldelete.SelectedValue == "Yes")
                {
                    ds = cn.RunSql("sp_addstock 'D','1','" + TxtSRNo.Text + "','" + TxtDate.Text + "','" + HifItem.Value + "','" + TxtTotalQty.Text + "','" + Request.QueryString["id"] + "','','" + Request.Cookies["CompID"].Value + "','" + Request.Cookies["BranchID"].Value + "','" + Request.Cookies["AccYear"].Value + "'", "puci");
                    Response.Redirect("TranStock.aspx");
                }
            }
            else
            {
                ds = cn.RunSql("sp_addstock 'PU','1','" + TxtSRNo.Text + "','" + TxtDate.Text + "','" + HifItem.Value + "','" + TxtTotalQty.Text + "','" + Request.QueryString["id"] + "','','" + Request.Cookies["CompID"].Value + "','" + Request.Cookies["BranchID"].Value + "','" + Request.Cookies["AccYear"].Value + "'", "puci");
                Response.Redirect("TranStock.aspx");
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
        Response.Redirect("TranStock.aspx");
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
}