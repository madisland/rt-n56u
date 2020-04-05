<!DOCTYPE html>
<html>
<head>
<title><#Web_Title#> - FRP</title>
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
<% frpc_status(); %>
<% frps_status(); %>
$j(document).ready(function() {
    init_itoggle('frpc_enable');
	init_itoggle('frps_enable');

});

</script>
<script>

<% login_state_hook(); %>

function initial(){
	show_banner(2);
	show_menu(5,11);
	showmenu();
	show_footer();

fill_status(frpc_status());
fill_status2(frps_status());
	if (!login_safe())
		textarea_scripts_enabled(0);
}

function textarea_scripts_enabled(v){
	inputCtrl(document.form['scripts.frp_script.sh'], v);
}

function fill_status(status_code){
	var stext = "Unknown";
	if (status_code == 0)
		stext = "<#Stopped#>";
	else if (status_code == 1)
		stext = "<#Running#>";
	$("frpc_status").innerHTML = '<span class="label label-' + (status_code != 0 ? 'success' : 'warning') + '">' + stext + '</span>';
}
function fill_status2(status_code){
	var stext = "Unknown";
	if (status_code == 0)
		stext = "<#Stopped#>";
	else if (status_code == 1)
		stext = "<#Running#>";
	$("frps_status").innerHTML = '<span class="label label-' + (status_code != 0 ? 'success' : 'warning') + '">' + stext + '</span>';
}

function applyRule(){
//	if(validForm()){
		showLoading();
		
		document.form.action_mode.value = " Apply ";
		document.form.current_page.value = "/Advanced_frp.asp";
		document.form.next_page.value = "";
		
		document.form.submit();
//	}
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

	<input type="hidden" name="current_page" value="Advanced_frp.asp">
	<input type="hidden" name="next_page" value="">
	<input type="hidden" name="next_host" value="">
	<input type="hidden" name="sid_list" value="FrpConf;">
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
							<h2 class="box_head round_top"><#menu5_25#> - <#menu5_30#></h2>
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
<li class="active">
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
									<p>frp 是一个可用于内网穿透的高性能的反向代理应用，支持 tcp, udp 协议，为 http 和 https 应用协议提供了额外的能力，且尝试性支持了点对点穿透。
									</p>
									frp项目地址<a href="https://github.com/fatedier/frp" target="blank"><i><u>https://github.com/fatedier/frp</u></i></a>
									</div>

									<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table">
									<tr> <th>frpc<#running_status#></th>
                                            <td id="frpc_status" colspan="2"></td>
                                        </tr>
										<tr> <th>frps<#running_status#></th>
                                            <td id="frps_status" colspan="2"></td>
                                        </tr>
										<tr>
											<th width="30%"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">启用frpc</a></th>
											<td>
													<div class="main_itoggle">
													<div id="frpc_enable_on_of">
														<input type="checkbox" id="frpc_enable_fake" <% nvram_match_x("", "frpc_enable", "1", "value=1 checked"); %><% nvram_match_x("", "frpc_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="frpc_enable" id="frpc_enable_1" class="input" value="1" <% nvram_match_x("", "frpc_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="frpc_enable" id="frpc_enable_0" class="input" value="0" <% nvram_match_x("", "frpc_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
												<tr>
											<th width="30%"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">启用frps</a></th>
											<td>
													<div class="main_itoggle">
													<div id="frps_enable_on_of">
														<input type="checkbox" id="frps_enable_fake" <% nvram_match_x("", "frps_enable", "1", "value=1 checked"); %><% nvram_match_x("", "frps_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="frps_enable" id="frps_enable_1" class="input" value="1"  <% nvram_match_x("", "frps_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="frps_enable" id="frps_enable_0" class="input" value="0"  <% nvram_match_x("", "frps_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr id="row_post_wan_script">
											<td colspan="2" style="border-top: 0 none;">
												<i class="icon-hand-right"></i> <a href="javascript:spoiler_toggle('script2')"><span>frp脚本-请自行配置脚本里的相关参数</span></a>
												<div id="script2" style="display:none;">
													<textarea rows="18" wrap="off" spellcheck="false" maxlength="314571" class="span12" name="scripts.frp_script.sh" style="font-family:'Courier New'; font-size:12px;"><% nvram_dump("scripts.frp_script.sh",""); %></textarea>
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
