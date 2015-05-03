<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/common.jsp" %>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="net.sf.json.JSONArray"%>
<%
 	
 	Map<String,String> map = (Map<String,String>)request.getAttribute("response");
    String msg = map.get("msg");     
    String referer = map.get("referer"); 
    String backflag = map.get("backflag");   
    
    if(backflag.equals("1")) {
    	%>
    	<script>
    	alert("<%=msg%>\r\n이전페이지로 이동합니다.");
    	location.href="<%=referer%>";
    	</script>
    	<% 
    }
    
%>

