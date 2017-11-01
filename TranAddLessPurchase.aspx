<%@ Page Title="" Language="C#" MasterPageFile="~/BillMaster.master" AutoEventWireup="true" CodeFile="TranAddLessPurchase.aspx.cs" Inherits="TranAddLessPurchase" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
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

        function select_Acc(sender, e) {
            var hd = $get("<%=HIDAccount.ClientID %>");
            hd.value = e.get_value();

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">

        <ContentTemplate>

            <div class="panel">
                <div class="panel-heading">
                    <h2 class="panel-title">Add / Less Purchase
                    </h2>
                </div>
                <div class="clearfix">
                </div>
                <div class="panel-content marginTopContent">
                    <table style="margin-left: 40px;" class="table1">
                        <tr>
                            <td style="width: 270px;">
                                <strong class="contentLabel">Descriptions</strong>
                            </td>
                            <td style="display: none;">
                                <strong class="contentLabel">Account Name</strong>
                            </td>
                            <td style="width: 150px;">
                                <strong class="contentLabel">Add / Less</strong>
                            </td>
                            <td style="width: 150px;">
                                <strong class="contentLabel">Per</strong>
                            </td>
                            <td style="width: 150px;">
                                <strong class="contentLabel">Account</strong>
                            </td>
                            <td style="width: 150px;display:none">
                                <strong class="contentLabel">Rs</strong>
                            </td>
                            <td style="width: 180px;display:none">
                                <strong class="contentLabel">Type</strong>
                            </td>
                            <td style="width: 180px;display:none">
                                <strong class="contentLabel">Count on Below Total</strong>
                            </td>
                            <td></td>

                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox runat="server" ID="TxtDescription" CssClass="bsinputblue" TabIndex="1"
                                    Style="width: 240px;" />


                            </td>
                            <td style="display: none;">
                                <asp:TextBox runat="server" ID="TxtAccountName" CssClass="bsinputblue" TabIndex="1"
                                    Style="width: 120px;" />

                            </td>
                            <td>
                                <asp:DropDownList ID="DdlAddLess" runat="server" CssClass="bsinputblue" Style="width: 100px;" TabIndex="1">
                                    <asp:ListItem>+</asp:ListItem>
                                    <asp:ListItem>-</asp:ListItem>
                                </asp:DropDownList>

                            </td>
                            <td>
                                <asp:TextBox runat="server" ID="TxtPer" CssClass="bsinputred" TabIndex="1"
                                    Style="width: 120px;" />

                            </td>
                            <td>
                                <asp:TextBox runat="server" ID="TxtAccount"  CssClass="bsinputgreen" Width="300px"
                                    Style="background: #E6f2f2; border: 1px solid DarkGray; border-radius: 3px; height: 22px;" />
                            
                            <cc1:AutoCompleteExtender ServiceMethod="SearchAccount" MinimumPrefixLength="1" OnClientItemSelected="select_Acc"
                                CompletionInterval="100" EnableCaching="false" CompletionSetCount="10" TargetControlID="TxtAccount"
                                ID="AutoCompleteExtender1" runat="server" FirstRowSelected="true" CompletionListCssClass="AutoComplete_completionListElement"
                                CompletionListItemCssClass="AutoComplete_listItem" CompletionListHighlightedItemCssClass="AutoComplete_highlightedListItem">
                            </cc1:AutoCompleteExtender>
                            <asp:HiddenField ID="HIDAccount" runat="server" />
                            </td>
                            <td style="display:none">
                                <asp:TextBox runat="server" ID="TxtRs" CssClass="bsinputred" TabIndex="1"
                                    Style="width: 120px;" />

                            </td>
                             <td style="display:none">
                                <asp:DropDownList ID="DDLType" runat="server" CssClass="bsinputblue" Style="width: 100px;" TabIndex="1">
                                    <%--<asp:ListItem>S-GST</asp:ListItem>
                                    <asp:ListItem>C-GST</asp:ListItem>
                                    <asp:ListItem>I-GST</asp:ListItem>
                                    <asp:ListItem>CESS</asp:ListItem>--%>
                                    <asp:ListItem>Other</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td style="display:none">
                                <asp:DropDownList ID="DDLCountBelow" runat="server" CssClass="bsinputblue" Style="width: 100px;" TabIndex="1">
                                    <asp:ListItem Selected="True" Value="0">No</asp:ListItem>
                                    <asp:ListItem Value="1">Yes</asp:ListItem>
                                </asp:DropDownList>

                            </td>
                            <td>
                                <asp:ImageButton ID="ImgBtnAdd" ImageUrl="assets/img/add.png" runat="server" TabIndex="1"
                                    Height="20px" ValidationGroup="Child" CssClass="buttoncss" OnClick="ImgBtnAdd_Click" />

                            </td>
                        </tr>
                        <tr>
                            <td colspan="5" style="height: 20px;"></td>

                        </tr>
                        <tr>
                            <td colspan="5">
                                <asp:GridView ID="GVaddless" runat="server" AutoGenerateColumns="false" class="table1 table-responsive table-bordered table-hover">
                                    <Columns>
                                        <asp:BoundField DataField="NID" HeaderText="" ItemStyle-Width="1px" ItemStyle-ForeColor="Transparent"
                                            ItemStyle-Font-Size="1px" />
                                        <asp:BoundField HeaderText="Description" DataField="cDescription" ItemStyle-Width="290px" />
                                        <asp:BoundField HeaderText="Add/Less" DataField="cAddless" />
                                        <asp:BoundField HeaderText="Per" DataField="nPer" />
                                        <asp:BoundField HeaderText="Account" DataField="cName" />
                                        <%--<asp:BoundField HeaderText="Rs" DataField="nRs" />
                                        <asp:BoundField HeaderText="Type" DataField="cAccountType" />
                                        <asp:BoundField HeaderText="Count on Below Total" DataField="nCountOnTotal" ItemStyle-Width="150px" />--%>
                                        <asp:TemplateField HeaderText="Edit" ItemStyle-Width="5%">
                                            <ItemTemplate>
                                                <a href="TranAddLessPurchase.aspx?id=<%# DataBinder.Eval(Container.DataItem , "NID") %>&E=1">
                                                    <asp:Image ID="ImgEdit" ImageUrl="assets/img/edit.png" runat="server" title="Edit" />
                                                </a>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Delete" ItemStyle-Width="5%">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="ImgDelete1" ImageUrl="assets/img/delete.png" runat="server"
                                                    title="Delete" OnClientClick="Confirm_box()" OnClick="ImgDelete1_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>

                        </tr>
                    </table>

                </div>

            </div>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="ImgBtnAdd" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="GVaddless" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>

