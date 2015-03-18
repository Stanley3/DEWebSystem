<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>����ƽ̨</title>
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
		$('#oldPwd').validatebox({
			required : true,
			missingMessage : '������ԭ����'
		});
		$('#newPwd').validatebox({
			required : true,
			missingMessage : '������������'
		});
		$('#agaginNew').validatebox({
			required : true,
			missingMessage : '���ٴ�����������',
			validType : "equals[('#newPwd')]"
		});
		$.extend($.fn.validatebox.defaults.rules, {
			equals : {
				validator : function(value, param) {
					return value == $(param[0]).val();
				},
				message : '�������벻ƥ��.'
			}
		});
	})
</script>
</head>
<body>
	<div id="header">
		<div class="col w5 bottomlast">
			<a href="" class="logo"> <img
				src="../resources/template/images/logo.gif" alt="Logo" />
			</a>
		</div>
		<div class="col w5 last right bottomlast">
			<p class="last">
				��ǰ�û��� <span class="strong">�����</span> <a href="">�޸�����</a> <a href="">�˳�</a>
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
						<li><a href="resetPwd.jsp" class="selected"><span>�޸�����</span></a></li>
					</ul>
				</div>

				<div>
					<form id="reset" method="post" action="resetPwd">
						<table>
							<tr>
								<td><label for="oldPwd">������ԭ���룺</label></td>
								<td><input class="easyui-validatebox" id="oldPwd"
									style="width:200px;hegith=32px" type="password" /></td>
							</tr>
							<tr>
								<td><label for="newPwd">�����������룺</label></td>
								<td><input class="easyui-validatebox" id="newPwd"
									style="width:200px;hegith=32px" type="password" /></td>
							</tr>
							<tr>
								<td><label for="agaginNew">���ٴ����������룺</label></td>
								<td><input class="easyui-validatebox" id="againNew"
									style="width:200px;hegith=32px" type="password" /></td>
							</tr>
							<tr>
								<td colspan="2"><input class="easyui-linkbutton"
									type="submit" id="submit" value="�޸�"
									style="height:32px;width:80px" /> &nbsp;&nbsp; <input
									class="easyui-linkbutton" type="reset" id="reset" value="����"
									style="height:32px;width:80px" "/> &nbsp;&nbsp; <input
									class="easyui-linkbutton" type="button" id="back" value="����"
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