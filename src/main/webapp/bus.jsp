<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page isELIgnored="false"%>
<%
	String userName = request.getParameter("userName");
	request.getSession().setAttribute("userName", userName);

	String orgName = request.getParameter("orgName");
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>班车设置</title>
<!-- Jquery组件引用 -->
<script type="text/javascript" src="${APP_PATH}/js/jquery-3.1.1.min.js"></script>

<!-- bootstrap组件引用 -->
<script type="text/javascript"
	src="${APP_PATH}/js/bootstrap/js/bootstrap.js"></script>
<link rel="stylesheet" type="text/css"
	href="${APP_PATH}/js/bootstrap/css/bootstrap.min.css">

<!-- bootstrap table组件以及中文包的引用 -->
<script type="text/javascript"
	src="${APP_PATH}/js/bootstrap-table/bootstrap-table.js"></script>
<link rel="stylesheet" type="text/css"
	href="${APP_PATH}/js/bootstrap-table/bootstrap-table.css" />
<script type="text/javascript"
	src="${APP_PATH}/js/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>

<!-- 提示框Js文件和Css的引用 -->
<script type="text/javascript" src="${APP_PATH}/js/toastr/toastr.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="${APP_PATH}/js/toastr/toastr.min.css" />
<script type="text/javascript"
	src="${APP_PATH}/js/sweetalert/sweetalert.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="${APP_PATH}/js/sweetalert/sweetalert.css" />

<!-- 页面下拉框Js文件和Css的引用 -->
<script type="text/javascript"
	src="${APP_PATH}/js/bootstrap-select/js/bootstrap-select.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="${APP_PATH}/js/bootstrap-select/css/bootstrap-select.min.css" />
<%-- 	<script type="text/javascript"
		src="${APP_PATH}/jsps/base/bus/js/bus-table.js"></script>
 --%>
<link rel="stylesheet" type="text/css"
	href="${APP_PATH}/js/bootstrap-validator/bootstrapValidator.min.css" />
<script type="text/javascript"
	src="${APP_PATH}/js/bootstrap-validator/bootstrapValidator.min.js"></script>
<style type="text/css">
/* style type ="text /css"> */
body {
	margin: 0;
	padding: 0
}

.background {
	margin-left: 100px;
}

p {
	height: 40px;
	line-height: 40px;
}

.open-model {
	text-align: center;
}

.open-model input {
	padding: 10px 20px;
	font-size: 24px;
	line-height: 24px;
	border: 0px;
	background: #F53639;
	color: #FFF;
	cursor: pointer;
}

.open-model input:hover {
	background: #F3726D;
}

.open-model input:focus {
	border: 0px;
	outline-width: 0px;
}

.model {
	opacity: 0.75;
	background: #666;
	position: fixed;
	left: 0;
	right: 0;
	top: 0;
	bottom: 0;
	z-index: 1000;
}

.model-dialog {
	width: 600px;
	height: 400px;
	background: white;
	position: absolute;
	z-index: 1001;
	left: 0;
	top: 0;
}

