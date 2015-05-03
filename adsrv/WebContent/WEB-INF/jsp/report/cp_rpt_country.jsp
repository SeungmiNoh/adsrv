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
	List<Report> rptlist = (List<Report>)map.get("rptlist"); 
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
	
	$(document).on("click", "tr[name=dayrpt]", function(e){		
		var cno = $(this).attr("cno");		
		var country = $(this).find("[name=country]").html();
		var cpid = $("#cpid").val();
		var adsid = $("#adsid").val();
		var sday = $("#sday").val();
		var eday = $("#eday").val();
		console.log("rptmgr.do?a=adsCountryDaily&cpid="+cpid+"&adsid="+adsid+"&cno="+cno+"&sday="+sday+"&eday="+eday);
		$.ajax({		    
	    	url : "rptmgr.do?a=adsCountryDaily&cpid="+cpid+"&adsid="+adsid+"&cno="+cno+"&sday="+sday+"&eday="+eday,
	    	dataType: "json",
            success: function (data) {
               	$("#tbodyRpt").html("");
               	$("#crName").html(country);
               	
                $.each(data, function (index, item) {
                	var wkno =  (item.weekday)-1;
	               	   
                	var htmlStr = "";
	               	htmlStr +='<tr>';
	               	htmlStr +='<td ';
	               	if(weekday[wkno].text!=null){
	               		htmlStr +='class="'+weekday[wkno].text+'"';
	               	}
	               	htmlStr +='>'+getYMD(item.rptday,"-");
	               	htmlStr +=' ('+weekday[wkno].isname+')</span></td>';
	               	htmlStr +='<td class="textRight">'+addComma(item.imp )+'</td>';
	               	htmlStr +='<td class="textRight">'+addComma(item.click )+'</td>';
	                htmlStr +='<td class="textRight">'+item.ctr+'%</td>';
	               	htmlStr +='</tr>'; 
	               	$("#tbodyRpt").append(htmlStr);
	            });
           },
            error: function () {
                console.log("에러 발생");
                console.log(e);
            }
		});
		$.ajax({		    
	    	url : "rptmgr.do?a=getAdsCountryTotal&cpid="+cpid+"&adsid="+adsid+"&cno="+cno+"&sday="+sday+"&eday="+eday,
	    	dataType: "json",
            success: function (data) {               	
                $.each(data, function (index, item) {
                	var htmlStr = "";
	               	htmlStr +='<tr>';
	               	htmlStr +='<td class="textCenter">Total</td>';
	               	htmlStr +='<td class="textRight">'+addComma(item.imp )+'</td>';
	               	htmlStr +='<td class="textRight">'+addComma(item.click )+'</td>';
	               	htmlStr +='<td class="textRight">'+item.ctr+'%</td>';
	               	htmlStr +='</tr>'; 
	               	$("#tbodySum").html(htmlStr);
	            });
            },
            error: function () {
                console.log("에러 발생");
            }
		});							
	});
	
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
				<col width="*"><!-- 국가 -->
				<col width="240"><!-- 노출 -->
				<col width="240"><!-- 클릭 -->
				<col width="200"><!-- CTR -->
					</colgroup>                   
	                    <thead>
                        <tr>
                            <th>국가</th>
                            <th>노출</th>
                            <th>클릭</th>
                            <th>CTR</th>
                        </tr>
                    </thead>
                    <tbody class="sum">
 <%if(tot2!=null){ %>                   
						<tr name="dayrpt" cno="">
                        <td><span name="country">Total</span></td>
                         <td class="textRight"><%=StringUtil.addComma(tot2.getImp()) %></td>
                         <td class="textRight"><%=StringUtil.addComma(tot2.getClick()) %></td>
                         <td class="textRight"><%=tot2.getCtr() %>%</td>
                       	</tr> 
<%}else{ %>
 <tr>
 <td colspan="8">리포트 데이터가 없습니다.</td>
 </tr>  
<%} %>                    	                  
                     </tbody>
                     <tbody>
<%

for(int k=0; k<rptlist.size(); k++){
    Report arpt = rptlist.get(k);
     
 %>                        
							<tr name="dayrpt" cno="<%=arpt.getRptday() %>">                           
                            <td><span name="country"><%=arpt.getRptday()%></span></td>
                            <td class="textRight"><%=StringUtil.addComma(arpt.getImp()) %></td>
                            <td class="textRight"><%=StringUtil.addComma(arpt.getClick()) %></td>
                             <td class="textRight"><%=arpt.getCtr() %>%</td>
                         </tr>
 <%} %>                     
 				</tbody>
                </table>
      <div class="boxtitle3" >
                    <h1 class="title4"><span class="glyphicon glyphicon-menu-down"></span> 일자별 리포트 
                    <span class="txtBlue" style="margin-left:10px;"><span class="glyphicon glyphicon-play-circle"></span> <span id="crName">Total</span></span>
                    </h1>
  </div>          
                
                
                <table class="rptTable" >
 				<colgroup>
				<col width="*"><!-- 일자 -->
				<col width="240"><!-- 노출 -->
				<col width="240"><!-- 클릭 -->
				<col width="200"><!-- CTR -->
					</colgroup>                   
	                    <thead>
                        <tr>
                            <th>일자</th>
                            <th>노출</th>
                            <th>클릭</th>                      
                            <th>CTR</th>
                        </tr>
                    </thead>
                    <tbody class="sum"  id="tbodySum">
 <%if(tot2!=null){ %>                   
						<tr>
                         <td>Total</td>
                         <td class="textRight"><%=StringUtil.addComma(tot2.getImp()) %></td>
                         <td class="textRight"><%=StringUtil.addComma(tot2.getClick()) %></td>
                         <td class="textRight"><%=tot2.getCtr() %>%</td>

                       	</tr> 
<%}else{ %>
 <tr>
 <td colspan="8">리포트 데이터가 없습니다.</td>
 </tr>  
<%} %>                    	                  
                     </tbody>
                     <tbody id="tbodyRpt">
<%
Integer wkno = 0;
String wkstyle = "";
String wkname = "";

for(int k=0; k<dayrpt.size(); k++){
    Report arpt = dayrpt.get(k);
    
    wkno = Integer.parseInt(arpt.getWeekday())-1;
    wkstyle = (weekday.get(wkno)).get("text");
    wkname = (weekday.get(wkno)).get("isname");  
 %>                        
<tr>
                            <td><span class="<%=wkstyle%>"><%=DateUtil.getYMD(arpt.getRptday()) %>   (<%=wkname%>)</span></td>
                            <td class="textRight"><%=StringUtil.addComma(arpt.getImp()) %></td>
                            <td class="textRight"><%=StringUtil.addComma(arpt.getClick()) %></td>
                           <td class="textRight"><%=arpt.getCtr() %>%</td>
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
