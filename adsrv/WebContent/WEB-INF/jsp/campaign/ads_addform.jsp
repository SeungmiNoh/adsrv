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
<%@page import="tv.pandora.adsrv.domain.User"%>    
<%	
try
{
	
	Map<String, Object> map = (Map<String, Object>)request.getAttribute("response");

	
	Campaign cp = (Campaign)map.get("cp");

	List<Map<String, String>> codelist = (List<Map<String, String>>)map.get("codelist");   
	List<Map<String,String>> tgcodelist = (List<Map<String,String>>)map.get("tgcodelist");

	JSONArray ads_code_data = JSONArray.fromObject(codelist);
	List<Map<String,String>> tglist = (List<Map<String,String>>)map.get("tglist");
	
	JSONArray target_data = JSONArray.fromObject(tglist);
	
	
	      
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
  
  
  resetData = function() {
	  defaultDate(); 
	}
  
  defaultDate = function() {
	  	$("#start").val("<%=DateUtil.getYMD(cp.getStartdate())%>");
		$("#end").val("<%=DateUtil.getYMD(cp.getEnddate())%>");
		$("#start_hour").val("00"); 
		$("#start_min").val("00");
		$("#end_hour").val("24"); 
		$("#end_min").val("00");
		$("#budget").val("0");
  }
  $(function() {
	  $("#btnRegist").on("click", function(e){			
			e.preventDefault();
			$("#frmRegAds input, #frmRegAds select").css("border-color", "#ccc");
			if($.trim($("#adsname").val()).length==0){
				$("#adsname").css("border-color","red").focus();
				$("#warningMsg").text("애즈명을 입력해주세요.");
				return;
			}else if( ($("#prtype").val() =="1" && $("#goaltype").val()=="4") ||($("#prtype").val() =="2" && $("#goaltype").val()!="4") ){
				$("#prtype").css("border-color","red").focus();
				$("#goaltype").css("border-color","red").focus();
				$("#warningMsg").text("광고상품과 목표타입을 확인해주세요.");
				return;
			}if($.trim($("#budget").val()).length==0){
				$("#budget").css("border-color","red").focus();
				$("#warningMsg").text("집행 금액을 입력해주세요.");
				return;
			}else if($.trim($("#start").val()).length!=10){
				$("#start").css("border-color","red").focus();
				$("#warningMsg").text("시작일을 선택해주세요.");
				return;
			}else if (delDash($("#start").val()) < $("[name=cp_startdate]").val()) {
				$("#start").css("border-color","red").focus();				
	        	$("#warningMsg").text("애즈 기간은 캠페인 기간을 벗어날 수 없습니다.");
				return;
	      }else if($.trim($("#end").val()).length!=10){
				$("#end").css("border-color","red").focus();
				$("#warningMsg").text("종료일을 선택해주세요.");
				return;
			}else if($("#period").val()!=0 && delDash($("#end").val()) > $("[name=cp_enddate]").val()) {
				$("#end").css("border-color","red").focus();				
	        	$("#warningMsg").text("애즈 기간은 캠페인 기간을 벗어날 수 없습니다.");
				return;
	      }else if($.trim($("#book_total").val()).length==0){
				$("#book_total").css("border-color","red").focus();
				$("#warningMsg").text($("#goalText").text()+"보장량을 입력해주세요.");
				return;
			}else if($.trim($("#goal_total").val()).length==0){
				$("#goal_total").css("border-color","red").focus();
				$("#warningMsg").text($("#goalText").text()+"목표량을 입력해주세요.");
				return;
			}else{
				setDate();
			}
			if(confirm("애즈를 등록하시겠습니까?")){
				$('.numinput').onlyNumberDelComma();
				$("#frmRegAds").submit();					
			}
			
		});
	});
   </script>
  	<script>
$(document).ready(function() {
	$('.numinput').numberOnly();
	//datepicker
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
			buttonImageOnly: true,
			showAnim:'show',
			showMonthAfterYear: true,
			yearSuffix: '년'};
		$.datepicker.setDefaults($.datepicker.regional['ko']);
		$(".start").datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth:true,
			changeYear:true,
			onClose: function(selectDate){
					$(".end").datepicker("option","minDate",selectDate);	
			}
		});
		$(".end").datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth:true,
			changeYear:true,
			onClose: function(selectDate){
					$(".start").datepicker("option","maxDate",selectDate);					
			}
		});
	/*********************** 애즈 선택옵션 *****************************/
	var ads_code = <%=ads_code_data%>;
	var cur_code = "";
	var htmlstr = "";
	for(var k=0; k<ads_code.length; k++) {
		if(cur_code != ads_code[k].code) {
			cur_code = ads_code[k].code;
		}
		htmlstr = '<option value="'+ads_code[k].isid+'"';
		if(ads_code[k].isdefault=="1"){  
			htmlstr += ' selected';				
		}
		htmlstr += '>'+ads_code[k].isname+'</option>';
		$("#"+ads_code[k].code).append(htmlstr);
		
	}
	setGoaltype = function() {
		
		if($("#goaltype").val()<=1) // 목표기간 완료, 목표 없음	
		{
			$(".goalText").text("");				
			$("#goal_total").val("0");
			$("#goal_total").prop( "disabled", true );	
			$("#book_total").val("0");
			$("#book_total").prop( "disabled", true );	
		} else {		
			if($("#goaltype").val()==2){ // 목표 노출 완료
				$(".goalText").text("노출 ");					
			} else if($("#goaltype").val()==3)  {	// 목표 클릭 완료
				$(".goalText").text("클릭 ");
			} else if($("#goaltype").val()==4) { // 목표 Hit 완료
				$(".goalText").text("Hit ");
			}
			
			$("#goal_total").prop( "disabled", false );				
			$("#goal_total").attr("placeholder",$("#goalText").text()+"목표량");
			$("#book_total").prop( "disabled", false );				
			$("#book_total").attr("placeholder",$("#goalText").text()+"보장량");
			}
		if($("#goaltype").val()!=4) { // 목표 Hit 완료
			$("#cost").prop( "disabled", true);
		} else {
			$("#cost").prop( "disabled", false );
		}
	}
	
	// 광고상품 변경
	$("#prtype").on("change", function(e){
		if($("#prtype").val()==2) // 프리즘 경우 
		{
			$("#goaltype").val("4");
		} else {
			$("#goaltype").val("2");
		}
		setGoaltype();
	});
    setDate = function () {
		var startdate = delDash($("#start").val())+$("#start_hour").val()+$("#start_min").val();				
		var enddate = delDash($("#end").val())+$("#end_hour").val()+$("#end_min").val();
		$("#startdate").val(startdate);
		$("#enddate").val(enddate);
		
	}
	
	// 로딩시
	resetData();
	setGoaltype();		
	
	$("[name=period]").on("click", function(e){
		
		if($('input:radio[name="period"]:checked').val()==0){
			
			$("#start").val("");
			$("#end").val("2037-12-31");
			$("#start_hour").val("00");
			$("#start_min").val("00");
			$("#end").val("2037-12-31");
			$("#end_hour").val("24");
			$("#end_min").val("00");
	
			$(".period").prop( "disabled", true );
			setDate();
			$(".datepicker").prop( "disabled", true );
			$(".datepicker").datepicker( "option", "disabled", true );
		} else {
			$(".period").prop( "disabled", false );
			defaultDate();
			$(".datepicker").datepicker( "option", "disabled", false );
		}
	});	
	$("#goaltype").on("change", function(e){				
		setGoaltype();
	});		
	
	// 세일즈 변경
	$("#salestype").on("change", function(e){
		if($("#salestype").val()==3) // 하우스경우 
		{
			//$("#goal_daily").prop( "disabled", true );			
			//$("#goal_daily").val("0");
			$("#goaltype").val("1");
			
		} else {
			$("#goaltype").val("2");
			//$("#goal_daily").prop( "disabled", false );			
		}
		setGoaltype();
	
	});
	
	/***********************타겟팅*********************************/
	  var target_data = <%=target_data%>;
	  var cur_type = "";
	  var htmlstr = "";
	  for(var k=0; k<target_data.length; k++) {
	  	if(cur_type != target_data[k].targettype) {
	  		$("#target"+cur_type).append(htmlstr);
	  		htmlstr = "";
	  		htmlstr = '<option value="0"></option>';
	  		cur_type = target_data[k].targettype;
	  	}
	  	htmlstr += '<option value="'+target_data[k].tid+'"';
	  	
	  	var choice = 0;
	  	
	  	if(target_data[k].targetid==target_data[k].tid){  								
	  			htmlstr += ' selected';	
	  	}			
	  	htmlstr += '>'+target_data[k].targetname+'</option>';
	  			
	  }
	  $("#target"+cur_type).append(htmlstr);


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
             <div class="title">캠페인 애즈 등록 <span class="txtBlue" style="margin-left:10px;font-size:9pt"><span class="glyphicon glyphicon-play-circle"></span> <%=cp.getCpname() %> </span></div>
                                   <div class="breadcrumbs"><span class="glyIcon"><img src="<%=web%>/img/navIcon.png" alt=""></span> 현재위치 : 캠페인  > 캠페인 정보 > 애즈 등록</div>
                   <!-- title End -->
                </div>      
               	<%-- **************** 캠페인 정보 ********************* --%>
 				<%@ include file="./com_cpinfo.jsp" %>
              	<%-- ************************************************ --%>                
                <br>
                <!-- view Table End -->
                <!-- campaign view End -->
                <!-- ads add title Start -->
                <div class="boxtitle2">
                    <!-- title Start -->
                    <div class="taptitle">애즈</div>
                    <!-- title End -->
                    <div class="tapBox">
                        <nav class="tapMenu">
                               <ul>  
                               <li><a href="cpmgr.do?a=cpAdsList&cpid=<%=cp.getCpid()%>">애즈 목록 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="#none"  class="active">애즈등록<span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                 <li><a href="#none" class="none">타겟팅 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="#none" class="none">광고물 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>                               
                                <li><a href="#none" class="none">광고위치 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>                               
                            </ul>
                            
                        </nav>
                    </div>
                </div>
                <!-- ads add title End -->
                <!-- ads add Table Start -->
 <div style="padding:10px;border: 0px solid #d3d2d2; background-color:#ffffcc;">
                <form id="frmRegAds" method="post" role="form" action="cpmgr.do?a=adsInsert">
                <input type="hidden" name="cpid" value="<%=cp.getCpid() %>"/>
                    <table class="addTable">
                        <colgroup>
                        <col width="9%">
                        <col width="22%">
                        <col width="9%">
                        <col width="24%">
                        <col width="9%">
                        <col width="27%">
                        </colgroup>
                       <tr>
                            <th>애즈명<span style="color:red"> * </span></th>
                            <td class="form-inline" colspan="3">
                                <input type="text" name="adsname" id="adsname" class="form-control input-sm" value="" style="width:280px">
                            </td>
                            <th>광고상품<span style="color:red"> * </span></th>
                            <td class="form-inline">
                                <select id="prtype" name="prtype" class="form-control input-sm" style="width:100px;">
                                 </select>
                            </td>
                        </tr>
  						<tr>
                             <th>세일즈 구분<span style="color:red"> * </span></th>
                            <td class="form-inline">
                                <select id="salestype" name="salestype" class="form-control input-sm"  style="width:100px;">
                                </select>
                            </td>
                             <th>집행금액<span style="color:red"> * </span></th>
                            <td class="form-inline">
                                <input type="text" name="budget" id="budget" class="form-control input-sm numinput" style="width:160px; text-align:right">
                            </td>
                       		<th>상태<span style="color:red"> * </span></th>
                            <td class="form-inline">
                                <select id="ads_state" name="ads_state" style="width:100px" class="form-control input-sm">
                                 </select>
                            </td>
                        </tr>  
                        <tr>
                            <th>기간<span style="color:red"> * </span></th>
                            <td class="form-inline">
                                <label class="radio-inline"><input type="radio" name="period" value="1" checked> Period</label>
                                <label class="radio-inline"><input type="radio" name="period" value="0"> No Period</label>
                            </td>
                            <th>시작일<span style="color:red"> * </span></th>
                            <td class="form-inline">
                                <input type="text" id="start" class="start form-control nopad datepicker" style="width:90px">                                
                                	<select id="start_hour" name="start_hour" class="form-control nopad input-sm period">
                                     <%for(int i=0;i<=23;i++){ %>
                                    <option value="<%=DateUtil.getMMStr(String.valueOf(i))%>"><%=DateUtil.getMMStr(String.valueOf(i))%>시</option>
                                    <%} %>
                                </select>
                                <select id="start_min" name="start_min" class="form-control nopad input-sm period">
                                       <%for(int i=0;i<6;i++){ %>
                                    <option value="<%=DateUtil.getMMStr(String.valueOf(i*10))%>"><%=DateUtil.getMMStr(String.valueOf(i*10))%>분</option>
                                    <%} %>                                    
                                </select>
                                <input type="hidden" id="startdate" name="startdate" class="debug" size=10/>
                            </td>
                             <th>종료일<span style="color:red"> * </span></th>
                            <td class="form-inline">
                                 <input type="text" id="end" class="end form-control nopad input-xs datepicker" style="width:90px">                                
                                	<select id="end_hour" name="end_hour" class="form-control nopad input-sm period">
                                     <%for(int i=0;i<=24;i++){ %>
                                    <option value="<%=DateUtil.getMMStr(String.valueOf(i))%>"><%=DateUtil.getMMStr(String.valueOf(i))%>시</option>
                                    <%} %>
                                </select>
                                <select id="end_min" name="end_min" class="form-control nopad input-sm period">
                                      <%for(int i=0;i<6;i++){ %>
                                    <option value="<%=DateUtil.getMMStr(String.valueOf(i*10))%>"><%=DateUtil.getMMStr(String.valueOf(i*10))%>분</option>
                                    <%} %>                                    
                                </select>
                                <input type="hidden" id="enddate" name="enddate" class="debug" size=10/>
                         </td>
                        </tr>
                       <tr>
                            <th>목표타입<span style="color:red"> * </span></th>
                            <td class="form-inline">
                                <select id="goaltype" name="goaltype" class="form-control input-sm" style="width:100px">
                                </select>
                            </td>
                            <th><label class="goalText" id="goalText">노출</label> 보장량<span style="color:red"> * </span></th>
                            <td class="form-inline">
                                <input type="text" name="book_total" id="book_total" class="form-control input-sm numinput goal" style="width:160px; text-align:right" placeholder="보장량">                             
							</td>                            	
                            <th><label class="goalText">노출</label> 목표량<span style="color:red"> * </span></th>
                            <td class="form-inline">
                                <input type="text" name="goal_total" id="goal_total" class="form-control input-sm numinput goal" style="width:160px; text-align:right" placeholder="목표 노출량">                             
							</td>
   						</tr>
                         <tr>
  							<th>일 목표 노출량</th>
                            <td class="form-inline">
                                <input type="text" id="goal_daily" name="goal_daily" class="form-control input-sm numinput" style="width:160px; text-align:right" placeholder="일간 목표 노출량">
                            </td>                       
  							<th>광고 단가</th>
                            <td class="form-inline">
                                <input type="text" id="cost" name="cost" class="form-control input-sm numinput" style="width:160px; text-align:right" placeholder="프리즘 Hit 단가">
                            </td>   
                            <th>등록일</th>
                            <td class="form-inline"> <%=userName %> (<%=DateUtil.getYMD(DateUtil.curDate()) %>)
                                
                         </tr>                      
                    </table>
                    
                    
                    
               
                <!-- add Table End -->
                <!-- button group Start -->
                
                <!--********************************************************************************************
                                          타겟팅 
