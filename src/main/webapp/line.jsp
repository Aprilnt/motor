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
<title>线路设置</title>
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
		src="${APP_PATH}/jsps/base/line/js/line-table.js"></script>
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
				url : '${APP_PATH}/line/findAllPageQuery', // 请求后台的URL（*）
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
						linename : $("#txt_search_linename").val(),
						linetype : $("#txt_search_linetype").val(),
						linestart : $("#txt_search_linestart").val(),
						lineend : $("#txt_search_lineend").val(),
						direction : $("#txt_search_direction").val(),
						useable : $("#txt_search_useable").val()
					};
					return param;
				},// 传递参数（*）
				sidePagination : "server", // 分页方式：client客户端分页，server服务端分页（*）
				pageNumber : 1, // 初始化加载第一页，默认第一页
				pageSize : 10, // 每页的记录行数（*）
				pageList : [ 5, 10, 15, 20 ], // 可供选择的每页的行数（*）
				strictSearch : true,
				showColumns : true, // 是否显示所有的列
				showRefresh : true, // 是否显示刷新按钮
				minimumCountColumns : 2, // 最少允许的列数
				clickToSelect : true, // 是否启用点击选中行
				uniqueId : "lineid", // 每一行的唯一标识，一般为主键列
				showToggle : true, // 是否显示详细视图和列表视图的切换按钮
				cardView : false, // 是否显示详细视图
				detailView : false, // 是否显示父子表
				columns : [ {
					checkbox : true
				}, {
					field : 'linename',
					title : '线路名'
				}, {
					field : 'linetype',
					title : '线路类型'
				}, {
					field : 'linestart',
					title : '开始站点 '
				}, {
					field : 'lineend',
					title : '结束站点'
				}, {
					field : 'direction',
					title : '方向'
				}, {
					field : 'description',
					title : '备注'
				}, {
					field : 'useable',
					title : '状态',
					formatter : function(value, row, index) {
						if (row.useable == 'Y') {
							return '激活';
						} else {
							return '作废';
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
			/*
			 * $("#btn_btn").click(function() { test();
			 * 
			 * });
			 */

			$("#btn_sub").click(function() {

				var linename = $("#linenameAdd").val();
				var linetype = $("#linetypeAdd").val();
				var linestart = $("#linestartAdd").val();
				var lineend = $("#lineendAdd").val();
				var direction = $("#directionAdd").val();
				var description = $("#descriptionAdd").val();
				var useable = $("#useableAdd").val();

				if (linename == null || linename == "") {
					toastr.error('线路名不能为空');
				} else if (linetype == null || linetype == "") {
					toastr.error('线路类型不能为空');
				} else if (linestart == null || linestart == "") {
					toastr.error('开始站点不能为空');
				} else if (lineend == null || lineend == "") {
					toastr.error('结束站点不能为空');
				} else if (direction == null || direction == "") {
					toastr.error('方向不能为空');
				} else {
					// 异步同步数据库
					$.ajax({
						type : "post",
						url : '${APP_PATH}/line/add',
						data : {
							linename : linename,
							linetype : linetype,
							linestart : linestart,
							lineend : lineend,
							direction : direction,
							description : description,
							useable : useable
						},
						success : function(result) {
							if (result == "true") {
								toastr.success('添加成功!');
								$('#tb_departments').bootstrapTable('refresh');
							} else {
								toastr.error('添加失败!');
							}
						}

					});
				}
			});

			// 点击修改脚本打开模态框
			$("#btn_edit").click(
					function() {
						var select = $('#tb_departments').bootstrapTable(
								'getSelections');
						if (select.length === 0) {
							toastr.warning('请选择一行修改');
						} else if (select.length > 1) {
							toastr.warning('不能同时修改多行');
						} else {
							var linename = [];
							var linetype = [];
							var linestart = [];
							var lineend = [];
							var direction = [];
							var description = [];
							var useable = [];
							// 获取单行数据
							for (var i = 0; i < select.length; i++) {
								linename[i] = select[i]['linename'];
								linetype[i] = select[i]['linetype'];
								linestart[i] = select[i]['linestart'];
								lineend[i] = select[i]['lineend'];
								direction[i] = select[i]['direction'];
								description[i] = select[i]['description'];
								useable[i] = select[i]['useable'];
							}

							// 给模态框赋值
							$("#linenameUp").attr("value", linename);
							$("#linetypeUp").attr("value", linetype);
							$("#linestartUp").attr("value", linestart);
							$("#lineendUp").attr("value", lineend);
							$("#directionUp").attr("value", direction);
							$("#descriptionUp").attr("value", description);
							$("#useableUp").attr("value", useable);
							$("#myModal-footer2").modal("show");

						}

						clean();
						$("#updateBusFrom").data('bootstrapValidator')
								.destroy();
						$('#updateBusFrom').data('bootstrapValidator', null);
						validatorU();

					});

			// 提交修改
			$("#subset_edit").click(
					function() {

						// 获取单行数据
						var select = $('#tb_departments').bootstrapTable(
								'getSelections');

						var lineid = "";
						var linename = [];
						var linetype = [];
						var linestart = [];
						var lineend = [];
						var direction = [];
						var description = [];
						var useable = [];
						// 获取单行数据
						for (var i = 0; i < select.length; i++) {
							lineid = select[i]['lineid'];
							linename[i] = select[i]['linename'];
							linetype[i] = select[i]['linetype'];
							linestart[i] = select[i]['linestart'];
							lineend[i] = select[i]['lineend'];
							direction[i] = select[i]['direction'];
							description[i] = select[i]['description'];
							useable[i] = select[i]['useable'];
						}

						// 获取输入框中数据
						var linename = $("#linenameUp").val();
						var linetype = $("#linetypeUp").val();
						var linestart = $("#linestartUp").val();
						var lineend = $("#lineendUp").val();
						var direction = $("#directionUp").val();
						var description = $("#descriptionUp").val();
						var useable = $("#useableUp").val();

						$.ajax({
							type : "post",
							url : '${APP_PATH}/line/update',
							data : {
								linename : linename,
								linetype : linetype,
								linestart : linestart,
								lineend : lineend,
								linename : linename,
								direction : direction,
								description : description,
								useable : useable,
								lineid : lineid
							},
							success : function(msg) {
								if (msg == "true") {
									toastr.success('修改成功!');
									$('#tb_departments').bootstrapTable(
											'refresh');
								} else {
									toastr.error('修改失败!');
								}
							}
						});
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
									arrs[i] = select[i]['lineid'];

									$('#tb_departments').bootstrapTable(
											'remove', {
												field : 'lineid',
												values : arrs
											});
								}
								$.ajax({
									type : "post",
									url : '${APP_PATH}/line/delete',
									data : {
										lineids : arrs
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
				url : '${APP_PATH}/line/findAllPageQuery',
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
								linenameAdd : {
									message : '线路名验证失败!',
									validators : {
										notEmpty : {
											message : '线路名不能为空!',
										},
										stringLength : {
											min : 6,
											max : 10,
											message : '线路名长度必须在6到10位之间!'
										},
										regexp : {
											regexp : /^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$/,
											message : '车牌号格式不正确!'
										}
									}
								},
								linetypeAdd : {
									validators : {
										notEmpty : {
											message : '线路类型不能为空!'
										},
										regexp : {
											regexp : /^[\u4E00-\u9FA5]{2,4}$/,
											message : '线路类型只能为中文例如:张三!'
										}
									}
								},
								linestartAdd : {
									validators : {
										notEmpty : {
											message : '开始站点不能为空!'
										},
										regexp : {
											regexp : /^1(3|4|5|7|8)\d{9}$/,
											message : '电话号码格式不正确!'
										}
									}
								},
								lineendAdd : {
									validators : {
										notEmpty : {
											message : '结束站点不能为空!'
										},
										regexp : {
											regexp : /^[\u4E00-\u9FA5]{2,4}$/,
											message : '职员名只能为中文例如:张三!'
										}
									}
								},
								directionAdd : {
									validators : {
										notEmpty : {
											message : '方向不能为空!'
										},

									}
								}
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
								linenameAdd : {
									message : '线路名验证失败!',
									validators : {
										notEmpty : {
											message : '线路名不能为空!',
										},
										stringLength : {
											min : 6,
											max : 10,
											message : '线路名长度必须在6到10位之间!'
										},
										regexp : {
											regexp : /^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$/,
											message : '车牌号格式不正确!'
										}
									}
								},
								linetypeAdd : {
									validators : {
										notEmpty : {
											message : '线路类型不能为空!'
										},
										regexp : {
											regexp : /^[\u4E00-\u9FA5]{2,4}$/,
											message : '线路类型只能为中文例如:张三!'
										}
									}
								},
								linestartAdd : {
									validators : {
										notEmpty : {
											message : '开始站点不能为空!'
										},
										regexp : {
											regexp : /^1(3|4|5|7|8)\d{9}$/,
											message : '电话号码格式不正确!'
										}
									}
								},
								lineendAdd : {
									validators : {
										notEmpty : {
											message : '结束站点不能为空!'
										},
										regexp : {
											regexp : /^[\u4E00-\u9FA5]{2,4}$/,
											message : '职员名只能为中文例如:张三!'
										}
									}
								},
								directionAdd : {
									validators : {
										notEmpty : {
											message : '方向不能为空!'
										},

									}
								}
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
					<a data-toggle="collapse"
						href="#collapseOne"> 显示查询条件<span class="caret"></span> </a>
				</h4>
			</div>
			<div id="collapseOne" class="panel-collapse collapse in">
			<div class="panel-body">
				<form id="formSearch" class="form-horizontal">
					<div class="form-group" style="margin-top: 15px">
						<label class="control-label col-sm-1" for="txt_search_linename">线路名</label>
						<div class="col-sm-2">
							<input type="text" class="mhcys form-control"
								id="txt_search_linename" placeholder="请输入线路名">
						</div>
						<label class="control-label col-sm-1" for="txt_search_linetype">线路类型</label>
						<div class="col-sm-2">
							<input type="text" class="mhcys form-control"
								id="txt_search_linetype" placeholder="请输入线路类型">
						</div>
						<label class="control-label col-sm-1" for="txt_search_linestart">开始站点</label>
						<div class="col-sm-2">
							<input type="text" class="mhsj form-control"
								id="txt_search_linestart" placeholder="请输入开始站点">
						</div>
						<label class="control-label col-sm-1" for="txt_search_lineend">结束站点</label>
						<div class="col-sm-2">
							<input type="text" class="mhsj form-control"
								id="txt_search_lineend" placeholder="请输入结束站点">
						</div>
					</div>
					<div class="form-group" style="margin-top: 15px">
						<label class="control-label col-sm-1" for="txt_search_direction">方向</label>
						<div class="col-sm-2">
							<input type="text" class="mhsj form-control"
								id="txt_search_direction" placeholder="请输入线路类型">
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
									<label for="lastname" class="col-sm-3 control-label">线路名</label>
									<div class="col-sm-8">
										<input type="text" class="form-control" id="linenameAdd"
											name="linenameAdd" placeholder="请输入线路名">
									</div>
								</div>
								<div class="form-group">
									<label for="lastname" class="col-sm-3 control-label">线路类型</label>
									<div class="col-sm-8">
										<input type="text" class="form-control" id="linetypeAdd"
											name="linetypeAdd" placeholder="请输入线路类型">
									</div>
								</div>
								<div class="form-group">
									<label for="lastname" class="col-sm-3 control-label">开始站点</label>
									<div class="col-sm-8">
										<input type="text" class="form-control" id="linestartAdd"
											name="linestartAdd" placeholder="请输入开始站点">
									</div>
								</div>
								<div class="form-group">
									<label for="lastname" class="col-sm-3 control-label">结束站点</label>
									<div class="col-sm-8">
										<input type="text" class="form-control" id="lineendAdd"
											name="lineendAdd" placeholder="请输入结束站点">
									</div>
								</div>
								<div class="form-group">
									<label for="lastname" class="col-sm-3 control-label">方向</label>
									<div class="col-sm-8">
										<input type="text" class="form-control" id="directionAdd"
											name="directionAdd" placeholder="请输入方向">
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
								role="form" id="addBusFrom">
								<div class="form-group">
									<label for="lastname" class="col-sm-3 control-label">线路名</label>
									<div class="col-sm-8">
										<input type="text" class="form-control" id="linenameUp"
											name="linenameUp" placeholder="请输入线路名">
									</div>
								</div>
								<div class="form-group">
									<label for="lastname" class="col-sm-3 control-label">线路类型</label>
									<div class="col-sm-8">
										<input type="text" class="form-control" id="linetypeUp"
											name="linetypeUp" placeholder="请输入线路类型">
									</div>
								</div>
								<div class="form-group">
									<label for="lastname" class="col-sm-3 control-label">开始站点</label>
									<div class="col-sm-8">
										<input type="text" class="form-control" id="linestartUp"
											name="linestartUp" placeholder="请输入开始站点">
									</div>
								</div>
								<div class="form-group">
									<label for="lastname" class="col-sm-3 control-label">结束站点</label>
									<div class="col-sm-8">
										<input type="text" class="form-control" id="lineendUp"
											name="lineendUp" placeholder="请输入结束站点">
									</div>
								</div>
								<div class="form-group">
									<label for="lastname" class="col-sm-3 control-label">方向</label>
									<div class="col-sm-8">
										<input type="text" class="form-control" id="directionUp"
											name="directionUp" placeholder="请输入方向">
									</div>
								</div>
								<div class="form-group">
									<label for="lastname" class="col-sm-3 control-label">备注</label>
									<div class="col-sm-8">
										<input type="text" class="form-control" id="descriptionUp"
											placeholder="备注">
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