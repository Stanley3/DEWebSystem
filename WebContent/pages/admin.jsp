<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>���ܹ���-��ʻԱ��ѵ��Ŀ��ģ�⿼��ϵͳ������̨</title>
<link rel="stylesheet" href="../resources/template/css/style.css"
	type="text/css" media="screen" charset="utf-8" />
<link rel="stylesheet"
	href="../resources/easyui/themes/default/easyui.css" type="text/css" />
<link rel="stylesheet" href="../resources/easyui/themes/icon.css"
	type="text/css" />
<script type="text/javascript" src="../resources/js/jquery.min.js"></script>
<script type="text/javascript" src="../resources/js/jquery.easyui.min.js"></script>
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
			$(ed.target).combobox('setValue', roleName); //��ѡ�е�ֵ������Ԫ��
			$('#dg').datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickRow(index) {
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
	function accept() { //update��������
		var completed = false;
		var be = endEditing();
		if (be) {
			var changes = $('#dg').datagrid('getChanges', 'inserted');
			if (changes != null && changes.length != 0) {
				//�����в���
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
				//�����в���
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
				//ɾ���в���
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
		if (rows > 0 && window.confirm("���еĲ�������ȡ�����Ƿ������")) {
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
	//�û�ˢ�»�ر�ҳ��ʱ��ʾ�в���δ����
	window.onbeforeunload = onbeforeunload_handler;
	function onbeforeunload_handler() {
		var rows = $('#dg').datagrid('getChanges').length;
		var warning = "�в���δ���棬�Ƿ�ȷ�ϲ���?";
		if (rows > 0)
			return warning;
		else
			return;
	}
</script>
</head>
<body>
<%String user_name = (String)session.getAttribute("name"); %>
	<div id="header">
		<div class="col w5 bottomlast">
			<a href="" class="logo"> <img
				src="../resources/template/images/logo.gif" alt="Logo" />
			</a>
		</div>
		<div class="col w5 last right bottomlast">
			<p class="last">
				��ǰ�û��� <span class="strong"><%=user_name %></span> <a href="resetPwd.jsp">�޸�����</a> <a href="exit.jsp">�˳�</a>
			</p>
		</div>
		<div class="clear"></div>
	</div>
	<div id="wrapper" style="height:90%">
		<div id="minwidth">
			<div id="holder">
				<div id="menu">
					<div id="left"></div>
					<div id="right"></div>
					<ul>
						<li><a href="vehicle.jsp"><span>��������</span></a></li>
						<li><a href="arrearage.jsp"><span>Ƿ�ѹ���</span></a></li>
						<li><a href="admin.jsp" class="selected"><span>���ܹ���</span></a></li>
						<li><a href="area.jsp"><span>��������</span></a></li>
						<li><a href="guest.jsp"><span>�ͻ�����</span></a></li>
					</ul>
					<div class="clear"></div>
				</div>

				<div class="content2" style="height:90%">
					<table id="dg" 
						data-options="
								rownumbers:true,
								singleSelect:true,
								pagination:true,
								url:'http://localhost:8080/ZHWS/rest/users',
								method:'get',
								toolbar: '#tb',
								onClickRow: onClickRow
							">
						<thead>
							<tr>
								<th
									data-options="field:'user_name',width:80,
									editor:{type:'textbox', options:{required:true}}">�û���</th>
								<th
									data-options="field:'user_role',width:100,
									editor:{	
											type:'combobox',
											options:{
												required: true,
												valueField: 'label',
												textField: 'value',
												data:[
													{label:'admin',value: '����Ա'},
													{label: 'guest', value: '��ͨ�û�'}
												]
											}
									}">�û���ɫ</th>
							</tr>
						</thead>
					</table>
				</div>
				<div id="sDiv" style="display:none">
					<label for="search">�������û�����</label> <input id="sName" name="search"
						class="easyui-textbox" style="width:300px"
						data-options="
								prompt:'�������û���...',
								icons:[{
									iconCls: 'icon-search',
									handler: function(e){
												var name = $(e.data.target).textbox('getValue');
												var role = $('#sRole').textbox('getValue');
												if(name)
													searchAndReload(name, role);
												}

								}]" />
					<br /> <label for="search">�������ɫ��</label> <input id="sRole"
						name="search" class="easyui-textbox" style="width:300px"
						data-options="
								prompt:'�������ɫ...',
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
						data-options="iconCls:'icon-add',plain:true" onclick="append()">����</a>
					<a href="javascript:void(0)" class="easyui-linkbutton"
						data-options="iconCls:'icon-remove',plain:true"
						onclick="removeit()">ɾ��</a> <a href="javascript:void(0)"
						class="easyui-linkbutton"
						data-options="iconCls:'icon-save',plain:true" onclick="accept()">����</a>
					<a href="javascript:void(0)" class="easyui-linkbutton"
						data-options="iconCls:'icon-undo',plain:true" onclick="reject()">ȡ��</a>
					<a href="javascript:void(0)" class="easyui-linkbutton"
						data-options="iconCls:'icon-search',plain:true" onclick="hide()">����</a>
				</div>
				<a href="" class="dropdown_button"><small class="icon plus"></small></a>



				<div class="clear"></div>


				<div class="clear"></div>

				<div class="clear"></div>


				<div id="body_footer">
					<div id="bottom_left">
						<div id="bottom_right"></div>
					</div>
				</div>

			</div>
		</div>
	</div>
	<div id="footer">
		<p class="last" style="align:bottom">
			Copyright 2009 - Gray Admin Template - Created by <a href="">Passatgt</a>
		</p>
	</div>
</body>
</html>