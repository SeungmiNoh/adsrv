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
	
	List<Ads> adslist = null; 
	List<PrismReport> rptlist = (List<PrismReport>)map.get("rptlist"); 	
	PrismReport tot = (PrismReport)map.get("rpttotal"); 	
	
	

	
	
	
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
		var adsid = $(this).attr("adsid");		
		var adsname = $(this).find("[name=adsname]").html();
		var cpid = $("#frmRpt input[name=cpid]").val();
		var sday = $("#frmRpt input[name=sday]").val();
		var eday = $("#frmRpt input[name=eday]").val();
		$.ajax({		    
	    	url : "rptmgr.do?a=adsPrismDaily&cpid="+cpid+"+&adsid="+adsid+"&sday="+sday+"&eday="+eday,
	    	dataType: "json",
            success: function (data) {
               	$("#tbodyRpt").html("");
               	$("#adsName").html(adsname);
               	
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
	               	htmlStr +='<td class="textRight">'+addComma(item.guarantee )+'</td>';
	               	htmlStr +='<td class="textRight">'+item.bookrate+'%</td>';
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
	    	url : "rptmgr.do?a=adsPrismDailyTotal&cpid="+cpid+"+&adsid="+adsid+"&sday="+sday+"&eday="+eday,
	    	dataType: "json",
            success: function (data) {               	
                $.each(data, function (index, item) {
                	var htmlStr = "";
	               	htmlStr +='<tr>';
	               	htmlStr +='<td>Total</td>';
	               	htmlStr +='<td class="textRight">'+addComma(item.guarantee )+'</td>';
	               	htmlStr +='<td class="textRight">'+item.bookrate+'%</td>';
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
            error: function () {
                console.log("에러 발생");
            }
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
                    <div class="title">캠페인 리포트</div>
                    <div class="breadcrumbs"><span class="glyIcon"><img src="<%=web%>/img/navIcon.png" alt=""></span> 현재위치 : 프리즘 > 캠페인 리포트</div>
                    <!-- title End -->
                </div>      
              <!-------------------------------------------------- 공통  ---------------------------------------------->
 				<%@ include file="./cp_prism.jsp" %>
                
                <form id="ajaxfrom" action="rptmgr.do" method="POST">
                <input type="hidden" name="a" value="adsDaily">
                <input type="hidden" name="adsid" value="">
                <input type="hidden" name="sday" value="">
                <input type="hidden" name="sday" value="">               
                
                <table class="rptTable table table-hover" style="width:1680">
                <colgroup>
						<col width="40"><!-- No        -->
						<col width="*"><!-- 애즈명  -->
						<col width="60"><!-- 상태      -->
						<col width="140"><!-- 기간      -->
						<col width="90"><!-- 보장량    -->
						<col width="60"><!-- 달성율    -->
						<col width="90"><!-- Imp       -->
						<col width="90"><!-- >HIT      -->
						<col width="60"><!-- >HTR(%)   -->
						<col width="90"><!-- >View     -->
						<col width="60"><!-- >VTR(%)   -->
						<col width="90"><!-- >Click    -->
						<col width="60"><!-- >CTR(%)   -->
						<col width="70"><!-- Skip      -->
						<col width="70"><!-- 평균단가  -->
						<col width="70"><!-- 무효클릭  -->				
						</colgroup>
                     <thead>
                         <tr>
                            <th rowspan="2">No</th>
                             <th rowspan="2">애즈명</th>
                             <th rowspan="2">상태</th>
                             <th rowspan="2">기간</th>
                             <th rowspan="2">보장량</th>
                             <th rowspan="2">달성율</th>
                             <th rowspan="2">Imp</th>
                             <th colspan="6">HIT</th>
                             <th rowspan="2">Skip</th>
                             <th rowspan="2">평균단가</th>
                             <th rowspan="2">무효클릭</th>
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

if(tot!=null){

 %> <tr name="dayrpt" adsid="">
    <td colspan="4">Total</td>
    <td class="textRight"><%=StringUtil.addComma(tot.getBook_total())%></td>
    <td class="textRight"><%=tot.getBookrate()%>%</td>
    <td class="textRight"><%=StringUtil.addComma(tot.getImp())%></td>
    <td class="textRight"><%=StringUtil.addComma(tot.getHit())%></td>
    <td class="textRight"><%=tot.getHtr()%>%</td>
    <td class="textRight"><%=StringUtil.addComma(tot.getViews())%></td>
    <td class="textRight"><%=tot.getVtr()%>%</td>
    <td class="textRight"><%=StringUtil.addComma(tot.getClick())%></td>
    <td class="textRight"><%=tot.getCtr()%>%</td>
    <td class="textRight"><%=StringUtil.addComma(tot.getSkip())%></td>
    <td class="textRight"><%=StringUtil.addComma(tot.getAvg_cost())%></td>
    <td class="textRight"><%=StringUtil.addComma(tot.getVoids())%></td>
	</tr> 
<%} %>                       
                      </tbody>
                    <tbody>
 <%

for(int k=0; k<rptlist.size(); k++){
    PrismReport rpt = rptlist.get(k);
 %>                     
    <tr name="dayrpt" adsid="<%=rpt.getId()%>">
    <td ><%=(k+1)%></td>
    <td class="textLeft"><span name="adsname"  class="<%=rpt.getText()%>"><%=rpt.getName() %></span></td>
    <td><span class="<%=rpt.getText()%>"><%=rpt.getState()%></span></td>
    <td><%=DateUtil.getYMD(rpt.getStartdate())%> ~ <%=DateUtil.getYMD(rpt.getEnddate())%></td>
    <td class="textRight"><%=StringUtil.addComma(rpt.getBook_total())%></td>
    <td class="textRight"><%=rpt.getBookrate()%>%</td>
    <td class="textRight"><%=StringUtil.addComma(rpt.getImp())%></td>
    <td class="textRight"><%=StringUtil.addComma(rpt.getHit())%></td>
    <td class="textRight"><%=rpt.getHtr()%>%</td>
    <td class="textRight"><%=StringUtil.addComma(rpt.getViews())%></td>
    <td class="textRight"><%=rpt.getVtr()%>%</td>
    <td class="textRight"><%=StringUtil.addComma(rpt.getClick())%></td>
    <td class="textRight"><%=rpt.getCtr()%>%</td>
    <td class="textRight"><%=StringUtil.addComma(rpt.getSkip())%></td>
    <td class="textRight"><%=StringUtil.addComma(rpt.getCost())%></td>
    <td class="textRight"><%=StringUtil.addComma(rpt.getVoids())%></td>
	</tr> 
<%} %>                     
                </tbody>
                </table>            
        </form>
                <div class="boxtitle3" >                   
                    <h1 class="title4"><span class="glyphicon glyphicon-menu-down"></span> 일자별 리포트 
                    <span class="txtBlue" style="margin-left:10px;"><span class="glyphicon glyphicon-play-circle"></span> <span id="adsName">Total</span></span>
                    </h1>
                </div>
             <%--************************** 일자별리포트 **************************--%>
                <%@ include file="./com_daily.jsp" %>
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
