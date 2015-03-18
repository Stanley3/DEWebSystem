<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk" import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder
import javax.ws.rs.client.Entity
import javax.ws.rs.client.WebTarget
import javax.ws.rs.core.Form
import javax.ws.rs.core.MediaType %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>测试平台</title>
<link rel="stylesheet" href="../resources/template/css/style.css"
	type="text/css" media="screen" charset="utf-8" />
<link rel="stylesheet"
	href="../resources/easyui/themes/default/easyui.css" type="text/css" />
<link rel="stylesheet" href="../resources/easyui/themes/icon.css"
	type="text/css" />
<script type="text/javascript" src="../resources/js/jquery.min.js"></script>
<script type="text/javascript"
	src="../resources/js/jquery.easyui.min.js"></script>
<script type="text/javascript">
	$(function() {
		$('#oldPwd').textbox({
			required : true,
			missingMessage : '请输入原密码'
		});
		$('#newPwd').textbox({
			required : true,
			missingMessage : '请输入新密码'
		});
		$('#againNew').textbox({
			required : true,
			missingMessage : '请再次输入新密码',
			validType : "equals[('#newPwd')]"
		});
		$.extend($.fn.validatebox.defaults.rules, {
			equals : {
				validator : function(value, param) {
					return value == $(param[0]).val();
				},
				message : '两次输入不匹配.'
			}
		});
	})
</script>
</head>
<body>
<%boolean equals = false;
	String tips = "";
	String newPwd = request.getParameter("newPwd");
	String oldPwd = request.getParameter("oldPwd");
	if(newPwd != null && !newPwd.isEmpty() && oldPwd != null && !oldPwd.isEmpty()){
		String pwd = (String)session.getAttribute("pwd");
		if(oldPwd.equals(pwd))
			equals = true;
		if(!equals){
			tips = "<label style=\"color:red\">请输入您现在的密码</label>";
			return;
		} 
		request.setAttribute("newPwd", newPwd);
		response.sendRedirect("resetPwd");	
}
%>
	<div id="header">
		<div class="col w5 bottomlast">
			<a href="" class="logo"> <img
				src="../resources/template/images/logo.gif" alt="Logo" />
			</a>
		</div>
		<div class="col w5 last right bottomlast">
			<p class="last">
				当前用户： <span class="strong">李二刀</span> <a href="">修改密码</a> <a href="">退出</a>
			</p>
		</div>
		<div class="clear"></div>
	</div>
	<div id="wrapper">
		<div id="minwidth">
			<div id="holder">
				<div id="menu">
					<div id="left"></div>
					<div id="right"></div>
					<ul>
						<li><a href="resetPwd.jsp" class="selected"><span>修改密码</span></a></li>
					</ul>
				</div>

				<div>
					<form id="reset" method="post" action="resetPwd.jsp">
						<table>
							<tr>
								<td><label for="oldPwd">请输入原密码：</label></td>
								<td><input class="easyui-textbox" id="oldPwd"
									style="width:200px;hegith=32px" type="password" />
									<%=tips %>
									</td>
							</tr>
							<tr>
								<td><label for="newPwd">请输入新密码：</label></td>
								<td><input class="easyui-textbox" id="newPwd"
									style="width:200px;hegith=32px" type="password" /></td>
							</tr>
							<tr>
								<td><label for="againNew">请再次输入新密码：</label></td>
								<td><input class="easyui-textbox" id="againNew"
									style="width:200px;hegith=32px" type="password" /></td>
							</tr>
							<tr>
								<td colspan="2"><input class="easyui-linkbutton"
									type="submit" id="submit" value="修改"
									style="height:32px;width:80px" /> &nbsp;&nbsp; <input
									class="easyui-linkbutton" type="reset" id="reset" value="重置"
									style="height:32px;width:80px" "/> &nbsp;&nbsp; <input
									class="easyui-linkbutton" type="button" id="back" value="返回"
									style="height:32px;width:80px" /></td>
							</tr>
						</table>
					</form>
				</div>

				<div id="body_footer">
					<div id="bottom_left">
						<div id="bottom_right"></div>
					</div>
				</div>

			</div>
		</div>
	</div>
	<div id="footer">
		<p class="last">
			Copyright 2009 - Gray Admin Template - Created by <a href="">Passatgt</a>
		</p>
	</div>
</body>
</html>
