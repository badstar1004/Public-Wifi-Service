<%@page import="javax.swing.plaf.synth.SynthOptionPaneUI"%>
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
%>
<%
	request.setCharacterEncoding("UTF-8");
	String bookMarkGroupAddData = request.getParameter("bookMarkAdd");

	if (bookMarkGroupAddData != null) {
		int idx = request.getParameter("bookMarkAdd").indexOf(",");
	
		String bookMarkName = bookMarkGroupAddData.substring(0, idx);
		String bookMarkSeq = bookMarkGroupAddData.substring(idx + 1);
	
		int insertCnt = dbcon.bookMarkGroupInsert(bookMarkName, bookMarkSeq);
		if(insertCnt >= 0){
%>
			<script type="text/javascript">
				alert('북마크 그룹 정보를 추가했습니다.');
			</script>
<%
		}
	}
	
	String bookMarkGroupUpdateData = request.getParameter("bookMarkUpdate");
	if (bookMarkGroupUpdateData != null) {
		String[] updateData = bookMarkGroupUpdateData.split(",");
	
		int UpdateCnt = dbcon.bookMarkGroupUpdate(updateData[0], updateData[1], updateData[2]);
		if(UpdateCnt >= 0){
%>
			<script type="text/javascript">
				alert('북마크 그룹 정보를 수정했습니다.');
			</script>
<%
		}
	}
	
	String groupID = request.getParameter("groupId");
	if(groupID != null){
		int result = dbcon.bookMarkGroupDelete(groupID);
		
		if(result >= -1){
			if(result == 0){
%>
				<script type="text/javascript">
					alert('북마크 그룹 정보를 삭제했습니다.');
					location.href='bookmark-Group.jsp';
				</script>
<%
			} else if(result == 1){
%>
				<script type="text/javascript">
					alert('해당 북마크 그룹에 추가된 북마크 정보가 있습니다.');
					location.href='bookmark-Group.jsp';
				</script>
<%
			}
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
		<h1>북마크 그룹</h1>

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

		<form action="bookmark-Group-Insert.jsp">
			<button type="submit">북마크 그룹 이름 추가</button>
		</form>

	</div>

	<table id="customers">
		<thead>
			<tr>
				<th>ID</th>
				<th>북마크 그룹 이름</th>
				<th>순서</th>
				<th>등록일자</th>
				<th>수정일자</th>
				<th>비고</th>
			</tr>
		</thead>
		<tbody>
			<%
				ArrayList<BookMarkGroup> bookMarkGroupList = dbcon.bookMarkGroupSelectData("");
				if (!bookMarkGroupList.isEmpty()) {
					for (BookMarkGroup bookMarkGroup : bookMarkGroupList) {
			%>
						<tr>
							<td><%=bookMarkGroup.getId()%></td>
							<td id="bookMarkName" name="updateName"><%=bookMarkGroup.getBookMarkName()%></td>
							<td id="seq" name="updateSeq"><%=bookMarkGroup.getSeq()%></td>
							<td><%=bookMarkGroup.getIdt()%></td>
							<td><%=bookMarkGroup.getUdt()%></td>
							<td align="center">
								<a href="bookmark-Group-Edit.jsp?bookGroupMarkID=<%=bookMarkGroup.getId()%>">수정</a> <a href="bookmark-Group.jsp?groupId=<%=bookMarkGroup.getId()%>">삭제</a>
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