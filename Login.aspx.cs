using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using App_Code;

public partial class Login : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    SqlInvoice cn = new SqlInvoice();

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void BtnSave_Click(object sender, EventArgs e)
    {
        try
        {
            ds = cn.RunSql("sp_login '" + TxtUserName.Text + "','"+ TxtPassword.Text +"'", "select");
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    Response.Cookies["CompID"].Value = ds.Tables[0].Rows[0]["cCompID"].ToString();
                    Response.Cookies["CompName"].Value = ds.Tables[0].Rows[0]["cCompName"].ToString();
                    Response.Cookies["loginid"].Value = ds.Tables[0].Rows[0]["nid"].ToString();
                    Response.Cookies["cname"].Value = ds.Tables[0].Rows[0]["cname"].ToString();
                    Response.Redirect("AcYearSelection.aspx");
                }
            }
        }
        catch (Exception ex)
        {

        }
    }
}