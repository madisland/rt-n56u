<!DOCTYPE html>
<html>
<head>
<title><#Web_Title#> - AdGuard Home</title>
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
<script type="text/javascript" src="/help_b.js"></script>
<script>
var $j = jQuery.noConflict();

$j(document).ready(function() {

	init_itoggle('adg_enable');

});

</script>
<script>

<% login_state_hook(); %>

function initial(){
	show_banner(2);
	show_menu(5,11);
	showmenu();
	show_footer();

	if (!login_safe())
		textarea_scripts_enabled(0);
}

function applyRule(){
//	if(validForm()){
		showLoading();
		
		document.form.action_mode.value = " Apply ";
		document.form.current_page.value = "/Advanced_adguardhome.asp";
		document.form.next_page.value = "";
		
		document.form.submit();
//	}
}

function textarea_scripts_enabled(v){
	inputCtrl(document.form['scripts.adg.sh'], v);
}

function showmenu(){
	showhide_div('ssrlink', found_app_shadowsocks());
	showhide_div('dsflink', found_app_dnsforwarder());
	showhide_div('adblink', found_app_adbyby());
	showhide_div('kplink', found_app_koolproxy());
	showhide_div('sdnslink', found_app_smartdns()); 
	showhide_div('adglink', found_app_adguardhome()); 
	showhide_div('alidnslink', found_app_aliddns()); 
	showhide_div('frplink', found_app_frp());
	showhide_div('caddylink', found_app_caddy());
	showhide_div('sculink', found_app_scutclient());
	showhide_div('menlink', found_app_mentohust());
}

function done_validating(action){
	refreshpage();
}

</script>
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

	<form method="post" name="form" id="ruleForm" action="/start_apply.htm" target="hidden_frame">

	<input type="hidden" name="current_page" value="Advanced_adguardhome.asp">
	<input type="hidden" name="next_page" value="">
	<input type="hidden" name="next_host" value="">
	<input type="hidden" name="sid_list" value="AdguardHomeConf;">
	<input type="hidden" name="group_id" value="">
	<input type="hidden" name="action_mode" value="">
	<input type="hidden" name="action_script" value="">
	<input type="hidden" name="wan_ipaddr" value="<% nvram_get_x("", "wan0_ipaddr"); %>" readonly="1">
	<input type="hidden" name="wan_netmask" value="<% nvram_get_x("", "wan0_netmask"); %>" readonly="1">
	<input type="hidden" name="dhcp_start" value="<% nvram_get_x("", "dhcp_start"); %>">
	<input type="hidden" name="dhcp_end" value="<% nvram_get_x("", "dhcp_end"); %>">

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
							<h2 class="box_head round_top"><#menu5_28#> - <#menu5_29#></h2>
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
<li class="active">
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
<li id="sculink" style="display:none">
<a href="scutclient.asp"><#menu5_13#></a>
</li>
<li id="menlink" style="display:none">
<a href="mentohust.asp"><#menu5_18#></a>
</li>
</ul>
</div>
								<div class="row-fluid">
									<div id="tabMenu" class="submenuBlock"></div>
									<div class="alert alert-info" style="margin: 10px;">
									<p>AdGuard Home 是一款全网广告拦截与反跟踪软件。在您将其安装完毕后，它将保护您所有家用设备，同时您不再需要安装任何客户端软件。随着物联网与连接设备的兴起，掌控您自己的整个网络环境变得越来越重要。
									</p>
									<a href="https://adguard.com/" target="blank">AdGuard Home  主页</a>		&&		<a href="https://github.com/AdguardTeam/AdGuardHome/wiki/Configuration" target="blank">帮助文档</a>
									</div>

									<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table">
										<tr>
											<th width="30%" style="border-top: 0 none;">启用AdGuardHome</th>
											<td style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="adg_enable_on_of">
														<input type="checkbox" id="adg_enable_fake" <% nvram_match_x("", "adg_enable", "1", "value=1 checked"); %><% nvram_match_x("", "adg_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="adg_enable" id="adg_enable_1" class="input" value="1" <% nvram_match_x("", "adg_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="adg_enable" id="adg_enable_0" class="input" value="0" <% nvram_match_x("", "adg_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										</tr>
                                         <tr>
											<th><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 1, 1);">DNS重定向</a></th>
											<td>
												<select name="adg_redirect" class="input" style="width: 200px">
													<option value="0" <% nvram_match_x("","adg_redirect", "0","selected"); %>>无</option>
													<option value="1" <% nvram_match_x("","adg_redirect", "1","selected"); %>>作为dnsmasq的上游服务器</option>
												</select>
											</td>
										</tr>
										<tr>
											<th>WEB管理地址:</th>
											<td>
											<a href="http://<% nvram_get_x("", "lan_ipaddr"); %>:3000" target="_blank">http://<% nvram_get_x("", "lan_ipaddr"); %>:3000</a>
											</td>
										</tr>
										
										<tr id="row_post_wan_script">
											<td colspan="2" style="border-top: 0 none;">
												<i class="icon-hand-right"></i> <a href="javascript:spoiler_toggle('script2')"><span>AdGuardHome脚本</span></a>
												<div id="script2" style="display:none;">
													<textarea rows="18" wrap="off" spellcheck="false" maxlength="314571" class="span12" name="scripts.adg.sh" style="font-family:'Courier New'; font-size:12px;"><% nvram_dump("scripts.adg.sh",""); %></textarea>
												</div>
											</td>
										</tr>

										<tr>
											<td colspan="2" style="border-top: 0 none;">
												<br />
												<center><input class="btn btn-primary" style="width: 219px" type="button" value="<#CTL_apply#>" onclick="applyRule()" /></center>
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

	</form>

	<div id="footer"></div>
</div>
</body>
</html>

