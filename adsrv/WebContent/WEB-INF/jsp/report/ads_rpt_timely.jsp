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
<%@page import="tv.pandora.adsrv.domain.DayReport"%>    
<%	
try
{
	String a = StringUtil.isNull(request.getParameter("a"));
	String sday = StringUtil.isNull(request.getParameter("sday"));
	String eday = StringUtil.isNull(request.getParameter("eday"));

	Map<String,Object> map = (Map)request.getAttribute("response");
	
	Map<String, String> paramap = (Map<String,String>)map.get("paramap");
	JSONObject param_data = JSONObject.fromObject(paramap);
	
	Campaign cp = (Campaign)map.get("cp");
	List<Report> rptlist = (List<Report>)map.get("rptlist"); 	
	
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
                    <div class="title">사이트 리포트</div>
                    <div class="breadcrumbs"><span class="glyIcon"><img src="<%=web%>/img/navIcon.png" alt=""></span> 현재위치 : 리포트 > 사이트 리포트</div>
                    <!-- title End -->
                </div>
                <!-- campaign view Start -->
                <!-------------------------------------------------- 공통  ---------------------------------------------->
 				<%@ include file="./site_rpt.jsp" %>
              <!-------------------------------------------------- 공통  ---------------------------------------------->
                <br>
                <!-- list Table Start -->
<table class="listTable2">
 				<colgroup>
				<col width="*">
				<col width="100"><!-- Request -->
				<col width="100"><!-- 잔여 -->
				<col width="90"><!-- 노출 -->
				<col width="90"><!-- 노출 -->
				<col width="90"><!-- 노출 -->
				<col width="90"><!-- 클릭 -->
				<col width="90"><!-- 클릭 -->
				<col width="90"><!-- 클릭 -->
				<col width="80"><!-- ctr -->
				<col width="80"><!-- ctr -->
				<col width="80"><!-- ctr -->
					</colgroup>                   
					<thead>
                        <tr>
                            <th rowspan="2">시간</th>
                            <th rowspan="2">Request</th>  
                            <th rowspan="2">잔여</th>  
                            <th colspan="<%=salestypelist.size()%>">노출</th>  
                            <th colspan="<%=salestypelist.size()%>">클릭</th>  
                            <th colspan="<%=salestypelist.size()%>">CTR</th>  
                            </tr>
                            <tr>
                            <%for(int i=0;i<salestypelist.size();i++){ Map<String,String> code = salestypelist.get(i);%>
                            <th><%=code.get("isname") %></th>                              
                            <%} %>
                            <%for(int i=0;i<salestypelist.size();i++){ Map<String,String> code = salestypelist.get(i);%>
                            <th><%=code.get("isname") %></th>                              
                            <%} %>
                            <%for(int i=0;i<salestypelist.size();i++){ Map<String,String> code = salestypelist.get(i);%>
                            <th><%=code.get("isname") %></th>                              
                            <%} %>
                       		</tr>
                    </thead>
                    <tbody>
<%


for(int k=0; k<rptlist.size(); k++){
    DayReport rpt = rptlist.get(k);
    
    
%>                    
                    
                    
                        <tr>
                      <td class="textCenter"><%=DateUtil.getYMD(rpt.getRpttime()) %></td>
                      <td class="textRight"><%=StringUtil.addComma(rpt.getInv())%></td>
                      <td class="textRight"><%=StringUtil.addComma(rpt.getRemain())%></td>
                      <td class="textRight"><%=StringUtil.addComma(rpt.getImp_d())%></td>
                      <td class="textRight"><%=StringUtil.addComma(rpt.getImp_n())%></td>
                      <td class="textRight"><%=StringUtil.addComma(rpt.getImp_h())%></td>
                      <td class="textRight"><%=StringUtil.addComma(rpt.getClick_d())%></td>
                      <td class="textRight"><%=StringUtil.addComma(rpt.getClick_n())%></td>
                      <td class="textRight"><%=StringUtil.addComma(rpt.getClick_h())%></td>
                      <td class="textRight"><%=rpt.getCtr_d()%>%</td>
                      <td class="textRight"><%=rpt.getCtr_n()%>%</td>
                      <td class="textRight"><%=rpt.getCtr_h()%>%</td>
	                         
                       </tr>
<%} %>                        
                        
                        
                    </tbody>
                </table>
                <!-- list Table End -->
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

