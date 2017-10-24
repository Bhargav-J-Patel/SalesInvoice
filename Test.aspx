<%@ Page Title="" Language="C#" MasterPageFile="~/BillMaster.master" AutoEventWireup="true"
    CodeFile="Test.aspx.cs" Inherits="Test" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        var inArray = new Array();
        var flag = true;
        var URL = '';
        var DATA = '';
        var Query = '';
        var ID;
        var E;
        var D;
        var CurrentHour = '';
        var CurrentMinute = '';
        var AMPM = '';

        $(document).on('keydown', function (e) {
            if (e.ctrlKey && e.keyCode == 83) {
                e.preventDefault();
                FinalSave();
            }
        });

        $(document).ready(function () {            
            var dNewDate = moment().add(-7, 'hours').format('DD/MM/YYYY');
            //alert(moment().add(-7, 'hours').hours());

            //GetCurrentDate();

            //$('body').attr('style', 'background-color:red;');

            //alert(moment().hour());
            //alert(moment().minutes());

            ID = GetParameterValues('ID');
            E = GetParameterValues('E');
            D = GetParameterValues('D');

            getAllStation(1);
            $(":input").inputmask();
            $('#<%=TxtdDate.ClientID %>').focus();
            $('#<%=HFIsDeposit.ClientID %>').val(0);

            if (ID == undefined) {
                GetCurrentDate();
                setTimeout(function () {
                    for (var i = 0; i < $('#<%=HFStationLength.ClientID%>').val() ; i++) {
                        $('#btnDetails_' + i).removeAttr('disabled');
                    }
                    //bCalendarExtenderdDate
                    var CalendarExtender1Behavior = $find("bCalendarExtenderdDate");
                    CalendarExtender1Behavior.set_selectedDate(getDateDJ(dNewDate, 'MM/dd/yyyy', 'dd/MM/yyyy'));
                    getTodayRate();
                    //For Pageload
                    DailySalesExists('PL');
                    
                    var dDateClosing = getDateDJ(dNewDate, 'MM/dd/yyyy', 'dd/MM/yyyy');
                    getStationOpening(dDateClosing);

                }, 200);
            }

            $('.NoteNoD').each(function (e) {
                $(this).css('width', '100%');
            });

            $('.NoteCountD').each(function (e) {
                $(this).css('width', '100%');
            });

            if (ID != undefined) {
                setTimeout(function () {
                    search(ID, 1);
                    $('#<%=HFCurrentShift.ClientID %>').val(1);
                    //alert($('#<%=HFCurrentShift.ClientID %>').val());
                    $('#<%=HFPID.ClientID %>').val(ID);
                    GetTotalRs();
                }, 1000);
            }
            $('.modal').draggable({
                handle: ".modal-header"
            });


        });

        function GetCurrentDate() {

            $.ajax({
                type: "POST",
                url: "TranCRUD.asmx/SetCurrentDate",
                data: "",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var currentDate = moment().add(response.d.addHours, 'hours').format('DD/MM/YYYY');
                    //alert(currentDate);
                    $('#<%=TxtdDate.ClientID %>').val(currentDate);
                },
                failure: function (response) {
                    alert(response.d.Msg);
                }
            });
        }

        function search(ID, Shift) {
            //SearchTblTranDailySales
            URL = 'TranCRUD.asmx/SearchTblTranDailySales';
            DATA = "{'PID':'" + ID + "','nShift':'" + Shift + "'}";
            setTimeout(function () {
                makeAjaxCall('Search', true);
            }, 100);


        }


        function DailySalesExists(Type) {
            $.ajax({
                type: "POST",
                url: "TranCRUD.asmx/TblTranDailySalesExists",
                data: "{'PID':'" + $('#<%=HFPID.ClientID %>').val() + "','dDate':'" + $('#<%=TxtdDate.ClientID %>').val() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d.Msg == "1") {
                        if (Type == "PL") {
                            $('#<%=TxtdDate.ClientID %>').val('');
                            $('#<%=TxtdDate.ClientID %>').focus();
                        }
                        else {
                            alertify.alert("Daily Sales already EXISTS for given Date!", function () {
                                $('#<%=TxtdDate.ClientID %>').val('');
                                $('#<%=TxtdDate.ClientID %>').focus();
                            });
                        }
                    }

                },
                failure: function (response) {
                    alert(response.d.Msg);
                }
            });
        }

        function getTodayRate() {
            $.ajax({
                type: "POST",
                url: "MasterCRUD.asmx/SearchRateByDate",
                data: "{'dDate':'" + $('#<%=TxtdDate.ClientID %>').val() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $('#<%=TxtnRate.ClientID %>').val(response.d.nSaleRate);
                    $('#<%=HFTodayRate.ClientID %>').val(response.d.nSaleRate);
                },
                failure: function (response) {
                    alert(response.d.Msg);
                }
            });
        }

        function shift1Click() {


            //alert($('').closest('li').hasClass('active'));
            if (!$('#liShift1').hasClass('active')) {
                getAllStation(1);
                $('#<%=HFCurrentShift.ClientID %>').val(1);
                $('#<%=HFIsDeposit.ClientID %>').val(0);
                setTimeout(function () {
                    if (ID != undefined) {
                        search(ID, 1);
                    }
                    else {
                        for (var i = 0; i < $('#<%=HFStationLength.ClientID%>').val() ; i++) {
                            $('#btnDetails_' + i).removeAttr('disabled');
                        }

                    }
                }, 600);



            }
            else {
                return false;
            }
        }

        function shift2Click() {
            if (!$('#liShift2').hasClass('active')) {
                getAllStation(2);
                $('#<%=HFCurrentShift.ClientID %>').val(2);
                $('#<%=HFIsDeposit.ClientID %>').val(0);
                setTimeout(function () {
                    if (ID != undefined) {
                        search(ID, 2);
                    }
                    else {
                        for (var i = 0; i < $('#<%=HFStationLength.ClientID%>').val() ; i++) {
                            $('#btnDetails_' + i).removeAttr('disabled');
                        }
                    }
                }, 600);


            }
            else {
                return false;
            }
        }

        function shift3Click() {
            if (!$('#liShift3').hasClass('active')) {
                getAllStation(3);
                $('#<%=HFCurrentShift.ClientID %>').val(3);
                $('#<%=HFIsDeposit.ClientID %>').val(0);
                setTimeout(function () {
                    if (ID != undefined) {
                        search(ID, 3);
                    }
                    else {
                        for (var i = 0; i < $('#<%=HFStationLength.ClientID%>').val() ; i++) {
                            $('#btnDetails_' + i).removeAttr('disabled');
                        }
                    }
                }, 600);


            }
            else {
                return false;
            }
        }


        function setColor(index) {


            for (var j = 0; j <= inArray.length; j++) {
                $('#divStation' + inArray[j]).attr('style', 'background-color:#FFF;');


                $('#txtnOpening_' + inArray[j]).attr('style', 'width:100%;max-width:205px;background:#FFE6E6');
                $('#txtnClosing_' + inArray[j]).attr('style', 'width:100%;max-width:205px;background:#FFE6E6');
                $('#txtnDiff_' + inArray[j]).attr('style', 'width:100%;max-width:205px;background:#FFE6E6');
                $('#txtnDiffRate_' + inArray[j]).attr('style', 'width:100%;max-width:205px;background:#FFE6E6');
                $('#txtnDepositRate_' + inArray[j]).attr('style', 'width:100%;max-width:205px;background:#FFE6E6');
                $('#txtnJumpRate_' + inArray[j]).attr('style', 'width:100%;max-width:205px;background:#FFE6E6');
                $('#txtnDiffAmt_' + inArray[j]).attr('style', 'width:100%;max-width:205px;background:#FFE6E6');
            }
            $('#divStation' + index).attr('style', 'background-color:aquamarine');

            $('#txtnOpening_' + index).attr('style', 'width:100%;max-width:205px;background:aquamarine');
            $('#txtnClosing_' + index).attr('style', 'width:100%;max-width:205px;background:aquamarine');
            $('#txtnDiff_' + index).attr('style', 'width:100%;max-width:205px;background:aquamarine');
            $('#txtnDiffRate_' + index).attr('style', 'width:100%;max-width:205px;background:aquamarine');
            $('#txtnDepositRate_' + index).attr('style', 'width:100%;max-width:205px;background:aquamarine');
            $('#txtnJumpRate_' + index).attr('style', 'width:100%;max-width:205px;background:aquamarine');
            $('#txtnDiffAmt_' + index).attr('style', 'width:100%;max-width:205px;background:aquamarine');

            style = "width:100%;max-width:205px;"
            inArray.push(index);

        }

        function DepositClick() {
            $('#btnAlertOK').unbind('click');
            var currentTime = '';
            CurrentHour = moment().hour();
            CurrentMinute = moment().minutes();

            //if (CurrentHour >= 0 && CurrentHour <= 12) {
            //    if (CurrentHour == 12) {
            //        AMPM = "PM";
            //    }
            //    else {
            //        AMPM = "AM";
            //    }
            //}
            //else {
            //    AMPM = "PM";
            //    CurrentHour = CurrentHour - 12;
            //}

            //currentTime = CurrentHour + ':' + CurrentMinute + ' ' + AMPM + '';
            currentTime = CurrentHour + ':' + CurrentMinute + '';
            $('#txtdCurrentTime').val(currentTime);
            DXcBankD.Focus();


            if (!$('#liDeposit').hasClass('active')) {
                getAllStation(4);
                SaveDetails('CashDepositListGrid');
                $('#<%=HFIsDeposit.ClientID %>').val(1);
                clearCashDeposit();
            }
            else {
                return false;
            }
        }

        function getShiftData(ShiftNo) {

        }

        function getAllStation(ShiftNo) {
            var DynamicTab;


            if (ShiftNo == 1) {
                DynamicTab = "4";
                $('#<%=HFCurrentShift.ClientID %>').val(1);
            }
            else if (ShiftNo == 2) {
                DynamicTab = "1000";
                $('#<%=HFCurrentShift.ClientID %>').val(2);
            }
            else if (ShiftNo == 3) {
                DynamicTab = "2000";
                $('#<%=HFCurrentShift.ClientID %>').val(3);
            }
            else {
                DynamicTab = "3000";
                $('#<%=HFCurrentShift.ClientID %>').val('D');
            }
            //if (ShiftNo == 1) {
            //
            //}
            //if ($('#<%=HFConfirmShift2.ClientID %>').val() == '1') {
            //    
            //}
            //if ($('#<%=HFConfirmShift3.ClientID %>').val() == '1') {
            //
            //}

            $('.dynamicChild').remove();
            //$('#dynamicChild').empty();

            $.ajax({
                type: "POST",
                url: "TranCRUD.asmx/GetAllStation",
                data: "",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var cHeaderDesign = '';
                    var cDesign = '';
                    var Opening = 'O';
                    var Closing = 'C';
                    var Jump = 'J';
                    cHeaderDesign += '<div class="col-lg-12 col-md-12 col-sm-12 top-buffer dynamicChild" style="border-bottom:1px solid black;">';
                    cHeaderDesign += '<div class="col-lg-1 col-md-1 col-sm-1" style="text-align:center;padding-left:0px;padding-right:0px;">';
                    cHeaderDesign += '<strong class="contentLabel">Station Name</strong>';
                    cHeaderDesign += '</div>';
                    cHeaderDesign += '<div class="col-lg-1 col-md-1 col-sm-1" style="text-align:center;">';
                    cHeaderDesign += '<strong class="contentLabel">Details</strong>';
                    cHeaderDesign += '</div>';
                    cHeaderDesign += '<div class="col-lg-2 col-md-2 col-sm-2" style="text-align:center;">';
                    cHeaderDesign += '<strong class="contentLabel">Staff</strong>';
                    cHeaderDesign += '</div>';
                    cHeaderDesign += '<div class="col-lg-3 col-md-3 col-sm-3 dynamicElements" style="text-align:center;">';
                    cHeaderDesign += '<div class="col-lg-6 col-md-6 col-sm-6 dynamicElements" style="text-align:center;">';
                    cHeaderDesign += '<strong class="contentLabel">Opening</strong>';
                    cHeaderDesign += '</div>';
                    cHeaderDesign += '<div class="col-lg-6 col-md-6 col-sm-6 dynamicElements" style="text-align:center;">';
                    cHeaderDesign += '<strong class="contentLabel">Closing</strong>';
                    cHeaderDesign += '</div>';
                    cHeaderDesign += '</div>';
                    cHeaderDesign += '<div class="col-lg-1 col-md-1 col-sm-1 dynamicElements" style="text-align:center;">';
                    cHeaderDesign += '<strong class="contentLabel">Diff.(KGs)</strong>';
                    cHeaderDesign += '</div>';
                    cHeaderDesign += '<div class="col-lg-1 col-md-1 col-sm-1 dynamicElements">';
                    cHeaderDesign += '<strong class="contentLabel">Jump Rate</strong>';
                    cHeaderDesign += '</div>';
                    cHeaderDesign += '<div class="col-lg-1 col-md-1 col-sm-1 dynamicElements">';
                    cHeaderDesign += '<strong class="contentLabel">Diff.(Rate)</strong>';
                    cHeaderDesign += '</div>';
                    cHeaderDesign += '<div class="col-lg-1 col-md-1 col-sm-1 dynamicElements">';
                    cHeaderDesign += '<strong class="contentLabel">Deposit All</strong>';
                    cHeaderDesign += '</div>';
                    cHeaderDesign += '<div class="col-lg-1 col-md-1 col-sm-1 dynamicElements">';
                    cHeaderDesign += '<strong class="contentLabel">Diff. Amt.</strong>';
                    cHeaderDesign += '</div>';
                    //cHeaderDesign += '<div class="col-lg-2 col-md-2 col-sm-2">';
                    //cHeaderDesign += '</div>';
                    cHeaderDesign += '</div>';

                    for (var i = 0; i < response.d.length; i++) {
                        var cStationName = response.d[i].cName;
                        var nStationID = response.d[i].NID;
                        $('#<%=HFStationLength.ClientID%>').val(response.d.length);

                        if (i == 0) {
                            if (ShiftNo == 1) {
                                $('#exampleTabsIconOne').append(cHeaderDesign);
                            }
                            else if (ShiftNo == 2) {
                                $('#exampleTabsIconTwo').append(cHeaderDesign);
                            }
                            else {
                                $('#exampleTabsIconThree').append(cHeaderDesign);
                            }
                        }
                        cDesign += '<div class="col-lg-12 col-md-12 col-sm-12 top-buffer dynamicChild" id="divStation' + i + '">';
                        cDesign += '<div class="col-lg-1 col-md-1 col-sm-1" style="text-align:center;padding-left:0px;padding-right:0px;">';
                        cDesign += '<strong class="contentLabel">' + cStationName + '</strong>';
                        cDesign += '<input type="hidden" id="HFStationID_' + i + '" value="' + nStationID + '"></input>';
                        cDesign += '<input type="hidden" id="HFCID_' + i + '"></input>';
                        cDesign += '</div>';
                        cDesign += '<div class="col-lg-1 col-md-1 col-sm-1" style="text-align:center;">';
                        //cDesign += '<button type="button" onclick="openStaffModal(' + i + ')" tabindex="' + parseInt(DynamicTab) + '" class="btn btn-info-nohover" style="padding:0px;padding-left:5px;padding-right:5px;font-size:13px;">Details</button>';
                        cDesign += '<button type="button" disabled="disabled" id="btnDetails_' + i + '" onclick="openStaffModal(' + i + ')" tabindex="' + parseInt(DynamicTab) + '" class="btn btn-info-nohover" style="padding:0px;padding-left:5px;padding-right:5px;font-size:13px;">Details</button>';
                        cDesign += '<input type="hidden" id="HFStaffID_' + i + '"></input>';
                        cDesign += '</div>';
                        cDesign += '<div class="col-lg-2 col-md-2 col-sm-2" style="vertical-align:middle;text-align:center;">';
                        cDesign += '<span style="font-weight:bold;" id="spanStaffName_' + i + '"></span>';
                        cDesign += '</div>';
                        DynamicTab = parseInt(DynamicTab) + 1;
                        cDesign += '<div class="col-lg-3 col-md-3 col-sm-3 dynamicElements" style="text-align:center;">'
                        cDesign += '<div class="col-lg-6 col-md-6 col-sm-6 dynamicElements" style="text-align:center;">';
                        //cDesign += '<input type="text" class="bsinputred" id="txtnOpening_' + i + '" disabled="disabled" tabindex="' + parseInt(DynamicTab) + '" onkeydown="return validateKeyPress(event,validNums)" onfocusout="CalculateDifference(\'' + i + '\',\'' + Opening + '\',$(this))">';
                        //cDesign += '<input type="text" class="bsinputred" id="txtnOpening_' + i + '" disabled="disabled" tabindex="' + parseInt(DynamicTab) + '" onkeydown="return validateKeyPress(event,validNums)" onchange="CalculateDifference(\'' + i + '\',\'' + Opening + '\',$(this))" style="width:100%;max-width:205px;" onfocus="this.select()" onmouseup="this.select()">';

                        cDesign += '<input type="text" class="bsinputred" id="txtnOpening_' + i + '" disabled="disabled" tabindex="' + parseInt(DynamicTab) + '" onkeydown="return validateKeyPress(event,validNums)" onchange="CalculateDifference(\'' + i + '\',\'' + Opening + '\',$(this))" style="width:100%;max-width:205px;" onclick="setColor(' + i + ')"  onmouseup="this.select()">';
                        cDesign += '</div>';
                        DynamicTab = parseInt(DynamicTab) + 1;
                        cDesign += '<div class="col-lg-6 col-md-6 col-sm-6 dynamicElements" style="text-align:center;">';
                        //cDesign += '<input type="text" class="bsinputred" id="txtnClosing_' + i + '" disabled="disabled" tabindex="' + parseInt(DynamicTab) + '" onkeydown="return validateKeyPress(event,validNums)" onfocusout="CalculateDifference(\'' + i + '\',\'' + Closing + '\',$(this))">';
                        //cDesign += '<input type="text" class="bsinputred" id="txtnClosing_' + i + '" disabled="disabled" tabindex="' + parseInt(DynamicTab) + '" onkeydown="return validateKeyPress(event,validNums)" onchange="CalculateDifference(\'' + i + '\',\'' + Closing + '\',$(this))" style="width:100%;max-width:205px;" onfocus="this.select()" onmouseup="this.select()">';

                        cDesign += '<input type="text" class="bsinputred" id="txtnClosing_' + i + '" disabled="disabled" tabindex="' + parseInt(DynamicTab) + '" onkeydown="return validateKeyPress(event,validNums)" onchange="CalculateDifference(\'' + i + '\',\'' + Closing + '\',$(this))" style="width:100%;max-width:205px;" onclick="setColor(' + i + ')"  onfocus="this.select()"  onmouseup="this.select()">';
                        cDesign += '</div>';
                        cDesign += '</div>';

                        DynamicTab = parseInt(DynamicTab) + 1;
                        cDesign += '<div class="col-lg-1 col-md-1 col-sm-1 dynamicElements" style="text-align:center;">';
                        cDesign += '<input type="text" class="bsinputred" id="txtnDiff_' + i + '" disabled="disabled" value="0" style="width:100%;">';
                        cDesign += '</div>';
                        cDesign += '<div class="col-lg-1 col-md-1 col-sm-1 dynamicElements" style="text-align:center;">';
                        cDesign += '<input type="text" class="bsinputred" id="txtnJumpRate_' + i + '" disabled="disabled" value="0" tabindex="' + parseInt(DynamicTab) + '" onkeydown="return validateKeyPress(event,validNums)" onchange="CalculateDifference(\'' + i + '\',\'' + Jump + '\',$(this))" style="width:100%;max-width:205px;" onclick="setColor(' + i + ')"  onmouseup="this.select()">';
                        cDesign += '</div>';
                        cDesign += '<div class="col-lg-1 col-md-1 col-sm-1 dynamicElements" style="text-align:center;">';
                        cDesign += '<input type="text" class="bsinputred" id="txtnDiffRate_' + i + '" disabled="disabled" value="0" style="width:100%;">';
                        cDesign += '</div>';
                        cDesign += '<div class="col-lg-1 col-md-1 col-sm-1 dynamicElements" style="text-align:center;">';
                        cDesign += '<input type="text" class="bsinputred" id="txtnDepositRate_' + i + '" disabled="disabled" value="0" style="width:100%;">';
                        cDesign += '</div>';
                        cDesign += '<div class="col-lg-1 col-md-1 col-sm-1 dynamicElements" style="text-align:center;">';
                        cDesign += '<input type="text" class="bsinputred" id="txtnDiffAmt_' + i + '" disabled="disabled" value="0" style="width:100%;">';
                        cDesign += '</div>';
                        //cDesign += '<div class="col-lg-2 col-md-2 col-sm-2">';
                        //cDesign += '</div>';
                        cDesign += '</div>';
                    }

                    cDesign += '<div class="col-lg-12 col-md-12 col-sm-12 top-buffer dynamicChild" style="border-top:1px solid black;">';
                    cDesign += '<div class="col-lg-1 col-md-1 col-sm-1" style="text-align:center;font-size:16px;">';
                    cDesign += '<strong class="contentLabel">Total</strong>';
                    cDesign += '</div>';
                    cDesign += '<div class="col-lg-1 col-md-1 col-sm-1" style="text-align:center;">';
                    cDesign += '</div>';
                    cDesign += '<div class="col-lg-1 col-md-1 col-sm-1" style="vertical-align:middle;text-align:center;">';
                    cDesign += '</div>';
                    cDesign += '<div class="col-lg-3 col-md-3 col-sm-3" style="text-align:center;">';
                    cDesign += '<div class="col-lg-6 col-md-6 col-sm-6" style="text-align:center;">';
                    //cDesign += '<span class="bsinputred" id="spanOpeningTotal" style="width:100%;">';
                    cDesign += '</div>';
                    cDesign += '<div class="col-lg-6 col-md-6 col-sm-6" style="text-align:center;">';
                    //cDesign += '<span class="bsinputred" id="spanClosingTotal" style="width:100%;">';
                    cDesign += '</div>';
                    cDesign += '</div>';
                    cDesign += '<div class="col-lg-1 col-md-1 col-sm-1">';
                    cDesign += '</div>';
                    cDesign += '<div class="col-lg-1 col-md-1 col-sm-1 dynamicElements" style="text-align:center;">';
                    cDesign += '<span id="spanDiffKGTotal" style="width:100%;float:right;text-align:right;padding-right:3px;font-size:15px;font-weight:bold!important;"></span>';
                    cDesign += '</div>';
                    cDesign += '<div class="col-lg-1 col-md-1 col-sm-1 dynamicElements" style="text-align:center;">';
                    cDesign += '<span id="spanJumpTotal" style="width:100%;float:right;text-align:right;padding-right:3px;font-size:15px;font-weight:bold!important;"></span>';
                    cDesign += '</div>';
                    cDesign += '<div class="col-lg-1 col-md-1 col-sm-1 dynamicElements" style="text-align:center;">';
                    cDesign += '<span id="spanDiffRateTotal" style="width:100%;float:right;text-align:right;padding-right:3px;font-size:15px;font-weight:bold!important;"></span>';
                    cDesign += '</div>';
                    cDesign += '<div class="col-lg-1 col-md-1 col-sm-1 dynamicElements" style="text-align:center;">';
                    cDesign += '<span id="spanDepositTotal" style="width:100%;float:right;text-align:right;padding-right:3px;font-size:15px;font-weight:bold!important;"></span>';
                    cDesign += '</div>';
                    cDesign += '<div class="col-lg-1 col-md-1 col-sm-1 dynamicElements" style="text-align:center;">';
                    cDesign += '<span id="spanDiffAmtTotal" style="width:100%;float:right;text-align:right;padding-right:3px;font-size:15px;font-weight:bold!important;"></span>';
                    cDesign += '</div>';
                    //cDesign += '<div class="col-lg-2 col-md-2 col-sm-2">';
                    //cDesign += '</div>';
                    cDesign += '</div>';

                    cDesign += '<div class="col-lg-12 col-md-12 col-sm-12 top-buffer dynamicChild" style="border-top:1px solid black;">';
                    cDesign += '<div class="col-lg-2 col-md-2 col-sm-2" style="text-align:center;font-size:16px;">';
                    cDesign += '<strong class="contentLabel">Shift Total</strong>';
                    cDesign += '</div>';
                    //cDesign += '<div class="col-lg-1 col-md-1 col-sm-1" style="text-align:center;">';
                    //cDesign += '</div>';
                    cDesign += '<div class="col-lg-2 col-md-2 col-sm-2 dynamicElements">';


                    cDesign += '<button type="button" onclick="CashTotal()" class="btn btn-info-nohover" style="padding:0px;padding-left:5px;padding-right:5px;font-size:13px;">Cash </button>';
                    //cDesign += '<button type="button" class="btn btn-info-nohover" style="padding:0px;padding-left:5px;padding-right:5px;font-size:13px;">Cash </button>';
                    cDesign += '&nbsp;<span><i class="fa fa-inr"></i></span> : </span>';
                    //cDesign += '<span style="font-size:16px;font-weight:bold!important;">Cash <span><i class="fa fa-inr"></i></span> : </span>';                    

                    cDesign += '<span id="spanShiftTotalCashRs" style="font-size:16px;font-weight:bold!important;"></span>';
                    cDesign += '</div>';
                    cDesign += '<div class="col-lg-2 col-md-2 col-sm-2 dynamicElements">';

                    cDesign += '<button type="button" onclick="CreditCardTotal()" class="btn btn-info-nohover" style="padding:0px;padding-left:5px;padding-right:5px;font-size:13px;">C.C. </button>';
                    cDesign += '&nbsp;<span><i class="fa fa-inr"></i></span> : </span>';
                    //cDesign += '<span style="font-size:16px;font-weight:bold!important;">C.C. <span><i class="fa fa-inr"></i></span> : </span>';

                    cDesign += '<span id="spanShiftTotalCreditCardRs" style="font-size:16px;font-weight:bold!important;"></span>';
                    cDesign += '</div>';
                    cDesign += '<div class="col-lg-2 col-md-2 col-sm-2 dynamicElements">';

                    cDesign += '<button type="button" onclick="PaytmTotal()" class="btn btn-info-nohover" style="padding:0px;padding-left:5px;padding-right:5px;font-size:13px;">Paytm </button>';
                    cDesign += '&nbsp;<span><i class="fa fa-inr"></i></span> : </span>';
                    //cDesign += '<span style="font-size:16px;font-weight:bold!important;">Paytm <span><i class="fa fa-inr"></i></span> : </span>';

                    cDesign += '<span id="spanShiftTotalPaytmRs" style="font-size:16px;font-weight:bold!important;"></span>';
                    cDesign += '</div>';
                    cDesign += '<div class="col-lg-2 col-md-2 col-sm-2 dynamicElements">';

                    cDesign += '<button type="button" onclick="CreditSalesTotal()" class="btn btn-info-nohover" style="padding:0px;padding-left:5px;padding-right:5px;font-size:13px;">C.S. </button>';
                    cDesign += '&nbsp;<span><i class="fa fa-inr"></i></span> : </span>';
                    //cDesign += '<span style="font-size:16px;font-weight:bold!important;">C.S. <span><i class="fa fa-inr"></i></span> : </span>';

                    cDesign += '<span id="spanShiftTotalCreditSalesRs" style="font-size:16px;font-weight:bold!important;"></span>';
                    cDesign += '</div>';
                    cDesign += '<div class="col-lg-2 col-md-2 col-sm-2 dynamicElements">';
                    cDesign += '<span style="font-size:16px;font-weight:bold!important;">Final Total. <span><i class="fa fa-inr"></i></span> : </span>';
                    cDesign += '<span id="spanFinalTotal" style="font-size:16px;font-weight:bold!important;"></span>';
                    cDesign += '</div>';
                    cDesign += '</div>';


                    if (ShiftNo == 1) {
                        $('#exampleTabsIconOne').append(cDesign);
                        $('#txtnOpening_0').focus();
                    }
                    else if (ShiftNo == 2) {
                        $('#exampleTabsIconTwo').append(cDesign);
                        $('#txtnOpening_0').focus();
                    }
                    else if (ShiftNo == 3) {
                        $('#exampleTabsIconThree').append(cDesign);
                        $('#txtnOpening_0').focus();
                    }
                    else {
                        //$('#txtnDRs2000').focus();
                        DXcBankD.Focus();
                    }
                    EnterKeyTabNew();
                },
                failure: function (response) {
                    alert(response.d.Msg);
                }
            });
        }


        //Added By RC


        function getStationOpening(dDate) {           
            $.ajax({
                type: "POST",
                url: "TranCRUD.asmx/GetStationOneOpening",
                data: "{'dDate':'" + dDate + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    for (var i = 0; i < response.d.length; i++) {
                        var cStationName = response.d[i].cName;
                        var nStationID = response.d[i].NID;
                        var nOpening = response.d[i].nOpening;

                        $('#<%=HFStationLength.ClientID%>').val(response.d.length);
                        $('#txtnOpening_' + i).val(response.d[i].nClosing);
                    }                    
                        $('#txtnOpening_0').focus();                                      
                },
                failure: function (response) {
                    alert(response.d.Msg);
                }
            });
        }

        function CashTotal() {
            var PID = $('#<%=HFPID.ClientID%>');
            var shift = $('#<%=HFCurrentShift.ClientID %>').val();

            URL = "TranCRUD.asmx/ListTblTranDailySalesChildCashTotal";
            DATA = "{'PID':'" + PID.val() + "','cType':'CGROUP','Shift':'" + shift + "'}";
            Type = 'CashListGridTotal'
            makeAjaxCall(Type, true);
            $('#CashListTotal').modal('show');
            DXcBankD.Focus();
        }


        function CreditCardTotal() {
            var PID = $('#<%=HFPID.ClientID%>');
            var shift = $('#<%=HFCurrentShift.ClientID %>').val();

            URL = "TranCRUD.asmx/ListTblTranDailySalesChildCreditCardTotal";
            DATA = "{'PID':'" + PID.val() + "','cType':'0','Shift':'" + shift + "'}";
            Type = 'CreditCardListGridTotal'
            makeAjaxCall(Type, true);
            $('#spanCreditCardTotalHead').text('Credit Card List');
            $('#CreditCardListTotal').modal('show');
            DXcBankD.Focus();
        }

        function PaytmTotal() {
            var PID = $('#<%=HFPID.ClientID%>');
            var shift = $('#<%=HFCurrentShift.ClientID %>').val();

            URL = "TranCRUD.asmx/ListTblTranDailySalesChildCreditCardTotal";
            DATA = "{'PID':'" + PID.val() + "','cType':'1','Shift':'" + shift + "'}";
            Type = 'PaytmListGridTotal'
            makeAjaxCall(Type, true);
            $('#spanCreditCardTotalHead').text('Paytm List');
            $('#CreditCardListTotal').modal('show');
            DXcBankD.Focus();
        }

        function CreditSalesTotal() {
            var PID = $('#<%=HFPID.ClientID%>');
            var shift = $('#<%=HFCurrentShift.ClientID %>').val();
            URL = "TranCRUD.asmx/ListTblTranDailySalesChildCreditSalesTotal";
            DATA = "{'PID':'" + PID.val() + "','cType':'0','Shift':'" + shift + "'}";
            Type = 'CreditSalesListGridTotal'
            makeAjaxCall(Type, true);
            $('#spanCreditSalesTotalHead').text('Credit Sales List');
            $('#CreditSalesListTotal').modal('show');
            DXcBankD.Focus();
        }


        //End by RC

        function CalculateDifference(index, Type, currObj) {
            //debugger;
            var nOpening = $('#txtnOpening_' + index + '');
            var nClosing = $('#txtnClosing_' + index + '');
            var nDiff = $('#txtnDiff_' + index + '');
            var nDiffRate = $('#txtnDiffRate_' + index + '');
            var nDepositRate = $('#txtnDepositRate_' + index + '');
            var nDiffAmt = $('#txtnDiffAmt_' + index + '');
            var nJumpRate = $('#txtnJumpRate_' + index + '');
            var nRate = $('#<%=HFTodayRate.ClientID %>');

            //var flag = true;

            if (parseFloat(nClosing.val()) > 0 && parseFloat(nOpening.val()) > 0) {
                if (parseFloat(ConvertToNum(nClosing.val())) < parseFloat(ConvertToNum(nOpening.val()))) {
                    if (Type == "O") {
                        alertify.alert("Opening can not be MORE than Closing!", function () {
                            undo();
                            nOpening.focus();
                        });
                    }
                    else if (Type == "C") {
                        alertify.alert("Closing can not be LESS than Opening!", function () {
                            undo();
                            nClosing.focus();
                        });
                    }
                    flag = false;
                }
                else {
                    flag = true;
                    if (Type == "O") {
                        nOpening.val(parseFloat(nOpening.val()).toFixed(2));
                    }
                    else if (Type == "C") {
                        nClosing.val(parseFloat(nClosing.val()).toFixed(2));
                    }
                    else {
                        nJumpRate.val(parseFloat(nJumpRate.val()).toFixed(2))
                    }
                    //nDiff.val(parseFloat(parseFloat(ConvertToNum(nClosing.val())) - parseFloat(ConvertToNum(nOpening.val()))).toFixed(2));


                    nDiff.val(parseFloat(parseFloat(ConvertToNum(nClosing.val())) - parseFloat(ConvertToNum(nOpening.val()))).toFixed("0"));


                    nDiffRate.val((parseFloat(parseFloat(ConvertToNum(nDiff.val())) * parseFloat(ConvertToNum(nRate.val()))).toFixed(2)) - (parseFloat(ConvertToNum(nJumpRate.val()))));
                    balanceChange(Type, currObj, index);
                }
            }
            else {
                flag = true;
                nDiff.val('0');
                balanceChange(Type, currObj, index);
            }
        }

        function balanceChange(Type, currObj, Index) {

            $('#<%=HFCurrentRow.ClientID %>').val(Index);
            if (currObj.val() != '') {
                if (flag) {
                    //if (Type == "O") {
                    SaveDetails(Type);
                    //}
                }
                if ($('#<%=HFDayDone.ClientID %>').val() != 1) {
                    if ($.cookie('CNGPumpLogin_Type') != 2) {
                        $('#txtnClosing_' + Index + '').removeAttr('disabled');
                    }
                    else {
                        if (ConvertToNum($('#txtnClosing_' + Index + '').val()) <= 0) {
                            $('#txtnClosing_' + Index + '').removeAttr('disabled');
                        }
                    }
                    $('#txtnJumpRate_' + Index + '').removeAttr('disabled');                    
                    
                }

                setTimeout(function () {
                    $('#txtnClosing_' + Index + '').focus();
                }, 50);



            }
            else {
                if (Type == "O") {
                    $('#txtnClosing_' + Index + '').val('');
                    $('#txtnClosing_' + Index + '').attr('disabled', 'disabled');
                    $('#txtnJumpRate_' + Index + '').attr('disabled', 'disabled');
                }
            }
        }


        function openStaffModal(Index) {

            //alert($('#<%=HFCurrentShift.ClientID %>').val());
            //alert(Index);
            $('#cCashTab').click();
            $('#<%=HFCurrentRow.ClientID %>').val(Index);
            $('#spanCurrentRow').text(Index);
            DXcStaff1.SetValue('');
            clearCash();
            setTimeout(function () {
                DXcStaff1.SetValue($('#HFStaffID_' + Index + '').val());
                DXcStaff1.Focus();
            }, 200);


            setColor(Index);
            $('#staffModal').modal();

        }

        function SaveDetails(Type) {
            //debugger;
            //alert("SaveDetails" + Type);

            //-----Variables Declaration Starts-----
            var Query;
            var nCurrentRow = $('#<%=HFCurrentRow.ClientID %>').val();
            var PID = $('#<%=HFPID.ClientID%>');
            var dDate = $('#<%=TxtdDate.ClientID%>');
            var nSrNo = $('#<%=TxtnTranNo.ClientID%>');
            var nBranchID = $.cookie('CNGPumpBranchID');
            var nCompID = $.cookie('CNGPumpCompID');
            var cAccYear = $.cookie('CNGPumpAccYear');
            var nInstID = $.cookie('CNGPumpLoginID');
            //var CID = $('#<%=HFCID.ClientID%>');
            var CID = $('#HFCID_' + nCurrentRow + '');
            var nStationID = $('#HFStationID_' + nCurrentRow + '');
            var nStaffID = $('#HFStaffID_' + nCurrentRow + '');
            var nShift = $('#<%=HFCurrentShift.ClientID %>');
            var nOpening = $('#txtnOpening_' + nCurrentRow + '');
            var nClosing = $('#txtnClosing_' + nCurrentRow + '');
            var nDiff = $('#txtnDiff_' + nCurrentRow + '');
            var nDiffRate = $('#txtnDiffRate_' + nCurrentRow + '');
            var nDepositRs = $('#txtnDepositRate_' + nCurrentRow + '');
            var nDiffAmt = $('#txtnDiffAmt_' + nCurrentRow + '');
            var nNotes2000 = $('#txtnRs2000');
            var nNotes1000 = $('#txtnRs1000');
            var nNotes500 = $('#txtnRs500');
            var nNotes100 = $('#txtnRs100');
            var nNotes50 = $('#txtnRs50');
            var nNotes20 = $('#txtnRs20');
            var nNotes10 = $('#txtnRs10');
            var nNotes5 = $('#txtnRs5');
            var nNotes2 = $('#txtnRs2');
            var nNotes1 = $('#txtnRs1');
            var nTotalNotes = $('#spanTotalNotes');
            var nTotalRs = $('#spanTotalRs');
            var nCashID = $('#<%=HFCashID.ClientID %>');
            var nCreditCardID = $('#<%=HFCreditCardID.ClientID %>');
            var nCreditSalesID = $('#<%=HFCreditSalesID.ClientID %>');
            var cCurrentAspect = $('#<%=HFCurrentAspect.ClientID %>');
            var nBankID = DXcBank;
            var cCardNo = $('#TxtcCreditCardNo');
            var nRs = $('#TxtnCreditCardRs');
            var nCustomerID = DXcCustomer;
            var cVehicleNo = $('#TxtcVehicleNo');
            var nCreditSaleRs = $('#TxtnCreditSaleRs');
            var nCreditSaleQty = $('#TxtnCreditSaleQty');
            var cNarration = $('#TxtcNarration');
            var nRate = $('#<%=HFTodayRate.ClientID %>');
            var nBankIDD = DXcBankD;
            var cCurrentTime = $('#txtdCurrentTime');
            var cCMSSlipNo = $('#txtcCMSSlipNo');
            var cHCINNo = $('#txtcHCINNo');
            var cDepositerName = $('#txtcDepositerName');
            var nCoins = $('#txtnCoinsRsTotal');
            var cType = '';

            var nJumpRate = $('#txtnJumpRate_' + nCurrentRow + '');


            //-----Variables Declaration Ends-----

            //if (ID != undefined) {
            //    if (D == '1') {
            //        Query = 'PDCD';
            //    }
            //    else {
            //        Query = 'PUCU';
            //    }
            //}
            //else {
            //    Query = 'PICI';
            //}

            if (PID.val() != '') {
                if (D == '1') {
                    Query = 'PDCD';
                }
                else {
                    if (CID.val() != '') {
                        Query = 'PUCU';
                    }
                    else {
                        Query = 'PUCI';
                    }
                }
            }
            else {
                Query = 'PICI';
            }

            //alert(DXcStaff1.GetValue());
            if (Type == "S") {

                if (DXcStaff1.GetValue() != null) {
                    //alert($.trim(DXcStaff1.GetSelectedItem().texts[0]));
                    //$('#spanStaffName_' + $('#<%=HFCurrentRow.ClientID %>').val() + '').text($.trim(DXcStaff1.GetSelectedItem().texts[0]));
                    $('#<%=HFCurrentStaffName.ClientID %>').val($.trim(DXcStaff1.GetText()));
                    //if ($('#<%=HFCurrentStaffID.ClientID %>').val() != '') {
                    //    DXcStaff1.SetValue($('#<%=HFCurrentStaffID.ClientID %>').val());
                    //}
                    $('#<%=HFCurrentStaffID.ClientID %>').val(DXcStaff1.GetValue());
                    $('#spanStaffName_' + $('#<%=HFCurrentRow.ClientID %>').val() + '').text($('#<%=HFCurrentStaffName.ClientID %>').val());
                    $('#HFStaffID_' + $('#<%=HFCurrentRow.ClientID %>').val() + '').val(DXcStaff1.GetValue());
                    if ($('#<%=HFDayDone.ClientID %>').val() != 1) {
                        if ($.cookie('CNGPumpLogin_Type') != 2) {
                            $('#txtnOpening_' + $('#<%=HFCurrentRow.ClientID %>').val() + '').removeAttr('disabled');
                        }
                        else {
                            if (ConvertToNum($('#txtnOpening_' + $('#<%=HFCurrentRow.ClientID %>').val() + '').val()) <= 0) {
                                $('#txtnOpening_' + $('#<%=HFCurrentRow.ClientID %>').val() + '').removeAttr('disabled');
                            }
                        }
                    }

                    if (CID.val() == "") {
                        URL = "TranCRUD.asmx/AddUpdateDeleteTblTranDailySales";
                        DATA = "{'Query':'" + Query + "','PID':'" + PID.val() + "','dDate':'" + dDate.val() + "','nSrNo':'','nBranchID':'" + nBranchID + "','nCompID':'" + nCompID + "','cAccYear':'" + cAccYear + "','nInstID':'" + nInstID + "','nUpID':'" + nInstID + "','CID':'" + CID.val() + "','nStationID':'" + nStationID.val() + "','nStaffID':'" + nStaffID.val() + "','nShift':'" + nShift.val() + "','nOpening':'" + nOpening.val() + "','nClosing':'" + nClosing.val() + "','nDiff':'" + nDiff.val() + "','nRate':'" + nRate.val() + "','nDiffRate':'" + ConvertToNum(nDiffRate.val()) + "','nDepositRs':'" + ConvertToNum(nDepositRs.val()) + "','nDiffAmt':'" + ConvertToNum(nDiffAmt.val()) + "','nJumpRate':'" + ConvertToNum(nJumpRate.val()) + "'}";
                        makeAjaxCall(Type, true);
                    }
                    else {
                        if (cCurrentAspect.val() == "Cash") {
                            var tempFlag = false;
                            $('.NoteNo').each(function (e) {
                                if (parseFloat($(this).val()) > 0 || parseFloat($('#txtnCoinsRsTotal').val()) > 0) {
                                    tempFlag = true;
                                    return false;
                                }
                            });

                            if (tempFlag) {
                                if (nCashID.val() != '') {
                                    Query = 'U';
                                }
                                else {
                                    Query = 'I';
                                }
                                $('#<%=HFListOpen.ClientID %>').val(0);
                                URL = "TranCRUD.asmx/AddUpdateDeleteTblTranDailySalesChildCash";
                                DATA = "{'Query':'" + Query + "','NID':'" + nCashID.val() + "','nParentID':'" + CID.val() + "','nNotes2000':'" + ConvertToNum(nNotes2000.val()) + "', 'nNotes1000':'" + ConvertToNum(nNotes1000.val()) + "', 'nNotes500':'" + ConvertToNum(nNotes500.val()) + "', 'nNotes100':'" + ConvertToNum(nNotes100.val()) + "', 'nNotes50':'" + ConvertToNum(nNotes50.val()) + "', 'nNotes20':'" + ConvertToNum(nNotes20.val()) + "', 'nNotes10':'" + ConvertToNum(nNotes10.val()) + "', 'nNotes5':'" + ConvertToNum(nNotes5.val()) + "', 'nNotes2':'" + ConvertToNum(nNotes2.val()) + "', 'nNotes1':'" + ConvertToNum(nNotes1.val()) + "', 'nTotalNotes':'" + ConvertToNum(nTotalNotes.val()) + "', 'nTotalRs':'" + ConvertToNum(nTotalRs.val()) + "','cType':'C','nBankID':'" + nBankIDD.GetValue() + "','cCurrentTime':'" + cCurrentTime.val() + "','cCMSSlipNo':'" + cCMSSlipNo.val() + "','cHCINNo':'" + cHCINNo.val() + "','cDepositerName':'" + cDepositerName.val() + "','nCoins':'" + ConvertToNum(nCoins.val()) + "'}";
                                makeAjaxCall(Type, false);
                                clearCash();
                                SaveDetails('CashListGrid');


                            }
                        }
                        else if (cCurrentAspect.val() == "CreditCard" || cCurrentAspect.val() == "Paytm") {
                            if (nCreditCardID.val() != '') {
                                Query = 'U';
                            }
                            else {
                                Query = 'I';
                            }

                            if (DXcBank.GetValue() == null) {
                                alertify.alert("Bank is Required!", function () {
                                    DXcBank.Focus();
                                });
                            }
                                //else if ($('#TxtcCreditCardNo').val() == '') {
                                //    alertify.alert("Credit Card No is Required!", function () {
                                //        $('#TxtcCreditCardNo').focus();
                                //    });
                                //}
                            else if (ConvertToNum($('#TxtnCreditCardRs').val()) <= 0) {
                                alertify.alert("Rs. is Required!", function () {
                                    $('#TxtnCreditCardRs').focus();
                                });
                            }
                            else {

                                if (cCurrentAspect.val() == "CreditCard") {
                                    cType = '0';
                                }
                                else {
                                    cType = '1';
                                }

                                URL = "TranCRUD.asmx/AddUpdateDeleteTblTranDailySalesChildCreditCard";
                                DATA = "{'Query':'" + Query + "','NID':'" + nCreditCardID.val() + "','nParentID':'" + CID.val() + "','nBankID':'" + nBankID.GetValue() + "', 'cCardNo':'" + cCardNo.val() + "', 'nRs':'" + ConvertToNum(nRs.val()) + "','cType':'" + cType + "'}";
                                makeAjaxCall(Type, false);

                                clearCreditCard();
                            }
                        }
                        else if (cCurrentAspect.val() == "CreditSale" || cCurrentAspect.val() == "AdaniSale") {
                            if (nCreditSalesID.val() != '') {
                                Query = 'U';
                            }
                            else {
                                Query = 'I';
                            }
                            if (DXcCustomer.GetValue() == null) {
                                alertify.alert("Customer is Required!", function () {
                                    DXcCustomer.Focus();
                                });
                            }
                                //else if ($('#TxtcVehicleNo').val() == '') {
                                //    alertify.alert("Vehicle No is Required!", function () {
                                //        $('#TxtcVehicleNo').focus();
                                //    });
                                //}
                            else if (ConvertToNum($('#TxtnCreditSaleRs').val()) <= 0) {
                                alertify.alert("Rs. is Required!", function () {
                                    $('#TxtnCreditCardRs').focus();
                                });
                            }
                            else {
                                if (cCurrentAspect.val() == "CreditSale") {
                                    cType = '0';
                                }
                                else {
                                    cType = '1';
                                }

                                URL = "TranCRUD.asmx/AddUpdateDeleteTblTranDailySalesChildCreditSales";
                                DATA = "{'Query':'" + Query + "','NID':'" + nCreditSalesID.val() + "','nParentID':'" + CID.val() + "','nCustomerID':'" + nCustomerID.GetValue() + "', 'cVehicleNo':'" + cVehicleNo.val() + "', 'nRs':'" + ConvertToNum(nCreditSaleRs.val()) + "', 'nRate':'" + ConvertToNum(nRate.val()) + "', 'nQty':'" + ConvertToNum(nCreditSaleQty.val()) + "','cNarration':'" + cNarration.val() + "','cType':'" + cType + "'}";
                                makeAjaxCall(Type, false);
                                clearCreditSales();
                            }
                        }
                        else {
                            var tempFlag = false;
                            $('.NoteNo').each(function (e) {
                                if (parseFloat($(this).val()) > 0) {
                                    tempFlag = true;
                                    return false;
                                }
                            });

                            if (tempFlag) {
                                if (nCashID.val() != '') {
                                    Query = 'U';
                                }
                                else {
                                    Query = 'I';
                                }
                                $('#<%=HFListOpen.ClientID %>').val(0);
                                URL = "TranCRUD.asmx/AddUpdateDeleteTblTranDailySalesChildCash";
                                DATA = "{'Query':'" + Query + "','NID':'" + nCashID.val() + "','nParentID':'" + CID.val() + "','nNotes2000':'" + ConvertToNum(nNotes2000.val()) + "', 'nNotes1000':'" + ConvertToNum(nNotes1000.val()) + "', 'nNotes500':'" + ConvertToNum(nNotes500.val()) + "', 'nNotes100':'" + ConvertToNum(nNotes100.val()) + "', 'nNotes50':'" + ConvertToNum(nNotes50.val()) + "', 'nNotes20':'" + ConvertToNum(nNotes20.val()) + "', 'nNotes10':'" + ConvertToNum(nNotes10.val()) + "', 'nNotes5':'" + ConvertToNum(nNotes5.val()) + "', 'nNotes2':'" + ConvertToNum(nNotes2.val()) + "', 'nNotes1':'" + ConvertToNum(nNotes1.val()) + "', 'nTotalNotes':'" + ConvertToNum(nTotalNotes.val()) + "', 'nTotalRs':'" + ConvertToNum(nTotalRs.val()) + "','cType':'C','nBankID':'" + nBankIDD.GetValue() + "','cCurrentTime':'" + cCurrentTime.val() + "','cCMSSlipNo':'" + cCMSSlipNo.val() + "','cHCINNo':'" + cHCINNo.val() + "','cDepositerName':'" + cDepositerName.val() + "','nCoins':'" + ConvertToNum(nCoins.val()) + "'}";
                                makeAjaxCall(Type, false);
                                clearCash();
                                SaveDetails('CashListGrid');
                            }
                        }
                        //setTimeout(function () {
                        //    makeAjaxCall('Search', true);
                        //}, 250);
                setTimeout(function () {
                    GetDepositRs();
                }, 300);
            }
        }
        else {
            alertify.alert("Select a Staff!", function () {
                DXcStaff1.Focus();
            });
        }
    }
    else if (Type == "SC") {
        if (DXcStaff1.GetValue() != null) {


            //alert($.trim(DXcStaff1.GetSelectedItem().texts[0]));
            //$('#spanStaffName_' + $('#<%=HFCurrentRow.ClientID %>').val() + '').text($.trim(DXcStaff1.GetSelectedItem().texts[0]));

            //if ($.trim(DXcStaff1.GetText()) != '') {
            //    DXcStaff1.SetText(DXcStaff1.GetSelectedItem().text[0]);
            //}

            $('#<%=HFCurrentStaffName.ClientID %>').val($.trim(DXcStaff1.GetText()));
            $('#<%=HFCurrentStaffID.ClientID %>').val(DXcStaff1.GetValue());
            $('#spanStaffName_' + $('#<%=HFCurrentRow.ClientID %>').val() + '').text($('#<%=HFCurrentStaffName.ClientID %>').val());
            $('#HFStaffID_' + $('#<%=HFCurrentRow.ClientID %>').val() + '').val(DXcStaff1.GetValue());
            if ($('#<%=HFDayDone.ClientID %>').val() != 1) {
                if ($.cookie('CNGPumpLogin_Type') != 2) {
                    $('#txtnOpening_' + $('#<%=HFCurrentRow.ClientID %>').val() + '').removeAttr('disabled');
                }
                else {
                    if (ConvertToNum($('#txtnOpening_' + $('#<%=HFCurrentRow.ClientID %>').val() + '').val()) <= 0) {
                        $('#txtnOpening_' + $('#<%=HFCurrentRow.ClientID %>').val() + '').removeAttr('disabled');
                    }
                }
                
            }

            if (CID.val() == "") {
                URL = "TranCRUD.asmx/AddUpdateDeleteTblTranDailySales";
                DATA = "{'Query':'" + Query + "','PID':'" + PID.val() + "','dDate':'" + dDate.val() + "','nSrNo':'','nBranchID':'" + nBranchID + "','nCompID':'" + nCompID + "','cAccYear':'" + cAccYear + "','nInstID':'" + nInstID + "','nUpID':'" + nInstID + "','CID':'" + CID.val() + "','nStationID':'" + nStationID.val() + "','nStaffID':'" + nStaffID.val() + "','nShift':'" + nShift.val() + "','nOpening':'" + nOpening.val() + "','nClosing':'" + nClosing.val() + "','nDiff':'" + nDiff.val() + "','nRate':'" + nRate.val() + "','nDiffRate':'" + ConvertToNum(nDiffRate.val()) + "','nDepositRs':'" + ConvertToNum(nDepositRs.val()) + "','nDiffAmt':'" + ConvertToNum(nDiffAmt.val()) + "','nJumpRate':'" + ConvertToNum(nJumpRate.val()) + "'}";
                makeAjaxCall(Type, true);


                $('#staffModal').modal('hide');

                setTimeout(function () {
                    $('#txtnOpening_' + $('#<%=HFCurrentRow.ClientID %>').val() + '').focus();
                }, 200);


            }
            else {
                //alert(cCurrentAspect.val());
                if (cCurrentAspect.val() == "Cash") {
                    var tempFlag = false;
                    $('.NoteNo').each(function (e) {
                        if (parseFloat($(this).val()) > 0) {
                            tempFlag = true;
                            return false;
                        }
                    });
                    if (tempFlag) {
                        if (nCashID.val() != '') {
                            Query = 'U';
                        }
                        else {
                            Query = 'I';
                        }
                        $('#<%=HFListOpen.ClientID %>').val(0);
                        URL = "TranCRUD.asmx/AddUpdateDeleteTblTranDailySalesChildCash";
                        DATA = "{'Query':'" + Query + "','NID':'" + nCashID.val() + "','nParentID':'" + CID.val() + "','nNotes2000':'" + ConvertToNum(nNotes2000.val()) + "', 'nNotes1000':'" + ConvertToNum(nNotes1000.val()) + "', 'nNotes500':'" + ConvertToNum(nNotes500.val()) + "', 'nNotes100':'" + ConvertToNum(nNotes100.val()) + "', 'nNotes50':'" + ConvertToNum(nNotes50.val()) + "', 'nNotes20':'" + ConvertToNum(nNotes20.val()) + "', 'nNotes10':'" + ConvertToNum(nNotes10.val()) + "', 'nNotes5':'" + ConvertToNum(nNotes5.val()) + "', 'nNotes2':'" + ConvertToNum(nNotes2.val()) + "', 'nNotes1':'" + ConvertToNum(nNotes1.val()) + "', 'nTotalNotes':'" + ConvertToNum(nTotalNotes.val()) + "', 'nTotalRs':'" + ConvertToNum(nTotalRs.val()) + "','cType':'C','nBankID':'" + nBankIDD.GetValue() + "','cCurrentTime':'" + cCurrentTime.val() + "','cCMSSlipNo':'" + cCMSSlipNo.val() + "','cHCINNo':'" + cHCINNo.val() + "','cDepositerName':'" + cDepositerName.val() + "','nCoins':'" + ConvertToNum(nCoins.val()) + "'}";
                        makeAjaxCall(Type, false);
                        clearCash();
                        SaveDetails('CashListGrid');
                        //$('#staffModal').modal('hide');
                    }
                    $('#staffModal').modal('hide');

                }
                else if (cCurrentAspect.val() == "CreditCard" || cCurrentAspect.val() == "Paytm") {
                    if (nCreditCardID.val() != '') {
                        Query = 'U';
                    }
                    else {
                        Query = 'I';
                    }

                    if (DXcBank.GetValue() == null) {
                        alertify.alert("Bank is Required!", function () {
                            DXcBank.Focus();
                        });
                    }
                        //else if ($('#TxtcCreditCardNo').val() == '') {
                        //    alertify.alert("Credit Card No is Required!", function () {
                        //        $('#TxtcCreditCardNo').focus();
                        //    });
                        //}
                    else if (ConvertToNum($('#TxtnCreditCardRs').val()) <= 0) {
                        alertify.alert("Rs. is Required!", function () {
                            $('#TxtnCreditCardRs').focus();
                        });
                    }
                    else {
                        if (cCurrentAspect.val() == "CreditCard") {
                            cType = '0';
                        }
                        else {
                            cType = '1';
                        }

                        URL = "TranCRUD.asmx/AddUpdateDeleteTblTranDailySalesChildCreditCard";
                        DATA = "{'Query':'" + Query + "','NID':'" + nCreditCardID.val() + "','nParentID':'" + CID.val() + "','nBankID':'" + nBankID.GetValue() + "', 'cCardNo':'" + cCardNo.val() + "', 'nRs':'" + ConvertToNum(nRs.val()) + "','cType':'" + cType + "'}";
                        makeAjaxCall(Type, false);

                        clearCreditCard();
                        $('#staffModal').modal('hide');
                    }
                }
                else if (cCurrentAspect.val() == "CreditSale" || cCurrentAspect.val() == "AdaniSale") {
                    if (nCreditSalesID.val() != '') {
                        Query = 'U';
                    }
                    else {
                        Query = 'I';
                    }

                    if (DXcCustomer.GetValue() == null) {
                        alertify.alert("Customer is Required!", function () {
                            DXcCustomer.Focus();
                        });
                    }
                        //else if ($('#TxtcVehicleNo').val() == '') {
                        //    alertify.alert("Vehicle No is Required!", function () {
                        //        $('#TxtcVehicleNo').focus();
                        //    });
                        //}
                    else if (ConvertToNum($('#TxtnCreditSaleRs').val()) <= 0) {
                        alertify.alert("Rs. is Required!", function () {
                            $('#TxtnCreditCardRs').focus();
                        });
                    }
                    else {
                        if (cCurrentAspect.val() == "CreditSale") {
                            cType = '0';
                        }
                        else {
                            cType = '1';
                        }

                        URL = "TranCRUD.asmx/AddUpdateDeleteTblTranDailySalesChildCreditSales";
                        DATA = "{'Query':'" + Query + "','NID':'" + nCreditSalesID.val() + "','nParentID':'" + CID.val() + "','nCustomerID':'" + nCustomerID.GetValue() + "', 'cVehicleNo':'" + cVehicleNo.val() + "', 'nRs':'" + ConvertToNum(nCreditSaleRs.val()) + "', 'nRate':'" + ConvertToNum(nRate.val()) + "', 'nQty':'" + ConvertToNum(nCreditSaleQty.val()) + "','cNarration':'" + cNarration.val() + "','cType':'" + cType + "'}";
                        makeAjaxCall(Type, false);

                        clearCreditSales();
                        $('#staffModal').modal('hide');
                    }
                }

                //setTimeout(function () {
                //    makeAjaxCall('Search', true);
                //}, 250);
                setTimeout(function () {
                    GetDepositRs();
                }, 300);
            }

        }
        else {
            alertify.alert("Select a Staff!", function () {
                DXcStaff1.Focus();
            });
        }
    }
    else if (Type == "O") {
        URL = "TranCRUD.asmx/AddUpdateDeleteTblTranDailySales";
        DATA = "{'Query':'" + Query + "','PID':'" + PID.val() + "','dDate':'" + dDate.val() + "','nSrNo':'','nBranchID':'" + nBranchID + "','nCompID':'" + nCompID + "','cAccYear':'" + cAccYear + "','nInstID':'" + nInstID + "','nUpID':'" + nInstID + "','CID':'" + CID.val() + "','nStationID':'" + nStationID.val() + "','nStaffID':'" + nStaffID.val() + "','nShift':'" + nShift.val() + "','nOpening':'" + nOpening.val() + "','nClosing':'" + nClosing.val() + "','nDiff':'" + nDiff.val() + "','nRate':'" + nRate.val() + "','nDiffRate':'" + ConvertToNum(nDiffRate.val()) + "','nDepositRs':'" + ConvertToNum(nDepositRs.val()) + "','nDiffAmt':'" + ConvertToNum(nDiffAmt.val()) + "','nJumpRate':'" + ConvertToNum(nJumpRate.val()) + "'}";
        makeAjaxCall(Type, true);
        //setTimeout(function () {
        //    makeAjaxCall('Search', true);
        //}, 250);
        setTimeout(function () {
            GetDepositRs();
        }, 300);
    }

    else if (Type == "C") {

        URL = "TranCRUD.asmx/AddUpdateDeleteTblTranDailySales";
        DATA = "{'Query':'" + Query + "','PID':'" + PID.val() + "','dDate':'" + dDate.val() + "','nSrNo':'','nBranchID':'" + nBranchID + "','nCompID':'" + nCompID + "','cAccYear':'" + cAccYear + "','nInstID':'" + nInstID + "','nUpID':'" + nInstID + "','CID':'" + CID.val() + "','nStationID':'" + nStationID.val() + "','nStaffID':'" + nStaffID.val() + "','nShift':'" + nShift.val() + "','nOpening':'" + nOpening.val() + "','nClosing':'" + nClosing.val() + "','nDiff':'" + nDiff.val() + "','nRate':'" + nRate.val() + "','nDiffRate':'" + ConvertToNum(nDiffRate.val()) + "','nDepositRs':'" + ConvertToNum(nDepositRs.val()) + "','nDiffAmt':'" + ConvertToNum(nDiffAmt.val()) + "','nJumpRate':'" + ConvertToNum(nJumpRate.val()) + "'}";
        makeAjaxCall(Type, true);
        //setTimeout(function () {
        //    makeAjaxCall('Search', true);
        //}, 250);
        setTimeout(function () {
            GetDepositRs();
        }, 300);
    }

    else if (Type == "J") {

        URL = "TranCRUD.asmx/AddUpdateDeleteTblTranDailySales";
        DATA = "{'Query':'" + Query + "','PID':'" + PID.val() + "','dDate':'" + dDate.val() + "','nSrNo':'','nBranchID':'" + nBranchID + "','nCompID':'" + nCompID + "','cAccYear':'" + cAccYear + "','nInstID':'" + nInstID + "','nUpID':'" + nInstID + "','CID':'" + CID.val() + "','nStationID':'" + nStationID.val() + "','nStaffID':'" + nStaffID.val() + "','nShift':'" + nShift.val() + "','nOpening':'" + nOpening.val() + "','nClosing':'" + nClosing.val() + "','nDiff':'" + nDiff.val() + "','nRate':'" + nRate.val() + "','nDiffRate':'" + ConvertToNum(nDiffRate.val()) + "','nDepositRs':'" + ConvertToNum(nDepositRs.val()) + "','nDiffAmt':'" + ConvertToNum(nDiffAmt.val()) + "','nJumpRate':'" + ConvertToNum(nJumpRate.val()) + "'}";
        makeAjaxCall(Type, true);
        //setTimeout(function () {
        //    makeAjaxCall('Search', true);
        //}, 250);
        setTimeout(function () {
            GetDepositRs();
        }, 300);
    }

    else if (Type == "CashListGrid") {
        URL = "TranCRUD.asmx/ListTblTranDailySalesChildCash";
        DATA = "{'PID':'" + CID.val() + "','cType':'C'}";
        makeAjaxCall(Type, true);

    }

    else if (Type == "CreditCardListGrid") {
        $('#spanCreditCardHead').text('Credit Card List');
        URL = "TranCRUD.asmx/ListTblTranDailySalesChildCreditCard";
        DATA = "{'PID':'" + CID.val() + "','cType':'0'}";
        makeAjaxCall(Type, true);
    }

    else if (Type == "PaytmListGrid") {
        $('#spanCreditCardHead').text('Paytm List');
        URL = "TranCRUD.asmx/ListTblTranDailySalesChildCreditCard";
        DATA = "{'PID':'" + CID.val() + "','cType':'1'}";
        makeAjaxCall(Type, true);
    }

    else if (Type == "CreditSalesListGrid") {
        $('#spanCreditSalesHead').text('Credit Sales List');
        URL = "TranCRUD.asmx/ListTblTranDailySalesChildCreditSales";
        DATA = "{'PID':'" + CID.val() + "','cType':'0'}";
        makeAjaxCall(Type, true);
    }

    else if (Type == "AdaniSalesListGrid") {
        $('#spanCreditSalesHead').text('Adani Sales List');
        URL = "TranCRUD.asmx/ListTblTranDailySalesChildCreditSales";
        DATA = "{'PID':'" + CID.val() + "','cType':'1'}";
        makeAjaxCall(Type, true);
    }

    else if (Type == "CashDepositListGrid") {
        URL = "TranCRUD.asmx/ListTblTranDailySalesChildCash";
        DATA = "{'PID':'" + PID.val() + "','cType':'CD'}";
        makeAjaxCall(Type, true);
        //$('#txtnDRs2000').focus();
        DXcBankD.Focus();
    }


            //else {
            //    URL = "TranCRUD.asmx/AddUpdateDeleteTblTranDailySales";
            //    DATA = "{'Query':'" + Query + "','PID':'" + PID.val() + "','dDate':'" + dDate.val() + "','nSrNo':'','nBranchID':'" + nBranchID + "','nCompID':'" + nCompID + "','cAccYear':'" + cAccYear + "','nInstID':'" + nInstID + "','nUpID':'" + nInstID + "','CID':'" + CID.val() + "','nStationID':'" + nStationID.val() + "','nStaffID':'" + nStaffID.val() + "','nShift':'" + nShift.val() + "','nOpening':'" + nOpening.val() + "','nClosing':'" + nClosing.val() + "','nDiff':'" + nDiff.val() + "','nJumpRate':'" + ConvertToNum(nJumpRate.val()) + "'}";
            //    makeAjaxCall(Type, true);
            //}

            //if ($('#<%=HFCurrentAspect.ClientID %>').val() == "Cash") {
            //
            //}
            //else if ($('#<%=HFCurrentAspect.ClientID %>').val() == "CreditCard") {
            //
            //}
            //else {
            //
            //}

        }

        function makeAjaxCall(Type, bIsResponseReqiured) {
            //alert(Type + URL + bIsResponseReqiured);
            $.ajax({
                type: "POST",
                url: URL,
                data: DATA,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (bIsResponseReqiured == true) {
                        SaveResponse(Type, response);
                    }
                    GetTotalRs();
                    GetTotalShiftRs();
                    GetPreviousData();
                },
                error: function (response) {
                    alertify.alert(response.d.Msg);
                }
            });
        }


        function SaveResponse(Type, response) {
            //alert(Type);
            var PID = $('#<%=HFPID.ClientID%>');
            var nCurrentRow = $('#<%=HFCurrentRow.ClientID %>').val();
            var dDate = $('#<%=TxtdDate.ClientID%>');
            var nSrNo = $('#<%=TxtnTranNo.ClientID%>');
            var nBranchID = $.cookie('CNGPumpBranchID');
            var nCompID = $.cookie('CNGPumpCompID');
            var cAccYear = $.cookie('CNGPumpAccYear');
            var nInstID = $.cookie('CNGPumpLoginID');
            //var CID = $('#<%=HFCID.ClientID%>');
            var CID = $('#HFCID_' + nCurrentRow + '');
            var nStationID = $('#HFStationID_' + nCurrentRow + '');
            var nStaffID = $('#HFStaffID_' + nCurrentRow + '');
            var cStaffName = $('#spanStaffName_' + nCurrentRow + '');
            var nShift = $('#<%=HFCurrentShift.ClientID %>');
            var nOpening = $('#txtnOpening_' + nCurrentRow + '');
            var nClosing = $('#txtnClosing_' + nCurrentRow + '');
            var nDiff = $('#txtnDiff_' + nCurrentRow + '');
            var nDiffRate = $('#txtnDiffRate_' + nCurrentRow + '');
            var nDepositRate = $('#txtnDepositRate_' + nCurrentRow + '');
            var nDiffAmt = $('#txtnDiffAmt_' + nCurrentRow + '');
            var nJumpRate = $('#txtnJumpRate_' + nCurrentRow + '');

            var ID = GetParameterValues('ID');
            var E = GetParameterValues('E');
            var D = GetParameterValues('D');
            var tempNID = '';

            if (parseFloat(nOpening.val()) >= 0) {
                if ($('#<%=HFDayDone.ClientID %>').val() != 1) {
                    if ($.cookie('CNGPumpLogin_Type') != 2) {
                        $('#txtnClosing_' + nCurrentRow + '').removeAttr('disabled');
                    }
                    else {
                        if (ConvertToNum($('#txtnClosing_' + nCurrentRow + '').val()) <= 0) {                           
                            $('#txtnClosing_' + nCurrentRow + '').removeAttr('disabled');
                        }
                    }
                    $('#nJumpRate' + nCurrentRow + '').removeAttr('disabled');
                }

                $('#txtnClosing_' + nCurrentRow + '').focus();


                //$('#txtnOpening_' + nCurrentRow + '').focus();

            }

            if (Type == "CashDepositDelete") {
                $('#CashList').modal('hide');
            }
            if (Type == "S" || Type == "SC" || Type == "O" || Type == "C") {
                if (PID.val() == "") {
                    PID.val(response.d[0].PID);
                    location.href = "TranDailySale.aspx?ID=" + PID.val() + "&E=1";
                }
                tempNID = response.d[0].PID;
                PID.val(response.d[0].PID);
                nSrNo.val(response.d[0].nSrNo);
                dDate.val(response.d[0].dDate);
                CID.val(response.d[0].CID);
                nStationID.val(response.d[0].nStationID);
                //dDate.val(response.d[0].cStationName);
                nStaffID.val(response.d[0].nStaffID);

                //DXcStaff1.SetText(response.d[0].cStaffName);
                //alert(response.d[0].cStaffName);
                cStaffName.text(response.d[0].cStaffName);
                //$('#<%=HFCurrentStaffName.ClientID %>').val();
                //$('#<%=HFCurrentStaffID.ClientID %>').val();
                //dDate.val(response.d[0].nShift);
                nOpening.val(response.d[0].nOpening);
                nClosing.val(response.d[0].nClosing);
                nDiff.val(response.d[0].nDiff);
                nDiffRate.val(response.d[0].nDiffRate);
                nDepositRate.val(response.d[0].nDepositRs);
                //nDiffAmt.val(parseInt(response.d[0].nDiffAmt).toFixed(0));
                nDiffAmt.val(Math.round(response.d[0].nDiffAmt));
                nJumpRate.val(response.d[0].nJumpRate);



                setTimeout(function () {
                    var CalendarExtender1Behavior = $find("bCalendarExtenderdDate");
                    CalendarExtender1Behavior.set_selectedDate(getDateDJ(response.d[0].dDate, 'dd/MM/yyyy', 'MM/dd/yyyy'), 'MM/dd/yyyy', 'dd/MM/yyyy');
                    DXcStaff1.SetText(response.d[0].cStaffName);
                    DXcStaff1.SetValue(response.d[0].nStaffID);
                }, 200);


            }
            else if (Type == 'Search') {
                var tempIndex = 0;
                for (var i = 0; i < response.d.length; i++) {
                    $('#btnDetails_' + i).removeAttr('disabled');
                    if (i == 0) {
                        PID.val(response.d[i].PID);
                        nSrNo.val(response.d[i].nSrNo);
                        dDate.val(response.d[i].dDate);
                        getTodayRate();
                        setTimeout(function () {
                            DXcStaff1.SetText(response.d[0].cStaffName);
                            DXcStaff1.SetValue(response.d[0].nStaffID);
                        }, 200);
                        $('#<%=HFDayDone.ClientID %>').val(response.d[0].cDayDone);
                        if (response.d[0].cDayDone == 1) {
                            alertify.alert("You can't Edit/Delete this SALE!", function () {
                                $('.panel-content').find('input,submit,textarea,button,select').attr('disabled', 'disabled');
                                $('submit,button').not('.AddList').removeAttr('onclick');
                            });
                        }
                    }
                    else {
                        tempIndex = i - 1;
                        if ($('#HFStationID_' + tempIndex + '').val() == response.d[i].nStationID) {
                            $('#HFCID_' + tempIndex + '').val(response.d[i].CID);
                            $('#HFStaffID_' + tempIndex + '').val(response.d[i].nStaffID);
                            $('#spanStaffName_' + tempIndex + '').text(response.d[i].cStaffName);
                            //alert(response.d[i].nShift);
                            //$('#<%=HFCurrentShift.ClientID %>').val(response.d[i].nShift);
                            $('#txtnOpening_' + tempIndex + '').val(response.d[i].nOpening);

                            if (response.d[i].nStaffID != '') {
                                if ($('#<%=HFDayDone.ClientID %>').val() != 1) {  
                                    if ($.cookie('CNGPumpLogin_Type') != 2) {
                                        $('#txtnOpening_' + tempIndex + '').removeAttr('disabled');
                                        $('#txtnClosing_' + tempIndex + '').removeAttr('disabled');
                                    }
                                    else {
                                        if (parseFloat(response.d[i].nOpening) <= 0) {
                                            $('#txtnOpening_' + tempIndex + '').removeAttr('disabled');
                                        }
                                        if (parseFloat(response.d[i].nClosing) <= 0) {                                            
                                            $('#txtnClosing_' + tempIndex + '').removeAttr('disabled');
                                        }
                                    }
                                    $('#txtnJumpRate_' + tempIndex + '').removeAttr('disabled');
                                    
                                }
                            }

                            <%--if (parseFloat(response.d[i].nOpening) > 0) {
                                if ($('#<%=HFDayDone.ClientID %>').val() != 1) {                                    
                                    if ($.cookie('CNGPumpLogin_Type') != 2) {                                        
                                        $('#txtnOpening_' + tempIndex + '').removeAttr('disabled');                                        
                                        $('#txtnClosing_' + tempIndex + '').removeAttr('disabled');                                        
                                    }
                                    else {
                                        if (ConvertToNum($('#txtnOpening_' + tempIndex + '').val()) == 0) {
                                            $('#txtnOpening_' + tempIndex + '').removeAttr('disabled');
                                        }
                                        if (ConvertToNum($('#txtnClosing_' + tempIndex + '').val()) == 0) {
                                            //$('#txtnClosing_' + tempIndex + '').removeAttr('disabled');
                                        }
                                    }
                                    
                                    $('#txtnJumpRate_' + tempIndex + '').removeAttr('disabled');

                                }
                            }--%>
                            $('#txtnClosing_' + tempIndex + '').val(response.d[i].nClosing);
                            <%--if (parseFloat(response.d[i].nClosing) > 0) {
                                if ($('#<%=HFDayDone.ClientID %>').val() != 1) {
                                    if ($.cookie('CNGPumpLogin_Type') != 2) {                                        
                                        $('#txtnClosing_' + tempIndex + '').removeAttr('disabled');                                        
                                    }
                                    else {
                                        if (ConvertToNum($('#txtnClosing_' + tempIndex + '').val()) == 0) {
                                            $('#txtnClosing_' + tempIndex + '').removeAttr('disabled');
                                        }
                                    }
                                    $('#txtnJumpRate_' + tempIndex + '').removeAttr('disabled');
                                }
                            }--%>
                            $('#txtnDiff_' + tempIndex + '').val(response.d[i].nDiff);
                            $('#txtnJumpRate_' + tempIndex + '').val(response.d[i].nJumpRate);
                            $('#txtnDiffRate_' + tempIndex + '').val(response.d[i].nDiffRate);
                            $('#txtnDepositRate_' + tempIndex + '').val(response.d[i].nDepositRs);
                            $('#txtnDiffAmt_' + tempIndex + '').val(Math.round(response.d[i].nDiffAmt));
                        }
                    }
                }

            }
            else if (Type == "CashListGrid" || Type == "CashDepositListGrid") {
                ListCash(response.d, Type);

            }
            else if (Type == "CashListGridTotal") {
                ListCashTotal(response.d, Type);
            }
            else if (Type == "CashDelete" || Type == "Cash" || Type == "CashDepositDelete") {
                $('#<%=HFIsDeleteState.ClientID %>').val(1);
                window.onkeydown = null;
                $('#btnAlertOK').unbind('click');

                swal("Deleted!", "You have successfully DELETE Cash Details!", "success");
                $('#btnAlertOK').on('click', function () {
                    if ($('#<%=HFCurrentType.ClientID %>').val() == 'Cash' || $('#<%=HFCurrentType.ClientID %>').val() == 'CashDeposit') {
                        if (Type == "CashDelete" || Type == "Cash") {
                            SaveDetails('CashListGrid');
                        }
                        else {
                            //alert("A");
                            SaveDetails('CashDepositListGrid');
                        }
                    }
                    //SaveDetails('CashListGrid');
                    //ListCash(response.d);
                });
            }
            else if (Type == "CreditCardListGrid" || Type == "PaytmListGrid") {
                ListCreditCard(response.d, Type);

            }
            else if (Type == "CreditCardListGridTotal" || Type == "PaytmListGridTotal") {
                ListCreditCardTotal(response.d, Type);

            }
            else if (Type == "CreditCardDelete" || Type == "PaytmDelete") {
                var CCPTM = '';
                if (Type == "CreditCardDelete") {
                    CCPTM = 'Credit Card';
                }
                else {
                    CCPTM = 'Paytm';
                }
                window.onkeydown = null;
                swal("Deleted!", "You have successfully DELETE " + CCPTM + " Details!", "success");
                $('#btnAlertOK').on('click', function () {
                    if ($('#<%=HFCurrentType.ClientID %>').val() == 'CreditCard') {
                        if (Type == "CreditCardDelete") {
                            SaveDetails('CreditCardListGrid');
                        }
                        else {
                            SaveDetails('PaytmListGrid');
                        }
                        $('#<%=HFCurrentType.ClientID %>').val('');
                    }
                    //ListCash(response.d);
                });
            }
            else if (Type == "CreditSalesListGrid" || Type == "AdaniSalesListGrid") {
                ListCreditSales(response.d, Type);

            }
            else if (Type == "CreditSalesListGridTotal" || Type == "AdaniSalesListGridTotal") {
                ListCreditSalesTotal(response.d, Type);

            }
            else if (Type == "CreditSalesDelete" || Type == "AdaniSalesDelete") {
                var CSAS = '';
                if (Type == "CreditCardDelete") {
                    CSAS = 'Credit Sales';
                }
                else {
                    CSAS = 'Adani Sales';
                }
                window.onkeydown = null;
                swal("Deleted!", "You have successfully DELETE " + CSAS + " Details!", "success");
                $('#btnAlertOK').on('click', function () {
                    if ($('#<%=HFCurrentType.ClientID %>').val() == 'CreditSales') {
                        if (Type == "CreditSalesDelete") {
                            SaveDetails('CreditSalesListGrid');
                        }
                        else {
                            SaveDetails('AdaniSalesListGrid');
                        }

                        $('#<%=HFCurrentType.ClientID %>').val('');
                    }
                    //ListCash(response.d);
                });
            }
            else if (Type == "CashDeposit") {
                SaveDetails('CashDepositListGrid');
            }

    TotalDiffKG();
    TotalDiffRate();
    TotalDepositRs();
    TotalDiffAmt();
    TotalJumpRate();
            //GetTotalRs();
}

