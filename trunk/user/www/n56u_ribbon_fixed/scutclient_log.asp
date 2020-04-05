<!DOCTYPE html>
<html>
<head>
<title><#Web_Title#> - <#menu5_13#></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">

<link rel="shortcut icon" href="images/favicon.ico">
<link rel="icon" href="images/favicon.png">
<link rel="stylesheet" type="text/css" href="/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/bootstrap/css/main.css">
<link rel="stylesheet" type="text/css" href="/bootstrap/css/engage.itoggle.css">

<script type="text/javascript" src="/jquery.js"></script>
<script type="text/javascript" src="/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/bootstrap/js/engage.itoggle.min.js"></script>
<script type="text/javascript" src="/state.js"></script>
<script type="text/javascript" src="/general.js"></script>
<script type="text/javascript" src="/itoggle.js"></script>
<script type="text/javascript" src="/popup.js"></script>
<script type="text/javascript" src="/help.js"></script>

<script>
var $j = jQuery.noConflict();

$j(document).ready(function(){
	var textArea = E('textarea');
	textArea.scrollTop = textArea.scrollHeight;
});

function initial(){
	show_banner(2);
	show_menu(5,11);
	showmenu();
	show_footer();
}
</script>

<style>
.nav-tabs > li > a {
    padding-right: 6px;
    padding-left: 6px;
}
</style>
</head>

<body onload="initial();" onunLoad="return unload_body();">

<div class="wrapper">
    <div class="container-fluid" style="padding-right: 0px">
        <div class="row-fluid">
            <div class="span3"><center><div id="logo"></div></center></div>
            <div class="span9" >
                <div id="TopBanner"></div>
            </div>
        </div>
    </div>

    <div id="Loading" class="popup_bg"></div>

    <iframe name="hidden_frame" id="hidden_frame" src="" width="0" height="0" frameborder="0"></iframe>

    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span3">
                <!--Sidebar content-->
                <!--=====Beginning of Main Menu=====-->
                <div class="well sidebar-nav side_nav" style="padding: 0px;">
                    <ul id="mainMenu" class="clearfix"></ul>
                    <ul class="clearfix">
                        <li>
                            <div id="subMenu" class="accordion"></div>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="span9">
                <!--Body content-->
                <div class="row-fluid">
                    <div class="span12">
                        <div class="box well grad_colour_dark_blue">
                            <h2 class="box_head round_top"><#menu5_13#></h2>
                            <div class="round_bottom">
<div>
<ul class="nav nav-tabs" style="margin-bottom: 10px;">
<li id="ssrlink" style="display:none">
<a href="Shadowsocks.asp"><#menu5_16#></a>
</li>
<li id="dsflink" style="display:none">
<a href="dns-forwarder.asp"><#menu5_15#></a>
</li>
<li id="adblink" style="display:none">
<a href="Advanced_adbyby.asp"><#menu5_20_1#></a>
</li>
<li id="kplink" style="display:none">
<a href="Advanced_koolproxy.asp"><#menu5_26_1#></a>
</li>
<li id="sdnslink" style="display:none">
<a href="Advanced_smartdns.asp"><#menu5_24#></a>
</li>
<li id="adglink" style="display:none">
<a href="Advanced_adguardhome.asp"><#menu5_28#></a>
</li>
<li id="alidnslink" style="display:none">
<a href="Advanced_aliddns.asp"><#menu5_23#></a>
</li>
<li id="frplink" style="display:none">
<a href="Advanced_frp.asp"><#menu5_25#></a>
</li>
<li id="caddylink" style="display:none">
<a href="Advanced_caddy.asp"><#menu5_27#></a>
</li>
<li class="active">
<a href="scutclient.asp"><#menu5_13#></a>
</li>
<li class="active">
<a href="scutclient_log.asp"><#menu5_13#></a>
</li>
<li id="menlink" style="display:none">
<a href="mentohust.asp"><#menu5_18#></a>
</li>
<li id="menllink" style="display:none">
<a href="mentohust_log.asp"><#menu5_18#></a>
</li>
</ul>
</div>
                                <div class="row-fluid">
                                    <div id="tabMenu" class="submenuBlock"></div>
                                    <table width="100%" cellpadding="4" cellspacing="0" class="table">
                                        <tr>
                                            <td colspan="3" style="border-top: 0 none; padding-bottom: 0px;">
                                                <textarea rows="21" class="span12" style="height:377px; font-family:'Courier New', Courier, mono; font-size:13px;" readonly="readonly" wrap="off" id="textarea"><% nvram_dump("scutclient.log",""); %></textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="15%" style="text-align: left; padding-bottom: 0px;">
                                                <input type="button" onClick="location.href=location.href" value="<#CTL_refresh#>" class="btn btn-primary" style="width: 170px">
                                            </td>
                                            <td width="15%" style="text-align: left; padding-bottom: 0px;">
                                                <input type="button" onClick="location.href='scutclient.log'" value="<#CTL_onlysave#>" class="btn btn-success" style="width: 170px">
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="footer"></div>
</div>
</body>
</html>
