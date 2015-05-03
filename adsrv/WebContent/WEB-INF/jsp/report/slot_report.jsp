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
	
	List<DayReport> rptlist = (List<DayReport>)map.get("rptlist"); 	
	List<Map<String,String>> sitetypelist = (List<Map<String,String>>)map.get("sitetypelist");
	List<Map<String,String>> prtypelist = (List<Map<String,String>>)map.get("prtypelist");	
	List<Map<String,String>> salestypelist = (List<Map<String,String>>)map.get("salestypelist");
	//List<Map<String,String>> grouplist = (List<Map<String,String>>)map.get("grouplist");
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

	$(document).ready(function() {
	/*********************** 파라미터 선택옵션 *****************************/
	var obj = <%=param_data%>;
	
	jQuery.each(obj, function(i, val) {
		  $("#" + i).append(document.createTextNode(" - " + val));
		  $("#"+i).val(val);
		  if(i=="sday" || i=="eday") {
			  $("#"+i).val(getYMD(val,"-"));
		  }
		  console.log("#"+i+" = "+val)
	});
});
</script>

<body>
    <div class="container-fluid containerBg">
 <div class="containerBox">
        <%@ include file="../common/header.jsp"  %>
             <section class="sectionBox">
                <div class="boxTitle">
                    <!-- title Start -->
                    <div class="title">위치 리포트</div>
                    <div class="breadcrumbs"><span class="glyIcon"><img src="<%=web%>/img/navIcon.png" alt=""></span> 현재위치 : 리포트 > 사이트 > 위치 리포트</div>
                    <!-- title End -->
                </div>
                <!-- ads add title Start -->
                <!-- search group Start -->
				<form id="frmRpt" action="rptmgr.do" method="get">
                <input type="hidden" name="a" value="<%=a %>">
                     <div class="form-inline">
                    	<div class="form-group">
                        <div class="form-group formGroupPadd">
                            <label>기간</label>
                            <input type="text" class="form-control input-sm" name="sday" id="sday" value="" style="width:90px">
                            <a class="btn btn-success btn-sm" href="#none" role="button" id="btnSday"><span class="glyphicon glyphicon-calendar"></span></a>
                        </div>
                        <div class="form-group formGroupPadd">
                            <input type="text" class="form-control input-sm"  name="eday" id="eday" value="" style="width:90px">
                            <a class="btn btn-success btn-sm" href="#none" role="button" id="btnEday"><span class="glyphicon glyphicon-calendar"></span></a>
                        </div>                                 <a class="btn btn-warning" href="javascript:$('#frmRpt').submit()" role="button">조회</a>
                                <a class="btn btn-default" href=""><img src="<%=web %>/img/page_excel.png" alt="excel Icon"></a>
                           
	                        <select id="sitetype" name="sitetype" class="form-control input-sm" style="width:100px">
	                             <option value="">사이트구분</option>
	                                <%for(int i=0;i<sitetypelist.size();i++){ 
	                                	Map<String,String> code = sitetypelist.get(i);
	                                %>
	                                <option value="<%=String.valueOf(code.get("isid")) %>"><%=code.get("isname") %></option>                               
	                                <%} %>
	                            </select>                               
	                            <select id="sch_column" name="sch_column"  class="form-control input-sm" style="width:100px">
                                <option value="sitename">사이트명</option>
                                <option value="slotname">위치명</option>
                            </select>
                            <input type="text" class="form-control input-sm" id="sch_text" name="sch_text">
                          </div>
                        <div class="form-group">
                            <button type="submit" class="btn btn-warning btn-sm">조회</button>
                        </div>
                    </div>
                </form>
                <!-- search group End -->
                <!-- saveBtn Start -->
                  <!-- saveBtn End -->
                <br>
                <!-- list Table Start -->
                 <table class="listTable2">
 				<colgroup>
				<col width="40">
				<col width="80"><!-- 사이트 구분 -->
				<col width="*"><!-- 위치 -->
				<col width="100"><!-- 사이즈 -->
				<col width="100"><!-- Request -->
				<col width="100"><!-- IMP -->
				<col width="100"><!-- 잔여 -->
				<col width="60"><!-- FILLRATE -->
				<col width="90"><!-- 노출 -->
				<col width="90"><!-- 노출 -->
				<col width="90"><!-- 노출 -->
				<col width="90"><!-- 클릭 -->
				<col width="90"><!-- 클릭 -->
				<col width="90"><!-- 클릭 -->
				<col width="60"><!-- ctr -->
				<col width="60"><!-- ctr -->
				<col width="60"><!-- ctr -->
					</colgroup>                   
					<thead>
                        <tr>
                            <th rowspan="2">No</th>
                            <th rowspan="2">구분</th>  
                            <th rowspan="2">위치</th>  
                            <th rowspan="2">사이즈</th>  
                            <th rowspan="2">Request</th>  
                            <th rowspan="2">IMP</th>  
                            <th rowspan="2">잔여</th>  
                            <th rowspan="2">Fill<br/>Rate</th>  
                            <th colspan="<%=salestypelist.size()%>">노출</th>  
                            <th colspan="<%=salestypelist.size()%>">클릭</th>  
                            <th colspan="<%=salestypelist.size()%>">CTR</th>  
                            </tr>
                            <tr>
                            <%for(int i=0;i<salestypelist.size();i++){ Map<String,String> code = salestypelist.get(i);%>
                            <th class="thBg"><%=code.get("isname") %></th>                              
                            <%} %>
                            <%for(int i=0;i<salestypelist.size();i++){ Map<String,String> code = salestypelist.get(i);%>
                            <th class="thBg"><%=code.get("isname") %></th>                              
                            <%} %>
                            <%for(int i=0;i<salestypelist.size();i++){ Map<String,String> code = salestypelist.get(i);%>
                            <th class="thBg"><%=code.get("isname") %></th>                              
                            <%} %>
                       		</tr>
                    </thead>
                    <tbody>
<%

for(int k=0; k<rptlist.size(); k++){
    DayReport rpt = rptlist.get(k);
 %>                    
                    
                    
                        <tr>
                      <td class="textCenter"><%=(k+1) %></td>
                      <td class="textCenter"><%=rpt.getSitetypename() %></td>
                      <td><a href="rptmgr.do?a=slotRptDaily&slotid=<%=rpt.getSlotid()%>"/><%=rpt.getSlotname() %></a></td>
                      <td><%=rpt.getWidth()%> * <%=rpt.getHeight() %></td>
                      <td class="textRight"><%=StringUtil.addComma(rpt.getInv())%></td>
                      <td class="textRight"><%=StringUtil.addComma(rpt.getImp())%></td>
                      <td class="textRight"><%=StringUtil.addComma(rpt.getRemain())%></td>
                      <td class="textRight"><%=StringUtil.addComma(rpt.getFillrate())%>%</td>
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

