<%@ Page Title="" Language="C#" MasterPageFile="~/BillMaster.master" AutoEventWireup="true" CodeFile="MasterGroup.aspx.cs" Inherits="MasterGroup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 <script type="text/javascript">
     function ScuessMsg(type) {
         if (type == 'I') {
             alertify.alert("You have Sucessfully Add Group", function () {
                 location.href = 'MasterGroup.aspx';
             });
         }
         if (type == 'U') {
             alertify.alert("You have Sucessfully Update Group", function () {
                 location.href = 'ListMasterGroup.aspx';
             });
         }
         if (type == 'D') {

             alertify.alert("You have Sucessfully Delete Group", function () {
                 location.href = 'ListMasterGroup.aspx';
             });
         }
     }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="panel">
        <div class="panel-heading">
            <h2 class="panel-title">
                Group Master
                <button type="button" name="btnList" runat="server" id="btnList" class="btn btn-info AddList"
                    onclick="location.href = 'ListMasterGroup.aspx'" tabindex="4" style="float: right;">
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
        <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-2 col-md-2 col-sm-2 col-xs-10">
                        <strong class="contentLabel">Group Code</strong>
                    </div>
                    <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
                        <asp:TextBox runat="server" ID="TxtGroupCode" CssClass="bsinputblue" TabIndex="2" Width="150px" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TxtGroupCode"
                            ErrorMessage="&lt;img src='assets/img/writing-icon.jpg' title='DELETE' alt='View' border='0'/&gt;"
                            ValidationGroup="Main"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-lg-7 col-md-7 col-sm-7 col-xs-12">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-2 col-md-2 col-sm-2 col-xs-10">
                        <strong class="contentLabel">Group Name</strong>
                    </div>
                    <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
                        <asp:TextBox runat="server" ID="TxtGroupName" CssClass="bsinputblue" TabIndex="1" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TxtGroupName"
                            ErrorMessage="&lt;img src='assets/img/writing-icon.jpg' title='DELETE' alt='View' border='0'/&gt;"
                            ValidationGroup="Main"></asp:RequiredFieldValidator>

                    </div>
                    <div class="col-lg-7 col-md-7 col-sm-7 col-xs-12">
                    </div>
                </div>
            </div>
              
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-2 col-md-2 col-sm-2 col-xs-10">
                        <strong class="contentLabel">Group Position</strong>
                    </div>
                    <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
                        <asp:TextBox runat="server" ID="TxtGroupPosition" CssClass="bsinputred" TabIndex="3" Text="0" />
                           <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TxtGroupPosition"
                            ErrorMessage="&lt;img src='assets/img/writing-icon.jpg' title='DELETE' alt='View' border='0'/&gt;"
                            ValidationGroup="Main"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-lg-7 col-md-7 col-sm-7 col-xs-12">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-2 col-md-2 col-sm-2 col-xs-10">
                        <strong class="contentLabel">Acc Type</strong>
                    </div>
                    <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
                        <asp:DropDownList runat="server" ID="DDLAccType" TabIndex="4" CssClass="bsinputblue" style="width:150px;">
                        <asp:ListItem Value="1">Other</asp:ListItem>
                        <asp:ListItem Value="2">Customer/Spplier</asp:ListItem>
                        <asp:ListItem Value="3">Incode/Expense</asp:ListItem>
                        <asp:ListItem Value="4">Bank/Cash</asp:ListItem>
                        <asp:ListItem Value="5">Broker</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-lg-7 col-md-7 col-sm-7 col-xs-12">
                    </div>
                </div>
            </div>
            <div class="BottomFixed">
                <%-- <button type="button" name="btnSave" id="btnSave" class="btn btn-success SaveCancel btnSave"
                    tabindex="6" onclick="AddUpdateDelete()">
                    <i class="icon fa-save SaveCancelIcon iSave" id="iSave"></i><span id="spanSave" class="spanSave">
                    </span>
                </button>--%>
                <asp:DropDownList ID="ddldelete" runat="server" Visible="false">
                    <asp:ListItem>No</asp:ListItem>
                    <asp:ListItem Value="Yes">Yes</asp:ListItem>
                </asp:DropDownList>
                <asp:Button runat="server" ID="btnsave" class="btn btn-success SaveCancel btnSave" ValidationGroup="Main"
                    OnClick="btnsave_Click" Text="Save" TabIndex="5" />
                <asp:Button runat="server" ID="btncancel" class="btn btn-info SaveCancel btnCancel"
                    Text="Cancel" TabIndex="6" OnClick="btncancel_Click" />
                <%--<button type="button" name="btnCancel" id="btnCancel" class="btn btn-info SaveCancel btnCancel"
                    tabindex="7" onclick="GoToDefaultPage()">
                    <i class="icon fa-close SaveCancelIcon iCancel"></i><span id="spanCancel" class="spanCancel">
                    </span>
                </button>--%>
            </div>
        </div>
    </div>
</asp:Content>


