<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="service.WifiService" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내  위치  기반  공공  와이파이  정보</title>

<!-- CSS -->
<style>
div{
	margin: 10px;
}

h1 {
	text-align: center;
}

a {
	margin-left: 48%;
}

</style>

</head>
<body>
	
<%
	WifiService wifiService = new WifiService();
   	int result = wifiService.wifiServiceToJson();

    if(result != -1){
        System.out.println("성공");
    } else {
        System.out.println("실패");
    }

    System.out.println(result); 
%>
	
	
	<div>
		<h1><%=result%> 개의 WIFI 정보를 정상적으로 저장했습니다.</h1>
		
       	<a href="main.jsp">홈으로 가기</a>
	</div>
	
	
</body>
</html>