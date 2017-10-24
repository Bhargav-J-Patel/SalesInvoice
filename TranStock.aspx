<%@ Page Title="" Language="C#" MasterPageFile="~/BillMaster.master" AutoEventWireup="true"
    CodeFile="TranStock.aspx.cs" Inherits="TranStock" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">

        function select_ItemGroup(sender, e) {
            var hd = $get("<%=HifItemGroup.ClientID %>");
            hd.value = e.get_value();

        }
        function select_Item(sender, e) {
            var hd = $get("<%=HifItem.ClientID %>");
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
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="panel">
        <div class="panel-heading">
            <h2 class="panel-title">
                Stock
                <button type="button" name="btnList" id="btnList" runat="server" class="btn btn-info AddList"
                    onclick="location.href = 'ListStock.aspx'" tabindex="10" style="float: right;">
                    <i class="icon wb-list"></i><span class="spanList"></span>
                </button>
                <button type="button" name="btnAdd" id="btnAdd" runat="server" class="btn btn-success AddList"
                    onclick="location.href = 'TranStock.aspx'" tabindex="9" style="float: right;
                    margin-right: 4px;">
                    <i class="icon wb-plus" style="margin-left: 0px; padding-left: 0px;"></i><span class="spanNew">
                    </span>
                </button>
            </h2>
            <div>
                <div class="clearfix">
                </div>
            </div>
        </div>
        <div class="panel-content marginTopContent">
        <div class="row">
          <table class="table1">
                <tr>
                    <td width="250px">
                        <strong class="contentLabel">Sr No :</strong>
                        <asp:TextBox runat="server" ID="TxtSRNo" CssClass="bsinputred" Enabled="false" />
                    </td>
                    <td>
                        <strong class="contentLabel">Date :</strong>
                        <asp:TextBox runat="server" ID="TxtDate" CssClass="bsdate_picker" TabIndex="1" onkeydown="return validateKeyPress(event,validDt)"
                            OnChange="dateval(this); getTodayRate(); DailySalesExists('DateChange');" MaxLength="10"
                            data-inputmask="'mask': '99/99/9999'" Width="120px" />
                        <cc1:CalendarExtender runat="server" ID="CalendarExtenderdDate" TargetControlID="TxtDate"
                            BehaviorID="bCalendarExtenderdDate" CssClass="cal_Theme1" Format="dd/MM/yyyy"
                            PopupButtonID="ImageButton1"></cc1:CalendarExtender>
                    </td>
                   
                </tr>
            </table>
            <div style="height: 20px; border-bottom: 1px solid grey;">
            </div>
            <asp:UpdatePanel runat="server" ID="Up1">
                <ContentTemplate>
                    <table class="table1">
                        <tr>
                            <td>
                                <strong class="contentLabel">Item Group</strong>
                            </td>
                            <td>
                                <strong class="contentLabel">Item</strong>
                            </td>
                            
                            <td>
                                <strong class="contentLabel">Qty</strong>
                            </td>
                           
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td width="265px">
                                <asp:TextBox runat="server" ID="TxtItemGroupName" CssClass="bsinputblue" TabIndex="2" Style="background: #E6f2f2; border: 1px solid DarkGray; border-radius: 3px;"
                                    Width="250px" OnTextChanged="TxtItemGroupName_TextChanged" AutoPostBack="true" />
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
                            </td>
                            <td width="265px">
                                <asp:TextBox runat="server" ID="TxtItemName" CssClass="bsinputblue" TabIndex="3" Style="background: #E6f2f2; border: 1px solid DarkGray; border-radius: 3px;"
                                    Width="250px"  />
                    <cc1:AutoCompleteExtender ServiceMethod="SearchItem" MinimumPrefixLength="1" OnClientItemSelected="select_Item"
                        CompletionInterval="100" EnableCaching="false" CompletionSetCount="10" TargetControlID="TxtItemName"
                        ID="AutoCompleteExtender2" runat="server" FirstRowSelected="false" CompletionListCssClass="AutoComplete_completionListElement"
                        CompletionListItemCssClass="AutoComplete_listItem" CompletionListHighlightedItemCssClass="AutoComplete_highlightedListItem">
                    </cc1:AutoCompleteExtender>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TxtItemName"
                        ErrorMessage="&lt;img src='assets/img/writing-icon.jpg' title='DELETE' alt='View' border='0'/&gt;"
                        ValidationGroup="Main"></asp:RequiredFieldValidator>
                    <asp:HiddenField ID="HifItem" runat="server" />
                            </td>
                            
                            <td width="110px">
                              
                                     <asp:TextBox runat="server" ID="TxtTotalQty" CssClass="bsinputred" TabIndex="4" />
                            </td>
                           
                            <td>
                                <asp:ImageButton ID="ImageButton1" ImageUrl="assets/img/add.png" runat="server" TabIndex="10"
                                    Height="20px" ValidationGroup="Child" OnClick="ImgBtnAdd_Click" CssClass="buttoncss" />
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
            </asp:UpdatePanel>

         <div style="height: 150px" class="col-lg-12 col-md-12 col-sm-12 top-buffer">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <asp:GridView ID="GVItem" runat="server" AutoGenerateColumns="false" class="table table-striped table-bordered table-hover">
                        <Columns>
                            <asp:BoundField DataField="NID" HeaderText="" ItemStyle-Width="1px" ItemStyle-ForeColor="Transparent"
                                ItemStyle-Font-Size="1px" />
                            <asp:BoundField DataField="cPNID" Visible="false" />
                            <asp:BoundField HeaderText="Item Group" DataField="cItemGroupName" />
                            <asp:BoundField HeaderText="Item" DataField="cItem" />
                           
                            <asp:BoundField HeaderText="Qty" DataField="nqty" />
                           
                           <asp:TemplateField HeaderText="Edit" ItemStyle-Width="5%">
                                <ItemTemplate>
                                    <a href="TranSalesRetailInvoice.aspx?id=<%# DataBinder.Eval(Container.DataItem,"PNID")%>&cid=<%# DataBinder.Eval(Container.DataItem , "NID") %>">
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
  
</asp:Content>
