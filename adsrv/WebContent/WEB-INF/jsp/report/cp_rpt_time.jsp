<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/common.jsp" %>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.google.gson.Gson"%> 
<%@page import="tv.pandora.adsrv.common.util.StringUtil"%>
<%@page import="tv.pandora.adsrv.common.util.DateUtil"%>    
<%@page import="tv.pandora.adsrv.domain.Campaign"%>  
<%@page import="tv.pandora.adsrv.domain.Ads"%>  
<%@page import="tv.pandora.adsrv.domain.Report"%>       
<%	
try
{
	
	Map<String,Object> map = (Map)request.getAttribute("response");
	String a = StringUtil.isNull(request.getParameter("a"));
	
	Map<String, String> paramap = (Map<String,String>)map.get("paramap");
	JSONObject param_data = JSONObject.fromObject(paramap);


	Campaign cp = (Campaign)map.get("cp");
	

	List<Ads> adslist = (List<Ads>)map.get("adslist"); 
	List<Report> dayrpt = (List<Report>)map.get("dayrpt"); 
	Report tot2 = (Report)map.get("daytotal"); 
	List<Map<String,String>> weekday = (List<Map<String,String>>)map.get("weekday");   
	Gson gson = new Gson();
	String weekday_data = gson.toJson(weekday);
	
	
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
  <script src="<%=web%>/js/bootstrap.js"></script>
  <script src="<%=web%>/js/basic.js"></script>
 <script src="<%=web%>/js/common.js"></script>
<script type="text/javascript">


$(function(){
	var weekday =  <%=weekday_data%>;
	
	
	
});
</script>

</head>
<body>
    <div class="container-fluid containerBg">
        <div class="containerBox">
        <%@ include file="../common/header.jsp"  %>
            <section class="sectionBox">
                <div class="boxTitle">
                    <!-- title Start -->
                          <div class="title">캠페인 리포트 <span class="txtBlue" style="margin-left:10px;font-size:9pt"><span class="glyphicon glyphicon-play-circle"></span> <%=cp.getCpname() %> </span></div>
                    <div class="breadcrumbs"><span class="glyIcon"><img src="<%=web%>/img/navIcon.png" alt=""></span> 현재위치 : 리포트  > 캠페인  > 요약 리포트</div>
                    <!-- title End -->
                </div>      
             <!-- ************ 공통  ************ -->
 				<%@ include file="./cp_rpt.jsp" %>
                  <table class="rptTable" >
 				<colgroup>
				<col width="*"><!-- 일자 -->
				<col width="140"><!-- 노출 -->
				<col width="140"><!-- 클릭 -->
				<col width="140"><!-- 리치 -->
				<col width="140"><!-- 유니크클릭 -->				
				<col width="140"><!-- View -->				
				<col width="100"><!-- CTR -->
				<col width="100"><!-- CPR -->
					</colgroup>                   
	                    <thead>
                        <tr>
                            <th>시간</th>
                            <th>노출</th>
                            <th>클릭</th>
                            <th>리치</th>
                            <th>유니크클릭</th>
                            <th>View</th>                           
                            <th>CTR</th>
                            <th>CPR</th>
                        </tr>
                    </thead>
                    <tbody class="sum"  id="tbodySum">
 <%if(tot2!=null){ %>                   
						<tr>
                         <td>Total</td>
                         <td class="textRight"><%=StringUtil.addComma(tot2.getImp()) %></td>
                         <td class="textRight"><%=StringUtil.addComma(tot2.getClick()) %></td>
                         <td class="textRight"><%=StringUtil.addComma(tot2.getUv()) %></td>
                         <td class="textRight"><%=StringUtil.addComma(tot2.getUc()) %></td>
                         <td class="textRight"><%=StringUtil.addComma(tot2.getViews()) %></td>
                         <td class="textRight"><%=tot2.getCtr() %>%</td>
                         <td class="textRight"><%=tot2.getCpr() %>%</td>
                       	</tr> 
<%}else{ %>
 <tr>
 <td colspan="8">리포트 데이터가 없습니다.</td>
 </tr>  
<%} %>                    	                  
                     </tbody>
                     <tbody id="tbodyRpt">
<%

for(int k=0; k<dayrpt.size(); k++){
    Report arpt = dayrpt.get(k);
     
 %>                        
<tr>
                            <td><%=arpt.getRptday()%></td>
                            <td class="textRight"><%=StringUtil.addComma(arpt.getImp()) %></td>
                            <td class="textRight"><%=StringUtil.addComma(arpt.getClick()) %></td>
                            <td class="textRight"><%=StringUtil.addComma(arpt.getUv()) %></td>
                            <td class="textRight"><%=StringUtil.addComma(arpt.getUc()) %></td>
                            <td class="textRight"><%=StringUtil.addComma(arpt.getViews()) %></td>
                            <td class="textRight"><%=arpt.getCtr() %>%</td>
                            <td class="textRight"><%=arpt.getCpr() %>%</td>
                         </tr>
 <%} %>                     
 				</tbody>
                </table>
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
