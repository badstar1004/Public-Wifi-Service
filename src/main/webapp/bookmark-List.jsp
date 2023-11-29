<%@page import="java.io.Console"%>
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
	String bookMarkAddData = request.getParameter("groupList");
	String wifiMgmtNo = request.getParameter("mgmtNo");
	String wifiName = request.getParameter("wifiName");
	
	DbConnection dbcon = new DbConnection();
	
	if(bookMarkAddData != null){
		
		int insertCnt = dbcon.bookMarkAdd(bookMarkAddData, wifiMgmtNo, wifiName);
		
		if(insertCnt >= 0){
%>
			<script type="text/javascript">
				alert('북마크를 추가했습니다.');
			</script>
<%
		}
	}
	
	String bookMarkDeleteData = request.getParameter("bookMarkId");
	if(bookMarkDeleteData != null){
		int insertCnt = dbcon.bookMarkDelete(bookMarkDeleteData);
		
		if(insertCnt >= 0){
%>
			<script type="text/javascript">
				alert('북마크를 삭제했습니다.');
			</script>
<%
		}
	}
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
		<h1>북마크 보기</h1>

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
				<th>북마크 그룹 이름</th>
				<th>와이파이명</th>
				<th>등록일자</th>
				<th>비고</th>
			</tr>
		</thead>
		<tbody>
			<%
				ArrayList<BookMarkList> bookMarkList = dbcon.bookMarkSelectData("");
				if (!bookMarkList.isEmpty()) {
					for (BookMarkList item : bookMarkList) {
			%>
						<tr>
							<td><%=item.getId()%></td>
							<td id="bookMarkName" name="updateName"><%=item.getBookMarkGroupName()%></td>
							<td id="seq" name="updateSeq"><%=item.getX_SWIFI_MAIN_NM()%></td>
							<td><%=item.getIdt()%></td>
							<td align="center">
								<a href="bookmark-Delete.jsp?bookMarkID=<%=item.getId()%>">삭제</a>
							</td>
						</tr>
			<%
					}
				} else {
			%>
					<tr>
						<td colspan="6" align="center">정보가 존재하지 않습니다.</td>
					</tr>
			<%
				}
			%>
		</tbody>
	</table>
</body>
</html>