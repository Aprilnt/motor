var TableInit = function() {
	var oTableInit = new Object();
	// 初始化Table
	oTableInit.Init = function() {
		$('#tb_departments').bootstrapTable({
			url : 'pickstandard/findAllPageQuery', // 请求后台的URL（*）
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
					pickstandardname : $("#txt_search_pickstandardname").val(),
					minweight : $("#txt_search_minweight").val(),
					maxweight : $("#txt_search_maxweight").val(),
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
			uniqueId : "pickstandardid", // 每一行的唯一标识，一般为主键列
			showToggle : true, // 是否显示详细视图和列表视图的切换按钮
			cardView : false, // 是否显示详细视图
			detailView : false, // 是否显示父子表
			columns : [ {
				checkbox : true
			}, {
				field : 'pickstandardname',
				title : '取派标准名'
			}, {
				field : 'minweight',
				title : '最大重量'
			}, {
				field : 'maxweight',
				title : '最小重量 '
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
		/*
		 * $("#btn_btn").click(function() { test();
		 * 
		 * });
		 */
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
								var pickstandardname = $("#pickstandardnameAdd").val();
								var minweight = $("#minweightAdd").val();
								var maxweight = $("#maxweightAdd").val();
								var description = $("#descriptionAdd").val();
								var useable = $("#useableAdd").val();

								if (pickstandardname == null || pickstandardname == "") {
									toastr.error('取派标准名不能为空');
								} else if (minweight == null || minweight == "") {
									toastr.error('最大重量不能为空');
								} else if (maxweight == null || maxweight == "") {
									toastr.error('最小重量不能为空');
								} else {
									// 异步同步数据库
									$.ajax({
										type : "post",
										url : 'pickstandard/add',
										data : {
											pickstandardname : pickstandardname,
											minweight : minweight,
											maxweight : maxweight,
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
						arrs[i] = select[i]['pickstandardid'];

						$('#tb_departments').bootstrapTable('remove', {
							field : 'pickstandardid',
							values : arrs
						});
					}
					$.ajax({
						type : "post",
						url : 'pickstandard/updateUseable',
						data : {
							pickstandardids : arrs
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
						arrs[i] = select[i]['pickstandardid'];

						$('#tb_departments').bootstrapTable('remove', {
							field : 'pickstandardid',
							values : arrs
						});
					}
					$.ajax({
						type : "post",
						url : 'pickstandard/updateUseableToYes',
						data : {
							pickstandardids : arrs
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
						var pickstandardname = [];
						var minweight = [];
						var maxweight = [];
						var description = [];
						// 获取单行数据
						for (var i = 0; i < select.length; i++) {
							pickstandardname[i] = select[i]['pickstandardname'];
							minweight[i] = select[i]['minweight'];
							maxweight[i] = select[i]['maxweight'];
							description[i] = select[i]['description'];
						}

						// 给模态框赋值
						$("#pickstandardnameUp").attr("value", pickstandardname);
						$("#minweightUp").attr("value", minweight);
						$("#maxweightUp").attr("value", maxweight);
						$("#descriptionUp").attr("value", description);
						$("#myModal-footer2").modal("show");

					}
					$("#updateLineFrom").data('bootstrapValidator').destroy();
					$('#updateLineFrom').data('bootstrapValidator', null);
					validatorU();

				});

		// 提交修改
		$("#subset_edit").click(function() {
			// 提交验证
			$("#updateLineFrom").bootstrapValidator('validate');
			if ($("#updateLineFrom").data('bootstrapValidator')
					.isValid() == false) {
				toastr.error('验证不通过！');
				return;
			} else {
				// 验证通过隐藏模态框
				$('#myModal-footer2').modal('hide');
				// 获取单行数据
				var select = $('#tb_departments').bootstrapTable(
						'getSelections');

				var pickstandardid = "";
				var pickstandardname = [];
				var minweight = [];
				var maxweight = [];
				var description = [];
				// 获取单行数据
				for (var i = 0; i < select.length; i++) {
					pickstandardid = select[i]['pickstandardid'];
					pickstandardname[i] = select[i]['pickstandardname'];
					minweight[i] = select[i]['minweight'];
					maxweight[i] = select[i]['maxweight'];
					description[i] = select[i]['description'];
				}

				// 获取输入框中数据
				var pickstandardname = $("#pickstandardnameUp").val();
				var minweight = $("#minweightUp").val();
				var maxweight = $("#maxweightUp").val();
				var description = $("#descriptionUp").val();

				$.ajax({
					type : "post",
					url : 'pickstandard/update',
					data : {
						pickstandardname : pickstandardname,
						minweight : minweight,
						maxweight : maxweight,
						description : description,
						pickstandardid : pickstandardid
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
						arrs[i] = select[i]['pickstandardid'];

						$('#tb_departments').bootstrapTable('remove', {
							field : 'pickstandardid',
							values : arrs
						});
					}
					$.ajax({
						type : "post",
						url : 'pickstandard/delete',
						data : {
							pickstandardids : arrs
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
			url : 'pickstandard/findAllPageQuery',
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
}// ===================================================================校验

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
	$('#addBusFrom').bootstrapValidator({
		message : 'This value is not valid',
		feedbackIcons : {
			valid : 'glyphicon glyphicon-ok',
			invalid : 'glyphicon glyphicon-remove',
			validating : 'glyphicon glyphicon-refresh'
		},
		fields : {
			pickstandardnameAdd : {
				message : '线路名验证失败!',
				validators : {
					notEmpty : {
						message : '线路名不能为空!',
					},
					stringLength : {
						min : 4,
						max : 10,
						message : '线路名长度必须在6到10位之间!'
					}
				}
			},
			pickstandardtypeAdd : {
				validators : {
					notEmpty : {
						message : '线路类型不能为空!'
					},
					regexp : {
						regexp : /^[\u4E00-\u9FA5]{2,4}$/,
						message : '线路类型只能为中文且2到4位例如:高速线路!'
					}
				}
			},
			pickstandardstartAdd : {
				validators : {
					notEmpty : {
						message : '开始站点不能为空!'
					},
					regexp : {
						regexp : /^[\u4E00-\u9FA5]{2,4}$/,
						message : '开始站点只能为中文且2到4位例如:长沙!'
					}
				}
			},
			pickstandardendAdd : {
				validators : {
					notEmpty : {
						message : '结束站点不能为空!'
					},
					regexp : {
						regexp : /^[\u4E00-\u9FA5]{2,4}$/,
						message : '结束站点只能为中文且2到4位例如:长沙!'
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
// 修改校验
function validatorU() {
	$('#updateLineFrom').bootstrapValidator({
		message : 'This value is not valid',
		feedbackIcons : {
			valid : 'glyphicon glyphicon-ok',
			invalid : 'glyphicon glyphicon-remove',
			validating : 'glyphicon glyphicon-refresh'
		},
		fields : {
			pickstandardnameUp : {
				message : '线路名验证失败!',
				validators : {
					notEmpty : {
						message : '线路名不能为空!',
					},
					stringLength : {
						min : 2,
						max : 10,
						message : '线路名长度必须在2到10位之间!'
					},
					regexp : {
						regexp : /^[\u4E00-\u9FA5A-Za-z0-9]+$/,
						message : '线路名不能含有特殊字符'
					}
				}
			},
			pickstandardtypeUp : {
				validators : {
					notEmpty : {
						message : '线路类型不能为空!'
					},
					regexp : {
						regexp : /^[\u4E00-\u9FA5]{2,6}$/,
						message : '线路类型只能为中文例如:快速线路!'
					}
				}
			},
			pickstandardstartUp : {
				validators : {
					notEmpty : {
						message : '开始站点不能为空!'
					},
					regexp : {
						regexp : /^[\u4e00-\u9fa5]{0,}$/,
						message : '开始站点要为中文!'
					}
				}
			},
			pickstandardendUp : {
				validators : {
					notEmpty : {
						message : '结束站点不能为空!'
					},
					regexp : {
						regexp : /^[\u4E00-\u9FA5]{0,}$/,
						message : '结束站点要为中文!'
					}
				}
			},
			directionUp : {
				validators : {
					notEmpty : {
						message : '方向不能为空!'
					},

				}
			}
		}
	});
}