**********************************************************************************************-->
                <div class="boxtitle3" style="width:900px;">                   
                    <h1 class="title4"><span class="glyphicon glyphicon-menu-down"></span> 타겟팅</h1>
                </div>				
               <table class="viewTable" style="width:900px;">
                    <colgroup>
                    <col width="10%">
                    <col width="40%">
                    <col width="10%">
                    <col width="40%">
                    </colgroup>                   
                    <tbody>
                                
 <%for(int i=0;i<tgcodelist.size();i++){ 
	Map<String,String> code = tgcodelist.get(i);
	
	if(i%2==0) {
		if(i>0) {
		%>
		</tr>
		<%} %>
		<tr>
		<%
	}
%>
                               <th><%=String.valueOf(code.get("isname")) %></th>
                                <td class="textCenter">
                                <input type="hidden" size=1 name="targettype" class="debug" value="<%= String.valueOf(code.get("isid"))%>"/>
                                 
                                <select id="target<%=String.valueOf(code.get("isid")) %>" name="tid" class="form-control input-sm" style="width:260px;"></select>
                                 
                                 </td>
                          
						 
<%} %>      
				<th></th>
				<td class="textRight">
				<span id="warningMsg" style="color:#a00"></span>
                </td>
				</tr>                
                </tbody>
                </table>
                </form>	
                
                
                <div class="buttonGroup">
                <span id="warningMsg" style="color:#a00"></span>
                    <button type="button" class="btn btn-danger btn-sm" id="btnRegist">등록</button>
                     <button type="button" class="btn btn-default btn-sm" id="btnBack">뒤로</button>
                 </div>
   </div>             
                
                
                <!-- button group End -->
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
