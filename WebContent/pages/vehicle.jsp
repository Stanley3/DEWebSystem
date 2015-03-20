<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>车辆管理-驾驶员培训科目三模拟考试系统管理后台</title>
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
			if (itemChanged) {//combobox被选择后才改变guset_id的值，否则使用初始值
				var ed = $('#dg').datagrid('getEditor', {
					index : editIndex,
					field : 'guest_name'
				});
				var name = $(ed.target).combobox('getText');
				guest_id = $(ed.target).combobox('getValue');
				$(ed.target).combobox('setValue', name); //将选中的值赋给单元格
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
	function accept() { //update到服务器
		/* try{ */
		if (endEditing()) {
			var changes = $('#dg').datagrid('getChanges', 'inserted');
			if (changes != null && changes.length != 0) {
				//新增行操作
				var i;
				var completed; //确保上次的ajax成功后才进行下次的ajax操作
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
							status : 0, //0表示未运行
							lock : 0, //0表示未锁定
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
				//更新行操作
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
							lock : changes[i].vehicle_lock, //0表示未锁定
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
				//删除行操作
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
	function onSelect() {
		//当combobox被选择时，设置itemChanged的值为true
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
			//此处写发送信息相关的代码，应该是一个ajax请求
		}else if(field == 'position'){
			//此处写定位相关的代码，应该打开一个新的界面
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
						<li><a href="vehicle.jsp" class="selected"><span>车辆管理</span></a></li>
						<li><a href="arrearage.jsp"><span>欠费管理</span></a></li>
						<li><a href="admin.jsp"><span>超管管理</span></a></li>
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
						url:'http://localhost:8080/ZHWS/rest/vehicles',
						method:'get',
						toolbar: '#tb',
						onDblClickRow : onDblClickRow,
						onClickCell : onClickCell
						">
						<thead height="100px">
							<tr>
								<th data-options="field:'vehicle_id',width:100,hidden:true">客户电话</th>
								<th
									data-options="field:'vehicle_sn',width:80, 
									editor:{
										type: 'numberbox',
										options : {
											required : true,
											missingMessage : '请输入产品序号'
										}
									}">产品序号</th>
								<th
									data-options="field:'vehicle_vin',width:100, 
									editor:{
										type: 'textbox',
										options : {
											required : true,
											missingMessage : '请输入车架号'
										}
									}">车架号</th>
								<th
									data-options="field:'vehicle_phone',width:100,
									editor:{
										type: 'numberbox',
										options : {
											required : true,
											missingMessage : '请输入机器手机号'
										}
									}">机器手机号</th>
								<th
									data-options="field:'guest_name',width:100, 
									editor:{
										type: 'combobox',
										options : {
											required : true,
											missingMessage : '请选择客户',
											valueField: 'guest_id',
											textField: 'guest_name',
											url : 'http://localhost:8080/ZHWS/rest/guests',
											method : 'get' ,
											onSelect : onSelect
										}
									}">客户名称</th>
								<th data-options="field:'guest_cellphone',width:100">客户电话</th>
								<th data-options="field:'vehicle_status',width:100, styler: statusStyler">运行</th>
								<th
									data-options="field:'vehicle_lock',width:100, styler: lockStyler,
									editor:{
										type: 'combobox',
										options : {
											required : true,
											missingMessage : '请输入锁定信息',
											valueField: 'code',
											textField: 'status',
											data: [
												{code: 0, status: '未锁定'},
												{code: 1, status: '锁定'}
											]
										}
									}">锁定</th>
								<th data-options="field:'area_address',width:100">所在地区</th>
								<th data-options="field:'vehicle_version',width:100">当前版本</th>
								<th
									data-options="field:'vehicle_arrearage',width:100, 
									editor:{
										type: 'numberbox',
										options : {
											required : true,
											missingMessage : '请输入欠费信息，0表示未欠费',
											min : 0,
											precision : 2
										}
									}">欠费</th>
								<th
									data-options="field:'vehicle_remark', width:300,
									editor:{
										type: 'textbox',
										options : {
											mutiline: true
										}
									}">备注</th>
								<th data-options="field: 'sendMsg', width:50, styler:msgStyler">发信息</th>
								<th data-options="field: 'position', width:50, styler:posStyler">定位</th>	
								<th data-options="field: 'edit', width:50, styler:editStyler">修改</th>
							</tr>
						</thead>
					</table>
					<div id="sDiv" style="display:none">
						<table style="width:100%;margin:5px; padding:10px;background-color:#ffffff">
							<tr>
								<td><label for="sVin">请输入车架号：</label> <input id="sVin"
									name="sVin" class="easyui-textbox" style="width:150px" /></td>
								<td><label for="sSn">请输入产品序号：</label> <input id="sSn"
									name="sSn" class="easyui-numberbox" style="width:150px" /></td>
								<td><label for="sVphone">请输入机器手机：</label> <input
									id="sVphone" name="sVphone" class="easyui-numberbox"
									style="width:150px" /></td>
								<td><label for="sArea">请选择地区：</label> <input id="sArea"
									name="sArea" class="easyui-combobox" style="width:150px"
									data-options="
												valueField: 'area_id',
												textField: 'area_address',
												url : 'http://localhost:8080/ZHWS/rest/areas',
												method: 'get'" />
								</td>
								<td><label for="slock">请选择锁定状态：</label> <input id="sLock"
									name="sLock" class="easyui-combobox" style="width:100px"
									data-options="
												valueField: 'code',
												textField: 'status',
												data: [
													{code: 0, status: ' '},
													{code: 1, status: '锁定'},
													{code: 2, status: '未锁定'}
												]" />
								</td>
							</tr>
							<tr >
								<td colspan="5" align="center" style="padding-top:10px"><a href="#"
									class="easyui-linkbutton" data-options="iconCls:'icon-search'"
									onclick="searchAndReload()" style="width:80px">查询</a>
									&nbsp;&nbsp;&nbsp; <a href="#" class="easyui-linkbutton"
									data-options="iconCls:'icon-clear'" onclick="clear()"
									style="width:80px">清空</a></td>
							</tr>
						</table>
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