function ModalCash() {
    $('#<%=HFCurrentAspect.ClientID %>').val('Cash');
    if (!$('#liCashTab').hasClass('active')) {
        $('#txtnRs2000').focus();
        clearCash();
        clearCreditCard(1);
        clearCreditSales();
    }
    else {
        return false;
    }
}

function ModalCreditCard() {
    $('#<%=HFCurrentAspect.ClientID %>').val('CreditCard');
    if (!$('#liCreditCardTab').hasClass('active')) {
        DXcBank.Focus();
        clearCash();
        clearCreditCard(1);
        clearCreditSales();
    }
    else {
        return false;
    }
}

function ModalPaytm() {
    $('#<%=HFCurrentAspect.ClientID %>').val('Paytm');
    if (!$('#liPaytmTab').hasClass('active')) {
        DXcBank.Focus();
        clearCash();
        clearCreditCard(2);
        clearCreditSales();
    }
    else {
        return false;
    }
}

function ModalCreditSales() {
    $('#<%=HFCurrentAspect.ClientID %>').val('CreditSale');
    if (!$('#liCreditSalesTab').hasClass('active')) {
        DXcCustomer.Focus();
        clearCash();
        clearCreditCard(1);
        clearCreditSales();
    }
    else {
        return false;
    }
}

