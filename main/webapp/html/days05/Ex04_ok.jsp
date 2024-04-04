<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 	

	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	System.out.printf("id : %s \n password : %s\n", id, passwd);
	
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- http://localhost/webPro/html/days05/Ex04_ok.jsp?id=%ED%99%8D%EA%B8%B8%EB%8F%99&passwd=1234 -->
<title>Insert title here</title>
</head>
<body>
<h3>ex04_ok.jsp</h3>
<%-- 입력한 아이디 : <% out.append(id); %><br>
입력한 비밀번호 : <%  = passwd %><br> --%>
</body>
</html>