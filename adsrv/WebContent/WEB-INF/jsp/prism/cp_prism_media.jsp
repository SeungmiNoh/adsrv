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
<%@page import="tv.pandora.adsrv.domain.PrismReport"%>       
<%	
try
{
	
	Map<String,Object> map = (Map)request.getAttribute("response");
	String a = StringUtil.isNull(request.getParameter("a"));
	
	Map<String, String> paramap = (Map<String,String>)map.get("paramap");
	JSONObject param_data = JSONObject.fromObject(paramap);

	Campaign cp = (Campaign)map.get("cp");
	
	List<Ads> adslist = (List<Ads>)map.get("adslist");
	
	
	//캠페인보장량때문
	PrismReport tot = (PrismReport)map.get("rpttotal"); 	

	
	List<PrismReport> med_rptlist = (List<PrismReport>)map.get("med_rptlist"); 	
	PrismReport med_tot = (PrismReport)map.get("med_rpttotal"); 	

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
		var siteid = $(this).attr("siteid");		
		var sitename = $(this).find("[name=sitename]").html();
		var cpid = $("#frmRpt input[name=cpid]").val();
		var adsid = $("#frmRpt select[name=adsid]").val();
		var sday = $("#frmRpt input[name=sday]").val();
		var eday = $("#frmRpt input[name=eday]").val();
		console.log("rptmgr.do?a=adsPrismDaily&cpid="+cpid+"&siteid="+siteid+"&adsid="+adsid+"&sday="+sday+"&eday="+eday);
		$.ajax({		    
	    	url : "rptmgr.do?a=adsPrismMedDaily&cpid="+cpid+"&siteid="+siteid+"&adsid="+adsid+"&sday="+sday+"&eday="+eday,
	    	dataType: "json",
            success: function (data) {
               	$("#tbodyRpt").html("");
               	$("#adsName").html(sitename);
               	
                $.each(data, function (index, item) {
                	var wkno =  (item.weekday)-1;
		       
	               	var htmlStr = "";
	               	htmlStr +='<tr>';
	               	htmlStr +='<td><span ';
	               	if(weekday[wkno].text!=null){
	               		htmlStr +='class="'+weekday[wkno].text+'"';
	               	}
	               	htmlStr +='>'+getYMD(item.name,"-");
	               	htmlStr +=' ('+weekday[wkno].isname+')</span></td>';
	               	htmlStr +='<td class="textRight">'+addComma(item.inv )+'</td>';
	               	htmlStr +='<td class="textRight">'+addComma(item.total_imp )+'</td>';
	               	htmlStr +='<td class="textRight">'+item.fillrate+'%</td>';
	               	htmlStr +='<td class="textRight">'+addComma(item.imp )+'</td>';
	               	htmlStr +='<td class="textRight">'+addComma(item.hit )+'</td>';
	               	htmlStr +='<td class="textRight">'+item.htr+'%</td>';
	               	htmlStr +='<td class="textRight">'+addComma(item.views )+'</td>';
	               	htmlStr +='<td class="textRight">'+item.vtr+'%</td>';
	               	htmlStr +='<td class="textRight">'+addComma(item.click )+'</td>';
	               	htmlStr +='<td class="textRight">'+item.ctr+'%</td>';
	               	htmlStr +='<td class="textRight">'+addComma(item.skip )+'</td>';
	               	htmlStr +='<td class="textRight">'+addComma(item.avg_cost )+'</td>';
	               	htmlStr +='<td class="textRight">'+addComma(item.voids )+'</td>';	               	
	               	htmlStr +='</tr>'; 
	               	$("#tbodyRpt").append(htmlStr);
	            });
           },
            error: function () {
                console.log("에러 발생");
            }
		});
		$.ajax({		    
	    	url : "rptmgr.do?a=adsPrismMedDailyTotal&cpid="+cpid+"&siteid="+siteid+"&adsid="+adsid+"&sday="+sday+"&eday="+eday,
	    	dataType: "json",
            success: function (data) {               	
                $.each(data, function (index, item) {
                	var htmlStr = "";
	               	htmlStr +='<tr>';
	               	htmlStr +='<td>Total</td>';
	               	htmlStr +='<td class="textRight">'+addComma(item.inv )+'</td>';
	               	htmlStr +='<td class="textRight">'+addComma(item.total_imp )+'</td>';
	               	htmlStr +='<td class="textRight">'+item.fillrate+'%</td>';
	               	htmlStr +='<td class="textRight">'+addComma(item.imp )+'</td>';
	               	htmlStr +='<td class="textRight">'+addComma(item.hit )+'</td>';
	               	htmlStr +='<td class="textRight">'+item.htr+'%</td>';
	               	htmlStr +='<td class="textRight">'+addComma(item.views )+'</td>';
	               	htmlStr +='<td class="textRight">'+item.vtr+'%</td>';
	               	htmlStr +='<td class="textRight">'+addComma(item.click )+'</td>';
	               	htmlStr +='<td class="textRight">'+item.ctr+'%</td>';
	               	htmlStr +='<td class="textRight">'+addComma(item.skip )+'</td>';
	               	htmlStr +='<td class="textRight">'+addComma(item.avg_cost )+'</td>';
	               	htmlStr +='<td class="textRight">'+addComma(item.voids )+'</td>';	               	
	               	htmlStr +='</tr>'; 
	               	$("#tbodySum").html(htmlStr);
	            });
            },
		});						
	});
    
});
</script>