function ModalAdaniSales() {
    $('#<%=HFCurrentAspect.ClientID %>').val('AdaniSale');
    if (!$('#liAdaniSalesTab').hasClass('active')) {
        DXcCustomer.Focus();
        clearCash();
        clearCreditCard(1);
        clearCreditSales();
    }
}

function CalculateCashNotes(Note, currObj) {
    var nNote = $('#txtnRs' + Note + '');
    var nNoteNo = currObj;
    var nNoteTotal = $('#txtnRs' + Note + 'Total');
    var nTotalRs = 0;
    var nTotalNotes = 0;
    var nCoins = '';

    if (parseFloat(nNoteNo.val()) > 0) {
        nNoteTotal.val(nNoteNo.val() * parseFloat(Note));
    }
    else {
        nNoteTotal.val(0);
    }

    $('.NoteCount').each(function (e) {
        if ($.trim($(this).attr('id').toString()) != 'txtnCoinsRsTotal') {
            nTotalRs += parseFloat(ConvertToNum($(this).val()));
            //alert($.trim($(this).attr('id').toString()) + ' ==> ' + $(this).val());
            //alert(message);
        }
    });

    nTotalRs += parseFloat(ConvertToNum($('#txtnCoinsRsTotal').val()));

    $('.NoteNo').not('#txtnCoinsRsTotal').each(function (e) {
        //if ($.trim(currObj.attr('id').toString()) != 'txtnCoinsRsTotal') {
        nTotalNotes += parseFloat(ConvertToNum($(this).val()));
        //}
    });

    //alert(currObj.attr('id'));
    //alert(nTotalRs);

    $('#spanTotalRs').text(nTotalRs);
    $('#spanTotalNotes').text(nTotalNotes);

}

