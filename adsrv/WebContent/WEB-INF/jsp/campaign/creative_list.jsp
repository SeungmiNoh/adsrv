<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/common.jsp" %>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="tv.pandora.adsrv.common.util.StringUtil"%>
<%@page import="tv.pandora.adsrv.common.util.DateUtil"%>    
<%@page import="tv.pandora.adsrv.domain.Creative"%>    
<% 
try
{
	String prtype = StringUtil.isNull(request.getParameter("prtype"));
	String stat = StringUtil.isNull(request.getParameter("stat"));
	String width = StringUtil.isNull(request.getParameter("width"));
	String height = StringUtil.isNull(request.getParameter("height"));
	String sch_column = StringUtil.isNull(request.getParameter("sch_column"));
	String sch_text = StringUtil.isNull(request.getParameter("sch_text"));	
	sch_text = new String (sch_text.getBytes("8859_1"),"UTF-8");

	Map<String,Object> map = (Map)request.getAttribute("response");

	List<Creative> crlist = (List<Creative>)map.get("crlist");   
	List<Map<String,String>> codelist = (List<Map<String,String>>)map.get("codelist");   
	List<Map<String,String>> stlist = (List<Map<String,String>>)map.get("stlist");   
	
	String sday = DateUtil.getYMD((String)map.get("sday"));
	String eday = DateUtil.getYMD((String)map.get("eday"));
    String totalCount = map.get("totalCount").toString();
    String nowPage = map.get("nowPage").toString();
	
	Integer skip = (Integer)map.get("skip");
	Integer max = (Integer)map.get("max");
	
%>  

<!DOCTYPE html>
<html lang="WebContent/WEB-INF/jsp/campaign/cp_ads_list.jsp""en">
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
	  $("#sday").val("<%=sday%>");
	  $("#eday").val("<%=eday%>");
	  $("#prtype").val("<%=prtype%>");
	  
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
						$("#end").datepicker("option","minDate",selectDate);					
						//$(this).trigger("change");
				}
		});
		$("#eday").datepicker({
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
</head>

<body>
    <div class="container-fluid containerBg">
        <div class="containerBox">
        <%@ include file="../common/header.jsp"  %>
             <section class="sectionBox">
                <div class="boxTitle">
                    <!-- title Start -->
                    <div class="title">광고물 목록</div>
                    <div class="breadcrumbs"><span class="glyIcon"><img src="<%=web%>/img/navIcon.png" alt=""></span> 현재위치 : 광고물 > 광고물 목록</div>
                    <!-- title End -->
                </div>
                <!-- search group Start -->
                <form id="frmList" name="frmList" method="get" action="cpmgr.do?a=crList">
				<input type="hidden" name="a" value="crList"/>
				<input type="hidden" name="p" id="page"/>
                    <div class="form-inline">
                          <div class="form-group formGroupPadd">
                            <label>등록일</label>
                            <input type="text" class="form-control input-sm" name="sday" id="start" value="<%=sday%>" style="width:90px">
                            <a class="btn btn-success btn-sm" href="#none" role="button" id="btnSday"><span class="glyphicon glyphicon-calendar"></span></a>
                        </div>
                        <div class="form-group formGroupPadd">
                            <input type="text" class="form-control input-sm"  name="eday" id="end" value="<%=eday%>" style="width:90px">
                            <a class="btn btn-success btn-sm" href="#none" role="button" id="btnEday"><span class="glyphicon glyphicon-calendar"></span></a>
                        </div> 
                        <div class="form-group formGroupPadd"> 
                        	<input type="text" name="width" id="width" class="form-control input-sm" style="width:50px" placeholder="가로" value="<%=width%>"> x
                            <input type="text" name="height" id="height" class="form-control input-sm" style="width:50px" placeholder="세로" value="<%=height%>">
                         </div>           
                        
                                               
                       <div class="form-group formGroupPadd">
                            <select name="cr_state" class="form-control input-sm">
                            <option value="">상태</option>
                                <%for(int i=0;i<stlist.size();i++){ 
                                	Map<String,String> st = stlist.get(i);
                                %>
                                <option value="<%=String.valueOf(st.get("isid")) %>" <%=stat.equals(String.valueOf(st.get("isid")))?"selected":"" %>><%=st.get("isname") %></option>                               
                                <%} %>
                            </select>
                        </div>
                        <div class="form-group formGroupPadd">
                            <select name="prtype" class="form-control input-sm">
                             <option value="">광고상품</option>
                                <%for(int i=0;i<codelist.size();i++){ 
                                	Map<String,String> code = codelist.get(i);
                                %>
                                <option value="<%=String.valueOf(code.get("isid")) %>" <%=prtype.equals(String.valueOf(code.get("isid")))?"selected":"" %>><%=code.get("isname") %></option>                               
                                <%} %>
                            </select>
                        </div>
                        <div class="form-group formGroupPadd">
                            <select id="sch_column" name="sch_column" class="form-control input-sm">
                                <option value="crname" <%=sch_column.equals("crname")?"selected":"" %>>광고물</option>
                                <option value="clientname" <%=sch_column.equals("clientname")?"selected":"" %>>광고주</option>
                            </select>
                        </div>
                        <div class="form-group formGroupPadd">
                            <input type="text" class="form-control input-sm" name="sch_text" value="<%=sch_text %>">
                        </div>
                        <div class="form-group formGroupPadd">
                            <button type="submit" class="btn btn-warning btn-sm">조회</button>
                        </div>
                    </div>
                </form>
                <!-- search group End -->

                <!-- saveBtn Start -->
                <div class="outsaveBtn1">
                    <a class="btn btn-danger" href="cpmgr.do?a=crAddForm" role="button">광고물등록</a>
                </div>
                <!-- saveBtn End -->
                <br>
                <!-- list Table Start -->
                <table class="listTable" style="width:1630px">
 				<colgroup>
				<col width="40">
				<col width="160"><!-- 광고상품 -->
				<col width="260"><!-- 광고물명 -->
				<col width="160"><!-- 광고주 -->
				<col width="90"><!-- 사이즈 -->
			    <col width="100"><!-- 등록일자 -->
				<col width="90"><!-- 등록자 -->
				<col width="100"><!-- 상태 -->
					</colgroup>                   
				<thead>
                        <tr>
                            <th>No</th>
                            <th>광고상품</th>
                            <th>광고물명</th>
                            <th>광고주</th>
                            <th>사이즈</th>
                            <th>등록일</th>
                            <th>등록인</th>
                            <th>상태</th>
                        </tr>
                    </thead>
                    <tbody>
<%

for(int k=0; k<crlist.size(); k++){
                                        
    Creative cr = crlist.get(k);
    
	 
 %>                    
                    
                    
                        <tr>
                            <td><%=skip+(k+1) %></td>
                            <td class="textCenter"><%=cr.getPrtypename() %></td>
                            <td class="textLeft"><a href="cpmgr.do?a=crInfo&crid=<%=cr.getCrid()%>"><%=cr.getCrname() %></a></td>
                            <td><%=cr.getClientname() %></td>
                            <td><%=cr.getWidth() %> x <%=cr.getHeight() %></td>
                            <td><%=DateUtil.getYMD(cr.getInsertdate(),".") %></td>
                            <td><%=cr.getUpdateusername()%></td>
                            <td><%=cr.getCr_statename() %></td>
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
