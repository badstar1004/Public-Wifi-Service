<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="db.DbConnection"%>
<%@page import="dto.WifiInfo"%>
<%@page import="java.util.*"%>
<%
	String LAT = request.getParameter("LAT");
	String LNT = request.getParameter("LNT");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내  위치  기반  공공  와이파이  정보</title>

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
		<h1>와이파이 정보 구하기</h1>
		
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
       	
       	<form method="get" action="main.jsp">
       		<label>LAT :</label>
       		<input type="text" id="LAT" name="LAT" maxlength="10" placeholder="Y좌표(위도)를 입력하세요" value="<%=LAT != null ? LAT : ""%>">
       		<input type="hidden" id="LAT_Hidden" value="126.9064">
       		
       		<label>LNT :</label>
       		<input type="text" id="LNT" name="LNT" maxlength="10" placeholder="X좌표(경도)를 입력하세요" value="<%=LNT != null ? LNT : ""%>">
       		<input type="hidden" id="LNT_Hidden" value="37.556">
       	
       		<button type="button" id="MyLocation" onclick="bindLocation(LAT_Hidden.value, LNT_Hidden.value);">내 위치 가져오기</button>
       		<button type="submit">근처 WIPI 정보 보기</button>
       	</form>
       	
	</div>
	
	<div>
		<table id="customers">
		<thead>
			<tr>
	    		<th>거리(Km)</th>
	    		<th>관리 번호</th>
	    		<th>자치구</th>
	    		<th>와이파이 명</th>
	    		<th>도로명 주소</th>
	    		<th>상세 주소</th>
	    		<th>설치 위치(층)</th>
	    		<th>설치 유형</th>
	    		<th>설치 기관</th>
	    		<th>서비스 구분</th>
	    		<th>망 종류</th>
	    		<th>설치 연도</th>
	    		<th>실내외 구분</th>
	    		<th>WIFI 접속 환경</th>
	    		<th>X 좌표</th>
	    		<th>Y 좌표</th>
	    		<th>작업 일자</th>
	  		</tr>
		</thead>
  		<tbody>
  			<%
				if (LAT == null && LNT == null || LAT.isEmpty() || LNT.isEmpty()) {
			%>
				<tr>
		  			<td colspan="17" align="center">위치 정보를 입력 한 후에 조회해 주세요.</td>
		  		</tr>
		  	<%
				} else {
					DbConnection dbcon = new DbConnection();
					int chkInsert = dbcon.wifiInsertHistory(LAT, LNT);
					
					if(chkInsert > 0){
						
						ArrayList<WifiInfo> nealWifi = dbcon.wifiSelectData(Double.parseDouble(LAT), Double.parseDouble(LNT));
						
						for (WifiInfo wifiInfo : nealWifi) {
							StringBuilder sb = new StringBuilder();
							sb.append("distance=" + wifiInfo.getDistance() + "&").append("mgrNo=" + wifiInfo.getX_SWIFI_MGR_NO() + "&")
							  .append("workArea=" + wifiInfo.getX_SWIFI_WRDOFC() + "&").append("wifiName=" + wifiInfo.getX_SWIFI_MAIN_NM() + "&")
							  .append("address1=" + wifiInfo.getX_SWIFI_ADRES1() + "&").append("address2=" + wifiInfo.getX_SWIFI_ADRES2() + "&")
							  .append("instalFoor=" + wifiInfo.getX_SWIFI_INSTL_FLOOR() + "&").append("instalType=" + wifiInfo.getX_SWIFI_INSTL_TY() + "&")
							  .append("instalMby=" + wifiInfo.getX_SWIFI_INSTL_MBY() + "&").append("serviceGbn=" + wifiInfo.getX_SWIFI_SVC_SE() + "&")
							  .append("networkType=" + wifiInfo.getX_SWIFI_CMCWR() + "&").append("instalYear=" + wifiInfo.getX_SWIFI_CNSTC_YEAR() + "&")
							  .append("inOut=" + wifiInfo.getX_SWIFI_INOUT_DOOR() + "&").append("wifiEnv=" + wifiInfo.getX_SWIFI_REMARS3() + "&")
							  .append("lat=" + wifiInfo.getLAT() + "&").append("lnt=" + wifiInfo.getLNT() + "&")
							  .append("workDtTm=" + wifiInfo.getWORK_DTTM());
		  	%>
				  			<tr>
				  				<td>
									<%=wifiInfo.getDistance()%>
								</td>
								<td>
									<%=wifiInfo.getX_SWIFI_MGR_NO()%>
								</td>
								<td>
									<%=wifiInfo.getX_SWIFI_WRDOFC()%>
								</td>
								<td>
									<a href="wifi-Detail.jsp?<%=sb.toString()%>"><%=wifiInfo.getX_SWIFI_MAIN_NM()%></a>
								</td>
								<td>
									<%=wifiInfo.getX_SWIFI_ADRES1()%>
								</td>
								<td>
									<%=wifiInfo.getX_SWIFI_ADRES2()%>
								</td>
								<td>
									<%=wifiInfo.getX_SWIFI_INSTL_FLOOR()%>
								</td>
								<td>
									<%=wifiInfo.getX_SWIFI_INSTL_TY()%>
								</td>
								<td>
									<%=wifiInfo.getX_SWIFI_INSTL_MBY()%>
								</td>
								<td>
									<%=wifiInfo.getX_SWIFI_SVC_SE()%>
								</td>
								<td>
									<%=wifiInfo.getX_SWIFI_CMCWR()%>
								</td>
								<td>
									<%=wifiInfo.getX_SWIFI_CNSTC_YEAR()%>
								</td>
								<td>
									<%=wifiInfo.getX_SWIFI_INOUT_DOOR()%>
								</td>
								<td>
									<%=wifiInfo.getX_SWIFI_REMARS3()%>
								</td>
								<td>
									<%=wifiInfo.getLAT()%>
								</td>
								<td>
									<%=wifiInfo.getLNT()%>
								</td>
								<td>
									<%=wifiInfo.getWORK_DTTM()%>
								</td>
				  			</tr>
		  	<%
						}
					}
				}
		  	%>
		  	
  		
  		</tbody>
  		</table>
	</div>
	
	
</body>
</html>