function CalculateCashNotesDeposit(Note, currObj) {
    var nNote = $('#txtnDRs' + Note + '');
    var nNoteNo = currObj;
    var nNoteTotal = $('#txtnDRs' + Note + 'Total');
    var nTotalRs = 0;
    var nTotalNotes = 0;

    if (parseFloat(nNoteNo.val()) > 0) {
        nNoteTotal.val(nNoteNo.val() * parseFloat(Note));
    }
    else {
        nNoteTotal.val(0);
    }
    //txtnCoinsRsDTotal
    $('.NoteCountD').each(function (e) {
        if ($.trim($(this).attr('id').toString()) != 'txtnCoinsRsDTotal') {
            nTotalRs += parseFloat(ConvertToNum($(this).val()));
        }
    });

    nTotalRs += parseFloat(ConvertToNum($('#txtnCoinsRsDTotal').val()));

    $('.NoteNoD').each(function (e) {
        if ($.trim($(this).attr('id').toString()) != 'txtnCoinsRsDTotal') {
            nTotalNotes += parseFloat(ConvertToNum($(this).val()));
        }
    });

    $('#spanDTotalRs').text(nTotalRs);
    $('#spanDTotalNotes').text(nTotalNotes);

}

$(document).one('shown.bs.modal', function (e) {
    setTimeout(function () {
        DXcStaff1.SetValue($('#HFStaffID_' + $('#<%=HFCurrentRow.ClientID %>').val() + '').val());
        DXcStaff1.Focus();
    }, 200);
});


//$('#staffModal').modal('toggle');

$(document).one('hidden.bs.modal', function (e) {

    $('#txtnOpening_' + $('#<%=HFCurrentRow.ClientID %>').val() + '').focus();

    //clearCash();
    //clearCreditCard();
    //clearCreditSales();
});

function getStaff(currObj) {
}

function ListCash(Receipt, Type) {
    BindCashTable(Receipt, Type);

}
function ListCashTotal(Receipt, Type) {
    BindCashTableTotal(Receipt, Type);

}

function ListCreditCard(Receipt, Type) {
    BindCreditCardTable(Receipt, Type);
}
function ListCreditCardTotal(Receipt, Type) {
    BindCreditCardTableTotal(Receipt, Type);
}

function ListCreditSales(Receipt, Type) {
    BindCreditSalesTable(Receipt, Type);
}
function ListCreditSalesTotal(Receipt, Type) {
    BindCreditSalesTableTotal(Receipt, Type);
}

function BindCashTable(Receipt, Type) {
    var root;
    var nStaffWiseRs = 0;
    if (Type == "CashListGrid") {
        root = document.getElementById('MyDivCash');
    }
    else {
        root = document.getElementById('myDivCashDeposit');
    }

    try {
        var tblId;
        if (Type == "CashListGrid") {
            tblId = document.getElementById('example');
        }
        else {
            tblId = document.getElementById('example7');
        }

        if (tblId != null) {
            root.removeChild(tblId);
        }
    }
    catch (e) {

    }
    var tab = document.createElement('table');

    if (Type == "CashListGrid") {
        tab.setAttribute("id", "example");
    }
    else {
        tab.setAttribute("id", "example7");
    }

    //tab.setAttribute("id", "example");
    tab.setAttribute("class", "table table-responsive table-bordered table-hover");
    tab.setAttribute("cellspacing", "1px");

    var tbo = document.createElement('thead');
    var row, cell;

    var Title1 = document.createElement('Label');
    var Title2 = document.createElement('Label');
    var Title3 = document.createElement('Label');
    var Title4 = document.createElement('Label');
    var Title5 = document.createElement('Label');
    var Title6 = document.createElement('Label');
    var Title7 = document.createElement('Label');
    var Title8 = document.createElement('Label');
    var Title9 = document.createElement('Label');
    var Title10 = document.createElement('Label');
    var Title11 = document.createElement('Label');
    var Title12 = document.createElement('Label');
    var Title13 = document.createElement('Label');
    var Title14 = document.createElement('Label');
    var Title15 = document.createElement('Label');
    var Title16 = document.createElement('Label');



    Title1.innerHTML = "NID";
    if (Type == "CashListGrid" || Type == 'C' || Type == 'Cash') {
        Title2.innerHTML = "Denom";
    }
    else {
        Title2.innerHTML = "Bank Name";
    }

    Title3.innerHTML = "2000";
    Title4.innerHTML = "1000";
    Title5.innerHTML = "500";
    Title6.innerHTML = "100";
    Title7.innerHTML = "50";
    Title8.innerHTML = "20";
    Title9.innerHTML = "10";
    Title10.innerHTML = "5";
    Title11.innerHTML = "2";
    Title12.innerHTML = "1";
    Title13.innerHTML = "Coins/Rs.";
    Title14.innerHTML = "Total Notes";
    Title15.innerHTML = "Total Rs";


    row = document.createElement('tr');

    //row.setAttribute("bgcolor", "#2A3F54");
    row.setAttribute("style", "background-color:#2A3F54;color:#FFF");

    cell = document.createElement('th');
    cell.appendChild(Title2);

    if (Type == "CashListGrid" || Type == 'C' || Type == 'Cash') {
        cell.setAttribute("style", "width:60px;color:#FFF");
    }
    else {
        cell.setAttribute("style", "width:200px;color:#FFF");
    }
    row.appendChild(cell);

    cell = document.createElement('th');
    cell.appendChild(Title3);
    cell.setAttribute("style", "width:50px;padding-left:5px;color:#FFF");
    row.appendChild(cell);

    //cell = document.createElement('th');
    //cell.appendChild(Title4);
    //cell.setAttribute("style", "width:50px;padding-left:5px;color:#FFF");
    //row.appendChild(cell);

    cell = document.createElement('th');
    cell.appendChild(Title5);
    cell.setAttribute("style", "width:50px;padding-left:5px;color:#FFF");
    row.appendChild(cell);

    cell = document.createElement('th');
    cell.appendChild(Title6);
    cell.setAttribute("style", "width:50px;padding-left:5px;color:#FFF");
    row.appendChild(cell);

    cell = document.createElement('th');
    cell.appendChild(Title7);
    cell.setAttribute("style", "width:48px;padding-left:5px;color:#FFF");
    row.appendChild(cell);

    cell = document.createElement('th');
    cell.appendChild(Title8);
    cell.setAttribute("style", "width:48px;padding-left:5px;color:#FFF");
    row.appendChild(cell);

    cell = document.createElement('th');
    cell.appendChild(Title9);
    cell.setAttribute("style", "width:48px;padding-left:5px;color:#FFF");
    row.appendChild(cell);

    //cell = document.createElement('th');
    //cell.appendChild(Title10);
    //cell.setAttribute("style", "width:45px;padding-left:5px;color:#FFF");
    //row.appendChild(cell);
    //
    //cell = document.createElement('th');
    //cell.appendChild(Title11);
    //cell.setAttribute("style", "width:45px;padding-left:5px;color:#FFF");
    //row.appendChild(cell);
    //
    //cell = document.createElement('th');
    //cell.appendChild(Title12);
    //cell.setAttribute("style", "width:45px;padding-left:5px;color:#FFF");
    //row.appendChild(cell);

    cell = document.createElement('th');
    cell.appendChild(Title13);
    //cell.setAttribute("style", "width:110px;padding-left:5px;color:#FFF");
    cell.setAttribute("style", "color:#FFF;width:80px;");
    row.appendChild(cell);

    cell = document.createElement('th');
    cell.appendChild(Title14);
    //cell.setAttribute("style", "width:110px;padding-left:5px;color:#FFF");
    cell.setAttribute("style", "color:#FFF");
    row.appendChild(cell);

    cell = document.createElement('th');
    cell.appendChild(Title15);
    cell.setAttribute("style", "width:85px;padding-left:5px;color:#FFF");
    row.appendChild(cell);


    cell = document.createElement('th');
    cell.setAttribute("style", "width:90px;padding-left:5px;color:#FFF");
    row.appendChild(cell);

    tbo.appendChild(row);
    tab.appendChild(tbo);
    root.appendChild(tab);

    var tbo = document.createElement('tbody');
    $.each(Receipt, function (index, Receipt1) {

        row = document.createElement('tr');
        row.setAttribute("class", "even pointer");

        //
        // the object of LIST is now extract the each cell of row
        //

        for (var j = 1; j < 12; j++) {

            cell = document.createElement('td');
            cell.setAttribute("class", " ");
            //cell.setAttribute("width", "100px");

            var nNotes2000 = Receipt1.nNotes2000;
            var nNotes1000 = Receipt1.nNotes1000;
            var nNotes500 = Receipt1.nNotes500;
            var nNotes100 = Receipt1.nNotes100;
            var nNotes50 = Receipt1.nNotes50;
            var nNotes20 = Receipt1.nNotes20;
            var nNotes10 = Receipt1.nNotes10;
            var nNotes5 = Receipt1.nNotes5;
            var nNotes2 = Receipt1.nNotes2;
            var nNotes1 = Receipt1.nNotes1;
            var nTotalNotes = Receipt1.nTotalNotes;
            var nTotalRs = Receipt1.nTotalRs;
            var cNotes = 'Notes';
            var cCurrentTime = Receipt1.cCurrentTime;
            var nBankID = Receipt1.nBankID;
            var cBankName = Receipt1.cBankName;
            var cCMSSlipNo = Receipt1.cCMSSlipNo;
            var cHCINNo = Receipt1.cHCINNo;
            var cDepositerName = Receipt1.cDepositerName;
            var nCoins = Receipt1.nCoins;

            if (j == 0) {
                //Create an input type dynamically.
                var hiddenId = document.createElement("input");
                //Assign different attributes to the element.
                hiddenId.setAttribute("type", "hidden");
                hiddenId.setAttribute("id", "hfRow_" + Receipt1.NID);
                hiddenId.setAttribute("value", Receipt1.NID);
                cell.appendChild(hiddenId);
            }

            else if (j == 1) {
                var spanValue = document.createElement("span");
                //cell.setAttribute("style", "padding-right:5px;text-align:right;");

                if (Type == "CashListGrid" || Type == 'C' || Type == 'Cash') {
                    spanValue.appendChild(document.createTextNode(cNotes));
                }
                else {
                    spanValue.appendChild(document.createTextNode(cBankName + ' (' + cCurrentTime + ')'));
                }

                cell.appendChild(spanValue);
            }

            else if (j == 2) {
                var spanValue = document.createElement("span");
                cell.setAttribute("style", "padding-right:5px;text-align:right;");
                spanValue.appendChild(document.createTextNode(nNotes2000));
                cell.appendChild(spanValue);
            }

                //                    else if (j == 3) {
                //                        var spanValue = document.createElement("span");
                //                        cell.setAttribute("style", "padding-right:5px;text-align:right;");
                //                        spanValue.appendChild(document.createTextNode(nNotes1000));
                //                        cell.appendChild(spanValue);
                //                    }

            else if (j == 3) {
                var spanValue = document.createElement("span");
                cell.setAttribute("style", "padding-right:5px;text-align:right;");
                spanValue.appendChild(document.createTextNode(nNotes500));
                cell.appendChild(spanValue);
            }

            else if (j == 4) {
                var spanValue = document.createElement("span");
                cell.setAttribute("style", "padding-right:5px;text-align:right;");
                spanValue.appendChild(document.createTextNode(nNotes100));
                cell.appendChild(spanValue);
            }

            else if (j == 5) {
                var spanValue = document.createElement("span");
                cell.setAttribute("style", "padding-right:5px;text-align:right;");
                spanValue.appendChild(document.createTextNode(nNotes50));
                cell.appendChild(spanValue);
            }

            else if (j == 6) {
                var spanValue = document.createElement("span");
                cell.setAttribute("style", "padding-right:5px;text-align:right;");
                spanValue.appendChild(document.createTextNode(nNotes20));
                cell.appendChild(spanValue);
            }

            else if (j == 7) {
                var spanValue = document.createElement("span");
                cell.setAttribute("style", "padding-right:5px;text-align:right;");
                spanValue.appendChild(document.createTextNode(nNotes10));
                cell.appendChild(spanValue);
            }

                //else if (j == 8) {
                //    var spanValue = document.createElement("span");
                //    cell.setAttribute("style", "padding-right:5px;text-align:right;");
                //    spanValue.appendChild(document.createTextNode(nNotes5));
                //    cell.appendChild(spanValue);
                //}
                //
                //else if (j == 9) {
                //    var spanValue = document.createElement("span");
                //    cell.setAttribute("style", "padding-right:5px;text-align:right;");
                //    spanValue.appendChild(document.createTextNode(nNotes2));
                //    cell.appendChild(spanValue);
                //}
                //
                //else if (j == 10) {
                //    var spanValue = document.createElement("span");
                //    cell.setAttribute("style", "padding-right:5px;text-align:right;");
                //    spanValue.appendChild(document.createTextNode(nNotes1));
                //    cell.appendChild(spanValue);
                //}

            else if (j == 8) {
                var spanValue = document.createElement("span");
                cell.setAttribute("style", "padding-right:5px;text-align:right;");
                spanValue.appendChild(document.createTextNode(nCoins));
                cell.appendChild(spanValue);
            }


            else if (j == 9) {
                var spanValue = document.createElement("span");
                cell.setAttribute("style", "padding-right:5px;text-align:right;");
                spanValue.appendChild(document.createTextNode(nTotalNotes));
                cell.appendChild(spanValue);
            }

            else if (j == 10) {
                nStaffWiseRs = parseFloat(nStaffWiseRs) + parseFloat(nTotalRs);
                var spanValue = document.createElement("span");
                cell.setAttribute("style", "padding-right:5px;text-align:right;");
                spanValue.appendChild(document.createTextNode(nTotalRs));
                cell.appendChild(spanValue);

            }


            else if (j == 11) {
                var spanValue = document.createElement("a");
                var spanValue1 = document.createElement("i");
                spanValue1.setAttribute("class", "icon wb-edit");

                if ($('#<%=HFIsDeposit.ClientID %>').val() == 1) {
                    Type = "CD";
                }

                if (Type == "CashListGrid" || Type == 'C' || Type == 'Cash') {
                    spanValue.setAttribute("onclick", "EditCash('" + Receipt1.NID + "','" + nNotes2000 + "','" + nNotes1000 + "','" + nNotes500 + "','" + nNotes100 + "','" + nNotes50 + "','" + nNotes20 + "','" + nNotes10 + "','" + nNotes5 + "','" + nNotes2 + "','" + nNotes1 + "','" + nTotalNotes + "','" + nTotalRs + "','C','" + nBankID + "','" + cBankName + "','" + cCurrentTime + "','','','','" + nCoins + "')");
                }
                else {
                    spanValue.setAttribute("onclick", "EditCash('" + Receipt1.NID + "','" + nNotes2000 + "','" + nNotes1000 + "','" + nNotes500 + "','" + nNotes100 + "','" + nNotes50 + "','" + nNotes20 + "','" + nNotes10 + "','" + nNotes5 + "','" + nNotes2 + "','" + nNotes1 + "','" + nTotalNotes + "','" + nTotalRs + "','CD','" + nBankID + "','" + cBankName + "','" + cCurrentTime + "','" + cCMSSlipNo + "','" + cHCINNo + "','" + cDepositerName + "','" + nCoins + "')");
                }


                spanValue.setAttribute("class", "editDeleteButton");
                spanValue.setAttribute("style", "padding:6px 6px;");
                //cell.setAttribute("min-width", "100px");
                //cell.setAttribute("width", "100px");
                //spanValue.setAttribute("title", "Edit");
                spanValue.appendChild(spanValue1);
                cell.appendChild(spanValue);

                var spanValue = document.createElement("a");
                var spanValue1 = document.createElement("i");
                spanValue1.setAttribute("class", "icon wb-trash");

                if ($('#<%=HFIsDeposit.ClientID %>').val() == 1) {
                            Type = "CD";
                        }

                        if (Type == "CashListGrid" || Type == 'C' || Type == 'Cash') {
                            spanValue.setAttribute("onclick", "DeleteCash('" + Receipt1.NID + "','" + Receipt1.nParentID + "','C')");
                        }
                        else {
                            spanValue.setAttribute("onclick", "DeleteCash('" + Receipt1.NID + "','" + Receipt1.nParentID + "','CD')");
                        }

                        spanValue.setAttribute("style", "padding:6px 6px;");
                        spanValue.setAttribute("class", "editDeleteButton");
                //spanValue.setAttribute("title", "Delete");
                        spanValue.appendChild(spanValue1);
                        cell.appendChild(spanValue);

                    }

    row.appendChild(cell);
}
        tbo.appendChild(row);
    });

    tab.appendChild(tbo);
    root.appendChild(tab);

    //if (Type == "CashListGrid" || Type == "C") {
    //    var nDeposit = nStaffWiseRs;
    //    var nDiffRate = $('#txtnDiffRate_' + $('#<%=HFCurrentRow.ClientID %>').val() + '').val();
    //    //$('.modal').not('#staffModal').modal('hide');
    //    //alert("Cash");
    //    $('#txtnDepositRate_' + $('#<%=HFCurrentRow.ClientID %>').val() + '').val(parseFloat(nDeposit).toFixed(2));
    //    $('#txtnDiffAmt_' + $('#<%=HFCurrentRow.ClientID %>').val() + '').val(parseFloat(nDiffRate) - parseFloat(nDeposit));
    //    //$('#CashList').modal('show');
    //}
    //else {
    //    $('#CashList').modal('hide');
    //}

    GetDepositRs();

}

function BindCashTableTotal(Receipt, Type) {
    var root;
    var nStaffWiseRs = 0;
    if (Type == "CashListGridTotal") {
        root = document.getElementById('MyDivCashTotal');
    }
    else {
        root = document.getElementById('myDivCashDeposit');
    }

    try {
        var tblId;
        if (Type == "CashListGridTotal") {
            tblId = document.getElementById('example8');
        }
        else {
            tblId = document.getElementById('example9');
        }

        if (tblId != null) {
            root.removeChild(tblId);
        }
    }
    catch (e) {

    }
    var tab = document.createElement('table');

    if (Type == "CashListGridTotal") {
        tab.setAttribute("id", "example8");
    }
    else {
        tab.setAttribute("id", "example9");
    }

    //tab.setAttribute("id", "example");
    tab.setAttribute("class", "table table-responsive table-bordered table-hover");
    tab.setAttribute("cellspacing", "0.5px");

    var tbo = document.createElement('thead');
    var row, cell;

    var Title1 = document.createElement('Label');
    var Title2 = document.createElement('Label');
    var Title3 = document.createElement('Label');
    var Title4 = document.createElement('Label');
    var Title5 = document.createElement('Label');
    var Title6 = document.createElement('Label');
    var Title7 = document.createElement('Label');
    var Title8 = document.createElement('Label');
    var Title9 = document.createElement('Label');
    var Title10 = document.createElement('Label');
    var Title11 = document.createElement('Label');
    var Title12 = document.createElement('Label');
    var Title13 = document.createElement('Label');
    var Title14 = document.createElement('Label');
    var Title15 = document.createElement('Label');
    var Title16 = document.createElement('Label');



    Title1.innerHTML = "NID";
    if (Type == "CashListGridTotal" || Type == 'C' || Type == 'Cash') {
        Title2.innerHTML = "Station Name";
    }
    else {
        Title2.innerHTML = "Bank Name";
    }

    Title3.innerHTML = "2000";
    Title4.innerHTML = "1000";
    Title5.innerHTML = "500";
    Title6.innerHTML = "100";
    Title7.innerHTML = "50";
    Title8.innerHTML = "20";
    Title9.innerHTML = "10";
    Title10.innerHTML = "5";
    Title11.innerHTML = "2";
    Title12.innerHTML = "1";
    Title13.innerHTML = "Coins/Rs.";
    Title14.innerHTML = "Total Notes";
    Title15.innerHTML = "Total Rs";


    row = document.createElement('tr');

    //row.setAttribute("bgcolor", "#2A3F54");
    row.setAttribute("style", "background-color:#2A3F54;color:#FFF");

    cell = document.createElement('th');
    cell.appendChild(Title2);

    if (Type == "CashListGridTotal" || Type == 'C' || Type == 'Cash') {
        cell.setAttribute("style", "color:#FFF");
    }
    else {
        cell.setAttribute("style", "color:#FFF");
    }
    row.appendChild(cell);

    cell = document.createElement('th');
    cell.appendChild(Title3);
    cell.setAttribute("style", "width:50px;padding-left:5px;color:#FFF");
    row.appendChild(cell);


    cell = document.createElement('th');
    cell.appendChild(Title5);
    cell.setAttribute("style", "width:50px;padding-left:5px;color:#FFF");
    row.appendChild(cell);

    cell = document.createElement('th');
    cell.appendChild(Title6);
    cell.setAttribute("style", "width:50px;padding-left:5px;color:#FFF");
    row.appendChild(cell);

    cell = document.createElement('th');
    cell.appendChild(Title7);
    cell.setAttribute("style", "width:48px;padding-left:5px;color:#FFF");
    row.appendChild(cell);

    cell = document.createElement('th');
    cell.appendChild(Title8);
    cell.setAttribute("style", "width:48px;padding-left:5px;color:#FFF");
    row.appendChild(cell);

    cell = document.createElement('th');
    cell.appendChild(Title9);
    cell.setAttribute("style", "width:48px;padding-left:5px;color:#FFF");
    row.appendChild(cell);


    cell = document.createElement('th');
    cell.appendChild(Title13);
    cell.setAttribute("style", "width:110px;padding-left:5px;color:#FFF");
    cell.setAttribute("style", "color:#FFF;width:80px;");
    row.appendChild(cell);

    cell = document.createElement('th');
    cell.appendChild(Title14);
    cell.setAttribute("style", "width:110px;padding-left:5px;color:#FFF");

    row.appendChild(cell);

    cell = document.createElement('th');
    cell.appendChild(Title15);
    cell.setAttribute("style", "width:85px;padding-left:5px;color:#FFF");
    row.appendChild(cell);


    tbo.appendChild(row);
    tab.appendChild(tbo);
    root.appendChild(tab);

    var tbo = document.createElement('tbody');
    $.each(Receipt, function (index, Receipt1) {

        row = document.createElement('tr');
        row.setAttribute("class", "even pointer");

        //
        // the object of LIST is now extract the each cell of row
        //

        for (var j = 1; j < 11; j++) {

            cell = document.createElement('td');
            cell.setAttribute("class", " ");
            //cell.setAttribute("width", "100px");


            var nNotes2000 = Receipt1.nNotes2000;
            var nNotes1000 = Receipt1.nNotes1000;
            var nNotes500 = Receipt1.nNotes500;
            var nNotes100 = Receipt1.nNotes100;
            var nNotes50 = Receipt1.nNotes50;
            var nNotes20 = Receipt1.nNotes20;
            var nNotes10 = Receipt1.nNotes10;
            var nNotes5 = Receipt1.nNotes5;
            var nNotes2 = Receipt1.nNotes2;
            var nNotes1 = Receipt1.nNotes1;
            var nTotalNotes = Receipt1.nTotalNotes;
            var nTotalRs = Receipt1.nTotalRs;
            var cNotes = Receipt1.cName;
            var cCurrentTime = Receipt1.cCurrentTime;
            var nBankID = Receipt1.nBankID;
            var cBankName = Receipt1.cBankName;
            var cCMSSlipNo = Receipt1.cCMSSlipNo;
            var cHCINNo = Receipt1.cHCINNo;
            var cDepositerName = Receipt1.cDepositerName;
            var nCoins = Receipt1.nCoins;

            if (j == 0) {
                //Create an input type dynamically.
                var hiddenId = document.createElement("input");
                //Assign different attributes to the element.
                hiddenId.setAttribute("type", "hidden");
                hiddenId.setAttribute("id", "hfRow_" + Receipt1.NID);
                hiddenId.setAttribute("value", Receipt1.NID);
                cell.appendChild(hiddenId);
            }

            else if (j == 1) {
                var spanValue = document.createElement("span");

                if (Type == "CashListGridTotal" || Type == 'C' || Type == 'Cash') {
                    spanValue.appendChild(document.createTextNode(cNotes));
                }
                else {
                    spanValue.appendChild(document.createTextNode(cBankName + ' (' + cCurrentTime + ')'));
                }

                cell.appendChild(spanValue);
            }

            else if (j == 2) {
                var spanValue = document.createElement("span");
                cell.setAttribute("style", "padding-right:5px;text-align:right;");
                spanValue.appendChild(document.createTextNode(nNotes2000));
                cell.appendChild(spanValue);
            }


            else if (j == 3) {
                var spanValue = document.createElement("span");
                cell.setAttribute("style", "padding-right:5px;text-align:right;");
                spanValue.appendChild(document.createTextNode(nNotes500));
                cell.appendChild(spanValue);
            }

            else if (j == 4) {
                var spanValue = document.createElement("span");
                cell.setAttribute("style", "padding-right:5px;text-align:right;");
                spanValue.appendChild(document.createTextNode(nNotes100));
                cell.appendChild(spanValue);
            }

            else if (j == 5) {
                var spanValue = document.createElement("span");
                cell.setAttribute("style", "padding-right:5px;text-align:right;");
                spanValue.appendChild(document.createTextNode(nNotes50));
                cell.appendChild(spanValue);
            }

            else if (j == 6) {
                var spanValue = document.createElement("span");
                cell.setAttribute("style", "padding-right:5px;text-align:right;");
                spanValue.appendChild(document.createTextNode(nNotes20));
                cell.appendChild(spanValue);
            }

            else if (j == 7) {
                var spanValue = document.createElement("span");
                cell.setAttribute("style", "padding-right:5px;text-align:right;");
                spanValue.appendChild(document.createTextNode(nNotes10));
                cell.appendChild(spanValue);
            }

            else if (j == 8) {
                var spanValue = document.createElement("span");
                cell.setAttribute("style", "padding-right:5px;text-align:right;");
                spanValue.appendChild(document.createTextNode(nCoins));
                cell.appendChild(spanValue);
            }


            else if (j == 9) {
                var spanValue = document.createElement("span");
                cell.setAttribute("style", "padding-right:5px;text-align:right;");
                spanValue.appendChild(document.createTextNode(nTotalNotes));
                cell.appendChild(spanValue);
            }

            else if (j == 10) {
                nStaffWiseRs = parseFloat(nStaffWiseRs) + parseFloat(nTotalRs);
                var spanValue = document.createElement("span");
                cell.setAttribute("style", "padding-right:5px;text-align:right;");
                spanValue.appendChild(document.createTextNode(nTotalRs));
                cell.appendChild(spanValue);

            }




            row.appendChild(cell);
        }
        tbo.appendChild(row);
    });

    tab.appendChild(tbo);
    root.appendChild(tab);



}

