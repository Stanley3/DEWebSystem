<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=gbk" />
    <title>退出登录-驾驶员培训科目三模拟考试系统管理后台</title>
  </head>
  <body>
    <%
    	response.setHeader("refresh", "3;URL=ZHWS/index.html");
    	session.invalidate();
     %>
     <h3>您已成功退出本系统，3秒后跳转回登录页面；</h3>
     <h3>如果没有跳转，请点击<a href="ZHWS/index.html">这里</a>。</h3>
  </body>
</html>
