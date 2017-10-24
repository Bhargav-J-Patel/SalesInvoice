using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using App_Code;
using System.Data;

public partial class PrintSalesBill : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    SqlInvoice cn = new SqlInvoice();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack == false)
        {
            try
            {
                if (Request.QueryString["Rpt"] == "Env")
                {
                    ds = cn.RunSql("[Sp_PrintEnvelope] '"+ Request.QueryString["Cusid"] +"'", "data");
                    LblReport.Text = ds.Tables[0].Rows[0][0] != DBNull.Value ? ds.Tables[0].Rows[0][0].ToString() : "";
                }
                else
                {
                    ds = cn.RunSql("sp_billprint '" + Request.QueryString["ID"] + "'", "stockissue");
                    LblReport.Text = ds.Tables[0].Rows[0][0] != DBNull.Value ? ds.Tables[0].Rows[0][0].ToString() : "";
                }
            }
            catch (Exception ex)
            {
                LblReport.Text = ex.Message.ToString();
                LblReport.Style.Add("color", "red");
            }
            finally
            {
                ds.Dispose();
            }
        }
    }
}