<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="db.DbConnection"%>
<%@page import="dto.BookMarkGroup"%>
<%@page import="java.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	String distance = request.getParameter("distance");
	String mgrNo = request.getParameter("mgrNo");
	String workArea = request.getParameter("workArea");
	String wifiName = request.getParameter("wifiName");
	String address1 = request.getParameter("address1");
	String address2 = request.getParameter("address2");
	String instalFoor = request.getParameter("instalFoor");
	String instalType = request.getParameter("instalType");
	String instalMby = request.getParameter("instalMby");
	String serviceGbn = request.getParameter("serviceGbn");
	String networkType = request.getParameter("networkType");
	String instalYear = request.getParameter("instalYear");
	String inOut = request.getParameter("inOut");
	String wifiEnv = request.getParameter("wifiEnv");
	String lat = request.getParameter("lat");
	String lnt = request.getParameter("lnt");
	String workDtTm = request.getParameter("workDtTm");
	
	DbConnection dbcon = new DbConnection();
	ArrayList<BookMarkGroup> bookMarkGroupList = dbcon.bookMarkGroupSelectData("");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- JavaScript -->
<script type="text/javascript" src="js/Wifi_Function.js"></script>

<!-- CSS -->
<style>
#customers {
	font-family: Arial, Helvetica, sans-serif;
  	border-collapse: collapse;
  	width: 50%;
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
  	width: 30%;
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
		<h1>와이파이 정보 상세</h1>
		
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
       	
       	<form method="post" name="groupForm" action="bookmark-List.jsp" onsubmit="return chkSelector()">
			<select id="groupList" name="groupList" style="height:22px">
				<option value = "" selected>북마크 그룹 이름 선택</option>
				<%
					for(BookMarkGroup bookMark : bookMarkGroupList){
				%>
						<option value="<%=bookMark.getId()%>"><%=bookMark.getBookMarkName()%></option>
				<%
					}
				%>
			</select>
	        <button type="submit" id="addBookMark" name="addBookMark">북마크 추가하기</button>
	        <input type="hidden" id="mgmtNo" name="mgmtNo" value="<%=mgrNo%>">
	        <input type="hidden" id="wifiName" name="wifiName" value="<%=wifiName%>">
		</form>
	</div>
	
	
	<table id="customers">
		<tr>
 			<th>거리(Km)</th>
 			<td>
				<%=distance%>
			</td>
 		</tr>
 		<tr>
   			<th>관리번호</th>
   			<td>
				<%=mgrNo%>
			</td>
 		</tr>
 		<tr>
   			<th>자치구</th>
   			<td>
				<%=workArea%>
			</td>
 		</tr>
 		<tr>
   			<th>와이파이명</th>
   			<td>
				<%=wifiName%>
			</td>
 		</tr>
 		<tr>
   			<th>도로명주소</th>
   			<td>
				<%=address1%>
			</td>
 		</tr>
 		<tr>
   			<th>상세주소</th>
   			<td>
				<%=address2%>
			</td>
 		</tr>
 		<tr>
   			<th>설치위치(층)</th>
   			<td>
				<%=instalFoor%>
			</td>
 		</tr>
 		<tr>
   			<th>설치유형</th>
   			<td>
				<%=instalType%>
			</td>
 		</tr>
 		<tr>
   			<th>설치기관</th>
   			<td>
				<%=instalMby%>
			</td>
 		</tr>
 		<tr>
   			<th>서비스구분</th>
   			<td>
				<%=serviceGbn%>
			</td>
 		</tr>
 		<tr>
   			<th>망종류</th>
   			<td>
				<%=networkType%>
			</td>
 		</tr>
 		<tr>
   			<th>설치년도</th>
   			<td>
				<%=instalYear%>
			</td>
 		</tr>
 		<tr>
   			<th>실내외구분</th>
   			<td>
				<%=inOut%>
			</td>
 		</tr>
 		<tr>
   			<th>WIFI접속환경</th>
   			<td>
				<%=wifiEnv%>
			</td>
 		</tr>
 		<tr>
   			<th>X좌표</th>
   			<td>
				<%=lat%>
			</td>
 		</tr>
 		<tr>
   			<th>Y좌표</th>
   			<td>
				<%=lnt%>
			</td>
 		</tr>
 		<tr>
   			<th>작업일자</th>
   			<td>
				<%=workDtTm%>
			</td>
 		</tr>
	</table>
</body>
</html>