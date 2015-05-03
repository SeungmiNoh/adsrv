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
<%@page import="tv.pandora.adsrv.domain.SiteReport"%>       
<%@page import="tv.pandora.adsrv.domain.PrismReport"%>       

<%	
try
{
	String a = StringUtil.isNull(request.getParameter("a"));

	Map<String,Object> map = (Map)request.getAttribute("response");
	
	Map<String, String> paramap = (Map<String,String>)map.get("paramap");
	JSONObject param_data = JSONObject.fromObject(paramap);
	
	
	List<PrismReport> rptlist = (List<PrismReport>)map.get("rptlist"); 	
	List<Map<String,String>> codelist = (List<Map<String,String>>)map.get("codelist");	
	Gson gson = new Gson();
	String code_data = gson.toJson(codelist);
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
$(document).ready(function() {

	
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
                    <div class="title">Prism 매체 목록</div>
                    <div class="breadcrumbs"><span class="glyIcon"><img src="<%=web %>/img/navIcon.png" alt=""></span> 현재위치 : 프리즘 > Prism 매체 목록</div>
                    <!-- title End -->
                </div>
                 <!-- search group Start -->
                <form id="frmRpt" action="rptmgr.do" method="get">
                <input type="hidden" name="a" value="<%=a %>">
                        <div class="form-inline">
                            <div class="form-group formGroupPadd">
                                <label for="">기간</label>
                                 <input type="text" class="form-control input-sm" name="sday" id="sday" value="" style="width:90px">
                                <a class="btn btn-success btn-sm" href="#none" role="button" id="btnSday"><span class="glyphicon glyphicon-calendar"></span></a>
                                <input type="text" class="form-control input-sm" name="eday" id="eday" value="" style="width:90px">
                                <a class="btn btn-success btn-sm" href="#none" role="button" id="btnEday"><span class="glyphicon glyphicon-calendar"></span></a>
                            </div>
                            <select id="sitetype" name="sitetype" class="form-control input-sm" style="width:140px">
	                        <option value="">사이트구분</option>
	                        </select>                              
	                            <select id="sch_column" name="sch_column"  class="form-control input-sm" style="width:100px">
                                <option value="sitename">사이트</option>                                
                            </select>
                            <input type="text" class="form-control input-sm" id="sch_text" name="sch_text">
                            <button type="submit" class="btn btn-warning btn-sm">조회</button>
                        </div>
                </form>
                <!-- search group End -->
               <br>
                <!-- list Table Start -->
                <table class="rptTable">
                    <thead>
                        <tr>
                            <th rowspan="2">No</th>
                            <th rowspan="2">매체명</th>
                            <th rowspan="2">Request</th>
                            <th rowspan="2">Imp</th>
                            <th rowspan="2">Fill Rate</th>
                            <th colspan="6">HIT</th>
                            <th rowspan="2">Skip</th>
                            <th rowspan="2">무효
                                <br>클릭수</th>
                            <th rowspan="2">광고비</th>
                        </tr>
                        <tr>
                            <th class="thBg">HIT</th>
                            <th class="thBg">HTR</th>
                            <th class="thBg">View</th>
                            <th class="thBg">VTR</th>
                            <th class="thBg">Click</th>
                            <th class="thBg">CTR</th>
                        </tr>
                    </thead>
                     <tbody class="sum">
                     
                        
                    </tbody>
                    <tbody>
<%

for(int k=0; k<rptlist.size(); k++){
    PrismReport rpt = rptlist.get(k);
 %>                     <tr>
    <td ><%=(k+1)%></td>
    <td class="textLeft"><a href="rptmgr.do?a=sitePrismDaily&siteid=<%=rpt.getId() %>" class="<%=rpt.getText()%>"><%=rpt.getName()%></a></td>
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
            		</div>
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
