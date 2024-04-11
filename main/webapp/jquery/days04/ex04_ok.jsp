<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image/x-icon" href="http://localhost/webPro/images/SiSt.ico">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="http://localhost/webPro/resources/cdn-main/example.css">
<script src="http://localhost/webPro/resources/cdn-main/example.js"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<title>Insert title here</title>
</head>
<div>
	<!-- // 스크립트릿 - 자바코딩
	// 요청할때의 모든 정보를 가지고있는 객체 request (파라미터 가져오기) -->
	
	<% String subject = request.getParameter("subject"); 
 	   System.out.printf("전송된 subject = %s\n", subject);
 	%>
<body>
	<input id="kor" type="radio" name="subject" value="kor"><label for="">국어</label>
	<input type="radio" name="subject" value="eng"><label for="">영어</label>
	<input type="radio" name="subject" value="mat"><label for="">수학</label>
	<input type="radio" name="subject" value="pe"><label for="">체육</label>
<br>
<br>
<!-- <a href="javascript:history.go(-1)">뒤로가기</a> -->
<a href="javascript:history.back()">뒤로가기</a>
</div>
<script>


	let subject = '<%= subject %>';
	
	// [2]
	$(`:radio[name=subject][value=\${subject}]`).attr("checked", true);
	
	// [1]
/* 	$(":radio[name=subject]").each( function ( index, element ){
		if( element.value == subject ){
			element.checked = true;
			return;
		}
	}); */
	
	
	
</script>
</body>
</html>