function EditCash(NID, nNotes2000, nNotes1000, nNotes500, nNotes100, nNotes50, nNotes20, nNotes10, nNotes5, nNotes2, nNotes1, nTotalNotes, nTotalRs, Type, nBankID, cBankName, cCurrentTime, cCMSSlipNo, cHCINNo, cDepositerName, nCoins) {
    var nNotes2000C;
    var nNotes1000C;
    var nNotes500C;
    var nNotes100C;
    var nNotes50C;
    var nNotes20C;
    var nNotes10C;
    var nNotes5C;
    var nNotes2C;
    var nNotes1C;
    var nNotes2000TotalC;
    var nNotes1000TotalC;
    var nNotes500TotalC;
    var nNotes100TotalC;
    var nNotes50TotalC;
    var nNotes20TotalC;
    var nNotes10TotalC;
    var nNotes5TotalC;
    var nNotes2TotalC;
    var nNotes1TotalC;
    var nTotalNotesC;
    var nTotalRsC;
    var nCashIDC;
    var nBankIDC;
    var cCurrentTimeC;
    var cBankNameC;
    var cCMSSlipNoC;
    var cHCINNoC;
    var cDepositerNameC;
    var nCoinsC;

    if (Type == "CashListGrid" || Type == "C" || Type == "Cash") {
        $('#cCashTab').click();
        nNotes2000C = $('#txtnRs2000');
        nNotes1000C = $('#txtnRs1000');
        nNotes500C = $('#txtnRs500');
        nNotes100C = $('#txtnRs100');
        nNotes50C = $('#txtnRs50');
        nNotes20C = $('#txtnRs20');
        nNotes10C = $('#txtnRs10');
        nNotes5C = $('#txtnRs5');
        nNotes2C = $('#txtnRs2');
        nNotes1C = $('#txtnRs1');
        nNotes2000TotalC = $('#txtnRs2000Total');
        nNotes1000TotalC = $('#txtnRs1000Total');
        nNotes500TotalC = $('#txtnRs500Total');
        nNotes100TotalC = $('#txtnRs100Total');
        nNotes50TotalC = $('#txtnRs50Total');
        nNotes20TotalC = $('#txtnRs20Total');
        nNotes10TotalC = $('#txtnRs10Total');
        nNotes5TotalC = $('#txtnRs5Total');
        nNotes2TotalC = $('#txtnRs2Total');
        nNotes1TotalC = $('#txtnRs1Total');
        nTotalNotesC = $('#spanTotalNotes');
        nTotalRsC = $('#spanTotalRs');
        nCashIDC = $('#<%=HFCashID.ClientID %>');
                nCoinsC = $('#txtnCoinsRsTotal');
                $('#CashList').modal('hide');
                nNotes2000C.focus();
            }
            else {
                nNotes2000C = $('#txtnDRs2000');
                nNotes1000C = $('#txtnDRs1000');
                nNotes500C = $('#txtnDRs500');
                nNotes100C = $('#txtnDRs100');
                nNotes50C = $('#txtnDRs50');
                nNotes20C = $('#txtnDRs20');
                nNotes10C = $('#txtnDRs10');
                nNotes5C = $('#txtnDRs5');
                nNotes2C = $('#txtnDRs2');
                nNotes1C = $('#txtnDRs1');
                nNotes2000TotalC = $('#txtnDRs2000Total');
                nNotes1000TotalC = $('#txtnDRs1000Total');
                nNotes500TotalC = $('#txtnDRs500Total');
                nNotes100TotalC = $('#txtnDRs100Total');
                nNotes50TotalC = $('#txtnDRs50Total');
                nNotes20TotalC = $('#txtnDRs20Total');
                nNotes10TotalC = $('#txtnDRs10Total');
                nNotes5TotalC = $('#txtnDRs5Total');
                nNotes2TotalC = $('#txtnDRs2Total');
                nNotes1TotalC = $('#txtnDRs1Total');
                nTotalNotesC = $('#spanDTotalNotes');
                nBankIDC = DXcBankD;
                cCurrentTimeC = $('#txtdCurrentTime');
                nTotalRsC = $('#spanDTotalRs');
                nCashIDC = $('#<%=HFCashDepositID.ClientID %>');
                cCMSSlipNoC = $('#txtcCMSSlipNo');
                cHCINNoC = $('#txtcHCINNo');
                cDepositerNameC = $('#txtcDepositerName');
                nCoinsC = $('#txtnCoinsRsDTotal');

                nBankIDC.SetValue(nBankID);
                cCurrentTimeC.val(cCurrentTime);
                cCMSSlipNoC.val(cCMSSlipNo);
                cHCINNoC.val(cHCINNo);
                cDepositerNameC.val(cDepositerName);
                DXcBankD.Focus();
            }

            nCashIDC.val(NID);
            nNotes2000C.val(nNotes2000);
            nNotes1000C.val(nNotes1000);
            nNotes500C.val(nNotes500);
            nNotes100C.val(nNotes100);
            nNotes50C.val(nNotes50);
            nNotes20C.val(nNotes20);
            nNotes10C.val(nNotes10);
            nNotes5C.val(nNotes5);
            nNotes2C.val(nNotes2);
            nNotes1C.val(nNotes1);
            nNotes2000TotalC.val(parseFloat(nNotes2000) * 2000);
            nNotes1000TotalC.val(parseFloat(nNotes1000) * 1000);
            nNotes500TotalC.val(parseFloat(nNotes500) * 500);
            nNotes100TotalC.val(parseFloat(nNotes100) * 100);
            nNotes50TotalC.val(parseFloat(nNotes50) * 50);
            nNotes20TotalC.val(parseFloat(nNotes20) * 20);
            nNotes10TotalC.val(parseFloat(nNotes10) * 10);
            nNotes5TotalC.val(parseFloat(nNotes5) * 5);
            nNotes2TotalC.val(parseFloat(nNotes2) * 2);
            nNotes1TotalC.val(parseFloat(nNotes1) * 1);
            nTotalNotesC.text(nTotalNotes);
            nTotalRsC.text(nTotalRs);
            nCoinsC.val(nCoins);
        }

        function DeleteCash(NID, nParentID, Type) {

            var nBankIDD = DXcBankD;
            var cCurrentTime = $('#txtdCurrentTime');
            var cCMSSlipNo = $('#txtcCMSSlipNo');
            var cHCINNo = $('#txtcHCINNo');
            var cDepositerName = $('#txtcDepositerName');
            var nCoins = $('#txtnCoinsRsTotal');
            var Query = 'D';
            swal({
                title: "Are you sure?",
                text: "Do you really want to delete?",
                type: "warning",
                showCancelButton: !0,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "Yes, delete it!",
                closeOnConfirm: !1
            }, function (isConfirm) {
                !isConfirm ? false :

                URL = "TranCRUD.asmx/AddUpdateDeleteTblTranDailySalesChildCash";
                DATA = "{'Query':'" + Query + "','NID':'" + NID + "','nParentID':'" + nParentID + "','nNotes2000':'', 'nNotes1000':'', 'nNotes500':'', 'nNotes100':'', 'nNotes50':'', 'nNotes20':'', 'nNotes10':'', 'nNotes5':'', 'nNotes2':'', 'nNotes1':'', 'nTotalNotes':'', 'nTotalRs':'','cType':'" + Type + "','nBankID':'" + nBankIDD.GetValue() + "','cCurrentTime':'" + cCurrentTime.val() + "','cCMSSlipNo':'" + cCMSSlipNo.val() + "','cHCINNo':'" + cHCINNo.val() + "','cDepositerName':'" + cDepositerName.val() + "','nCoins':'" + ConvertToNum(nCoins.val()) + "'}";
                if (Type == "CashListGrid" || Type == 'C' || Type == 'Cash') {
                    $('#<%=HFCurrentType.ClientID %>').val('Cash');
                    makeAjaxCall('CashDelete', true);
                    clearCash();
                }
                else {
                    $('#<%=HFCurrentType.ClientID %>').val('CashDeposit');
                    makeAjaxCall('CashDepositDelete', true);
                    clearCashDeposit();
                    $('#CashList').modal('hide');
                }
            });
        }

        function BindCreditCardTable(Receipt, Type) {
            var root = document.getElementById('myDivCreditCard');
            var cType = '';
            try {
                var tblId = document.getElementById('example1');
                if (tblId != null) {
                    root.removeChild(tblId);
                }
            }
            catch (e) {

            }

            if (Type == "CreditCardListGrid") {
                cType = '0';
            }
            else {
                cType = '1';
            }

            var tab = document.createElement('table');
            tab.setAttribute("id", "example1");
            tab.setAttribute("class", "table table-responsive table-bordered table-hover");
            tab.setAttribute("cellspacing", "1px");

            var tbo = document.createElement('thead');
            var row, cell;

            var Title1 = document.createElement('Label');
            var Title2 = document.createElement('Label');
            var Title3 = document.createElement('Label');
            var Title4 = document.createElement('Label');

            Title1.innerHTML = "NID";
            Title2.innerHTML = "Bank Name";
            //Title3.innerHTML = "Card No";
            Title4.innerHTML = "Rs";

            row = document.createElement('tr');

            //row.setAttribute("bgcolor", "#2A3F54");
            row.setAttribute("style", "background-color:#2A3F54;color:#FFF");

            cell = document.createElement('th');
            cell.appendChild(Title2);
            cell.setAttribute("style", "color:#FFF");
            row.appendChild(cell);

            //cell = document.createElement('th');
            //cell.appendChild(Title3);
            //cell.setAttribute("style", "width:120px;padding-left:5px;color:#FFF");
            //row.appendChild(cell);

            cell = document.createElement('th');
            cell.appendChild(Title4);
            cell.setAttribute("style", "width:100px;padding-left:5px;color:#FFF");
            row.appendChild(cell);


            cell = document.createElement('th');
            cell.setAttribute("style", "width:90px;padding-left:5px;color:#FFF");
            row.appendChild(cell);

            tbo.appendChild(row);
            tab.appendChild(tbo);
            root.appendChild(tab);

            var tbo = document.createElement('tbody');
            $.each(Receipt, function (index, Receipt1) {

                row = document.createElement('tr');
                row.setAttribute("class", "even pointer");

                //
                // the object of LIST is now extract the each cell of row
                //

                for (var j = 1; j < 4; j++) {

                    cell = document.createElement('td');
                    cell.setAttribute("class", " ");
                    //cell.setAttribute("width", "100px");

                    var cBankName = Receipt1.cBankName;
                    var nBankID = Receipt1.nBankID;
                    //var cCardNo = Receipt1.cCardNo;
                    var nRs = Receipt1.nRs;

                    if (j == 0) {
                        //Create an input type dynamically.
                        var hiddenId = document.createElement("input");
                        //Assign different attributes to the element.
                        hiddenId.setAttribute("type", "hidden");
                        hiddenId.setAttribute("id", "hfRow_" + Receipt1.NID);
                        hiddenId.setAttribute("value", Receipt1.NID);
                        cell.appendChild(hiddenId);
                    }

                    else if (j == 1) {
                        var spanValue = document.createElement("span");
                        //cell.setAttribute("style", "padding-right:5px;text-align:right;");
                        spanValue.appendChild(document.createTextNode(cBankName));
                        cell.appendChild(spanValue);
                    }

                        //else if (j == 2) {
                        //    var spanValue = document.createElement("span");
                        //    //cell.setAttribute("style", "padding-right:5px;text-align:right;");
                        //    cell.setAttribute("style", "padding-left:5px;");
                        //    spanValue.appendChild(document.createTextNode(cCardNo));
                        //    cell.appendChild(spanValue);
                        //}

                    else if (j == 2) {
                        var spanValue = document.createElement("span");
                        cell.setAttribute("style", "padding-right:5px;text-align:right;");
                        spanValue.appendChild(document.createTextNode(nRs));
                        cell.appendChild(spanValue);
                    }

                    else if (j == 3) {
                        var spanValue = document.createElement("a");
                        var spanValue1 = document.createElement("i");
                        spanValue1.setAttribute("class", "icon wb-edit");
                        spanValue.setAttribute("onclick", "EditCreditCard('" + Receipt1.NID + "','" + cBankName + "','" + nBankID + "','','" + nRs + "','" + cType + "')");
                        spanValue.setAttribute("class", "editDeleteButton");
                        spanValue.setAttribute("style", "padding:6px 6px;");
                        //cell.setAttribute("min-width", "100px");
                        //cell.setAttribute("width", "100px");
                        //spanValue.setAttribute("title", "Edit");
                        spanValue.appendChild(spanValue1);
                        cell.appendChild(spanValue);

                        var spanValue = document.createElement("a");
                        var spanValue1 = document.createElement("i");
                        spanValue1.setAttribute("class", "icon wb-trash");
                        spanValue.setAttribute("onclick", "DeleteCreditCard('" + Receipt1.NID + "','" + Receipt1.nParentID + "','" + cType + "')");
                        spanValue.setAttribute("style", "padding:6px 6px;");
                        spanValue.setAttribute("class", "editDeleteButton");
                        //spanValue.setAttribute("title", "Delete");
                        spanValue.appendChild(spanValue1);
                        cell.appendChild(spanValue);

                    }

                    row.appendChild(cell);
                }
                tbo.appendChild(row);
            });

            tab.appendChild(tbo);
            root.appendChild(tab);

            //$('.modal').not('#staffModal').modal('hide');
            //alert("CreditCard");
            GetDepositRs();
            $('#CreditCardList').modal('show');
        }

        function BindCreditCardTableTotal(Receipt, Type) {
            var root = document.getElementById('myDivCreditCardTotal');
            var cType = '';
            try {
                var tblId = document.getElementById('example10');
                if (tblId != null) {
                    root.removeChild(tblId);
                }
            }
            catch (e) {

            }

            if (Type == "CreditCardListGridTotal") {
                cType = '0';
            }
            else {
                cType = '1';
            }

            var tab = document.createElement('table');
            tab.setAttribute("id", "example10");
            tab.setAttribute("class", "table table-responsive table-bordered table-hover");
            tab.setAttribute("cellspacing", "1px");

            var tbo = document.createElement('thead');
            var row, cell;

            var Title1 = document.createElement('Label');
            var Title2 = document.createElement('Label');
            var Title3 = document.createElement('Label');
            var Title4 = document.createElement('Label');

            Title1.innerHTML = "NID";
            Title2.innerHTML = "Station Name";
            //Title3.innerHTML = "Card No";
            Title4.innerHTML = "Rs";

            row = document.createElement('tr');

            //row.setAttribute("bgcolor", "#2A3F54");
            row.setAttribute("style", "background-color:#2A3F54;color:#FFF");

            cell = document.createElement('th');
            cell.appendChild(Title2);
            cell.setAttribute("style", "color:#FFF");
            row.appendChild(cell);

            //cell = document.createElement('th');
            //cell.appendChild(Title3);
            //cell.setAttribute("style", "width:120px;padding-left:5px;color:#FFF");
            //row.appendChild(cell);

            cell = document.createElement('th');
            cell.appendChild(Title4);
            cell.setAttribute("style", "width:100px;padding-left:5px;color:#FFF");
            row.appendChild(cell);


            //cell = document.createElement('th');
            //cell.setAttribute("style", "width:90px;padding-left:5px;color:#FFF");
            //row.appendChild(cell);

            tbo.appendChild(row);
            tab.appendChild(tbo);
            root.appendChild(tab);

            var tbo = document.createElement('tbody');
            $.each(Receipt, function (index, Receipt1) {

                row = document.createElement('tr');
                row.setAttribute("class", "even pointer");

                //
                // the object of LIST is now extract the each cell of row
                //

                for (var j = 1; j < 3; j++) {

                    cell = document.createElement('td');
                    cell.setAttribute("class", " ");
                    //cell.setAttribute("width", "100px");

                    //var cBankName = Receipt1.cBankName;
                    //var nBankID = Receipt1.nBankID;
                    //var cCardNo = Receipt1.cCardNo;

                    var cName = Receipt1.cName;
                    var nRs = Receipt1.nRs;

                    if (j == 0) {
                        ////Create an input type dynamically.
                        //var hiddenId = document.createElement("input");
                        ////Assign different attributes to the element.
                        //hiddenId.setAttribute("type", "hidden");
                        //hiddenId.setAttribute("id", "hfRow_" + Receipt1.NID);
                        //hiddenId.setAttribute("value", Receipt1.NID);
                        //cell.appendChild(hiddenId);
                    }

                    else if (j == 1) {
                        var spanValue = document.createElement("span");
                        //cell.setAttribute("style", "padding-right:5px;text-align:right;");
                        spanValue.appendChild(document.createTextNode(cName));
                        cell.appendChild(spanValue);
                    }

                    else if (j == 2) {
                        var spanValue = document.createElement("span");
                        cell.setAttribute("style", "padding-right:5px;text-align:right;");
                        spanValue.appendChild(document.createTextNode(nRs));
                        cell.appendChild(spanValue);
                    }


                    row.appendChild(cell);
                }
                tbo.appendChild(row);
            });

            tab.appendChild(tbo);
            root.appendChild(tab);
        }

        function EditCreditCard(NID, cBankName, nBankID, cCardNo, nRs, cType) {
            if (cType == '0') {
                $('#cCreditCardTab').click();
            }
            else {
                $('#cPaytmTab').click();
            }

            var nCreditCardID = $('#<%=HFCreditCardID.ClientID %>');
            var nBankIDC = DXcBank;
            //var cCardNoC = $('#TxtcCreditCardNo');
            var nRsC = $('#TxtnCreditCardRs');

            nCreditCardID.val(NID);
            nBankIDC.SetValue(nBankID);
            //nBankIDC.SetText(cBankName);
            //alert(nBankIDC.GetValue());
            //cCardNoC.val(cCardNo);
            nRsC.val(nRs);
            $('#CreditCardList').modal('hide');
            nBankIDC.Focus();
        }

        function DeleteCreditCard(NID, nParentID, cType) {
            //debugger;
            var Query = 'D';

            swal({
                title: "Are you sure?",
                text: "Do you really want to delete?",
                type: "warning",
                showCancelButton: !0,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "Yes, delete it!",
                closeOnConfirm: !1
            }, function (isConfirm) {
                !isConfirm ? false :

                $('#<%=HFCurrentType.ClientID %>').val('CreditCard');
        URL = "TranCRUD.asmx/AddUpdateDeleteTblTranDailySalesChildCreditCard";
        DATA = "{'Query':'" + Query + "','NID':'" + NID + "','nParentID':'" + nParentID + "','nBankID':'', 'cCardNo':'', 'nRs':'','cType':'" + cType + "'}";

        if (cType == '0') {
            makeAjaxCall('CreditCardDelete', true);
            clearCreditCard(1);
        }
        else {
            makeAjaxCall('PaytmDelete', true);
            clearCreditCard(2);
        }

        //clearCreditCard();

    });
}

function BindCreditSalesTable(Receipt, Type) {
    var root = document.getElementById('myDivCreditSales');
    var cType = '';

    if (Type == "CreditSalesListGrid") {
        cType = '0';
    }
    else {
        cType = '1';
    }

    try {
        var tblId = document.getElementById('example2');
        if (tblId != null) {
            root.removeChild(tblId);
        }
    }
    catch (e) {

    }
    var tab = document.createElement('table');
    tab.setAttribute("id", "example2");
    tab.setAttribute("class", "table table-responsive table-bordered table-hover");
    tab.setAttribute("cellspacing", "1px");

    var tbo = document.createElement('thead');
    var row, cell;

    var Title1 = document.createElement('Label');
    var Title2 = document.createElement('Label');
    var Title3 = document.createElement('Label');
    var Title4 = document.createElement('Label');
    var Title5 = document.createElement('Label');

    Title1.innerHTML = "NID";
    Title2.innerHTML = "Customer Name";
    Title3.innerHTML = "Vehicle No";
    Title4.innerHTML = "Rs";
    Title5.innerHTML = "Qty (KG)";

    row = document.createElement('tr');

    //row.setAttribute("bgcolor", "#2A3F54");
    row.setAttribute("style", "background-color:#2A3F54;color:#FFF");

    cell = document.createElement('th');
    cell.appendChild(Title2);
    cell.setAttribute("style", "color:#FFF");
    row.appendChild(cell);

    cell = document.createElement('th');
    cell.appendChild(Title3);
    cell.setAttribute("style", "width:120px;padding-left:5px;color:#FFF");
    row.appendChild(cell);

    cell = document.createElement('th');
    cell.appendChild(Title4);
    cell.setAttribute("style", "width:100px;padding-left:5px;color:#FFF");
    row.appendChild(cell);

    cell = document.createElement('th');
    cell.appendChild(Title5);
    cell.setAttribute("style", "width:100px;padding-left:5px;color:#FFF");
    row.appendChild(cell);


    cell = document.createElement('th');
    cell.setAttribute("style", "width:90px;padding-left:5px;color:#FFF");
    row.appendChild(cell);

    tbo.appendChild(row);
    tab.appendChild(tbo);
    root.appendChild(tab);

    var tbo = document.createElement('tbody');
    $.each(Receipt, function (index, Receipt1) {

        row = document.createElement('tr');
        row.setAttribute("class", "even pointer");

        //
        // the object of LIST is now extract the each cell of row
        //

        for (var j = 1; j < 6; j++) {

            cell = document.createElement('td');
            cell.setAttribute("class", " ");
            //cell.setAttribute("width", "100px");

            var cCustomerName = Receipt1.cCustomerName;
            var nCustomerID = Receipt1.nCustomerID;
            var cVehicleNo = Receipt1.cVehicleNo;
            var nRs = Receipt1.nRs;
            var nQty = Receipt1.nQty;
            var cNarration = Receipt1.cNarration;

            if (j == 0) {
                //Create an input type dynamically.
                var hiddenId = document.createElement("input");
                //Assign different attributes to the element.
                hiddenId.setAttribute("type", "hidden");
                hiddenId.setAttribute("id", "hfRow_" + Receipt1.NID);
                hiddenId.setAttribute("value", Receipt1.NID);
                cell.appendChild(hiddenId);
            }

            else if (j == 1) {
                var spanValue = document.createElement("span");
                //cell.setAttribute("style", "padding-right:5px;text-align:right;");
                spanValue.appendChild(document.createTextNode(cCustomerName));
                cell.appendChild(spanValue);
            }

            else if (j == 2) {
                var spanValue = document.createElement("span");
                cell.setAttribute("style", "padding-left:5px;");
                spanValue.appendChild(document.createTextNode(cVehicleNo));
                cell.appendChild(spanValue);
            }

            else if (j == 3) {
                var spanValue = document.createElement("span");
                cell.setAttribute("style", "padding-right:5px;text-align:right;");
                spanValue.appendChild(document.createTextNode(nRs));
                cell.appendChild(spanValue);
            }

            else if (j == 4) {
                var spanValue = document.createElement("span");
                cell.setAttribute("style", "padding-right:5px;text-align:right;");
                spanValue.appendChild(document.createTextNode(nQty));
                cell.appendChild(spanValue);
            }

            else if (j == 5) {
                var spanValue = document.createElement("a");
                var spanValue1 = document.createElement("i");
                spanValue1.setAttribute("class", "icon wb-edit");
                spanValue.setAttribute("onclick", "EditCreditSales('" + Receipt1.NID + "','" + cCustomerName + "','" + nCustomerID + "','" + cVehicleNo + "','" + nRs + "','" + nQty + "','" + cNarration + "','" + cType + "')");
                spanValue.setAttribute("class", "editDeleteButton");
                spanValue.setAttribute("style", "padding:6px 6px;");
                //cell.setAttribute("min-width", "100px");
                //cell.setAttribute("width", "100px");
                //spanValue.setAttribute("title", "Edit");
                spanValue.appendChild(spanValue1);
                cell.appendChild(spanValue);

                var spanValue = document.createElement("a");
                var spanValue1 = document.createElement("i");
                spanValue1.setAttribute("class", "icon wb-trash");
                spanValue.setAttribute("onclick", "DeleteCreditSales('" + Receipt1.NID + "','" + Receipt1.nParentID + "','" + cType + "')");
                spanValue.setAttribute("style", "padding:6px 6px;");
                spanValue.setAttribute("class", "editDeleteButton");
                //spanValue.setAttribute("title", "Delete");
                spanValue.appendChild(spanValue1);
                cell.appendChild(spanValue);

            }

            row.appendChild(cell);
        }
        tbo.appendChild(row);
    });

    tab.appendChild(tbo);
    root.appendChild(tab);

    //$('#CashList').modal('hide');
    //$('#CreditCardList').modal('hide');

    //$('.modal').not('#staffModal').modal('hide');
    //alert('Credit Sales');
    GetDepositRs();
    $('#CreditSalesList').modal('show');
}

function BindCreditSalesTableTotal(Receipt, Type) {
    var root = document.getElementById('myDivCreditSalesTotal');
    var cType = '';

    if (Type == "CreditSalesListGridTotal") {
        cType = '0';
    }
    else {
        cType = '1';
    }

    try {
        var tblId = document.getElementById('example20');
        if (tblId != null) {
            root.removeChild(tblId);
        }
    }
    catch (e) {

    }
    var tab = document.createElement('table');
    tab.setAttribute("id", "example20");
    tab.setAttribute("class", "table table-responsive table-bordered table-hover");
    tab.setAttribute("cellspacing", "1px");

    var tbo = document.createElement('thead');
    var row, cell;

    var Title1 = document.createElement('Label');
    var Title2 = document.createElement('Label');
    var Title3 = document.createElement('Label');
    var Title4 = document.createElement('Label');
    var Title5 = document.createElement('Label');

    Title1.innerHTML = "NID";
    Title2.innerHTML = "Station Name";
    Title3.innerHTML = "Vehicle No";
    Title4.innerHTML = "Rs";
    Title5.innerHTML = "Qty (KG)";

    row = document.createElement('tr');

    //row.setAttribute("bgcolor", "#2A3F54");
    row.setAttribute("style", "background-color:#2A3F54;color:#FFF");

    cell = document.createElement('th');
    cell.appendChild(Title2);
    cell.setAttribute("style", "color:#FFF");
    row.appendChild(cell);

    //cell = document.createElement('th');
    //cell.appendChild(Title3);
    //cell.setAttribute("style", "width:120px;padding-left:5px;color:#FFF");
    //row.appendChild(cell);

    cell = document.createElement('th');
    cell.appendChild(Title4);
    cell.setAttribute("style", "width:100px;padding-left:5px;color:#FFF");
    row.appendChild(cell);

    cell = document.createElement('th');
    cell.appendChild(Title5);
    cell.setAttribute("style", "width:100px;padding-left:5px;color:#FFF");
    row.appendChild(cell);


    tbo.appendChild(row);
    tab.appendChild(tbo);
    root.appendChild(tab);

    var tbo = document.createElement('tbody');
    $.each(Receipt, function (index, Receipt1) {

        row = document.createElement('tr');
        row.setAttribute("class", "even pointer");

        //
        // the object of LIST is now extract the each cell of row
        //

        for (var j = 1; j < 4; j++) {

            cell = document.createElement('td');
            cell.setAttribute("class", " ");
            //cell.setAttribute("width", "100px");

            //var cCustomerName = Receipt1.cCustomerName;
            //var nCustomerID = Receipt1.nCustomerID;
            //var cVehicleNo = Receipt1.cVehicleNo;
            //var nRs = Receipt1.nRs;
            //var nQty = Receipt1.nQty;
            //var cNarration = Receipt1.cNarration;

            var cName = Receipt1.cName;
            var nRs = Receipt1.nRs;
            var nQty = Receipt1.nQty;

            if (j == 0) {
                ////Create an input type dynamically.
                //var hiddenId = document.createElement("input");
                ////Assign different attributes to the element.
                //hiddenId.setAttribute("type", "hidden");
                //hiddenId.setAttribute("id", "hfRow_" + Receipt1.NID);
                //hiddenId.setAttribute("value", Receipt1.NID);
                //cell.appendChild(hiddenId);
            }

            else if (j == 1) {
                var spanValue = document.createElement("span");
                //cell.setAttribute("style", "padding-right:5px;text-align:right;");
                spanValue.appendChild(document.createTextNode(cName));
                cell.appendChild(spanValue);
            }

                //else if (j == 2) {
                //    var spanValue = document.createElement("span");
                //    cell.setAttribute("style", "padding-left:5px;");
                //    spanValue.appendChild(document.createTextNode(cVehicleNo));
                //    cell.appendChild(spanValue);
                //}

            else if (j == 2) {
                var spanValue = document.createElement("span");
                cell.setAttribute("style", "padding-right:5px;text-align:right;");
                spanValue.appendChild(document.createTextNode(nRs));
                cell.appendChild(spanValue);
            }

            else if (j == 3) {
                var spanValue = document.createElement("span");
                cell.setAttribute("style", "padding-right:5px;text-align:right;");
                spanValue.appendChild(document.createTextNode(nQty));
                cell.appendChild(spanValue);
            }

            row.appendChild(cell);
        }
        tbo.appendChild(row);
    });

    tab.appendChild(tbo);
    root.appendChild(tab);
}

