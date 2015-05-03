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
	String a = StringUtil.isNull(request.getParameter("a"));
	
	Map<String, String> paramap = (Map<String,String>)map.get("paramap");
	JSONObject param_data = JSONObject.fromObject(paramap);

	
	Campaign cp = (Campaign)map.get("cp");
	
	List<Ads> adslist = null; 
	List<Report> adsrpt = (List<Report>)map.get("adsrpt"); 
	List<Report> crrpt = (List<Report>)map.get("crrpt"); 
	Report tot = (Report)map.get("adstotal"); 
	Report tot2 = (Report)map.get("crtotal"); 
	List<Report> country = (List<Report>)map.get("country"); 
	
	
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
               <!-------------------------------------------------- 공통  ---------------------------------------------->
 				<%@ include file="./cp_rpt.jsp" %>
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
<tbody class="sum">
<%
if(tot!=null) { %> 					
							<tr name="dayrpt" adsid="">
                           	<td></td>
                           	<td><span name="adsname">Total</span></td>
							<td><span class="txtBlack mr4"><%=DateUtil.getYMD(tot.getStartdate()) %></span></td>
                            <td><span class="txtBlack mr4"><%=DateUtil.getYMD(tot.getEnddate()) %></span></td>
                            <td></td>
                            <td class="textRight"></td>
                            <td class="textRight"><%=StringUtil.addComma(tot.getImp()) %></td>
                            <td class="textRight"><%=StringUtil.addComma(tot.getClick()) %></td>
                            <td class="textRight"><%=StringUtil.addComma(tot.getUv()) %></td>
                            <td class="textRight"><%=StringUtil.addComma(tot.getUc()) %></td>
                            <td class="textRight"><%=StringUtil.addComma(tot.getViews()) %></td>
                            <td class="textRight"><%=tot.getCtr() %>%</td>
                            <td class="textRight"><%=tot.getCpr() %>%</td>
                             <td class="textRight"><%=StringUtil.addComma(tot.getAvg_imp()) %></td>
                            <td class="textRight"><%=StringUtil.addComma(tot.getGoalrate()) %></td>
                            <td></td>
                        	</tr>    
<%}else{%>  
 <tr>
 <td colspan="16">리포트 데이터가 없습니다.</td>
 </tr>
 <%} %>                         	              
                    </tbody>
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
                        </tr>
                    </thead>
<tbody class="sum"  id="tbodySum">
 <%if(tot2!=null){ %>   
 						<tr>
                         <td colspan="4">Total</td>
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
<%} %>                      </tbody>
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
                          </tr>
 <%} %>                     
 				</tbody>
                </table>
                
       
                <!-- list Table End -->
                <!-- creative list End -->                 
                <!-- creative list Start -->
                <div class="boxtitle2">                    
                    <!-- 2th title Start -->
                    <h2 class="title3">국가 리포트</h2>
                    <!-- 2th title End -->
                </div>
                <!-- list Table Start -->
 <table class="rptTable" >
 				<colgroup>
				<col width="*"><!-- 일자 -->
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
                    <tbody id="tbodyRpt">
<%

for(int k=0; k<country.size(); k++){
    Report arpt = country.get(k);
     
 %>                        
<tr>
                            <td><%=arpt.getRptday().equals("etc")?"그 외 국가":arpt.getRptday()%></td>
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
