package spring.dwr.service;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;

public class MapServiceImpl implements MapService {
	
	public String getGeoCode(MapBean mapBean) {
		
		String sUrl = "http://maps.google.com/maps/api/geocode/json?address="+URLEncoder.encode(mapBean.getAddr())+"+&sensor=true";
		System.out.println("sUrl : "+sUrl);
		
		try{
			InputStream in = new URL(sUrl).openStream();
			InputStreamReader isr = new InputStreamReader(in, "UTF-8");
			BufferedReader br = new BufferedReader(isr);
			
			String line = "";
			String jsonData = "";
			
			while((line=br.readLine()) != null){
				jsonData += line;
			}
			System.out.println("jsonData : "+jsonData);
			
			return jsonData;
			
		}catch(Exception e) {
			return null;
		}
	}

	
}
