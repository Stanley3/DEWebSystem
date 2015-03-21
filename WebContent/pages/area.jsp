<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>��������-��ʻԱ��ѵ��Ŀ��ģ�⿼��ϵͳ�����̨</title>
<link rel="stylesheet" href="../resources/template/css/style.css"
	type="text/css" media="screen" charset="utf-8" />
<link rel="stylesheet"
	href="../resources/easyui/themes/default/easyui.css" type="text/css" />
<link rel="stylesheet" href="../resources/easyui/themes/icon.css"
	type="text/css" />
<style type="text/css">
.hide {
	display: none
}
</style>
<script type="text/javascript" src="../resources/js/jquery.min.js"></script>
<script type="text/javascript"
	src="../resources/js/jquery.easyui.min.js"></script>
<script type="text/javascript">
	var editIndex = undefined;
	$(function() {
		var pager = $('#dg').datagrid().datagrid('getPager'); // get the pager of datagrid
	});
	function searchAndReload(v) {
		$('#dg').datagrid({
			url : '../rest/areas',
			method : 'get',
			queryParams : {
				address : v
			}
		});
		$('#dg').datagrid('reload');
	}
	function endEditing() {
		if (editIndex == undefined)
			return true;
		if ($('#dg').datagrid('validateRow', editIndex)) {
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
		if (endEditing()) {
			var changes = $('#dg').datagrid('getChanges', 'inserted');
			if (changes != null && changes.length != 0) {
				//�����в���
				var i;
				var completed; //ȷ���ϴε�ajax�ɹ���Ž����´ε�ajax����
				for (i in changes) {
					$.ajax({
						url : '../rest/areas',
						type : 'post',
						dataType : 'text',
						data : {
							address : changes[i].area_address
						},
						success : function(data) {
							if (data != null) {
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
						&& changes[i].area_id != undefined
						&& changes[i].area_id != ""; ++i) {
					url = "../rest/areas/" + changes[i].area_id;
					$.ajax({
						url : url,
						type : 'post',
						dataType : 'text',
						data : {
							address : changes[i].area_address
						},
						success : function(data) {
							if (data != null)
								completed = true;
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
						&& changes[i].area_id != undefined
						&& changes[i].area_id != ""; ++i) {
					$.ajax({
						url : '../rest/areas/' + changes[i].area_id,
						type : 'delete',
						dataType : 'text',
						success : function(data) {
							if (data != 'false') {
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
			<a href="" class="logo"> <img
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
						<li><a href="arrearage.jsp"><span>Ƿ�ѹ���</span></a></li>
						<li><a href="admin.jsp"><span>���ܹ���</span></a></li>
						<li><a href="area.jsp" class="selected"><span>��������</span></a></li>
						<li><a href="guest.jsp"><span>�ͻ�����</span></a></li>
					</ul>
					<div class="clear"></div>
				</div>
				<div class="arrow"></div>
				<div class="content">
					<table id="dg"
						data-options="
								rownumbers:true,
								singleSelect:true,
								pagination:true,
								url:'../rest/areas',
								method:'get',
								toolbar: '#tb',
								onDblClickRow: onDblClickRow,
								onClickCell : onClickCell
								">
						<thead>
							<tr>
								<th data-options="field:'area_id',width:80, hidden:true">����id</th>
								<th
									data-options="field:'area_address',width:100,
									editor:{type:'textbox', options:{required: true}}">��ַ</th>
								<th data-options="field: 'edit', width:50, styler:editStyler">�޸�</th>
							</tr>
						</thead>
					</table>
					<div id="sDiv" style="display:none">
						<label for="search">�������������</label> <input id="search"
							name="search" class="easyui-textbox" style="width:300px"
							data-options="
								prompt:'�����������...',
								icons:[{
									iconCls: 'icon-search',
									handler: function(e){
												var v = $(e.data.target).textbox('getValue');
												if(v)
													searchAndReload(v);
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