</head></head>
<body>
    <div class="container-fluid containerBg">
        <div class="containerBox">
        <%@ include file="../common/header.jsp"  %>
            <section class="sectionBox">
                <div class="boxTitle">
                    <!-- title Start -->
                          <div class="title">캠페인 리포트 <span class="txtBlue" style="margin-left:10px;font-size:9pt"><span class="glyphicon glyphicon-play-circle"></span> <%=cp.getCpname() %></span></div>
                    <div class="breadcrumbs"><span class="glyIcon"><img src="<%=web %>/img/navIcon.png" alt=""></span> 현재위치 : 리포트  > 캠페인  > 요약 리포트</div>
                    <!-- title End -->
                </div>      
              <!-------------------------------------------------- 공통  ---------------------------------------------->
 				<%@ include file="./cp_prism.jsp" %>
                
                <table class="rptTable table table-hover" style="width:1680">
                    <thead>
                        <tr>
                            <th rowspan="2">No</th>
                            <th rowspan="2">매체명</th>
                            <th rowspan="2">캠페인
                            <br>보장량</th>
                            <th rowspan="2">캠페인<br>달성율</th>
                            <th rowspan="2">매체<br>달성율</th>
                            <th rowspan="2">Request</th>
                            <th rowspan="2">Imp</th>
                            <th rowspan="2">Fill Rate</th>
                            <th colspan="6">HIT</th>
                            <th rowspan="2">Skip</th>
                            <th rowspan="2">무효<br>클릭수</th>
                            <th rowspan="2">광고비</th>
                        </tr>
                        <tr>
                            <th class="thBg">HIT</th>
                            <th class="thBg">HTR(%)</th>
                            <th class="thBg">View</th>
                            <th class="thBg">VTR(%)</th>
                            <th class="thBg">Click</th>
                            <th class="thBg">CTR(%)</th>
                        </tr>
                    </thead>
                     <tbody class="sum">
                     
 <%

if(med_tot!=null){

 %> <tr name="dayrpt" siteid="">
    <td colspan="2"><span name="sitename">Total</span></td>
     <td class="textRight"><%=StringUtil.addComma(tot.getBook_total())%></td>
    <td class="textRight"><%=StringUtil.addComma(tot.getBookrate())%></td>
    <td class="textRight"><%=med_tot.getBookrate()%>%</td>
    <td class="textRight"><%=StringUtil.addComma(med_tot.getInv())%></td>
    <td class="textRight"><%=StringUtil.addComma(med_tot.getImp())%></td>
    <td class="textRight"><%=med_tot.getFillrate()%>%</td>   
    <td class="textRight"><%=StringUtil.addComma(med_tot.getHit())%></td>
    <td class="textRight"><%=med_tot.getHtr()%>%</td>
    <td class="textRight"><%=StringUtil.addComma(med_tot.getViews())%></td>
    <td class="textRight"><%=med_tot.getVtr()%>%</td>
    <td class="textRight"><%=StringUtil.addComma(med_tot.getClick())%></td>
    <td class="textRight"><%=med_tot.getCtr()%>%</td>
    <td class="textRight"><%=StringUtil.addComma(med_tot.getSkip())%></td>
    <td class="textRight"><%=StringUtil.addComma(med_tot.getVoids())%></td>
   <td class="textRight"><%=StringUtil.addComma(med_tot.getAvg_cost())%></td>
	</tr> 
<%} %>                       
                    </tbody>
                    <tbody>
<%

for(int k=0; k<med_rptlist.size(); k++){
    PrismReport rpt = med_rptlist.get(k);
 %>                     
 <tr name="dayrpt" siteid="<%=rpt.getId() %>">
    <td ><%=(k+1)%></td>
    <td class="textLeft"><span name="sitename"><%=rpt.getName()%></span></td>
    <td class="textRight"><%=StringUtil.addComma(tot.getBook_total())%></td>
    <td class="textRight"><%=StringUtil.addComma(tot.getBookrate())%></td>
    <td class="textRight"><%=rpt.getBookrate()%>%</td>
    <td class="textRight"><%=StringUtil.addComma(rpt.getInv())%></td>
    <td class="textRight"><%=StringUtil.addComma(rpt.getImp())%></td>
    <td class="textRight"><%=rpt.getFillrate()%>%</td>   
    <td class="textRight"><%=StringUtil.addComma(rpt.getHit())%></td>
    <td class="textRight"><%=rpt.getHtr()%>%</td>
    <td class="textRight"><%=StringUtil.addComma(rpt.getViews())%></td>
    <td class="textRight"><%=rpt.getVtr()%>%</td>
    <td class="textRight"><%=StringUtil.addComma(rpt.getClick())%></td>
    <td class="textRight"><%=rpt.getCtr()%>%</td>
    <td class="textRight"><%=StringUtil.addComma(rpt.getSkip())%></td>
    <td class="textRight"><%=StringUtil.addComma(rpt.getVoids())%></td>
   <td class="textRight"><%=StringUtil.addComma(rpt.getAvg_cost())%></td>
	</tr> 
<%} %>                        
                </table>
         </form>
               <%--************************** 일자별리포트 **************************--%>
               <div class="boxtitle3" >                   
                    <h1 class="title4"><span class="glyphicon glyphicon-menu-down"></span> 일자별 리포트 
                    <span class="txtBlue" style="margin-left:10px;"><span class="glyphicon glyphicon-play-circle"></span> <span id="adsName">Total</span></span>
                    </h1>
                </div>
 <%
	List<PrismReport> day_rptlist = (List<PrismReport>)map.get("day_rptlist"); 	
	PrismReport day_tot = (PrismReport)map.get("day_rpttotal"); 	
