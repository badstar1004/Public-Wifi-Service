<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="db.DbConnection"%>
<%@page import="dto.BookMarkGroup"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<%
	DbConnection dbcon = new DbConnection();
	request.setCharacterEncoding("UTF-8");
	String updateId = request.getParameter("bookGroupMarkID");
	ArrayList<BookMarkGroup> bookMarkGroupList = dbcon.bookMarkGroupSelectData(updateId);
%>

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

<title>와이파이 정보 구하기</title>
</head>
<body>
	<div>
		<h1>북마크 그룹 수정</h1>

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
		<%
			for(BookMarkGroup bookMarkGroup : bookMarkGroupList){
		%>
				<tr>
		 			<th>북마크 그룹 이름</th>
		 			<td>
		 				<input id="bookMarkName" name="bookMarkName" type="text" maxlength="50" value="<%=bookMarkGroup.getBookMarkName()%>">
		 			</td>
		 		</tr>
		 		<tr>
		   			<th>순서</th>
		   			<td>
		   				<input id="bookMarkSeq" name="bookMarkSeq" type="number" value="<%=bookMarkGroup.getSeq()%>">
		   			</td>
		 		</tr>
		<%
			}
		%>
 		 <tr>
   			<td style="text-align: center;" colspan="2">
   				<a href="bookmark-Group.jsp">돌아가기</a>
   				<label>|</label>
   				<form action="bookmark-Group.jsp" onsubmit="return updateBookMark(<%=updateId%>);">
   					<button type="submit" id="bookMarkUpdate" name="bookMarkUpdate">수정</button>
   				</form>
   			</td>
 		</tr>
	</table>
</body>
</html>