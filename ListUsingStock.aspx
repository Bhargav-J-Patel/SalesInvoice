<%@ Page Title="" Language="C#" MasterPageFile="~/BillMaster.master" AutoEventWireup="true" CodeFile="ListUsingStock.aspx.cs" Inherits="ListUsingStock" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script src="js/icheck/icheck.min.js" type="text/javascript"></script>
<script src="js/datatables/js/jquery.dataTables.js" type="text/javascript"></script>
    <script src="js/datatables/js/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="js/datatables/tools/js/dataTables.tableTools.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {

            $('input.tableflat').iCheck({
                checkboxClass: 'icheckbox_flat-green',
                radioClass: 'iradio_flat-green'
            });
            var asInitVals = new Array();
            //$('#divProgressBar').attr('style', 'display:none;');
            var oTable = $('#datatable').DataTable({
                columns: [
                //{ 'data': 'NID' },


                    {'data': 'nSrNo' },
                     { 'data': 'dDate' },

                    { 'data': 'cedit' },
                    { 'data': 'cdelete' }

                ],
                "aoColumnDefs": [
                        {
                            'bSortable': false,
                            'aTargets': [2, 3]
                        } //disables sorting for column one
                        ],

                bServerSide: true,
                sAjaxSource: 'ListPage.asmx/ListUsingStock',
                sServerMethod: 'post',
                "sPaginationType": "full_numbers",
                'iDisplayLength': 50
            });
            //$(tableTools.fnContainer()).insertBefore('#datatable_wrapper');




        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="panel">
        <div class="panel-heading">
            <h2 class="panel-title">
               List Using Stock
               <%-- <button type="button" name="btnList" runat="server" id="btnList" class="btn btn-info AddList"
                    onclick="location.href = 'ListMasterItemGroup.aspx'" tabindex="4" style="float: right;">
                    <i class="icon wb-list"></i><span class="spanList"></span>
                </button>--%>
                <button type="button" name="btnAdd" runat="server" id="btnAdd" class="btn btn-success AddList"
                    onclick="location.href = 'TranUsingStock.aspx'" tabindex="5" style="float: right;
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
                <div class="widget-body">
                    <div id="MyDiv" class="modal-body">
                        <div id="datatable_wrapper" class="dataTables_wrapper" role="grid">
                            <table id="datatable" width="100%" area-describedby="datatable_info" cellspacing="1px"
                                class="table table-responsive table-bordered table-hover">
                                <thead>
                                    <tr style="background-color: #2A3F54; color: #fff; height: 34px;">
                                        <th style="width: 120px; padding: 5px 0px 5px 5px;">
                                            Sr No
                                        </th>
                                        <th style="width: 120px; padding: 5px 0px 5px 5px;">
                                           Date
                                        </th>
                                        
                                        <th style="width: 25px; padding: 5px 0px 5px 5px;">
                                            &nbsp;
                                        </th>
                                        <th style="width: 25px; padding: 5px 0px 5px 5px;">
                                            &nbsp;
                                        </th>
                                        
                                    </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>








