<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="db.DbConnection"%>
<%@page import="dto.WifiLocationHistory"%>
<%@page import="java.util.*"%>
<%
	int delId = request.getParameter("del") == null ? 0 : Integer.parseInt(request.getParameter("del"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>와이파이 정보 구하기</title>

<!-- JavaScript -->
<script type="text/javascript" src="js/Wifi_Function.js"></script>

<!-- CSS -->
<style>
#customers {
	font-family: Arial, Helvetica, sans-serif;
  	border-collapse: collapse;
  	width: 100%;
  	align-content: space-between;
}

#customers td, #customers th {
  	border: 1px solid #ddd;
  	padding: 8px;
}

#customers tr:nth-child(even){
	background-color: #f2f2f2;
}

#customers tr:hover {
	background-color: #ddd;
}

#customers th {
  	padding-top: 12px;
  	padding-bottom: 12px;
	text-align: center;
  	background-color: #04AA6D;
  	color: white;
}

div{
	margin: 10px;
}

ul {
	list-style: none;
	padding: 0;
}

li {
	display: inline;
}

</style>

</head>
<body>
	<div>
		<h1>위치 히스토리 목록</h1>
		
       	<ul>
           	<li>
           		<a href="main.jsp">홈</a>
           	</li>

			<li>
           		<label>|</label>
           	</li>

           	<li>
               	<a href="location-history.jsp">위치 히스토리 목록</a>
           	</li>

			<li>
           		<label>|</label>
           	</li>

           	<li>
               	<a href="information-insert.jsp">Open API 와이파이 정보 가져오기</a>
           	</li>
           	
           	<li>
           		<label>|</label>
           	</li>

           	<li>
               	<a href="bookmark-List.jsp">북마크 보기</a>
           	</li>
           	
           	<li>
           		<label>|</label>
           	</li>

           	<li>
               	<a href="bookmark-Group.jsp">북마크 그룹 관리</a>
           	</li>
           	
       	</ul>
	</div>
	 
	<table id="customers">
	<thead>
		<tr>
 			<th>ID</th>
		    <th>X좌표</th>
		    <th>Y좌표</th>
		    <th>조회일자</th>
		    <th>비고</th>
 		</tr>
	</thead>
	<tbody>
		<%
			DbConnection dbcon = new DbConnection();
		
			if(delId != 0){
				dbcon.wifiHistoryDeleteData(delId);
		%>
				<script type="text/javascript">
					alert('위치 히스토리를 삭제했습니다.');
				</script>
		<%
			}
		
			ArrayList<WifiLocationHistory> wifiHistoryList = dbcon.wifiHistorySelectData();
			if(!wifiHistoryList.isEmpty()){
				for (WifiLocationHistory historyList : wifiHistoryList) {
		%>
					<tr>
			 			<td>
			 				<%=historyList.getId()%>
			 			</td>
					    <td>
					    	<%=historyList.getLAT()%>
					    </td>
					    <td>
					    	<%=historyList.getLNT()%>
					    </td>
					    <td>
					    	<%=historyList.getIDT()%>
					    </td>
					    <td>
					    <form method="post" action="location-history.jsp">
					    	<button type="submit" name="del" style="margin-left: 42%;" value="<%=historyList.getId()%>">삭제</button>
					    </form>
					    </td>
			 		</tr>
	 		<%
				}
			} else {
			%>
				<tr>
					<td colspan="5" align="center">정보가 존재하지 않습니다.</td>
				</tr>
			<%
			}
	 		%>
	</tbody>
	</table>
</body>
</html>