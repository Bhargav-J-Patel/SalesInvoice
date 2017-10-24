<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AcYearSelection.aspx.cs"
    Inherits="AcYearSelection"  EnableEventValidation="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Account Year Selection</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <meta content="" name="description" />
    <meta content="" name="author" />
    <!-- BEGIN GLOBAL MANDATORY STYLES -->
    <link href="assets/assets/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet"
        type="text/css" />
    <link href="assets/assets/plugins/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet"
        type="text/css" />
    <link href="assets/assets/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet"
        type="text/css" />
    <link href="assets/assets/css/style-metro.css" rel="stylesheet" type="text/css" />
    <link href="assets/assets/css/style.css" rel="stylesheet" type="text/css" />
    <link href="assets/assets/css/style-responsive.css" rel="stylesheet" type="text/css" />
    <link href="assets/assets/css/themes/default.css" rel="stylesheet" type="text/css"
        id="style_color" />
    <!--<link href="assets/plugins/uniform/css/uniform.default.css" rel="stylesheet" type="text/css"/>-->
    <link rel="stylesheet" type="text/css" href="assets/assets/plugins/select2/select2_metro.css" />
    <!-- END GLOBAL MANDATORY STYLES -->
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link href="assets/assets/css/pages/login-soft.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .roundedDJ
        {
            border-radius: 3px !important;
        }
        
        
        .dropdownDJ
        {
            padding-left: 35px;
        }
        
        .dropdownDJ:focus
        {
            border: 1px solid red;
        }
    </style>
</head>
<body class="login">
    <form id="form1" runat="server">
    <!-- BEGIN LOGO -->
    <div class="logo">
        <!-- PUT YOUR LOGO HERE -->
    </div>
    <!-- END LOGO -->
    <!-- BEGIN ACC YEAR -->
    <div class="content">
        <!-- BEGIN ACC YEAR FORM -->
        <form class="form-vertical login-form" action="" method="post">
        <h3 class="form-title" id="h3lbl" style="text-align: center; font-weight: bold;">
        </h3>
        <div class="alert alert-error errorClose" style="display: none;">
            <button class="close" data-dismiss="alert" style="top: 5px;">
            </button>
            <span id="spanError"></span>
        </div>
        <div class="control-group">
            <label class="control-label visible-ie8 visible-ie9">
                Branch</label>
            <div class="controls">
                <div class="input-icon left">
                    <i class="icon-building"></i>
                    <asp:DropDownList runat="server" ID="DDLBranch" class="m-wrap placeholder-no-fix EnterDJ roundedDJ dropdownDJ"
                        TabIndex="1" Style="width: 100%;" DataTextField="cName" DataValueField="NID">
                    </asp:DropDownList>
                </div>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label visible-ie8 visible-ie9">
                Year</label>
            <div class="controls">
                <div class="input-icon left">
                    <i class="icon-calendar"></i>
                    <asp:DropDownList runat="server" ID="DDLYear" class="m-wrap placeholder-no-fix EnterDJ roundedDJ dropdownDJ"
                        TabIndex="2" Style="width: 100%;">
                        <asp:ListItem>2017 - 2018</asp:ListItem>
                        <asp:ListItem>2016 - 2017</asp:ListItem>
                        <asp:ListItem>2015 - 2016</asp:ListItem>
                        <asp:ListItem>2014 - 2025</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
        </div>
         <div class="form-actions loginDetails">


            <asp:Button runat="server" ID="BtnSave" class="btn blue pull-right EnterDJ" 
                Text="Submit" onclick="BtnSave_Click"/> 

        </div>
        </form>
        <!-- END ACC YEAR -->
    </div>
    <!-- END LOGIN -->
    </form>
    <!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
    <!-- BEGIN CORE PLUGINS -->
    <script src="assets/assets/plugins/jquery-1.10.1.min.js" type="text/javascript"></script>
    <script src="assets/assets/plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
    <!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
    <script src="assets/assets/plugins/jquery-ui/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>
    <script src="assets/assets/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <!--<script src="assets/plugins/bootstrap-hover-dropdown/twitter-bootstrap-hover-dropdown.min.js"
        type="text/javascript"></script>-->
    <!--[if lt IE 9]>
	<script src="assets/plugins/excanvas.min.js"></script>
	<script src="assets/plugins/respond.min.js"></script>  
	<![endif]-->
    <script src="assets/assets/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
    <script src="assets/assets/plugins/jquery.blockui.min.js" type="text/javascript"></script>
    <script src="assets/assets/plugins/jquery.cookie.min.js" type="text/javascript"></script>
    <!--<script src="assets/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>-->
    <!-- END CORE PLUGINS -->
    <!-- BEGIN PAGE LEVEL PLUGINS -->
    <script src="assets/assets/plugins/jquery-validation/dist/jquery.validate.min.js"
        type="text/javascript"></script>
    <script src="assets/assets/plugins/backstretch/jquery.backstretch.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="assets/assets/plugins/select2/select2.min.js"></script>
    <!-- END PAGE LEVEL PLUGINS -->
    <!-- BEGIN PAGE LEVEL SCRIPTS -->
    <script src="assets/assets/scripts/app.js" type="text/javascript"></script>
    <script src="assets/assets/scripts/login-soft.js" type="text/javascript"></script>
    <!-- END PAGE LEVEL SCRIPTS -->
</body>
</html>
