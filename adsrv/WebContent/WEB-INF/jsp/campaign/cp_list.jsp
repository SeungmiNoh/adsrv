


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/common.jsp" %>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="tv.pandora.adsrv.common.util.StringUtil"%>
<%@page import="tv.pandora.adsrv.common.util.DateUtil"%>    
<%@page import="tv.pandora.adsrv.domain.Campaign"%>    
<%@page import="tv.pandora.adsrv.domain.User"%>    
<% 
try
{
	String sch_column = StringUtil.isNull(request.getParameter("sch_column"));
	String sch_text = StringUtil.isNull(request.getParameter("sch_text"));	

	Map<String,Object> map = (Map)request.getAttribute("response");

	List<Campaign> cplist = (List<Campaign>)map.get("cplist");   
	List<User> tclist = (List<User>)map.get("tclist");
	
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
<!--  script type="text/javascript">

  $(document).ready(function() {
	  
	  /*
	 
	 $("[name=sch_column]").val("<%=sch_column%>");
	 if($("[name=sch_column]").val()==''){
		 $("[name=sch_column] option:eq(0)").prop("selected", true);
	 }*/
	 
	 
	 
	 $("[name=sch_text]").val("<%=sch_text%>");
  });
 </script-->
 
 <script type="text/javascript">


$(function(){
	//$(".debug").css("display","none");

	
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

	
	
	$("#btnPopup").click(function(e){
		$("#frmRegist input, #frmRegist select").css("border-color", "#ccc");
		e.preventDefault();
		$('#myModal').modal();
		$(".modify").css("display", "none");
		$(".new").css("display", "");
		$(".debug").val(""); //값 초기화	 (siteid, change)	
		$('#cpname').focus();
		$("input:radio[name='sitetype']:radio[value=1]").prop('checked',true);
		
	
	});
	
	$('#frmRegist').change(function(e){	
		$("#change").val("change");
	});

	$("span[name=cpmod]").click(function(e){
		var cpid = $(this).attr("cpid");
		location.href = "cpmgr.do?a=cpEditForm&cpid="+cpid;
	});
	
	$("#btnRegCp").on("click", function(e){
		$("#frmRegCp input, #frmRegCp select").css("border-color", "#ccc");
		$("#warningMsg").text("");
		e.preventDefault();
		
		if($.trim($("#cpname").val()).length==0){
			$("#cpname").css("border-color","red").focus();
			$("#warningMsg").text("캠페인 명을 입력해주세요.");
			return false;
		}else if($("#clientid").val()==0){
			$("#client").css("border-color","red").focus();
			$("#warningMsg").text("광고주를 선택해주세요.");
			return false;
		}else if($.trim($("#budget").val()).length==0){
			$("#budget").css("border-color","red").focus();
			$("#warningMsg").text("집행 금액을 입력해주세요.");
			return false;
		}else if($.trim($("#start").val()).length!=10){
			$("#start").css("border-color","red").focus();
			$("#warningMsg").text("시작일을 선택해주세요.");
			return false;
		}else if($.trim($("#end").val()).length!=10){
			$("#end").css("border-color","red").focus();
			$("#warningMsg").text("종료일을 선택해주세요.");
			return false;
		}else if($.trim($("#memo").val()).length>50){
			$("#memo").css("border-color","red").focus();
			$("#warningMsg").text("설명은 50자 이내로 입력해주세요.");
			return false;
		}else{
			$("#cpname").css("border-color","green");
		}
		if(confirm("캠페인을 등록하시겠습니까?")){
			
			$("#frmRegCp").submit();					
			
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
                    <div class="title">캠페인 목록</div>
                    <div class="breadcrumbs"><span class="glyIcon"><img src="<%=web%>/img/navIcon.png" alt=""></span> 현재위치 : 캠페인 > 캠페인 목록</div>
                    <!-- title End -->
                </div>
                <!-- search group Start -->
                <form id="frmList" name="frmList" method="get" action="cpmgr.do?a=cpList">
				<input type="hidden" name="a" value="cpList"/>
				<input type="hidden" name="p" id="page"/>
                    <div class="form-inline">
                        <div class="form-group formGroupPadd">
                            <label>기간</label>
                            <input type="text" class="form-control input-sm" name="" placeholder="20150101">
                            <!-- datePicker Btn Start -->
                            <a class="btn btn-success btn-sm" href="#" role="button"><span class="glyphicon glyphicon-calendar"></span></a>
                            <!-- datePicker Btn End -->
                        </div>
                        <div class="form-group formGroupPadd">
                            <input type="text" class="form-control input-sm" name="" placeholder="20150101">
                            <!-- datePicker Btn Start -->
                            <a class="btn btn-success btn-sm" href="#" role="button"><span class="glyphicon glyphicon-calendar"></span></a>
                            <!-- datePicker Btn End -->
                        </div>
                        <div class="form-group formGroupPadd">
                            <select name="cp_state" class="form-control input-sm">
                                <option>상태</option>
                                <option>진행</option>
                                <option>예약</option>
                                <option>준비</option>
                                <option>완료</option>
                                <option>중지</option>
                                <option>취소</option>
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
                            <input type="text" class="form-control input-sm" name="sch_text">
                        </div>
                        <div class="form-group formGroupPadd">
                            <button type="submit" class="btn btn-warning btn-sm">조회</button>
                        </div>
                    </div>
                </form>
                <!-- search group End -->

                <!-- saveBtn Start -->
                <div class="outsaveBtn1">
                    <a class="btn btn-danger" href="cpmgr.do?a=cpAddForm" role="button">캠페인등록</a>
                  </div>
                <!-- saveBtn End -->
                <br>
                <!-- list Table Start -->
                <table class="listTable" style="width:1630px">
 				<colgroup>
				<col width="40">
				<col width="260"><!-- 캠페인명 -->
				<col width="160"><!-- 광고주 -->
				<col width="160"><!-- 미디어렙 -->
				<col width="90"><!-- 시작일 -->
				<col width="90"><!-- 종료일 -->
				<col width="80"><!-- 집행금액 -->
				<col width="100"><!-- 목표량 -->
				<col width="100"><!-- 노출 -->
				<col width="80"><!-- 달성율 -->
				<col width="100"><!-- 클릭 -->
				<col width="80"><!-- CTR -->
			    <col width="100"><!-- 등록일 -->
				<col width="90"><!-- 담당자 -->
				<col width="100"><!-- 상태 -->
					</colgroup>                   
				<thead>
                        <tr>
                            <th>No</th>
                            <th>캠페인명</th>
                            <th>광고주</th>
                            <th>미디어렙</th>
                            <th>시작일</th>
                            <th>종료일</th>
                            <th>집행금액</th>
                            <th>목표량</th>
                            <th>노출</th>
                            <th>달성율</th>
                            <th>클릭</th>
                            <th>CTR</th>
                            <th>등록일</th>
                            <th>담당자</th>
                            <th>상태</th>
                        </tr>
                    </thead>
                    <tbody>
<%

for(int k=0; k<cplist.size(); k++){
                                        
    Campaign cp = cplist.get(k);
    
	 
 %>                    
                    
                    
                        <tr>
                            <td><%=skip+(k+1) %></td>
                            <td class="textLeft">
                            <span name="cpmod" cpid="<%=cp.getCpid()%>" class="label label-<%=k%3==0?"info":"default"%>">T</span> 
                            <span name="cpmod" cpid="<%=cp.getCpid()%>" style="margin-right:6px" class="label label-<%=k%3==0?"warning":"default"%>">P</span> 
                            <a href="cpmgr.do?a=cpAdsList&cpid=<%=cp.getCpid()%>" class="<%=cp.getText()%>"><%=cp.getCpname() %></a>
                            </td>
                            <td><%=cp.getClientname() %></td>
                            <td><%=StringUtil.isNull(cp.getMedrepname()) %></td>
                            <td><%=DateUtil.getYMD(cp.getStartdate(),".") %></td>
                            <td><%=DateUtil.getYMD(cp.getEnddate(), ".") %></td>
                            <td class="textRight"><%=StringUtil.addComma(cp.getBudget()) %></td>
                            <td class="textRight">10,000,000</td>
                            <td class="textRight">3,333,333</td>
                            <td class="textRight">101%</td>
                            <td class="textRight">33,333</td>
                            <td class="textRight">0.24%</td>
                            <td><%=DateUtil.getYMD(cp.getInsertdate(),".") %></td>
                            <td><%=cp.getTcname()%></td>
                            <td><span class="<%=cp.getText()%>"><%=cp.getCp_statename() %></span></td>
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