function EditCreditSales(NID, cCustomerName, nCustomerID, cVehicleNo, nRs, nQty, cNarration, cType) {
    if (cType == '0') {
        $('#cCreditSalesTab').click();
    }
    else {
        $('#cAdaniSalesTab').click();
    }

    var nCreditSalesID = $('#<%=HFCreditSalesID.ClientID %>');
    var nCustomerIDC = DXcCustomer;
    var cVehicleNoC = $('#TxtcVehicleNo');
    var nCreditSaleRsC = $('#TxtnCreditSaleRs');
    var nCreditSaleQtyC = $('#TxtnCreditSaleQty');
    var cNarrationC = $('#TxtcNarration');

    nCreditSalesID.val(NID);
    nCustomerIDC.SetValue(nCustomerID);
    //nBankIDC.SetText(cBankName);
    //alert(nBankIDC.GetValue());
    cVehicleNoC.val(cVehicleNo);
    nCreditSaleRsC.val(nRs);
    nCreditSaleQtyC.val(nQty);
    cNarrationC.val(cNarration);


    $('#CreditSalesList').modal('hide');

    nCustomerIDC.Focus();
}

function DeleteCreditSales(NID, nParentID, Type) {
    var Query = 'D';
    swal({
        title: "Are you sure?",
        text: "Do you really want to delete?",
        type: "warning",
        showCancelButton: !0,
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "Yes, delete it!",
        closeOnConfirm: !1
    }, function (isConfirm) {
        !isConfirm ? false :

        $('#<%=HFCurrentType.ClientID %>').val('CreditSales');
        URL = "TranCRUD.asmx/AddUpdateDeleteTblTranDailySalesChildCreditSales";
        //, string nRs, string 
        DATA = "{'Query':'" + Query + "','NID':'" + NID + "','nParentID':'" + nParentID + "','nCustomerID':'', 'cVehicleNo':'', 'nRs':'','nRate':'','nQty':'','cNarration':'','cType':'" + Type + "'}";

        if (Type == '0') {
            makeAjaxCall('CreditSalesDelete', true);
        }
        else {
            makeAjaxCall('AdaniSalesDelete', true);
        }

        clearCreditSales();
    });
}


function clearCash() {
    var nNotes2000C = $('#txtnRs2000');
    var nNotes1000C = $('#txtnRs1000');
    var nNotes500C = $('#txtnRs500');
    var nNotes100C = $('#txtnRs100');
    var nNotes50C = $('#txtnRs50');
    var nNotes20C = $('#txtnRs20');
    var nNotes10C = $('#txtnRs10');
    var nNotes5C = $('#txtnRs5');
    var nNotes2C = $('#txtnRs2');
    var nNotes1C = $('#txtnRs1');
    var nNotes2000TotalC = $('#txtnRs2000Total');
    var nNotes1000TotalC = $('#txtnRs1000Total');
    var nNotes500TotalC = $('#txtnRs500Total');
    var nNotes100TotalC = $('#txtnRs100Total');
    var nNotes50TotalC = $('#txtnRs50Total');
    var nNotes20TotalC = $('#txtnRs20Total');
    var nNotes10TotalC = $('#txtnRs10Total');
    var nNotes5TotalC = $('#txtnRs5Total');
    var nNotes2TotalC = $('#txtnRs2Total');
    var nNotes1TotalC = $('#txtnRs1Total');
    var nTotalNotesC = $('#spanTotalNotes');
    var nTotalRsC = $('#spanTotalRs');
    var nCashIDC = $('#<%=HFCashID.ClientID %>');
            var nCoinsC = $('#txtnCoinsRsTotal');


            nNotes2000C.val('');
            nNotes1000C.val('');
            nNotes500C.val('');
            nNotes100C.val('');
            nNotes50C.val('');
            nNotes20C.val('');
            nNotes10C.val('');
            nNotes5C.val('');
            nNotes2C.val('');
            nNotes1C.val('');
            nNotes2000TotalC.val('');
            nNotes1000TotalC.val('');
            nNotes500TotalC.val('');
            nNotes100TotalC.val('');
            nNotes50TotalC.val('');
            nNotes20TotalC.val('');
            nNotes10TotalC.val('');
            nNotes5TotalC.val('');
            nNotes2TotalC.val('');
            nNotes1TotalC.val('');
            nTotalNotesC.text('');
            nTotalRsC.text('');
            nCashIDC.val('');
            nCoinsC.val('');

            //$('#CashList').modal('hide');
        }

        function clearCashDeposit(BankType) {
            //            var nNotes2000C = $('#txtnDRs2000');
            //            var nNotes1000C = $('#txtnDRs1000');
            //            var nNotes500C = $('#txtnDRs500');
            //            var nNotes100C = $('#txtnDRs100');
            //            var nNotes50C = $('#txtnDRs50');
            //            var nNotes20C = $('#txtnDRs20');
            //            var nNotes10C = $('#txtnDRs10');
            //            var nNotes5C = $('#txtnDRs5');
            //            var nNotes2C = $('#txtnDRs2');
            //            var nNotes1C = $('#txtnDRs1');
            //            var nNotes2000TotalC = $('#txtnDRs2000Total');
            //            var nNotes1000TotalC = $('#txtnDRs1000Total');
            //            var nNotes500TotalC = $('#txtnDRs500Total');
            //            var nNotes100TotalC = $('#txtnDRs100Total');
            //            var nNotes50TotalC = $('#txtnDRs50Total');
            //            var nNotes20TotalC = $('#txtnDRs20Total');
            //            var nNotes10TotalC = $('#txtnDRs10Total');
            //            var nNotes5TotalC = $('#txtnDRs5Total');
            //            var nNotes2TotalC = $('#txtnDRs2Total');
            //            var nNotes1TotalC = $('#txtnDRs1Total');
            //            var nTotalNotesC = $('#spanDTotalNotes');
            //            var nTotalRsC = $('#spanDTotalRs');
            //            var nCashIDC = $('#<%=HFCashDepositID.ClientID %>');


            //            nNotes2000C.val('');
            //            nNotes1000C.val('');
            //            nNotes500C.val('');
            //            nNotes100C.val('');
            //            nNotes50C.val('');
            //            nNotes20C.val('');
            //            nNotes10C.val('');
            //            nNotes5C.val('');
            //            nNotes2C.val('');
            //            nNotes1C.val('');
            //            nNotes2000TotalC.val('');
            //            nNotes1000TotalC.val('');
            //            nNotes500TotalC.val('');
            //            nNotes100TotalC.val('');
            //            nNotes50TotalC.val('');
            //            nNotes20TotalC.val('');
            //            nNotes10TotalC.val('');
            //            nNotes5TotalC.val('');
            //            nNotes2TotalC.val('');
            //            nNotes1TotalC.val('');
            //            nTotalNotesC.text('');
            //            nTotalRsC.text('');
            //            nCashIDC.val('');

            var currentTime = '';
            CurrentHour = moment().hour();
            CurrentMinute = moment().minutes();

            //if (CurrentHour >= 0 && CurrentHour <= 12) {
            //    if (CurrentHour == 12) {
            //        AMPM = "PM";
            //    }
            //    else {
            //        AMPM = "AM";
            //    }
            //}
            //else {
            //    AMPM = "PM";
            //    CurrentHour = CurrentHour - 12;
            //}

            //currentTime = CurrentHour + ':' + CurrentMinute + ' ' + AMPM + '';
            currentTime = CurrentHour + ':' + CurrentMinute + '';

            //DXcBankD.SetValue('');
            //DXcBankD.SetText('');
            $('#txtdCurrentTime').val(currentTime);
            $('#txtnDRs2000').val('');
            $('#txtnDRs1000').val('');
            $('#txtnDRs500').val('');
            $('#txtnDRs100').val('');
            $('#txtnDRs50').val('');
            $('#txtnDRs20').val('');
            $('#txtnDRs10').val('');
            $('#txtnDRs5').val('');
            $('#txtnDRs2').val('');
            $('#txtnDRs1').val('');
            $('#txtnDRs2000Total').val('');
            $('#txtnDRs1000Total').val('');
            $('#txtnDRs500Total').val('');
            $('#txtnDRs100Total').val('');
            $('#txtnDRs50Total').val('');
            $('#txtnDRs20Total').val('');
            $('#txtnDRs10Total').val('');
            $('#txtnDRs5Total').val('');
            $('#txtnDRs2Total').val('');
            $('#txtnDRs1Total').val('');
            $('#spanDTotalNotes').text('');
            $('#spanDTotalRs').text('');
            $('#<%=HFCashDepositID.ClientID %>').val('');
            $('#txtnCoinsRsDTotal').val('');
            var cCMSSlipNoC = $('#txtcCMSSlipNo');
            var cHCINNoC = $('#txtcHCINNo');
            var cDepositerNameC = $('#txtcDepositerName');
            cCMSSlipNoC.val('');
            cHCINNoC.val('');
            cDepositerNameC.val('');


            $.ajax({
                type: "POST",
                url: "TranCRUD.asmx/GetDefaultBankAccount",
                data: "{'BankType':'" + BankType + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    //alert(response.d.nBankID);
                    setTimeout(function () {
                        DXcBankD.SetValue(response.d.nBankID);
                        DXcBankD.SetText(response.d.cBankName);
                    }, 300);
                },
                error: function (response) {
                    alertify.alert(response.d.Msg);
                }
            });
            DXcBankD.Focus();
        }

        function clearCreditCard(BankType) {
            //            DXcBank.SetText('');
            //            DXcBank.SetValue('');
            $('#TxtcCreditCardNo').val('');
            $('#TxtnCreditCardRs').val('');
            $('#<%=HFCreditCardID.ClientID %>').val('');

            $.ajax({
                type: "POST",
                url: "TranCRUD.asmx/GetDefaultBankAccount",
                data: "{'BankType':'" + BankType + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    //alert(response.d.nBankID);
                    setTimeout(function () {
                        DXcBank.SetValue(response.d.nBankID);
                        DXcBank.SetText(response.d.cBankName);
                    }, 200);
                },
                error: function (response) {
                    alertify.alert(response.d.Msg);
                }
            });

            //$('#CreditCardList').modal('hide');
        }

        function clearCreditSales() {
            DXcCustomer.SetText('');
            DXcCustomer.SetValue('');
            $('#TxtcVehicleNo').val('');
            $('#TxtnCreditSaleRs').val('');
            $('#TxtnCreditSaleQty').val('');
            $('#TxtcNarration').val('');
            $('#<%=HFCreditSalesID.ClientID %>').val('');
            //$('#CreditSalesList').modal('hide');
            if ($('#<%=HFCurrentAspect.ClientID %>').val() == "AdaniSale") {
                $.ajax({
                    type: "POST",
                    url: "TranCRUD.asmx/GetDefaultAdaniSalesAccount",
                    data: "",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        //alert(response.d.nBankID);
                        setTimeout(function () {
                            DXcCustomer.SetValue(response.d.nBankID);
                            DXcCustomer.SetText(response.d.cBankName);
                        }, 300);
                    },
                    error: function (response) {
                        alertify.alert(response.d.Msg);
                    }
                });
            }

        }

        function CreditSalesRsChange(currObj) {
            var nRate = $('#<%=HFTodayRate.ClientID %>').val();
            var nRs = 0;
            var nQty = currObj.val();
            nRs = parseFloat(nQty) * parseFloat(nRate);
            $('#TxtnCreditSaleRs').val(nRs.toFixed(2));
        }

        function AddUpdateDeleteCashDeposit() {
            var nCashID = $('#<%=HFCashDepositID.ClientID %>');
            var nNotes2000 = $('#txtnDRs2000');
            var nNotes1000 = $('#txtnDRs1000');
            var nNotes500 = $('#txtnDRs500');
            var nNotes100 = $('#txtnDRs100');
            var nNotes50 = $('#txtnDRs50');
            var nNotes20 = $('#txtnDRs20');
            var nNotes10 = $('#txtnDRs10');
            var nNotes5 = $('#txtnDRs5');
            var nNotes2 = $('#txtnDRs2');
            var nNotes1 = $('#txtnDRs1');
            var nTotalNotes = $('#spanDTotalNotes');
            var nTotalRs = $('#spanDTotalRs');
            var CID = $('#<%=HFPID.ClientID %>');
            var nBankIDD = DXcBankD;
            var cCurrentTime = $('#txtdCurrentTime');
            var cCMSSlipNo = $('#txtcCMSSlipNo');
            var cHCINNo = $('#txtcHCINNo');
            var cDepositerName = $('#txtcDepositerName');
            var nCoins = $('#txtnCoinsRsDTotal');

            if (nBankIDD.GetValue() == null) {
                alertify.alert("Bank Name is Required!", function () {
                    nBankIDD.Focus();
                });
            }
            else {
                var tempFlag = false;
                $('.NoteNoD').each(function (e) {
                    if (parseFloat($(this).val()) > 0) {
                        tempFlag = true;
                        return false;
                    }
                });

                //alert(CID.val());
                if (tempFlag) {
                    if (nCashID.val() != '') {
                        Query = 'U';
                    }
                    else {
                        Query = 'I';
                    }

                    if ($('#<%=HFPID.ClientID %>').val() != '') {
                        URL = "TranCRUD.asmx/AddUpdateDeleteTblTranDailySalesChildCash";
                        DATA = "{'Query':'" + Query + "','NID':'" + nCashID.val() + "','nParentID':'" + CID.val() + "','nNotes2000':'" + ConvertToNum(nNotes2000.val()) + "', 'nNotes1000':'" + ConvertToNum(nNotes1000.val()) + "', 'nNotes500':'" + ConvertToNum(nNotes500.val()) + "', 'nNotes100':'" + ConvertToNum(nNotes100.val()) + "', 'nNotes50':'" + ConvertToNum(nNotes50.val()) + "', 'nNotes20':'" + ConvertToNum(nNotes20.val()) + "', 'nNotes10':'" + ConvertToNum(nNotes10.val()) + "', 'nNotes5':'" + ConvertToNum(nNotes5.val()) + "', 'nNotes2':'" + ConvertToNum(nNotes2.val()) + "', 'nNotes1':'" + ConvertToNum(nNotes1.val()) + "', 'nTotalNotes':'" + ConvertToNum(nTotalNotes.val()) + "', 'nTotalRs':'" + ConvertToNum(nTotalRs.val()) + "','cType':'CD','nBankID':'" + nBankIDD.GetValue() + "','cCurrentTime':'" + cCurrentTime.val() + "','cCMSSlipNo':'" + cCMSSlipNo.val() + "','cHCINNo':'" + cHCINNo.val() + "','cDepositerName':'" + cDepositerName.val() + "','nCoins':'" + ConvertToNum(nCoins.val()) + "'}";
                        makeAjaxCall('CashDeposit', true);
                        clearCashDeposit();
                    }
                    else {
                        Query = 'PICI';
                        var PID = $('#<%=HFPID.ClientID%>');
                        var dDate = $('#<%=TxtdDate.ClientID%>');
                        var nSrNo = $('#<%=TxtnTranNo.ClientID%>');
                        var nBranchID = $.cookie('CNGPumpBranchID');
                        var nCompID = $.cookie('CNGPumpCompID');
                        var cAccYear = $.cookie('CNGPumpAccYear');
                        var nInstID = $.cookie('CNGPumpLoginID');
                        $.ajax({
                            type: "POST",
                            url: "TranCRUD.asmx/AddUpdateDeleteTblTranDailySales",
                            data: "{'Query':'" + Query + "','PID':'" + PID.val() + "','dDate':'" + dDate.val() + "','nSrNo':'','nBranchID':'" + nBranchID + "','nCompID':'" + nCompID + "','cAccYear':'" + cAccYear + "','nInstID':'" + nInstID + "','nUpID':'" + nInstID + "','CID':'','nStationID':'','nStaffID':'','nShift':'','nOpening':'','nClosing':'','nDiff':'','nRate':'" + nRate.val() + "','nDiffRate':'" + ConvertToNum(nDiffRate.val()) + "','nDepositRs':'" + ConvertToNum(nDepositRs.val()) + "','nDiffAmt':'" + ConvertToNum(nDiffAmt.val()) + "','nJumpRate':'" + ConvertToNum(nJumpRate.val()) + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (response) {
                                PID.val(response.d[0].PID);

                                if (nCashID.val() != '') {
                                    Query = 'U';
                                }
                                else {
                                    Query = 'I';
                                }

                                $('#<%=TxtnRate.ClientID %>').val(response.d.nSaleRate);
                                $('#<%=HFTodayRate.ClientID %>').val(response.d.nSaleRate);
                                URL = "TranCRUD.asmx/AddUpdateDeleteTblTranDailySalesChildCash";
                                DATA = "{'Query':'" + Query + "','NID':'" + nCashID.val() + "','nParentID':'" + PID.val() + "','nNotes2000':'" + ConvertToNum(nNotes2000.val()) + "', 'nNotes1000':'" + ConvertToNum(nNotes1000.val()) + "', 'nNotes500':'" + ConvertToNum(nNotes500.val()) + "', 'nNotes100':'" + ConvertToNum(nNotes100.val()) + "', 'nNotes50':'" + ConvertToNum(nNotes50.val()) + "', 'nNotes20':'" + ConvertToNum(nNotes20.val()) + "', 'nNotes10':'" + ConvertToNum(nNotes10.val()) + "', 'nNotes5':'" + ConvertToNum(nNotes5.val()) + "', 'nNotes2':'" + ConvertToNum(nNotes2.val()) + "', 'nNotes1':'" + ConvertToNum(nNotes1.val()) + "', 'nTotalNotes':'" + ConvertToNum(nTotalNotes.val()) + "', 'nTotalRs':'" + ConvertToNum(nTotalRs.val()) + "','cType':'CD','nBankID':'" + nBankIDD.GetValue() + "','cCurrentTime':'" + cCurrentTime.val() + "','cCMSSlipNo':'" + cCMSSlipNo.val() + "','cHCINNo':'" + cHCINNo.val() + "','cDepositerName':'" + cDepositerName.val() + "','nCoins':'" + ConvertToNum(nCoins.val()) + "'}";
                                makeAjaxCall('CashDeposit', true);
                                clearCashDeposit();
                            },
                            failure: function (response) {
                                alert(response.d.Msg);
                            }
                        });
                    }

                }
            }



        }


        //function loadProgress() {
        //    $('body').attr('disabled', 'disabled');
        //    $('body').append('<i class="icon fa-spinner"></i>');
        //}

        function FinalSave() {
            var nBranchID = $.cookie('CNGPumpBranchID');
            var nCompID = $.cookie('CNGPumpCompID');
            var cAccYear = $.cookie('CNGPumpAccYear');
            var nInstID = $.cookie('CNGPumpLoginID');
            if (ID != undefined) {
                if (D == undefined) {
                    $.ajax({
                        type: "POST",
                        url: "TranCRUD.asmx/AddUpdateDeleteTblTranDailySales",
                        data: "{'Query':'PU','PID':'" + ID + "','dDate':'" + $('#<%=TxtdDate.ClientID %>').val() + "','nSrNo':'','nBranchID':'" + nBranchID + "','nCompID':'" + nCompID + "','cAccYear':'" + cAccYear + "','nInstID':'" + nInstID + "','nUpID':'" + nInstID + "','CID':'','nStationID':'','nStaffID':'','nShift':'','nOpening':'','nClosing':'','nDiff':'','nRate':'','nDiffRate':'','nDepositRs':'','nDiffAmt':'','nJumpRate':''}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            alertify.alert("You have successfully UPDATE Daily Sale Details!", function () {
                                location.href = "ListTranDailySale.aspx";
                            });
                        },
                        failure: function (response) {
                            alert(response.d.Msg);
                        }
                    });
                }
                else {
                    var Query = 'PDCD';
                    swal({
                        title: "Are you sure?",
                        text: "Do you really want to delete?",
                        type: "warning",
                        showCancelButton: !0,
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "Yes, delete it!",
                        closeOnConfirm: !1
                    }, function (isConfirm) {
                        !isConfirm ? location.href = "ListTranDailySale.aspx" :
						$.ajax({

						    url: "TranCRUD.asmx/AddUpdateDeleteTblTranDailySales",
						    data: "{'Query':'" + Query + "','PID':'" + ID + "','dDate':'','nSrNo':'','nBranchID':'" + nBranchID + "','nCompID':'" + nCompID + "','cAccYear':'" + cAccYear + "','nInstID':'','nUpID':'','CID':'','nStationID':'','nStaffID':'','nShift':'','nOpening':'','nClosing':'','nDiff':'','nRate':'','nDiffRate':'','nDepositRs':'','nDiffAmt':'','nJumpRate':''}",
						    dataType: "json",
						    type: "POST",
						    contentType: "application/json;charset:utf-8",
						    success: function (data) {
						        window.onkeydown = null;
						        swal("Deleted!", "You have successfully DELETE Daily Sale Details!", "success");
						        $('#btnAlertOK').on('click', function () {
						            location.href = "ListTranDailySale.aspx";
						        });
						    },
						    failure: function (data) {
						        $('#btnAlertifyOK').on('click', function () {
						            location.href = "ListTranDailySale.aspx";
						        });
						    }
						});
                    });
                }
            }
            else {
                $.ajax({
                    type: "POST",
                    url: "TranCRUD.asmx/AddUpdateDeleteTblTranDailySales",
                    data: "{'Query':'PU','PID':'" + ID + "','dDate':'" + $('#<%=TxtdDate.ClientID %>').val() + "','nSrNo':'','nBranchID':'" + nBranchID + "','nCompID':'" + nCompID + "','cAccYear':'" + cAccYear + "','nInstID':'" + nInstID + "','nUpID':'" + nInstID + "','CID':'','nStationID':'','nStaffID':'','nShift':'','nOpening':'','nClosing':'','nDiff':'','nRate':'','nDiffRate':'','nDepositRs':'','nDiffAmt':'','nJumpRate':''}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        alertify.alert("You have successfully INSERT Daily Sale Details!", function () {
                            location.href = "TranDailySale.aspx";
                        });
                    },
                    failure: function (response) {
                        alert(response.d.Msg);
                    }
                });
            }
        }

        function CancelCashD(BankType) {
            var currentTime = '';
            CurrentHour = moment().hour();
            CurrentMinute = moment().minutes();

            //if (CurrentHour >= 0 && CurrentHour < 12) {
            //    AMPM = "AM";
            //}
            //else {
            //    AMPM = "PM";
            //    CurrentHour = CurrentHour - 12;
            //}
            //
            //currentTime = CurrentHour + ':' + CurrentMinute + ' ' + AMPM + '';

            currentTime = CurrentHour + ':' + CurrentMinute + '';

            //DXcBankD.SetValue('');
            //DXcBankD.SetText('');
            $('#txtdCurrentTime').val(currentTime);
            $('#txtnDRs2000').val('');
            $('#txtnDRs1000').val('');
            $('#txtnDRs500').val('');
            $('#txtnDRs100').val('');
            $('#txtnDRs50').val('');
            $('#txtnDRs20').val('');
            $('#txtnDRs10').val('');
            $('#txtnDRs5').val('');
            $('#txtnDRs2').val('');
            $('#txtnDRs1').val('');
            $('#txtnDRs2000Total').val('');
            $('#txtnDRs1000Total').val('');
            $('#txtnDRs500Total').val('');
            $('#txtnDRs100Total').val('');
            $('#txtnDRs50Total').val('');
            $('#txtnDRs20Total').val('');
            $('#txtnDRs10Total').val('');
            $('#txtnDRs5Total').val('');
            $('#txtnDRs2Total').val('');
            $('#txtnDRs1Total').val('');
            $('#spanDTotalNotes').text('');
            $('#spanDTotalRs').text('');
            $('#<%=HFCashDepositID.ClientID %>').val('');
            $('#txtnCoinsRsDTotal').val('');
            var cCMSSlipNoC = $('#txtcCMSSlipNo');
            var cHCINNoC = $('#txtcHCINNo');
            var cDepositerNameC = $('#txtcDepositerName');
            cCMSSlipNoC.val('');
            cHCINNoC.val('');
            cDepositerNameC.val('');

            $.ajax({
                type: "POST",
                url: "TranCRUD.asmx/GetDefaultBankAccount",
                data: "{'BankType':'" + BankType + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    //alert(response.d.nBankID);
                    setTimeout(function () {
                        DXcBankD.SetValue(response.d.nBankID);
                        DXcBankD.SetText(response.d.cBankName);

                    }, 200);
                },
                error: function (response) {
                    alertify.alert(response.d.Msg);
                }
            });

            DXcBankD.Focus();

        }

        function clearAllModalItems() {
            clearCash();
            clearCreditCard();
            clearCreditSales();
            setTimeout(function () {
                if ($('#<%=HFCurrentAspect.ClientID %>').val() == "Cash") {
                    $('#cCashTab').click();
                    $('#txtnRs2000').focus();
                }
                else if ($('#<%=HFCurrentAspect.ClientID %>').val() == "CreditCard") {
                    $('#cCreditCardTab').click();
                    DXcBank.Focus();
                }
                else if ($('#<%=HFCurrentAspect.ClientID %>').val() == "Paytm") {
                    $('#cPaytmTab').click();
                    DXcBank.Focus();
                }
                else if ($('#<%=HFCurrentAspect.ClientID %>').val() == "CreditSale") {
                    $('#cCreditSalesTab').click();
                    DXcCustomer.Focus();
                }
                else if ($('#<%=HFCurrentAspect.ClientID %>').val() == "AdaniSale") {
                    $('#cAdaniSalesTab').click();
                    DXcCustomer.Focus();
                }
                else {
                    $('#cCashTab').click();
                    $('#txtnRs2000').focus();
                }
            }, 100);
}

function TotalDiffKG() {
    var shift = '';
    if ($('#<%=HFCurrentShift.ClientID %>').val() == "1") {
        shift = 'One';
    }
    else if ($('#<%=HFCurrentShift.ClientID %>').val() == "2") {
        shift = 'Two';
    }
    else if ($('#<%=HFCurrentShift.ClientID %>').val() == "3") {
        shift = 'Three';
    }
    else {
        shift = 'One';
    }
    var nTotalRows = $('#exampleTabsIcon' + shift + ' .dynamicChild').length - 3;
    var nDiffTotal = 0;
    for (var i = 0; i < nTotalRows; i++) {
        var nDiffKGs = $('#txtnDiff_' + i + '').val();
        nDiffTotal = parseFloat(nDiffTotal) + parseFloat(ConvertToNum(nDiffKGs));
    }
    //alert(nDiffTotal);
    nDiffTotal = parseFloat(nDiffTotal).toFixed(2);
    $('#spanDiffKGTotal').text(nDiffTotal);
}

function TotalJumpRate() {
    var shift = '';
    if ($('#<%=HFCurrentShift.ClientID %>').val() == "1") {
        shift = 'One';
    }
    else if ($('#<%=HFCurrentShift.ClientID %>').val() == "2") {
        shift = 'Two';
    }
    else if ($('#<%=HFCurrentShift.ClientID %>').val() == "3") {
        shift = 'Three';
    }
    else {
        shift = 'One';
    }
    var nTotalRows = $('#exampleTabsIcon' + shift + ' .dynamicChild').length - 3;
    var nTotalJumpRate = 0;
    for (var i = 0; i < nTotalRows; i++) {
        var nJumpRate = $('#txtnJumpRate_' + i + '').val();
        nTotalJumpRate = parseFloat(nTotalJumpRate) + parseFloat(ConvertToNum(nJumpRate));
    }
            //alert(nDiffTotal);
    nTotalJumpRate = parseFloat(nTotalJumpRate).toFixed(2);
    $('#spanJumpTotal').text(nTotalJumpRate);
}



