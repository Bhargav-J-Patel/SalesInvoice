using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using App_Code;
public partial class TranAddLessPurchase : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    SqlInvoice cn = new SqlInvoice();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                BindGrid();
                if (Request.QueryString["ID"] != null)
                {
                    ds = cn.RunSql("sp_SearchAddLess 'S','" + Request.QueryString["ID"].ToString() + "','3'", "Search");
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        TxtDescription.Text = ds.Tables[0].Rows[0]["cDescription"] != DBNull.Value ? ds.Tables[0].Rows[0]["cDescription"].ToString() : "";
                        DdlAddLess.SelectedValue = ds.Tables[0].Rows[0]["cAddless"] != DBNull.Value ? ds.Tables[0].Rows[0]["cAddless"].ToString() : "+";
                        TxtPer.Text = ds.Tables[0].Rows[0]["nPer"] != DBNull.Value ? ds.Tables[0].Rows[0]["nPer"].ToString() : "0";
                        TxtRs.Text = ds.Tables[0].Rows[0]["nRs"] != DBNull.Value ? ds.Tables[0].Rows[0]["nRs"].ToString() : "0";
                        DDLCountBelow.SelectedValue = ds.Tables[0].Rows[0]["nCountOnTotal"] != DBNull.Value ? ds.Tables[0].Rows[0]["nCountOnTotal"].ToString() : "0";
                        DDLType.SelectedValue = ds.Tables[0].Rows[0]["cAccountType"] != DBNull.Value ? ds.Tables[0].Rows[0]["cAccountType"].ToString() : "";
                        //TxtDescription.Text = ds.Tables[0].Rows[0]["cDescription"] != DBNull.Value ? ds.Tables[0].Rows[0]["cDescription"].ToString() : "";

                    }

                }
                TxtDescription.Focus();

            }

            



        }
        catch (Exception ex)
        {

        }
    }
    protected void ImgBtnAdd_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            TxtPer.Text = TxtPer.Text == "" ? "0" : TxtPer.Text;
            TxtRs.Text = TxtRs.Text == "" ? "0" : TxtRs.Text;

            if (Request.QueryString["ID"] != null)
            {
                if (Request.QueryString["E"] != null)
                {
                    ds = cn.RunSql("sp_addMasterAddLess 'U','" + Request.QueryString["ID"].ToString() + "','" + TxtDescription.Text + "','" + TxtAccountName.Text + "','" + DdlAddLess.SelectedValue + "','" + TxtPer.Text + "','" + TxtRs.Text + "','" + DDLCountBelow.SelectedValue + "','3','" + DDLType.SelectedValue + "'", "Add");
                    Response.Redirect("TranAddLessPurchase.aspx");
                }
                //else if (Request.QueryString["D"] != null)
                //{
                //    ds = cn.RunSql("sp_addMasterAddLess 'D','" + Request.QueryString["ID"].ToString() + "','" + TxtDescription.Text + "','" + TxtAccountName.Text + "','" + DdlAddLess.SelectedValue + "','" + TxtPer.Text + "','" + TxtRs.Text + "','" + DDLCountBelow.SelectedValue + "','1'", "Add");
                //}
            }
            else
            {
                ds = cn.RunSql("sp_addMasterAddLess 'I','','" + TxtDescription.Text + "','" + TxtAccountName.Text + "','" + DdlAddLess.SelectedValue + "','" + TxtPer.Text + "','" + TxtRs.Text + "','" + DDLCountBelow.SelectedValue + "','3','" + DDLType.SelectedValue + "'", "Add");
                BindGrid();
                ClearChild();
            }
        }
        catch (Exception ex)
        {

        }
    }
    protected void BindGrid()
    {
        ds = cn.RunSql("sp_SearchAddLess 'Grid','','3'", "Search");
        GVaddless.DataSource = ds;
        GVaddless.DataBind();
        TxtDescription.Focus();
    }
    void ClearChild()
    {
        TxtDescription.Text = "";
        DdlAddLess.SelectedValue = "+";
        TxtPer.Text = "0";
        TxtRs.Text = "0";
        DDLCountBelow.SelectedValue = "0";
    }

    protected void ImgDelete1_Click(object sender, EventArgs e)
    {
        try
        {
            ImageButton imgbtn = (ImageButton)sender;
            GridViewRow row = (GridViewRow)imgbtn.NamingContainer;

            TxtPer.Text = TxtPer.Text == "" ? "0" : TxtPer.Text;
            TxtRs.Text = TxtRs.Text == "" ? "0" : TxtRs.Text;

            string cnid = "";
            string confirmval = "";
            confirmval = Request.Form["confirm_value"];
            if (confirmval == "Yes")
            {
                cnid = GVaddless.Rows[row.RowIndex].Cells[0].Text;
                ds = cn.RunSql("sp_addMasterAddLess 'D','" + cnid.ToString() + "','" + TxtDescription.Text + "','" + TxtAccountName.Text + "','" + DdlAddLess.SelectedValue + "','" + TxtPer.Text + "','" + TxtRs.Text + "','" + DDLCountBelow.SelectedValue + "','3','" + DDLType.SelectedValue + "'", "Add");
                Response.Redirect("TranAddLessPurchase.aspx");
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

}