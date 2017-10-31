<%@ Page Title="Account Master" Language="C#" MasterPageFile="~/BillMaster.master" AutoEventWireup="true" CodeFile="ListMasterAccount.aspx.cs" Inherits="ListMasterAccount" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 <script src="global/vendor/datatables-responsive-BJ/jquery-1.12.3.js" type="text/javascript"></script>
    <script src="global/vendor/datatables-responsive-BJ/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="global/vendor/datatables-responsive-BJ/dataTables.bootstrap.min.js" type="text/javascript"></script>
    <script src="global/vendor/datatables-responsive-BJ/dataTables.responsive.min.js" type="text/javascript"></script>
    <script src="global/vendor/datatables-responsive-BJ/responsive.bootstrap.min.js" type="text/javascript"></script>
    <link href="global/vendor/datatables-responsive-BJ/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="global/vendor/datatables-responsive-BJ/responsive.bootstrap.min.css" rel="stylesheet" type="text/css" />
    <script src="global/vendor/datatables-responsive-BJ/natural.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            var asInitVals = new Array();
            //$('#divProgressBar').attr('style', 'display:none;');
            var oTable = $('#datatable').DataTable({
                columns: [
                //{ 'data': 'NID' },
                    { 'data': 'cName' },
                    { 'data': 'cCity' },
                    { 'data': 'cConNo' },
                    { 'data': 'cOtherDetail' },
                    { 'data': 'cedit' },
                    { 'data': 'cdelete' }
                ],
                "aoColumnDefs": [
                        {
                            'bSortable': false,
                            'aTargets': [4, 5]
                        } //disables sorting for column one
                ],

                bServerSide: true,
                sAjaxSource: 'ListPage.asmx/ListAccount',
                sServerMethod: 'post',
                "sPaginationType": "full_numbers",
                'iDisplayLength': 100,
                "sDom": '<"top"fp<"clear">>rt<"bottom"i<"clear">>',
            });
            //$(tableTools.fnContainer()).insertBefore('#datatable_wrapper');




        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="panel">
        <div class="panel-heading">
            <h2 class="panel-title">List Account Master
                <%-- <button type="button" name="btnList" runat="server" id="btnList" class="btn btn-info AddList"
                    onclick="location.href = 'ListMasterItemGroup.aspx'" tabindex="4" style="float: right;">
                    <i class="icon wb-list"></i><span class="spanList"></span>
                </button>--%>
                <button type="button" name="btnAdd" runat="server" id="btnAdd" class="btn btn-success AddList"
                    onclick="location.href = 'MasterAcccount.aspx'" tabindex="5" style="float: right; margin-right: 4px;">
                    <i class="icon wb-plus" style="margin-left: 0px; padding-left: 0px;"></i><span class="spanNew"></span>
                </button>
            </h2>
            <div>
                <div class="clearfix">
                </div>
            </div>
        </div>
        <div class="panel-body">
            <div class="x_content">
                <div id="MyDiv" class="DataTableDivBJ">
                    <div id="datatable_wrapper" class="dataTables_wrapper" role="grid">
                        <table id="datatable" width="100%" area-describedby="datatable_info" cellspacing="1px"
                            class="table table-responsive table-bordered table-hover">
                            <thead>
                                <tr style="background-color: #2A3F54; color: #fff; height: 34px;">
                                    <th style="padding: 5px 0px 5px 5px;">Name
                                    </th>
                                    <th style="width: 150px; padding: 5px 0px 5px 5px;">City
                                    </th>
                                    <th style="width: 150px; padding: 5px 0px 5px 5px;">Contact No
                                    </th>
                                    <th style="width: 200px; padding: 5px 0px 5px 5px;">GSTN NO
                                    </th>
                                    <th style="width: 50px; padding: 5px 0px 5px 5px;">&nbsp;
                                    </th>
                                    <th style="width: 50px; padding: 5px 0px 5px 5px;">&nbsp;
                                    </th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