.hide {
	display: none;
}
</style>
<script type="text/javascript">
	var TableInit = function() {
		var oTableInit = new Object();
		// 初始化Table
		oTableInit.Init = function() {
			$('#tb_departments').bootstrapTable({
				url : '${APP_PATH}/bus/findAllPageQuery', // 请求后台的URL（*）
				method : 'get', // 请求方式（*）
				toolbar : '#toolbar', // 工具按钮用哪个容器
				striped : true, // 是否显示行间隔色
				cache : false, // 是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
				pagination : true, // 是否显示分页（*）
				sortable : true, // 是否启用排序
				sortOrder : "asc", // 排序方式
				queryParamsType : "undefined",
				queryParams : function queryParams(params) { // 设置查询参数
					var param = {
						pageNumber : params.pageNumber,
						pageSize : params.pageSize,
						carrier : $("#txt_search_carrier").val(),
						driver : $("#txt_search_driver").val(),
						busnumber : $("#txt_search_busnumber").val(),
						driverphone : $("#txt_search_driverphone").val(),
						linetype : $("#txt_search_linetype").val(),
						linename : $("#txt_search_linename").val(),
						useable : $("#txt_search_useable").val()
					};
					return param;
				},// 传递参数（*）
				sidePagination : "server", // 分页方式：client客户端分页，server服务端分页（*）
				pageNumber : 1, // 初始化加载第一页，默认第一页
				pageSize : 10, // 每页的记录行数（*）
				pageList : [ 5, 10, 15, 20 ], // 可供选择的每页的行数（*）
				/* search : true, */// 是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
				strictSearch : true,
				showColumns : true, // 是否显示所有的列
				showRefresh : true, // 是否显示刷新按钮
				minimumCountColumns : 2, // 最少允许的列数
				clickToSelect : true, // 是否启用点击选中行
				uniqueId : "busid", // 每一行的唯一标识，一般为主键列
				showToggle : true, // 是否显示详细视图和列表视图的切换按钮
				cardView : false, // 是否显示详细视图
				detailView : false, // 是否显示父子表
				columns : [ {
					checkbox : true
				}, {
					field : 'busnumber',
					title : '车牌号'
				}, {
					field : 'carrier',
					title : '承运商'
				}, {
					field : 'driver',
					title : '司机 '
				}, {
					field : 'driverphone',
					title : '电话'
				},/*  {
																																								field : 'bustype',
																																								title : '车型'
																																							}, */{
					field : 'linetype',
					title : '线路类型'
				}, {
					field : 'linename',
					title : '线路名称'
				},/*  {
																																								field : 'operationStaffId',
																																								title : '操作人'
																																							}, {
																																								field : 'operateUnit',
																																								title : '操作单位'
																																							}, {
																																								field : 'operateTime',
																																								title : '操作时间'
																																							}, */{
					field : 'ton',
					title : '吨控'
				}, {
					field : 'description',
					title : '备注'
				}, {
					field : 'useable',
					title : '状态',
					formatter : function(value, row, index) {
						if (row.useable == 'Y') {
							return '<span style="color:green">激活</span>';
						} else {
							return '<span style="color:red">作废</span>';
						}
					}
				} ]
			});
		};
		return oTableInit;

	};

	var ButtonInit = function() {
		var oInit = new Object();
		var postdata = {};
		oInit.Init = function() {
			$("#btn_sub")
					.click(
							function() {

								var busnumber = $("#busnumberAdd").val();
								var carrier = $("#carrierAdd").val();
								/* //获取司机下拉框的值
								var staffId = "";
								//获取基础档案的Id
								for (var i = 0; i < $("#driverAdd").children().length; i++) {
									if ($("#driverAdd").children()[i].selected) {
										staffId = $($("#driverAdd").children()[i]).attr("id");
									}
								}
								var driver = staffId; */
								var driverphone = $("#driverphoneAdd").val();
								/* //获取车型下拉框的值
								var subsetId = "";
								//获取基础档案的Id
								for (var i = 0; i < $("#bustypeAdd").children().length; i++) {
									if ($("#bustypeAdd").children()[i].selected) {
										subsetId = $($("#bustypeAdd").children()[i]).attr("id");
									}
								}
								var bustype = subsetId; */
								//获取线路类型下拉框的值
								var subsetId = "";
								//获取基础档案的Id
								for (var i = 0; i < $("#linetypeAdd")
										.children().length; i++) {
									if ($("#linetypeAdd").children()[i].selected) {
										subsetId = $(
												$("#linetypeAdd").children()[i])
												.attr("id");
									}
								}
								var linetype = subsetId;
								var linename = $("#linenameAdd").val();
								/* var operationStaffId = $("#operationStaffIdAdd").val();
								var operateUnit = $("#orgName").val();
								alert(operateUnit);
								var operateTime = $("#operateTimeAdd").val(); */
								var ton = $("#tonAdd").val();
								var description = $("#descriptionAdd").val();
								var useable = $("#useableAdd").val();

								if (busnumber == null || busnumber == "") {
									toastr.error('车牌号不能为空');
								} else if (carrier == null || carrier == "") {
									toastr.error('承运商不能为空');
								} else if (driverphone == null
										|| driverphone == "") {
									toastr.error('电话不能为空');
								}/* else if (operationStaffId == null || operationStaffId == "") {
																																																																												toastr.error('操作人不能为空');
																																																																											} else if (operateUnit == null || operateUnit == "") {
																																																																												toastr.error('操作单位不能为空');
																																																																											}  */else if (ton == null
										|| ton == "") {
									toastr.error('吨控不能为空');
								} else {
									// 异步同步数据库
									$.ajax({
										type : "post",
										url : '${APP_PATH}/bus/add',
										data : {
											busnumber : busnumber,
											carrier : carrier,
											/* driver : driver, */
											driverphone : driverphone,
											/* bustype : bustype, */
											linetype : linetype,
											linename : linename,
											/* operationStaffId : operationStaffId,
											operateUnit : operateUnit, */
											ton : ton,
											description : description,
											useable : useable
										},
										success : function(result) {
											if (result == "true") {
												toastr.success('添加成功!');
												$('#tb_departments')
														.bootstrapTable(
																'refresh');
											} else {
												toastr.error('添加失败!');
											}
										}

									});
								}
							});

			// 点击修改脚本打开模态框
			$("#btn_edit")
					.click(
							function() {
								var select = $('#tb_departments')
										.bootstrapTable('getSelections');
								if (select.length === 0) {
									toastr.warning('请选择一行修改');
								} else if (select.length > 1) {
									toastr.warning('不能同时修改多行');
								} else {
									var busnumber = [];
									var carrier = [];
									/* var driver = []; */
									var driverphone = [];
									/* var bustype = []; */
									var linetype = [];
									var linename = [];
									/* var operationStaffId = [];
									var operateUnit = [];
									var operateTime = []; */
									var ton = [];
									var description = [];
									var useable = [];
									// 获取单行数据
									for (var i = 0; i < select.length; i++) {
										busnumber[i] = select[i]['busnumber'];
										carrier[i] = select[i]['carrier'];
										/* driver[i] = select[i]['driver']; */
										driverphone[i] = select[i]['driverphone'];
										/* bustype[i] = select[i]['bustype']; */
										linetype[i] = select[i]['linetype'];
										linename[i] = select[i]['linename'];
										/* operationStaffId[i] = select[i]['operationStaffId'];
										operateUnit[i] = select[i]['operateUnit'];
										operateTime[i] = select[i]['operateTime']; */
										ton[i] = select[i]['ton'];
										description[i] = select[i]['description'];
										useable[i] = select[i]['useable'];
									}

									// 给模态框赋值
									$("#busnumberUp").attr("value", busnumber);
									$("#carrierUp").attr("value", carrier);
									/* $("#driverUp").attr("value", driver); */
									$("#driverphoneUp").attr("value",
											driverphone);
									/* $("#bustypeUp").attr("value", bustype); */
									$("#linetypeUp").attr("value", linetype);
									$("#linenameUp").attr("value", linename);
									/* $("#operationStaffIdUp").attr("value", operationStaffId);
									$("#operateUnitUp").attr("value", operateUnit);
									$("#operateTimeUp").attr("value", operateTime); */
									$("#tonUp").attr("value", ton);
									$("#descriptionUp").attr("value",
											description);
									$("#useableUp").attr("value", useable);

									$("#myModal-footer2").modal("show");

								}

								clean();
								/* //司机名
								$.ajax({
									url : '${APP_PATH}/bus/findAllSubsetNameAndIdQuery',
									type:"post",
									async:true,
									success:function(response){
										var html = "<option>请选择司机名</option>";
										for(var i=0;i<response.length;i++) {
											html = html+"<option id='"+response[i].staffId+"'>"+response[i].subsetName+"</option>";
										}
										$("#driverUp").append(html);
										$(".selectpicker").selectpicker("refresh");
									}
									
								}); */
								/* //车型
								$.ajax({
									type:"post",
									async:false,
									url : '${APP_PATH}/bus/findAllArchivesAndIdQuery',
									success:function(response){
										var html = "<option>请选择车型</option>";
										for(var i=0;i<response.length;i++) {
											html = html+"<option id='"+response[i].subsetId+"'>"+response[i].subsetName+"</option>";
										}
										$("#bustypeUp").append(html);
										$(".selectpicker").selectpicker("refresh");
									}
								}); */
								//线路类型
								$
										.ajax({
											type : "post",
											async : false,
											url : '${APP_PATH}/bus/findLineNameAndId',
											success : function(response) {
												var html = "<option>"
														+ linetype
														+ "</option>";
												for (var i = 0; i < response.length; i++) {
													html = html
															+ "<option id='"+response[i].linetype+"'>"
															+ response[i].linetype
															+ "</option>";
												}
												$("#linetypeUp").append(html);
												$(".selectpicker")
														.selectpicker("refresh");
											}
										});
								$("#updateBusFrom").data('bootstrapValidator')
										.destroy();
								$('#updateBusFrom').data('bootstrapValidator',
										null);
								validatorU();

							});

			// 提交修改
			$("#subset_edit")
					.click(
							function() {

								// 获取单行数据
								var select = $('#tb_departments')
										.bootstrapTable('getSelections');

								var busid = "";
								var busnumber = [];
								var carrier = [];
								/* var driver = []; */
								var driverphone = [];
								/* var bustype = []; */
								var linetype = [];
								var linename = [];
								/* var operationStaffId = [];
								var operateUnit = [];
								var operateTime = []; */
								var ton = [];
								var description = [];
								var useable = [];
								// 获取单行数据
								for (var i = 0; i < select.length; i++) {
									busid = select[i]['busid'];
									busnumber[i] = select[i]['busnumber'];
									carrier[i] = select[i]['carrier'];
									/* driver[i] = select[i]['driver']; */
									driverphone[i] = select[i]['driverphone'];
									/* bustype[i] = select[i]['bustype']; */
									linetype[i] = select[i]['linetype'];
									linename[i] = select[i]['linename'];
									/* operationStaffId[i] = select[i]['operationStaffId'];
									operateUnit[i] = select[i]['operateUnit'];
									operateTime[i] = select[i]['operateTime']; */
									ton[i] = select[i]['ton'];
									description[i] = select[i]['description'];
									useable[i] = select[i]['useable'];
								}

								// 获取输入框中数据
								var busnumber = $("#busnumberUp").val();
								var carrier = $("#carrierUp").val();
								//var driver = $("#driverUp").val();
								/* //获取司机下拉框的值
								var staffId = "";
								//获取基础档案的Id
								for (var i = 0; i < $("#driverUp").children().length; i++) {
									if ($("#driverUp").children()[i].selected) {
										staffId = $($("#driverUp").children()[i]).attr("id");
									}
								}
								var driver = staffId; */
								var driverphone = $("#driverphoneUp").val();

								/* //获取车型下拉框的值
								var subsetId = "";
								//获取基础档案的Id
								for (var i = 0; i < $("#bustypeUp").children().length; i++) {
									if ($("#bustypeUp").children()[i].selected) {
										subsetId = $($("#bustypeUp").children()[i]).attr("id");
									}
								}
								
								var bustype = subsetId; */

								//var linetype = $("#linetypeUp").val();
								//获取线路类型下拉框的值
								var subsetId = "";
								//获取基础档案的Id
								for (var i = 0; i < $("#linetypeUp").children().length; i++) {
									if ($("#linetypeUp").children()[i].selected) {
										subsetId = $(
												$("#linetypeUp").children()[i])
												.attr("id");
									}
								}
								var linetype = subsetId;
								var linename = $("#linenameUp").val();
								/* var operationStaffId = $("#operationStaffIdUp").val();
								var operateUnit = $("#operateUnitUp").val();
								var operateTime = $("#operateTimeUp").val(); */
								var ton = $("#tonUp").val();
								var description = $("#descriptionUp").val();
								var useable = $("#useableUp").val();

								$.ajax({
									type : "post",
									url : '${APP_PATH}/bus/update',
									data : {
										busnumber : busnumber,
										carrier : carrier,
										/* driver : driver, */
										driverphone : driverphone,
										/* bustype : bustype, */
										linetype : linetype,
										linename : linename,
										ton : ton,
										description : description,
										useable : useable,
										busid : busid
									},
									success : function(msg) {
										if (msg == "true") {
											toastr.success('修改成功!');
											$('#tb_departments')
													.bootstrapTable('refresh');
										} else {
											toastr.error('修改失败!');
										}
									}
								});
							});
			$("#btn_forzen").click(
					function() {
						var select = $('#tb_departments').bootstrapTable(
								'getSelections');
						if (select.length === 0) {
							toastr.warning('请至少选择一行冻结');
						} else {
							//遍历，如果选择的用户中有已被禁用的，给出提示，退出!
							for (var i = 0; i < select.length; i++) {
								if (select[i].useable == "N") {
									toastr.warning('您选择的目标用户中有已被禁用的');
									return;
								}
							}
							swal({
								title : "操作提示", //弹出框的title  
								text : "确定冻结吗？", //弹出框里面的提示文本  
								type : "warning", //弹出框类型  
								showCancelButton : true, //是否显示取消按钮  
								confirmButtonColor : "#DD6B55",//确定按钮颜色  
								cancelButtonText : "取消",//取消按钮文本  
								confirmButtonText : "是的，确定冻结！",//确定按钮上面的文档  
								closeOnConfirm : true
							}, function() {
								var arrs = [];
								for (var i = 0; i < select.length; i++) {
									arrs[i] = select[i]['busid'];

									$('#tb_departments').bootstrapTable(
											'remove', {
												field : 'busid',
												values : arrs
											});
								}
								$.ajax({
									type : "post",
									url : '${APP_PATH}/bus/updateUseable',
									data : {
										busids : arrs
									},
									success : function(result) {
										if (result == "success") {
											toastr.success('冻结成功!');
											$('#tb_departments')
													.bootstrapTable('refresh');

										} else {
											toastr.error('冻结失败!');
										}
									}

								});

							});

						}

					});
			$("#btn_recover").click(
					function() {
						var select = $('#tb_departments').bootstrapTable(
								'getSelections');
						if (select.length === 0) {
							toastr.warning('请至少选择一行解冻');
						} else {
							//遍历，如果选择的用户中有已被禁用的，给出提示，退出!
							for (var i = 0; i < select.length; i++) {
								if (select[i].useable == "Y") {
									toastr.warning('您选择的目标用户中有激活的');
									return;
								}
							}
							swal({
								title : "操作提示", //弹出框的title  
								text : "确定激活吗？", //弹出框里面的提示文本  
								type : "warning", //弹出框类型  
								showCancelButton : true, //是否显示取消按钮  
								confirmButtonColor : "#DD6B55",//确定按钮颜色  
								cancelButtonText : "取消",//取消按钮文本  
								confirmButtonText : "是的，确定激活！",//确定按钮上面的文档  
								closeOnConfirm : true
							}, function() {
								var arrs = [];
								for (var i = 0; i < select.length; i++) {
									arrs[i] = select[i]['busid'];

									$('#tb_departments').bootstrapTable(
											'remove', {
												field : 'busid',
												values : arrs
											});
								}
								$.ajax({
									type : "post",
									url : '${APP_PATH}/bus/updateUseableToYes',
									data : {
										busids : arrs
									},
									success : function(result) {
										if (result == "success") {
											toastr.success('解冻成功!');
											$('#tb_departments')
													.bootstrapTable('refresh');

										} else {
											toastr.error('解冻失败!');
										}
									}

								});

							});

						}

					});
			$("#btn_delete").click(
					function() {
						var select = $('#tb_departments').bootstrapTable(
								'getSelections');
						if (select.length === 0) {
							toastr.warning('请至少选择一行删除');
						} else {
							swal({
								title : "操作提示", // 弹出框的title
								text : "确定删除吗？", // 弹出框里面的提示文本
								type : "warning", // 弹出框类型
								confirmButtonColor : "#DD6B55",// 确定按钮颜色
								confirmButtonText : "确定删除",// 确定按钮上面的文档
								useableButtonText : "取消",// 取消按钮文本
								showuseableButton : true, // 是否显示取消按钮
								closeOnConfirm : true
							}, function() {
								var arrs = [];
								for (var i = 0; i < select.length; i++) {
									arrs[i] = select[i]['busid'];

									$('#tb_departments').bootstrapTable(
											'remove', {
												field : 'busid',
												values : arrs
											});
								}
								$.ajax({
									type : "post",
									url : '${APP_PATH}/bus/delete',
									data : {
										busids : arrs
									},
									success : function(result) {
										if (result == "success") {
											toastr.success('删除成功!');
											$('#tb_departments')
													.bootstrapTable('refresh');

										} else {
											toastr.error('删除失败!');
										}
									}

								});

							});

						}

					});
		};
		return oInit;
	};

	$(function() {
		validator();
		validatorU();
		//1.初始化Table
		var oTable = new TableInit();
		oTable.Init();

		//2.初始化Button的点击事件
		var oButtonInit = new ButtonInit();
		oButtonInit.Init();
		// 点击查询按钮触发点击事件
		$("#btn_query").click(function() {

			$('#tb_departments').bootstrapTable("refresh", {
				url : '${APP_PATH}/bus/findAllPageQuery',
				queryParams : oTable.queryParams
			});
		});

		//新增按钮
		$("#btn_add").click(function() {
			clean();
			getDataInsert();
			$("#addBusFrom").data('bootstrapValidator').destroy();
			$('#addBusFrom').data('bootstrapValidator', null);
			validator();

		});

		//初始化操作消息提示框
		toastr.options = {
			closeButton : false, //是否显示关闭按钮
			debug : false, //是否为调试
			progressBar : true, //是否显示进度条
			positionClass : "toast-top-center", //在页面中显示的位置
			onclick : null, //点击事件
			showDuration : "100", //显示动作时间
			hideDuration : "1000", //隐藏动作时间
			timeOut : "2000", //自动关闭超时时间
			extendedTimeOut : "1000",
			showEasing : "swing",
			hideEasing : "linear",
			preventDuplicates : true,
			preventOpenDuplicates : true, //重复内容的提示框在开启时只出现一个
			showMethod : "fadeIn", //显示的方式
			hideMethod : "fadeOut" //隐藏的方式
		};

	});

	function useable() {
		$('body').css('overflow', 'auto');
		$('body').css('padding-right', '0px');
		$('.model').addClass('hide');
		$('.model-dialog').addClass('hide');
	}

	function check() {

		//校验逻辑

		return false;
	}

	//获取各种下拉列表的数据
	function getDataInsert() {
		/* //司机名
		$.ajax({
			type:"post",
			async:false,
			url : '${APP_PATH}/bus/findAllSubsetNameAndIdQuery',
			success:function(response){
				var html = "<option>请选择司机名</option>";
				for(var i=0;i<response.length;i++) {
					html = html+"<option id='"+response[i].staffId+"'>"+response[i].subsetName+"</option>";
				}
				$("#driverAdd").append(html);
				$(".selectpicker").selectpicker("refresh");
			}
		}); */
		//车型
		/* $.ajax({
			type:"post",
			async:false,
			url : '${APP_PATH}/bus/findAllArchivesAndIdQuery',
			success:function(response){
				var html = "<option>请选择车型</option>";
				for(var i=0;i<response.length;i++) {
					html = html+"<option id='"+response[i].subsetId+"'>"+response[i].subsetName+"</option>";
				}
				$("#bustypeAdd").append(html);
				$(".selectpicker").selectpicker("refresh");
			}
		}); */
		//线路类型
		$.ajax({
			type : "post",
			async : false,
			url : '${APP_PATH}/bus/findLineNameAndId',
			success : function(response) {
				var html = "<option>请选择线路类型</option>";
				for (var i = 0; i < response.length; i++) {
					html = html + "<option id='"+response[i].linetype+"'>"
							+ response[i].linetype + "</option>";
				}
				$("#linetypeAdd").append(html);
				$(".selectpicker").selectpicker("refresh");
			}
		});

	}

	//清除方法
	function clean() {
		/* $("#driverAdd").children("option").remove();
		$("#bustypeAdd").children("option").remove(); */
		$("#linetypeAdd").children("option").remove();

		/* $("#driverUp").children("option").remove();
		$("#bustypeUp").children("option").remove(); */
		$("#linetypeUp").children("option").remove();

	}

	//===================================================================校验

	//清除提示
	function useablePrompt(obj) {
		$("#" + obj.id + "_prompt").text("");
	};

	//修改按钮再次验证
	function verificationU() {
		checkPhoneU(updatedriverphone);
	};
	//添加校验
	function validator() {
		$('#addBusFrom')
				.bootstrapValidator(
						{
							message : 'This value is not valid',
							feedbackIcons : {
								valid : 'glyphicon glyphicon-ok',
								invalid : 'glyphicon glyphicon-remove',
								validating : 'glyphicon glyphicon-refresh'
							},
							fields : {
								busnumberAdd : {
									message : '车牌号验证失败!',
									validators : {
										notEmpty : {
											message : '车牌号不能为空!',
										},
										stringLength : {
											min : 6,
											max : 10,
											message : '车牌号长度必须在6到10位之间!'
										},
										regexp : {
											regexp : /^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$/,
											message : '车牌号格式不正确!'
										}
									}
								},
								/* carrierAdd: {
								     validators: {
								         notEmpty: {
								             message: '承运商不能为空!'
								         },
								         regexp: {
								             regexp: /^[\u4E00-\u9FA5]{2,4}$/,
								             message: '职员名只能为中文例如:张三!'
								            }
								     }
								 }, */
								driverphoneAdd : {
									validators : {
										notEmpty : {
											message : '电话不能为空!'
										},
										regexp : {
											regexp : /^1(3|4|5|7|8)\d{9}$/,
											message : '电话号码格式不正确!'
										}
									}
								},
								linenameAdd : {
									validators : {
										notEmpty : {
											message : '线路名称不能为空!'
										},
										regexp : {
											regexp : /^[\u4E00-\u9FA5]{2,6}$/,
											message : '线路名称只能为中文且2到6位例如:高速线路!'
										}
									}
								},
								/* operationStaffIdAdd: {
								    validators: {
								        notEmpty: {
								            message: '操作人不能为空!'
								        },
								        
								    }
								},
								operateUnitAdd: {
								    validators: {
								        notEmpty: {
								            message: '操作单位不能为空!'
								        },
								        
								    }
								}, */
								tonAdd : {
									validators : {
										notEmpty : {
											message : '吨控不能为空!'
										},

									}
								},
							}
						});
	};
	//修改校验
	function validatorU() {
		$('#updateBusFrom')
				.bootstrapValidator(
						{
							message : 'This value is not valid',
							feedbackIcons : {
								valid : 'glyphicon glyphicon-ok',
								invalid : 'glyphicon glyphicon-remove',
								validating : 'glyphicon glyphicon-refresh'
							},
							fields : {
								busnumberUp : {
									message : '车牌号验证失败!',
									validators : {
										notEmpty : {
											message : '车牌号不能为空!',
										},
										stringLength : {
											min : 6,
											max : 10,
											message : '车牌号长度必须在6到10位之间!'
										},
										regexp : {
											regexp : /^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$/,
											message : '车牌号格式不正确!'
										}
									}
								},
								/* carrierUp: {
								     validators: {
								         notEmpty: {
								             message: '承运商不能为空!'
								         },
								         regexp: {
								             regexp: /^[\u4E00-\u9FA5]{2,4}$/,
								             message: '职员名只能为中文例如:张三!'
								            }
								     }
								 }, */
								driverphoneUp : {
									validators : {
										notEmpty : {
											message : '电话不能为空!'
										},
										regexp : {
											regexp : /^1(3|4|5|7|8)\d{9}$/,
											message : '电话号码格式不正确!'
										}
									}
								},
								linenameUp : {
									validators : {
										notEmpty : {
											message : '线路名称不能为空!'
										},
										regexp : {
											regexp : /^[\u4E00-\u9FA5]{2,6}$/,
											message : '线路名称只能为中文且2到6位例如:高速线路！'
										}
									}
								},
								/* operationStaffIdUp: {
								    validators: {
								        notEmpty: {
								            message: '操作人不能为空!'
								        },
								        
								    }
								},
								operateUnitUp: {
								    validators: {
								        notEmpty: {
								            message: '操作单位不能为空!'
								        },
								        
								    }
								}, */
								tonUp : {
									validators : {
										notEmpty : {
											message : '吨控不能为空!'
										},

									}
								},
							}
						});
	}
