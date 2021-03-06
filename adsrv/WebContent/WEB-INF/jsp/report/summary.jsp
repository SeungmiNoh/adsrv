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
<%@page import="tv.pandora.adsrv.domain.Report"%>       
<%	
try
{
	
	Map<String,Object> map = (Map)request.getAttribute("response");
	String sday = StringUtil.isNull(request.getParameter("sday"));
	String eday = StringUtil.isNull(request.getParameter("eday"));

	Campaign cp = (Campaign)map.get("cp");
	
	if(sday.equals("")) {
		sday = DateUtil.getYMD(cp.getStartdate());
		eday = DateUtil.getYMD(cp.getEnddate());
	}
	List<Ads> adslist = (List<Ads>)map.get("adslist"); 
	List<Report> adsrpt = (List<Report>)map.get("adsrpt"); 
	List<Report> crrpt = (List<Report>)map.get("crrpt"); 
	
	
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
	//$(".debug").css("display","none");

		
		//메뉴이동
  	
		
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
	
		$("#start").datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth:true,
			changeYear:true,
			onClose: function(selectDate){
					$("#end").datepicker("option","minDate",selectDate);					
					//$(this).trigger("change");
			}
	});
	$("#end").datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth:true,
			changeYear:true,
			onClose: function(selectDate){
					$("#start").datepicker("option","maxDate",selectDate);
					//$(this).trigger("change");
					
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
                          <div class="title">캠페인 리포트 <span class="txtBlue" style="margin-left:10px;font-size:9pt"><span class="glyphicon glyphicon-play-circle"></span> <%=cp.getCpname() %> </span></div>
                    <div class="breadcrumbs"><span class="glyIcon"><img src="<%=web%>/img/navIcon.png" alt=""></span> 현재위치 : 리포트  > 캠페인  > 요약 리포트</div>
                    <!-- title End -->
                </div>      
                <table class="viewTable" style="width:900px">
				<colgroup>
				<col width="10%">
				<col width="23%">
				<col width="10%">
				<col width="23%">
				<col width="10%">
				<col width="">
				</colgroup>
                    <tr>
                        <th>캠페인명</th>
                        <td colspan="3"><%=cp.getCpname() %></td>
                        <th>담당자</th>
                        <td><%=cp.getTcname() %></td>
                    </tr>
                    <tr>
                        <th>광고주</th>
                        <td><%=cp.getClientname() %></td>
                        <th>대행사</th>
                        <td><%=StringUtil.isNull(cp.getAgencyname()) %></td>
                        <th>미디어렙</th>
                        <td><%=StringUtil.isNull(cp.getMedrepname()) %></td>
                    </tr>
                    <tr>
                        <th>보장량</th>
                        <td><%=StringUtil.addComma(cp.getBook_total()) %></td>
                        <th>목표량</th>
                        <td><%=StringUtil.addComma(cp.getGoal_total()) %></td>
                        <th>집행금액</th>
                        <td><%=StringUtil.addComma(cp.getBudget()) %></td>
                    </tr>
                    <tr>
                        <th>시작일</th>
                        <td><%=DateUtil.getYMD(cp.getStartdate(), "-") %></td>
                        <th>종료일</th>
                        <td><%=DateUtil.getYMD(cp.getEnddate(), "-") %></td>
                        <th>상태</th>
                        <td><span class="<%=cp.getText()%>"><%=StringUtil.isNull(cp.getCp_statename()) %></span></td>
                    </tr>
                </table>
                <div class="buttonGroup" style="width:900px">
                                         
                </div>
                <form id="frmRpt" action="rptmgr.do" method="get">
                <input type="hidden" name="a" value="summary">
                <input type="hidden" name="cpid" value="<%= cp.getCpid()%>">
                <!-- tap menu Start -->
                <div class="tapBox3">
                		<nav class="tapMenu">
                            <ul>  
                                <li><a href="#none" name="rptMenu" alink="summary" class="active" >요약리포트<span class="glyphicon glyphicon-menu-right"></span></a>
                               </li>
                                <li><a href="#name" name="rptMenu" alink="adsRpt">애즈 리포트<span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="#name" name="rptMenu" alink="crRpt">광고물 리포트<span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>                               
                                <li><a href="#name" name="rptMenu" alink="timeRpt">시간 리포트<span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="#name" name="rptMenu" alink="nationRpt">국가 리포트<span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                            </ul>
                        </nav>
                 </div>
                <!-- tap menu End -->
                <!-- campaign view End -->
                <!-- ads list Start -->
                <div class="boxtitle3">
                    <!-- saveBtn Start -->
                    <div class="saveBtn4">
                        <div class="form-inline">
                            <div class="form-group">
                                <input type="text" class="form-control input-sm" name="sday" id="start" value="<%=sday%>" style="width:90px">
                                <a class="btn btn-success btn-sm" href="#none" role="button" id="btnSday"><span class="glyphicon glyphicon-calendar"></span></a>
                                <input type="text" class="form-control input-sm" name="eday" id="end" value="<%=eday%>" style="width:90px">
                                <a class="btn btn-success btn-sm" href="#none" role="button" id="btnEday"><span class="glyphicon glyphicon-calendar"></span></a>
                                 <a class="btn btn-warning" href="javascript:$('#frmRpt').submit()" role="button">조회</a>
                                 <a class="btn btn-default" href=""><img src="<%=web %>/img/page_excel.png" alt="excel Icon"></a>
                            </div>
                        </div>
                    </div>
                    <!-- saveBtn End -->
                    <!-- 2th title Start -->
                    <h1 class="title4"><span class="glyphicon glyphicon-ok"></span> 애즈 리포트</h1>
                    <!-- 2th title End -->
                </div>
                 </form>
                
                <table class="rptTable">
 				<colgroup>
				<col width="40">
				<col width="380"><!-- 애즈명 -->
				<col width="120"><!-- 시작일 -->
				<col width="120"><!-- 종료일 -->
				<col width="100"><!-- 목표타입 -->
				<col width="100"><!-- 보장량 -->
				
				<col width="100"><!-- 노출 -->
				<col width="100"><!-- 클릭 -->
				<col width="100"><!-- 리치 -->
				<col width="100"><!-- 유니크클릭 -->				
				<col width="80"><!-- View -->
				
				<col width="80"><!-- CTR -->
				<col width="80"><!-- CPR -->
				<col width="90"><!-- 일평균 노출량-->								
				<col width="90"><!-- 도달율 -->				
				<col width="120"><!-- 상태 -->	
					</colgroup>                   
	                    <thead>
                        <tr>
                            <th>No</th>
                            <th>애즈명</th>
                            <th>시작일</th>
                            <th>종료일</th>
                            <th>목표타입</th>
                            <th>보장량</th>
                            
                            <th>노출</th>
                            <th>클릭</th>
                            <th>리치</th>
                            <th>유니크클릭</th>
                            <th>View</th>
                            
                            <th>CTR</th>
                            <th>CPR</th>
                            <th>일평균<br/>노출량</th>
                            <th>도달율</th>
                            <th>상태</th>
                        </tr>
                    </thead>
                    <tbody>
<%

for(int k=0; k<adsrpt.size(); k++){
                                        
    Report ads = adsrpt.get(k);
    
	 
 %>                        <tr>
                            <td><%=k+1 %></td>
                            <td class="textLeft"><span name="cpmod" adsid="<%=ads.getAdsid()%>" class="label label-<%=ads.getIsprism().equals("Y")?"warning":"default"%>" style="margin-right:6px">P</span>                                                    
                            <a href="cpmgr.do?a=adsInfo&adsid=<%=ads.getAdsid()%>" class="<%=ads.getText()%>"><%=ads.getAdsname() %><%=ads.getIstarget().equals("Y")?"<span class='txtRed' style='font-size:8pt;margin:4px'>targeting</span>":""%></a></td>                            
                            <td><span class="txtBlack mr4"><%=DateUtil.getYMD(ads.getStartdate()) %></span> <%--DateUtil.getCutHH(ads.getStartdate()) %>:<%=DateUtil.getCutMM(ads.getStartdate())--%></td>
                            <td><span class="txtBlack mr4"><%=DateUtil.getYMD(ads.getEnddate()) %></span> <%--DateUtil.getCutHH(ads.getEnddate()) %>:<%=DateUtil.getCutMM(ads.getEnddate())--%></td>
                            <td><%=ads.getGoaltypename() %></td>
                            <td class="textRight"><%=StringUtil.addComma(ads.getBook_total()) %></td>
                            <td class="textRight"><%=StringUtil.addComma(ads.getImp()) %></td>
                            <td class="textRight"><%=StringUtil.addComma(ads.getClick()) %></td>
                            <td class="textRight"><%=StringUtil.addComma(ads.getUv()) %></td>
                            <td class="textRight"><%=StringUtil.addComma(ads.getUc()) %></td>
                            <td class="textRight"><%=StringUtil.addComma(ads.getViews()) %></td>
                            <td class="textRight"><%=ads.getCtr() %>%</td>
                            <td class="textRight"><%=ads.getCpr() %>%</td>
                             <td class="textRight"><%=StringUtil.addComma(ads.getAvg_imp()) %></td>
                            <td class="textRight"><%=StringUtil.addComma(ads.getGoalrate()) %></td>
                            <td><a href="cpmgr.do?a=adsEdit&adsid=<%=ads.getAdsid()%>" class="<%=ads.getText()%>"><span class="<%=ads.getText()%>"><%=ads.getAds_statename() %></span></a></td>
                        	</tr>
 <%} %>                     
 				</tbody>
                </table>
        
                <!-- list Table End -->
                <!-- creative list End -->                 
                <!-- creative list Start -->
                <div class="boxtitle2">                    
                    <!-- 2th title Start -->
                    <h2 class="title3">광고물</h2>
                    <!-- 2th title End -->
                </div>
                <!-- list Table Start -->
                <table class="rptTable" >
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
                    <tbody>
<%
for(int k=0; k<crrpt.size(); k++){
    Report arpt = crrpt.get(k);
 %>                        
<tr>
                            <td><%=k+1 %></td>
                            <td class="textLeft">
                            <%if(!StringUtil.isNull(arpt.getCrurl()).equals("")){%><a href=javascript:newTab("<%=arpt.getCrurl() %>")><span class="glyphicon glyphicon glyphicon-picture mr4" style="font-size:10pt"></span></a><%}%>
                            <a href="cpmgr.do?a=crInfo&crid=<%=arpt.getCrid()%>"><%=arpt.getCrname() %></a></td>                            
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
