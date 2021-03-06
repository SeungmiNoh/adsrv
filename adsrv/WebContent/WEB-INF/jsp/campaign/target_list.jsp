<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/common.jsp" %>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="tv.pandora.adsrv.common.util.StringUtil"%>
<%@page import="tv.pandora.adsrv.common.util.DateUtil"%>      
<%	
try
{
	String sch_text = StringUtil.isNull(request.getParameter("sch_text"));
	String s_type = StringUtil.isNull(request.getParameter("s_type"));
	
	sch_text = new String (sch_text.getBytes("8859_1"),"UTF-8");
	  
	Map<String,Object> map = (Map)request.getAttribute("response");

	List<Map<String,String>> codelist = (List<Map<String,String>>)map.get("codelist");   
	List<Map<String,String>> targetlist = (List<Map<String,String>>)map.get("targetlist");   

	
	Integer skip = (Integer)map.get("skip");
 	Integer max = (Integer)map.get("max");
  
    String totalCount = map.get("totalCount").toString();
    String nowPage = map.get("nowPage").toString();
 %>  
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Prism Ad Network</title>
    <!-- css start -->
    <link rel="stylesheet" href="<%=web%>/css/bootstrap.css">
    <link rel="stylesheet" href="<%=web%>/css/bootstrap-theme.css">
    <link rel="stylesheet" href="<%=web%>/css/design.css">
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
  
 <script type="text/javascript" src="<%=web%>/dwr/engine.js"></script>
<script type="text/javascript" src="<%=web%>/dwr/util.js"></script>
<script type="text/javascript" src="<%=web%>/dwr/interface/MasDwrService.js"></script>
  <script src="<%=web%>/js/bootstrap.js"></script>
  <script src="<%=web%>/js/basic.js"></script>
 <script src="<%=web%>/js/common.js"></script>

<body>
    <div class="container-fluid containerBg">
 <div class="containerBox">
        <%@ include file="../common/header.jsp"  %>
             <section class="sectionBox">
                <div class="boxTitle">
                    <!-- title Start -->
                    <div class="title">타겟팅목록</div>
                    <div class="breadcrumbs"><span class="glyIcon"><img src="<%=web%>/img/navIcon.png" alt=""></span> 현재위치 : 캠페인 > 타겟팅 > 타겟팅 목록</div>
                    <!-- title End -->
                </div>
                <!-- ads add title Start -->
                <!-- search group Start -->
				<form id="frmList" name="frmList" method="get" action="cpmgr.do?a=targetList">
 				<input type="hidden" name="a" value="targetList"/>
				<input type="hidden" name="p" id="page"/>
                    <div class="form-inline">
                        <div class="form-group">
                            <select name="s_type" class="form-control input-sm">
                                <option value="">종류</option>
                                <%for(int i=0;i<codelist.size();i++){ 
                                	Map<String,String> code = codelist.get(i);
                                %>
                                <option value="<%=String.valueOf(code.get("isid")) %>" <%=s_type.equals(String.valueOf(code.get("isid")))?"selected":"" %>><%=String.valueOf(code.get("isname")) %></option>                               
                                <%} %>                                
                            </select>
                        </div>
                        <div class="form-group formGroupPadd">
                            <input type="text" class="form-control input-sm" name="sch_text" value="<%=sch_text%>">
                        </div>
                        <div class="form-group formGroupPadd">
                            <button type="submit" class="btn btn-warning btn-sm">조회</button>
                        </div>
                    </div>
                </form>
                <!-- search group End -->
                <!-- saveBtn Start -->
  				<div class="outsaveBtn1">
                    <!--  a class="btn btn-danger" href="#" data-toggle="modal" data-target="#myModal" id="btnPopup">업체등록</a-->
                    <a class="btn btn-danger" href="cpmgr.do?a=targetForm&tgtype=1"  data-target="#myModal" id="btnPopup">타겟팅등록</a>
                </div>                  
                <!-- saveBtn End -->
                <br>
                <!-- list Table Start -->
                <table class="listTable">
				<colgroup>
				<col width="40">
				<col width="160"><!-- 종류 -->
				<col width="260"><!-- 타겟명 -->
			    <col width="160"><!-- 등록일 -->
				<col width="160"><!-- 담당자 -->
					</colgroup>                   
				<thead>
                        <tr>
                            <th>No</th>
                            <th>종류</th>
                            <th>타겟명</th>  
                            <th>등록일</th>
                            <th>등록자</th>
                            
                        </tr>
                    </thead>
                    <tbody>
<%

for(int k=0; k<targetlist.size(); k++){
                                        
	Map<String,String> target = targetlist.get(k);
    
	 
 %>                    
                    
                    
                        <tr>
                            <td><%=skip+(k+1) %></td>
                            <td><%=target.get("targettypename") %></td>
                            <td class="textLeft"><a href="cpmgr.do?a=targetView&tid=<%=String.valueOf(target.get("tid"))%>"><%=target.get("targetname") %></a></td>                           
                            <td><%=DateUtil.getYMDHM(String.valueOf(target.get("updatedate")),"-") %></td>
                            <td><%=target.get("updateusername") %></td>                            
                        </tr>
<%} %>                        
                        
                        
                    </tbody>
                </table>
                <!--table Paging-->            
                <jsp:include page="../common/paging.jsp">
                <jsp:param name="actionForm" value="frmList"/>
                <jsp:param name="totalCount" value="<%=totalCount %>"/>
                <jsp:param name="countPerPage" value="<%=max %>"/>
                <jsp:param name="blockCount" value="10"/>
                <jsp:param name="nowPage" value="<%=nowPage %>"/>
            	</jsp:include>
            	<!--//table Paging-->                  
            	<!-- list Table End -->
                 <!-- list Table End -->

           
            </section>
        </div>
    </div>

    
    <!-- js start -->
    <script src="<%=web%>/js/jquery-1.11.1.js"></script>
    <script src="<%=web%>/js/bootstrap.js"></script>
    <script src="<%=web%>/js/basic.js"></script>
    <!-- js end -->
</body>
<%
} catch(Exception e) {
    out.println(e.getMessage());
}
%>
</html>

