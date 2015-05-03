<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/common.jsp" %>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.google.gson.Gson"%> 
<%@page import="tv.pandora.adsrv.common.util.GoogleChartDTO"%>

<%@page import="tv.pandora.adsrv.common.util.StringUtil"%>
<%@page import="tv.pandora.adsrv.common.util.DateUtil"%>    
<%@page import="tv.pandora.adsrv.domain.Campaign"%>       
<%@page import="tv.pandora.adsrv.domain.Ads"%>  
<%@page import="tv.pandora.adsrv.domain.PrismReport"%>       
<%@page import="tv.pandora.adsrv.domain.ClickTime"%>       

<%	
try
{
	String a = StringUtil.isNull(request.getParameter("a"));

	Map<String,Object> map = (Map)request.getAttribute("response");
	
	Map<String, String> paramap = (Map<String,String>)map.get("paramap");
	JSONObject param_data = JSONObject.fromObject(paramap);
	
	Campaign cp = (Campaign)map.get("cp");
	List<Ads> adslist = null; 

	List<PrismReport> rptlist = (List<PrismReport>)map.get("rptlist"); 	
	PrismReport tot = (PrismReport)map.get("rpttotal"); 	
	
	List<PrismReport> cr_rptlist = (List<PrismReport>)map.get("cr_rptlist"); 	
	PrismReport cr_tot = (PrismReport)map.get("cr_rpttotal"); 	

	List<PrismReport> med_rptlist = (List<PrismReport>)map.get("med_rptlist"); 	
	PrismReport med_tot = (PrismReport)map.get("med_rpttotal"); 	
	
	
	List<ClickTime> clickrpt = (List<ClickTime>)map.get("clickrpt"); 	
	List<ClickTime> skiprpt = (List<ClickTime>)map.get("skiprpt"); 	
	ClickTime clicktot = (ClickTime)map.get("clicktot"); 	
	ClickTime skiptot = (ClickTime)map.get("skiptot"); 	
	
	
	
	
	
	List<Map<String,String>> weekday = (List<Map<String,String>>)map.get("weekday");   
	List<Map<String,String>> codelist = (List<Map<String,String>>)map.get("codelist");	
	
	Gson gson = new Gson();
	String code_data = gson.toJson(codelist);
	String weekday_data = gson.toJson(weekday);
	JSONObject ckdata = JSONObject.fromObject(clicktot);		
	JSONArray click_data = JSONArray.fromObject(clickrpt);
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
 <script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript" src="<%=web %>/js/ajax-googlechart.js"></script>
<link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/themes/base/jquery-ui.css" type="text/css" media="all" />
<script type="text/javascript">

google.load("visualization", "1", {packages:["corechart"]});       
google.setOnLoadCallback(drawChart2);
google.setOnLoadCallback(drawChart1);
function drawChart2() 
{         
  	var data = google.visualization.arrayToDataTable([
  	                                                  ['skip', 'SKIP 누적 합계'],
  	                                                   ['5초',<%=skiptot.getClick1()%>],
	                                               	   ['10초',<%=skiptot.getClick2()%>],
	                                            	   ['15초',<%=skiptot.getClick3()%>],
	                                            	   ['20초',<%=skiptot.getClick4()%>],
	                                            	   ['25초',<%=skiptot.getClick5()%>],
	                                            	   ['30초',<%=skiptot.getClick6()%>],
	                                            	   ['35초 이상',<%=skiptot.getClick7()%>]
  	                                                  ]);
  	
  	var options = {        
		title: '',  
		isStacked: true,   
		fontName: "맑은 고딕, Malgon Gothic",
		  legend : {position: 'bottom', textStyle: {color: '#3a3f58', fontName: "맑은 고딕, Malgon Gothic", bold:true,  fontSize: 13}},
		  hAxis: {title: '', titleTextStyle: {color: 'red'}, textStyle: {color: '#414141', fontName: "맑은 고딕, Malgon Gothic", bold:true,  fontSize: 12}},    
		  vAxis: {textStyle: {color: '#414141', fontName: "맑은 고딕, Malgon Gothic", bold:true,  fontSize: 12}}
	  	};
	var chart = new google.visualization.ColumnChart(document.getElementById('skipChart'));
    chart.draw(data, options);
}
function drawChart1() 
{         
  	var data = google.visualization.arrayToDataTable([
  	                                                  ['click', 'CLICK 누적 합계'],
  	                                                   ['5초',<%=clicktot.getClick1()%>],
	                                               	   ['10초',<%=clicktot.getClick2()%>],
	                                            	   ['15초',<%=clicktot.getClick3()%>],
	                                            	   ['20초',<%=clicktot.getClick4()%>],
	                                            	   ['25초',<%=clicktot.getClick5()%>],
	                                            	   ['30초',<%=clicktot.getClick6()%>],
	                                            	   ['35초 이상',<%=clicktot.getClick7()%>]
  	                                                  ]);
  	
  	var options = {        
		title: '',  
		isStacked: true,   
		fontName: "맑은 고딕, Malgon Gothic",
		  legend : {position: 'bottom', textStyle: {color: '#3a3f58', fontName: "맑은 고딕, Malgon Gothic", bold:true,  fontSize: 13}},
		  hAxis: {title: '', titleTextStyle: {color: 'red'}, textStyle: {color: '#414141', fontName: "맑은 고딕, Malgon Gothic", bold:true,  fontSize: 12}},    
		  vAxis: {textStyle: {color: '#414141', fontName: "맑은 고딕, Malgon Gothic", bold:true,  fontSize: 12}}
	  	};
	var chart = new google.visualization.ColumnChart(document.getElementById('clickChart'));
    chart.draw(data, options);
}
</script>

 
<script type="text/javascript">



function json2array(json){
    var result = [];
    var result1 = [];
    var keys = Object.keys(json);
    
   
       
    keys.forEach(function(i, key){
    	
        console.log(i+") "+key+"="+json[i]);
    	
    	console.log("json[key]="+json[key]);
     	if(json[key]!=""){
    	       result.key = (json[key]);
    	       result1.push(1,result);
    	       result  = [];
    	          		
    	}
    });
    return result1;
}



$(document).ready(function() {
	var ckdata =  <%=ckdata%>;
	var arrayResult = json2array(ckdata);
	
	//console.log("arrayResult : "+ arrayResult);
	
var obj = <%=ckdata%>;
var arrData = [];
var result2 = [];
	
	
	
	

	
	jQuery.each(obj, function(i, val) {
		  //$("#" + i).append(document.createTextNode(" - " + val));
		  
		  //console.log("obj key : "+ i);
		  //console.log("obj val : "+ val);
		  result2.push(i);
		  arrData.push(result2);
		  
	});
	//console.log("arrData : "+ arrData);
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	var weekday =  <%=weekday_data%>;
	
	var ads_code = <%=code_data%>;
	var cur_code = "";
	var htmlstr = "";
	for(var k=0; k<ads_code.length; k++) {
		if(cur_code != ads_code[k].code) {
			cur_code = ads_code[k].code;
		}
		htmlstr = '<option value="'+ads_code[k].isid+'"';	
		htmlstr += '>'+ads_code[k].isname+'</option>';
		$("#"+ads_code[k].code).append(htmlstr);
		
	}
	
	
	
	
	
	
	/*********************** 애즈 선택옵션 *****************************/
	var obj = <%=param_data%>;
	
	jQuery.each(obj, function(i, val) {
		  //$("#" + i).append(document.createTextNode(" - " + val));
		  if(i=="sday" || i=="eday") {
			  $("#"+i).val(getYMD(val,"-"));
		  } else {
			  $("#"+i).val(val);
		  }
	});	
	$.datepicker.regional['ko'] = {
			closeText: '닫기',
			prevText: '이전달',
			nextText: '다음달',
			currentText: '오늘',
			monthNames: ['1월','2월','3월','4월','5월','6월', '7월','8월','9월','10월','11월','12월'],
			monthNamesShort: ['1월','2월','3월','4월','5월','6월', '7월','8월','9월','10월','11월','12월'],
			dayNames: ['일','월','화','수','목','금','토'],
			dayNamesShort: ['일','월','화','수','목','금','토'],
			dayNamesMin: ['일','월','화','수','목','금','토'],
			weekHeader: 'Wk',
			dateFormat: 'yy-mm-dd',
			firstDay: 0,
			isRTL: false,
			duration:200,
			showAnim:'show',
			showMonthAfterYear: true,
			yearSuffix: '년'};
		$.datepicker.setDefaults($.datepicker.regional['ko']);
	
		$("#sday").datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth:true,
			changeYear:true,
			onClose: function(selectDate){
					$("#eday").datepicker("option","minDate",selectDate);					
			}
	});
	$("#eday").datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth:true,
			changeYear:true,
			onClose: function(selectDate){
					$("#sday").datepicker("option","maxDate",selectDate);
			}
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
                <!-- campaign view Start -->
                <!-- view Table Start -->
                
               <!-------------------------------------------------- 공통  ---------------------------------------------->
 				<%@ include file="./cp_prism.jsp" %>
    
                

                <div class="graphBox">
                    <div class="conLeft">
                    <!--  
                        <div class="boxtitle3">
                            <h1 class="title4"><span class="glyphicon glyphicon-ok"></span> 실시간 누적 Skip 데이터</h1>
                        </div>
					-->
                        <!-- graph box Start -->
                        <div class="graphborderBox" style="height:300px;" id="skipChart">
                            
                        </div>
                        <!-- graph box Start -->
                        <!-- list Table Start -->
                        <table class="rptTable">
                            <colgroup>
                                <col width="5%">
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>애즈</th>
                                    <th>5초</th>
                                    <th>10초</th>
                                    <th>15초</th>
                                    <th>20초</th>
                                    <th>25초</th>
                                    <th>30초</th>
                                    <th>30초 이상</th>
                                </tr>
                            </thead>
                            <tbody class="sum">
 <%
if(skiptot!=null){
 %> <tr>
    <td>Total</td>
    <td class="textRight"><%=StringUtil.addComma(skiptot.getClick1())%></td>
    <td class="textRight"><%=StringUtil.addComma(skiptot.getClick2())%></td>
    <td class="textRight"><%=StringUtil.addComma(skiptot.getClick3())%></td>
    <td class="textRight"><%=StringUtil.addComma(skiptot.getClick4())%></td>
    <td class="textRight"><%=StringUtil.addComma(skiptot.getClick5())%></td>
    <td class="textRight"><%=StringUtil.addComma(skiptot.getClick6())%></td>
    <td class="textRight"><%=StringUtil.addComma(skiptot.getClick7())%></td>
  	</tr> 
<%} %>                              </tbody>
                            <tbody>
<%

for(int k=0; k<skiprpt.size(); k++){
    ClickTime rpt = skiprpt.get(k);
 %>                     <tr>
    <td class="textLeft"><%=rpt.getAdsname()%></td>   
    <td class="textRight"><%=StringUtil.addComma(rpt.getClick1())%></td>
    <td class="textRight"><%=StringUtil.addComma(rpt.getClick2())%></td>
    <td class="textRight"><%=StringUtil.addComma(rpt.getClick3())%></td>
    <td class="textRight"><%=StringUtil.addComma(rpt.getClick4())%></td>
    <td class="textRight"><%=StringUtil.addComma(rpt.getClick5())%></td>
    <td class="textRight"><%=StringUtil.addComma(rpt.getClick6())%></td>
    <td class="textRight"><%=StringUtil.addComma(rpt.getClick7())%></td>
  	</tr> 
<%} %>
                            </tbody>
                        </table>
                        <!-- list Table End -->
                        <!-- ads list End -->
                    </div>
                    <div class="conRight">
                        <!-- ads list Start 
                        <div class="boxtitle3">
                            <h1 class="title4"><span class="glyphicon glyphicon-ok"></span> Click 데이터</h1>
                        </div>
                        -->
                      
                        <div class="graphborderBox" style="height:300px;" id="clickChart">
                            
                        </div>
                        <!-- graph box Start -->
                        <!-- list Table Start -->
                        <table class="rptTable">
                            <colgroup>
                                <col width="5%">
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>애즈</th>
                                    <th>5초</th>
                                    <th>10초</th>
                                    <th>15초</th>
                                    <th>20초</th>
                                    <th>25초</th>
                                    <th>30초</th>
                                    <th>30초 이상</th>
                                </tr>
                            </thead>
                            <tbody class="sum">
<%
if(clicktot!=null){
 %> <tr>
    <td>Total</td>
    <td class="textRight"><%=StringUtil.addComma(clicktot.getClick1())%></td>
    <td class="textRight"><%=StringUtil.addComma(clicktot.getClick2())%></td>
    <td class="textRight"><%=StringUtil.addComma(clicktot.getClick3())%></td>
    <td class="textRight"><%=StringUtil.addComma(clicktot.getClick4())%></td>
    <td class="textRight"><%=StringUtil.addComma(clicktot.getClick5())%></td>
    <td class="textRight"><%=StringUtil.addComma(clicktot.getClick6())%></td>
    <td class="textRight"><%=StringUtil.addComma(clicktot.getClick7())%></td>
  	</tr> 
<%}%>                            </tbody>
                            <tbody>
<%

for(int k=0; k<clickrpt.size(); k++){
    ClickTime rpt = clickrpt.get(k);
 %>                     <tr>
    <td class="textLeft"><%=rpt.getAdsname()%></td>   
    <td class="textRight"><%=StringUtil.addComma(rpt.getClick1())%></td>
    <td class="textRight"><%=StringUtil.addComma(rpt.getClick2())%></td>
    <td class="textRight"><%=StringUtil.addComma(rpt.getClick3())%></td>
    <td class="textRight"><%=StringUtil.addComma(rpt.getClick4())%></td>
    <td class="textRight"><%=StringUtil.addComma(rpt.getClick5())%></td>
    <td class="textRight"><%=StringUtil.addComma(rpt.getClick6())%></td>
    <td class="textRight"><%=StringUtil.addComma(rpt.getClick7())%></td>
  	</tr> 
<%} %>                            
                            </tbody>
                        </table>
                        <!-- list Table End -->
                        <!-- ads list End -->
                    </div>
                </div>
                <br>

               <%--************************** 일자별리포트 **************************--%>
                <!-- ads list Start -->
                <div class="boxtitle3">
                    <!-- 2th title Start -->
                    <h1 class="title4"><span class="glyphicon glyphicon-ok"></span> 캠페인 일자 별 리포트</h1>
                    <!-- 2th title End -->
                </div>
                <%@ include file="./com_daily.jsp" %>
              <%--************************** 일자별리포트 **************************--%>
  
                <br>
                <!-- ads list Start -->
                <div class="boxtitle3">
                    <!-- 2th title Start -->
                    <h1 class="title4"><span class="glyphicon glyphicon-ok"></span> 애즈 리포트</h1>
                    <!-- 2th title End -->
                </div>
<!-- list Table Start -->
                 <table class="rptTable" style="width:1680">
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
                     <tbody class="sum"  id="tbodySum">
                     
 <%

if(tot!=null){

 %> <tr>
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
 %>                     <tr>
    <td ><%=(k+1)%></td>
    <td class="textLeft"><span class="<%=rpt.getText()%>"><%=rpt.getName()%></span></td>
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

                <br>
                <!-- ads list Start -->
                <div class="boxtitle3">
                    <!-- 2th title Start -->
                    <h1 class="title4"><span class="glyphicon glyphicon-ok"></span> 광고물 리포트</h1>
                    <!-- 2th title End -->
                </div>
                <!-- list Table Start -->
                 <table class="rptTable" style="width:1680">
               <colgroup>
						<col width="40"><!-- No        -->
						<col width="*"><!-- 광고물  -->
						<col width="60"><!-- 상태     -->
						<col width="160"><!-- 기간      -->
						<col width="100"><!-- Imp       -->
						<col width="100"><!-- >HIT      -->
						<col width="60"><!-- >HTR(%)   -->
						<col width="100"><!-- >View     -->
						<col width="60"><!-- >VTR(%)   -->
						<col width="90"><!-- >Click    -->
						<col width="60"><!-- >CTR(%)   -->
						<col width="90"><!-- Skip      -->
						<col width="70"><!-- 무효클릭  -->				
						</colgroup>
                    <thead>
                        <tr>
                            <th rowspan="2">No</th>
                            <th rowspan="2">광고물명</th>
                            <th rowspan="2">기간</th>
                            <th rowspan="2">상태</th>
                            <th rowspan="2">Imp</th>
                            <th colspan="6">HIT</th>
                            <th rowspan="2">Skip</th>
                            <th rowspan="2">무효
                            <br>클릭수</th>
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

if(cr_tot!=null){

 %> <tr>
    <td colspan="4">Total</td>
     <td class="textRight"><%=StringUtil.addComma(cr_tot.getImp())%></td>
    <td class="textRight"><%=StringUtil.addComma(cr_tot.getHit())%></td>
    <td class="textRight"><%=cr_tot.getHtr()%>%</td>
    <td class="textRight"><%=StringUtil.addComma(cr_tot.getViews())%></td>
    <td class="textRight"><%=cr_tot.getVtr()%>%</td>
    <td class="textRight"><%=StringUtil.addComma(cr_tot.getClick())%></td>
    <td class="textRight"><%=cr_tot.getCtr()%>%</td>
    <td class="textRight"><%=StringUtil.addComma(cr_tot.getSkip())%></td>
    <td class="textRight"><%=StringUtil.addComma(cr_tot.getVoids())%></td>
	</tr> 
<%} %>                       
                      </tbody>                    
                      <tbody>
<%

for(int k=0; k<cr_rptlist.size(); k++){
    PrismReport rpt = cr_rptlist.get(k);
 %>                     <tr>
    <td ><%=(k+1)%></td>
    <td class="textLeft"><%=rpt.getName()%></td>
    <td><span class="<%=rpt.getText()%>"><%=rpt.getState()%></span></td>
    <td><%=DateUtil.getYMD(rpt.getStartdate())%> ~ <%=DateUtil.getYMD(rpt.getEnddate())%></td>
    <td class="textRight"><%=StringUtil.addComma(rpt.getImp())%></td>
    <td class="textRight"><%=StringUtil.addComma(rpt.getHit())%></td>
    <td class="textRight"><%=rpt.getHtr()%>%</td>
    <td class="textRight"><%=StringUtil.addComma(rpt.getViews())%></td>
    <td class="textRight"><%=rpt.getVtr()%>%</td>
    <td class="textRight"><%=StringUtil.addComma(rpt.getClick())%></td>
    <td class="textRight"><%=rpt.getCtr()%>%</td>
    <td class="textRight"><%=StringUtil.addComma(rpt.getSkip())%></td>
    <td class="textRight"><%=StringUtil.addComma(rpt.getVoids())%></td>
	</tr> 
<%} %>
                </table>
                <!-- list Table End -->
                <!-- ads list End -->
<%if(isMain.equals("1")){ %>
                <br>
                <!-- ads list Start -->
                <div class="boxtitle3">
                    <!-- 2th title Start -->
                    <h1 class="title4"><span class="glyphicon glyphicon-ok"></span> 매체 리포트</h1>
                    <!-- 2th title End -->
                </div>
                <!-- list Table Start -->
                <table class="rptTable">
                    <thead>
                        <tr>
                            <th rowspan="2">No</th>
                            <th rowspan="2">매체명</th>
                            <th rowspan="2">캠페인
                            <br>보장량</th>
                            <th rowspan="2">캠페인
                                <br>달성율</th>
                            <th rowspan="2">매체
                                <br>달성율</th>
                            <th rowspan="2">Request</th>
                            <th rowspan="2">Imp</th>
                            <th rowspan="2">Fill
                                <br>Rate(%)</th>
                            <th colspan="6">HIT</th>
                            <th rowspan="2">Skip</th>
                            <th rowspan="2">무효
                                <br>클릭수</th>
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

 %> <tr>
    <td colspan="2">Total</td>
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
 %>                     <tr>
    <td ><%=(k+1)%></td>
    <td class="textLeft"><%=rpt.getName()%></td>
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
                <%} %>
                <!-- list Table End -->
                <!-- ads list End -->
            </section>




			

        </div>
    </div>
    <%
} catch(Exception e) {
    out.println(e.getMessage());
}
%> 
</body>
</html>
