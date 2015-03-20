<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>��������-��ʻԱ��ѵ��Ŀ��ģ�⿼��ϵͳ�����̨</title>
<style type="text/css">
	th{
		height: 60px;
	}
</style>
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
		var pager = $('#dg').datagrid().datagrid('getPager'); // get the pager of datagrid
	});
	var editIndex = undefined;
	var guest_id = null;
	var itemChanged = false;
	function searchAndReload() {
		var vin = $('#sVin').textbox('getValue');
		var sn = $('#sSn').textbox('getValue');
		var phone = $('#sVphone').textbox('getValue');
		var area = $('#sArea').combobox('getValue');
		var lock = $('#sLock').combobox('getValue');
		if (vin || sn || phone || area || lock) {
			alert("vin=" + vin + ", sn=" + ", " + phone + ", area=" + area
					+ ", lock=" + lock);
			$('#dg').datagrid({
				url : 'http://localhost:8080/ZHWS/rest/vehicles',
				method : 'get',
				queryParams : {
					vin : vin,
					sn : sn,
					phone : phone,
					area : area,
					lock : lock
				}
			});
			$('#dg').datagrid('reload');
		}
	}
	function endEditing() {
		if (editIndex == undefined)
			return true;
		if ($('#dg').datagrid('validateRow', editIndex)) {
			if (itemChanged) {//combobox��ѡ���Ÿı�guset_id��ֵ������ʹ�ó�ʼֵ
				var ed = $('#dg').datagrid('getEditor', {
					index : editIndex,
					field : 'guest_name'
				});
				var name = $(ed.target).combobox('getText');
				guest_id = $(ed.target).combobox('getValue');
				$(ed.target).combobox('setValue', name); //��ѡ�е�ֵ������Ԫ��
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
						url : 'http://localhost:8080/ZHWS/rest/vehicles',
						type : 'post',
						dataType : 'text',
						data : {
							sn : changes[i].vehicle_sn,
							vin : changes[i].vehicle_vin,
							phone : changes[i].vehicle_phone,
							guest : guest_id,
							status : 0, //0��ʾδ����
							lock : 0, //0��ʾδ����
							remark : changes[i].vehicle_remark,
							arrearage : changes[i].vehicle_arrearage
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
						&& changes[i].vehicle_id != undefined
						&& changes[i].vehicle_id != ""; ++i) {
					url = "http://localhost:8080/ZHWS/rest/vehicles/"
							+ changes[i].vehicle_id;
					$.ajax({
						url : url,
						type : 'post',
						dataType : 'text',
						data : {
							sn : changes[i].vehicle_sn,
							vin : changes[i].vehicle_vin,
							phone : changes[i].vehicle_phone,
							guest : guest_id,
							lock : changes[i].vehicle_lock, //0��ʾδ����
							remark : changes[i].vehicle_remark,
							arrearage : changes[i].vehicle_arrearage
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
						&& changes[i].vehicle_id != undefined
						&& changes[i].vehicle_id != ""; ++i) {
					$.ajax({
						url : 'http://localhost:8080/ZHWS/rest/vehicles/'
								+ changes[i].vehicle_id,
						type : 'delete',
						dataType : 'text',
						success : function(data) {
							if (data != 'false') {
							}
						},
						error : function(msg) {
							alert(msg);
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
		//��combobox��ѡ��ʱ������itemChanged��ֵΪtrue
		itemChanged = true;
	}
	function editStyler(value, row, index){
		return 'background: url(../resources/images/edit.png) no-repeat center';
	}
	function msgStyler(value, row, index){
		return 'background: url(../resources/images/sms.png) no-repeat center';
	}
	function posStyler(value, row, index){
		return 'background: url(../resources/images/map.png) no-repeat center';
	}
	function statusStyler(value, row, index){
		if(value == 0){
			return 'background: url(../resources/images/off.png) no-repeat center;color:#ffffff';
		} else if(value > 0){
			return 'background: url(../resources/images/on.png) no-repeat center;color:#ffffff';
		}
	}
	function lockStyler(value, row, index){
		if(value == 0){
			return 'background: url(../resources/images/unlock.png) no-repeat center;color:#ffffff';
		}else if(value > 0){
			return 'background: url(../resources/images/lock.png) no-repeat center;color:#ffffff';
		}
	}
	function onClickCell(index, field, value){
		if(field == 'edit')
			onDblClickRow(index);
		else if(field == 'sendMsg'){
			//�˴�д������Ϣ��صĴ��룬Ӧ����һ��ajax����
		}else if(field == 'position'){
			//�˴�д��λ��صĴ��룬Ӧ�ô�һ���µĽ���
		}
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
						<li><a href="vehicle.jsp" class="selected"><span>��������</span></a></li>
						<li><a href="arrearage.jsp"><span>Ƿ�ѹ���</span></a></li>
						<li><a href="admin.jsp"><span>���ܹ���</span></a></li>
						<li><a href="area.jsp"><span>��������</span></a></li>
						<li><a href="guest.jsp"><span>�ͻ�����</span></a></li>
					</ul>
					<div class="clear"></div>
				</div>

				<div class="content">
					<table id="dg"
						data-options="
						rownumbers:true,
						singleSelect:true,
						pagination:true,
						url:'http://localhost:8080/ZHWS/rest/vehicles',
						method:'get',
						toolbar: '#tb',
						onDblClickRow : onDblClickRow,
						onClickCell : onClickCell
						">
						<thead height="100px">
							<tr>
								<th data-options="field:'vehicle_id',width:100,hidden:true">�ͻ��绰</th>
								<th
									data-options="field:'vehicle_sn',width:80, 
									editor:{
										type: 'numberbox',
										options : {
											required : true,
											missingMessage : '�������Ʒ���'
										}
									}">��Ʒ���</th>
								<th
									data-options="field:'vehicle_vin',width:100, 
									editor:{
										type: 'textbox',
										options : {
											required : true,
											missingMessage : '�����복�ܺ�'
										}
									}">���ܺ�</th>
								<th
									data-options="field:'vehicle_phone',width:100,
									editor:{
										type: 'numberbox',
										options : {
											required : true,
											missingMessage : '����������ֻ���'
										}
									}">�����ֻ���</th>
								<th
									data-options="field:'guest_name',width:100, 
									editor:{
										type: 'combobox',
										options : {
											required : true,
											missingMessage : '��ѡ��ͻ�',
											valueField: 'guest_id',
											textField: 'guest_name',
											url : 'http://localhost:8080/ZHWS/rest/guests',
											method : 'get' ,
											onSelect : onSelect
										}
									}">�ͻ�����</th>
								<th data-options="field:'guest_cellphone',width:100">�ͻ��绰</th>
								<th data-options="field:'vehicle_status',width:100, styler: statusStyler">����</th>
								<th
									data-options="field:'vehicle_lock',width:100, styler: lockStyler,
									editor:{
										type: 'combobox',
										options : {
											required : true,
											missingMessage : '������������Ϣ',
											valueField: 'code',
											textField: 'status',
											data: [
												{code: 0, status: 'δ����'},
												{code: 1, status: '����'}
											]
										}
									}">����</th>
								<th data-options="field:'area_address',width:100">���ڵ���</th>
								<th data-options="field:'vehicle_version',width:100">��ǰ�汾</th>
								<th
									data-options="field:'vehicle_arrearage',width:100, 
									editor:{
										type: 'numberbox',
										options : {
											required : true,
											missingMessage : '������Ƿ����Ϣ��0��ʾδǷ��',
											min : 0,
											precision : 2
										}
									}">Ƿ��</th>
								<th
									data-options="field:'vehicle_remark', width:300,
									editor:{
										type: 'textbox',
										options : {
											mutiline: true
										}
									}">��ע</th>
								<th data-options="field: 'sendMsg', width:50, styler:msgStyler">����Ϣ</th>
								<th data-options="field: 'position', width:50, styler:posStyler">��λ</th>	
								<th data-options="field: 'edit', width:50, styler:editStyler">�޸�</th>
							</tr>
						</thead>
					</table>
					<div id="sDiv" style="display:none">
						<table style="width:100%;margin:5px; padding:10px;background-color:#ffffff">
							<tr>
								<td><label for="sVin">�����복�ܺţ�</label> <input id="sVin"
									name="sVin" class="easyui-textbox" style="width:150px" /></td>
								<td><label for="sSn">�������Ʒ��ţ�</label> <input id="sSn"
									name="sSn" class="easyui-numberbox" style="width:150px" /></td>
								<td><label for="sVphone">����������ֻ���</label> <input
									id="sVphone" name="sVphone" class="easyui-numberbox"
									style="width:150px" /></td>
								<td><label for="sArea">��ѡ�������</label> <input id="sArea"
									name="sArea" class="easyui-combobox" style="width:150px"
									data-options="
												valueField: 'area_id',
												textField: 'area_address',
												url : 'http://localhost:8080/ZHWS/rest/areas',
												method: 'get'" />
								</td>
								<td><label for="slock">��ѡ������״̬��</label> <input id="sLock"
									name="sLock" class="easyui-combobox" style="width:100px"
									data-options="
												valueField: 'code',
												textField: 'status',
												data: [
													{code: 0, status: ' '},
													{code: 1, status: '����'},
													{code: 2, status: 'δ����'}
												]" />
								</td>
							</tr>
							<tr >
								<td colspan="5" align="center" style="padding-top:10px"><a href="#"
									class="easyui-linkbutton" data-options="iconCls:'icon-search'"
									onclick="searchAndReload()" style="width:80px">��ѯ</a>
									&nbsp;&nbsp;&nbsp; <a href="#" class="easyui-linkbutton"
									data-options="iconCls:'icon-clear'" onclick="clear()"
									style="width:80px">���</a></td>
							</tr>
						</table>
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