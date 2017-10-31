<%@ Page Title="" Language="C#" MasterPageFile="~/BillMaster.master" AutoEventWireup="true" CodeFile="Systemsetting.aspx.cs" Inherits="Systemsetting" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function ScuessMsg(type) {

            if (type == 'U') {
                alertify.alert("You have Sucessfully Update System Setting", function () {
                    location.href = 'Systemsetting.aspx';
                });
            }

        }
        function select_CGST(sender, e) {
            var hd = $get("<%=HIDTxtCGSTAccount.ClientID %>");
            hd.value = e.get_value();

        }
        function select_SGST(sender, e) {
            var hd = $get("<%=HIDTxtSGSTAccount.ClientID %>");
            hd.value = e.get_value();

        }
        function select_IGST(sender, e) {
            var hd = $get("<%=HIDTxtIGSTAccount.ClientID %>");
            hd.value = e.get_value();

        }
        function select_Cash(sender, e) {
            var hd = $get("<%=HIDTxtCashAccount.ClientID %>");
            hd.value = e.get_value();

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="panel">
        <div class="panel-heading">
            <h2 class="panel-title">System setting
               <%-- <button type="button" name="btnList" runat="server" id="btnList" class="btn btn-info AddList"
                    onclick="location.href = 'ListMasterCustomer.aspx'" tabindex="16" style="float: right;">
                    <i class="icon wb-list"></i><span class="spanList"></span>
                </button>--%>
                <%-- <button type="button" name="btnAdd" runat="server" id="btnAdd" class="btn btn-success AddList"
                    onclick="location.href = 'MasterCustomer.aspx'" tabindex="9" style="float: right;
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
            <div class="row" style="margin-left: 20px;">
                <table class="table1">
                    <tr>
                        <td style="width: 150px;"><strong class="contentLabel">State code</strong></td>
                        <td style="width: 350px;">
                            <asp:TextBox runat="server" ID="Txtstatecode" CssClass="bsinputblue" Width="300px" /></td>
                        <td style="width: 150px; padding-left: 40px;">
                            <strong class="contentLabel">CGST Account</strong>
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="TxtCGSTAccount" CssClass="bsinputblue" Width="300px" Style="background: #E6f2f2; border: 1px solid DarkGray; border-radius: 3px; height: 22px;" />
                            <cc1:AutoCompleteExtender ServiceMethod="SearchGSTAccount" MinimumPrefixLength="1"
                                OnClientItemSelected="select_CGST" CompletionInterval="100" EnableCaching="false"
                                CompletionSetCount="10" TargetControlID="TxtCGSTAccount" ID="AutoCompleteExtender3"
                                runat="server" FirstRowSelected="true" CompletionListCssClass="AutoComplete_completionListElement"
                                CompletionListItemCssClass="AutoComplete_listItem" CompletionListHighlightedItemCssClass="AutoComplete_highlightedListItem">
                            </cc1:AutoCompleteExtender>
                            <asp:HiddenField ID="HIDTxtCGSTAccount" runat="server" />
                        </td>
                    </tr>

                    <tr>
                        <td style="width: 150px;"><strong class="contentLabel">SGST Account</strong></td>
                        <td style="width: 350px;">
                            <asp:TextBox runat="server" ID="TxtSGSTAccount" CssClass="bsinputgreen" Width="300px" Style="background: #E6f2f2; border: 1px solid DarkGray; border-radius: 3px; height: 22px;" /></td>
                        <cc1:AutoCompleteExtender ServiceMethod="SearchGSTAccount" MinimumPrefixLength="1"
                            OnClientItemSelected="select_SGST" CompletionInterval="100" EnableCaching="false"
                            CompletionSetCount="10" TargetControlID="TxtSGSTAccount" ID="AutoCompleteExtender1"
                            runat="server" FirstRowSelected="true" CompletionListCssClass="AutoComplete_completionListElement"
                            CompletionListItemCssClass="AutoComplete_listItem" CompletionListHighlightedItemCssClass="AutoComplete_highlightedListItem">
                        </cc1:AutoCompleteExtender>
                        <asp:HiddenField ID="HIDTxtSGSTAccount" runat="server" />
                        <td style="width: 150px; padding-left: 40px;">
                            <strong class="contentLabel">IGST Account</strong>
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="TxtIGSTAccount" CssClass="bsinputgreen" Width="300px" Style="background: #E6f2f2; border: 1px solid DarkGray; border-radius: 3px; height: 22px;" />
                            <cc1:AutoCompleteExtender ServiceMethod="SearchGSTAccount" MinimumPrefixLength="1"
                                OnClientItemSelected="select_IGST" CompletionInterval="100" EnableCaching="false"
                                CompletionSetCount="10" TargetControlID="TxtIGSTAccount" ID="AutoCompleteExtender2"
                                runat="server" FirstRowSelected="true" CompletionListCssClass="AutoComplete_completionListElement"
                                CompletionListItemCssClass="AutoComplete_listItem" CompletionListHighlightedItemCssClass="AutoComplete_highlightedListItem">
                            </cc1:AutoCompleteExtender>
                            <asp:HiddenField ID="HIDTxtIGSTAccount" runat="server" />
                        </td>
                    </tr>

                    <tr>
                        <td style="width: 150px;"><strong class="contentLabel">Cash Account</strong></td>
                        <td style="width: 350px;">
                            <asp:TextBox runat="server" ID="TxtCashAccount" CssClass="bsinputgreen" Width="300px" Style="background: #E6f2f2; border: 1px solid DarkGray; border-radius: 3px; height: 22px;" /></td>
                        <cc1:AutoCompleteExtender ServiceMethod="SearchCashAccount" MinimumPrefixLength="1"
                            OnClientItemSelected="select_Cash" CompletionInterval="100" EnableCaching="false"
                            CompletionSetCount="10" TargetControlID="TxtCashAccount" ID="AutoCompleteExtender4"
                            runat="server" FirstRowSelected="true" CompletionListCssClass="AutoComplete_completionListElement"
                            CompletionListItemCssClass="AutoComplete_listItem" CompletionListHighlightedItemCssClass="AutoComplete_highlightedListItem">
                        </cc1:AutoCompleteExtender>
                        <asp:HiddenField ID="HIDTxtCashAccount" runat="server" />
                    </tr>
                </table>
            </div>
            <div class="BottomFixed">
                <%-- <button type="button" name="btnSave" id="btnSave" class="btn btn-success SaveCancel btnSave"
                    tabindex="6012" onclick="FinalSave()">
                    <i class="icon fa-save SaveCancelIcon iSave" id="iSave"></i><span id="spanSave" class="spanSave">
                    </span>
                </button>
                <button type="button" name="btnCancel" id="btnCancel" class="btn btn-info SaveCancel btnCancel"
                    tabindex="6013" onclick="GoToDefaultPage()">
                    <i class="icon fa-close SaveCancelIcon iCancel"></i><span id="spanCancel" class="spanCancel">
                    </span>
                </button>--%>
                <asp:DropDownList ID="ddldelete" runat="server" Visible="false" TabIndex="6">
                    <asp:ListItem>No</asp:ListItem>
                    <asp:ListItem Value="Yes">Yes</asp:ListItem>
                </asp:DropDownList>
                <asp:Button runat="server" ID="btnsave" class="btn btn-success SaveCancel btnSave"
                    OnClick="btnsave_Click" Text="Save" TabIndex="7" />
                <asp:Button runat="server" ID="btncancel" class="btn btn-info SaveCancel btnCancel"
                    Text="Cancel" TabIndex="8" OnClick="btncancel_Click" />


            </div>
        </div>
    </div>
</asp:Content>

