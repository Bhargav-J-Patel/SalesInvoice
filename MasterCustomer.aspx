<%@ Page Title="" Language="C#" MasterPageFile="~/BillMaster.master" AutoEventWireup="true"
    CodeFile="MasterCustomer.aspx.cs" Inherits="MasterCustomer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">


        function ScuessMsg(type) {

            if (type == 'I') {
                alertify.alert("You have Sucessfully Add Customer", function () {
                    location.href = 'MasterCustomer.aspx';
                });
            }
            if (type == 'U') {
                alertify.alert("You have Sucessfully Update Customer", function () {
                    location.href = 'ListMasterCustomer.aspx';
                });
            }
            if (type == 'D') {
                alertify.alert("You have Sucessfully Delete Customer", function () {
                    location.href = 'ListMasterCustomer.aspx';
                });
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="panel">
        <div class="panel-heading">
            <h2 class="panel-title">
                Customer Master
                <button type="button" name="btnList" runat="server" id="btnList" class="btn btn-info AddList"
                    onclick="location.href = 'ListMasterCustomer.aspx'" tabindex="16" style="float: right;">
                    <i class="icon wb-list"></i><span class="spanList"></span>
                </button>
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
                        <strong class="contentLabel">Name</strong>
                    </div>
                    <div class="col-lg-3 col-md-3
        col-sm-3 col-xs-12">
                        <asp:TextBox runat="server" ID="TxtCustName" CssClass="bsinputblue" TabIndex="1" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TxtCustName"
                            ErrorMessage="&lt;img src='assets/img/writing-icon.jpg' title='DELETE' alt='View' border='0'/&gt;"
                            ValidationGroup="Main"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-1 col-xs-12">
                        <strong class="contentLabel">ContactPerson</strong>
                    </div>
                    <div class="col-lg-3 col-md-3
        col-sm-3 col-xs-12">
                        <asp:TextBox runat="server" ID="TxtConPName" CssClass="bsinputblue" TabIndex="2" />
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
                    </div>
                </div>
            </div>
            <div class="row top-buffer">
                <div class="col-lg-12
        col-md-12 col-sm-12">
                    <div class="col-lg-1 col-md-1 col-sm-1 col-xs-12">
                        <strong class="contentLabel">Contact No</strong>
                    </div>
                    <div class="col-lg-3 col-md-3 col-sm-3
        col-xs-12">
                        <asp:TextBox runat="server" ID="TxtcContactNo" CssClass="bsinputblue" TabIndex="8" />
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-1 col-xs-12">
                        <strong class="contentLabel">Email ID</strong>
                    </div>
                    <div class="col-lg-3 col-md-3 col-sm-3
        col-xs-12">
                        <asp:TextBox runat="server" ID="TxtEmailID" CssClass="bsinputblue" TabIndex="9" onkeyup="emailChange(this.value,'keyup')" />
                        <i id="i2"></i>
                    </div>
                    <div class="col-lg-3
        col-md-3 col-sm-3 col-xs-12">
                    </div>
                </div>
            </div>
            <div class="row top-buffer">
                <div class="col-lg-12 col-md-6 col-sm-6">
                    <div class="col-lg-1 col-md-1 col-sm-1 col-xs-12">
                        <strong class="contentLabel">Address</strong></div>
                    <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
                        <asp:TextBox runat="server" ID="TxtAddress" CssClass="bsinputbluemulti" TabIndex="3"
                            Height="120px" TextMode="MultiLine" />
                        <i id="i1"></i>
                    </div>
                    <div class="col-lg-1 col-md-2 col-sm-3 col-xs-2">
                        <div class="top-buffer" style="margin-top: 7px;">
                            <strong class="contentLabel">City</strong></div>
                        <div class="top-buffer" style="margin-top: 5px;">
                            <strong class="contentLabel">PinCode</strong></div>
                        <div class="short-div top-buffer" style="margin-top: 10px;">
                            <strong class="contentLabel">State</strong></div>
                        <div class="short-div top-buffer" style="margin-top: 5px;">
                            <strong class="contentLabel">Country</strong></div>
                    </div>
                    <div class="col-lg-3 col-md-2 col-sm-3 col-xs-2">
                        <div class="short-div top-buffer">
                            <asp:TextBox runat="server" ID="TxtCity" CssClass="bsinputblue" TabIndex="4" /></div>
                        <div class="short-div top-buffer">
                            <asp:TextBox runat="server" ID="TxtPinCode" CssClass="bsinputblue" TabIndex="5" /></div>
                        <div class="short-div top-buffer">
                            <asp:TextBox runat="server" ID="TxtState" CssClass="bsinputblue" TabIndex="6" /></div>
                        <div class="short-div top-buffer">
                            <asp:TextBox runat="server" ID="TxtCountry" CssClass="bsinputblue" TabIndex="7" /></div>
                    </div>
                </div>
            </div>
            <div class="row top-buffer">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-1 col-md-1 col-sm-1 col-xs-12">
                        <strong class="contentLabel">State code</strong>
                    </div>
                    <div class="col-lg-3
        col-md-3 col-sm-3 col-xs-12">
                        <asp:TextBox runat="server" ID="TxtTinNo" CssClass="bsinputblue" TabIndex="10" />
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-1 col-xs-10">
                        <strong class="contentLabel">VAT No</strong>
                    </div>
                    <div class="col-lg-3 col-md-3 col-sm-3
        col-xs-12">
                        <asp:TextBox runat="server" ID="TxtVatNo" CssClass="bsinputblue" TabIndex="11" />
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
                    </div>
                </div>
            </div>
            <div class="row top-buffer">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-1 col-md-1 col-sm-1 col-xs-12">
                        <strong class="contentLabel">PAN No</strong>
                    </div>
                    <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
                        <asp:TextBox runat="server" ID="TxtcPANNo" CssClass="bsinputblue" TabIndex="12" />
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-1
        col-xs-10">
                        <strong class="contentLabel">GSTIN No</strong>
                    </div>
                    <div class="col-lg-3
        col-md-3 col-sm-3 col-xs-12">
                        <asp:TextBox runat="server" ID="TxtOtherDetail" CssClass="bsinputblue" TabIndex="13" />
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
                    </div>
                </div>
            </div>
       

         <div class="row top-buffer">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-1 col-md-1 col-sm-1 col-xs-12">
                        <strong class="contentLabel">Bank No</strong>
                    </div>
                    <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
                        <asp:TextBox runat="server" ID="TxtBankName" CssClass="bsinputblue" TabIndex="12" />
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-1
        col-xs-10">
                        <strong class="contentLabel">IFSC Code</strong>
                    </div>
                    <div class="col-lg-3
        col-md-3 col-sm-3 col-xs-12">
                        <asp:TextBox runat="server" ID="TxtIFSCCode" CssClass="bsinputblue" TabIndex="13" />
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
                    </div>
                </div>
            </div>
        

        <div class="row top-buffer">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-1 col-md-1 col-sm-1 col-xs-12">
                        <strong class="contentLabel">Account No</strong>
                    </div>
                    <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
                        <asp:TextBox runat="server" ID="TxtAccount" CssClass="bsinputblue" TabIndex="12" />
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-1
        col-xs-10">
                        <strong class="contentLabel">Branch</strong>
                    </div>
                    <div class="col-lg-3
        col-md-3 col-sm-3 col-xs-12">
                        <asp:TextBox runat="server" ID="TxtBranch" CssClass="bsinputblue" TabIndex="13" />
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
                    </div>
                </div>
            </div>
        </div>

        <div class="BottomFixed">
            <asp:DropDownList ID="ddldelete" runat="server" Visible="false">
                <asp:ListItem>No</asp:ListItem>
                <asp:ListItem Value="Yes">Yes</asp:ListItem>
            </asp:DropDownList>
            <asp:Button runat="server" ID="btnsave" class="btn btn-success SaveCancel btnSave" ValidationGroup="Main"
                OnClick="btnsave_Click" Text="Save" TabIndex="14" />
            <asp:Button runat="server" ID="btncancel" class="btn btn-info SaveCancel btnCancel"
                Text="Cancel" TabIndex="15" OnClick="btncancel_Click" />
        </div>
    </div>
    <asp:HiddenField ID="HFNID" runat="server" />
</asp:Content>