function TotalDiffRate() {
    var shift = '';
    if ($('#<%=HFCurrentShift.ClientID %>').val() == "1") {
        shift = 'One';
    }
    else if ($('#<%=HFCurrentShift.ClientID %>').val() == "2") {
        shift = 'Two';
    }
    else if ($('#<%=HFCurrentShift.ClientID %>').val() == "3") {
        shift = 'Three';
    }
    else {
        shift = 'One';
    }
    var nTotalRows = $('#exampleTabsIcon' + shift + ' .dynamicChild').length - 3;
    var nDiffTotal = 0;
    for (var i = 0; i < nTotalRows; i++) {
        var nDiffRate = $('#txtnDiffRate_' + i + '').val();
        nDiffTotal = parseFloat(nDiffTotal) + parseFloat(ConvertToNum(nDiffRate));
    }
    nDiffTotal = parseFloat(nDiffTotal).toFixed(2);
    $('#spanDiffRateTotal').text(nDiffTotal);
}

function TotalDepositRs() {
    var shift = '';
    if ($('#<%=HFCurrentShift.ClientID %>').val() == "1") {
        shift = 'One';
    }
    else if ($('#<%=HFCurrentShift.ClientID %>').val() == "2") {
        shift = 'Two';
    }
    else if ($('#<%=HFCurrentShift.ClientID %>').val() == "3") {
        shift = 'Three';
    }
    else {
        shift = 'One';
    }
    var nTotalRows = $('#exampleTabsIcon' + shift + ' .dynamicChild').length - 3;
    var nDiffTotal = 0;
    for (var i = 0; i < nTotalRows; i++) {
        var nDiffDepositRs = $('#txtnDepositRate_' + i + '').val();
        nDiffTotal = parseFloat(nDiffTotal) + parseFloat(ConvertToNum(nDiffDepositRs));
    }
    nDiffTotal = parseFloat(nDiffTotal).toFixed(2);
    $('#spanDepositTotal').text(nDiffTotal);
    //alert(nDiffTotal);
}

function TotalDiffAmt() {

    var shift = '';
    if ($('#<%=HFCurrentShift.ClientID %>').val() == "1") {
        shift = 'One';
    }
    else if ($('#<%=HFCurrentShift.ClientID %>').val() == "2") {
        shift = 'Two';
    }
    else if ($('#<%=HFCurrentShift.ClientID %>').val() == "3") {
        shift = 'Three';
    }
    else {
        shift = 'One';
    }
    var nDiffTotal = 0;
    var nTotalRows = $('#exampleTabsIcon' + shift + ' .dynamicChild').length - 3;
    for (var i = 0; i < nTotalRows; i++) {
        var nDiffAmt = $('#txtnDiffAmt_' + i + '').val();


        nDiffTotal = parseFloat(nDiffTotal) + parseFloat(ConvertToNum(nDiffAmt));
    }
    nDiffTotal = parseFloat(nDiffTotal).toFixed(2);
    $('#spanDiffAmtTotal').text(nDiffTotal);
}


function GetTotalRs() {
    if ($('#<%=HFIsDeposit.ClientID %>').val() != "1") {
        $.ajax({
            type: "POST",
            url: "TranCRUD.asmx/DailySalesTotalRs",
            data: "{'PID':'" + $('#<%=HFPID.ClientID %>').val() + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                $('#spanTotalCash').text(response.d.nTotalCashRs);
                $('#spanTotalCreditCard').text(response.d.nTotalCreditCardRs);
                $('#spanTotalPaytm').text(response.d.nTotalPaytmRs);
                $('#spanTotalCreditSales').text(response.d.nTotalCreditSalesRs);
            },
            failure: function (response) {
                alert(response.d.Msg);
            }
        });
    }
}

function GetTotalShiftRs() {
    $.ajax({
        type: "POST",
        url: "TranCRUD.asmx/DailySalesShiftTotalRs",
        data: "{'PID':'" + $('#<%=HFPID.ClientID %>').val() + "','nShift':'" + $('#<%=HFCurrentShift.ClientID %>').val() + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            $('#spanShiftTotalCashRs').text(response.d.nTotalCashRs);
            $('#spanShiftTotalCreditCardRs').text(response.d.nTotalCreditCardRs);
            $('#spanShiftTotalPaytmRs').text(response.d.nTotalPaytmRs);
            $('#spanShiftTotalCreditSalesRs').text(response.d.nTotalCreditSalesRs);
            $('#spanFinalTotal').text(parseFloat(parseFloat(response.d.nTotalCashRs) + parseFloat(response.d.nTotalCreditCardRs) + parseFloat(response.d.nTotalPaytmRs) + parseFloat(response.d.nTotalCreditSalesRs)).toFixed(2));

        },
        failure: function (response) {
            alert(response.d.Msg);
        }
    });
}

function GetPreviousData() {
    if ($('#<%=HFCurrentShift.ClientID %>').val() > 1) {
        $.ajax({
            type: "POST",
            url: "TranCRUD.asmx/PreviousShiftData",
            data: "{'PID':'" + $('#<%=HFPID.ClientID %>').val() + "','nShift':'" + $('#<%=HFCurrentShift.ClientID %>').val() + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                for (var i = 0; i < response.d.length; i++) {
                    var nClosing = response.d[i].nClosing;
                    if (ConvertToNum($('#txtnOpening_' + i + '').val()) <= 0) {
                        //if (parseFloat(ConvertToNum(nClosing)) > 0) {
                            $('#txtnOpening_' + i + '').val(nClosing);
                            if ($('#HFStaffID_' + i + '').val() != '') {
                                if ($('#<%=HFDayDone.ClientID %>').val() != 1) {
                                    if ($.cookie('CNGPumpLogin_Type') != 2) {                                        
                                        $('#txtnOpening_' + i + '').removeAttr('disabled');                                       
                                        $('#txtnClosing_' + i + '').removeAttr('disabled');                                        
                                    }
                                    else {
                                        if (ConvertToNum($('#txtnOpening_' + i + '').val()) == 0) {
                                            $('#txtnOpening_' + i + '').removeAttr('disabled');
                                        }
                                        if (ConvertToNum($('#txtnClosing_' + i + '').val()) == 0) {
                                            $('#txtnClosing_' + i + '').removeAttr('disabled');
                                        }
                                    }
                                    $('#txtnJumpRate_' + i + '').removeAttr('disabled');
                                }
                            }
                        //}
                    }
                }
            },
            failure: function (response) {
                alert(response.d.Msg);
            }
        });
    }

}


function GetDepositRs() {


    $.ajax({
        type: "POST",
        url: "TranCRUD.asmx/GetDepositCashRsStaffWise",
        data: "{'PID':'" + $('#<%=HFPID.ClientID %>').val() + "','nShift':'" + $('#<%=HFCurrentShift.ClientID %>').val() + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            var nTotalDepositRs = 0;
            var nTotalDiffRate = 0;
            var nTotalDiffAmt = 0;
            var nTotalJumpRate = 0;
            for (var i = 0; i < response.d.length; i++) {
                $('#txtnDepositRate_' + i + '').val(response.d[i].nDepositRs);
                $('#txtnDiffRate_' + i + '').val(response.d[i].nDiffRate);
                $('#txtnDiffAmt_' + i + '').val(Math.round(response.d[i].nDiffAmt));
                $('#txtnJumpRate_' + i + '').val(response.d[i].nJumpRate);
                if (i == 0) {
                    nTotalDepositRs = response.d[0].nTotalDepositRs;
                    nTotalDiffRate = response.d[0].nTotalDiffRate;
                    nTotalDiffAmt = Math.round(response.d[0].nTotalDiffAmt);
                    nTotalJumpRate = response.d[0].nTotalJumpRate;
                }
            }
            $('#spanDepositTotal').text(nTotalDepositRs);
            $('#spanDiffRateTotal').text(nTotalDiffRate);
            $('#spanDiffAmtTotal').text(nTotalDiffAmt);
            $('#spanJumpTotal').text(nTotalJumpRate);

        },
        failure: function (response) {
            alert(response.d.Msg);
        }
    });
}

