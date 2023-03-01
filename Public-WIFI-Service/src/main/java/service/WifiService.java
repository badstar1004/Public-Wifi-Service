package service;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import db.DbConnection;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

public class WifiService {
	
	private final DbConnection dbConnection = new DbConnection();
	
	public int wifiServiceToJson() {
		
		try {
			
			// 전체 개수
			int totalCount = getTotalCount();
			int count = 0;
			
			// for
			for (int i = 1; i <= ((totalCount / 1000) + 1) * 1000; i += 1000) {
				
				String urlBuilder = "http://openapi.seoul.go.kr:8088/776366566b62616438356b516e537a/json/TbPublicWifiInfo/" + i + "/" + (i + 999) + "/";
				
				OkHttpClient client = new OkHttpClient();
				Request request = new Request.Builder()
											 .url(urlBuilder.toString())
											 .addHeader("Content-Type", "application/json; charset=utf-8")
											 .build();
				
				// 실행
				Response response = client.newCall(request).execute();
				String jsonString = response.body().string();
				JsonObject jsonObject = JsonParser.parseString(jsonString).getAsJsonObject();
				JsonObject publicWifiInfo = (JsonObject) jsonObject.get("TbPublicWifiInfo");
				JsonArray jsonArray = (JsonArray) publicWifiInfo.get("row");
				
				count += dbConnection.wifiSaveUpdateAllData(jsonArray);
			}
			
			return count;
			
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}
	
	// 전체 개수
	private int getTotalCount() {
			// 연결
			String url = "http://openapi.seoul.go.kr:8088/776366566b62616438356b516e537a/json/TbPublicWifiInfo/0/1/";
			
			OkHttpClient client = new OkHttpClient();
			Request request = new Request.Builder()
										 .url(url)
										 .build();
			
		try {
			
			// 실행
			Response response = client.newCall(request).execute();
			String jsonString = response.body().string();
			response.close();
			
			JsonObject jsonObject = JsonParser.parseString(jsonString).getAsJsonObject();
			JsonObject wifiInfo = (JsonObject) jsonObject.get("TbPublicWifiInfo");

			// return 전체 개수
			return wifiInfo.get("list_total_count").getAsInt();
			
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}
}