%>                
                <!-- list Table Start -->
                <table class="rptTable">
                    <thead>
                        <tr>
                            <th rowspan="2">일자</th>
                            <th colspan="3">매체전체</th>
                            <th rowspan="2">Imp</th>
                            <th colspan="6">HIT</th>
                            <th rowspan="2">Skip</th>
                            <th rowspan="2">단가</th>
                            <th rowspan="2">무효
                                <br>클릭수</th>
                        </tr>
                        <tr>
                            <th class="thBg">Request</th>
                            <th class="thBg">IMP</th>
                            <th class="thBg">Fill Rate</th>
                            <th class="thBg">HIT</th>
                            <th class="thBg">HTR(%)</th>
                            <th class="thBg">View</th>
                            <th class="thBg">VTR(%)</th>
                            <th class="thBg">Click</th>
                            <th class="thBg">CTR(%)</th>
                        </tr>
                    </thead>
                    <tbody class="sum" id="tbodySum">
<%

if(day_tot!=null){

 %> 	<tr>
    <td >Total</td>
	<td class="textRight"><%=StringUtil.addComma(day_tot.getInv())%></td>
	<td class="textRight"><%=StringUtil.addComma(day_tot.getTotal_imp())%></td>
	<td class="textRight"><%=day_tot.getFillrate()%>%</td>
     <td class="textRight"><%=StringUtil.addComma(day_tot.getImp())%></td>
    <td class="textRight"><%=StringUtil.addComma(day_tot.getHit())%></td>
    <td class="textRight"><%=day_tot.getHtr()%>%</td>
    <td class="textRight"><%=StringUtil.addComma(day_tot.getViews())%></td>
    <td class="textRight"><%=day_tot.getVtr()%>%</td>
    <td class="textRight"><%=StringUtil.addComma(day_tot.getClick())%></td>
    <td class="textRight"><%=day_tot.getCtr()%>%</td>
    <td class="textRight"><%=StringUtil.addComma(day_tot.getSkip())%></td>
    <td class="textRight"><%=StringUtil.addComma(day_tot.getAvg_cost())%></td>
    <td class="textRight"><%=StringUtil.addComma(day_tot.getVoids())%></td>
	</tr> 
<%} %>                     </tbody>
                    <tbody id="tbodyRpt">
<%
Integer wkno = 0;
String wkstyle = "";
String wkname = "";

for(int k=0; k<day_rptlist.size(); k++){
    PrismReport rpt = day_rptlist.get(k);
    
    wkno = Integer.parseInt(rpt.getWeekday())-1;
   	wkstyle = (weekday.get(wkno)).get("text");
    wkname = (weekday.get(wkno)).get("isname"); 
  %>                       
                    
                    
                        <tr>
                            <td><span class="<%=wkstyle%>"><%=DateUtil.getYMD(rpt.getName()) %>   (<%=wkname%>)</span></td>
							<td class="textRight"><%=StringUtil.addComma(rpt.getInv())%></td>
							<td class="textRight"><%=StringUtil.addComma(rpt.getTotal_imp())%></td>
							<td class="textRight"><%=rpt.getFillrate()%>%</td>
						 	 <td class="textRight"><%=StringUtil.addComma(rpt.getImp())%></td>
						    <td class="textRight"><%=StringUtil.addComma(rpt.getHit())%></td>
						    <td class="textRight"><%=rpt.getHtr()%>%</td>
						    <td class="textRight"><%=StringUtil.addComma(rpt.getViews())%></td>
						    <td class="textRight"><%=rpt.getVtr()%>%</td>
						    <td class="textRight"><%=StringUtil.addComma(rpt.getClick())%></td>
						    <td class="textRight"><%=rpt.getCtr()%>%</td>
						    <td class="textRight"><%=StringUtil.addComma(rpt.getSkip())%></td>
						    <td class="textRight"><%=StringUtil.addComma(rpt.getAvg_cost())%></td>
						    <td class="textRight"><%=StringUtil.addComma(rpt.getVoids())%></td>

                        </tr>
<%} %> 
                    </tbody>
                </table>              
              <%--************************** 일자별리포트 **************************--%>
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
