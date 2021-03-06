var TableInit = function() {
	var oTableInit = new Object();
	// 初始化Table
	oTableInit.Init = function() {
		// 线路类型
		$.ajax({
			type : "post",
			async : false,
			url : 'bus/findLineNameAndId',
			success : function(response) {
				var html = "";
				for (var i = 0; i < response.length; i++) {
					html = html + "<option id='" + response[i].linetype + "'>"
							+ response[i].linetype + "</option>";
				}
				$("#txt_search_linetype").append(html);
			}
		});
		// 线路名称
		$.ajax({
			type : "post",
			async : false,
			url : 'bus/findLineNameAndId',
			success : function(response) {
				var html = "";
				for (var i = 0; i < response.length; i++) {
					html = html + "<option id='" + response[i].linename + "'>"
							+ response[i].linename + "</option>";
				}
				$("#txt_search_linename").append(html);
			}
		});
		// 司机
		$.ajax({
			type : "post",
			async : false,
			url : 'bus/findDriverNameAndId',
			success : function(response) {
				var html = "";
				for (var i = 0; i < response.length; i++) {
					html = html + "<option id='" + response[i].dispatchername
							+ "'>" + response[i].dispatchername + "</option>";
				}
				$("#txt_search_driver").append(html);
			}
		});

		$('#tb_departments').bootstrapTable({
			url : 'bus/findAllPageQuery', // 请求后台的URL（*）
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
			},/*
				 * { field : 'bustype', title : '车型' },
				 */{
				field : 'linetype',
				title : '线路类型'
			}, {
				field : 'linename',
				title : '线路名称'
			},/*
				 * { field : 'operationStaffId', title : '操作人' }, { field :
				 * 'operateUnit', title : '操作单位' }, { field : 'operateTime',
				 * title : '操作时间' },
				 */{
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
							// 提交验证
							$("#addBusFrom").bootstrapValidator('validate');
							if ($("#addBusFrom").data('bootstrapValidator')
									.isValid() == false) {
								toastr.error('验证不通过！');
								return;
							} else {
								// 验证通过隐藏模态框
								$('#myModal').modal('hide');
								// 清空模态框中的表单数据
								$('#myModal').on('hidden.bs.modal', function() {
									$("#myModal input").val("");
								})
								var busnumber = $("#busnumberAdd").val();
								var carrier = $("#carrierAdd").val();
								// 获取司机下拉框的值
								var staffId = "";
								// 获取基础档案的Id
								for (var i = 0; i < $("#driverAdd").children().length; i++) {
									if ($("#driverAdd").children()[i].selected) {
										staffId = $(
												$("#driverAdd").children()[i])
												.attr("id");
									}
								}
								var driver = staffId;
								var driverphone = $("#driverphoneAdd").val();
								// 获取线路名称下拉框的值
								var subsetId = "";
								// 获取基础档案的Id
								for (var i = 0; i < $("#linenameAdd")
										.children().length; i++) {
									if ($("#linenameAdd").children()[i].selected) {
										subsetId = $(
												$("#linenameAdd").children()[i])
												.attr("id");
									}
								}
								var linename = subsetId;
								// 获取线路类型下拉框的值
								var subsetId = "";
								// 获取基础档案的Id
								for (var i = 0; i < $("#linetypeAdd")
										.children().length; i++) {
									if ($("#linetypeAdd").children()[i].selected) {
										subsetId = $(
												$("#linetypeAdd").children()[i])
												.attr("id");
									}
								}
								var linetype = subsetId;
								/*
								 * var operationStaffId =
								 * $("#operationStaffIdAdd").val(); var
								 * operateUnit = $("#orgName").val();
								 * alert(operateUnit); var operateTime =
								 * $("#operateTimeAdd").val();
								 */
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
								}/*
									 * else if (operationStaffId == null ||
									 * operationStaffId == "") {
									 * toastr.error('操作人不能为空'); } else if
									 * (operateUnit == null || operateUnit ==
									 * "") { toastr.error('操作单位不能为空'); }
									 */else if (ton == null || ton == "") {
									toastr.error('吨控不能为空');
								} else {
									// 异步同步数据库
									$.ajax({
										type : "post",
										url : 'bus/add',
										data : {
											busnumber : busnumber,
											carrier : carrier,
											driver : driver,
											driverphone : driverphone,
											/* bustype : bustype, */
											linetype : linetype,
											linename : linename,
											/*
											 * operationStaffId :
											 * operationStaffId, operateUnit :
											 * operateUnit,
											 */
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
						var busnumber = [];
						var carrier = [];
						var driver = [];
						var driverphone = [];
						/* var bustype = []; */
						var linetype = [];
						var linename = [];
						/*
						 * var operationStaffId = []; var operateUnit = []; var
						 * operateTime = [];
						 */
						var ton = [];
						var description = [];
						// 获取单行数据
						for (var i = 0; i < select.length; i++) {
							busnumber[i] = select[i]['busnumber'];
							carrier[i] = select[i]['carrier'];
							driver[i] = select[i]['driver'];
							driverphone[i] = select[i]['driverphone'];
							/* bustype[i] = select[i]['bustype']; */
							linetype[i] = select[i]['linetype'];
							linename[i] = select[i]['linename'];
							/*
							 * operationStaffId[i] =
							 * select[i]['operationStaffId']; operateUnit[i] =
							 * select[i]['operateUnit']; operateTime[i] =
							 * select[i]['operateTime'];
							 */
							ton[i] = select[i]['ton'];
							description[i] = select[i]['description'];
						}

						// 给模态框赋值
						$("#busnumberUp").attr("value", busnumber);
						$("#carrierUp").attr("value", carrier);
						$("#driverUp").attr("value", driver);
						$("#driverphoneUp").attr("value", driverphone);
						/* $("#bustypeUp").attr("value", bustype); */
						$("#linetypeUp").attr("value", linetype);
						$("#linenameUp").attr("value", linename);
						/*
						 * $("#operationStaffIdUp").attr("value",
						 * operationStaffId); $("#operateUnitUp").attr("value",
						 * operateUnit); $("#operateTimeUp").attr("value",
						 * operateTime);
						 */
						$("#tonUp").attr("value", ton);
						$("#descriptionUp").attr("value", description);

						$("#myModal-footer2").modal("show");

					}

					clean();
					// 司机名
					$.ajax({
						url : 'bus/findDriverNameAndId',
						type : "post",
						async : true,
						success : function(response) {
							var html = "<option>" + driver + "</option>";
							for (var i = 0; i < response.length; i++) {
								html = html + "<option id='"
										+ response[i].dispatchername + "'>"
										+ response[i].dispatchername
										+ "</option>";
							}
							$("#driverUp").append(html);
							$(".selectpicker").selectpicker("refresh");
						}

					});
					// 线路名称
					$.ajax({
						type : "post",
						async : false,
						url : 'bus/findLineNameAndId',
						success : function(response) {
							var html = "<option>" + linename + "</option>";
							for (var i = 0; i < response.length; i++) {
								html = html + "<option id='"
										+ response[i].linename + "'>"
										+ response[i].linename + "</option>";
							}
							$("#linenameUp").append(html);
							$(".selectpicker").selectpicker("refresh");
						}
					});
					// 线路类型
					$.ajax({
						type : "post",
						async : false,
						url : 'bus/findLineNameAndId',
						success : function(response) {
							var html = "<option>" + linetype + "</option>";
							for (var i = 0; i < response.length; i++) {
								html = html + "<option id='"
										+ response[i].linetype + "'>"
										+ response[i].linetype + "</option>";
							}
							$("#linetypeUp").append(html);
							$(".selectpicker").selectpicker("refresh");
						}
					});
					$("#updateBusFrom").data('bootstrapValidator').destroy();
					$('#updateBusFrom').data('bootstrapValidator', null);
					validatorU();

				});

		// 提交修改
		$("#subset_edit").click(function() {
			// 提交验证
			$("#updateBusFrom").bootstrapValidator('validate');
			if ($("#updateBusFrom").data('bootstrapValidator')
					.isValid() == false) {
				toastr.error('验证不通过！');
				return;
			} else {
				// 验证通过隐藏模态框
				$('#myModal-footer2').modal('hide');
			// 获取单行数据
			var select = $('#tb_departments').bootstrapTable('getSelections');
			var busid = "";
			var busnumber = [];
			var carrier = [];
			var driver = [];
			var driverphone = [];
			/* var bustype = []; */
			var linetype = [];
			var linename = [];
			/*
			 * var operationStaffId = []; var operateUnit = []; var operateTime =
			 * [];
			 */
			var ton = [];
			var description = [];
			// 获取单行数据
			for (var i = 0; i < select.length; i++) {
				busid = select[i]['busid'];
				busnumber[i] = select[i]['busnumber'];
				carrier[i] = select[i]['carrier'];
				driver[i] = select[i]['driver'];
				driverphone[i] = select[i]['driverphone'];
				/* bustype[i] = select[i]['bustype']; */
				linetype[i] = select[i]['linetype'];
				linename[i] = select[i]['linename'];
				/*
				 * operationStaffId[i] = select[i]['operationStaffId'];
				 * operateUnit[i] = select[i]['operateUnit']; operateTime[i] =
				 * select[i]['operateTime'];
				 */
				ton[i] = select[i]['ton'];
				description[i] = select[i]['description'];
			}

			// 获取输入框中数据
			var busnumber = $("#busnumberUp").val();
			var carrier = $("#carrierUp").val();
			// var driver = $("#driverUp").val();
			var driver = $("#driverUp").val();
			var driverphone = $("#driverphoneUp").val();
			var linename = $("#linenameUp").val();
			var linetype = $("#linetypeUp").val();
			/*
			 * var operationStaffId = $("#operationStaffIdUp").val(); var
			 * operateUnit = $("#operateUnitUp").val(); var operateTime =
			 * $("#operateTimeUp").val();
			 */
			var ton = $("#tonUp").val();
			var description = $("#descriptionUp").val();

			$.ajax({
				type : "post",
				url : 'bus/update',
				data : {
					busnumber : busnumber,
					carrier : carrier,
					driver : driver,
					driverphone : driverphone,
					/* bustype : bustype, */
					linetype : linetype,
					linename : linename,
					ton : ton,
					description : description,
					busid : busid
				},
				success : function(msg) {
					if (msg == "true") {
						toastr.success('修改成功!');
						$('#tb_departments').bootstrapTable('refresh');
					} else {
						toastr.error('修改失败!');
					}
				}
			});
			}
		});
		$("#btn_forzen").click(function() {
			var select = $('#tb_departments').bootstrapTable('getSelections');
			if (select.length === 0) {
				toastr.warning('请至少选择一行冻结');
			} else {
				// 遍历，如果选择的用户中有已被禁用的，给出提示，退出!
				for (var i = 0; i < select.length; i++) {
					if (select[i].useable == "N") {
						toastr.warning('您选择的目标用户中有已被禁用的');
						return;
					}
				}
				swal({
					title : "操作提示", // 弹出框的title
					text : "确定冻结吗？", // 弹出框里面的提示文本
					type : "warning", // 弹出框类型
					showCancelButton : true, // 是否显示取消按钮
					confirmButtonColor : "#DD6B55",// 确定按钮颜色
					cancelButtonText : "取消",// 取消按钮文本
					confirmButtonText : "是的，确定冻结！",// 确定按钮上面的文档
					closeOnConfirm : true
				}, function() {
					var arrs = [];
					for (var i = 0; i < select.length; i++) {
						arrs[i] = select[i]['busid'];

						$('#tb_departments').bootstrapTable('remove', {
							field : 'busid',
							values : arrs
						});
					}
					$.ajax({
						type : "post",
						url : 'bus/updateUseable',
						data : {
							busids : arrs
						},
						success : function(result) {
							if (result == "success") {
								toastr.success('冻结成功!');
								$('#tb_departments').bootstrapTable('refresh');

							} else {
								toastr.error('冻结失败!');
							}
						}

					});

				});

			}

		});
		$("#btn_recover").click(function() {
			var select = $('#tb_departments').bootstrapTable('getSelections');
			if (select.length === 0) {
				toastr.warning('请至少选择一行解冻');
			} else {
				// 遍历，如果选择的用户中有已被禁用的，给出提示，退出!
				for (var i = 0; i < select.length; i++) {
					if (select[i].useable == "Y") {
						toastr.warning('您选择的目标用户中有激活的');
						return;
					}
				}
				swal({
					title : "操作提示", // 弹出框的title
					text : "确定激活吗？", // 弹出框里面的提示文本
					type : "warning", // 弹出框类型
					showCancelButton : true, // 是否显示取消按钮
					confirmButtonColor : "#DD6B55",// 确定按钮颜色
					cancelButtonText : "取消",// 取消按钮文本
					confirmButtonText : "是的，确定激活！",// 确定按钮上面的文档
					closeOnConfirm : true
				}, function() {
					var arrs = [];
					for (var i = 0; i < select.length; i++) {
						arrs[i] = select[i]['busid'];

						$('#tb_departments').bootstrapTable('remove', {
							field : 'busid',
							values : arrs
						});
					}
					$.ajax({
						type : "post",
						url : 'bus/updateUseableToYes',
						data : {
							busids : arrs
						},
						success : function(result) {
							if (result == "success") {
								toastr.success('解冻成功!');
								$('#tb_departments').bootstrapTable('refresh');

							} else {
								toastr.error('解冻失败!');
							}
						}

					});

				});

			}

		});
		$("#btn_delete").click(function() {
			var select = $('#tb_departments').bootstrapTable('getSelections');
			if (select.length === 0) {
				toastr.warning('请至少选择一行删除');
			} else {
				swal({
					title : "操作提示", // 弹出框的title
					text : "确定删除吗？", // 弹出框里面的提示文本
					type : "warning", // 弹出框类型
					showCancelButton : true, // 是否显示取消按钮
					confirmButtonColor : "#DD6B55",// 确定按钮颜色
					cancelButtonText : "取消",// 取消按钮文本
					confirmButtonText : "是的，确定删除！",// 确定按钮上面的文档
					closeOnConfirm : true
				}, function() {
					var arrs = [];
					for (var i = 0; i < select.length; i++) {
						arrs[i] = select[i]['busid'];

						$('#tb_departments').bootstrapTable('remove', {
							field : 'busid',
							values : arrs
						});
					}
					$.ajax({
						type : "post",
						url : 'bus/delete',
						data : {
							busids : arrs
						},
						success : function(result) {
							if (result == "success") {
								toastr.success('删除成功!');
								$('#tb_departments').bootstrapTable('refresh');

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
	// 1.初始化Table
	var oTable = new TableInit();
	oTable.Init();

	// 2.初始化Button的点击事件
	var oButtonInit = new ButtonInit();
	oButtonInit.Init();
	// 点击查询按钮触发点击事件
	$("#btn_query").click(function() {

		$('#tb_departments').bootstrapTable("refresh", {
			url : 'bus/findAllPageQuery',
			queryParams : oTable.queryParams
		});
	});

	// 新增按钮
	$("#btn_add").click(function() {
		clean();
		getDataInsert();
		$("#addBusFrom").data('bootstrapValidator').destroy();
		$('#addBusFrom').data('bootstrapValidator', null);
		validator();

	});

	// 初始化操作消息提示框
	toastr.options = {
		closeButton : false, // 是否显示关闭按钮
		debug : false, // 是否为调试
		progressBar : true, // 是否显示进度条
		positionClass : "toast-top-center", // 在页面中显示的位置
		onclick : null, // 点击事件
		showDuration : "100", // 显示动作时间
		hideDuration : "1000", // 隐藏动作时间
		timeOut : "2000", // 自动关闭超时时间
		extendedTimeOut : "1000",
		showEasing : "swing",
		hideEasing : "linear",
		preventDuplicates : true,
		preventOpenDuplicates : true, // 重复内容的提示框在开启时只出现一个
		showMethod : "fadeIn", // 显示的方式
		hideMethod : "fadeOut" // 隐藏的方式
	};

});

function useable() {
	$('body').css('overflow', 'auto');
	$('body').css('padding-right', '0px');
	$('.model').addClass('hide');
	$('.model-dialog').addClass('hide');
}

function check() {

	// 校验逻辑

	return false;
}

// 获取各种下拉列表的数据
function getDataInsert() {
	// 司机名
	$.ajax({
		type : "post",
		async : false,
		url : 'bus/findDriverNameAndId',
		success : function(response) {
			var html = "<option value=''>请选择司机</option>";
			for (var i = 0; i < response.length; i++) {
				html = html + "<option id='" + response[i].dispatchername
						+ "'>" + response[i].dispatchername + "</option>";
			}
			$("#driverAdd").append(html);
			$(".selectpicker").selectpicker("refresh");
		}
	});
	// 线路名称
	$.ajax({
		type : "post",
		async : false,
		url : 'bus/findLineNameAndId',
		success : function(response) {
			var html = "<option value=''>请选择线路名称</option>";
			for (var i = 0; i < response.length; i++) {
				html = html + "<option id='" + response[i].linename + "'>"
						+ response[i].linename + "</option>";
			}
			$("#linenameAdd").append(html);
			$(".selectpicker").selectpicker("refresh");
		}
	});
	// 线路类型
	$.ajax({
		type : "post",
		async : false,
		url : 'bus/findLineNameAndId',
		success : function(response) {
			var html = "<option value=''>请选择线路类型</option>";
			for (var i = 0; i < response.length; i++) {
				html = html + "<option id='" + response[i].linetype + "'>"
						+ response[i].linetype + "</option>";
			}
			$("#linetypeAdd").append(html);
			$(".selectpicker").selectpicker("refresh");
		}
	});

}

// 清除方法
function clean() {
	$("#driverAdd").children("option").remove();
	$("#linenameAdd").children("option").remove();
	$("#linetypeAdd").children("option").remove();

	$("#driverUp").children("option").remove();
	$("#linenameUp").children("option").remove();
	$("#linetypeUp").children("option").remove();

}

// ===================================================================校验

// 清除提示
function useablePrompt(obj) {
	$("#" + obj.id + "_prompt").text("");
};

// 修改按钮再次验证
function verificationU() {
	checkPhoneU(updatedriverphone);
};
// 添加校验
function validator() {
	$('#addBusFrom')
			.bootstrapValidator(
					{
						message : 'This value is not valid',
						/* submitButtons: '#btn_sub', */
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
									regexp : {
										regexp : /^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$/,
										message : '车牌号格式不正确!'
									}
								}
							},
							driverAdd : {
								validators : {
									notEmpty : {
										message : '司机不能为空!'
									}
								}
							},
							carrierAdd : {
								validators : {
									notEmpty : {
										message : '承运商不能为空!'
									},
									regexp : {
										regexp : /^[\u4E00-\u9FA5]{0,}$/,
										message : '承运商只能为中文例如:长沙承运公司'
									}
								}
							},
							driverphoneAdd : {
								validators : {
									notEmpty : {
										message : '手机号码不能为空!'
									},
									regexp : {
										regexp : /^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\d{8}$/,
										message : '手机号码格式不正确!'
									}
								}
							},
							linenameAdd : {
								validators : {
									notEmpty : {
										message : '线路名称不能为空!'
									}
								}
							},
							linetypeAdd : {
								validators : {
									notEmpty : {
										message : '线路类型不能为空!'
									}
								}
							},
							tonAdd : {
								validators : {
									notEmpty : {
										message : '吨控不能为空!'
									},
									greaterThan : {
										value : 0,
										message : '输入值不能为负数'
									},
									regexp : {
										regexp : /^[0-9]+(.[0-9]{1,2})?$/,
										message : '输入值格式不正确!'
									}
								}
							},
						}
					});
};
// 修改校验
function validatorU() {
	$('#updateBusFrom')
			.bootstrapValidator(
					{
						message : 'This value is not valid',
						/* submitButtons: '#btn_sub', */
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
							carrierUp : {
								validators : {
									notEmpty : {
										message : '承运商不能为空!'
									},
									regexp : {
										regexp : /^[\u4E00-\u9FA5]{0,}$/,
										message : '承运商只能为中文例如:长沙承运公司'
									}
								}
							},
							driverphoneUp : {
								validators : {
									notEmpty : {
										message : '手机号码不能为空!'
									},
									regexp : {
										regexp : /^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\d{8}$/,
										message : '手机号码格式不正确!'
									}
								}
							},
							linetypeUp : {
								validators : {
									notEmpty : {
										message : '线路类型不能为空!'
									}
								}
							},
							driverUp : {
								validators : {
									notEmpty : {
										message : '司机不能为空!'
									}
								}
							},
							linenameUp : {
								validators : {
									notEmpty : {
										message : '线路名称不能为空!'
									}
								}
							},
							tonUp : {
								validators : {
									notEmpty : {
										message : '吨控不能为空!'
									},
									greaterThan : {
										value : 0,
										message : '输入值不能为负数'
									},
									regexp : {
										regexp : /^[0-9]+(.[0-9]{1,2})?$/,
										message : '输入值格式不正确!'
									}
								}
							},
						}
					});
};
