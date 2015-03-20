<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="tv.pandora.adsrv.common.Constant"%>    

<script>
alert("세션이 종료되었습니다.\r\n다시 로그인해주세요.");
location.href="<%=Constant.WEB_ROOT%>";
</script>	
<%
	//response.sendRedirect(web);
%>