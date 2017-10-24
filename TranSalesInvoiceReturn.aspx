<%@ Page Title="Sales Tax Return" Language="C#" MasterPageFile="~/BillMaster.master" AutoEventWireup="true" CodeFile="TranSalesInvoiceReturn.aspx.cs" Inherits="TranSalesInvoiceReturn" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
         $(document).ready(function () {
            var ID = getParameterByName('id');
            if (ID != undefined) {

                setTimeout(function () { document.getElementById("<%=TxtItemName.ClientID%>").focus(); }, 200);

            }

        });

        function getParameterByName(name, url) {
            if (!url) url = window.location.href;
            name = name.replace(/[\[\]]/g, "\\$&");
            var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
                results = regex.exec(url);
            if (!results) return null;
            if (!results[2]) return '';
            return decodeURIComponent(results[2].replace(/\+/g, " "));
        }
        function select_ItemGroup(sender, e) {
            var hd = $get("<%=HifItemGroup.ClientID %>");
            hd.value = e.get_value();

        }
        function select_Item(sender, e) {
            var hd = $get("<%=HifItem.ClientID %>");
            hd.value = e.get_value();

        }
        function select_Cus(sender, e) {
            var hd = $get("<%=HifCustomer.ClientID %>");
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
                alertify.alert("You have Sucessfully Add Sales Invoice", function () {
                    location.href = 'TranSalesInvoiceReturn.aspx';
                });
            }
            else if (type == 'D' && ID == 'D') {
                alertify.alert("You have Sucessfully Delete Sales Invoice! !", function () {
                    location.href = 'ListTranSalesTaxInvoiceReturn.aspx';
                });
            }
            else {
                alertify.alert("You have Sucessfully Update Sales Invoice! !", function () {
                    location.href = 'ListTranSalesTaxInvoiceReturn.aspx';
                });
            }

        }


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="panel">
        <div class="panel-heading">
            <h2 class="panel-title">Sales Return(Exclue)
                <button type="button" name="btnList" id="btnList" runat="server" class="btn btn-info AddList"
                    onclick="location.href = 'ListTranSalesTaxInvoiceReturn.aspx'" tabindex="6015" style="float: right;">
                    <i class="icon wb-list"></i><span class="spanList"></span>
                </button>
                <button type="button" name="btnAdd" id="btnAdd" runat="server" class="btn btn-success AddList"
                    onclick="location.href = 'TranSalesInvoiceReturn.aspx'" tabindex="6014" style="float: right; margin-right: 4px;">
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
                    <td>
                        <strong class="contentLabel">Sr No :</strong>
                        <asp:TextBox runat="server" ID="TxtSRNo" CssClass="bsinputred" Enabled="false" Width="70px" />
                    </td>
                    <td>
                        <strong class="contentLabel">Date :</strong>
                        <asp:TextBox runat="server" ID="TxtDate" CssClass="bsdate_picker" TabIndex="1" onkeydown="return validateKeyPress(event,validDt)"
                            OnChange="dateval(this);" MaxLength="10"
                            data-inputmask="'mask': '99/99/9999'" Width="120px" />
                        <cc1:CalendarExtender runat="server" ID="CalendarExtenderdDate" TargetControlID="TxtDate"
                            BehaviorID="bCalendarExtenderdDate" CssClass="cal_Theme1" Format="dd/MM/yyyy"
                            PopupButtonID="ImageButton1"></cc1:CalendarExtender>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TxtDate"
                            ErrorMessage="&lt;img src='assets/img/writing-icon.jpg' title='DELETE' alt='View' border='0'/&gt;"
                            ValidationGroup="Main"></asp:RequiredFieldValidator>
                    </td>
                    <td>
                        <strong class="contentLabel">Customer :</strong>
                        <asp:TextBox runat="server" ID="TxtCustomer" CssClass="bsinputgreen" TabIndex="1"
                            Style="background: #E6f2f2; border: 1px solid DarkGray; border-radius: 3px; height: 22px;"
                            Width="270px" />
                        <cc1:AutoCompleteExtender ServiceMethod="SearchCustomer" MinimumPrefixLength="1"
                            OnClientItemSelected="select_Cus" CompletionInterval="100" EnableCaching="false"
                            CompletionSetCount="10" TargetControlID="TxtCustomer" ID="AutoCompleteExtender3"
                            runat="server" FirstRowSelected="true" CompletionListCssClass="AutoComplete_completionListElement"
                            CompletionListItemCssClass="AutoComplete_listItem" CompletionListHighlightedItemCssClass="AutoComplete_highlightedListItem">
                        </cc1:AutoCompleteExtender>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TxtItemGroupName"
                            ErrorMessage="&lt;img src='assets/img/writing-icon.jpg' title='DELETE' alt='View' border='0'/&gt;"
                            ValidationGroup="Main" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:HiddenField ID="HifCustomer" runat="server" />
                         <asp:DropDownList ID="DDLCashCredit" runat="server" TabIndex="1">
                            <asp:ListItem Value="0">Cash</asp:ListItem>
                            <asp:ListItem Value="1">Credit</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <strong class="contentLabel">Transporter ID</strong>
                        <asp:TextBox runat="server" ID="TxtTransporterID" CssClass="bsinputblue" TabIndex="1"
                            Style="width: 120px;" />
                    </td>
                    <td>
                        <strong class="contentLabel">Transporter Name</strong>
                        <asp:TextBox runat="server" ID="TxtTransporterName" CssClass="bsinputblue" TabIndex="1"
                            Style="width: 120px;" />
                    </td>
                    <td>
                        <strong class="contentLabel">VehicleNo</strong>
                        <asp:TextBox runat="server" ID="TxtVehicleNo" CssClass="bsinputblue" TabIndex="1"
                            Style="width: 100px;" />
                    </td>
                </tr>
            </table>
            <div style="height: 7px; border-bottom: 1px solid grey;">
            </div>
            <asp:UpdatePanel runat="server" ID="Up1">
                <ContentTemplate>
                    <table class="table1">
                        <tr>

                            <td>
                                <strong class="contentLabel">Item</strong>
                            </td>
                            <td>
                                <strong class="contentLabel">Item Group</strong>
                            </td>
                            <td>
                                <strong class="contentLabel">Description</strong>
                            </td>
                            <td style="display: none">
                                <strong class="contentLabel">Size</strong>
                            </td>
                            <td>
                                <strong class="contentLabel">MRP</strong>
                            </td>
                            <td>
                                <strong class="contentLabel">Dis %</strong>
                            </td>
                            <td>
                                <strong class="contentLabel">DisRs</strong>
                            </td>
                            <td>
                                <strong class="contentLabel">Sale Rate</strong>
                            </td>
                            <td>
                                <strong class="contentLabel">Qty</strong>
                            </td>
                            <td>
                                <strong class="contentLabel">Total</strong>
                            </td>
                            <td></td>
                        </tr>
                        <tr>

                            <td width="265px">
                                <asp:TextBox runat="server" ID="TxtItemName" CssClass="bsinputgreen" AutoPostBack="true"
                                    Style="background: #E6f2f2; border: 1px solid DarkGray; border-radius: 3px; height: 22px;"
                                    Width="250px" TabIndex="1" OnTextChanged="TxtItemName_TextChanged" />
                                <cc1:AutoCompleteExtender ServiceMethod="SearchItem" MinimumPrefixLength="1" OnClientItemSelected="select_Item"
                                    CompletionInterval="100" EnableCaching="false" CompletionSetCount="10" TargetControlID="TxtItemName"
                                    ID="AutoCompleteExtender2" runat="server" FirstRowSelected="true" CompletionListCssClass="AutoComplete_completionListElement"
                                    CompletionListItemCssClass="AutoComplete_listItem" CompletionListHighlightedItemCssClass="AutoComplete_highlightedListItem">
                                </cc1:AutoCompleteExtender>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TxtItemName"
                                    ErrorMessage="&lt;img src='assets/img/writing-icon.jpg' title='DELETE' alt='View' border='0'/&gt;"
                                    ValidationGroup="Main"></asp:RequiredFieldValidator>
                                <asp:HiddenField ID="HifItem" runat="server" />
                            </td>
                            <td width="265px">
                                <asp:TextBox runat="server" ID="TxtItemGroupName" CssClass="bsinputgreen" TabIndex="1"
                                    Style="background: #E6f2f2; border: 1px solid DarkGray; border-radius: 3px;"
                                    Width="250px" Enabled="false"></asp:TextBox>
                                <%--<cc1:AutoCompleteExtender ServiceMethod="SearchItemGroup" MinimumPrefixLength="1"
                                    OnClientItemSelected="select_ItemGroup" CompletionInterval="100" EnableCaching="false"
                                    CompletionSetCount="10" TargetControlID="TxtItemGroupName" ID="AutoCompleteExtender1"
                                    runat="server" FirstRowSelected="false" CompletionListCssClass="AutoComplete_completionListElement"
                                    CompletionListItemCssClass="AutoComplete_listItem" CompletionListHighlightedItemCssClass="AutoComplete_highlightedListItem">
                                </cc1:AutoCompleteExtender>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TxtItemGroupName"
                                    ErrorMessage="&lt;img src='assets/img/writing-icon.jpg' title='DELETE' alt='View' border='0'/&gt;"
                                    ValidationGroup="Main"></asp:RequiredFieldValidator>--%>
                                <asp:HiddenField ID="HifItemGroup" runat="server" />
                            </td>
                            <td width="275px">
                                <asp:TextBox runat="server" ID="TxtDescription" CssClass="bsinputblue" TabIndex="1"
                                    Width="250px" Enabled="false" />
                            </td>
                            <td width="160px" style="display: none">
                                <asp:TextBox runat="server" ID="TxtSize" CssClass="bsinputblue" TabIndex="1" Enabled="false"
                                    Width="150px" />
                            </td>
                            <td>
                                <asp:TextBox runat="server" ID="TxtMRP" CssClass="bsinputred" TabIndex="1" Enabled="false" />
                            </td>
                            <td>
                                <asp:TextBox runat="server" ID="txtDiscPerChild" CssClass="bsinputred" TabIndex="1" OnTextChanged="txtDiscPerChild_TextChanged" AutoPostBack="true" />
                            </td>
                            <td>
                                <asp:TextBox runat="server" ID="TxtDisRsChild" CssClass="bsinputred" TabIndex="1" OnTextChanged="TxtDisRsChild_TextChanged" Enabled="false" />
                            </td>
                            <td>
                                <asp:TextBox runat="server" ID="TxtSaleRate" CssClass="bsinputred" TabIndex="1" OnTextChanged="TxtSaleRate_TextChanged" AutoPostBack="true" />
                            </td>
                            <td>
                                <asp:TextBox runat="server" ID="TxtQty" CssClass="bsinputred" TabIndex="1" AutoPostBack="true"
                                    OnTextChanged="TxtQty_TextChanged" />
                            </td>
                            <td>
                                <asp:Label runat="server" ID="LblTotal"></asp:Label>
                            </td>
                            <td>
                                <asp:ImageButton ID="ImgBtnAdd" ImageUrl="assets/img/add.png" runat="server" TabIndex="1"
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
                        <asp:BoundField HeaderText="Item" DataField="cItem" />
                        <asp:BoundField HeaderText="Item Group" DataField="cItemGroupName" />
                        <asp:BoundField HeaderText="Description" DataField="cDescription" />
                        <asp:BoundField HeaderText="Size" DataField="nSize" Visible="false" />
                        <asp:BoundField HeaderText="MRP" DataField="nMRP" />
                        <asp:BoundField HeaderText="Disc(%)" DataField="nDisPer" />
                        <asp:BoundField HeaderText="DiscRs" DataField="nDisRs" />
                        <asp:BoundField HeaderText="Sales Rate" DataField="nSaleRate" />
                        <asp:BoundField HeaderText="Qty" DataField="nqty" />
                        <asp:BoundField HeaderText="Total" DataField="nTotal" />
                        <asp:TemplateField HeaderText="Edit" ItemStyle-Width="5%">
                            <ItemTemplate>
                                <a href="TranSalesInvoiceReturn.aspx?id=<%# DataBinder.Eval(Container.DataItem,"cPNID")%>&cid=<%# DataBinder.Eval(Container.DataItem , "NID") %>">
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
            <div class="col-lg-12 col-md-12 col-sm-12 top-buffer">
                <div class="col-lg-12 col-md-12 col-sm-12 top-buffer">
                    <div class="col-lg-7 col-md-7 col-sm-7 top-buffer">
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-2 top-buffer" style="font-weight: bold;">
                        <strong style="font-size: 16px; font-weight: bold;">Total Qty : </strong>
                        <asp:Label runat="server" ID="LblTotalQty" Style="font-size: 16px;"></asp:Label>
                    </div>
                    <div class="col-lg-3 col-md-3 col-sm-3 top-buffer" style="font-weight: bold;">
                        <strong style="font-size: 16px; font-weight: bold;">Gross Rs : </strong>
                        <asp:Label runat="server" ID="LblGrossRs" Style="font-size: 16px;"></asp:Label>
                    </div>
                </div>
            </div>
            <asp:UpdatePanel runat="server" ID="up2">
                <ContentTemplate>
                    <div class="col-lg-12 col-md-12 col-sm-12" style="border-top: 1px solid grey;">
                        <div class="col-lg-12 col-md-12 col-sm-12">
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-2">
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-2">
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-2">
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-2">
                        </div>
                        <div class="col-lg-1 col-md-1 col-sm-1" style="text-align: right">
                            <strong>CGST</strong>
                        </div>
                        <div class="col-lg-1 col-md-1 col-sm-1 inputCenter">
                            <asp:TextBox runat="server" ID="TxtVatPer" CssClass="bsinputred" TabIndex="1" AutoPostBack="true" Style="display: none"
                                OnTextChanged="TxtVatPer_TextChanged" />
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-2 inputLeft">
                            <asp:TextBox runat="server" ID="TxtVatRs" CssClass="bsinputred" TabIndex="1" Enabled="false" />
                        </div>
                    </div>
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <div class="col-lg-2 col-md-2 col-sm-2" style="text-align: center;">
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-2 inputCenter">
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-3 inputCenter">
                        </div>
                        <div class="col-lg-1 col-md-1 col-sm-1 inputCenter">
                        </div>
                        <div class="col-lg-1 col-md-1 col-sm-1 inputCenter" style="text-align: right">
                            <strong>SGST</strong>
                        </div>
                        <div class="col-lg-1 col-md-1 col-sm-1 inputCenter">
                            <asp:TextBox runat="server" ID="TxtExtraPer" CssClass="bsinputred" TabIndex="1" AutoPostBack="true" Style="display: none"
                                OnTextChanged="TxtExtraPer_TextChanged" />
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-2 inputLeft">
                            <asp:TextBox runat="server" ID="TxtExtraRs" CssClass="bsinputred" TabIndex="1" Enabled="false" />
                        </div>
                    </div>
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <div class="col-lg-2 col-md-2 col-sm-2" style="text-align: center;">
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-2 inputCenter">
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-3 inputCenter">
                        </div>
                        <div class="col-lg-1 col-md-1 col-sm-1 inputCenter">
                        </div>
                        <div class="col-lg-1 col-md-1 col-sm-1 inputCenter" style="text-align: right">
                            <strong>IGST</strong>
                        </div>
                        <div class="col-lg-1 col-md-1 col-sm-1 inputCenter">
                            <asp:TextBox runat="server" ID="TxtIGSTPer" CssClass="bsinputred" TabIndex="1" AutoPostBack="true" Style="display: none"
                                OnTextChanged="TxtExtraPer_TextChanged" />
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-2 inputLeft">
                            <asp:TextBox runat="server" ID="TxtIGST" CssClass="bsinputred" TabIndex="1" Enabled="false" />
                        </div>
                    </div>
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <div class="col-lg-2 col-md-2 col-sm-2" style="text-align: center;">
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-2 inputCenter">
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-3 inputCenter">
                        </div>
                        <div class="col-lg-1 col-md-1 col-sm-1 inputCenter">
                        </div>
                        <div class="col-lg-1 col-md-1 col-sm-1 inputCenter" style="text-align: right">
                            <strong>Amount</strong>
                        </div>
                        <div class="col-lg-1 col-md-1 col-sm-1 inputCenter">
                            <asp:TextBox runat="server" ID="TextBox1" CssClass="bsinputred" TabIndex="1" AutoPostBack="true"
                                OnTextChanged="TxtExtraPer_TextChanged" Visible="false" />
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-2 inputLeft">
                            <asp:TextBox runat="server" ID="LblAmt" CssClass="bsinputred" TabIndex="1" Enabled="false" />
                            <%--<asp:Label runat="server" ID="LblAmt"></asp:Label>--%>
                        </div>
                    </div>
                    <div class="col-lg-12 col-md-12 col-sm-12" style="display:none">
                        <div class="col-lg-2 col-md-2 col-sm-2" style="text-align: center;">
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-2 inputCenter">
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-3 inputCenter">
                        </div>
                        <div class="col-lg-1 col-md-1 col-sm-1 inputCenter">
                        </div>
                        <div class="col-lg-1 col-md-1 col-sm-1 inputRight" style="text-align: right">
                            <strong>Disc</strong>
                        </div>
                        <div class="col-lg-1 col-md-1 col-sm-1 inputRight" style="text-align: right;">
                            <asp:TextBox runat="server" ID="TxtDisPer" CssClass="bsinputred" TabIndex="1" AutoPostBack="true"
                                OnTextChanged="TxtDisPer_TextChanged" />
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-2 inputLeft">
                            <asp:TextBox runat="server" ID="TxtDisRs" CssClass="bsinputred" TabIndex="1" AutoPostBack="true" OnTextChanged="TxtDisRS_TextChanged" />
                        </div>
                    </div>

                         <div class="col-lg-12 col-md-12 col-sm-12 top-buffer">
                <div class="col-lg-12 col-md-12 col-sm-12 top-buffer">
                    <div class="col-lg-8 col-md-8 col-sm-8 top-buffer">
                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-4 top-buffer">
                        <asp:GridView ID="GvAddLess" runat="server" AutoGenerateColumns="false" class="table1 table-responsive table-bordered table-hover">
                            <Columns>
                                <%--<asp:BoundField DataField="NID" HeaderText="" ItemStyle-Width="1px" ItemStyle-ForeColor="Transparent"
                                    ItemStyle-Font-Size="1px" />--%>
                                <%--<asp:BoundField HeaderText="" DataField="cAccountType" ItemStyle-Font-Size="1px"
                                    ItemStyle-ForeColor="Transparent" />--%>
                                <asp:TemplateField HeaderText="" ItemStyle-Font-Size="1px" ItemStyle-ForeColor="Transparent">
                                    <ItemStyle Width="1px" ></ItemStyle>
                                    <ItemTemplate >
                                        <asp:Label ID="LblNID" runat="server" Text='<%# Bind("NID") %>'>
                                        </asp:Label></ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="Acc" DataField="cDescription" />
                                <%--<asp:BoundField HeaderText="Addless" DataField="cAddless" />--%>

                                 <asp:TemplateField HeaderText="Addless" ItemStyle-Width="15px">
                                    <ItemTemplate>
                                        <asp:Label ID="LblAddLess" runat="server" Text='<%# Bind("cAddless") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Per%" ItemStyle-Width="15px">
                                    <ItemTemplate>
                                        <asp:TextBox ID="TxtAddLessPer" runat="server" CssClass="bsinputred"  Text='<%# Bind("nPer") %>' AutoPostBack="true" OnTextChanged="TxtAddLessPer_TextChanged"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Amt">
                                    <ItemTemplate>
                                        <asp:TextBox ID="TxtAddLessRs" runat="server" CssClass="bsinputred" Text='<%# Bind("nRs") %>' Enabled=false></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>

                   <br /><br /><br /><br /><br /><br /><br /><br /> <div class="col-lg-12 col-md-12 col-sm-12">
                        <div class="col-lg-2 col-md-2 col-sm-2" style="text-align: center;">
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-2 inputCenter">
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-3 inputCenter">
                        </div>
                        <div class="col-lg-1 col-md-1 col-sm-1 inputCenter">
                        </div>
                        <div class="col-lg-1 col-md-1 col-sm-1 inputRight" style="text-align: right">
                            <strong>Round Off</strong>
                        </div>
                        <div class="col-lg-1 col-md-1 col-sm-1 inputRight" style="text-align: right;">
                          <asp:Label runat="server" ID="LblRoundOff"></asp:Label>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-2 inputLeft">
                           
                        </div>
                    </div>
                     <br /><br />
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
                            OnClick="btnsave_Click" Text="Save" TabIndex="2" />
                        <asp:Button runat="server" ID="btncancel" class="btn btn-info SaveCancel btnCancel"
                            Text="Cancel" TabIndex="3" OnClick="btncancel_Click" />
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
                            <span class="contentLabel">Net Rs</span>&nbsp;:&nbsp;&nbsp;<asp:Label runat="server"
                                ID="LblNetRs"></asp:Label>
                        </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
    <br />
    <br />
    <br />
    <br />
</asp:Content>




