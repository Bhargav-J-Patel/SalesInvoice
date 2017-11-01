using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Script.Serialization;
using App_Code;
using System.Data;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[System.Web.Script.Services.ScriptService]
public class ListPage : System.Web.Services.WebService
{

    public class myClass
    {
        

    }
    public class ListAll
    {
        public string ItemGroup;
        public string cedit;
        public string cdelete;
        public string nSize;
        public string cItem;
        public string cName;
        public string cCity;
        public string cConNo;
        public string cEmailID;
        public string dDate;
        public string nSrNo;
        public string cprint, GroupCode, GroupName;
        public string nVouchNo, dVochDate, cCashBank;

        public string BranchID = HttpContext.Current.Request.Cookies["BranchID"].Value.ToString();
        public string CompID = HttpContext.Current.Request.Cookies["CompID"].Value.ToString();
        public string AccYear = HttpContext.Current.Request.Cookies["AccYear"].Value.ToString();

        public string nGrossRs { get; set; }
        public string nNetRs { get; set; }
        public string cOtherDetail { get; set; }
    }
    [WebMethod]
    public void ListGroup(int iDisplayLength, int iDisplayStart, int iSortCol_0, string sSortDir_0, string sSearch)
    {
        int displayLength = iDisplayLength;
        int displayStart = iDisplayStart;
        int sortCol = iSortCol_0;
        string sortDir = sSortDir_0;
        string search = sSearch;


        ListAll cls2 = new ListAll();
        List<ListAll> myList = new List<ListAll>();



        int filteredCount = 0;
        DataSet DS = new DataSet();
        SqlInvoice CN = new SqlInvoice();

        DS = CN.RunSql("SP_ListMasterGroup '" + displayLength + "','" + displayStart + "','" + sortCol + "','" + sortDir + "','" + cls2.CompID + "','" + search + "'", "List");


        if (DS.Tables.Count > 0)
        {
            if (DS.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < DS.Tables[0].Rows.Count; i++)
                {
                    ListAll cls = new ListAll();

                    filteredCount = Convert.ToInt32(DS.Tables[0].Rows[i]["TotalCount"] != DBNull.Value ? DS.Tables[0].Rows[i]["TotalCount"].ToString() : "0");
                    cls.GroupCode = DS.Tables[0].Rows[i]["cGroupCode"] != DBNull.Value ? DS.Tables[0].Rows[i]["cGroupCode"].ToString() : "";
                    cls.GroupName = DS.Tables[0].Rows[i]["cGroupName"] != DBNull.Value ? DS.Tables[0].Rows[i]["cGroupName"].ToString() : "";
                    
                    cls.cedit = DS.Tables[0].Rows[i]["cedit"] != DBNull.Value ? DS.Tables[0].Rows[i]["cedit"].ToString() : "";
                    cls.cdelete = DS.Tables[0].Rows[i]["cdelete"] != DBNull.Value ? DS.Tables[0].Rows[i]["cdelete"].ToString() : "";

                    myList.Add(cls);
                }
            }
        }