</script>
</head>
<body>
	<div class="panel-body" style="padding-bottom: 0px;">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h4 class="panel-title">
					<a data-toggle="collapse" href="#collapseOne"> 显示查询条件<span
						class="caret"></span>
					</a>
				</h4>
			</div>
			<div id="collapseOne" class="panel-collapse collapse in">
				<div class="panel-body">
					<form id="formSearch" class="form-horizontal">
						<div class="form-group" style="margin-top: 15px">
							<label class="control-label col-sm-1" for="txt_search_busnumber">车牌号</label>
							<div class="col-sm-2">
								<input type="text" class="mhcys form-control"
									id="txt_search_busnumber" placeholder="请输入车牌号">
							</div>
							<label class="control-label col-sm-1" for="txt_search_carrier">承运商</label>
							<div class="col-sm-2">
								<input type="text" class="mhcys form-control"
									id="txt_search_carrier" placeholder="请输入承运商">
							</div>
							<label class="control-label col-sm-1" for="txt_search_driver">司机</label>
							<div class="col-sm-2">
								<input type="text" class="mhsj form-control"
									id="txt_search_driver" placeholder="请输入司机">
							</div>
							<label class="control-label col-sm-1"
								for="txt_search_driverphone">电话</label>
							<div class="col-sm-2">
								<input type="text" class="mhsj form-control"
									id="txt_search_driverphone" placeholder="请输入电话号码">
							</div>
						</div>
						<div class="form-group" style="margin-top: 15px">
							<label class="control-label col-sm-1" for="txt_search_linetype">线路类型</label>
							<div class="col-sm-2">
								<input type="text" class="mhsj form-control"
									id="txt_search_linetype" placeholder="请输入线路类型">
							</div>
							<label class="control-label col-sm-1" for="txt_search_linename">线路名称</label>
							<div class="col-sm-2">
								<input type="text" class="mhsj form-control"
									id="txt_search_linename" placeholder="请输入线路名称">
							</div>
							<label class="control-label col-sm-1" for="txt_search_useable">状态</label>
							<div class="col-sm-2">
								<select class="form-control" id="txt_search_useable"
									name="linetypeAdd">
									<option value="">选择您要查询的状态</option>
									<option value="Y">激活</option>
									<option value="N">作废</option>
								</select>
							</div>
							<div class="col-sm-3" style="text-align: left;">
								<button type="button" style="margin-left: 50px" id="btn_query"
									class="btn btn-success">查询</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<div id="toolbar" class="btn-group">
		<shiro:hasPermission name="新增班车">
			<button id="btn_add" type="button" class="btn btn-success"
				data-toggle="modal" data-target="#myModal">
				<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
			</button>
		</shiro:hasPermission>
		<shiro:hasPermission name="修改班车 ">
			<button id="btn_edit" type="button" class="btn btn-info">
				<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
			</button>
		</shiro:hasPermission>
		<shiro:hasPermission name="删除班车 ">
			<button id="btn_delete" type="button" class="btn btn-danger">
				<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
			</button>
		</shiro:hasPermission>
		<shiro:hasPermission name="作废用户">
			<button id="btn_forzen" type="button" class="btn btn-warning">
				<span class="glyphicon glyphicon-remove-sign" aria-hidden="true"></span>
				冻结
			</button>
			<!-- </shiro:hasPermission> -->
			<shiro:hasPermission name="还原用户">
				<button id="btn_recover" type="button" class="btn btn-success">
					<span class="glyphicon glyphicon-repeat" aria-hidden="true"></span>
					还原
				</button>
			</shiro:hasPermission>
	</div>
	<table id="tb_departments"></table>

	<!-- 添加模态框（Modal） -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<div class="panel panel-success">
						<div class="panel-heading">
							<h3 class="panel-title">新增</h3>
						</div>
						<div class="panel-body">
							<form class="form-horizontal" onsubmit="return check()"
								role="form" id="addBusFrom">
								<div class="form-group">
									<label for="lastname" class="col-sm-3 control-label">车牌号</label>
									<div class="col-sm-8">
										<input type="text" class="form-control" id="busnumberAdd"
											name="busnumberAdd" placeholder="请输入车牌号">
									</div>
								</div>
								<div class="form-group">
									<label for="lastname" class="col-sm-3 control-label">承运商</label>
									<div class="col-sm-8">
										<input type="text" class="form-control" id="carrierAdd"
											name="carrierAdd" placeholder="请输入承运商">
									</div>
								</div>
								<div class="form-group">
									<label for="lastname" class="col-sm-3 control-label">电话</label>
									<div class="col-sm-8">
										<input type="text" class="form-control" id="driverphoneAdd"
											name="driverphoneAdd" placeholder="请输入电话号码">
									</div>
								</div>
								<div class="form-group">
									<label for="lastname" class="col-sm-3 control-label">线路名称</label>
									<div class="col-sm-8">
										<input type="text" class="form-control" id="linenameAdd"
											name="linenameAdd" placeholder="请输入线路名称">
									</div>
								</div>
								<div class="form-group">
									<label for="firstname" class="col-sm-3 control-label">线路类型</label>
									<div class="col-sm-8">
										<select class="form-control" id="linetypeAdd"
											name="linetypeAdd">
										</select>
									</div>
								</div>
								<div class="form-group">
									<label for="lastname" class="col-sm-3 control-label">吨控</label>
									<div class="col-sm-8">
										<input type="text" class="form-control" id="tonAdd"
											name="tonAdd" placeholder="吨控(必输项)">
									</div>
								</div>
								<div class="form-group">
									<label for="lastname" class="col-sm-3 control-label">备注</label>
									<div class="col-sm-8">
										<input type="text" class="form-control" id="descriptionAdd"
											placeholder="备注">
									</div>
								</div>
								<div class="form-group">
									<label for="lastname" class="col-sm-3 control-label">作废</label>
									<div class="col-sm-8">
										<select class="form-control" id="useableAdd">
											<option value="Y">激活</option>
										</select>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button id="btn_sub" type="button" class="btn btn-primary"
						data-dismiss="modal">添加</button>
					<button type="button" class="btn btn-default4" data-dismiss="modal">关闭</button>
				</div>
				<input type="hidden" value="<%=orgName%>" id="orgName" />
			</div>
		</div>
	</div>
	<!-- 修改模态框（Modal） -->
	<div class="modal fade" id="myModal-footer2" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<div class="panel panel-success">
						<div class="panel-heading">
							<h3 class="panel-title">修改</h3>
						</div>
					</div>
					<div class="panel-body">
						<form class="form-horizontal" onsubmit="return check()"
							role="form" id="updateBusFrom">
							<div class="form-group">
								<label for="lastname" class="col-sm-3 control-label">车牌号</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="busnumberUp"
										name="busnumberUp" placeholder="请输入车牌号">
								</div>
							</div>
							<div class="form-group">
								<label for="lastname" class="col-sm-3 control-label">承运商</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="carrierUp"
										name="carrierUp" placeholder="请输入承运商">
								</div>
							</div>
							<div class="form-group">
								<label for="lastname" class="col-sm-3 control-label">电话</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="driverphoneUp"
										name="driverphoneUp" placeholder="请输入电话号码">
								</div>
							</div>
							<div class="form-group">
								<label for="lastname" class="col-sm-3 control-label">线路名称</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="linenameUp"
										name="linenameUp" placeholder="请输入线路名称">
								</div>
							</div>
							<div class="form-group">
								<label for="firstname" class="col-sm-3 control-label">线路类型</label>
								<div class="col-sm-8">
									<select class="form-control" id="linetypeUp" name="linetypeUp">
									</select>
								</div>
							</div>
							<div class="form-group">
								<label for="lastname" class="col-sm-3 control-label">吨控</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="tonUp" name="tonUp"
										placeholder="吨控(必输项)">
								</div>
							</div>
							<div class="form-group">
								<label for="lastname" class="col-sm-3 control-label">备注</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="descriptionUp"
										name="descriptionUp" placeholder="备注">
								</div>
							</div>
							<div class="form-group">
								<label for="lastname" class="col-sm-3 control-label">作废</label>
								<div class="col-sm-8">
									<select class="form-control" id="useableUp">
										<option value="Y">激活</option>
										<option value="N">作废</option>
									</select>
								</div>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button id="subset_edit" type="button" class="btn btn-primary"
							data-dismiss="modal">提交更改</button>
						<button type="button" class="btn btn-default4"
							data-dismiss="modal">关闭</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>