<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=gbk" />
    <title>�˳���¼-��ʻԱ��ѵ��Ŀ��ģ�⿼��ϵͳ�����̨</title>
  </head>
  <body>
    <%
    	response.setHeader("refresh", "3;URL=ZHWS/index.html");
    	session.invalidate();
     %>
     <h3>���ѳɹ��˳���ϵͳ��3�����ת�ص�¼ҳ�棻</h3>
     <h3>���û����ת������<a href="ZHWS/index.html">����</a>��</h3>
  </body>
</html>
