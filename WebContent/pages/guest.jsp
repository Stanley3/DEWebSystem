<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>�ͻ���¼-��ʻԱ��ѵ��Ŀ��ģ�⿼��ϵͳ�����̨</title>
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
		var pager = $('#dg').datagrid().datagrid('getPager');
	});// get the pager of datagrid
	var editIndex = undefined;
	var area_id = null; //����ѡ��ĵ�����id
	var itemChanged = false;
	function searchAndReload(name, cellphone, address) {
		$('#dg').datagrid({
			url : '../rest/guests',
			method : 'get',
			queryParams : {
				name : name,
				cellphone : cellphone,
				address : address
			}
		});
		$('#dg').datagrid('reload');
	}
	function endEditing() {
		if (editIndex == undefined)
			return true;
		if ($('#dg').datagrid('validateRow', editIndex)) {
			if (itemChanged) {
				var ed = $('#dg').datagrid('getEditor', {
					index : editIndex,
					field : 'area_address'
				});
				var address = $(ed.target).combobox('getText');
				area_id = $(ed.target).combobox('getValue');
				$(ed.target).combobox('setValue', address); //��ѡ�е�ֵ������Ԫ��
			}
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
	function accept() { //update��������
		/* try{ */
		if (endEditing()) {
			var changes = $('#dg').datagrid('getChanges', 'inserted');
			if (changes != null && changes.length != 0) {
				//�����в���
				var i;
				var completed; //ȷ���ϴε�ajax�ɹ���Ž����´ε�ajax����
				for (i in changes) {
					$.ajax({
						url : '../rest/guests',
						type : 'post',
						dataType : 'text',
						data : {
							name : changes[i].guest_name,
							cellphone : changes[i].guest_cellphone,
							fixedline : changes[i].guest_fixedline,
							area : area_id
						},
						success : function(data) {
							if (data != null) {
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
						&& changes[i].guest_id != undefined
						&& changes[i].guest_id != ""; ++i) {
					url = "../rest/guests/" + changes[i].guest_id;
					$.ajax({
						url : url,
						type : 'post',
						dataType : 'text',
						data : {
							name : changes[i].guest_name,
							cellphone : changes[i].guest_cellphone,
							fixedline : changes[i].guest_fixedline,
							area : area_id
						},
						success : function(data) {
							if (data != null) {
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
						&& changes[i].guest_id != undefined
						&& changes[i].guest_id != ""; ++i) {
					$.ajax({
						url : '../rest/guests/' + changes[i].guest_id,
						type : 'delete',
						dataType : 'text',
						success : function(data) {
							if (data != 'false') {
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
		/* }catch(err){
			alert(err);
		} */

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
	function onSelect() {
		itemChanged = true;
	}

	function onClickCell(index) {
		if (field == 'edit')
			onDblClickRow(index);
	}
	function editStyler(value, row, index) {
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
			<a href="vehicle.jsp" class="logo"> <img
				src="../resources/template/images/logo.gif" alt="Logo" />
			</a>
		</div>
		<div class="col w5 last right bottomlast">
			<p class="last">
				��ǰ�û��� <span class="strong"><%=user_name%></span> <a
					href="resetPwd.jsp">�޸�����</a> <a href="exit.jsp">�˳�</a>
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
						<li><a href="vehicle.jsp"><span>��������</span></a></li>
						<!-- <li><a href="arrearage.jsp"><span>Ƿ�ѹ���</span></a></li> -->
						<li><a href="admin.jsp"><span>���ܹ���</span></a></li>
						<li><a href="area.jsp"><span>��������</span></a></li>
						<li><a href="guest.jsp" class="selected"><span>�ͻ�����</span></a></li>
					</ul>
					<div class="clear"></div>
				</div>

				<div class="content">
					<table id="dg"
						data-options="
						rownumbers:true,
						singleSelect:true,
						pagination:true,
						url:'../rest/guests',
						method:'get',
						toolbar: '#tb',
						onDblClickRow: onDblClickRow,
						onClickCell: onClickCell
						">
						<thead>
							<tr>
								<th
									data-options="field:'guest_name',width:80,
									editor:{
										type: 'textbox',
										options: {
											missingMessage: '������ͻ�����',
											required:true
										}
									}">����</th>
								<th
									data-options="field:'guest_cellphone',width:100,
									editor:{
										type: 'numberbox',
										options: {
											missingMessage: '������ͻ��ֻ��ţ�',
											required:true
										}
									}">�ͻ��ֻ���</th>
								<th
									data-options="field:'guest_fixedline', width:100,
									editor:{
										type: 'numberbox',
										options: {
											missingMessage: '������ͻ��̶��绰�ã���ѡ����'
										}
									}">�̶��绰��</th>
								<th
									data-options="field: 'area_address', width: 100,
									editor:{
										type: 'combobox',
										options:{
											required: true,
											missingMessage: '��ѡ��ͻ���ַ',
											valueField: 'area_id',
											textField: 'area_address',
											url: '../rest/areas',
											method: 'get',
											onSelect : onSelect
										}
									}">�ͻ���ַ</th>
								<th data-options="field: 'edit', width:50, styler:editStyler">�޸�</th>
							</tr>
						</thead>
					</table>
					<div id="sDiv" style="display:none">
						<label for="search">������ͻ�������</label> <input id="sName"
							name="search" class="easyui-textbox" style="width:300px"
							data-options="
								prompt:'������ͻ�����...',
								icons:[{
									iconCls: 'icon-search',
									handler: function(e){
												var name = $(e.data.target).textbox('getValue');
												var cellphone = $('#sCellphone').textbox('getValue');
												var address = $('#sAddress').textbox('getValue');
												if(name)
													searchAndReload(name, cellphone, address);
												}

								}]" />
						<br /> <label for="search">������ͻ��ֻ��ţ�</label> <input
							id="sCellphone" name="search" class="easyui-numberbox"
							style="width:300px"
							data-options="
								prompt:'������ͻ��ֻ���...',
								icons:[{
									iconCls: 'icon-search',
									handler: function(e){
												var cellphone = $(e.data.target).textbox('getValue');
												var name = $('#sName').textbox('getValue');
												var address = $('#sAddress').textbox('getValue');
												if(cellphone)
													searchAndReload(name, cellphone, address);
												}

								}]" />
						<br /> <label for="search">������ͻ���ַ��</label> <input id="sAddress"
							name="search" class="easyui-textbox" style="width:300px"
							data-options="
								prompt:'������ͻ���ַ...',
								icons:[{
									iconCls: 'icon-search',
									handler: function(e){
												var address = $(e.data.target).textbox('getValue');
												var name = $('#sName').textbox('getValue');
												var cellphone = $('#sCellphone').textbox('getValue');
												if(address)
													searchAndReload(name, cellphone, address);
												}

								}]" />
					</div>

					<div id="tb" style="height:auto">
						<a href="javascript:void(0)" class="easyui-linkbutton"
							data-options="iconCls:'icon-add',plain:true" onclick="append()">���</a>
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
	</div>
	<div id="footer">
		<p class="last">
			Copyright 2009 - Gray Admin Template - Created by <a href="">Passatgt</a>
		</p>
	</div>
</body>
</html>