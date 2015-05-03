<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/common.jsp" %>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="tv.pandora.adsrv.common.util.StringUtil"%>
<%@page import="tv.pandora.adsrv.common.util.DateUtil"%>    
<%@page import="tv.pandora.adsrv.domain.Ads"%>    
<%@page import="tv.pandora.adsrv.domain.User"%>    
<% 
try
{
	String state = StringUtil.isNull(request.getParameter("state"));	
	String sch_column = StringUtil.isNull(request.getParameter("sch_column"));
	String sch_text = StringUtil.isNull(request.getParameter("sch_text"));	
	sch_text = new String (sch_text.getBytes("8859_1"),"UTF-8");
	
 	Map<String,Object> map = (Map)request.getAttribute("response");
	String sday = StringUtil.isNull(request.getParameter("sday"));	
	String eday = StringUtil.isNull(request.getParameter("eday"));	

	List<Ads> adslist = (List<Ads>)map.get("adslist");   
	List<Map<String,String>> stlist = (List<Map<String,String>>)map.get("stlist");   
	
	
    String totalCount = map.get("totalCount").toString();
    String nowPage = map.get("nowPage").toString();
	
	Integer skip = (Integer)map.get("skip");
	Integer max = (Integer)map.get("max");
	
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
 <script type="text/javascript" src="<%=web%>/dwr/engine.js"></script>
<script type="text/javascript" src="<%=web%>/dwr/util.js"></script>
<script type="text/javascript" src="<%=web%>/dwr/interface/MasDwrService.js"></script>
<script src="<%=web%>/js/bootstrap.js"></script>
<script src="<%=web%>/js/basic.js"></script>
<script src="<%=web%>/js/common.js"></script>
 <script type="text/javascript">


$(function(){
	
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
			}
	});
	$("#end").datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth:true,
			changeYear:true,
			onClose: function(selectDate){
					$("#start").datepicker("option","maxDate",selectDate);
			}
	});
	$('#btnSday').click(function(){
	    $(document).ready(function(){
	        $("#start").datepicker().focus();
	    });
	});
	$('#btnEday').click(function(){
	    $(document).ready(function(){
	        $("#end").datepicker().focus();
	    });
	});

});
</script>
</head>

<body>
    <div class="container-fluid containerBg">
        <div class="containerBox">
        <%@ include file="../common/header.jsp"  %>
             <section class="sectionBox">
                <div class="boxTitle">
                    <!-- title Start -->
                    <div class="title">애즈 목록</div>
                    <div class="breadcrumbs"><span class="glyIcon"><img src="<%=web%>/img/navIcon.png" alt=""></span> 현재위치 : 캠페인 > 애즈 목록</div>
                    <!-- title End -->
                </div>
                <!-- search group Start -->
                <form id="frmList" name="frmList" method="get" action="cpmgr.do?a=adsList">
				<input type="hidden" name="a" value="adsList"/>
				<input type="hidden" name="p" id="page"/>
                    <div class="form-inline">
                        <div class="form-group formGroupPadd">
                            <label>기간</label>
                            <input type="text" class="form-control input-sm" name="sday" id="start" value="<%=sday%>" style="width:90px">
                            <a class="btn btn-success btn-sm" href="#none" role="button" id="btnSday"><span class="glyphicon glyphicon-calendar"></span></a>
                        </div>
                        <div class="form-group formGroupPadd">
                            <input type="text" class="form-control input-sm"  name="eday" id="end" value="<%=eday%>" style="width:90px">
                            <a class="btn btn-success btn-sm" href="#none" role="button" id="btnEday"><span class="glyphicon glyphicon-calendar"></span></a>
                        </div>
                        <div class="form-group formGroupPadd">
                            <select id="state" name="state" class="form-control input-sm">
                                <option value="">상태</option>
                               <%for(int i=0;i<stlist.size();i++){ 
                                	Map<String,String> st = stlist.get(i);
                                %>
                                <option value="<%=String.valueOf(st.get("isid")) %>" <%=state.equals(String.valueOf(st.get("isid")))?"selected":"" %>><%=st.get("isname") %></option>                               
                                <%} %>
                              </select>
                        </div>
                        <div class="form-group formGroupPadd">
                            <select id="sch_column" name="sch_column" class="form-control input-sm">
                                <option value="cpname" <%=sch_column.equals("cpname")?"selected":"" %>>캠페인</option>
                                <option value="clientname" <%=sch_column.equals("clientname")?"selected":"" %>>광고주</option>
                                <option value="agencyname" <%=sch_column.equals("agencyname")?"selected":"" %>>대행사</option>
                                <option value="medrepname" <%=sch_column.equals("medrepname")?"selected":"" %>>미디어렙</option>
                                <option value="tcname" <%=sch_column.equals("tcname")?"selected":"" %>>담당자</option>
                            </select>
                        </div>
                        <div class="form-group formGroupPadd">
                            <input type="text" class="form-control input-sm" name="sch_text" value="<%=sch_text%>">
                        </div>
                        <div class="form-group formGroupPadd">
                            <button type="submit" class="btn btn-warning btn-sm">조회</button>
                        </div>
                    </div>
                </form>
                <br>
                <!-- list Table Start -->
                 <table class="listTable" style="width:1280px">
 				<colgroup>
				<col width="40">
				<col width="80"><!-- 광고상품 -->
				<col width="240"><!-- 애즈명 -->
				<col width="180"><!-- 광고주 -->
				<col width="120"><!-- 광고주 -->
				<col width="120"><!-- 시작일 -->
				<col width="120"><!-- 종료일 -->
				<col width="80"><!-- 집행금액 -->
				<col width="100"><!-- 목표타입 -->
				<col width="80"><!-- 보장량량 -->
				<col width="80"><!-- 목표량 -->
				<%-- 
				<col width="80"><!-- 노출 -->
				<col width="60"><!-- 달성율 -->
				<col width="80"><!-- 클릭 -->
				<col width="40"><!-- CTR -->
				--%>
			    <col width="80"><!-- 등록일 -->
				<col width="60"><!-- 담당자 -->
				<col width="40"><!-- 상태 -->	
					</colgroup>                   
	                    <thead>
                        <tr>
                            <th>No</th>
                             <th>광고상품</th>
                             <th>애즈명</th>
                            <th>캠페인</th>
                            <th>광고주</th>
                            <th>시작일</th>
                            <th>종료일</th>
                            <th>집행금액</th>
                            <th>목표타입</th>
                            <th>보장량</th>
                            <th>목표량</th>
                            <%--
                            <th>노출</th>
                            <th>달성율</th>
                            <th>클릭</th>
                            <th>CTR</th>
                            --%>
                            <th>상태</th>
                        </tr>
                    </thead>
                    <tbody>
