using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using App_Code;
using iTextSharp.text;

public partial class OptionForm : System.Web.UI.Page
{

    DataSet ds = new DataSet();
    SqlInvoice cn = new SqlInvoice();
    string city;
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
                else if (Request.QueryString["Rpt"] == "DB")
                {
                    LblHead.Text = "Day book";
                    trSingleDate.Visible = true;
                }
                else if (Request.QueryString["Rpt"] == "CashB")
                {
                    LblHead.Text = "Cash book";
                    trCusEnv.Visible = true;
                    trDate.Visible = true;
                    ds = cn.RunSql("[Sp_SearchAccType] '2' ", "select");
                    DDL_Account.DataSource = ds;
                    DDL_Account.DataBind();
                    TxtCustomer.Visible = false;
                }
                else if (Request.QueryString["Rpt"] == "BankB")
                {
                    LblHead.Text = "Bank book";
                    trDate.Visible = true;
                    trCusEnv.Visible = true;
                    ds = cn.RunSql("[Sp_SearchAccType] '1' ", "select");
                    DDL_Account.DataSource = ds;
                    DDL_Account.DataBind();
                    TxtCustomer.Visible = false;
                }
                else if (Request.QueryString["Rpt"] == "StatB")
                {
                    LblHead.Text = "Statement";
                    trDate.Visible = true;
                    trCusEnv.Visible = true;
                    DDL_Account.Visible = false;
                }
                else if (Request.QueryString["Rpt"] == "Rec")
                {
                    LblHead.Text = "Receivable";
                    trSingleDate.Visible = true;
                    trcity.Visible = true;
                    ds = cn.RunSql("[sp_Searchaccount] 'City','" + Request.Cookies["CompID"].Value.ToString() + "'", "data");
                    ChkCity.DataSource = ds;
                    ChkCity.DataBind();
                }
                else if (Request.QueryString["Rpt"] == "Pay")
                {
                    LblHead.Text = "Payable";
                    trSingleDate.Visible = true;
                    trcity.Visible = true;
                    ds = cn.RunSql("[sp_Searchaccount] 'City','" + Request.Cookies["CompID"].Value.ToString() + "'", "data");
                    ChkCity.DataSource = ds;
                    ChkCity.DataBind();
                }
                else if (Request.QueryString["Rpt"] == "Trail")
                {
                    LblHead.Text = "Trail Balance";
                    trSingleDate.Visible = true;
                }
                else if (Request.QueryString["Rpt"] == "TA")
                {
                    LblHead.Text = "Trading Account";
                    trDate.Visible = true;
                }
                else if (Request.QueryString["Rpt"] == "PL")
                {
                    LblHead.Text = "Profit & Loss";
                    trDate.Visible = true;
                }
                else if (Request.QueryString["Rpt"] == "Bal")
                {
                    LblHead.Text = "Balance Shit";
                    trDate.Visible = true;
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
            else if (Request.QueryString["Rpt"] == "DB")
            {
                Response.Redirect("PrintSalesReport.aspx?Rpt=DB&dDate=" + TxtDate.Text + "&Branchid=" + DDLBranch.SelectedValue + " ");
            }
            else if (Request.QueryString["Rpt"] == "CashB")
            {
                Response.Redirect("PrintSalesReport.aspx?Rpt=CashB&FrmDate=" + TxtFrmdate.Text + "&ToDate=" + TxtToDate.Text + "&AcID=" + DDL_Account.SelectedValue + "&Branchid=" + DDLBranch.SelectedValue + " ");
            }
            else if (Request.QueryString["Rpt"] == "BankB")
            {
                Response.Redirect("PrintSalesReport.aspx?Rpt=BankB&FrmDate=" + TxtFrmdate.Text + "&ToDate=" + TxtToDate.Text + "&AcID=" + DDL_Account.SelectedValue + "&Branchid=" + DDLBranch.SelectedValue + " ");
            }
            else if (Request.QueryString["Rpt"] == "StatB")
            {
                Response.Redirect("PrintSalesReport.aspx?Rpt=StatB&FrmDate=" + TxtFrmdate.Text + "&ToDate=" + TxtToDate.Text + "&AcID=" + HifCustomer.Value + "&Branchid=" + DDLBranch.SelectedValue + " ");
            }
            else if (Request.QueryString["Rpt"] == "Rec")
            {
                city = "";
                if (ChkCity.Items[0].Selected == true)
                {
                    city = "1";
                }
                else
                {
                    for (int i = 0; i < ChkCity.Items.Count - 1; i++)
                    {
                        if (ChkCity.Items[i].Selected == true)
                        {
                            city = city + ChkCity.Items[i].Value.ToString() + ",";
                        }
                    }

                    //foreach (ListItem LiCity in ChkCity.Items)
                    //{
                    //    if (LiCity.ToString() == true)
                    //    {
                    //        city = city + LiCity.Value;
                    //    }
                    //}

                }
                Response.Redirect("PrintSalesReport.aspx?Rpt=Rec&Date=" + TxtDate.Text + "&cCity=" + city + "&Branchid=" + DDLBranch.SelectedValue + " ");
            }
            else if (Request.QueryString["Rpt"] == "Pay")
            {
                city = "";
                if (ChkCity.Items[0].Selected == true)
                {
                    city = "1";
                }
                else
                {
                    city = "1";
                    for (int i = 0; i < ChkCity.Items.Count - 1; i++)
                    {
                        if (ChkCity.Items[i].Selected == true)
                        {
                            city = city + ChkCity.Items[i].Value.ToString() + ",";
                        }
                    }
                }
                Response.Redirect("PrintSalesReport.aspx?Rpt=Pay&Date=" + TxtDate.Text + "&cCity=" + city + "&Branchid =" + DDLBranch.SelectedValue + " ");
            }

            else if (Request.QueryString["Rpt"] == "Trail")
            {
                Response.Redirect("PrintSalesReport.aspx?Rpt=Trail&dDate=" + TxtDate.Text + "&Branchid=" + DDLBranch.SelectedValue + " ");
            }
            else if (Request.QueryString["Rpt"] == "TA")
            {
                Response.Redirect("PrintSalesReport.aspx?Rpt=TA&FrmDate=" + TxtFrmdate.Text + "&ToDate=" + TxtToDate.Text + "&Branchid=" + DDLBranch.SelectedValue + " ");
            }
            else if (Request.QueryString["Rpt"] == "PL")
            {
                Response.Redirect("PrintSalesReport.aspx?Rpt=PL&FrmDate=" + TxtFrmdate.Text + "&ToDate=" + TxtToDate.Text + "&Branchid=" + DDLBranch.SelectedValue + " ");
            }
            else if (Request.QueryString["Rpt"] == "Bal")
            {
                Response.Redirect("PrintSalesReport.aspx?Rpt=Bal&FrmDate=" + TxtFrmdate.Text + "&ToDate=" + TxtToDate.Text + "&Branchid=" + DDLBranch.SelectedValue + " ");
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