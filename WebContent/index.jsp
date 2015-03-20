<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>管理员登录-驾驶员培训科目三模拟考试系统管理后台</title>
<style type="text/css">
</style>
<link href="resources/images/style.css" type="text/css" rel="stylesheet" />
<link href="resources/easyui/themes/default/easyui.css" type="text/css"
	rel="stylesheet" />
<link href="resources/easyui/themes/icon.css" type="text/css"
	rel="stylesheet" />
<script type="text/javascript" src="resources/js/jquery.min.js"></script>
<script type="text/javascript" src="resources/js/jquery.easyui.min.js"></script>
<script type="text/javascript">
	function login(){
		return $('#login').form('validate');
	}
</script>
</head>

<body>
	<table width="100%" border="0" align="center" cellpadding="0"
		cellspacing="0" height="20%">
		<tr>
			<td height="91" align="center" valign="top" bgcolor="#f0f0f0"><table
					width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="60" align="center" bgcolor="#F0F0F0"
							style="padding-left: 20px;"><img
							src="./resources/images/topbg.png" width="700" height="90" /></td>
					</tr>
				</table></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" height="850px">
		<tr height="100%">
			<td  align="center" bgcolor="F0F0F0"><table
					width="285" border="0" bgcolor="#FFFFFF" cellspacing="5"
					cellpadding="0">
					<tr>
						<td width="285" align="left" valign="top">
							<table width="100%" bgcolor="#f2f2f2" border="0" cellspacing="5"
								cellpadding="0">
								<tr>
									<td valign="top">
										<div class="easyui-panel" title="管理员登录"
											style="width:400px;padding:30px 60px; font-size:18px">
											<form id="login" method="post" action="LoginServlet">
												<div style="margin-bottom:20px">
													<input class="easyui-textbox"
														style="width:100%;height:32px" name="name" id="name"
														data-options="required:true, missingMessage:'请输入用户名', iconCls:'icon-man', iconAlign:'right'" type="text"/>
												</div>
												<div style="margin-bottom:20px">
													 <input class="easyui-textbox"
														style="width:100%;height:32px" name="password" 
														id="password" type="password" data-options="required:true, missingMessage:'请输入密码', iconCls:'icon-lock', iconAlign:'right'" />
												</div>
												<div>
													<!-- <a href="javascript:void(0)" class="easyui-linkbutton"
														onclick="submitForm()"
														style="width:100%;height:32px;"><strong style="font-size:16px">登&nbsp;&nbsp;录</strong></a> -->
													<input type="submit" class="easyui-linkbutton" id="submit" onclick="return login();" style="width:100%;height:32px" value="登录" />
												</div>
											</form>
										</div>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" height="10%">
		<tr>
			<td align="center" bgcolor="#f0f0f0"
				class="index_jianjie">CopyRight HenanZhonghe，All Rights
				Reserved</td>
		</tr>
	</table>
</body>
</html>
