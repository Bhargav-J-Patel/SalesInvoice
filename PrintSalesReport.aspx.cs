using System;
using App_Code;
using System.Data;
using System.Web.UI.WebControls;

public partial class PrintSalesReport : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    SqlInvoice cn = new SqlInvoice();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try

            {
                if (Request.QueryString["Rpt"] == "1")
                {
                    ds = cn.RunSql("[sp_PrintPurchaseDateWise] '" + Request.QueryString["FrmDate"] + "','" + Request.QueryString["Todate"] + "','" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompID"].Value + "' ", "data");
                }
                else if (Request.QueryString["Rpt"] == "5")
                {
                    ds = cn.RunSql("[Sp_PrintPurchasedateSummary] '" + Request.QueryString["FrmDate"] + "','" + Request.QueryString["Todate"] + "','" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompID"].Value + "' ", "data");
                }
                else if (Request.QueryString["Rpt"] == "7")
                {
                    ds = cn.RunSql("[Sp_PrintPurchaseItemSummary] '" + Request.QueryString["FrmDate"] + "','" + Request.QueryString["Todate"] + "','" + Request.QueryString["itemid"] + "','" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompID"].Value + "' ", "data");
                }
                else if (Request.QueryString["Rpt"] == "2")
                {
                    //ds = cn.RunSql("[sp_PrintSalesDateWise] '" + Request.QueryString["FrmDate"] + "','" + Request.QueryString["Todate"] + "','" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompID"].Value + "' ", "data");
                    ds = cn.RunSql("[sp_PrintSalesDateRegi] '" + Request.QueryString["FrmDate"] + "','" + Request.QueryString["Todate"] + "','" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompID"].Value + "' ", "data");
                }
                else if (Request.QueryString["Rpt"] == "4")
                {
                    ds = cn.RunSql("[Sp_PrintSalesdateSummary] '" + Request.QueryString["FrmDate"] + "','" + Request.QueryString["Todate"] + "','" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompID"].Value + "' ", "data");
                }
                else if (Request.QueryString["Rpt"] == "6")
                {
                    ds = cn.RunSql("[Sp_PrintSalesItemSummary] '" + Request.QueryString["FrmDate"] + "','" + Request.QueryString["Todate"] + "','" + Request.QueryString["itemid"] + "','" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompID"].Value + "' ", "data");
                }
                else if (Request.QueryString["Rpt"] == "3")
                {
                    ds = cn.RunSql("[Sp_PrintClosingDateWise] '" + Request.QueryString["Date"] + "','" + Request.QueryString["itemId"] + "','" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompID"].Value + "','" + Request.Cookies["AccYear"].Value + "' ", "Data");
                }
                else if (Request.QueryString["Rpt"] == "8")
                {
                    ds = cn.RunSql("[Sp_PrintGSTSummary] '" + Request.QueryString["FrmDate"] + "','" + Request.QueryString["Todate"] + "','" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompID"].Value + "','" + Request.QueryString["Type"] + "' ", "data");
                }
                else if (Request.QueryString["Rpt"] == "DB")
                {
                    ds = cn.RunSql("[Sp_PrintDayBook] '" + Request.QueryString["dDate"] + "','" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompID"].Value + "' ", "Data");
                }
                else if (Request.QueryString["Rpt"] == "CashB")
                {
                    ds = cn.RunSql("[Sp_PrintCashBankStatmnent]'" + Request.QueryString["FrmDate"] + "','" + Request.QueryString["Todate"] + "','" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompID"].Value + "','" + Request.QueryString["AcID"] + "' ", "Data");
                }
                else if (Request.QueryString["Rpt"] == "BankB")
                {
                    ds = cn.RunSql("[Sp_PrintCashBankStatmnent]'" + Request.QueryString["FrmDate"] + "','" + Request.QueryString["Todate"] + "','" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompID"].Value + "','" + Request.QueryString["AcID"] + "' ", "Data");
                }
                else if (Request.QueryString["Rpt"] == "StatB")
                {
                    ds = cn.RunSql("[Sp_PrintCashBankStatmnent]'" + Request.QueryString["FrmDate"] + "','" + Request.QueryString["Todate"] + "','" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompID"].Value + "','" + Request.QueryString["AcID"] + "' ", "Data");
                }
                else if (Request.QueryString["Rpt"] == "Rec")
                {
                    ds = cn.RunSql("[Sp_PrintReci_Pay] '" + Request.QueryString["date"] + "','" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompId"].Value.ToString() + "','" + Request.QueryString["cCity"] + "','R' ", "data");
                }
                else if (Request.QueryString["Rpt"] == "Pay")
                {
                    ds = cn.RunSql("[Sp_PrintReci_Pay] '" + Request.QueryString["date"] + "','" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompId"].Value.ToString() + "','" + Request.QueryString["cCity"] + "','P' ", "data");
                }
                else if (Request.QueryString["Rpt"] == "Trail")
                {
                    ds = cn.RunSql("[Sp_PrintTrailBalance] '" + Request.QueryString["dDate"] + "', '" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompId"].Value.ToString() + "','" + Request.Cookies["AccYear"].Value.ToString() + "' ", "data");
                }
                else if (Request.QueryString["Rpt"] == "TA")
                {
                    ds = cn.RunSql("[Sp_PrintTA_PL_bal] '" + Request.QueryString["FrmDate"] + "','" + Request.QueryString["Todate"] + "', '" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompId"].Value.ToString() + "'", "data");
                    Lbl.Text = ds.Tables[0].Rows[0][0].ToString();
                }
                else if (Request.QueryString["Rpt"] == "PL")
                {
                    ds = cn.RunSql("[Sp_PrintTA_PL_bal] '" + Request.QueryString["FrmDate"] + "','" + Request.QueryString["Todate"] + "', '" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompId"].Value.ToString() + "'", "data");
                    Lbl.Text = ds.Tables[1].Rows[0][0].ToString();
                }
                else if (Request.QueryString["Rpt"] == "Bal")
                {
                    ds = cn.RunSql("[Sp_PrintTA_PL_bal] '" + Request.QueryString["FrmDate"] + "','" + Request.QueryString["Todate"] + "', '" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompId"].Value.ToString() + "'", "data");
                    Lbl.Text = ds.Tables[2].Rows[0][0].ToString();
                }
                //[Sp_PrintTA_PL_bal]
                if (Request.QueryString["Rpt"] != "TA" && Request.QueryString["Rpt"] != "PL" && Request.QueryString["Rpt"] != "Bal")
                {
                    if (ds.Tables.Count > 0)
                    {
                        Lbl.Text = ds.Tables[0].Rows[0][0].ToString();
                    }
                    else
                    {
                        Lbl.Text = "Error.... !! THERE IS NO RECORD.";
                        Lbl.Style.Add("color", "red");
                    }
                }
            }
            catch (Exception ex)
            {
                Lbl.Text = ex.Message.ToString();
                Lbl.Style.Add("color", "red");
            }
        }
    }


    public void ImageButton1_Click(object sender, EventArgs e)
    {
        if (Request.QueryString["Rpt"] == "1")
        {
            ds = cn.RunSql("[sp_PrintPurchaseDateWise] '" + Request.QueryString["FrmDate"] + "','" + Request.QueryString["Todate"] + "','" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompID"].Value + "' ", "data");
        }
        else if (Request.QueryString["Rpt"] == "5")
        {
            ds = cn.RunSql("[Sp_PrintPurchasedateSummary] '" + Request.QueryString["FrmDate"] + "','" + Request.QueryString["Todate"] + "','" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompID"].Value + "' ", "data");
        }
        else if (Request.QueryString["Rpt"] == "7")
        {
            ds = cn.RunSql("[Sp_PrintPurchaseItemSummary] '" + Request.QueryString["FrmDate"] + "','" + Request.QueryString["Todate"] + "','" + Request.QueryString["itemid"] + "','" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompID"].Value + "' ", "data");
        }
        else if (Request.QueryString["Rpt"] == "2")
        {
            //ds = cn.RunSql("[sp_PrintSalesDateWise] '" + Request.QueryString["FrmDate"] + "','" + Request.QueryString["Todate"] + "','" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompID"].Value + "' ", "data");
            //ds = cn.RunSql("[sp_PrintSalesDateRegi] '" + Request.QueryString["FrmDate"] + "','" + Request.QueryString["Todate"] + "','" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompID"].Value + "' ", "data");
            ds = cn.RunSql("[sp_PrintSalesDateRegi] '" + Request.QueryString["FrmDate"] + "','" + Request.QueryString["Todate"] + "','" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompID"].Value + "' ", "data");
        }
        else if (Request.QueryString["Rpt"] == "4")
        {
            ds = cn.RunSql("[Sp_PrintSalesdateSummary] '" + Request.QueryString["FrmDate"] + "','" + Request.QueryString["Todate"] + "','" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompID"].Value + "' ", "data");
        }
        else if (Request.QueryString["Rpt"] == "6")
        {
            ds = cn.RunSql("[Sp_PrintSalesItemSummary] '" + Request.QueryString["FrmDate"] + "','" + Request.QueryString["Todate"] + "','" + Request.QueryString["itemid"] + "','" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompID"].Value + "' ", "data");
        }
        else if (Request.QueryString["Rpt"] == "3")
        {
            ds = cn.RunSql("[Sp_PrintClosingDateWise] '" + Request.QueryString["Date"] + "','" + Request.QueryString["itemId"] + "','" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompID"].Value + "','" + Request.Cookies["AccYear"].Value + "' ", "Data");
        }
        else if (Request.QueryString["Rpt"] == "8")
        {
            ds = cn.RunSql("[Sp_PrintGSTSummary] '" + Request.QueryString["FrmDate"] + "','" + Request.QueryString["Todate"] + "','" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompID"].Value + "','" + Request.QueryString["Type"] + "' ", "data");
        }
        else if (Request.QueryString["Rpt"] == "DB")
        {
            ds = cn.RunSql("[Sp_PrintDayBook] '" + Request.QueryString["Date"] + "','" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompID"].Value + "' ", "Data");
        }
        else if (Request.QueryString["Rpt"] == "CashB")
        {
            ds = cn.RunSql("[Sp_PrintCashBankStatmnent]'" + Request.QueryString["FrmDate"] + "','" + Request.QueryString["Todate"] + "','" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompID"].Value + "','" + Request.QueryString["AcID"] + "' ", "Data");
        }
        else if (Request.QueryString["Rpt"] == "BankB")
        {
            ds = cn.RunSql("[Sp_PrintCashBankStatmnent]'" + Request.QueryString["FrmDate"] + "','" + Request.QueryString["Todate"] + "','" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompID"].Value + "','" + Request.QueryString["AcID"] + "' ", "Data");
        }
        else if (Request.QueryString["Rpt"] == "StatB")
        {
            ds = cn.RunSql("[Sp_PrintCashBankStatmnent]'" + Request.QueryString["FrmDate"] + "','" + Request.QueryString["Todate"] + "','" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompID"].Value + "','" + Request.QueryString["AcID"] + "' ", "Data");
        }
        else if (Request.QueryString["Rpt"] == "Rec")
        {
            ds = cn.RunSql("[Sp_PrintReci_Pay] '" + Request.QueryString["date"] + "','" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompId"].Value.ToString() + "','" + Request.QueryString["cCity"] + "','R' ", "data");
        }
        else if (Request.QueryString["Rpt"] == "Pay")
        {
            ds = cn.RunSql("[Sp_PrintReci_Pay] '" + Request.QueryString["date"] + "','" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompId"].Value.ToString() + "','" + Request.QueryString["cCity"] + "','P' ", "data");
        }

        else if (Request.QueryString["Rpt"] == "Trail")
        {
            ds = cn.RunSql("[Sp_PrintTrailBalance] '" + Request.QueryString["dDate"] + "', '" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompId"].Value.ToString() + "','" + Request.Cookies["AccYear"].Value.ToString() + "' ", "data");
        }
        else if (Request.QueryString["Rpt"] == "TA")
        {
            ds = cn.RunSql("[Sp_PrintTA_PL_bal] '" + Request.QueryString["FrmDate"] + "','" + Request.QueryString["Todate"] + "', '" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompId"].Value.ToString() + "'", "data");
            Lbl.Text = ds.Tables[0].Rows[0][0].ToString();
        }
        else if (Request.QueryString["Rpt"] == "PL")
        {
            ds = cn.RunSql("[Sp_PrintTA_PL_bal] '" + Request.QueryString["FrmDate"] + "','" + Request.QueryString["Todate"] + "', '" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompId"].Value.ToString() + "'", "data");
            ExportToExcel(ds.Tables[1], "ProfitLoss");
        }
        else if (Request.QueryString["Rpt"] == "Bal")
        {
            ds = cn.RunSql("[Sp_PrintTA_PL_bal] '" + Request.QueryString["FrmDate"] + "','" + Request.QueryString["Todate"] + "', '" + Request.QueryString["Branchid"] + "','" + Request.Cookies["CompId"].Value.ToString() + "'", "data");
            ExportToExcel(ds.Tables[2], "Balancesheet");
        }
        if (Request.QueryString["Rpt"] != "PL" && Request.QueryString["Rpt"] != "Bal")
        {
            if (ds.Tables.Count > 0)
            {
                ExportToExcel(ds.Tables[0], "SalesData");
            }
            else
            {
                Lbl.Text = "Error.... !! THERE IS NO RECORD.";
                Lbl.Style.Add("color", "red");
            }
        }
    }

    void ExportToExcel(DataTable dt, string filenmae)
    {
        string filename = filenmae + ".xls";
        System.IO.StringWriter tw = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);
        DataGrid dgGrid = new DataGrid();
        dgGrid.DataSource = dt;
        dgGrid.DataBind();

        //Get the HTML for the control.
        dgGrid.RenderControl(hw);
        //Write the HTML back to the browser.
        //Response.ContentType = application/vnd.ms-excel;
        Response.ContentType = "application/vnd.ms-excel";
        Response.AppendHeader("Content-Disposition",
                              "attachment; filename=" + filename + "");
        this.EnableViewState = false;
        Response.Write(tw.ToString());
        Response.End();
    }
}