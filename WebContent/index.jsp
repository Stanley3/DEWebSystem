<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>����Ա��¼-��ʻԱ��ѵ��Ŀ��ģ�⿼��ϵͳ�����̨</title>
<style type="text/css">
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	/* [disabled]margin-bottom: 0px; */
}
</style>
<link href="resources/images/style.css" rel="stylesheet"
	type="text/css" />
<link href="resources/easyui/themes/default/easyui.css" type="text/css"
	rel="stylesheet" />
<link href="resources/easyui/themes/icon.css" type="text/css"
	rel="stylesheet" />
<script type="text/javascript" src="resources/js/jquery.min.js"></script>
<script type="text/javascript" src="resources/js/jquery.easyui.min.js"></script>
</head>

<body>
	<table width="100%" border="0" align="center" cellpadding="0"
		cellspacing="0">
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
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="465" align="center" bgcolor="F0F0F0"><table
					width="285" border="0" bgcolor="#FFFFFF" cellspacing="5"
					cellpadding="0">
					<tr>
						<td width="285" align="left" valign="top">
							<table width="100%" bgcolor="#f2f2f2" border="0" cellspacing="5"
								cellpadding="0">
								<tr>
									<td valign="top">
										<div class="easyui-panel" title="�ʺŵ�¼"
											style="width:400px;padding:30px 60px; font-size:18px">
											<form id="login" method="post" action="LoginServlet">
												<div style="margin-bottom:20px">
													�û����� <input class="easyui-textbox"
														style="width:60%;height:32px" name="name" id="name"
														data-options="required:true, missingMessage:'�������û���'" type="text"/>
												</div>
												<div style="margin-bottom:20px">
													��&nbsp;&nbsp;&nbsp;�룺 <input class="easyui-textbox"
														style="width:60%;height:32px" name="password"
														id="password" type="password" data-options="required:true, missingMessage:'����������'" />
												</div>
												<div style="margin-bottom:20px">
													��֤�룺 <input class="easyui-textbox"
														style="width:60%;height:32px" />
												</div>
												<div>
													<!-- <a href="javascript:void(0)" class="easyui-linkbutton"
														onclick="submitForm()"
														style="width:100%;height:32px;"><strong style="font-size:16px">��&nbsp;&nbsp;¼</strong></a> -->
													<input type="submit" class="easyui-linkbutton" id="submit" style="width:100%;height:32px" value="��¼" />
												</div>
											</form>
										</div>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="50" align="center" bgcolor="#f0f0f0"
				class="index_jianjie">CopyRight HenanZhonghe��All Rights
				Reserved</td>
		</tr>
	</table>
</body>
</html>
