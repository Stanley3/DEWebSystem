<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>管理员登录-驾驶员培训科目三模拟考试系统管理后台</title>
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
<script type="text/javascript" src="pages/js/jquery.min.js"></script>
<script type="text/javascript" src="pages/js/jquery.easyui.min.js"></script>
<script>
	/* function submitForm(){
		$('#login').form({
			url: 'rest/users/validate',
			onSumit:function(param){
				param.name = $('#name').val();
				param.password = $('#password').val();
			},
			success:function(data){
			alert(data);
			 var data = eval('(' + data + ')');
				if(data != null)
					alert("登录成功！" + data.user_id);
				else
					alert("登录失败！");
			}});
			$('#login').submit();
	} */
	function submitForm(){
		if(!$('#login').form('validate'))
			return ;
		$.ajax({
			url: "http://localhost:8080/ZHWS/rest/users/validate",
			type: "post",
			data: {name: $('#name').val(), password:$('#password').val()},
			dataType: "json",
			success:function(data){
				if(data != null && data.user_id != null){
					/* var obj;
					try{
						obj = eval('(' + data + ')');
					}catch(err){
						alert(err + "data的类型为" + typeof(data) + data.user_id);
					}
					if(obj.user_id != null)
						alert("用户" + obj.user_id + "登录成功！");
					else
						alert("登录失败！"); */
					//alert(data.user_role);
					window.location = "pages/area.html"; //路径跳转
				}
				else
					alert("登录失败！");
			},
			error:function(msg){
				alert("登录失败！" + msg.status);
			}
		});
	}
</script>
</head>

<body>
	<table width="100%" border="0" align="center" cellpadding="0"
		cellspacing="0">
		<tr>
			<td height="91" align="center" valign="top" bgcolor="#333333"><table
					width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="60" align="center" bgcolor="#135A84"
							style="padding-left: 20px;"><img
							src="./resources/images/topbg.png" width="700" height="90" /></td>
					</tr>
				</table></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="465" align="center" bgcolor="#135A84"><table
					width="285" border="0" bgcolor="#FFFFFF" cellspacing="5"
					cellpadding="0">
					<tr>
						<td width="285" align="left" valign="top">
							<table width="100%" bgcolor="#f2f2f2" border="0" cellspacing="5"
								cellpadding="0">
								<tr>
									<td valign="top">
										<div class="easyui-panel" title="帐号登录"
											style="width:400px;padding:30px 60px; font-size:18px">
											<form id="login" method="post" action="pages/Test.jsp">
												<div style="margin-bottom:20px">
													用户名： <input class="easyui-textbox"
														style="width:60%;height:32px" name="name" id="name"
														data-options="required:true, missingMessage:'请输入用户名'" type="text"/>
												</div>
												<div style="margin-bottom:20px">
													密&nbsp;&nbsp;&nbsp;码： <input class="easyui-textbox"
														style="width:60%;height:32px" name="password"
														id="password" type="password" data-options="required:true, missingMessage:'请输入密码'" />
												</div>
												<div style="margin-bottom:20px">
													验证码： <input class="easyui-textbox"
														style="width:60%;height:32px" />
												</div>
												<div>
													<a href="javascript:void(0)" class="easyui-linkbutton"
														onclick="submitForm()"
														style="width:100%;height:32px;"><strong style="font-size:16px">登&nbsp;&nbsp;录</strong></a>
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
			<td height="50" align="center" bgcolor="#135A84"
				class="index_jianjie">CopyRight HenanZhonghe，All Rights
				Reserved</td>
		</tr>
	</table>
</body>
</html>
