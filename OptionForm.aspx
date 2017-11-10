<%@ Page Title="Option Form" Language="C#" MasterPageFile="~/BillMaster.master" AutoEventWireup="true" CodeFile="OptionForm.aspx.cs" Inherits="OptionForm" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function select_Item(sender, e) {
            var hd = $get("<%=HifItem.ClientID %>");
            hd.value = e.get_value();
        }
        function select_Cus(sender, e) {
            var hd = $get("<%=HifCustomer.ClientID %>");
            hd.value = e.get_value();
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="panel">
        <div class="panel-heading">
            <h2 class="panel-title">
                <asp:Label ID="LblHead" runat="server" />

            </h2>
            <div>
                <div class="clearfix">
                </div>
            </div>
        </div>
        <div class="panel-content marginTopContent">
            <table class="table1">
                <tr runat="server" id="trSingleDate" visible="false">
                    <td style="width: 200px; text-align: center;">Date</td>
                    <td>
                        <asp:TextBox runat="server" ID="TxtDate" CssClass="bsdate_picker" TabIndex="1" onkeydown="return validateKeyPress(event,validDt)"
                            OnChange="dateval(this);" MaxLength="10"
                            data-inputmask="'mask': '99/99/9999'" Width="120px" />
                        <cc1:CalendarExtender runat="server" ID="CalendarExtenderdDate" TargetControlID="TxtDate"
                            BehaviorID="bCalendarExtenderdDate" CssClass="cal_Theme1" Format="dd/MM/yyyy"
                            PopupButtonID="ImageButton1"></cc1:CalendarExtender>
                    </td>
                    <td></td>
                    <td></td>
                </tr>
                <tr runat="server" id="trDate" visible="false">
                    <td style="text-align: center;">From Date </td>
                    <td>
                        <asp:TextBox runat="server" ID="TxtFrmdate" CssClass="bsdate_picker" TabIndex="2" onkeydown="return validateKeyPress(event,validDt)"
                            OnChange="dateval(this);" MaxLength="10"
                            data-inputmask="'mask': '99/99/9999'" Width="120px" />
                        <cc1:CalendarExtender runat="server" ID="CalendarExtender1" TargetControlID="TxtFrmdate"
                            BehaviorID="bCalendarExtenderdDate1" CssClass="cal_Theme1" Format="dd/MM/yyyy"
                            PopupButtonID="ImageButton1"></cc1:CalendarExtender>
                    </td>
                    <td style="text-align: center;">To Date</td>
                    <td>
                        <asp:TextBox runat="server" ID="TxtToDate" CssClass="bsdate_picker" TabIndex="3" onkeydown="return validateKeyPress(event,validDt)"
                            OnChange="dateval(this);" MaxLength="10"
                            data-inputmask="'mask': '99/99/9999'" Width="120px" />
                        <cc1:CalendarExtender runat="server" ID="CalendarExtender2" TargetControlID="TxtToDate"
                            BehaviorID="bCalendarExtenderdDate2" CssClass="cal_Theme1" Format="dd/MM/yyyy"
                            PopupButtonID="ImageButton1"></cc1:CalendarExtender>
                    </td>
                    <td style="text-align: center;" id="tdbranch" runat="server">Branch</td>
                    <td>
                        <asp:DropDownList ID="DDLBranch" DataTextField="cName" DataValueField="NID" runat="server" TabIndex="4" CssClass="bsinputblue" Width="120px">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr runat="server" id="tritem" visible="false">
                    <td style="text-align: center;">Item</td>
                    <td>
                        <asp:TextBox runat="server" ID="TxtItemName" CssClass="bsinputgreen" AutoPostBack="true"
                            Style="background: #E6f2f2; border: 1px solid DarkGray; border-radius: 3px; height: 22px;"
                            Width="250px" TabIndex="5" />
                        <cc1:AutoCompleteExtender ServiceMethod="SearchItem" MinimumPrefixLength="1" OnClientItemSelected="select_Item"
                            CompletionInterval="100" EnableCaching="false" CompletionSetCount="10" TargetControlID="TxtItemName"
                            ID="AutoCompleteExtender2" runat="server" FirstRowSelected="true" CompletionListCssClass="AutoComplete_completionListElement"
                            CompletionListItemCssClass="AutoComplete_listItem" CompletionListHighlightedItemCssClass="AutoComplete_highlightedListItem">
                        </cc1:AutoCompleteExtender>
                    </td>
                    <td style="text-align: center;">Branch</td>
                    <td>
                        <asp:DropDownList ID="DDL1Branch" DataTextField="cName" DataValueField="NID" TabIndex="6" runat="server" CssClass="bsinputblue" Width="120px">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr runat="server" id="trGst" visible="false">
                    <td></td>
                    <td>
                        <asp:DropDownList ID="DDLItem" runat="server" TabIndex="1">
                            <asp:ListItem Value="1">Item Wise</asp:ListItem>
                            <asp:ListItem Value="2">HSN Code</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td></td>
                </tr>
                <tr runat="server" id="trCusEnv" visible="false">
                    <td style="text-align: center;">Account Name
                    </td>
                    <td style="text-align: left;">
                        <asp:TextBox runat="server" ID="TxtCustomer" CssClass="bsinputgreen" TabIndex="1"
                            Style="background: #E6f2f2; border: 1px solid DarkGray; border-radius: 3px; height: 22px;"
                            Width="200px" />
                        <cc1:AutoCompleteExtender ServiceMethod="SearchCustomer" MinimumPrefixLength="1"
                            OnClientItemSelected="select_Cus" CompletionInterval="100" EnableCaching="false"
                            CompletionSetCount="10" TargetControlID="TxtCustomer" ID="AutoCompleteExtender3"
                            runat="server" FirstRowSelected="true" CompletionListCssClass="AutoComplete_completionListElement"
                            CompletionListItemCssClass="AutoComplete_listItem" CompletionListHighlightedItemCssClass="AutoComplete_highlightedListItem">
                        </cc1:AutoCompleteExtender>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TxtCustomer"
                            ErrorMessage="&lt;img src='assets/img/writing-icon.jpg' title='DELETE' alt='View' border='0'/&gt;"
                            ValidationGroup="Main" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:DropDownList ID="DDL_Account" DataTextField="cName" DataValueField="NID" TabIndex="6" runat="server" CssClass="bsinputblue" Width="120px">
                        </asp:DropDownList>

                    </td>
                    <td></td>
                </tr>
                <tr runat="server" id="trcity" visible="false" >
                    <td colspan="4">
                        <asp:Panel if="" runat="server" Style="border-color: #CCCCCC; border-width: 1px; border-style: Solid; height: 330px; width: 90%; overflow-y: scroll; overflow-x: hidden; overflow-y: auto; margin: 5px 5px 5px 10px;">
                            <asp:CheckBoxList ID="ChkCity" runat="server" RepeatColumns="8" DataValueField="City" DataTextField="City">
                            </asp:CheckBoxList>
                        </asp:Panel>
                    </td>

                </tr>
                <tr>
                    <td colspan="2" style="padding: 10px 0px 0px 85px;">
                        <asp:Button runat="server" ID="btnsave" class="btn btn-success SaveCancel btnSave"
                            Text="Save" TabIndex="7" OnClick="btnsave_Click" />
                        <asp:Button runat="server" ID="BtnCancel" class="btn btn-info SaveCancel btnSave"
                            Text="Cancel" TabIndex="8" OnClick="BtnCancel_Click" />
                    </td>
                </tr>

            </table>
        </div>
    </div>

    <asp:HiddenField ID="HifItem" runat="server" />
    <asp:HiddenField ID="HifCustomer" runat="server" />
</asp:Content>

