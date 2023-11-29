<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	</div>
	
	<table id="customers" name="frm">
 		<tr>
 			<th>북마크 이름</th>
 			<td>
 				<input type="text" id="bookMarkName" name="bookMarkName" placeholder="북마크 이름을 입력하세요">
 			</td>
 		</tr>
 		<tr>
   			<th>순서</th>
   			<td>
   				<input type="text" id="bookMarkSeq" name="bookMarkSeq" placeholder="북마크 순서를 입력하세요">
   			</td>
 		</tr>
 		 <tr>
 		 	<form action="bookmark-Group.jsp" method="post" onsubmit="return insertBookMark();">
 		 		<td style="text-align: center;" colspan="2">
 		 			<button type="submit" id="btnBookMarkAdd" name="bookMarkAdd">추가</button>
 		 		</td>
 		 	</form>
 		</tr>
	</table>
</body>
</html>