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
	List<PrismReport> day_rptlist = (List<PrismReport>)map.get("dayrpt"); 	
	PrismReport day_tot = (PrismReport)map.get("daytotal"); 	
		
	
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
                <!-- list Table Start -->
                <table class="rptTable">
                    <thead>
                        <tr>
                            <th rowspan="2">시간</th>
                            <th rowspan="2">Imp</th>
                            <th colspan="6">HIT</th>
                            <th rowspan="2">Skip</th>
                            <th rowspan="2">단가</th>
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
                    <tbody class="sum" id="tbodySum">
<%

if(day_tot!=null){

 %> <tr>
    <td >Total</td>
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


for(int k=0; k<day_rptlist.size(); k++){
    PrismReport rpt = day_rptlist.get(k);
   
  %>                       
                    
                    
                        <tr>
                            <td><%=rpt.getName()%></td>
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
                </table>               </section>



        </div>
    </div>
<%
} catch(Exception e) {
    out.println(e.getMessage());
}
%> 

    
</body>

</html>