function DayEnd() {
    $.ajax({
        type: "POST",
        url: "TranCRUD.asmx/TranDailySaleDayEnd",
        data: "{'PID':'" + $('#<%=HFPID.ClientID %>').val() + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                alertify.alert("Day End done sucessfully!", function () {
                    location.href = "TranDailySale.aspx";
                });
            },
            failure: function (response) {
                alert(response.d.Msg);
            }
        });
    }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="panel">
        <div class="panel-heading">
            <h2 class="panel-title">Daily Sales Transaction
                <button type="button" name="btnList" id="btnList" runat="server" class="btn btn-info AddList" onclick="location.href = 'ListTranDailySale.aspx'"
                    tabindex="6015" style="float: right;">
                    <i class="icon wb-list"></i><span class="spanList"></span>
                </button>
                <button type="button" name="btnAdd" id="btnAdd" runat="server" class="btn btn-success AddList" onclick="location.href = 'TranDailySale.aspx'"
                    tabindex="6014" style="float: right; margin-right: 4px;">
                    <i class="icon wb-plus" style="margin-left: 0px; padding-left: 0px;"></i><span class="spanNew"></span>
                </button>
            </h2>
            <div>
                <div class="clearfix">
                </div>
            </div>
        </div>
        <div class="panel-content marginTopContent">
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="col-lg-1 col-md-2 col-sm-2 col-xs-10">
                        <strong class="contentLabel">Tran No</strong>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
                        <asp:TextBox runat="server" ID="TxtnTranNo" CssClass="bsinputred" Enabled="false" />
                    </div>
                    <div class="col-lg-1 col-md-2 col-sm-2 col-xs-10">
                        <strong class="contentLabel">Date</strong>
                    </div>
                    <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
                        <asp:TextBox runat="server" ID="TxtdDate" CssClass="bsdate_picker" TabIndex="1" onkeydown="return validateKeyPress(event,validDt)"
                            OnChange="dateval(this); getTodayRate(); DailySalesExists('DateChange');" MaxLength="10"
                            data-inputmask="'mask': '99/99/9999'" />
                        <cc1:CalendarExtender runat="server" ID="CalendarExtenderdDate" TargetControlID="TxtdDate"
                            BehaviorID="bCalendarExtenderdDate" CssClass="cal_Theme1" Format="dd/MM/yyyy"
                            PopupButtonID="ImageButton1">
                        </cc1:CalendarExtender>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-1">
                        <strong class="contentLabel">Rate</strong>
                    </div>
                    <div class="col-lg-4 col-md-2 col-sm-2">
                        <asp:TextBox runat="server" ID="TxtnRate" CssClass="bsinputred" Enabled="false" />
                    </div>
                </div>
            </div>
            <div class="row top-buffer" style="padding-left: 3%; padding-right: 3%;">
                <div class="nav-tabs-horizontal">
                    <ul class="nav nav-tabs" data-plugin="nav-tabs" role="tablist">
                        <li class="active" role="presentation" id="liShift1"><a data-toggle="tab" href="#exampleTabsIconOne"
                            tabindex="2" aria-controls="exampleTabsIconOne" role="tab" onclick="shift1Click()">Shift 1</a></li>
                        <li role="presentation" id="liShift2"><a data-toggle="tab" href="#exampleTabsIconTwo"
                            aria-controls="exampleTabsIconTwo" tabindex="998" role="tab" onclick="shift2Click()">Shift 2</a></li>
                        <li role="presentation" id="liShift3"><a data-toggle="tab" href="#exampleTabsIconThree"
                            aria-controls="exampleTabsIconThree" tabindex="1998" role="tab" onclick="shift3Click()">Shift 3</a></li>
                        <li role="presentation" id="liDeposit"><a data-toggle="tab" href="#exampleTabsIconFour"
                            aria-controls="exampleTabsIconFour" tabindex="2998" role="tab" onclick="DepositClick()">Deposit</a></li>
                    </ul>
                    <div class="tab-content padding-top-15">
                        <div class="tab-pane active" id="exampleTabsIconOne" role="tabpanel">
                        </div>
                        <div class="tab-pane" id="exampleTabsIconTwo" role="tabpanel">
                        </div>
                        <div class="tab-pane" id="exampleTabsIconThree" role="tabpanel">
                        </div>
                        <div class="tab-pane" id="exampleTabsIconFour" role="tabpanel">
                            <div class="row top-buffer">
                                <div class="col-lg-12 col-md-12 col-sm-12">
                                    <div class="col-lg-2 col-md-2 col-sm-2">
                                        <strong class="contentLabel">Bank Name</strong>
                                    </div>
                                    <div class="col-lg-3 col-md-3 col-sm-3">
                                      <%--  <dx:ASPxComboBox ID="DXcBankD" runat="server" EnableCallbackMode="True" CallbackPageSize="200"
                                            ValueField="NID" OnItemsRequestedByFilterCondition="DXcBank_ASPxComboBox_OnItemsRequestedByFilterCondition_SQL"
                                            OnItemRequestedByValue="DXcBank_ASPxComboBox_OnItemRequestedByValue_SQL" TextFormatString="{1}"
                                            DropDownStyle="DropDownList" DisplayFormatString="{1}" ClientInstanceName="DXcBankD"
                                            TabIndex="6001" BackColor="#D9EBFB" AllowNull="true" IncrementalFilteringMode="Contains"
                                            CssClass="dxResponsive">
                                            <Columns>
                                                <dx:ListBoxColumn FieldName="cAlias" Caption="Short Name" Width="100px" />
                                                <dx:ListBoxColumn FieldName="cname" Caption="Bank Name" Width="200px" />
                                                <dx:ListBoxColumn FieldName="cCity" Caption="" Width="0px" />
                                            </Columns>
                                            <%--<ClientSideEvents ValueChanged="function(s,e) { getGroupName(s) }" />--%>
                                       <%-- </dx:ASPxComboBox--%>
                                    </div>
                                    <div class="col-lg-2 col-md-2 col-sm-2">
                                        <strong class="contentLabel">Current Time</strong>
                                    </div>
                                    <div class="col-lg-2 col-md-2 col-sm-2">
                                        <input type="text" class="bsinputblue" id="txtdCurrentTime" disabled="disabled" />
                                    </div>
                                    <div class="col-lg-3 col-md-3 col-sm-3">
                                    </div>
                                </div>
                                <div class="col-lg-12 col-md-12 col-sm-12 top-buffer">
                                    <div class="col-lg-2 col-md-2 col-sm-2">
                                        <strong class="contentLabel">CMS Slip No</strong>
                                    </div>
                                    <div class="col-lg-3 col-md-3 col-sm-3">
                                        <input type="text" class="bsinputblue" id="txtcCMSSlipNo" tabindex="6001" />
                                    </div>
                                    <div class="col-lg-2 col-md-2 col-sm-2">
                                        <strong class="contentLabel">HCIN No</strong>
                                    </div>
                                    <div class="col-lg-2 col-md-2 col-sm-2">
                                        <input type="text" class="bsinputblue" id="txtcHCINNo" tabindex="6001" />
                                    </div>
                                    <div class="col-lg-3 col-md-3 col-sm-3">
                                    </div>
                                </div>
                                <div class="col-lg-12 col-md-12 col-sm-12 top-buffer">
                                    <div class="col-lg-2 col-md-2 col-sm-2">
                                        <strong class="contentLabel">Name</strong>
                                    </div>
                                    <div class="col-lg-3 col-md-3 col-sm-3">
                                        <input type="text" class="bsinputblue" id="txtcDepositerName" tabindex="6001" />
                                    </div>
                                    <div class="col-lg-7 col-md-7 col-sm-7">
                                    </div>
                                </div>
                                <div class="col-lg-12 col-md-12 col-sm-12 top-buffer" style="border-bottom: 1px solid black; margin-top: 10px;">
                                    <div class="col-lg-1 col-md-1 col-sm-1" style="text-align: center; font-size: 18px;">
                                        <strong class="contentLabel">Denom</strong>
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1 inputCenter" style="font-size: 18px;">
                                        <strong class="contentLabel">2000</strong>
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1 inputCenter" style="font-size: 18px; display: none;">
                                        <strong class="contentLabel">1000</strong>
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1 inputCenter" style="font-size: 18px;">
                                        <strong class="contentLabel">500</strong>
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1 inputCenter" style="font-size: 18px;">
                                        <strong class="contentLabel">100</strong>
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1 inputCenter" style="font-size: 18px;">
                                        <strong class="contentLabel">50</strong>
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1 inputCenter" style="font-size: 18px;">
                                        <strong class="contentLabel">20</strong>
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1 inputCenter" style="font-size: 18px;">
                                        <strong class="contentLabel">10</strong>
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1 inputCenter" style="font-size: 18px;">
                                        <strong class="contentLabel">Coins/Rs.</strong>
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1 inputCenter" style="font-size: 18px; display: none;">
                                        <strong class="contentLabel">5</strong>
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1 inputCenter" style="font-size: 18px; display: none;">
                                        <strong class="contentLabel">2</strong>
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1 inputCenter" style="font-size: 18px; display: none;">
                                        <strong class="contentLabel">1</strong>
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1 cashRight">
                                        <strong class="contentLabel" style="font-size: 18px;">Total</strong>
                                    </div>
                                </div>
                                <div class="col-lg-12 col-md-12 col-sm-12 top-buffer">
                                    <div class="col-lg-1 col-md-1 col-sm-1" style="text-align: center;">
                                        <strong class="contentLabel">Notes</strong>
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1 inputCenter">
                                        <input type="text" class="bsinputred NoteNoD" id="txtnDRs2000" onkeydown="return validateKeyPress(event,validNums)"
                                            onfocusout="CalculateCashNotesDeposit('2000',$(this))" tabindex="6002" />
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1 inputCenter" style="display: none;">
                                        <input type="text" class="bsinputred NoteNoD" id="txtnDRs1000" onkeydown="return validateKeyPress(event,validNums)"
                                            onfocusout="CalculateCashNotesDeposit('1000',$(this))" tabindex="6003" />
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1 inputCenter">
                                        <input type="text" class="bsinputred NoteNoD" id="txtnDRs500" onkeydown="return validateKeyPress(event,validNums)"
                                            onfocusout="CalculateCashNotesDeposit('500',$(this))" tabindex="6004" />
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1 inputCenter">
                                        <input type="text" class="bsinputred NoteNoD" id="txtnDRs100" onkeydown="return validateKeyPress(event,validNums)"
                                            onfocusout="CalculateCashNotesDeposit('100',$(this))" tabindex="6005" />
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1 inputCenter">
                                        <input type="text" class="bsinputred NoteNoD" id="txtnDRs50" onkeydown="return validateKeyPress(event,validNums)"
                                            onfocusout="CalculateCashNotesDeposit('50',$(this))" tabindex="6006" />
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1 inputCenter">
                                        <input type="text" class="bsinputred NoteNoD" id="txtnDRs20" onkeydown="return validateKeyPress(event,validNums)"
                                            onfocusout="CalculateCashNotesDeposit('20',$(this))" tabindex="6007" />
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1 inputCenter">
                                        <input type="text" class="bsinputred NoteNoD" id="txtnDRs10" onkeydown="return validateKeyPress(event,validNums)"
                                            onfocusout="CalculateCashNotesDeposit('10',$(this))" tabindex="6008" />
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1 inputCenter">
                                        <%--<input type="text" class="bsinputred NoteNoD" id="txtnDCoinsRs" onkeydown="return validateKeyPress(event,validNums)"
                                            onfocusout="CalculateCashNotesDeposit('1',$(this))" tabindex="6009" />--%>
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1 inputCenter" style="display: none;">
                                        <input type="text" class="bsinputred" id="txtnDRs5" onkeydown="return validateKeyPress(event,validNums)"
                                            onfocusout="CalculateCashNotesDeposit('5',$(this))" tabindex="6009" />
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1 inputCenter" style="display: none;">
                                        <input type="text" class="bsinputred" id="txtnDRs2" onkeydown="return validateKeyPress(event,validNums)"
                                            onfocusout="CalculateCashNotesDeposit('2',$(this))" tabindex="6010" />
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1 inputCenter" style="display: none;">
                                        <input type="text" class="bsinputred" id="txtnDRs1" onkeydown="return validateKeyPress(event,validNums)"
                                            onfocusout="CalculateCashNotesDeposit('1',$(this))" tabindex="6011" />
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1" style="text-align: right;">
                                        <span style="font-size: 18px; font-weight: bold;" id="spanDTotalNotes"></span>
                                    </div>
                                    <div class="col-lg-3 col-md-3 col-sm-3">
                                    </div>
                                </div>
                                <div class="col-lg-12 col-md-12 col-sm-12 top-buffer-3">
                                    <div class="col-lg-1 col-md-1 col-sm-1" style="text-align: center;">
                                        <strong class="contentLabel">Rs. (<i class="fa fa-inr"></i>)</strong>
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1 inputCenter">
                                        <input type="text" class="bsinputred NoteCountD" id="txtnDRs2000Total" onkeydown="return validateKeyPress(event,validNums)"
                                            disabled="disabled" value="0" />
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1 inputCenter" style="display: none;">
                                        <input type="text" class="bsinputred NoteCountD" id="txtnDRs1000Total" onkeydown="return validateKeyPress(event,validNums)"
                                            disabled="disabled" value="0" />
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1 inputCenter">
                                        <input type="text" class="bsinputred NoteCountD" id="txtnDRs500Total" onkeydown="return validateKeyPress(event,validNums)"
                                            disabled="disabled" value="0" />
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1 inputCenter">
                                        <input type="text" class="bsinputred NoteCountD" id="txtnDRs100Total" onkeydown="return validateKeyPress(event,validNums)"
                                            disabled="disabled" value="0" />
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1 inputCenter">
                                        <input type="text" class="bsinputred NoteCountD" id="txtnDRs50Total" onkeydown="return validateKeyPress(event,validNums)"
                                            disabled="disabled" value="0" />
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1 inputCenter">
                                        <input type="text" class="bsinputred NoteCountD" id="txtnDRs20Total" onkeydown="return validateKeyPress(event,validNums)"
                                            disabled="disabled" value="0" />
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1 inputCenter">
                                        <input type="text" class="bsinputred NoteCountD" id="txtnDRs10Total" onkeydown="return validateKeyPress(event,validNums)"
                                            disabled="disabled" value="0" />
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1 inputCenter">
                                        <input type="text" class="bsinputred NoteNoD" id="txtnCoinsRsDTotal" onkeydown="return validateKeyPress(event,validNums)"
                                            tabindex="6009" onfocusout="CalculateCashNotesDeposit('1',$(this))" />
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1 inputCenter" style="display: none;">
                                        <input type="text" class="bsinputred" id="txtnDRs5Total" onkeydown="return validateKeyPress(event,validNums)"
                                            disabled="disabled" value="0" />
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1 inputCenter" style="display: none;">
                                        <input type="text" class="bsinputred" id="txtnDRs2Total" onkeydown="return validateKeyPress(event,validNums)"
                                            disabled="disabled" value="0" />
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1 inputCenter" style="display: none;">
                                        <input type="text" class="bsinputred" id="txtnDRs1Total" onkeydown="return validateKeyPress(event,validNums)"
                                            disabled="disabled" value="0" />
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1" style="text-align: right;">
                                        <span style="font-size: 18px; font-weight: bold;" id="spanDTotalRs"></span>
                                    </div>
                                    <div class="col-lg-3 col-md-3 col-sm-3">
                                        <button type="button" name="btnAddCash" id="btnAddCash" class="btn btn-sm btn-floating btn-success"
                                            tabindex="6011" onclick="AddUpdateDeleteCashDeposit()">
                                            <i class="icon md-plus"></i>
                                        </button>
                                        <button type="button" name="btnCancelCashD" id="btnCancelCashD" class="btn btn-sm btn-floating btn-danger"
                                            tabindex="6011" onclick="CancelCashD()">
                                            <i class="icon md-close"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="col-lg-12 col-md-12 col-sm-12 top-buffer-3" style="display: none;">
                                    <div class="col-lg-10 col-md-10 col-sm-10">
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1">
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-1">
                                        <%--<button type="button" name="btnAddCash" id="btnAddCash" class="btn btn-sm btn-floating btn-success"
                                            tabindex="6011" onclick="AddUpdateDeleteCashDeposit()">
                                            <i class="icon md-plus"></i>
                                        </button>
                                        <button type="button" name="btnCancelCashD" id="btnCancelCashD" class="btn btn-sm btn-floating btn-danger"
                                            tabindex="6011" onclick="CancelCashD()">
                                            <i class="icon md-close"></i>
                                        </button>--%>
                                    </div>
                                </div>
                                <div class="col-lg-12 col-md-12 col-sm-12 top-buffer-3">
                                    <div class="row" style="width: 950px; margin-left: 100px;">
                                        <div id="myDivCashDeposit" style="padding-top: 0px; padding-bottom: 0px;">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <br />
            <br />
            <div class="BottomFixed">
                <button type="button" name="btnSave" id="btnSave" class="btn btn-success SaveCancel btnSave"
                    tabindex="6012" onclick="FinalSave()">
                    <i class="icon fa-save SaveCancelIcon iSave" id="iSave"></i><span id="spanSave" class="spanSave"></span>
                </button>
                <button type="button" name="btnCancel" id="btnCancel" class="btn btn-info SaveCancel btnCancel"
                    tabindex="6013" onclick="GoToDefaultPage()">
                    <i class="icon fa-close SaveCancelIcon iCancel"></i><span id="spanCancel" class="spanCancel"></span>
                </button>
                <button type="button" name="btnCancel" id="btnDayEnd" class="btn btn-primary" tabindex="6013"
                    onclick="DayEnd()">
                    <i class="icon fa-check"></i>Day End
                </button>
                <div style="padding-top: 3px; font-weight: bold; font-size: 18px; display: inline-block; margin-left: 5%;">
                    <span class="contentLabel">Cash</span>&nbsp;:&nbsp;<span><i class="fa fa-inr"></i></span>&nbsp;<span
                        class="contentLabel" id="spanTotalCash"></span>
                </div>
                <div style="padding-top: 3px; font-weight: bold; font-size: 18px; display: inline-block; margin-left: 5%;">
                    <span class="contentLabel">C.C.</span>&nbsp;:&nbsp;<span><i class="fa fa-inr"></i></span>&nbsp;<span
                        class="contentLabel" id="spanTotalCreditCard"></span>
                </div>
                <div style="padding-top: 3px; font-weight: bold; font-size: 18px; display: inline-block; margin-left: 5%;">
                    <span class="contentLabel">Paytm</span>&nbsp;:&nbsp;<span><i class="fa fa-inr"></i></span>&nbsp;<span
                        class="contentLabel" id="spanTotalPaytm"></span>
                </div>
                <div style="padding-top: 3px; font-weight: bold; font-size: 18px; display: inline-block; margin-left: 5%;">
                    <span class="contentLabel">C.S.</span>&nbsp;:&nbsp;<span><i class="fa fa-inr"></i></span>&nbsp;<span
                        class="contentLabel" id="spanTotalCreditSales"></span>
                </div>
            </div>
        </div>
    </div>
    <!-- Staff Modal Starts -->
    <div class="modal fade" id="staffModal" aria-hidden="true" aria-labelledby="staffModalCenter"
        role="dialog" tabindex="-1">
        <div class="modal-dialog modal-center">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <div class="col-lg-1 col-md-1 col-sm-1 col-xs-10">
                            <strong class="contentLabel">Staff</strong>
                        </div>
                        <div class="col-lg-7 col-md-7 col-sm-7 col-xs-12">
                          <%--  <dx:ASPxComboBox ID="DXcStaff1" runat="server" EnableCallbackMode="True" CallbackPageSize="200"
                                ValueField="NID" OnItemsRequestedByFilterCondition="DXcStaff_ASPxComboBox_OnItemsRequestedByFilterCondition_SQL"
                                OnItemRequestedByValue="DXcStaff_ASPxComboBox_OnItemRequestedByValue_SQL" TextFormatString="{0}"
                                DropDownStyle="DropDownList" DisplayFormatString="{0}" ClientInstanceName="DXcStaff1"
                                BackColor="#D9EBFB" AllowNull="true" IncrementalFilteringMode="Contains" CssClass="dxResponsive">
                                <Columns>
                                    <dx:ListBoxColumn FieldName="cname" Caption="Staff Name" Width="200px" />
                                    <%--<dx:ListBoxColumn FieldName="cCity" Caption="City" Width="100px" />--%>
                                </Columns>
                                <ClientSideEvents ValueChanged="function(s,e) { getStaff(s) }" />
                            </dx:ASPxComboBox>--%>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                            <button type="button" name="btnCancelModalValues" id="btnCancelModalValues" class="btn btn-danger"
                                onclick="clearAllModalItems()">
                                <i class="icon md-close"></i>Clear Data
                            </button>
                        </div>
                    </div>
                </div>
                <div class="modal-body">
                    <div class="row">
                    </div>
                    <div class="nav-tabs-horizontal">
                        <ul class="nav nav-tabs" data-plugin="nav-tabs" role="tablist">
                            <li class="active" role="presentation" id="liCashTab"><a data-toggle="tab" href="#CashTabModal"
                                aria-controls="CashTabModal" role="tab" onclick="ModalCash()" id="cCashTab">Cash</a></li>
                            <li role="presentation" id="liCreditCardTab"><a data-toggle="tab" href="#CreditCardTabModal"
                                aria-controls="CreditCardTabModal" role="tab" onclick="ModalCreditCard()" id="cCreditCardTab">Credit Card</a></li>
                            <li role="presentation" id="liPaytmTab"><a data-toggle="tab" href="#CreditCardTabModal"
                                aria-controls="CreditCardTabModal" role="tab" onclick="ModalPaytm()" id="cPaytmTab">Paytm</a></li>
                            <li role="presentation" id="liCreditSalesTab"><a data-toggle="tab" href="#CreditSalesTabModal"
                                aria-controls="CreditSalesTabModal" role="tab" onclick="ModalCreditSales()" id="cCreditSalesTab">Credit Sales</a></li>
                            <li role="presentation" id="liAdaniSalesTab"><a data-toggle="tab" href="#CreditSalesTabModal"
                                aria-controls="CreditSalesTabModal" role="tab" onclick="ModalAdaniSales()" id="cAdaniSalesTab">Adani Sales</a></li>
                        </ul>
                        <div class="tab-content padding-top-15">
                            <div class="tab-pane active" id="CashTabModal" role="tabpanel">
                                <div class="row top-buffer">
                                    <div class="col-lg-12 col-md-12 col-sm-12" style="border-bottom: 1px solid black;">
                                        <div class="col-lg-2 col-md-2 col-sm-2" style="text-align: center;">
                                            <strong class="contentLabel">Denom</strong>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-3" style="text-align: center;">
                                            <strong class="contentLabel">No of Notes</strong>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-2" style="text-align: center;">
                                            <strong class="contentLabel">Rs. (<i class="fa fa-inr"></i>)</strong>
                                        </div>
                                        <div class="col-lg-5 col-md-5 col-sm-5">
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-md-12 col-sm-12 top-buffer">
                                        <div class="col-lg-2 col-md-2 col-sm-2 cashRight">
                                            <strong class="contentLabel">2000</strong>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-3 inputCenter">
                                            <input type="text" class="bsinputred NoteNo" id="txtnRs2000" onkeydown="return validateKeyPress(event,validNums)"
                                                onfocusout="CalculateCashNotes('2000',$(this))" />
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-3 inputCenter">
                                            <input type="text" class="bsinputred NoteCount" id="txtnRs2000Total" onkeydown="return validateKeyPress(event,validNums)"
                                                disabled="disabled" value="0" />
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-sm-4">
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-md-12 col-sm-12 top-buffer-3" style="display: none;">
                                        <div class="col-lg-2 col-md-2 col-sm-2 cashRight">
                                            <strong class="contentLabel">1000</strong>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-3 inputCenter">
                                            <input type="text" class="bsinputred NoteNo" id="txtnRs1000" onkeydown="return validateKeyPress(event,validNums)"
                                                onfocusout="CalculateCashNotes('1000',$(this))" />
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-3 inputCenter">
                                            <input type="text" class="bsinputred NoteCount" id="txtnRs1000Total" onkeydown="return validateKeyPress(event,validNums)"
                                                disabled="disabled" value="0" />
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-sm-4">
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-md-12 col-sm-12 top-buffer-3">
                                        <div class="col-lg-2 col-md-2 col-sm-2 cashRight">
                                            <strong class="contentLabel">500</strong>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-3 inputCenter">
                                            <input type="text" class="bsinputred NoteNo" id="txtnRs500" onkeydown="return validateKeyPress(event,validNums)"
                                                onfocusout="CalculateCashNotes('500',$(this))" />
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-3 inputCenter">
                                            <input type="text" class="bsinputred NoteCount" id="txtnRs500Total" onkeydown="return validateKeyPress(event,validNums)"
                                                disabled="disabled" value="0" />
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-sm-4">
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-md-12 col-sm-12 top-buffer-3">
                                        <div class="col-lg-2 col-md-2 col-sm-2 cashRight">
                                            <strong class="contentLabel">100</strong>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-3 inputCenter">
                                            <input type="text" class="bsinputred NoteNo" id="txtnRs100" onkeydown="return validateKeyPress(event,validNums)"
                                                onfocusout="CalculateCashNotes('100',$(this))" />
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-3 inputCenter">
                                            <input type="text" class="bsinputred NoteCount" id="txtnRs100Total" onkeydown="return validateKeyPress(event,validNums)"
                                                disabled="disabled" value="0" />
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-sm-4">
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-md-12 col-sm-12 top-buffer-3">
                                        <div class="col-lg-2 col-md-2 col-sm-2 cashRight">
                                            <strong class="contentLabel">50</strong>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-3 inputCenter">
                                            <input type="text" class="bsinputred NoteNo" id="txtnRs50" onkeydown="return validateKeyPress(event,validNums)"
                                                onfocusout="CalculateCashNotes('50',$(this))" />
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-3 inputCenter">
                                            <input type="text" class="bsinputred NoteCount" id="txtnRs50Total" onkeydown="return validateKeyPress(event,validNums)"
                                                disabled="disabled" value="0" />
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-sm-4">
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-md-12 col-sm-12 top-buffer-3">
                                        <div class="col-lg-2 col-md-2 col-sm-2 cashRight">
                                            <strong class="contentLabel">20</strong>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-3 inputCenter">
                                            <input type="text" class="bsinputred NoteNo" id="txtnRs20" onkeydown="return validateKeyPress(event,validNums)"
                                                onfocusout="CalculateCashNotes('20',$(this))" />
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-3 inputCenter">
                                            <input type="text" class="bsinputred NoteCount" id="txtnRs20Total" onkeydown="return validateKeyPress(event,validNums)"
                                                disabled="disabled" value="0" />
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-sm-4">
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-md-12 col-sm-12 top-buffer-3">
                                        <div class="col-lg-2 col-md-2 col-sm-2 cashRight">
                                            <strong class="contentLabel">10</strong>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-3 inputCenter">
                                            <input type="text" class="bsinputred NoteNo" id="txtnRs10" onkeydown="return validateKeyPress(event,validNums)"
                                                onfocusout="CalculateCashNotes('10',$(this))" />
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-3 inputCenter">
                                            <input type="text" class="bsinputred NoteCount" id="txtnRs10Total" onkeydown="return validateKeyPress(event,validNums)"
                                                disabled="disabled" value="0" />
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-sm-4">
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-md-12 col-sm-12 top-buffer-3">
                                        <div class="col-lg-2 col-md-2 col-sm-2 cashRight">
                                            <strong class="contentLabel">Coins/Rs.</strong>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-3 inputCenter">
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-3 inputCenter">
                                            <input type="text" class="bsinputred NoteNo" id="txtnCoinsRsTotal" onkeydown="return validateKeyPress(event,validNums)"
                                                onfocusout="CalculateCashNotes('1',$(this))" />
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-sm-4">
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-md-12 col-sm-12 top-buffer-3" style="display: none;">
                                        <div class="col-lg-2 col-md-2 col-sm-2 cashRight">
                                            <strong class="contentLabel">5</strong>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-3 inputCenter">
                                            <input type="text" class="bsinputred" id="txtnRs5" onkeydown="return validateKeyPress(event,validNums)"
                                                onfocusout="CalculateCashNotes('5',$(this))" />
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-3 inputCenter">
                                            <input type="text" class="bsinputred" id="txtnRs5Total" onkeydown="return validateKeyPress(event,validNums)"
                                                disabled="disabled" value="0" />
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-sm-4">
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-md-12 col-sm-12 top-buffer-3">
                                        <div class="col-lg-2 col-md-2 col-sm-2 cashRight" style="display: none;">
                                            <strong class="contentLabel">2</strong>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-3 inputCenter" style="display: none;">
                                            <input type="text" class="bsinputred" id="txtnRs2" onkeydown="return validateKeyPress(event,validNums)"
                                                onfocusout="CalculateCashNotes('2',$(this))" />
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-3 inputCenter" style="display: none;">
                                            <input type="text" class="bsinputred" id="txtnRs2Total" onkeydown="return validateKeyPress(event,validNums)"
                                                disabled="disabled" value="0" />
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-2" style="padding-left: 0px; padding-right: 0px;">
                                            <strong class="contentLabel" style="float: right;">Total</strong>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-3" style="padding-left: 0px; padding-right: 35px;">
                                            <strong class="contentLabel" style="float: right;"><span class="contentLabel" id="spanTotalNotes"
                                                style="font-size: 16px; margin-left: 5px;"></span></strong>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-3" style="padding-left: 0px; padding-right: 35px;">
                                            <strong class="contentLabel" style="float: right;"><span class="contentLabel" id="spanTotalRs"
                                                style="font-size: 16px; margin-left: 5px;"></span></strong>
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-sm-4">
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-md-12 col-sm-12 top-buffer-3">
                                        <div class="col-lg-2 col-md-2 col-sm-2 cashRight" style="display: none;">
                                            <strong class="contentLabel">1</strong>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-3 inputCenter" style="display: none;">
                                            <input type="text" class="bsinputred" id="txtnRs1" onkeydown="return validateKeyPress(event,validNums)"
                                                onfocusout="CalculateCashNotes('1',$(this))" />
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-3 inputCenter" style="display: none;">
                                            <input type="text" class="bsinputred" id="txtnRs1Total" onkeydown="return validateKeyPress(event,validNums)"
                                                disabled="disabled" value="0" />
                                        </div>
                                        <%--<div class="col-lg-2 col-md-2 col-sm-2" style="padding-left: 0px; padding-right: 0px;">
                                            <strong class="contentLabel" style="float: right;">Total <i class="fa fa-inr"></i>
                                            </strong>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-2" style="padding-left: 0px; padding-right: 0px;">
                                            <strong class="contentLabel" style="float: right;"><span class="contentLabel" id="spanTotalRs"
                                                style="font-size: 16px; margin-left: 5px;"></span></strong>
                                        </div>--%>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane" id="CreditCardTabModal" role="tabpanel">
                                <div class="row top-buffer">
                                    <div class="col-lg-12 col-md-12 col-sm-12">
                                        <div class="col-lg-2 col-md-2 col-sm-2">
                                            <strong class="contentLabel">Bank</strong>
                                        </div>
                                        <div class="col-lg-8 col-md-8 col-sm-8">
                                          <%--  <dx:ASPxComboBox ID="DXcBank" runat="server" EnableCallbackMode="True" CallbackPageSize="200"
                                                ValueField="NID" OnItemsRequestedByFilterCondition="DXcBank_ASPxComboBox_OnItemsRequestedByFilterCondition_SQL"
                                                OnItemRequestedByValue="DXcBank_ASPxComboBox_OnItemRequestedByValue_SQL" TextFormatString="{1}"
                                                DropDownStyle="DropDownList" DisplayFormatString="{1}" ClientInstanceName="DXcBank"
                                                BackColor="#D9EBFB" AllowNull="true" IncrementalFilteringMode="Contains" CssClass="dxResponsive">
                                                <Columns>
                                                    <dx:ListBoxColumn FieldName="cAlias" Caption="Short Name" Width="100px" />
                                                    <dx:ListBoxColumn FieldName="cname" Caption="Bank Name" Width="200px" />
                                                    <dx:ListBoxColumn FieldName="cCity" Caption="" Width="0px" />
                                                </Columns>
                                                <%--<ClientSideEvents ValueChanged="function(s,e) { getGroupName(s) }" />--%>
                                            </dx:ASPxComboBox>--%>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-2">
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-md-12 col-sm-12 top-buffer-3" style="display: none;">
                                        <div class="col-lg-2 col-md-2 col-sm-2">
                                            <strong class="contentLabel">Card No</strong>
                                        </div>
                                        <div class="col-lg-8 col-md-8 col-sm-8">
                                            <input type="text" class="bsinputred" id="TxtcCreditCardNo" onkeydown="return validateKeyPress(event,validNums)"
                                                style="max-width: 500px;" />
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-2">
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-md-12 col-sm-12 top-buffer-3">
                                        <div class="col-lg-2 col-md-2 col-sm-2">
                                            <strong class="contentLabel">Rs. (<i class="fa fa-inr"></i>)</strong>
                                        </div>
                                        <div class="col-lg-8 col-md-8 col-sm-8">
                                            <input type="text" class="bsinputred" id="TxtnCreditCardRs" onkeydown="return validateKeyPress(event,validNums)" />
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-2">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%--<div class="tab-pane" id="PaytmTabModal" role="tabpanel">
                                <div class="row top-buffer">
                                    <div class="col-lg-12 col-md-12 col-sm-12">
                                        <div class="col-lg-2 col-md-2 col-sm-2">
                                            <strong class="contentLabel">Bank</strong>
                                        </div>
                                        <div class="col-lg-8 col-md-8 col-sm-8">
                                            <dx:ASPxComboBox ID="DXcPaytm" runat="server" EnableCallbackMode="True" CallbackPageSize="200"
                                                ValueField="NID" OnItemsRequestedByFilterCondition="DXcBank_ASPxComboBox_OnItemsRequestedByFilterCondition_SQL"
                                                OnItemRequestedByValue="DXcBank_ASPxComboBox_OnItemRequestedByValue_SQL" TextFormatString="{0} {1}"
                                                DropDownStyle="DropDownList" DisplayFormatString="{0}" ClientInstanceName="DXcPaytm"
                                                BackColor="#D9EBFB" AllowNull="true" IncrementalFilteringMode="Contains" CssClass="dxResponsive">
                                                <Columns>
                                                    <dx:ListBoxColumn FieldName="cAlias" Caption="Short Name" Width="100px" />
                                                    <dx:ListBoxColumn FieldName="cname" Caption="Bank Name" Width="200px" />
                                                    <dx:ListBoxColumn FieldName="cCity" Caption="" Width="0px" />
                                                </Columns>
                                            </dx:ASPxComboBox>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-2">
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-md-12 col-sm-12 top-buffer-3" style="display: none;">
                                        <div class="col-lg-2 col-md-2 col-sm-2">
                                            <strong class="contentLabel">Card No</strong>
                                        </div>
                                        <div class="col-lg-8 col-md-8 col-sm-8">
                                            <input type="text" class="bsinputred" id="Text1" onkeydown="return validateKeyPress(event,validNums)"
                                                style="max-width: 500px;" />
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-2">
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-md-12 col-sm-12 top-buffer-3">
                                        <div class="col-lg-2 col-md-2 col-sm-2">
                                            <strong class="contentLabel">Rs. (<i class="fa fa-inr"></i>)</strong>
                                        </div>
                                        <div class="col-lg-8 col-md-8 col-sm-8">
                                            <input type="text" class="bsinputred" id="TxtnPaytmRs" onkeydown="return validateKeyPress(event,validNums)" />
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-2">
                                        </div>
                                    </div>
                                </div>
                            </div>--%>
                            <div class="tab-pane" id="CreditSalesTabModal" role="tabpanel">
                                <div class="row top-buffer">
                                    <div class="col-lg-12 col-md-12 col-sm-12">
                                        <div class="col-lg-3 col-md-3 col-sm-3">
                                            <strong class="contentLabel">Customer</strong>
                                        </div>
                                        <div class="col-lg-9 col-md-9 col-sm-9">
                                         <%--   <dx:ASPxComboBox ID="DXcCustomer" runat="server" EnableCallbackMode="True" CallbackPageSize="200"
                                                ValueField="NID" OnItemsRequestedByFilterCondition="DXcCustomer_ASPxComboBox_OnItemsRequestedByFilterCondition_SQL"
                                                OnItemRequestedByValue="DXcCustomer_ASPxComboBox_OnItemRequestedByValue_SQL"
                                                TextFormatString="{1}" DropDownStyle="DropDownList" DisplayFormatString="{1}"
                                                ClientInstanceName="DXcCustomer" BackColor="#D9EBFB" AllowNull="true" IncrementalFilteringMode="Contains"
                                                CssClass="dxResponsive">
                                                <Columns>
                                                    <dx:ListBoxColumn FieldName="cAlias" Caption="Short Name" Width="100px" />
                                                    <dx:ListBoxColumn FieldName="cname" Caption="Customer Name" Width="200px" />
                                                    <dx:ListBoxColumn FieldName="cCity" Caption="" Width="200px" />
                                                </Columns>
                                                <%--<ClientSideEvents ValueChanged="function(s,e) { getGroupName(s) }" /
                                            </dx:ASPxComboBox>--%>
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-md-12 col-sm-12 top-buffer-3">
                                        <div class="col-lg-3 col-md-3 col-sm-3">
                                            <strong class="contentLabel">Vehicle No</strong>
                                        </div>
                                        <div class="col-lg-5 col-md-5 col-sm-5">
                                            <input type="text" id="TxtcVehicleNo" class="bsinputblue" />
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-sm-4">
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-md-12 col-sm-12 top-buffer-3">
                                        <div class="col-lg-3 col-md-3 col-sm-3">
                                            <strong class="contentLabel">Qty (Kg)</strong>
                                        </div>
                                        <div class="col-lg-5 col-md-5 col-sm-5">
                                            <input type="text" class="bsinputred" id="TxtnCreditSaleQty" onkeydown="return validateKeyPress(event,validNums)"
                                                onchange="CreditSalesRsChange($(this))" />
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-sm-4">
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-md-12 col-sm-12 top-buffer-3">
                                        <div class="col-lg-3 col-md-3 col-sm-3">
                                            <strong class="contentLabel">Rs. (<i class="fa fa-inr"></i>)</strong>
                                        </div>
                                        <div class="col-lg-5 col-md-5 col-sm-5">
                                            <input type="text" class="bsinputred" id="TxtnCreditSaleRs" disabled="disabled" />
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-sm-4">
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-md-12 col-sm-12 top-buffer-3">
                                        <div class="col-lg-3 col-md-3 col-sm-3">
                                            <strong class="contentLabel">Narration</strong>
                                        </div>
                                        <div class="col-lg-7 col-md-7 col-sm-7">
                                            <input type="text" id="TxtcNarration" class="bsinputblue" />
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-2">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer" style="padding-left: 5px; padding-right: 12px;">
                    <%--icon fa-credit-card--%>
                    <button type="button" class="btn btn-info-nohover" style="padding: 5px 11px; margin-right: -5px;"
                        onclick="SaveDetails('S')">
                        <i class="icon fa-save"></i>Save</button>
                    <button type="button" class="btn btn-info-nohover" style="padding: 5px 11px; margin-right: -3px;"
                        onclick="SaveDetails('SC')">
                        <i class="icon fa-save"></i>Save-Close &nbsp;</button>
                    <br style="height: 5px;" />
                    <button type="button" class="btn btn-info-nohover" style="padding: 5px 11px; margin-top: 5px; margin-left: 5px;"
                        data-toggle="modal" data-target="#CashList" onclick="SaveDetails('CashListGrid')">
                        <i class="icon fa-money"></i>Cash</button>
                    <button type="button" class="btn btn-info-nohover" style="padding: 5px 11px; margin-top: 5px; margin-left: 5px;"
                        data-toggle="modal" data-target="#CreditCardList" onclick="SaveDetails('CreditCardListGrid')">
                        <i class="icon fa-credit-card"></i>Credit Card</button>
                    <button type="button" class="btn btn-info-nohover" style="padding: 5px 11px; margin-top: 5px; margin-left: 5px;"
                        data-toggle="modal" data-target="#CreditCardList" onclick="SaveDetails('PaytmListGrid')">
                        <i class="icon md-paypal"></i>Paytm</button>
                    <button type="button" class="btn btn-info-nohover" style="padding: 5px 11px; margin-top: 5px; margin-left: 5px;"
                        data-toggle="modal" data-target="#CreditSalesList" onclick="SaveDetails('CreditSalesListGrid')">
                        <i class="icon fa-group"></i>Credit Sales</button>
                    <button type="button" class="btn btn-info-nohover" style="padding: 5px 11px; margin-top: 5px; margin-left: 5px;"
                        data-toggle="modal" data-target="#CreditSalesList" onclick="SaveDetails('AdaniSalesListGrid')">
                        <i class="icon fa-group"></i>Adani Sales</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Staff Modal Ends -->
    <!-- Cash List Modal Starts -->
    <div class="modal fade" id="CashList" aria-hidden="true" aria-labelledby="CashListModal"
        role="dialog" tabindex="-1">
        <div class="modal-dialog modal-center" style="width: 850px;">
            <div class="modal-content">
                <div class="modal-header">
                    <strong style="font-weight: bold; font-size: 18px;"><span id="spanCashListHead">Cash
                        List</span></strong>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body" style="padding: 0px">
                    <div class="row">
                        <div id="MyDivCash" class="modal-body" style="padding-top: 0px; padding-bottom: 0px;">
                            <%--col-lg-12 col-md-12 col-sm-12--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Cash List Modal Ends -->
    <!-- Cash List Total Modal Starts -->
    <div class="modal fade" id="CashListTotal" aria-hidden="true" aria-labelledby="CashListTotalModal"
        role="dialog" tabindex="-1">
        <div class="modal-dialog modal-center" style="width: 850px;">
            <div class="modal-content">
                <div class="modal-header">
                    <strong style="font-weight: bold; font-size: 18px;"><span id="spanCashListHeadTotal">Cash
                        List</span></strong>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body" style="padding: 0px">
                    <div class="row">
                        <div id="MyDivCashTotal" class="modal-body" style="padding-top: 0px; padding-bottom: 0px;">
                            <%--col-lg-12 col-md-12 col-sm-12--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Cash List Total Modal Ends -->
    <!-- Credit Card List Modal Starts -->
    <div class="modal fade" id="CreditCardList" aria-hidden="true" aria-labelledby="CreditCardListModal"
        role="dialog" tabindex="-1">
        <div class="modal-dialog modal-center" style="width: 700px;">
            <div class="modal-content">
                <div class="modal-header">
                    <strong style="font-weight: bold; font-size: 18px;"><span id="spanCreditCardHead"></span>
                    </strong>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body" style="padding: 0px">
                    <div class="row">
                        <div id="myDivCreditCard" class="modal-body" style="padding-top: 0px; padding-bottom: 0px;">
                            <%--col-lg-12 col-md-12 col-sm-12--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Credit Card List Modal Ends -->
    <!-- Credit Card Total List Modal Starts -->
    <div class="modal fade" id="CreditCardListTotal" aria-hidden="true" aria-labelledby="CreditCardListTotalModal"
        role="dialog" tabindex="-1">
        <div class="modal-dialog modal-center" style="width: 700px;">
            <div class="modal-content">
                <div class="modal-header">
                    <strong style="font-weight: bold; font-size: 18px;"><span id="spanCreditCardTotalHead"></span>
                    </strong>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body" style="padding: 0px">
                    <div class="row">
                        <div id="myDivCreditCardTotal" class="modal-body" style="padding-top: 0px; padding-bottom: 0px;">
                            <%--col-lg-12 col-md-12 col-sm-12--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Credit Card Total List Modal Ends -->
    <!-- Credit Sales List Modal Starts -->
    <div class="modal fade" id="CreditSalesList" aria-hidden="true" aria-labelledby="CreditSalesListModal"
        role="dialog" tabindex="-1">
        <div class="modal-dialog modal-center" style="width: 700px;">
            <div class="modal-content">
                <div class="modal-header">
                    <strong style="font-weight: bold; font-size: 18px;"><span id="spanCreditSalesHead"></span>
                    </strong>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body" style="padding: 0px">
                    <div class="row">
                        <div id="myDivCreditSales" class="modal-body" style="padding-top: 0px; padding-bottom: 0px;">
                            <%--col-lg-12 col-md-12 col-sm-12--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Credit Sales List Modal Ends -->
    <!-- Credit Sales List Modal Starts -->
    <div class="modal fade" id="CreditSalesListTotal" aria-hidden="true" aria-labelledby="CreditSalesListTotalModal"
        role="dialog" tabindex="-1">
        <div class="modal-dialog modal-center" style="width: 700px;">
            <div class="modal-content">
                <div class="modal-header">
                    <strong style="font-weight: bold; font-size: 18px;"><span id="spanCreditSalesTotalHead"></span>
                    </strong>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body" style="padding: 0px">
                    <div class="row">
                        <div id="myDivCreditSalesTotal" class="modal-body" style="padding-top: 0px; padding-bottom: 0px;">
                            <%--col-lg-12 col-md-12 col-sm-12--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Credit Sales List Modal Ends -->
    <asp:HiddenField ID="HFNID" runat="server" />
    <asp:HiddenField ID="HFPID" runat="server" />
    <asp:HiddenField ID="HFCID" runat="server" />
    <asp:HiddenField ID="HFTodayRate" runat="server" />
    <asp:HiddenField ID="HFConfirmShift1" runat="server" />
    <asp:HiddenField ID="HFConfirmShift2" runat="server" />
    <asp:HiddenField ID="HFConfirmShift3" runat="server" />
    <asp:HiddenField ID="HFCurrentRow" runat="server" />
    <asp:HiddenField ID="HFCurrentAspect" runat="server" />
    <asp:HiddenField ID="HFCurrentShift" runat="server" />
    <asp:HiddenField ID="HFIsDeposit" runat="server" />
    <asp:HiddenField ID="HFCashID" runat="server" />
    <asp:HiddenField ID="HFCreditCardID" runat="server" />
    <asp:HiddenField ID="HFCreditSalesID" runat="server" />
    <asp:HiddenField ID="HFCashDepositID" runat="server" />
    <asp:HiddenField ID="HFCurrentStaffName" runat="server" />
    <asp:HiddenField ID="HFCurrentStaffID" runat="server" />
    <asp:HiddenField ID="HFIsDeleteState" runat="server" />
    <asp:HiddenField ID="HFCurrentType" runat="server" />
    <asp:HiddenField ID="HFListOpen" runat="server" />
    <asp:HiddenField ID="HFDayDone" runat="server" />
    <asp:HiddenField ID="HFStationLength" runat="server" />
</asp:Content>
