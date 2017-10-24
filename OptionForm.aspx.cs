using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using App_Code;
public partial class OptionForm : System.Web.UI.Page
{

    DataSet ds = new DataSet();
    SqlInvoice cn = new SqlInvoice();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                ds = cn.RunSql("sp_getbranch '" + Request.Cookies["CompID"].Value + "'", "select");
                DDLBranch.DataSource = ds;
                DDLBranch.DataBind();

                ds = cn.RunSql("sp_getbranch '" + Request.Cookies["CompID"].Value + "'", "select");
                DDL1Branch.DataSource = ds;
                DDL1Branch.DataBind();

                DateTime now = DateTime.Now;
                var startDate = new DateTime(now.Year, now.Month, 1);
                var endDate = startDate.AddMonths(1).AddDays(-1);

                TxtFrmdate.Text = startDate.ToString("dd-MM-yyyy");
                TxtToDate.Text = endDate.ToString("dd-MM-yyyy");
                TxtDate.Text = DateTime.Now.ToString("dd-MM-yyyy");

                if (Request.QueryString["Rpt"] == "1")
                {
                    LblHead.Text = "Purchase Register";
                    trDate.Visible = true;
                    tritem.Visible = false;
                }
                else if (Request.QueryString["Rpt"] == "5")
                {
                    LblHead.Text = "Purchase Date Summary";
                    trDate.Visible = true;
                    tritem.Visible = false;
                }
                else if (Request.QueryString["Rpt"] == "7")
                {
                    LblHead.Text = "Purchase Item Summary";
                    trDate.Visible = true;
                    //trSingleDate.Visible = true;
                    tritem.Visible = false;
                    tritem.Visible = true;
                    DDLBranch.Visible = false;
                }
                else if (Request.QueryString["Rpt"] == "2")
                {
                    LblHead.Text = "Sales Register";
                    trDate.Visible = true;
                    tritem.Visible = false;
                }
                else if (Request.QueryString["Rpt"] == "4")
                {
                    LblHead.Text = "Sales Date Summary";
                    trDate.Visible = true;
                    tritem.Visible = false;
                }
                else if (Request.QueryString["Rpt"] == "6")
                {
                    LblHead.Text = "Sales Item Summary";
                    trDate.Visible = true;
                    tritem.Visible = false;
                    tritem.Visible = true;
                    tdbranch.Visible = false;
                    DDLBranch.Visible = false;
                }
                else if (Request.QueryString["Rpt"] == "3")
                {
                    LblHead.Text = "Closing Stock";
                    trSingleDate.Visible = true;
                    tritem.Visible = true;
                }
                else if (Request.QueryString["Rpt"] == "8")
                {
                    LblHead.Text = "GST Summary";
                    trDate.Visible = true;
                    tritem.Visible = false;
                    trGst.Visible = true;
                }
                else if (Request.QueryString["Rpt"] == "Env")
                {
                    LblHead.Text = "Envelope";
                    trCusEnv.Visible = true;
                }
            }
            catch (Exception ex)
            {
                LblHead.Text = ex.Message.ToString();
            }
        }
    }

    protected void btnsave_Click(object sender, EventArgs e)
    {
        try
        {
            if (Request.QueryString["Rpt"] == "1")
            {
                Response.Redirect("PrintSalesReport.aspx?Rpt=1&FrmDate=" + TxtFrmdate.Text + "&ToDate=" + TxtToDate.Text + "&Branchid=" + DDLBranch.SelectedValue + " ");
            }
            else if (Request.QueryString["Rpt"] == "5")
            {
                Response.Redirect("PrintSalesReport.aspx?Rpt=5&FrmDate=" + TxtFrmdate.Text + "&ToDate=" + TxtToDate.Text + "&Branchid=" + DDLBranch.SelectedValue + " ");
            }
            else if (Request.QueryString["Rpt"] == "7")
            {
                Response.Redirect("PrintSalesReport.aspx?Rpt=7&FrmDate=" + TxtFrmdate.Text + "&ToDate=" + TxtToDate.Text + "&itemid=" + HifItem.Value + "&Branchid=" + DDL1Branch.SelectedValue + " ");
            }
            else if (Request.QueryString["Rpt"] == "2")
            {
                Response.Redirect("PrintSalesReport.aspx?Rpt=2&FrmDate=" + TxtFrmdate.Text + "&ToDate=" + TxtToDate.Text + "&Branchid=" + DDLBranch.SelectedValue + " ");
            }
            else if (Request.QueryString["Rpt"] == "4")
            {
                Response.Redirect("PrintSalesReport.aspx?Rpt=4&FrmDate=" + TxtFrmdate.Text + "&ToDate=" + TxtToDate.Text + "&Branchid=" + DDLBranch.SelectedValue + " ");
            }
            else if (Request.QueryString["Rpt"] == "6")
            {
                Response.Redirect("PrintSalesReport.aspx?Rpt=6&FrmDate=" + TxtFrmdate.Text + "&ToDate=" + TxtToDate.Text + "&itemid=" + HifItem.Value + "&Branchid=" + DDL1Branch.SelectedValue + " ");
            }
            else if (Request.QueryString["Rpt"] == "3")
            {
                Response.Redirect("PrintSalesReport.aspx?Rpt=3&Date=" + TxtDate.Text + "&itemId=" + HifItem.Value + "&Branchid=" + DDL1Branch.SelectedValue + " ");
            }
            else if (Request.QueryString["Rpt"] == "8")
            {
                Response.Redirect("PrintSalesReport.aspx?Rpt=8&FrmDate=" + TxtFrmdate.Text + "&ToDate=" + TxtToDate.Text + "&Type=" + DDLItem.SelectedValue + "&Branchid=" + DDLBranch.SelectedValue + " ");
            }
            else if (Request.QueryString["Rpt"] == "Env")
            {
                Response.Redirect("PrintSalesBill.aspx?Rpt=Env&Cusid=" + HifCustomer.Value + " ");
            }
        }
        catch (Exception ex)
        {
            LblHead.Text = ex.Message.ToString();
        }
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
        ds = cn.RunSql("sp_Searchforautocomplete 'Customer','" + prefixText + "','" + HttpContext.Current.Request.Cookies["CompID"].Value + "',''", "select");
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

    protected void BtnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("home.aspx");
    }
}