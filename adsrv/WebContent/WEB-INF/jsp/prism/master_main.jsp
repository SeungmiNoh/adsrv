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
<%@page import="tv.pandora.adsrv.domain.AdsReport"%>       

<%	
try
{
	String a = StringUtil.isNull(request.getParameter("a"));

	Map<String,Object> map = (Map)request.getAttribute("response");
	
	Map<String, String> paramap = (Map<String,String>)map.get("paramap");
	JSONObject param_data = JSONObject.fromObject(paramap);
	
	
	List<AdsReport> rptlist = (List<AdsReport>)map.get("cprptlist"); 	
	AdsReport cptot = (AdsReport)map.get("cptotal"); 	
	List<SiteReport> medrptlist = (List<SiteReport>)map.get("medrptlist"); 	
	SiteReport medtot = (SiteReport)map.get("medtotal"); 	
	List<Map<String,String>> sitetypelist = (List<Map<String,String>>)map.get("sitetypelist");	
	Gson gson = new Gson();
	String code_data = gson.toJson(sitetypelist);
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
                    <div class="title">Prism 진행 현황</div>
                    <div class="breadcrumbs"><span class="glyIcon"><img src="<%=web %>/img/navIcon.png" alt=""></span> 현재위치 : 프리즘 > 마스터 메인</div>
                    <!-- title End -->
                </div>
                <p class="dateText"><span class="glyphicon glyphicon-bell"></span> <span class="textBold"><%=DateUtil.getYMDKor(DateUtil.curDate()) %></span> 총 <%=cptot.getLivecnt() %>개 캠페인 진행 중 입니다.</p>
                <!-- campaign view Start -->
         		<form id="frmRpt" action="rptmgr.do" method="get">
                <input type="hidden" name="a" value="<%=a %>">
 
                <!-- ads list Start -->
                <div class="boxtitle2" style="width:1200px;">
                     <div class="saveBtn2">
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

                            <button type="submit" class="btn btn-warning btn-sm">조회</button>
                        </div>
                    </div>
                    <!-- 2th title Start -->
                    <h1 class="title3">매체 현황</h1>
                    <!-- 2th title End -->
                </div>
                     </form>
               
                <!-- list Table Start -->
<table class="rptTable">
                    <colgroup>
                    <col width="2%">
                    <col width="">
                    <col width="">
                    <col width="">
                    <col width="10%">
                    <col width="">
                    <col width="">
                    <col width="">
                    <col width="">
                    <col width="10%">
                    <col width="10%">
                    </colgroup>
                    <thead>
                        <tr>
                            <th rowspan="2">No</th>
                            <th rowspan="2">매체명</th>
                            <th rowspan="2">Request</th>
                            <th rowspan="2">Imp</th>
                            <th rowspan="2">Fill Rate(%)</th>
                            <th>HIT</th>
                            <th>View</th>
                            <th>Click</th>
                            <th rowspan="2">Skip</th>
                            <th rowspan="2">비중</th>
                            <th rowspan="2">무효 클릭수</th>
                        </tr>
                        <tr>
                            <th class="thBg">HTR</th>
                            <th class="thBg">VTR</th>
                            <th class="thBg">CTR</th>
                        </tr>
                    </thead>
                    <tbody class="sum">
<%if(!StringUtil.isNull(medtot.getInv()).equals("")) {%>                    
                        <tr>
                            <td colspan="2" colspan="3">Total</td>
	 	                   	<td rowspan="2" class="textRight"><%=StringUtil.addComma(medtot.getInv())%></td>
		                   	<td rowspan="2" class="textRight"><%=StringUtil.addComma(medtot.getImp())%></td>
		                    <td rowspan="2" class="textRight"><%=medtot.getFillrate()%>%</td>
	  	                   	<td class="textRight"><%=StringUtil.addComma(medtot.getHit())%></td>
		                   	<td class="textRight"><%=StringUtil.addComma(medtot.getViews())%></td>
		                   	<td class="textRight"><%=StringUtil.addComma(medtot.getClick())%></td>
		                   	<td class="textRight"><%=StringUtil.addComma(medtot.getSkip())%></td>
                            <td class="textRight">100%</td>
 	                   		<td class="textRight"><%=StringUtil.addComma(medtot.getVoids())%></td>
                       </tr>
<%}else{ %>
<tr><td colspan="11">데이터가 없습니다.</td></tr>
<%}%>                       
                    </tbody>
                    <tbody>
<%

for(int k=0; k<medrptlist.size(); k++){
	SiteReport rpt = medrptlist.get(k);
 %>                     <tr>
                        	<td rowspan="2"><%=(k+1)%></td>
	                   	<td rowspan="2" class="textLeft" ><a href="rptmgr.do?a=sitePrismDaily&siteid=<%=rpt.getSiteid()%>"><%=rpt.getSitename()%></a></td>
	                   	<td rowspan="2" class="textRight"><%=StringUtil.addComma(rpt.getInv())%></td>
	                   	<td rowspan="2" class="textRight"><%=StringUtil.addComma(rpt.getImp())%></td>
	                    <td rowspan="2" class="textRight"><%=rpt.getFillrate()%>%</td>
	                   	<td class="textRight"><%=StringUtil.addComma(rpt.getHit())%></td>
	                   	<td class="textRight"><%=StringUtil.addComma(rpt.getViews())%></td>
	                   	<td class="textRight"><%=StringUtil.addComma(rpt.getClick())%></td>
	                   	<td rowspan="2" class="textRight"><%=StringUtil.addComma(rpt.getSkip())%></td>
	                   	<td rowspan="2" class="textRight"><%=rpt.getWeight()%>%</td>
	                   	<td rowspan="2" class="textRight"><%=StringUtil.addComma(rpt.getVoids())%></td>
	                    </tr> 
	                   	<tr>	           	
	                   	<td class="tdBg textRight"><%=rpt.getHtr()%>%</td>
	                   	<td class="tdBg textRight"><%=rpt.getVtr()%>%</td>
	                   	<td class="tdBg textRight"><%=rpt.getCtr()%>%</td>
	                   	</tr> 

                       
<%} %>                                             
                    </tbody>
                </table>
                <!-- list Table End -->
                <!-- ads list End -->
                <br>
                <!-- ads list Start -->
                <div class="boxtitle2">
                    <!-- 2th title Start -->
                    <h1 class="title3">캠페인 현황</h1>
                    <!-- 2th title End -->
                </div>
                <!-- list Table Start -->

                <table class="rptTable">
                <colgroup>
						<col width="40"><!-- No -->
						<col width="*"><!-- 애즈명 -->
						<col width="120"><!-- 기간 -->
						<col width="120"><!-- 잔여일 -->
						<col width="120"><!-- 보장량 -->
						<col width="120"><!-- 총노출-->
						<col width="100"><!-- hit -->
						<col width="120"><!-- 잔여목표-->
						<col width="90"><!-- 금일목표-->
						<col width="90"><!-- 금일HIT-->
				</colgroup>
                     <thead>
                         <tr>
                            <th rowspan="2">No</th>
                             <th rowspan="2">캠페인명</th>
                             <th rowspan="2">기간</th>
                             <th>잔여일</th>
                             <th>보장량</th>
                             <th>Imp</th>
                             <th>HIT</th>
                             <th rowspan="2">잔여목표량</th>
                             <th rowspan="2">금일목표</th>
                             <th>금일HIT</th>
                            
                         </tr>
                         <tr>
                             <th class="thBg">진행율</th>
                             <th class="thBg">도달율</th>
                             <th class="thBg">CTR</th>                
                             <th class="thBg">HTR</th>                
                             <th class="thBg">달성율</th>                
                         </tr>
                     </thead>
                    <tbody>
 <%

for(int k=0; k<rptlist.size(); k++){
    AdsReport rpt = rptlist.get(k);
 %>                     <tr>
	                   	<td rowspan="2"><%=(k+1)%></td>
	                   	<td rowspan="2" class="textLeft"><a href="rptmgr.do?a=summaryPrism&cpid=<%=rpt.getCpid()%>"><%=rpt.getCpname()%></a></td>
	                   	<td rowspan="2"><%=DateUtil.getYMD(rpt.getStartdate())%>~<%=DateUtil.getYMD(rpt.getEnddate())%></td>
	                   	<td class="textRight"><%=rpt.getRemaindays()%>일 / <%=rpt.getTotaldays()%>일</td>
	                   	<td class="textRight"><%=StringUtil.addComma(rpt.getBook_total())%></td>
	                   	<td class="textRight"><%=StringUtil.addComma(rpt.getTotal_imp())%></td>
	                   	<td class="textRight"><%=StringUtil.addComma(rpt.getTotal_hit())%></td>
	                   	<td rowspan="2" class="textRight"><%=StringUtil.addComma(rpt.getRemain ())%></td>
	                   	<td rowspan="2" class="textRight"><%=StringUtil.addComma(rpt.getToday_goal())%></td>
	                   	<td class="textRight"><%=rpt.getToday_hit()%></td>
	                    </tr> 
	                   	<tr>	           	
	                   	<td class="tdBg textRight"><%=rpt.getGo_rate()%>%</td>
	                   	<td class="tdBg textRight"><%=rpt.getBookrate()%>%</td>
	                   	<td class="tdBg textRight"><%=rpt.getTotal_ctr()%>%</td>
	                   	<td class="tdBg textRight"><%=rpt.getTotal_htr()%>%</td>
	                   	<td class="tdBg textRight"><%=rpt.getToday_rate()%>%</td>
	                   	</tr> 

                       
<%} %>                     
                    </tbody>
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
