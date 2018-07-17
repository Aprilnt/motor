<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page isELIgnored="false"%>
<%
	String userName = request.getParameter("userName");
	request.getSession().setAttribute("userName", userName);

	String orgName = request.getParameter("orgName");
	pageContext.setAttribute("APP_PATH", request.getContextPath());
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>" />
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
<script type="text/javascript" src="${APP_PATH}/jsps/js/line.js">
</script>
</head>
<body>
	<div class="panel-body" style="padding-bottom: 0px;">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h4 class="panel-title">
					<a data-toggle="collapse"
						href="#collapseTwo"> 显示查询条件<span class="caret"></span> </a>
				</h4>
			</div>
			<div id="collapseTwo" class="panel-collapse collapse in">
			<div class="panel-body">
				<form id="formSearch" class="form-horizontal">
					<div class="form-group" style="margin-top: 15px">
						<label class="control-label col-sm-1" for="txt_search_linename">线路名</label>
						<div class="col-sm-2">
								<select class="form-control" id="txt_search_linename">
									<option value="">选择查询的线路名称</option>
								</select>
						</div>
						<label class="control-label col-sm-1" for="txt_search_linetype">线路类型</label>
						<div class="col-sm-2">
								<select class="form-control" id="txt_search_linetype">
									<option value="">选择查询的线路类型</option>
								</select>
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
							<select class="form-control" id="txt_search_direction"
								name="linetypeAdd">
								<option value="">选择您要查询的方向</option>
								<option value="Y">正方向</option>
								<option value="N">反方向</option>
							</select>
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
										<select class="form-control" id="directionAdd">
											<option value="">请选择方向</option>
											<option value="Y">正方向</option>
											<option value="N">反方向</option>
										</select>
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
									<select class="form-control" id="directionUp">
										<option value="Y">正方向</option>
										<option value="N">反方向</option>
									</select>
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