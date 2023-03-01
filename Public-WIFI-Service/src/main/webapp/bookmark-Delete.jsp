<%@page import="javax.swing.plaf.synth.SynthOptionPaneUI"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="db.DbConnection"%>
<%@page import="dto.BookMarkList"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<%
	request.setCharacterEncoding("UTF-8");
	String bookMarkId = request.getParameter("bookMarkID");
	
	DbConnection dbcon = new DbConnection();
	ArrayList<BookMarkList> bookMarkList = dbcon.bookMarkSelectData(bookMarkId);
%>

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

#customers tr:nth-child(even) {
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

div {
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
		<h1>북마크 삭제</h1>

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
	<div>
		<p>북마크를 삭제하시겠습니까?</p>
	</div>

	<table id="customers">
		<%
			for(BookMarkList item : bookMarkList){
		%>
		 		<tr>
		   			<th>북마크 이름</th>
		   			<td>
		   				<%=item.getBookMarkGroupName()%>
		   			</td>
		 		</tr>
		 		<tr>
		   			<th>와이파이명</th>
		   			<td>
		   				<%=item.getX_SWIFI_MAIN_NM()%>
		   			</td>
		 		</tr>
		 		<tr>
		   			<th>등록일자</th>
		   			<td>
		   				<%=item.getIdt()%>
		   			</td>
		 		</tr>
		<%
			}
		%>
 		 <tr>
   			<td style="text-align: center;" colspan="2">
   				<a href="bookmark-List.jsp">돌아가기</a>
   				<label>|</label>
   				<form action="bookmark-List.jsp">
   					<button type="submit" id="bookMarkDelete" name="bookMarkDelete">삭제</button>
   					<input type="hidden" id="bookMarkId" name="bookMarkId" value="<%=bookMarkId%>">
   				</form>
   			</td>
 		</tr>
	</table>
</body>
</html>