        var result = new
        {
            iTotalRecords = GetTotalCount("ListGroup", ""),
            //iTotalRecords = 5000,
            iTotalDisplayRecords = filteredCount,
            aaData = myList
        };
        JavaScriptSerializer js = new JavaScriptSerializer();
        Context.Response.Write(js.Serialize(result));
    }
    [WebMethod]
    public void ListItemGroup(int iDisplayLength, int iDisplayStart, int iSortCol_0, string sSortDir_0, string sSearch)
    {
        int displayLength = iDisplayLength;
        int displayStart = iDisplayStart;
        int sortCol = iSortCol_0;
        string sortDir = sSortDir_0;
        string search = sSearch;


        ListAll cls2 = new ListAll();
        List<ListAll> myList = new List<ListAll>();



        int filteredCount = 0;
        DataSet DS = new DataSet();
        SqlInvoice CN = new SqlInvoice();

        DS = CN.RunSql("SP_ListMasterItemGroup '" + displayLength + "','" + displayStart + "','" + sortCol + "','" + sortDir + "','" + cls2.CompID + "','" + search + "'", "List");


        if (DS.Tables.Count > 0)
        {
            if (DS.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < DS.Tables[0].Rows.Count; i++)
                {
                    ListAll cls = new ListAll();

                    filteredCount = Convert.ToInt32(DS.Tables[0].Rows[i]["TotalCount"] != DBNull.Value ? DS.Tables[0].Rows[i]["TotalCount"].ToString() : "0");
                    cls.ItemGroup = DS.Tables[0].Rows[i]["cItemGroupName"] != DBNull.Value ? DS.Tables[0].Rows[i]["cItemGroupName"].ToString() : "";
                    cls.cedit = DS.Tables[0].Rows[i]["cedit"] != DBNull.Value ? DS.Tables[0].Rows[i]["cedit"].ToString() : "";
                    cls.cdelete = DS.Tables[0].Rows[i]["cdelete"] != DBNull.Value ? DS.Tables[0].Rows[i]["cdelete"].ToString() : "";

                    myList.Add(cls);
                }
            }
        }

        var result = new
        {
            iTotalRecords = GetTotalCount("ListItemGroup", ""),
            //iTotalRecords = 5000,
            iTotalDisplayRecords = filteredCount,
            aaData = myList
        };
        JavaScriptSerializer js = new JavaScriptSerializer();
        Context.Response.Write(js.Serialize(result));
    }
    [WebMethod]
    public void ListItem(int iDisplayLength, int iDisplayStart, int iSortCol_0, string sSortDir_0, string sSearch)
    {
        int displayLength = iDisplayLength;
        int displayStart = iDisplayStart;
        int sortCol = iSortCol_0;
        string sortDir = sSortDir_0;
        string search = sSearch;


        ListAll cls2 = new ListAll();
        List<ListAll> myList = new List<ListAll>();



        int filteredCount = 0;
        DataSet DS = new DataSet();
        SqlInvoice CN = new SqlInvoice();

        DS = CN.RunSql("SP_ListMasterItem '" + displayLength + "','" + displayStart + "','" + sortCol + "','" + sortDir + "','" + cls2.CompID + "','" + search + "'", "List");


        if (DS.Tables.Count > 0)
        {
            if (DS.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < DS.Tables[0].Rows.Count; i++)
                {
                    ListAll cls = new ListAll();

                    filteredCount = Convert.ToInt32(DS.Tables[0].Rows[i]["TotalCount"] != DBNull.Value ? DS.Tables[0].Rows[i]["TotalCount"].ToString() : "0");
                    cls.ItemGroup = DS.Tables[0].Rows[i]["cItemGroupName"] != DBNull.Value ? DS.Tables[0].Rows[i]["cItemGroupName"].ToString() : "";
                    cls.cItem = DS.Tables[0].Rows[i]["cItem"] != DBNull.Value ? DS.Tables[0].Rows[i]["cItem"].ToString() : "";
                    cls.nSize = DS.Tables[0].Rows[i]["nSize"] != DBNull.Value ? DS.Tables[0].Rows[i]["nSize"].ToString() : "";
                    cls.cedit = DS.Tables[0].Rows[i]["cedit"] != DBNull.Value ? DS.Tables[0].Rows[i]["cedit"].ToString() : "";
                    cls.cdelete = DS.Tables[0].Rows[i]["cdelete"] != DBNull.Value ? DS.Tables[0].Rows[i]["cdelete"].ToString() : "";

                    myList.Add(cls);
                }
            }
        }

        var result = new
        {
            iTotalRecords = GetTotalCount("ListItem", ""),
            //iTotalRecords = 5000,
            iTotalDisplayRecords = filteredCount,
            aaData = myList
        };
        JavaScriptSerializer js = new JavaScriptSerializer();
        Context.Response.Write(js.Serialize(result));
    }
    [WebMethod]
    public void ListSalesRetail(int iDisplayLength, int iDisplayStart, int iSortCol_0, string sSortDir_0, string sSearch)
    {
        int displayLength = iDisplayLength;
        int displayStart = iDisplayStart;
        int sortCol = iSortCol_0;
        string sortDir = sSortDir_0;
        string search = sSearch;


        ListAll cls2 = new ListAll();
        List<ListAll> myList = new List<ListAll>();



        int filteredCount = 0;
        DataSet DS = new DataSet();
        SqlInvoice CN = new SqlInvoice();

        
        DS = CN.RunSql("SP_ListTranSalesRetail '" + displayLength + "','" + displayStart + "','" + sortCol + "','" + sortDir + "','" + search + "','" + HttpContext.Current.Request.Cookies["AccYear"].Value + "'", "List");


        if (DS.Tables.Count > 0)
        {
            if (DS.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < DS.Tables[0].Rows.Count; i++)
                {
                    ListAll cls = new ListAll();

                    filteredCount = Convert.ToInt32(DS.Tables[0].Rows[i]["TotalCount"] != DBNull.Value ? DS.Tables[0].Rows[i]["TotalCount"].ToString() : "0");
                    cls.nSrNo = DS.Tables[0].Rows[i]["nSrNo"] != DBNull.Value ? DS.Tables[0].Rows[i]["nSrNo"].ToString() : "";
                    cls.dDate = DS.Tables[0].Rows[i]["dDate"] != DBNull.Value ? DS.Tables[0].Rows[i]["dDate"].ToString() : "";
                    cls.cName = DS.Tables[0].Rows[i]["cName"] != DBNull.Value ? DS.Tables[0].Rows[i]["cName"].ToString() : "";
                    cls.nGrossRs = DS.Tables[0].Rows[i]["nGrossRs"] != DBNull.Value ? DS.Tables[0].Rows[i]["nGrossRs"].ToString() : "";
                    cls.nNetRs = DS.Tables[0].Rows[i]["nNetRs"] != DBNull.Value ? DS.Tables[0].Rows[i]["nNetRs"].ToString() : "";
                    cls.cedit = DS.Tables[0].Rows[i]["cedit"] != DBNull.Value ? DS.Tables[0].Rows[i]["cedit"].ToString() : "";
                    cls.cdelete = DS.Tables[0].Rows[i]["cdelete"] != DBNull.Value ? DS.Tables[0].Rows[i]["cdelete"].ToString() : "";
                    cls.cprint = DS.Tables[0].Rows[i]["cprint"] != DBNull.Value ? DS.Tables[0].Rows[i]["cprint"].ToString() : "";

                    myList.Add(cls);
                }
            }
        }

        var result = new
        {
            iTotalRecords = GetTotalCount("SalesRetail", ""),
            //iTotalRecords = 5000,
            iTotalDisplayRecords = filteredCount,
            aaData = myList
        };
        JavaScriptSerializer js = new JavaScriptSerializer();
        Context.Response.Write(js.Serialize(result));
    }
    [WebMethod]
    public void ListSalesTax(int iDisplayLength, int iDisplayStart, int iSortCol_0, string sSortDir_0, string sSearch)
    {
        int displayLength = iDisplayLength;
        int displayStart = iDisplayStart;
        int sortCol = iSortCol_0;
        string sortDir = sSortDir_0;
        string search = sSearch;


        ListAll cls2 = new ListAll();
        List<ListAll> myList = new List<ListAll>();



        int filteredCount = 0;
        DataSet DS = new DataSet();
        SqlInvoice CN = new SqlInvoice();

        DS = CN.RunSql("SP_ListTranSalesTax '" + displayLength + "','" + displayStart + "','" + sortCol + "','" + sortDir + "','" + search + "','"+ HttpContext.Current.Request.Cookies["AccYear"].Value  +"'", "List");


        if (DS.Tables.Count > 0)
        {
            if (DS.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < DS.Tables[0].Rows.Count; i++)
                {
                    ListAll cls = new ListAll();

                    filteredCount = Convert.ToInt32(DS.Tables[0].Rows[i]["TotalCount"] != DBNull.Value ? DS.Tables[0].Rows[i]["TotalCount"].ToString() : "0");
                    cls.nSrNo = DS.Tables[0].Rows[i]["nSrNo"] != DBNull.Value ? DS.Tables[0].Rows[i]["nSrNo"].ToString() : "";
                    cls.dDate = DS.Tables[0].Rows[i]["dDate"] != DBNull.Value ? DS.Tables[0].Rows[i]["dDate"].ToString() : "";
                    cls.cName = DS.Tables[0].Rows[i]["cName"] != DBNull.Value ? DS.Tables[0].Rows[i]["cName"].ToString() : "";
                    cls.nGrossRs = DS.Tables[0].Rows[i]["nGrossRs"] != DBNull.Value ? DS.Tables[0].Rows[i]["nGrossRs"].ToString() : "";
                    cls.nNetRs = DS.Tables[0].Rows[i]["nNetRs"] != DBNull.Value ? DS.Tables[0].Rows[i]["nNetRs"].ToString() : "";
                    cls.cedit = DS.Tables[0].Rows[i]["cedit"] != DBNull.Value ? DS.Tables[0].Rows[i]["cedit"].ToString() : "";
                    cls.cdelete = DS.Tables[0].Rows[i]["cdelete"] != DBNull.Value ? DS.Tables[0].Rows[i]["cdelete"].ToString() : "";
                    cls.cprint = DS.Tables[0].Rows[i]["cprint"] != DBNull.Value ? DS.Tables[0].Rows[i]["cprint"].ToString() : "";

                    myList.Add(cls);
                }
            }
        }

        var result = new
        {
            iTotalRecords = GetTotalCount("SalesTax", ""),
            //iTotalRecords = 5000,
            iTotalDisplayRecords = filteredCount,
            aaData = myList
        };
        JavaScriptSerializer js = new JavaScriptSerializer();
        Context.Response.Write(js.Serialize(result));
    }
    [WebMethod]
    public void ListSalesTaxReturn(int iDisplayLength, int iDisplayStart, int iSortCol_0, string sSortDir_0, string sSearch)
    {
        int displayLength = iDisplayLength;
        int displayStart = iDisplayStart;
        int sortCol = iSortCol_0;
        string sortDir = sSortDir_0;
        string search = sSearch;


        ListAll cls2 = new ListAll();
        List<ListAll> myList = new List<ListAll>();



        int filteredCount = 0;
        DataSet DS = new DataSet();
        SqlInvoice CN = new SqlInvoice();

        DS = CN.RunSql("SP_ListTranSalesTaxReturn '" + displayLength + "','" + displayStart + "','" + sortCol + "','" + sortDir + "','" + search + "','" + HttpContext.Current.Request.Cookies["AccYear"].Value + "'", "List");


        if (DS.Tables.Count > 0)
        {
            if (DS.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < DS.Tables[0].Rows.Count; i++)
                {
                    ListAll cls = new ListAll();

                    filteredCount = Convert.ToInt32(DS.Tables[0].Rows[i]["TotalCount"] != DBNull.Value ? DS.Tables[0].Rows[i]["TotalCount"].ToString() : "0");
                    cls.nSrNo = DS.Tables[0].Rows[i]["nSrNo"] != DBNull.Value ? DS.Tables[0].Rows[i]["nSrNo"].ToString() : "";
                    cls.dDate = DS.Tables[0].Rows[i]["dDate"] != DBNull.Value ? DS.Tables[0].Rows[i]["dDate"].ToString() : "";
                    cls.cName = DS.Tables[0].Rows[i]["cName"] != DBNull.Value ? DS.Tables[0].Rows[i]["cName"].ToString() : "";
                    cls.nGrossRs = DS.Tables[0].Rows[i]["nGrossRs"] != DBNull.Value ? DS.Tables[0].Rows[i]["nGrossRs"].ToString() : "";
                    cls.nNetRs = DS.Tables[0].Rows[i]["nNetRs"] != DBNull.Value ? DS.Tables[0].Rows[i]["nNetRs"].ToString() : "";
                    cls.cedit = DS.Tables[0].Rows[i]["cedit"] != DBNull.Value ? DS.Tables[0].Rows[i]["cedit"].ToString() : "";
                    cls.cdelete = DS.Tables[0].Rows[i]["cdelete"] != DBNull.Value ? DS.Tables[0].Rows[i]["cdelete"].ToString() : "";
                    cls.cprint = DS.Tables[0].Rows[i]["cprint"] != DBNull.Value ? DS.Tables[0].Rows[i]["cprint"].ToString() : "";

                    myList.Add(cls);
                }
            }
        }

        var result = new
        {
            iTotalRecords = GetTotalCount("SalesTaxReturn", ""),
            //iTotalRecords = 5000,
            iTotalDisplayRecords = filteredCount,
            aaData = myList
        };
        JavaScriptSerializer js = new JavaScriptSerializer();
        Context.Response.Write(js.Serialize(result));
    }
    [WebMethod]
    public void ListSalesRetailReturn(int iDisplayLength, int iDisplayStart, int iSortCol_0, string sSortDir_0, string sSearch)
    {
        int displayLength = iDisplayLength;
        int displayStart = iDisplayStart;
        int sortCol = iSortCol_0;
        string sortDir = sSortDir_0;
        string search = sSearch;


        ListAll cls2 = new ListAll();
        List<ListAll> myList = new List<ListAll>();



        int filteredCount = 0;
        DataSet DS = new DataSet();
        SqlInvoice CN = new SqlInvoice();

        DS = CN.RunSql("SP_ListTranSalesRetailReturn '" + displayLength + "','" + displayStart + "','" + sortCol + "','" + sortDir + "','" + search + "','" + HttpContext.Current.Request.Cookies["AccYear"].Value + "'", "List");


        if (DS.Tables.Count > 0)
        {
            if (DS.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < DS.Tables[0].Rows.Count; i++)
                {
                    ListAll cls = new ListAll();

                    filteredCount = Convert.ToInt32(DS.Tables[0].Rows[i]["TotalCount"] != DBNull.Value ? DS.Tables[0].Rows[i]["TotalCount"].ToString() : "0");
                    cls.nSrNo = DS.Tables[0].Rows[i]["nSrNo"] != DBNull.Value ? DS.Tables[0].Rows[i]["nSrNo"].ToString() : "";
                    cls.dDate = DS.Tables[0].Rows[i]["dDate"] != DBNull.Value ? DS.Tables[0].Rows[i]["dDate"].ToString() : "";
                    cls.cName = DS.Tables[0].Rows[i]["cName"] != DBNull.Value ? DS.Tables[0].Rows[i]["cName"].ToString() : "";
                    cls.nGrossRs = DS.Tables[0].Rows[i]["nGrossRs"] != DBNull.Value ? DS.Tables[0].Rows[i]["nGrossRs"].ToString() : "";
                    cls.nNetRs = DS.Tables[0].Rows[i]["nNetRs"] != DBNull.Value ? DS.Tables[0].Rows[i]["nNetRs"].ToString() : "";
                    cls.cedit = DS.Tables[0].Rows[i]["cedit"] != DBNull.Value ? DS.Tables[0].Rows[i]["cedit"].ToString() : "";
                    cls.cdelete = DS.Tables[0].Rows[i]["cdelete"] != DBNull.Value ? DS.Tables[0].Rows[i]["cdelete"].ToString() : "";
                    cls.cprint = DS.Tables[0].Rows[i]["cprint"] != DBNull.Value ? DS.Tables[0].Rows[i]["cprint"].ToString() : "";

                    myList.Add(cls);
                }
            }
        }

        var result = new
        {
            iTotalRecords = GetTotalCount("SalesRetailReturn", ""),
            //iTotalRecords = 5000,
            iTotalDisplayRecords = filteredCount,
            aaData = myList
        };
        JavaScriptSerializer js = new JavaScriptSerializer();
        Context.Response.Write(js.Serialize(result));
    }
    [WebMethod]
    public void ListPurchase(int iDisplayLength, int iDisplayStart, int iSortCol_0, string sSortDir_0, string sSearch)
    {
        int displayLength = iDisplayLength;
        int displayStart = iDisplayStart;
        int sortCol = iSortCol_0;
        string sortDir = sSortDir_0;
        string search = sSearch;


        ListAll cls2 = new ListAll();
        List<ListAll> myList = new List<ListAll>();



        int filteredCount = 0;
        DataSet DS = new DataSet();
        SqlInvoice CN = new SqlInvoice();

        DS = CN.RunSql("SP_ListTranPurchase '" + displayLength + "','" + displayStart + "','" + sortCol + "','" + sortDir + "','" + search + "','" + HttpContext.Current.Request.Cookies["AccYear"].Value + "'", "List");


        if (DS.Tables.Count > 0)
        {
            if (DS.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < DS.Tables[0].Rows.Count; i++)
                {
                    ListAll cls = new ListAll();

                    filteredCount = Convert.ToInt32(DS.Tables[0].Rows[i]["TotalCount"] != DBNull.Value ? DS.Tables[0].Rows[i]["TotalCount"].ToString() : "0");
                    cls.nSrNo = DS.Tables[0].Rows[i]["nSrNo"] != DBNull.Value ? DS.Tables[0].Rows[i]["nSrNo"].ToString() : "";
                    cls.dDate = DS.Tables[0].Rows[i]["dDate"] != DBNull.Value ? DS.Tables[0].Rows[i]["dDate"].ToString() : "";
                    cls.cName = DS.Tables[0].Rows[i]["cName"] != DBNull.Value ? DS.Tables[0].Rows[i]["cName"].ToString() : "";
                    cls.nGrossRs = DS.Tables[0].Rows[i]["nGrossRs"] != DBNull.Value ? DS.Tables[0].Rows[i]["nGrossRs"].ToString() : "";
                    cls.nNetRs = DS.Tables[0].Rows[i]["nNetRs"] != DBNull.Value ? DS.Tables[0].Rows[i]["nNetRs"].ToString() : "";
                    cls.cedit = DS.Tables[0].Rows[i]["cedit"] != DBNull.Value ? DS.Tables[0].Rows[i]["cedit"].ToString() : "";
                    cls.cdelete = DS.Tables[0].Rows[i]["cdelete"] != DBNull.Value ? DS.Tables[0].Rows[i]["cdelete"].ToString() : "";
                    cls.cprint = DS.Tables[0].Rows[i]["cprint"] != DBNull.Value ? DS.Tables[0].Rows[i]["cprint"].ToString() : "";

                    myList.Add(cls);
                }
            }
        }

        var result = new
        {
            iTotalRecords = GetTotalCount("Purchase", ""),
            //iTotalRecords = 5000,
            iTotalDisplayRecords = filteredCount,
            aaData = myList
        };
        JavaScriptSerializer js = new JavaScriptSerializer();
        Context.Response.Write(js.Serialize(result));
    }
    [WebMethod]
    public void ListPurchaseInclude(int iDisplayLength, int iDisplayStart, int iSortCol_0, string sSortDir_0, string sSearch)
    {
        int displayLength = iDisplayLength;
        int displayStart = iDisplayStart;
        int sortCol = iSortCol_0;
        string sortDir = sSortDir_0;
        string search = sSearch;


        ListAll cls2 = new ListAll();
        List<ListAll> myList = new List<ListAll>();



        int filteredCount = 0;
        DataSet DS = new DataSet();
        SqlInvoice CN = new SqlInvoice();

        DS = CN.RunSql("SP_ListTranPurchaseInclude '" + displayLength + "','" + displayStart + "','" + sortCol + "','" + sortDir + "','" + search + "','" + HttpContext.Current.Request.Cookies["AccYear"].Value + "'", "List");


        if (DS.Tables.Count > 0)
        {
            if (DS.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < DS.Tables[0].Rows.Count; i++)
                {
                    ListAll cls = new ListAll();

                    filteredCount = Convert.ToInt32(DS.Tables[0].Rows[i]["TotalCount"] != DBNull.Value ? DS.Tables[0].Rows[i]["TotalCount"].ToString() : "0");
                    cls.nSrNo = DS.Tables[0].Rows[i]["nSrNo"] != DBNull.Value ? DS.Tables[0].Rows[i]["nSrNo"].ToString() : "";
                    cls.dDate = DS.Tables[0].Rows[i]["dDate"] != DBNull.Value ? DS.Tables[0].Rows[i]["dDate"].ToString() : "";
                    cls.cName = DS.Tables[0].Rows[i]["cName"] != DBNull.Value ? DS.Tables[0].Rows[i]["cName"].ToString() : "";
                    cls.nGrossRs = DS.Tables[0].Rows[i]["nGrossRs"] != DBNull.Value ? DS.Tables[0].Rows[i]["nGrossRs"].ToString() : "";
                    cls.nNetRs = DS.Tables[0].Rows[i]["nNetRs"] != DBNull.Value ? DS.Tables[0].Rows[i]["nNetRs"].ToString() : "";
                    cls.cedit = DS.Tables[0].Rows[i]["cedit"] != DBNull.Value ? DS.Tables[0].Rows[i]["cedit"].ToString() : "";
                    cls.cdelete = DS.Tables[0].Rows[i]["cdelete"] != DBNull.Value ? DS.Tables[0].Rows[i]["cdelete"].ToString() : "";
                    cls.cprint = DS.Tables[0].Rows[i]["cprint"] != DBNull.Value ? DS.Tables[0].Rows[i]["cprint"].ToString() : "";

                    myList.Add(cls);
                }
            }
        }

        var result = new
        {
            iTotalRecords = GetTotalCount("PurchaseInclude", ""),
            //iTotalRecords = 5000,
            iTotalDisplayRecords = filteredCount,
            aaData = myList
        };
        JavaScriptSerializer js = new JavaScriptSerializer();
        Context.Response.Write(js.Serialize(result));
    }
    [WebMethod]
    public void ListPurchaseReturnInclude(int iDisplayLength, int iDisplayStart, int iSortCol_0, string sSortDir_0, string sSearch)
    {
        int displayLength = iDisplayLength;
        int displayStart = iDisplayStart;
        int sortCol = iSortCol_0;
        string sortDir = sSortDir_0;
        string search = sSearch;


        ListAll cls2 = new ListAll();
        List<ListAll> myList = new List<ListAll>();



        int filteredCount = 0;
        DataSet DS = new DataSet();
        SqlInvoice CN = new SqlInvoice();

        DS = CN.RunSql("SP_ListTranPurchaseReturnInclude '" + displayLength + "','" + displayStart + "','" + sortCol + "','" + sortDir + "','" + search + "','" + HttpContext.Current.Request.Cookies["AccYear"].Value + "'", "List");


        if (DS.Tables.Count > 0)
        {
            if (DS.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < DS.Tables[0].Rows.Count; i++)
                {
                    ListAll cls = new ListAll();

                    filteredCount = Convert.ToInt32(DS.Tables[0].Rows[i]["TotalCount"] != DBNull.Value ? DS.Tables[0].Rows[i]["TotalCount"].ToString() : "0");
                    cls.nSrNo = DS.Tables[0].Rows[i]["nSrNo"] != DBNull.Value ? DS.Tables[0].Rows[i]["nSrNo"].ToString() : "";
                    cls.dDate = DS.Tables[0].Rows[i]["dDate"] != DBNull.Value ? DS.Tables[0].Rows[i]["dDate"].ToString() : "";
                    cls.cName = DS.Tables[0].Rows[i]["cName"] != DBNull.Value ? DS.Tables[0].Rows[i]["cName"].ToString() : "";
                    cls.nGrossRs = DS.Tables[0].Rows[i]["nGrossRs"] != DBNull.Value ? DS.Tables[0].Rows[i]["nGrossRs"].ToString() : "";
                    cls.nNetRs = DS.Tables[0].Rows[i]["nNetRs"] != DBNull.Value ? DS.Tables[0].Rows[i]["nNetRs"].ToString() : "";
                    cls.cedit = DS.Tables[0].Rows[i]["cedit"] != DBNull.Value ? DS.Tables[0].Rows[i]["cedit"].ToString() : "";
                    cls.cdelete = DS.Tables[0].Rows[i]["cdelete"] != DBNull.Value ? DS.Tables[0].Rows[i]["cdelete"].ToString() : "";
                    cls.cprint = DS.Tables[0].Rows[i]["cprint"] != DBNull.Value ? DS.Tables[0].Rows[i]["cprint"].ToString() : "";

                    myList.Add(cls);
                }
            }
        }

        var result = new
        {
            iTotalRecords = GetTotalCount("PurchaseReturnInclude", ""),
            //iTotalRecords = 5000,
            iTotalDisplayRecords = filteredCount,
            aaData = myList
        };
        JavaScriptSerializer js = new JavaScriptSerializer();
        Context.Response.Write(js.Serialize(result));
    }

    [WebMethod]
    public void ListPurchaseReturn(int iDisplayLength, int iDisplayStart, int iSortCol_0, string sSortDir_0, string sSearch)
    {
        int displayLength = iDisplayLength;
        int displayStart = iDisplayStart;
        int sortCol = iSortCol_0;
        string sortDir = sSortDir_0;
        string search = sSearch;


        ListAll cls2 = new ListAll();
        List<ListAll> myList = new List<ListAll>();



        int filteredCount = 0;
        DataSet DS = new DataSet();
        SqlInvoice CN = new SqlInvoice();

        DS = CN.RunSql("SP_ListTranPurchaseReturn '" + displayLength + "','" + displayStart + "','" + sortCol + "','" + sortDir + "','" + search + "','" + HttpContext.Current.Request.Cookies["AccYear"].Value + "'", "List");


        if (DS.Tables.Count > 0)
        {
            if (DS.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < DS.Tables[0].Rows.Count; i++)
                {
                    ListAll cls = new ListAll();

                    filteredCount = Convert.ToInt32(DS.Tables[0].Rows[i]["TotalCount"] != DBNull.Value ? DS.Tables[0].Rows[i]["TotalCount"].ToString() : "0");
                    cls.nSrNo = DS.Tables[0].Rows[i]["nSrNo"] != DBNull.Value ? DS.Tables[0].Rows[i]["nSrNo"].ToString() : "";
                    cls.dDate = DS.Tables[0].Rows[i]["dDate"] != DBNull.Value ? DS.Tables[0].Rows[i]["dDate"].ToString() : "";
                    cls.cName = DS.Tables[0].Rows[i]["cName"] != DBNull.Value ? DS.Tables[0].Rows[i]["cName"].ToString() : "";
                    cls.nGrossRs = DS.Tables[0].Rows[i]["nGrossRs"] != DBNull.Value ? DS.Tables[0].Rows[i]["nGrossRs"].ToString() : "";
                    cls.nNetRs = DS.Tables[0].Rows[i]["nNetRs"] != DBNull.Value ? DS.Tables[0].Rows[i]["nNetRs"].ToString() : "";
                    cls.cedit = DS.Tables[0].Rows[i]["cedit"] != DBNull.Value ? DS.Tables[0].Rows[i]["cedit"].ToString() : "";
                    cls.cdelete = DS.Tables[0].Rows[i]["cdelete"] != DBNull.Value ? DS.Tables[0].Rows[i]["cdelete"].ToString() : "";
                    cls.cprint = DS.Tables[0].Rows[i]["cprint"] != DBNull.Value ? DS.Tables[0].Rows[i]["cprint"].ToString() : "";

                    myList.Add(cls);
                }
            }
        }

        var result = new
        {
            iTotalRecords = GetTotalCount("PurchaseReturn", ""),
            //iTotalRecords = 5000,
            iTotalDisplayRecords = filteredCount,
            aaData = myList
        };
        JavaScriptSerializer js = new JavaScriptSerializer();
        Context.Response.Write(js.Serialize(result));
    }

    [WebMethod]
    public void ListCustomer(int iDisplayLength, int iDisplayStart, int iSortCol_0, string sSortDir_0, string sSearch)
    {
        int displayLength = iDisplayLength;
        int displayStart = iDisplayStart;
        int sortCol = iSortCol_0;
        string sortDir = sSortDir_0;
        string search = sSearch;


        ListAll cls2 = new ListAll();
        List<ListAll> myList = new List<ListAll>();



        int filteredCount = 0;
        DataSet DS = new DataSet();
        SqlInvoice CN = new SqlInvoice();

        DS = CN.RunSql("SP_ListMasterCustomer '" + displayLength + "','" + displayStart + "','" + sortCol + "','" + sortDir + "','"+ cls2.CompID +"','" + search + "'", "List");


        if (DS.Tables.Count > 0)
        {
            if (DS.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < DS.Tables[0].Rows.Count; i++)
                {
                    ListAll cls = new ListAll();

                    filteredCount = Convert.ToInt32(DS.Tables[0].Rows[i]["TotalCount"] != DBNull.Value ? DS.Tables[0].Rows[i]["TotalCount"].ToString() : "0");
                    cls.cName = DS.Tables[0].Rows[i]["cName"] != DBNull.Value ? DS.Tables[0].Rows[i]["cName"].ToString() : "";
                    cls.cCity = DS.Tables[0].Rows[i]["cCity"] != DBNull.Value ? DS.Tables[0].Rows[i]["cCity"].ToString() : "";
                    cls.cConNo = DS.Tables[0].Rows[i]["cConNo"] != DBNull.Value ? DS.Tables[0].Rows[i]["cConNo"].ToString() : "";
                    cls.cOtherDetail = DS.Tables[0].Rows[i]["cOtherDetail"] != DBNull.Value ? DS.Tables[0].Rows[i]["cOtherDetail"].ToString() : "";
                    cls.cedit = DS.Tables[0].Rows[i]["cedit"] != DBNull.Value ? DS.Tables[0].Rows[i]["cedit"].ToString() : "";
                    cls.cdelete = DS.Tables[0].Rows[i]["cdelete"] != DBNull.Value ? DS.Tables[0].Rows[i]["cdelete"].ToString() : "";

                    myList.Add(cls);
                }
            }
        }

        var result = new
        {
            iTotalRecords = GetTotalCount("ListCustomer", ""),
            //iTotalRecords = 5000,
            iTotalDisplayRecords = filteredCount,
            aaData = myList
        };
        JavaScriptSerializer js = new JavaScriptSerializer();
        Context.Response.Write(js.Serialize(result));
    }


    [WebMethod]
    public void ListAccount(int iDisplayLength, int iDisplayStart, int iSortCol_0, string sSortDir_0, string sSearch)
    {
        int displayLength = iDisplayLength;
        int displayStart = iDisplayStart;
        int sortCol = iSortCol_0;
        string sortDir = sSortDir_0;
        string search = sSearch;


        ListAll cls2 = new ListAll();
        List<ListAll> myList = new List<ListAll>();



        int filteredCount = 0;
        DataSet DS = new DataSet();
        SqlInvoice CN = new SqlInvoice();

        DS = CN.RunSql("SP_ListMasterAccount '" + displayLength + "','" + displayStart + "','" + sortCol + "','" + sortDir + "','" + cls2.CompID + "','" + search + "'", "List");


        if (DS.Tables.Count > 0)
        {
            if (DS.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < DS.Tables[0].Rows.Count; i++)
                {
                    ListAll cls = new ListAll();

                    filteredCount = Convert.ToInt32(DS.Tables[0].Rows[i]["TotalCount"] != DBNull.Value ? DS.Tables[0].Rows[i]["TotalCount"].ToString() : "0");
                    cls.cName = DS.Tables[0].Rows[i]["cName"] != DBNull.Value ? DS.Tables[0].Rows[i]["cName"].ToString() : "";
                    cls.cCity = DS.Tables[0].Rows[i]["cCity"] != DBNull.Value ? DS.Tables[0].Rows[i]["cCity"].ToString() : "";
                    cls.cConNo = DS.Tables[0].Rows[i]["cConNo"] != DBNull.Value ? DS.Tables[0].Rows[i]["cConNo"].ToString() : "";
                    cls.cOtherDetail = DS.Tables[0].Rows[i]["cOtherDetail"] != DBNull.Value ? DS.Tables[0].Rows[i]["cOtherDetail"].ToString() : "";
                    cls.cedit = DS.Tables[0].Rows[i]["cedit"] != DBNull.Value ? DS.Tables[0].Rows[i]["cedit"].ToString() : "";
                    cls.cdelete = DS.Tables[0].Rows[i]["cdelete"] != DBNull.Value ? DS.Tables[0].Rows[i]["cdelete"].ToString() : "";

                    myList.Add(cls);
                }
            }
        }

        var result = new
        {
            iTotalRecords = GetTotalCount("ListAccount", ""),
            //iTotalRecords = 5000,
            iTotalDisplayRecords = filteredCount,
            aaData = myList
        };
        JavaScriptSerializer js = new JavaScriptSerializer();
        Context.Response.Write(js.Serialize(result));
    }

    [WebMethod]
    public void ListSupplier(int iDisplayLength, int iDisplayStart, int iSortCol_0, string sSortDir_0, string sSearch)
    {
        int displayLength = iDisplayLength;
        int displayStart = iDisplayStart;
        int sortCol = iSortCol_0;
        string sortDir = sSortDir_0;
        string search = sSearch;


        ListAll cls2 = new ListAll();
        List<ListAll> myList = new List<ListAll>();



        int filteredCount = 0;
        DataSet DS = new DataSet();
        SqlInvoice CN = new SqlInvoice();

        DS = CN.RunSql("SP_ListMasterSupplier '" + displayLength + "','" + displayStart + "','" + sortCol + "','" + sortDir + "','" + cls2.CompID + "','" + search + "'", "List");


        if (DS.Tables.Count > 0)
        {
            if (DS.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < DS.Tables[0].Rows.Count; i++)
                {
                    ListAll cls = new ListAll();

                    filteredCount = Convert.ToInt32(DS.Tables[0].Rows[i]["TotalCount"] != DBNull.Value ? DS.Tables[0].Rows[i]["TotalCount"].ToString() : "0");
                    cls.cName = DS.Tables[0].Rows[i]["cName"] != DBNull.Value ? DS.Tables[0].Rows[i]["cName"].ToString() : "";
                    cls.cCity = DS.Tables[0].Rows[i]["cCity"] != DBNull.Value ? DS.Tables[0].Rows[i]["cCity"].ToString() : "";
                    cls.cConNo = DS.Tables[0].Rows[i]["cConNo"] != DBNull.Value ? DS.Tables[0].Rows[i]["cConNo"].ToString() : "";
                    cls.cOtherDetail = DS.Tables[0].Rows[i]["cOtherDetail"] != DBNull.Value ? DS.Tables[0].Rows[i]["cOtherDetail"].ToString() : "";
                    cls.cedit = DS.Tables[0].Rows[i]["cedit"] != DBNull.Value ? DS.Tables[0].Rows[i]["cedit"].ToString() : "";
                    cls.cdelete = DS.Tables[0].Rows[i]["cdelete"] != DBNull.Value ? DS.Tables[0].Rows[i]["cdelete"].ToString() : "";

                    myList.Add(cls);
                }
            }
        }

        var result = new
        {
            iTotalRecords = GetTotalCount("ListSupplier", ""),
            //iTotalRecords = 5000,
            iTotalDisplayRecords = filteredCount,
            aaData = myList
        };
        JavaScriptSerializer js = new JavaScriptSerializer();
        Context.Response.Write(js.Serialize(result));
    }
    [WebMethod]
    public void ListStock(int iDisplayLength, int iDisplayStart, int iSortCol_0, string sSortDir_0, string sSearch)
    {
        int displayLength = iDisplayLength;
        int displayStart = iDisplayStart;
        int sortCol = iSortCol_0;
        string sortDir = sSortDir_0;
        string search = sSearch;


        ListAll cls2 = new ListAll();
        List<ListAll> myList = new List<ListAll>();



        int filteredCount = 0;
        DataSet DS = new DataSet();
        SqlInvoice CN = new SqlInvoice();

        DS = CN.RunSql("SP_ListTranStock '" + displayLength + "','" + displayStart + "','" + sortCol + "','" + sortDir + "','" + search + "'", "List");


        if (DS.Tables.Count > 0)
        {
            if (DS.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < DS.Tables[0].Rows.Count; i++)
                {
                    ListAll cls = new ListAll();

                    filteredCount = Convert.ToInt32(DS.Tables[0].Rows[i]["TotalCount"] != DBNull.Value ? DS.Tables[0].Rows[i]["TotalCount"].ToString() : "0");
                    cls.nSrNo = DS.Tables[0].Rows[i]["nSrNo"] != DBNull.Value ? DS.Tables[0].Rows[i]["nSrNo"].ToString() : "";
                    cls.dDate = DS.Tables[0].Rows[i]["dDate"] != DBNull.Value ? DS.Tables[0].Rows[i]["dDate"].ToString() : "";
                    cls.cedit = DS.Tables[0].Rows[i]["cedit"] != DBNull.Value ? DS.Tables[0].Rows[i]["cedit"].ToString() : "";
                    cls.cdelete = DS.Tables[0].Rows[i]["cdelete"] != DBNull.Value ? DS.Tables[0].Rows[i]["cdelete"].ToString() : "";
                   

                    myList.Add(cls);
                }
            }
        }

        var result = new
        {
            iTotalRecords = GetTotalCount("Stock", ""),
            //iTotalRecords = 5000,
            iTotalDisplayRecords = filteredCount,
            aaData = myList
        };
        JavaScriptSerializer js = new JavaScriptSerializer();
        Context.Response.Write(js.Serialize(result));
    }
    [WebMethod]
    public void ListUsingStock(int iDisplayLength, int iDisplayStart, int iSortCol_0, string sSortDir_0, string sSearch)
    {
        int displayLength = iDisplayLength;
        int displayStart = iDisplayStart;
        int sortCol = iSortCol_0;
        string sortDir = sSortDir_0;
        string search = sSearch;


        ListAll cls2 = new ListAll();
        List<ListAll> myList = new List<ListAll>();



        int filteredCount = 0;
        DataSet DS = new DataSet();
        SqlInvoice CN = new SqlInvoice();

        DS = CN.RunSql("SP_ListTranUsingStock '" + displayLength + "','" + displayStart + "','" + sortCol + "','" + sortDir + "','" + search + "'", "List");


        if (DS.Tables.Count > 0)
        {
            if (DS.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < DS.Tables[0].Rows.Count; i++)
                {
                    ListAll cls = new ListAll();

                    filteredCount = Convert.ToInt32(DS.Tables[0].Rows[i]["TotalCount"] != DBNull.Value ? DS.Tables[0].Rows[i]["TotalCount"].ToString() : "0");
                    cls.nSrNo = DS.Tables[0].Rows[i]["nSrNo"] != DBNull.Value ? DS.Tables[0].Rows[i]["nSrNo"].ToString() : "";
                    cls.dDate = DS.Tables[0].Rows[i]["dDate"] != DBNull.Value ? DS.Tables[0].Rows[i]["dDate"].ToString() : "";
                    cls.cedit = DS.Tables[0].Rows[i]["cedit"] != DBNull.Value ? DS.Tables[0].Rows[i]["cedit"].ToString() : "";
                    cls.cdelete = DS.Tables[0].Rows[i]["cdelete"] != DBNull.Value ? DS.Tables[0].Rows[i]["cdelete"].ToString() : "";


                    myList.Add(cls);
                }
            }
        }

        var result = new
        {
            iTotalRecords = GetTotalCount("Stock", ""),
            //iTotalRecords = 5000,
            iTotalDisplayRecords = filteredCount,
            aaData = myList
        };
        JavaScriptSerializer js = new JavaScriptSerializer();
        Context.Response.Write(js.Serialize(result));
    }

    [WebMethod]
    public void ListReceipt(int iDisplayLength, int iDisplayStart, int iSortCol_0, string sSortDir_0, string sSearch)
    {
        int displayLength = iDisplayLength;
        int displayStart = iDisplayStart;
        int sortCol = iSortCol_0;
        string sortDir = sSortDir_0;
        string search = sSearch;


        ListAll cls2 = new ListAll();
        List<ListAll> myList = new List<ListAll>();



        int filteredCount = 0;
        DataSet DS = new DataSet();
        SqlInvoice CN = new SqlInvoice();

        DS = CN.RunSql("SP_ListTranReceipt '" + displayLength + "','" + displayStart + "','" + sortCol + "','" + sortDir + "','" + cls2.CompID + "','" + search + "'", "List");


        if (DS.Tables.Count > 0)
        {
            if (DS.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < DS.Tables[0].Rows.Count; i++)
                {
                    ListAll cls = new ListAll();

                    filteredCount = Convert.ToInt32(DS.Tables[0].Rows[i]["TotalCount"] != DBNull.Value ? DS.Tables[0].Rows[i]["TotalCount"].ToString() : "0");
                    cls.nVouchNo = DS.Tables[0].Rows[i]["nVouchNo"] != DBNull.Value ? DS.Tables[0].Rows[i]["nVouchNo"].ToString() : "";
                    cls.dVochDate = DS.Tables[0].Rows[i]["dVochDate"] != DBNull.Value ? DS.Tables[0].Rows[i]["dVochDate"].ToString() : "";
                    cls.cCashBank = DS.Tables[0].Rows[i]["cCashBank"] != DBNull.Value ? DS.Tables[0].Rows[i]["cCashBank"].ToString() : "";
                    cls.cName = DS.Tables[0].Rows[i]["cname"] != DBNull.Value ? DS.Tables[0].Rows[i]["cname"].ToString() : "";
                    cls.cedit = DS.Tables[0].Rows[i]["cedit"] != DBNull.Value ? DS.Tables[0].Rows[i]["cedit"].ToString() : "";
                    cls.cdelete = DS.Tables[0].Rows[i]["cdelete"] != DBNull.Value ? DS.Tables[0].Rows[i]["cdelete"].ToString() : "";

                    myList.Add(cls);
                }
            }
        }

        var result = new
        {
            iTotalRecords = GetTotalCount("ListRec", ""),
            //iTotalRecords = 5000,
            iTotalDisplayRecords = filteredCount,
            aaData = myList
        };
        JavaScriptSerializer js = new JavaScriptSerializer();
        Context.Response.Write(js.Serialize(result));
    }
    [WebMethod]
    public void ListPayment(int iDisplayLength, int iDisplayStart, int iSortCol_0, string sSortDir_0, string sSearch)
    {
        int displayLength = iDisplayLength;
        int displayStart = iDisplayStart;
        int sortCol = iSortCol_0;
        string sortDir = sSortDir_0;
        string search = sSearch;


        ListAll cls2 = new ListAll();
        List<ListAll> myList = new List<ListAll>();



        int filteredCount = 0;
        DataSet DS = new DataSet();
        SqlInvoice CN = new SqlInvoice();

        DS = CN.RunSql("SP_ListTranPayment '" + displayLength + "','" + displayStart + "','" + sortCol + "','" + sortDir + "','" + cls2.CompID + "','" + search + "'", "List");


        if (DS.Tables.Count > 0)
        {
            if (DS.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < DS.Tables[0].Rows.Count; i++)
                {
                    ListAll cls = new ListAll();

                    filteredCount = Convert.ToInt32(DS.Tables[0].Rows[i]["TotalCount"] != DBNull.Value ? DS.Tables[0].Rows[i]["TotalCount"].ToString() : "0");
                    cls.nVouchNo = DS.Tables[0].Rows[i]["nVouchNo"] != DBNull.Value ? DS.Tables[0].Rows[i]["nVouchNo"].ToString() : "";
                    cls.dVochDate = DS.Tables[0].Rows[i]["dVochDate"] != DBNull.Value ? DS.Tables[0].Rows[i]["dVochDate"].ToString() : "";
                    cls.cCashBank = DS.Tables[0].Rows[i]["cCashBank"] != DBNull.Value ? DS.Tables[0].Rows[i]["cCashBank"].ToString() : "";
                    cls.cName = DS.Tables[0].Rows[i]["cname"] != DBNull.Value ? DS.Tables[0].Rows[i]["cname"].ToString() : "";
                    cls.cedit = DS.Tables[0].Rows[i]["cedit"] != DBNull.Value ? DS.Tables[0].Rows[i]["cedit"].ToString() : "";
                    cls.cdelete = DS.Tables[0].Rows[i]["cdelete"] != DBNull.Value ? DS.Tables[0].Rows[i]["cdelete"].ToString() : "";

                    myList.Add(cls);
                }
            }
        }

        var result = new
        {
            iTotalRecords = GetTotalCount("ListPay", ""),
            //iTotalRecords = 5000,
            iTotalDisplayRecords = filteredCount,
            aaData = myList
        };
        JavaScriptSerializer js = new JavaScriptSerializer();
        Context.Response.Write(js.Serialize(result));
    }

    private int GetTotalCount(string pageName, string cType)
    {
        myClass m = new myClass();
        ListAll cls2 = new ListAll();

        int totalCount = 0;
        DataSet DS = new DataSet();
        SqlInvoice CN = new SqlInvoice();

        DS = CN.RunSql("SP_GetTotalCount '" + pageName + "','" + cType + "','" + cls2.CompID + "'", "Count");
        totalCount = Convert.ToInt32(DS.Tables[0].Rows[0][0].ToString());
        return totalCount;
    }
}
