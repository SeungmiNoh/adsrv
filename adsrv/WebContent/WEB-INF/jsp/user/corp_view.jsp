<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/common.jsp" %>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="tv.pandora.adsrv.common.util.StringUtil"%>
<%@page import="tv.pandora.adsrv.common.util.DateUtil"%>    
<%@page import="tv.pandora.adsrv.domain.Campaign"%>  
<%@page import="tv.pandora.adsrv.domain.Ads"%>  
<%@page import="tv.pandora.adsrv.domain.User"%>    
<%	
try
{
	
	Map<String,Object> map = (Map)request.getAttribute("response");

	Map<String,String> corp = (Map<String,String>)map.get("corp");
	List<User> userlist = (List<User>)map.get("userlist");   

%>  
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Prism Ad Network</title>
    <!-- css start -->
    <link rel="stylesheet" href="../css/bootstrap.css">
    <link rel="stylesheet" href="../css/bootstrap-theme.css">
    <link rel="stylesheet" href="../css/design.css">
   <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <!-- css end -->
    
    
    

  <link rel="stylesheet" href="//code.jquery.com/ui/1.11.3/themes/smoothness/jquery-ui.css">

  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.3/jquery-ui.js"></script>
  <link rel="stylesheet" href="/resources/demos/style.css">

  <script src="../js/bootstrap.js"></script>
  <script src="../js/basic.js"></script>
 <script src="../js/common.js"></script>
 

</head>

<body>
    <div class="container-fluid containerBg">
        <div class="containerBox">
        <%@ include file="../common/header.jsp"  %>
            <section class="sectionBox">
                <div class="boxTitle">
                    <!-- title Start -->
                    <div class="title">업체 정보</div>
                    <div class="breadcrumbs"><span class="glyIcon"><img src="../img/navIcon.png" alt=""></span> 현재위치 : 계정 > 업체 > 업체정보</div>
                    <!-- title End -->
                </div>      
                <table class="viewTable" style="width:680px">
				<colgroup>
				<col width="140">
				<col width="200">
				<col width="140">
				<col width="200">
				</colgroup>
                    <tr>
                        <th>업체명</th>
                        <td><%=corp.get("corpname") %></td>
                        <th>업체구분</th>
                        <td><%=corp.get("corptypename") %></td>
                    </tr>
                    <tr>
                        <th>등록일</th>
                        <td><%=DateUtil.getYMD(String.valueOf(corp.get("insertdate"))) %></td>
                        <th>등록자</th>
                        <td><%=corp.get("insertusername") %></td>
                    </tr>
                </table>
                <!-- button group Start -->
                <div class="buttonGroup" style="width:680px;">
                   <button type="button" class="btn btn-default btn-sm">수정</button>
                   <button type="button" class="btn btn-default btn-sm">삭제</button>
                   <button type="button" class="btn btn-default btn-sm">업체등록</button>
                 </div>
                <!-- button group End -->
                
                <br>
                <!-- view Table End -->
                <!-- campaign view End -->
                <!-- ads add Table Start -->
                <!-- ads list Start -->
    			<div class="boxtitle3" style="width:800px">
                                       <button type="button" class="btn btn-danger btn-xs">사용자등록</button>
                    
                    <h1 class="title4"><span class="glyphicon glyphicon-ok"></span> 사용자 목록</h1>
                    <!-- title End -->
                </div>             
                <!-- list Table Start -->
                <table class="listTable3" style="width:800x">
				<colgroup>
				<col width="40">
			    <col width="160"><!-- 아이디 -->
			    <col width=""><!-- 사용자명 -->
				<col width="160"><!-- 계정 -->
				<col width="260"><!-- 업체명 -->
			    <col width="100"><!-- 권한 -->
			    <col width="160"><!-- 등록일 -->
				<col width="80"><!-- 담당자 -->
			   </colgroup>                   
				<thead>
                        <tr>
                            <th>No</th>
                            <th>아이디</th>
                            <th>사용자명</th>
                            <th>계정</th>
                            <th>업체명</th>  
                            <th>권한</th>
                            <th>등록일</th>
                            <th>등록자</th>
                            
                        </tr>
                    </thead>
                    <tbody>
<%

for(int k=0; k<userlist.size(); k++){
                                        
	User user = userlist.get(k);
    
	 
 %>                    
                    
                    
                        <tr>
                            <td><%=(k+1) %></td>
                             <td class="textLeft"><%=user.getLoginid() %></a></td>                           
                            <td class="textLeft"><%=user.getUsername() %></a></td>                           
                            <td><%=user.getCorptypename() %></td>
                            <td class="textLeft"><a href="usermgr.do?a=corpView"><%=user.getCorpname() %></a></td>                           
                            <td class="textLeft"><%=user.getPername() %></a></td>                           
                            <td><%=user.getUpdatedate() %></td>
                            <td><%=user.getUpdateusername() %></td>                            
                        </tr>
<%} %>                        
                        
                        
                    </tbody>
                </table>
                <!-- list Table End -->
                <!-- ads list End -->
           </section>



        </div>
    </div>
<%
} catch(Exception e) {
    e.getMessage();
}
%> 

    
</body>

</html>
