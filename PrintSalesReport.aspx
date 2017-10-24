<%@ Page Title="Report" Language="C#" MasterPageFile="~/BillMaster.master" AutoEventWireup="true" CodeFile="PrintSalesReport.aspx.cs" Inherits="PrintSalesReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">

        function openWin() {
            myWindow = window.open('', '', 'width=200,height=100');
            //myWindow.focus();
            print(myWindow);
        }
        function goback()
        {
            window.history.back();
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div style="margin: 10px 0px 0px 10px;">
        <div style="vertical-align:top;">
        <img src="assets/img/printer.png" alt="print" onclick="openWin()" style="display:none" /> 
        &nbsp;&nbsp;&nbsp;
        <img src="global/images/back_enabled_hover.png" alt="print" onclick="goback()" />
        <asp:ImageButton ID="ImageButton1" runat="server" Height="20px" Width="20px"
            ImageUrl="global/images/icons/export-excel-icon.png" onclick="ImageButton1_Click" />
            </div>

        <%--D:\Proj 31-08\Proj 31-08\SalesINV27082017\global\images--%>
        <div id="DivPrint" runat="server">
            <asp:Label Text="" ID="Lbl" runat="server" />
        </div>
    </div>

</asp:Content>

