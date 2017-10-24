<%@ Page Title="" Language="C#" MasterPageFile="~/BillMaster.master" AutoEventWireup="true" CodeFile="Systemsetting.aspx.cs" Inherits="Systemsetting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">


        function ScuessMsg(type) {

            if (type == 'U') {
                alertify.alert("You have Sucessfully Update System Setting", function () {
                    location.href = 'Systemsetting.aspx';
                });
            }

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
            <div class="row">
                <div class="col-lg-12
        col-md-12 col-sm-12">
                    <div class="col-lg-1 col-md-1 col-sm-1 col-xs-12">
                        <strong class="contentLabel">State code</strong>


                    </div>
                    <div class="col-lg-3 col-md-3
        col-sm-3 col-xs-12">
                        <asp:TextBox runat="server" ID="Txtstatecode" CssClass="bsinputblue" Width="150px" />
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

