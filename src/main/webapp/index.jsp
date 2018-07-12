<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>班车线路管理</title>
<!-- Jquery组件引用 -->
<script type="text/javascript" src="${APP_PATH}/js/jquery-3.1.1.min.js"></script>

<!-- bootstrap组件引用 -->
<script type="text/javascript"
	src="${APP_PATH}/js/bootstrap/js/bootstrap.js"></script>
<link rel="stylesheet" type="text/css"
	href="${APP_PATH}/js/bootstrap/css/bootstrap.min.css">
</head>
<body>
	<div class="tabs-container">
		<div>

			<!-- Nav tabs -->
			<ul class="nav nav-tabs" role="tablist">
				<li role="presentation" class="active"><a href="#home"
					aria-controls="home" role="tab" data-toggle="tab">班车设置</a></li>
				<li role="presentation"><a href="#profile"
					aria-controls="profile" role="tab" data-toggle="tab">线路设置</a></li>
			</ul>

			<!-- Tab panes -->
			<div class="tab-content">
				<div role="tabpanel" class="tab-pane active" id="home">
					<iframe style="width: 100%; height: 600px; boxder: none"
						src="bus.jsp"></iframe>
				</div>
				<div role="tabpanel" class="tab-pane" id="profile">
					<iframe style="width: 100%; height: 600px; boxder: none"
						src="line.jsp"></iframe>
				</div>
			</div>
		</div>
	</div>
</body>
</html>