<%

for(int k=0; k<adslist.size(); k++){
                                        
    Ads ads = adslist.get(k);
    
	 
 %>                        <tr>
                            <td><%=skip+(k+1) %></td>
                            <td><%=ads.getPrtypename() %></td>
                            <td class="textLeft">
                            <%-- 
                            <span name="cpmod" adsid="<%=ads.getAdsid()%>" class="label label-<%=ads.getIstarget().equals("Y")?"info":"default"%>">T</span> 
                            --%><span name="cpmod" adsid="<%=ads.getAdsid()%>" class="label label-<%=ads.getIsprism().equals("Y")?"warning":"default"%>" style="margin-right:6px">P</span> 
                            <a href="cpmgr.do?a=adsInfo&adsid=<%=ads.getAdsid()%>" class="<%=ads.getText()%>"><%=ads.getAdsname() %><%=ads.getIstarget().equals("Y")?"<span class='txtRed' style='font-size:8pt;margin:4px'>targeting</span>":""%></a></td>
                            <td class="textLeft"><%=ads.getCpname() %></td>
                            <td class="textLeft"><%=ads.getClientname() %></td>
                            <td><%=DateUtil.getYMD(ads.getStartdate()) %></td>
                            <!--  td><%=ads.getStart_hour() %>:<%=ads.getStart_min()%></td-->
                            <td><%=DateUtil.getYMD(ads.getEnddate()) %></td>
                            <!--td><%=ads.getEnd_hour()%>:<%=ads.getEnd_min()%></td-->
                            <td class="textRight"><%=StringUtil.addComma(ads.getBudget()) %></td>
                            <td></td>
                            <td class="textRight"><%=StringUtil.addComma(ads.getBook_total()) %></td>
                            <td class="textRight"><%=StringUtil.addComma(ads.getGoal_total()) %></td>
                            <!--   
                            <td class="textRight">3,333,333</td>
                            <td class="textRight">101%</td>
                            <td class="textRight">33,333</td>
                            <td class="textRight">0.24%</td>
                            -->
                            <td class="<%=ads.getText()%>"><%=ads.getAds_statename() %></td>
                        </tr>	
 <%} %>                     
 				</tbody>
                </table>
                 <!--table Paging-->            
                <jsp:include page="../common/paging.jsp">
                <jsp:param name="actionForm" value="frmList"/>
                <jsp:param name="totalCount" value="<%=totalCount %>"/>
                <jsp:param name="countPerPage" value="<%=max %>"/>
                <jsp:param name="blockCount" value="10"/>
                <jsp:param name="nowPage" value="<%=nowPage %>"/>
            	</jsp:include>
            	<!--//table Paging--> 
            	<!-- list Table End -->
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
