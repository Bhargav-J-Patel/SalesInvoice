<%@ Page Title="" Language="C#" MasterPageFile="~/BillMaster.master" AutoEventWireup="true"
    CodeFile="MasterItemGroup.aspx.cs" Inherits="MasterItemGroup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function ScuessMsg(type) {
            if (type == 'I') {
                alertify.alert("You have Sucessfully Add ItemGroup", function () {
                    location.href = 'MasterItemGroup.aspx';
                });
            }
            if (type == 'U') {
                alertify.alert("You have Sucessfully Update ItemGroup", function () {
                    location.href = 'ListMasterItemGroup.aspx';
                });
            }
            if (type == 'D') {

                alertify.alert("You have Sucessfully Delete ItemGroup", function () {
                    location.href = 'ListMasterItemGroup.aspx';
                });
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="panel">
        <div class="panel-heading">
            <h2 class="panel-title">
                Item Group Master
                <button type="button" name="btnList" runat="server" id="btnList" class="btn btn-info AddList"
                    onclick="location.href = 'ListMasterItemGroup.aspx'" tabindex="4" style="float: right;">
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
                        <strong class="contentLabel">Item Group Name</strong>
                    </div>
                    <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
                        <asp:TextBox runat="server" ID="TxtItemGroupName" CssClass="bsinputblue" TabIndex="1" />
                    </div>
                    <div class="col-lg-7 col-md-7 col-sm-7 col-xs-12">
                    </div>
                </div>
            </div>
              <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-2 col-md-2 col-sm-2 col-xs-10">
                        <strong class="contentLabel">HSN Code</strong>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
                        <asp:TextBox runat="server" ID="TxtHsnCode" CssClass="bsinputblue" TabIndex="2" />
                    </div>
                    <div class="col-lg-7 col-md-7 col-sm-7 col-xs-12">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-2 col-md-2 col-sm-2 col-xs-10">
                        <strong class="contentLabel">CGST</strong>
                    </div>
                    <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
                        <asp:TextBox runat="server" ID="TxtCGSTPer" CssClass="bsinputred" TabIndex="1" />
                    </div>
                    <div class="col-lg-7 col-md-7 col-sm-7 col-xs-12">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-2 col-md-2 col-sm-2 col-xs-10">
                        <strong class="contentLabel">SGST</strong>
                    </div>
                    <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
                        <asp:TextBox runat="server" ID="TxtSGSTPer" CssClass="bsinputred" TabIndex="1" />
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
                <asp:Button runat="server" ID="btnsave" class="btn btn-success SaveCancel btnSave"
                    OnClick="btnsave_Click" Text="Save" TabIndex="2" />
                <asp:Button runat="server" ID="btncancel" class="btn btn-info SaveCancel btnCancel"
                    Text="Cancel" TabIndex="3" OnClick="btncancel_Click" />
                <%--<button type="button" name="btnCancel" id="btnCancel" class="btn btn-info SaveCancel btnCancel"
                    tabindex="7" onclick="GoToDefaultPage()">
                    <i class="icon fa-close SaveCancelIcon iCancel"></i><span id="spanCancel" class="spanCancel">
                    </span>
                </button>--%>
            </div>
        </div>
    </div>
</asp:Content>
