<%@ Page Title="Receipt" Language="C#" MasterPageFile="~/BillMaster.master" AutoEventWireup="true"
    CodeFile="TranReceipt.aspx.cs" Inherits="TranReceipt" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function select_Cus(sender, e) {
            var hd = $get("<%=HifCustomer.ClientID %>");
            hd.value = e.get_value();

        }
        function select_Acc(sender, e) {
            var hd = $get("<%=HIFAccount.ClientID %>");
            hd.value = e.get_value();

        }
        function Confirm_box() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("Are you sure you want to delete this Record ?")) {
                confirm_value.value = "Yes";
            } else {
                confirm_value.value = "No";
            }
            document.forms[0].appendChild(confirm_value);
        }

        function ScuessMsg(type, ID) {
            if (type == 'PU' && ID != '') {
                alertify.alert("You have Sucessfully Add Receipt !!", function () {
                    location.href = 'TranReceipt.aspx';
                });
            }
            else if (type == 'D' && ID == 'D') {
                alertify.alert("You have Sucessfully Delete Receipt! !", function () {
                    location.href = 'ListTranReceipt.aspx';
                });
            }
            else {
                alertify.alert("You have Sucessfully Update Receipt ! !", function () {
                    location.href = 'ListTranReceipt.aspx';
                });
            }

        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="panel">
        <div class="panel-heading">
            <h2 class="panel-title">Receipt
                <button type="button" name="btnList" id="btnList" runat="server" class="btn btn-info AddList"
                    onclick="location.href = 'ListTranReceipt.aspx'" tabindex="16" style="float: right;">
                    <i class="icon wb-list"></i><span class="spanList"></span>
                </button>
                <button type="button" name="btnAdd" id="btnAdd" runat="server" class="btn btn-success AddList"
                    onclick="location.href = 'TranReceipt.aspx'" tabindex="17" style="float: right; margin-right: 4px;">
                    <i class="icon wb-plus" style="margin-left: 0px; padding-left: 0px;"></i><span class="spanNew"></span>
                </button>
            </h2>
            <div>
                <div class="clearfix">
                </div>
            </div>
        </div>
        <div class="panel-content marginTopContent">
            <table class="table1">
                <tr>
                    <td style="width: 150px;">
                        <strong class="contentLabel">Sr No :</strong>
                        <asp:TextBox runat="server" ID="TxtSRNo" CssClass="bsinputred" Enabled="false" Width="70px" />
                    </td>
                    <td style="width: 200px;">
                        <strong class="contentLabel">Date :</strong>
                        <asp:TextBox runat="server" ID="TxtDate" CssClass="bsdate_picker" TabIndex="1" onkeydown="return validateKeyPress(event,validDt)"
                            OnChange="dateval(this);" MaxLength="10" data-inputmask="'mask': '99/99/9999'"
                            Width="120px" />
                        <cc1:CalendarExtender runat="server" ID="CalendarExtenderdDate" TargetControlID="TxtDate"
                            BehaviorID="bCalendarExtenderdDate" CssClass="cal_Theme1" Format="dd/MM/yyyy"
                            PopupButtonID="ImageButton1"></cc1:CalendarExtender>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TxtDate"
                            ErrorMessage="&lt;img src='assets/img/writing-icon.jpg' title='DELETE' alt='View' border='0'/&gt;"
                            ValidationGroup="Main"></asp:RequiredFieldValidator>
                    </td>
                    <td style="width: 150px;">
                        <strong class="contentLabel">Type :</strong>
                        <asp:DropDownList runat="server" ID="DDLCType" TabIndex="2">
                            <asp:ListItem>Cash</asp:ListItem>
                            <asp:ListItem>Bank</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <strong class="contentLabel">Account :</strong>
                        <asp:TextBox runat="server" ID="TxtCustomer" CssClass="bsinputgreen" TabIndex="3"
                            Style="background: #E6f2f2; border: 1px solid DarkGray; border-radius: 3px; height: 22px;"
                            Width="270px" />
                        <cc1:AutoCompleteExtender ServiceMethod="SearchCustomer" MinimumPrefixLength="1"
                            OnClientItemSelected="select_Cus" CompletionInterval="100" EnableCaching="false"
                            CompletionSetCount="10" TargetControlID="TxtCustomer" ID="AutoCompleteExtender3"
                            runat="server" FirstRowSelected="true" CompletionListCssClass="AutoComplete_completionListElement"
                            CompletionListItemCssClass="AutoComplete_listItem" CompletionListHighlightedItemCssClass="AutoComplete_highlightedListItem">
                        </cc1:AutoCompleteExtender>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TxtCustomer"
                            ErrorMessage="&lt;img src='assets/img/writing-icon.jpg' title='DELETE' alt='View' border='0'/&gt;"
                            ValidationGroup="Main" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:HiddenField ID="HifCustomer" runat="server" />
                    </td>
                </tr>
            </table>
            <div style="height: 7px; border-bottom: 1px solid grey;">
            </div>
            <asp:UpdatePanel runat="server" ID="Up1">
                <ContentTemplate>
                    <table class="table1">
                        <tr>
                            <td style="width: 290px">
                                <strong class="contentLabel">Account</strong>
                            </td>
                            <td style="width: 110px">
                                <strong class="contentLabel">Amount</strong>
                            </td>
                            <td style="width: 110px">
                                <strong class="contentLabel">Against Bill</strong>
                            </td>
                            <td style="width: 110px; display: none">
                                <strong class="contentLabel">Kasar</strong>
                            </td>
                            <td style="width: 110px; display: none">
                                <strong class="contentLabel">TDS</strong>
                            </td>
                            <td style="width: 110px">
                                <strong class="contentLabel">Ref No</strong>
                            </td>
                            <td style="width: 110px">
                                <strong class="contentLabel">Ref Date</strong>
                            </td>
                            <td style="width: 200px">
                                <strong class="contentLabel">Remarks</strong>
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox runat="server" ID="TxtAccount" CssClass="bsinputgreen" TabIndex="4"
                                    Style="background: #E6f2f2; border: 1px solid DarkGray; border-radius: 3px; height: 22px;"
                                    Width="270px" />
                                <cc1:AutoCompleteExtender ServiceMethod="SearchAccount" MinimumPrefixLength="1" OnClientItemSelected="select_Acc"
                                    CompletionInterval="100" EnableCaching="false" CompletionSetCount="10" TargetControlID="TxtAccount"
                                    ID="AutoCompleteExtender1" runat="server" FirstRowSelected="true" CompletionListCssClass="AutoComplete_completionListElement"
                                    CompletionListItemCssClass="AutoComplete_listItem" CompletionListHighlightedItemCssClass="AutoComplete_highlightedListItem">
                                </cc1:AutoCompleteExtender>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TxtAccount"
                                    ErrorMessage="&lt;img src='assets/img/writing-icon.jpg' title='DELETE' alt='View' border='0'/&gt;"
                                    ValidationGroup="Main" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:HiddenField ID="HIFAccount" runat="server" />
                            </td>
                            <td>
                                <asp:TextBox runat="server" ID="TxtAmount" CssClass="bsinputred" TabIndex="5" />
                            </td>
                            <td>
                                <asp:DropDownList runat="server" ID="DDLAgainstBill" TabIndex="6">
                                    <asp:ListItem>Yes</asp:ListItem>
                                    <asp:ListItem>No</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td style="display: none">
                                <asp:TextBox runat="server" ID="TxtKasar" CssClass="bsinputred" TabIndex="7" />
                            </td>
                            <td style="display: none">
                                <asp:TextBox runat="server" ID="TxtTDS" CssClass="bsinputred" TabIndex="8" />
                            </td>
                            <td>
                                <asp:TextBox runat="server" ID="TxtRefNO" CssClass="bsinputblue" TabIndex="9" />
                            </td>
                            <td>

                                <asp:TextBox runat="server" ID="TxtRefdate" CssClass="bsdate_picker" TabIndex="10" onkeydown="return validateKeyPress(event,validDt)"
                                    OnChange="dateval(this);" MaxLength="10" data-inputmask="'mask': '99/99/9999'"
                                    Width="120px" />
                                <cc1:CalendarExtender runat="server" ID="CalendarExtender1" TargetControlID="TxtRefdate"
                                    BehaviorID="bCalendarExtenderdDate" CssClass="cal_Theme1" Format="dd/MM/yyyy"
                                    PopupButtonID="ImageButton1"></cc1:CalendarExtender>
                            </td>
                            <td>
                                <asp:TextBox runat="server" ID="TxtRemarks" CssClass="bsinputblue" TabIndex="11" />
                            </td>
                            <td>
                                <asp:ImageButton ID="ImgBtnAdd" ImageUrl="assets/img/add.png" runat="server" TabIndex="12"
                                    Height="20px" ValidationGroup="Main" OnClick="ImgBtnAdd_Click" CssClass="buttoncss" />
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
            </asp:UpdatePanel>

            <div style="height: 400px; overflow: auto; overflow-x: hidden;">
                <asp:GridView ID="GVItem" runat="server" AutoGenerateColumns="false" class="table1 table-responsive table-bordered table-hover">
                    <Columns>
                        <asp:BoundField DataField="NID" HeaderText="" ItemStyle-Width="1px" ItemStyle-ForeColor="Transparent"
                            ItemStyle-Font-Size="1px" />
                        <asp:BoundField DataField="cPNID" Visible="false" />
                        <asp:BoundField HeaderText="SrNo" DataField="srno" />
                        <asp:BoundField HeaderText="Acc Name" DataField="cName" />
                        <asp:BoundField HeaderText="Amount" DataField="nAmount" />
                        <asp:BoundField HeaderText="Against Bill" DataField="cAgainstBill" />
                        <asp:BoundField HeaderText="Kasar" DataField="nKasar" Visible="false" />
                        <asp:BoundField HeaderText="TDS" DataField="nTDS" Visible="false" />
                        <asp:BoundField HeaderText="Ref No" DataField="nRefNo" />
                        <asp:BoundField HeaderText="Ref Date" DataField="dRefDate" />
                        <asp:BoundField HeaderText="Remark" DataField="cRemark" />

                        <asp:TemplateField HeaderText="Edit" ItemStyle-Width="5%">
                            <ItemTemplate>
                                <a href="TranReceipt.aspx?id=<%# DataBinder.Eval(Container.DataItem,"cPNID")%>&cid=<%# DataBinder.Eval(Container.DataItem , "NID") %>">
                                    <asp:Image ID="ImgEdit" ImageUrl="assets/img/edit.png" runat="server" title="Edit" />
                                </a>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Delete">
                            <ItemTemplate>
                                <asp:ImageButton ID="ImgDelete1" ImageUrl="assets/img/delete.png" runat="server"
                                    title="Delete" OnClientClick="Confirm_box()" OnClick="ImgDelete1_Click" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
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
                <asp:DropDownList ID="ddldelete" runat="server" Visible="false">
                    <asp:ListItem>No</asp:ListItem>
                    <asp:ListItem Value="Yes">Yes</asp:ListItem>
                </asp:DropDownList>
                <asp:Button runat="server" ID="btnsave" class="btn btn-success SaveCancel btnSave"
                    OnClick="btnsave_Click" Text="Save" TabIndex="13" />
                <asp:Button runat="server" ID="btncancel" class="btn btn-info SaveCancel btnCancel"
                    Text="Cancel" TabIndex="14" OnClick="btncancel_Click" />
                <div style="padding-top: 3px; font-weight: bold; display: inline-block; margin-left: 15%;">
                    &nbsp;
                </div>
                <div style="padding-top: 3px; font-weight: bold; display: inline-block; margin-left: 15%;">
                    &nbsp;
                </div>
                <div style="padding-top: 3px; font-weight: bold; display: inline-block; margin-left: 15%;">
                    &nbsp;
                </div>
                <div style="padding-top: 3px; font-weight: bold; display: inline-block; margin-left: 5%;">
                    &nbsp;
                </div>
                <div style="padding-top: 3px; font-weight: bold; display: inline-block; margin-left: 5%;">
                    &nbsp;
                </div>
                <div style="padding-top: 3px; font-weight: bold; font-size: 20px; display: inline-block; margin-left: 5%;">
                    <span class="contentLabel">Total Rs</span>&nbsp;:&nbsp;&nbsp;<asp:Label runat="server"
                        ID="LblNetRs"></asp:Label>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
