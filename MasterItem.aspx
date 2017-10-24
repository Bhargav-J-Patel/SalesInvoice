<%@ Page Title="" Language="C#" MasterPageFile="~/BillMaster.master" AutoEventWireup="true"
    CodeFile="MasterItem.aspx.cs" Inherits="MasterItem" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">

        function Calculation() {

            var purate = document.getElementById("<%=TxtPurRate.ClientID%>");
            var TxtMarginPer = document.getElementById("<%=TxtMarginPer.ClientID%>");
            var TxtMarginRs = document.getElementById("<%=TxtMarginRs.ClientID%>");
            var discper = document.getElementById("<%=TxtDiscPer.ClientID%>");
            var discrs = document.getElementById("<%=TxtDiscRS.ClientID%>");
            var salerate = document.getElementById("<%=TxtSaleRate.ClientID%>");
            var TxtMrp = document.getElementById("<%=TxtMrp.ClientID%>");
            
            TxtMarginRs.value = (purate.value * TxtMarginPer.value) / 100;
            discrs.value = (purate.value * discper.value) / 100;
            salerate.value = (parseFloat(purate.value) + parseFloat(TxtMarginRs.value)) - parseFloat(discrs.value);
            TxtMrp.value = (parseFloat(purate.value) + parseFloat(TxtMarginRs.value)) - parseFloat(discrs.value);


        }
        function select_ItemGroup(sender, e) {
            var hd = $get("<%=HifItemGroup.ClientID %>");
            hd.value = e.get_value();

        }

        function ScuessMsg(type) {

            if (type == 'I') {
                alertify.alert("You have Sucessfully Add Item", function () {
                    location.href = 'MasterItem.aspx';
                });
            }
            if (type == 'U') {
                alertify.alert("You have Sucessfully Update Item", function () {
                    location.href = 'ListMasterItem.aspx';
                });
            }
            if (type == 'D') {
                alertify.alert("You have Sucessfully Delete Item", function () {
                    location.href = 'ListMasterItem.aspx';
                });
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="panel">
        <div class="panel-heading">
            <h2 class="panel-title">Item Master
                <button type="button" name="btnList" runat="server" id="btnList" class="btn btn-info AddList"
                    onclick="location.href = 'ListMasterItem.aspx'" tabindex="4" style="float: right;">
                    <i class="icon wb-list"></i><span class="spanList"></span>
                </button>
                <%-- <button type="button" name="btnAdd" runat="server" id="btnAdd" class="btn btn-success AddList"
                    onclick="location.href = 'MasterItemGroup.aspx'" tabindex="5" style="float: right;
                    margin-right: 4px;">
                    <i class="icon wb-plus" style="margin-left: 0px; padding-left: 0px;"></i><span class="spanNew">
                    </span>
                </button>--%>
            </h2>
            <div>
                <div class="clearfix">
                </div>
            </div>
        </div>
        <div class="panel-content marginTopContent">
            <div class="row top-buffer">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-1 col-md-1 col-sm-1 col-xs-12">
                        <strong class="contentLabel">Item Group</strong>
                    </div>
                    <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
                        <asp:TextBox runat="server" ID="TxtItemGroupName" CssClass="bsinputblue" TabIndex="1" AutoPostBack="true"
                            Style="background: #E6f2f2; border: 1px solid DarkGray; border-radius: 3px;" OnTextChanged="TxtItemGroupName_TextChanged" />
                        <cc1:AutoCompleteExtender ServiceMethod="SearchItemGroup" MinimumPrefixLength="1"
                            OnClientItemSelected="select_ItemGroup" CompletionInterval="100" EnableCaching="false"
                            CompletionSetCount="10" TargetControlID="TxtItemGroupName" ID="AutoCompleteExtender1"
                            runat="server" FirstRowSelected="false" CompletionListCssClass="AutoComplete_completionListElement"
                            CompletionListItemCssClass="AutoComplete_listItem" CompletionListHighlightedItemCssClass="AutoComplete_highlightedListItem">
                        </cc1:AutoCompleteExtender>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TxtItemGroupName"
                            ErrorMessage="&lt;img src='assets/img/writing-icon.jpg' title='DELETE' alt='View' border='0'/&gt;"
                            ValidationGroup="Main"></asp:RequiredFieldValidator>
                        <asp:HiddenField ID="HifItemGroup" runat="server" />
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-1 col-xs-12">
                        <strong class="contentLabel">Item Name</strong>
                    </div>
                    <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
                        <asp:TextBox runat="server" ID="TxtItemName" CssClass="bsinputblue" TabIndex="1" />
                         <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TxtItemName"
                            ErrorMessage="&lt;img src='assets/img/writing-icon.jpg' title='FILL' alt='View' border='0'/&gt;"
                            ValidationGroup="Main"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                    </div>
                </div>
            </div>
            <div class="row top-buffer">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-1 col-md-1 col-sm-1 col-xs-10">
                        <strong class="contentLabel">Description</strong>
                    </div>
                    <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
                        <asp:TextBox runat="server" ID="TxtDescription" CssClass="bsinputblue" TabIndex="1" />
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-1 col-xs-10">
                        <strong class="contentLabel">HSN Code</strong>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
                        <asp:TextBox runat="server" ID="TxtHSNCode" CssClass="bsinputblue" TabIndex="1" />
                    </div>
                    <div class="col-lg-5 col-md-5 col-sm-5">
                    </div>
                </div>
            </div>
            <div class="row top-buffer" style="display: none">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-1 col-md-1 col-sm-1 col-xs-10">
                        <strong class="contentLabel">Size</strong>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
                        <asp:TextBox runat="server" ID="TxtSize" CssClass="bsinputblue" TabIndex="2" />
                    </div>
                    <div class="col-lg-9 col-md-9 col-sm-9">
                    </div>
                </div>
            </div>
            <div class="row top-buffer">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-1 col-md-1 col-sm-1 col-xs-10">
                        <strong class="contentLabel">Pu Rate</strong>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
                        <asp:TextBox runat="server" ID="TxtPurRate" CssClass="bsinputred" TabIndex="2" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TxtPurRate"
                            ErrorMessage="&lt;img src='assets/img/writing-icon.jpg' title='DELETE' alt='View' border='0'/&gt;"
                            ValidationGroup="Main"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-lg-9 col-md-9 col-sm-9">
                    </div>
                </div>
            </div>
            <div class="row top-buffer">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-1 col-md-1 col-sm-1 col-xs-10">
                        <strong class="contentLabel">Margin %</strong>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-1 col-xs-12">
                        <asp:TextBox runat="server" ID="TxtMarginPer" CssClass="bsinputred" TabIndex="2" onchange="Calculation()" />
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
                        <asp:TextBox runat="server" ID="TxtMarginRs" CssClass="bsinputred" TabIndex="2" />
                    </div>

                    <div class="col-lg-1 col-md-1 col-sm-1 col-xs-10">
                        <strong class="contentLabel">Disc %</strong>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-1 col-xs-12">
                        <asp:TextBox runat="server" ID="TxtDiscPer" CssClass="bsinputred" TabIndex="2" onchange="Calculation()" />
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
                        <asp:TextBox runat="server" ID="TxtDiscRS" CssClass="bsinputred" TabIndex="2" />
                    </div>
                    <div class="col-lg-8 col-md-8 col-sm-8">
                    </div>
                </div>
                <div class="row top-buffer">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                    </div>
                </div>

               

                <div class="row top-buffer">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <div class="col-lg-1 col-md-1 col-sm-1 col-xs-10">
                            <strong class="contentLabel" style="margin-left: 15px;">Sale Rate</strong>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-2 col-xs-12" style="margin-left: 12px;">
                            <asp:TextBox runat="server" ID="TxtSaleRate" CssClass="bsinputred" TabIndex="2" />
                              <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="TxtSaleRate"
                            ErrorMessage="&lt;img src='assets/img/writing-icon.jpg' title='Fill' alt='View' border='0'/&gt;"
                            ValidationGroup="Main"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-4">
                        </div>
                    </div>
                </div>
                 <div class="row top-buffer">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <div class="col-lg-1 col-md-1 col-sm-1 col-xs-10">
                            <strong class="contentLabel" style="margin-left: 15px;">MRP</strong>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-2 col-xs-12" style="margin-left: 12px;">
                            <asp:TextBox runat="server" ID="TxtMrp" CssClass="bsinputred" TabIndex="2" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="TxtMrp"
                            ErrorMessage="&lt;img src='assets/img/writing-icon.jpg' title='FILL' alt='View' border='0'/&gt;"
                            ValidationGroup="Main"></asp:RequiredFieldValidator>
                        </div>
                       
                        
                    </div>
                </div>
                <div class="row top-buffer">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <div class="col-lg-1 col-md-1 col-sm-1 col-xs-10">
                            <strong class="contentLabel" style="margin-left: 15px;">Qty</strong>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-2 col-xs-12" style="margin-left: 12px;">
                            <asp:TextBox runat="server" ID="TxtOpeningQty" CssClass="bsinputred" TabIndex="2" />
                        </div>
                       
                        
                    </div>
                </div>
                <div class="row top-buffer">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <div class="col-lg-1 col-md-1 col-sm-1 col-xs-10">
                            <strong class="contentLabel" style="margin-left: 15px;">Brand</strong>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-2 col-xs-12" style="margin-left: 12px;">
                            <asp:TextBox runat="server" ID="TxtcBrand" CssClass="bsinputblue" TabIndex="2" />
                        </div>
                       
                        
                    </div>
                </div>
                <div class="BottomFixed">
                    <asp:DropDownList ID="ddldelete" runat="server" Visible="false">
                        <asp:ListItem>No</asp:ListItem>
                        <asp:ListItem Value="Yes">Yes</asp:ListItem>
                    </asp:DropDownList>
                    <asp:Button runat="server" ID="btnsave" class="btn btn-success SaveCancel btnSave" ValidationGroup="Main"
                        OnClick="btnsave_Click" Text="Save" TabIndex="2" />
                    <asp:Button runat="server" ID="btncancel" class="btn btn-info SaveCancel btnCancel"
                        Text="Cancel" TabIndex="3" OnClick="btncancel_Click" />
                </div>
            </div>
        </div>
        <asp:HiddenField ID="HFNID" runat="server" />
</asp:Content>
