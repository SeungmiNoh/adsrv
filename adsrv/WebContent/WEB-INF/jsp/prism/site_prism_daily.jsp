<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/common.jsp" %>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.google.gson.Gson"%> 
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="tv.pandora.adsrv.common.util.StringUtil"%>
<%@page import="tv.pandora.adsrv.common.util.DateUtil"%>    
<%@page import="tv.pandora.adsrv.domain.PrismReport"%>    
<%	
try
{
	String a = StringUtil.isNull(request.getParameter("a"));
	String sday = StringUtil.isNull(request.getParameter("sday"));
	String eday = StringUtil.isNull(request.getParameter("eday"));

	Map<String,Object> map = (Map)request.getAttribute("response");
	
	Map<String, String> paramap = (Map<String,String>)map.get("paramap");
	JSONObject param_data = JSONObject.fromObject(paramap);
	
	Map<String,String> site = (Map<String,String>)map.get("site");
		
	List<Map<String,String>> weekday = (List<Map<String,String>>)map.get("weekday");   
	Gson gson = new Gson();
	String weekday_data = gson.toJson(weekday);
	
%>  
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
 <script type="text/javascript" src="<%=web%>/dwr/engine.js"></script>
<script type="text/javascript" src="<%=web%>/dwr/util.js"></script>
<script type="text/javascript" src="<%=web%>/dwr/interface/MasDwrService.js"></script>
<script src="<%=web%>/js/bootstrap.js"></script>
<script src="<%=web%>/js/basic.js"></script>
<script src="<%=web%>/js/common.js"></script>


<body>
    <div class="container-fluid containerBg">
 <div class="containerBox">
        <%@ include file="../common/header.jsp"  %>
             <section class="sectionBox">
                <div class="boxTitle">
                    <!-- title Start -->
                     <div class="title">매체 리포트</div>
                    <div class="breadcrumbs"><span class="glyIcon"><img src="<%=web%>/img/navIcon.png" alt=""></span> 현재위치 : 리포트 > 프리즘 > 매체 리포트</div>
                    <!-- title End -->
                </div>
                <!-- campaign view Start -->
                <!-------------------------------------------------- 공통  ---------------------------------------------->
 				<%@ include file="./site_prism.jsp" %>
              <!-------------------------------------------------- 공통  ---------------------------------------------->
                <br>
                <!-- list Table Start -->
<%--************************** 일자별리포트 **************************--%>
               <div class="boxtitle3" >                   
                    <h1 class="title4"><span class="glyphicon glyphicon-menu-down"></span> 일자별 리포트</h1>
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
                            <th rowspan="2">Request</th>
                            <th rowspan="2">Imp</th>
                            <th rowspan="2">Fill Rate</th>
                            <th colspan="6">HIT</th>
                            <th rowspan="2">Skip</th>
                            <th rowspan="2">무효<br>클릭수</th>
							<th rowspan="2">평균단가</th>
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
                    <tbody class="sum" id="tbodySum">
<%

if(day_tot!=null){

 %> 	<tr>
    <td >Total</td>
	<td class="textRight"><%=StringUtil.addComma(day_tot.getInv())%></td>
    <td class="textRight"><%=StringUtil.addComma(day_tot.getImp())%></td>
	<td class="textRight"><%=day_tot.getFillrate()%>%</td>
     <td class="textRight"><%=StringUtil.addComma(day_tot.getHit())%></td>
    <td class="textRight"><%=day_tot.getHtr()%>%</td>
    <td class="textRight"><%=StringUtil.addComma(day_tot.getViews())%></td>
    <td class="textRight"><%=day_tot.getVtr()%>%</td>
    <td class="textRight"><%=StringUtil.addComma(day_tot.getClick())%></td>
    <td class="textRight"><%=day_tot.getCtr()%>%</td>
    <td class="textRight"><%=StringUtil.addComma(day_tot.getSkip())%></td>
    <td class="textRight"><%=StringUtil.addComma(day_tot.getVoids())%></td>
    <td class="textRight"><%=StringUtil.addComma(day_tot.getAvg_cost())%></td>
    <td class="textRight"><%=StringUtil.addComma(day_tot.getCost())%></td>
	</tr> 
<%} %>                     
</tbody>
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
							<td class="textRight"><%=StringUtil.addComma(rpt.getCost())%></td>
                       </tr>
<%} %> 
                    </tbody>
                </table>              
              <%--************************** 일자별리포트 **************************--%>
                <!-- ads list End -->
            </section>
        </div>
    </div>

    <!-- /.modal -->

    <!-- modal End -->

    
</body>
<%
} catch(Exception e) {
    out.println(e.getMessage());
}
%>
</html>

