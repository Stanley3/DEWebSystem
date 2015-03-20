<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>超管管理-驾驶员培训科目三模拟考试系统管理后台</title>
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
	var editIndex = undefined;
	$(function() {
		var pager = $('#dg').datagrid().datagrid('getPager'); // get the pager of datagrid
	});
	function searchAndReload(name, role) {
		$('#dg').datagrid({
			url : 'http://localhost:8080/ZHWS/rest/users',
			method : 'get',
			queryParams : {
				name : name,
				role : role
			}
		});
		$('#dg').datagrid('reload');
	}
	function endEditing() {
		if (editIndex == undefined)
			return true;
		if ($('#dg').datagrid('validateRow', editIndex)) {
			var ed = $('#dg').datagrid('getEditor', {
				index : editIndex,
				field : 'user_role'
			});
			var roleName = $(ed.target).combobox('getText');
			$(ed.target).combobox('setValue', roleName); //将选中的值赋给单元格
			$('#dg').datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onDblClickRow(index) {
		if (editIndex != index) {
			if (endEditing()) {
				$('#dg').datagrid('selectRow', index).datagrid('beginEdit',
						index);
				editIndex = index;
			} else {
				$('#dg').datagrid('selectRow', editIndex);
			}
		}
	}
	function append() {
		if (endEditing()) {
			$('#dg').datagrid('appendRow', {});
			editIndex = $('#dg').datagrid('getRows').length - 1;
			$('#dg').datagrid('selectRow', editIndex).datagrid('beginEdit',
					editIndex);
		}
	}
	function removeit() {
		if (editIndex == undefined)
			return;
		$('#dg').datagrid('cancelEdit', editIndex).datagrid('deleteRow',
				editIndex);
		//var row = $('#dg').datagrid('getSelected');
		editIndex = undefined;
	}
	function accept() { //update到服务器
		var completed = false;
		var be = endEditing();
		if (be) {
			var changes = $('#dg').datagrid('getChanges', 'inserted');
			if (changes != null && changes.length != 0) {
				//新增行操作
				var i;
				for (i in changes) {
					$.ajax({
						url : 'http://localhost:8080/ZHWS/rest/users',
						type : 'post',
						dataType : 'text',
						data : {
							name : changes[i].user_name,
							password : '123456',
							role : changes[i].user_role
						},
						beforeSend : function(request) {
							completed = false;
						},
						success : function(data) {
							if (data != "false") {
								completed = true;
							}
						},
						error : function(msg) {
							alert(msg);
						}
					});
				}
			}
			changes = null;
			changes = $('#dg').datagrid('getChanges', 'updated');
			if (changes != null && changes.length != 0) {
				//更新行操作
				var i;
				var url = "";
				for (i = 0; i < changes.length
						&& changes[i].user_id != undefined
						&& changes[i].user_id != ""; ++i) {
					url = "http://localhost:8080/ZHWS/rest/users/"
							+ changes[i].user_id;
					$.ajax({
						url : url,
						type : 'post',
						dataType : 'text',
						data : {
							name : changes[i].user_name,
							role : changes[i].user_role
						},
						beforeSend : function(request) {
							completed = false;
						},
						success : function(data) {
							if (data != "false") {
								completed = true;
							}
						},
						error : function(msg) {
							alert(msg.getStatus());
						}
					});
				}
			}
			changes = $('#dg').datagrid('getChanges', 'deleted');
			if (changes != null && changes.length != 0) {
				//删除行操作
				var i;
				for (i = 0; i < changes.length
						&& changes[i].user_id != undefined
						&& changes[i].user_id != ""; ++i) {
					$.ajax({
						url : 'http://localhost:8080/ZHWS/rest/users/'
								+ changes[i].user_id,
						type : 'delete',
						dataType : 'text',
						beforeSend : function(request) {
							completed = false;
						},
						success : function(data) {
							if (data != "false") {
								completed = true;
							}
						},
						error : function(msg) {
							alert(msg.getStatus());
						}
					});
				}
			}
			$('#dg').datagrid('acceptChanges');
		}
	}
	function reject() {
		var rows = $('#dg').datagrid('getChanges').length;
		if (rows > 0 && window.confirm("所有的操作将被取消，是否继续？")) {
			$('#dg').datagrid('rejectChanges');
			editIndex = undefined;
		}
	}
	function hide() {
		var hide = $('#sDiv').css('display');
		if (hide == 'none')
			$('#sDiv').css('display', 'block');
		else
			$('#sDiv').css('display', 'none');
	}
	//用户刷新或关闭页面时提示有操作未保存
	window.onbeforeunload = onbeforeunload_handler;
	function onbeforeunload_handler() {
		var rows = $('#dg').datagrid('getChanges').length;
		var warning = "有操作未保存，是否确认操作?";
		if (rows > 0)
			return warning;
		else
			return;
	}
	
	function onClickCell(index){
		onDblClickRow(index);
	}
	function editStyler(value, row, index){
		return 'background: url(../resources/images/edit.png) no-repeat center';
	}
</script>
</head>
<body>
	<%
		String user_name = (String) session.getAttribute("name");
	%>
	<div id="header">
		<div class="col w5 bottomlast">
			<a href="" class="logo"> <img
				src="../resources/template/images/logo.gif" alt="Logo" />
			</a>
		</div>
		<div class="col w5 last right bottomlast">
			<p class="last">
				当前用户： <span class="strong"><%=user_name%></span> <a
					href="resetPwd.jsp">修改密码</a> <a href="exit.jsp">退出</a>
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
						<li><a href="vehicle.jsp"><span>车辆管理</span></a></li>
						<li><a href="arrearage.jsp"><span>欠费管理</span></a></li>
						<li><a href="admin.jsp" class="selected"><span>超管管理</span></a></li>
						<li><a href="area.jsp"><span>地区管理</span></a></li>
						<li><a href="guest.jsp"><span>客户管理</span></a></li>
					</ul>
					<div class="clear"></div>
				</div>

				<div class="content">
					<table id="dg"
						data-options="
								rownumbers:true,
								singleSelect:true,
								pagination:true,
								url:'http://localhost:8080/ZHWS/rest/users',
								method:'get',
								toolbar: '#tb',
								onDblClickRow: onDblClickRow,
								onClickCell : onClickCell
							">
						<thead>
							<tr>
								<th
									data-options="field:'user_name',width:80,
									editor:{type:'textbox', options:{required:true}}">用户名</th>
								<th
									data-options="field:'user_role',width:100,
									editor:{	
											type:'combobox',
											options:{
												required: true,
												valueField: 'label',
												textField: 'value',
												data:[
													{label:'admin',value: '管理员'},
													{label: 'guest', value: '普通用户'}
												]
											}
									}">用户角色</th>
								<th data-options="field: 'edit', width:50, styler:editStyler">修改</th>
							</tr>
						</thead>
					</table>

					<div id="sDiv" style="display:none">
						<label for="search">请输入用户名：</label> <input id="sName"
							name="search" class="easyui-textbox" style="width:300px"
							data-options="
								prompt:'请输入用户名...',
								icons:[{
									iconCls: 'icon-search',
									handler: function(e){
												var name = $(e.data.target).textbox('getValue');
												var role = $('#sRole').textbox('getValue');
												if(name)
													searchAndReload(name, role);
												}

								}]" />
						<br /> <label for="search">请输入角色：</label> <input id="sRole"
							name="search" class="easyui-textbox" style="width:300px"
							data-options="
								prompt:'请输入角色...',
								icons:[{
									iconCls: 'icon-search',
									handler: function(e){
												var role = $(e.data.target).textbox('getValue');
												var name = $('#sName').textbox('getValue');
												if(role)
													searchAndReload(name, role);
												}

								}]" />
					</div>
					<div id="tb" style="height:auto">
						<a href="javascript:void(0)" class="easyui-linkbutton"
							data-options="iconCls:'icon-add',plain:true" onclick="append()">添加</a>
						<a href="javascript:void(0)" class="easyui-linkbutton"
							data-options="iconCls:'icon-remove',plain:true"
							onclick="removeit()">删除</a> <a href="javascript:void(0)"
							class="easyui-linkbutton"
							data-options="iconCls:'icon-save',plain:true" onclick="accept()">保存</a>
						<a href="javascript:void(0)" class="easyui-linkbutton"
							data-options="iconCls:'icon-undo',plain:true" onclick="reject()">取消</a>
						<a href="javascript:void(0)" class="easyui-linkbutton"
							data-options="iconCls:'icon-search',plain:true" onclick="hide()">搜索</a>
					</div>

					<div id="body_footer">
						<div id="bottom_left">
							<div id="bottom_right"></div>
						</div>
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