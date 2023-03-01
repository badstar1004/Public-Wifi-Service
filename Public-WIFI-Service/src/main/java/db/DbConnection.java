package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;

import dto.BookMarkGroup;
import dto.BookMarkList;
import dto.WifiInfo;
import dto.WifiLocationHistory;

public class DbConnection {
	
	private final String url = "jdbc:mariadb://localhost:3306/zerobasedb";
	private final String id = "root";
	private final String password = "1234";
	private Connection con;			// 커넥션
    private PreparedStatement ps;	// 쿼리 실행
    private ResultSet rs;			// 쿼리 결과
    private StringBuilder sqlQuery = new StringBuilder();	// 쿼리문
    
    
    // WIFI 데이터 저장
    public int wifiSaveUpdateAllData(JsonArray jsonArray) {
    	
    	int successCount = 0;
    	try {
    		Class.forName("org.mariadb.jdbc.Driver");
    		
    		con = DriverManager.getConnection(url, id, password);
    		sqlQuery.delete(0, sqlQuery.length());
    		
    		Gson gson = new Gson();
    		
    		con.setAutoCommit(false);
    		
	    	sqlQuery.append("INSERT INTO PUBLIC_WIFI_DATA ")
	    			.append("VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ")
	    			.append("ON DUPLICATE KEY UPDATE X_SWIFI_WRDOFC = ?, X_SWIFI_MAIN_NM = ?")
	    								  .append(", X_SWIFI_ADRES1 = ?, X_SWIFI_ADRES2 = ?")
	    								  .append(", X_SWIFI_INSTL_FLOOR = ?, X_SWIFI_INSTL_TY = ?")
	    								  .append(", X_SWIFI_INSTL_MBY = ?, X_SWIFI_SVC_SE = ?")
	    								  .append(", X_SWIFI_CMCWR = ?, X_SWIFI_CNSTC_YEAR = ?")
	    								  .append(", X_SWIFI_INOUT_DOOR = ?, X_SWIFI_REMARS3 = ?")
	    								  .append(", LAT = ?, LNT = ?")
	    								  .append(", WORK_DTTM = ?;");
    	
	    	for (JsonElement jsonElement : jsonArray) {
	    		
	    		WifiInfo wifiInfo = gson.fromJson(jsonElement, WifiInfo.class);
	    		
				ps = con.prepareStatement(sqlQuery.toString());
				
				ps.setString(1, wifiInfo.getX_SWIFI_MGR_NO());
                ps.setString(2, wifiInfo.getX_SWIFI_WRDOFC());
                ps.setString(3, wifiInfo.getX_SWIFI_MAIN_NM());
                ps.setString(4, wifiInfo.getX_SWIFI_ADRES1());
                ps.setString(5, wifiInfo.getX_SWIFI_ADRES2());
                ps.setString(6, wifiInfo.getX_SWIFI_INSTL_FLOOR());
                ps.setString(7, wifiInfo.getX_SWIFI_INSTL_TY());
                ps.setString(8, wifiInfo.getX_SWIFI_INSTL_MBY());
                ps.setString(9, wifiInfo.getX_SWIFI_SVC_SE());
                ps.setString(10, wifiInfo.getX_SWIFI_CMCWR());
                ps.setString(11, wifiInfo.getX_SWIFI_CNSTC_YEAR());
                ps.setString(12, wifiInfo.getX_SWIFI_INOUT_DOOR());
                ps.setString(13, wifiInfo.getX_SWIFI_REMARS3());
                ps.setString(14, wifiInfo.getLAT());
                ps.setString(15, wifiInfo.getLNT());
                ps.setString(16, wifiInfo.getWORK_DTTM());
                
                ps.setString(17, wifiInfo.getX_SWIFI_WRDOFC());
                ps.setString(18, wifiInfo.getX_SWIFI_MAIN_NM());
                ps.setString(19, wifiInfo.getX_SWIFI_ADRES1());
                ps.setString(20, wifiInfo.getX_SWIFI_ADRES2());
                ps.setString(21, wifiInfo.getX_SWIFI_INSTL_FLOOR());
                ps.setString(22, wifiInfo.getX_SWIFI_INSTL_TY());
                ps.setString(23, wifiInfo.getX_SWIFI_INSTL_MBY());
                ps.setString(24, wifiInfo.getX_SWIFI_SVC_SE());
                ps.setString(25, wifiInfo.getX_SWIFI_CMCWR());
                ps.setString(26, wifiInfo.getX_SWIFI_CNSTC_YEAR());
                ps.setString(27, wifiInfo.getX_SWIFI_INOUT_DOOR());
                ps.setString(28, wifiInfo.getX_SWIFI_REMARS3());
                ps.setString(29, wifiInfo.getLAT());
                ps.setString(30, wifiInfo.getLNT());
                ps.setString(31, wifiInfo.getWORK_DTTM());
                
                ps.executeUpdate();
                successCount += 1;
			}
	    	
	    	con.commit();
			
			if (con != null) {
	            con.close();
	        }
			
	        if (ps != null) {
	            ps.close();
	        }
			
		} catch (SQLException e) {
			e.printStackTrace();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
    	return successCount;
    }
    
    
    // 근처 WIFI 데이터 조회
    public ArrayList<WifiInfo> wifiSelectData(double lat, double lnt){
    	
    	ArrayList<WifiInfo> wifiHistoryList = new ArrayList<>();
    	 
    	try {
    		Class.forName("org.mariadb.jdbc.Driver");
    		
    		con = DriverManager.getConnection(url, id, password);
    		sqlQuery.delete(0, sqlQuery.length());
    		
    		
    		sqlQuery.append("WITH CAL_DISTANCE AS ( ")
					.append("SELECT *, ROUND((6371 * 2 * ASIN(")
					.append("SQRT(POWER(SIN((" + lat + "- ABS(LAT)) * PI()/180 / 2), 2) + ")
					.append("COS(LAT * PI()/180) * COS(" + lat + " * PI()/180) * ")
    				.append("POWER(SIN((" + lnt + " - LNT) * PI()/180 / 2), 2)))), 4)	DISTANCE ")
    				.append("FROM PUBLIC_WIFI_DATA )")
    				.append("SELECT * FROM CAL_DISTANCE ORDER BY DISTANCE LIMIT 20;");
    		
    		ps = con.prepareStatement(sqlQuery.toString());
    		rs = ps.executeQuery();
    		
			while(rs.next()) {
				
				WifiInfo wifiInfo = new WifiInfo();
				
				wifiInfo.setX_SWIFI_MGR_NO(rs.getString("X_SWIFI_MGR_NO"));
				wifiInfo.setX_SWIFI_WRDOFC(rs.getString("X_SWIFI_WRDOFC"));
				wifiInfo.setX_SWIFI_MAIN_NM(rs.getString("X_SWIFI_MAIN_NM"));
				wifiInfo.setX_SWIFI_ADRES1(rs.getString("X_SWIFI_ADRES1"));
				wifiInfo.setX_SWIFI_ADRES2(rs.getString("X_SWIFI_ADRES2"));
				wifiInfo.setX_SWIFI_INSTL_FLOOR(rs.getString("X_SWIFI_INSTL_FLOOR"));
				wifiInfo.setX_SWIFI_INSTL_TY(rs.getString("X_SWIFI_INSTL_TY"));
				wifiInfo.setX_SWIFI_INSTL_MBY(rs.getString("X_SWIFI_INSTL_MBY"));
				wifiInfo.setX_SWIFI_SVC_SE(rs.getString("X_SWIFI_SVC_SE"));
				wifiInfo.setX_SWIFI_CMCWR(rs.getString("X_SWIFI_CMCWR"));
				wifiInfo.setX_SWIFI_CNSTC_YEAR(rs.getString("X_SWIFI_CNSTC_YEAR"));
				wifiInfo.setX_SWIFI_INOUT_DOOR(rs.getString("X_SWIFI_INOUT_DOOR"));
				wifiInfo.setX_SWIFI_REMARS3(rs.getString("X_SWIFI_REMARS3"));
				wifiInfo.setLAT(rs.getString("LAT"));
				wifiInfo.setLNT(rs.getString("LNT"));
				wifiInfo.setWORK_DTTM(rs.getString("WORK_DTTM"));
				wifiInfo.setDistance(rs.getString("DISTANCE"));
				
				wifiHistoryList.add(wifiInfo);
			}
			
			if (con != null) {
	            con.close();
	        }
			
	        if (ps != null) {
	            ps.close();
	        }
	        
	        if(rs != null) {
	        	rs.close();
	        }
			
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
    	return wifiHistoryList;
    }
    
    // 근처 와이파이 조회 시 내위치 히스토리 저장
    public int wifiInsertHistory(String lat, String lnt) {
    	int successCount = 0;
    	try {
    		Class.forName("org.mariadb.jdbc.Driver");
    		
    		con = DriverManager.getConnection(url, id, password);
    		sqlQuery.delete(0, sqlQuery.length());
    		
	    	sqlQuery.append("INSERT INTO WIFI_LOCATION_HISTORY (LAT, LNT) ")
	    			.append("VALUES (?, ?);");
    	
				ps = con.prepareStatement(sqlQuery.toString());
				
				ps.setString(1, lat);
                ps.setString(2, lnt);
                
                int rsNum = ps.executeUpdate();
                if (rsNum > 0) {
                	successCount += 1;
                }
                
			if (con != null) {
	            con.close();
	        }
			
	        if (ps != null) {
	            ps.close();
	        }
			
		} catch (SQLException e) {
			e.printStackTrace();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
    	return successCount;
    }
    
    // 위치 히스토리 조회
    public ArrayList<WifiLocationHistory> wifiHistorySelectData(){
    	
    	ArrayList<WifiLocationHistory> wifiHistoryList = new ArrayList<>();
    	 
    	try {
    		Class.forName("org.mariadb.jdbc.Driver");
    		
    		con = DriverManager.getConnection(url, id, password);
    		sqlQuery.delete(0, sqlQuery.length());
    		
    		
    		sqlQuery.append("SELECT * FROM WIFI_LOCATION_HISTORY ORDER BY ID DESC;");
    		
    		ps = con.prepareStatement(sqlQuery.toString());
    		rs = ps.executeQuery();
    		
			while(rs.next()) {
				
				WifiLocationHistory wifiLocationHistory = new WifiLocationHistory();
				
				wifiLocationHistory.setId(rs.getInt("ID"));
				wifiLocationHistory.setLAT(rs.getString("LAT"));
				wifiLocationHistory.setLNT(rs.getString("LNT"));
				wifiLocationHistory.setIDT(rs.getString("IDT"));
				
				wifiHistoryList.add(wifiLocationHistory);
			}
			
			if (con != null) {
	            con.close();
	        }
			
	        if (ps != null) {
	            ps.close();
	        }
	        
	        if(rs != null) {
	        	rs.close();
	        }
			
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
    	return wifiHistoryList;
    }
    
    // 위치 히스토리 삭제
    public int wifiHistoryDeleteData(int delId) {
    	
    	try {
    		Class.forName("org.mariadb.jdbc.Driver");
    		
    		con = DriverManager.getConnection(url, id, password);
    		sqlQuery.delete(0, sqlQuery.length());
    		
    		sqlQuery.append("DELETE FROM WIFI_LOCATION_HISTORY WHERE ID = ?");
    		
    		ps = con.prepareStatement(sqlQuery.toString());
			ps.setInt(1, delId);
			
			return ps.executeUpdate();
			
    	}catch (Exception e) {
    		e.printStackTrace();
		}
    	
		return -1;
    }
    
    // 북마크 그룹 정보 등록
    public int bookMarkGroupInsert(String bookMarkName, String seq) {
    	int successCount = 0;
    	try {
    		Class.forName("org.mariadb.jdbc.Driver");
    		
    		con = DriverManager.getConnection(url, id, password);
    		sqlQuery.delete(0, sqlQuery.length());
    		
	    	sqlQuery.append("INSERT INTO BOOKMARK_GROUP (BOOKMARK_NAME, SEQ) ")
	    			.append("VALUES (?, ?);");
    	
				ps = con.prepareStatement(sqlQuery.toString());
				
				int newSeq = Integer.parseInt(seq);
				
				ps.setString(1, bookMarkName);
                ps.setInt(2, newSeq);
                
                int rsNum = ps.executeUpdate();
                if (rsNum > 0) {
                	successCount += 1;
                }
                
			if (con != null) {
	            con.close();
	        }
			
	        if (ps != null) {
	            ps.close();
	        }
			
		} catch (SQLException e) {
			e.printStackTrace();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
    	return successCount;
    }
    
    // 북마크 그룹 정보 수정
    public int bookMarkGroupUpdate(String bookmarkId, String bookMarkName, String seq) {
    	int successCount = 0;
    	try {
    		Class.forName("org.mariadb.jdbc.Driver");
    		
    		con = DriverManager.getConnection(url, id, password);
    		sqlQuery.delete(0, sqlQuery.length());
    		
    		int newBookMarkId = Integer.parseInt(bookmarkId);
	    	sqlQuery.append("UPDATE BOOKMARK_GROUP ")
	    			   .append("SET BOOKMARK_NAME = ?")
	    			     .append(", SEQ = ?")
	    			     .append(", UDT = NOW() ")
	    			 .append("WHERE ID = " + newBookMarkId + ";");
    	
				ps = con.prepareStatement(sqlQuery.toString());
				
				int newSeq = Integer.parseInt(seq);
				
				ps.setString(1, bookMarkName);
                ps.setInt(2, newSeq);
                
                int rsNum = ps.executeUpdate();
                if (rsNum > 0) {
                	successCount += 1;
                }
                
			if (con != null) {
	            con.close();
	        }
			
	        if (ps != null) {
	            ps.close();
	        }
			
		} catch (SQLException e) {
			e.printStackTrace();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
    	return successCount;
    }
    
    // 북마크 그룹 정보 조회
    public ArrayList<BookMarkGroup> bookMarkGroupSelectData(String bookMarkId){
    	
    	ArrayList<BookMarkGroup> bookMarkGroupList = new ArrayList<>();
    	 
    	try {
    		Class.forName("org.mariadb.jdbc.Driver");
    		
    		con = DriverManager.getConnection(url, id, password);
    		sqlQuery.delete(0, sqlQuery.length());
    		
    		if(bookMarkId != "") {
    			int newBookMarkId = Integer.parseInt(bookMarkId);
    			sqlQuery = sqlQuery.append("SELECT ID, BOOKMARK_NAME, SEQ, IDT, IFNULL(UDT, '') UDT ")
    							   .append("FROM BOOKMARK_GROUP WHERE ID = " + newBookMarkId + ";");
    		} else {
    			sqlQuery = sqlQuery.append("SELECT ID, BOOKMARK_NAME, SEQ, IDT, IFNULL(UDT, '')	UDT ")
    							   .append("FROM BOOKMARK_GROUP;");
    		}
    		
    		ps = con.prepareStatement(sqlQuery.toString());
    		rs = ps.executeQuery();
    		
			while(rs.next()) {
				
				BookMarkGroup bookMarkGroup = new BookMarkGroup();
				
				bookMarkGroup.setId(rs.getInt("ID"));
				bookMarkGroup.setBookMarkName(rs.getString("BOOKMARK_NAME"));
				bookMarkGroup.setSeq(rs.getString("SEQ"));
				bookMarkGroup.setIdt(rs.getString("IDT"));
				bookMarkGroup.setUdt(rs.getString("UDT"));
				
				bookMarkGroupList.add(bookMarkGroup);
			}
			
			if (con != null) {
	            con.close();
	        }
			
	        if (ps != null) {
	            ps.close();
	        }
	        
	        if(rs != null) {
	        	rs.close();
	        }
			
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
    	return bookMarkGroupList;
    }
    
    // 북마크 그룹 삭제
    public int bookMarkGroupDelete(String delId) {
    	
    	int result = -1;
    	try {
    		Class.forName("org.mariadb.jdbc.Driver");
    		
    		con = DriverManager.getConnection(url, id, password);
    		sqlQuery.delete(0, sqlQuery.length());
    		
    		sqlQuery.append("IF EXISTS(SELECT ID FROM BOOKMARK_HISTORY WHERE ID = ?) ")
    			    .append("THEN SELECT 1	RESULTNO; ")
    			    .append("ELSE DELETE FROM BOOKMARK_GROUP WHERE ID = ?; SELECT 0	RESULTNO; ")
    			    .append("END IF;");
    		
    		ps = con.prepareStatement(sqlQuery.toString());
    		
    		int newDelId = Integer.parseInt(delId);
			ps.setInt(1, newDelId);
			ps.setInt(2, newDelId);
			
			rs = ps.executeQuery();
    		
			while(rs.next()) {
				result = rs.getInt("RESULTNO");
			}
			
    	}catch (Exception e) {
    		e.printStackTrace();
		}
    	
		return result;
    }
    
    
    // 북마크 등록
    public int bookMarkAdd(String bookMarkGroupId, String wifiMgmtNo, String wifiName) {
    	int successCount = 0;
    	try {
    		Class.forName("org.mariadb.jdbc.Driver");
    		
    		con = DriverManager.getConnection(url, id, password);
    		sqlQuery.delete(0, sqlQuery.length());
    		
	    	sqlQuery.append("INSERT INTO BOOKMARK_HISTORY (ID, X_SWIFI_MGR_NO, X_SWIFI_MAIN_NM) ")
	    			.append("VALUES (?, ?, ?);");
    	
				ps = con.prepareStatement(sqlQuery.toString());
				
				int newBookMarkGroupId = Integer.parseInt(bookMarkGroupId);
				ps.setInt(1, newBookMarkGroupId);
                ps.setString(2, wifiMgmtNo);
                ps.setString(3, wifiName);
                
                int rsNum = ps.executeUpdate();
                if (rsNum > 0) {
                	successCount += 1;
                }
                
			if (con != null) {
	            con.close();
	        }
			
	        if (ps != null) {
	            ps.close();
	        }
			
		} catch (SQLException e) {
			e.printStackTrace();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
    	return successCount;
    }
    
    // 북마크 조회
    public ArrayList<BookMarkList> bookMarkSelectData(String bookMarkId){
    	
    	ArrayList<BookMarkList> bookMarkList = new ArrayList<>();
    	 
    	try {
    		Class.forName("org.mariadb.jdbc.Driver");
    		
    		con = DriverManager.getConnection(url, id, password);
    		sqlQuery.delete(0, sqlQuery.length());
    		
    		if(bookMarkId != "") {
    			
    			int newBookMarkId = Integer.parseInt(bookMarkId);
    			
    			sqlQuery = sqlQuery.append("SELECT BH.BOOKMARK_ID ")
    							   	 	.append(", BG.BOOKMARK_NAME		BOOKMARKGROUP_NAME ")
    							   	 	.append(", BH.X_SWIFI_MAIN_NM ")
    							   	 	.append(", BH.IDT ")
    							   	 .append("FROM BOOKMARK_GROUP		BG ")
    						   .append("INNER JOIN BOOKMARK_HISTORY		BH ")
    						   		   .append("ON BG.ID	= BH.ID ")
    							    .append("WHERE BOOKMARK_ID = " + newBookMarkId + ";");
    		} else {
    			sqlQuery = sqlQuery.append("SELECT BH.BOOKMARK_ID ")
								   	 	.append(", BG.BOOKMARK_NAME		BOOKMARKGROUP_NAME ")
								   	 	.append(", BH.X_SWIFI_MAIN_NM ")
								   	 	.append(", BH.IDT ")
								   	 .append("FROM BOOKMARK_GROUP		BG ")
							   .append("INNER JOIN BOOKMARK_HISTORY		BH ")
							   		   .append("ON BG.ID	= BH.ID;");
    		}
    		
    		ps = con.prepareStatement(sqlQuery.toString());
    		rs = ps.executeQuery();
    		
			while(rs.next()) {
				
				BookMarkList bookMark = new BookMarkList();
				
				bookMark.setId(rs.getString("BOOKMARK_ID"));
				bookMark.setBookMarkGroupName(rs.getString("BOOKMARKGROUP_NAME"));
				bookMark.setX_SWIFI_MAIN_NM(rs.getString("X_SWIFI_MAIN_NM"));
				bookMark.setIdt(rs.getString("IDT"));
				
				bookMarkList.add(bookMark);
			}
			
			if (con != null) {
	            con.close();
	        }
			
	        if (ps != null) {
	            ps.close();
	        }
	        
	        if(rs != null) {
	        	rs.close();
	        }
			
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
    	return bookMarkList;
    }
    
    // 북마크 삭제
    public int bookMarkDelete(String delId) {
    	
    	try {
    		Class.forName("org.mariadb.jdbc.Driver");
    		
    		con = DriverManager.getConnection(url, id, password);
    		sqlQuery.delete(0, sqlQuery.length());
    		
    		int newDelId = Integer.parseInt(delId);
    		sqlQuery.append("DELETE FROM BOOKMARK_HISTORY WHERE BOOKMARK_ID = ?;");
    		
    		ps = con.prepareStatement(sqlQuery.toString());
    		ps.setInt(1, newDelId);
			
			return ps.executeUpdate();
			
    	}catch (Exception e) {
    		e.printStackTrace();
		}
    	
		return -1;
    }
}
