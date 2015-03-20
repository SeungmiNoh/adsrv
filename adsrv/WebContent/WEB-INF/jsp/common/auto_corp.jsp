<%@page import="java.util.HashMap"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	Map map = (Map)request.getAttribute("response");

	List<Map<String, String>> corplist = (List<Map<String, String>>)map.get("corplist");

	JSONArray json_array = new JSONArray();
	JSONObject json_obj = null;
	
	for(int k=0; k<corplist.size(); k++){
        
		Map<String, String> corp = corplist.get(k);
		
	
		
		json_obj = new JSONObject();
		json_obj.put("label", corp.get("label"));
		json_obj.put("value", corp.get("value"));
		json_obj.accumulateAll(corp);
		json_array.add(json_obj);
	}
	
	JSONArray data = JSONArray.fromObject(corplist);
	
	out.print(JSONArray.fromObject(data).toString());
//out.println(json_array);
%> 


