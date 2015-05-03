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
	List<Report> crrpt = (List<Report>)map.get("crrpt"); 
	List<Report> clickrpt = (List<Report>)map.get("clickrpt"); 
	List<Report> dayrpt = (List<Report>)map.get("dayrpt"); 
	Report tot = (Report)map.get("crtotal"); 
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
		var crid = $(this).attr("crid");		
		var crname = $(this).find("[name=crname]").html();
		var cpid = $("#cpid").val();
		var adsid = $("#adsid").val();
		var sday = $("#sday").val();
		var eday = $("#eday").val();
		console.log("rptmgr.do?a=adsDaily&cpid="+cpid+"&adsid="+adsid+"&crid="+crid+"&sday="+sday+"&eday="+eday);
		console.log("rptmgr.do?a=crClickRpt&cpid="+cpid+"&adsid="+adsid+"&crid="+crid+"&sday="+sday+"&eday="+eday);
		$.ajax({		    
	    	url : "rptmgr.do?a=adsDaily&cpid="+cpid+"&adsid="+adsid+"&crid="+crid+"&sday="+sday+"&eday="+eday,
	    	dataType: "json",
            success: function (data) {
               	$("#tbodyRpt").html("");
               	$("#crName").html(crname);
               	
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
	               	htmlStr +='<td class="textRight">'+addComma(item.uv )+'</td>';
	               	htmlStr +='<td class="textRight">'+addComma(item.uc )+'</td>';
	               	htmlStr +='<td class="textRight">'+addComma(item.views )+'</td>';
	               	htmlStr +='<td class="textRight">'+item.ctr+'%</td>';
	               	htmlStr +='<td class="textRight">'+item.cpr+'%</td>';
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
	    	url : "rptmgr.do?a=adsDailyTotal&cpid="+cpid+"&adsid="+adsid+"&crid="+crid+"&sday="+sday+"&eday="+eday,
	    	dataType: "json",
            success: function (data) {               	
                $.each(data, function (index, item) {
                	var htmlStr = "";
	               	htmlStr +='<tr>';
	               	htmlStr +='<td>Total</td>';
	               	htmlStr +='<td class="textRight">'+addComma(item.imp )+'</td>';
	               	htmlStr +='<td class="textRight">'+addComma(item.click )+'</td>';
	               	htmlStr +='<td class="textRight">'+addComma(item.uv )+'</td>';
	               	htmlStr +='<td class="textRight">'+addComma(item.uc )+'</td>';
	               	htmlStr +='<td class="textRight">'+addComma(item.views )+'</td>';
	               	htmlStr +='<td class="textRight">'+item.ctr+'%</td>';
	               	htmlStr +='<td class="textRight">'+item.cpr+'%</td>';
	               	htmlStr +='</tr>'; 
	               	$("#tbodySum").html(htmlStr);
	            });
            },
            error: function () {
                console.log("에러 발생");
            }
		});		
		$.ajax({		    
	    	url : "rptmgr.do?a=crClickRpt&cpid="+cpid+"&adsid="+adsid+"&crid="+crid+"&sday="+sday+"&eday="+eday,
	    	dataType: "json",
            success: function (data) {       
            	
            	$("#tbodyClick").html("");
                $.each(data, function (index, item) {
                	var htmlStr = "";
	               	htmlStr +='<tr>';
	               	htmlStr +='<td>'+item.crname+'</td>';
	               	htmlStr +='<td>'+item.clickname +'</td>';
	               	htmlStr +='<td>'+item.clickurl +'</td>';
	               	htmlStr +='<td class="textRight">'+addComma(item.imp )+'</td>';
	               	htmlStr +='<td class="textRight">'+addComma(item.click )+'</td>';
	               	htmlStr +='<td class="textRight">'+addComma(item.uv )+'</td>';
	               	htmlStr +='<td class="textRight">'+addComma(item.uc )+'</td>';
	               	htmlStr +='<td class="textRight">'+addComma(item.views )+'</td>';
	               	htmlStr +='<td class="textRight">'+item.ctr+'%</td>';
	               	htmlStr +='<td class="textRight">'+item.cpr+'%</td>';
	               	htmlStr +='</tr>'; 
	               	$("#tbodyClick").append(htmlStr);
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
               <table class="rptTable table table-hover">
 				<colgroup>
				<col width="40">
				<col width="380"><!-- 광고물명 -->
				<col width="120"><!-- 시작일 -->
				<col width="120"><!-- 종료일 -->
				<col width="100"><!-- 노출 -->
				<col width="100"><!-- 클릭 -->
				<col width="100"><!-- 리치 -->
				<col width="100"><!-- 유니크클릭 -->				
				<col width="80"><!-- View -->
				
				<col width="80"><!-- CTR -->
				<col width="80"><!-- CPR -->
				<col width="90"><!-- 일평균 노출량-->		
					</colgroup>                   
	                    <thead>
                        <tr>
                            <th>No</th>
                            <th>광고물명</th>
                            <th>시작일</th>
                            <th>종료일</th>
                            <th>노출</th>
                            <th>클릭</th>
                            <th>리치</th>
                            <th>유니크클릭</th>
                            <th>View</th>
                            
                            <th>CTR</th>
                            <th>CPR</th>
                            <th>일평균<br/>노출량</th>
                        </tr>
                    </thead>
                     <tbody class="sum">
<%
if(tot!=null) {%> 					
							<tr name="dayrpt" crid="">
                           	<td></td>
                           	<td><span name="crname">Total</span></td>
							<td><span class="txtBlack mr4"><%=DateUtil.getYMD(tot.getStartdate()) %></span></td>
                            <td><span class="txtBlack mr4"><%=DateUtil.getYMD(tot.getEnddate()) %></span></td>
                            <td class="textRight"><%=StringUtil.addComma(tot.getImp()) %></td>
                            <td class="textRight"><%=StringUtil.addComma(tot.getClick()) %></td>
                            <td class="textRight"><%=StringUtil.addComma(tot.getUv()) %></td>
                            <td class="textRight"><%=StringUtil.addComma(tot.getUc()) %></td>
                            <td class="textRight"><%=StringUtil.addComma(tot.getViews()) %></td>
                            <td class="textRight"><%=tot.getCtr() %>%</td>
                            <td class="textRight"><%=tot.getCpr() %>%</td>
                             <td class="textRight"><%=StringUtil.addComma(tot.getAvg_imp()) %></td>
                        	</tr>                  
 <%}else{%>  
 <tr>
 <td colspan="12">리포트 데이터가 없습니다.</td>
 </tr>
 <%} %>                    </tbody>
                 
                    <tbody>
<%
for(int k=0; k<crrpt.size(); k++){
    Report arpt = crrpt.get(k);
 %>                        
							<tr name="dayrpt" crid="<%=arpt.getCrid() %>">                           
                            <td><%=k+1 %></td>
                            <td class="textLeft">
                            <%--if(!StringUtil.isNull(arpt.getCrurl()).equals("")){%><a href=javascript:newTab("<%=arpt.getCrurl() %>")><span class="glyphicon glyphicon glyphicon-picture mr4" style="font-size:10pt"></span></a>
                            <a href="cpmgr.do?a=crInfo&crid=<%=arpt.getCrid()%>"><%=arpt.getCrname() %></a>
                            --%>
                            <span name="crname"><%=arpt.getCrname() %></span>
                            </td>                            
                            <td><span class="txtBlack mr4"><%=DateUtil.getYMD(arpt.getStartdate()) %></span> <%--DateUtil.getCutHH(arpt.getStartdate()) %>:<%=DateUtil.getCutMM(arpt.getStartdate())--%></td>
                            <td><span class="txtBlack mr4"><%=DateUtil.getYMD(arpt.getEnddate()) %></span> <%--DateUtil.getCutHH(arpt.getEnddate()) %>:<%=DateUtil.getCutMM(arpt.getEnddate())--%></td>
                            <td class="textRight"><%=StringUtil.addComma(arpt.getImp()) %></td>
                            <td class="textRight"><%=StringUtil.addComma(arpt.getClick()) %></td>
                            <td class="textRight"><%=StringUtil.addComma(arpt.getUv()) %></td>
                            <td class="textRight"><%=StringUtil.addComma(arpt.getUc()) %></td>
                            <td class="textRight"><%=StringUtil.addComma(arpt.getViews()) %></td>
                            <td class="textRight"><%=arpt.getCtr() %>%</td>
                            <td class="textRight"><%=arpt.getCpr() %>%</td>
                            <td class="textRight"><%=StringUtil.addComma(arpt.getAvg_imp()) %></td>
                         </tr>
 <%} %>                     
 				</tbody>
                </table>
                
                
                
               <div class="boxtitle3" >
                    <h1 class="title4"><span class="glyphicon glyphicon-menu-down"></span> 클릭 상세 리포트 
                    <span class="txtBlue" style="margin-left:10px;"><span class="glyphicon glyphicon-play-circle"></span> <span id="crName">Total</span></span>
                    </h1>
  </div>  
                
                 
                <table class="rptTable table table-hover">
 				<colgroup>
				<col width="380"><!-- 광고물명 -->
				<col width="120"><!-- 시작일 -->
				<col width="120"><!-- 종료일 -->
				<col width="100"><!-- 노출 -->
				<col width="100"><!-- 클릭 -->
				<col width="100"><!-- 리치 -->
				<col width="100"><!-- 유니크클릭 -->				
				<col width="80"><!-- View -->
				
				<col width="80"><!-- CTR -->
				<col width="80"><!-- CPR -->
				<col width="90"><!-- 일평균 노출량-->		
					</colgroup>                   
	                    <thead>
                        <tr>
                            <th>광고물명</th>
                            <th>클릭명</th>
                            <th>클릭URL</th>
                            <th>노출</th>
                             <th>클릭수</th>
                            <th>UV</th>
                             <th>유니크클릭</th>
                            <th>Views</th>
                            <th>CTR</th>
                            <th>CPR</th>
                        </tr>
                    </thead>
                    <tbody id="tbodyClick">
                    
                    
<%--
String cur_crid = "";
for(int k=0; k<clickrpt.size(); k++){
    Report arpt = clickrpt.get(k);
    
    if(!cur_crid.equals(arpt.getCrid())) 
    {
    	
    	cur_crid = arpt.getCrid();
 %>                        
							<tr name="dayrpt" crid="<%=arpt.getCrid() %>"  ckid="<%=arpt.getCkid() %>">                           
                            <td rowspan="<%=arpt.getClickcnt()%>"><%=k+1 %></td>
                            <td class="textLeft" rowspan="<%=arpt.getClickcnt()%>"><span name="crname"><%=arpt.getCrname() %></span></td>
                            <td class="textLeft"><span name="crname"><%=arpt.getClickname() %></span></td>
                            <td class="textLeft"><%=arpt.getClickurl() %></td>
                            <td class="textRight" rowspan="<%=arpt.getClickcnt()%>"><%=StringUtil.addComma(arpt.getImp()) %></td>                            
                            <td class="textRight"><%=StringUtil.addComma(arpt.getClick()) %></td>
                            <td class="textRight" rowspan="<%=arpt.getClickcnt()%>"><%=StringUtil.addComma(arpt.getUv()) %></td>
                            <td class="textRight"><%=StringUtil.addComma(arpt.getUc()) %></td>
                            <td class="textRight" rowspan="<%=arpt.getClickcnt()%>"><%=StringUtil.addComma(arpt.getViews()) %></td>
                            <td class="textRight"><%=arpt.getCtr() %>%</td>
                            <td class="textRight" rowspan="<%=arpt.getClickcnt()%>"><%=arpt.getCpr() %>%</td>
                         </tr>
 <%}else{ %>                        
							<tr>                           
                            <td class="textLeft"><span name="crname"><%=arpt.getClickname() %></span></td>
                            <td class="textLeft"><%=arpt.getClickurl() %></td>
                            <td class="textRight"><%=StringUtil.addComma(arpt.getClick()) %></td>
                            <td class="textRight"><%=StringUtil.addComma(arpt.getUc()) %></td>
                            <td class="textRight"><%=arpt.getCtr() %>%</td>
                         </tr> 
<%		}
    }--%>                      
                    
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
                            <th>일자</th>
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
