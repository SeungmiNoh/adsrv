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
	
	Map<String,Object> map = (Map<String,Object>)request.getAttribute("response");

	String mode = StringUtil.isNull((String)map.get("mode"));   
	String modestr = "등록";
	if(mode.equals("E")) {
		modestr = "수정";
	}
	
	Campaign  cp = (Campaign)map.get("cpinfo");
	List<User> tclist = (List<User>)map.get("tclist");
	
	String cpid = "";
	String cpname = "";
	String clientid = "";
	String clientname = "";
	String agencyid = "";
	String agencyname = "";
	String medrepid = "";
	String medrepname = "";
	String startdate = "";
	String enddate = "";
	String tcid = "";
	String tcname = "";
	String memo = "";
	String updatedate = "";
	String updateusername = "";
	String budget = "";
	
	if(cp != null)
	{	
		cpid = cp.getCpid();
		cpname = cp.getCpname();
		clientid = cp.getClientid();
		clientname = cp.getClientname();
		agencyid = StringUtil.isNullZero(cp.getAgencyid());
		agencyname = StringUtil.isNull(cp.getAgencyname());
		medrepid = StringUtil.isNullZero(cp.getMedrepid());
		medrepname = StringUtil.isNull(cp.getMedrepname());
		startdate = DateUtil.getYMD(cp.getStartdate());
		enddate = DateUtil.getYMD(cp.getEnddate());
		budget = StringUtil.addComma(cp.getBudget());
		tcid = cp.getTcid();
		tcname = cp.getTcname();
		memo = StringUtil.isNull(cp.getMemo());
		updatedate = DateUtil.getYMDHM(cp.getUpdatedate(),"-");
		updateusername = cp.getUpdateusername();
	}
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
  
  
  <script>
  $(document).ready(function() {
		$('.numinput').onlyNumber();
		$("#cpname").focus();
		
		$("#btnCopy").on("click", function(e){	
			if(confirm("캠페인 내 애즈정보 모두 복사됩니다. \r\n캠페인을 복사하시겠습니까?")) {					
				//$("#frmRegist input[name=a]").val("campaignCopy");
				$("#frmCopy").submit();
			}					
		});	
		$(document).on("click", "a[name=btnDel]", function(e){
			if(confirm("캠페인을 삭제하시겠습니까?")) {								
				$("#frmDel").submit();
			}					
		});
		
		
		<%if(cp != null) {%>
		resetData();
		function resetData()  {
			$("#cpid").val("<%=cpid%>");
			$("#cpname").val("<%=cpname%>");
			$("#clientid").val("<%=clientid%>");
			$("#clientname").val("<%=clientname%>");
			$("#client").val("<%=clientname%>");
			$("#agencyid").val("<%=agencyid%>");
			$("#agencyname").val("<%=agencyname%>");
			$("#agency").val("<%=agencyname%>");
			$("#medrepid").val("<%=medrepid%>");
			$("#medrepname").val("<%=medrepname%>");
			$("#medrep").val("<%=medrepname%>");
			$("#start").val("<%=startdate%>");
			$("#end").val("<%=enddate%>");
			$("#budget").val("<%=budget%>");
			$("#tcid").val("<%=tcid%>");
			$("#memo").val("<%=memo%>");
			$("#updatedate").html("<%=updatedate%>");
			$("#updateuser").html("<%=updateusername%>");		
		}
		<%}%>
		
	});
  
  $(function() {
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
				//showOn: "button",
				buttonImage: "<%=web%>/img/calendar-icon-red.gif",
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
		$(".debug").css("display","none");
	  	$('#frmRegist').change(function(e){	
			$("#change").val("change");
		});
	  	
		$("#btnRegist").on("click", function(e){
			$("#frmRegist input, #frmRegist select").css("border-color", "#ccc");
			$("#warningMsg").text("");
			e.preventDefault();
			
			if($("#change").val() != "change"){
				alert("변경된 내용이 없습니다.");
				return;
			}else if($.trim($("#cpname").val()).length==0){
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
			if(confirm("캠페인 정보를 <%=modestr%>하시겠습니까?")){
				$("#frmRegist input[name=a]").val("cpRegist");
				$("#frmRegist").submit();					
				
			}
		});


	    $.ajax({		    
			url : "cpmgr.do?a=auto_corp&corptype=2",
		    datatype:"json",
		    success:function(data, type){	     
		        test = eval("(" + data + ")");	      
				$( "#agency" ).autocomplete({
					source:test,
					focus: function(event, ui) {
						return false;
					},
					select: function(event, ui) {
						$('#agency').val(ui.item.label);
						$('#agencyid').val(ui.item.value);
						$('#agencyname').val(ui.item.label);
						$("#agency").css("border-color","green").focus();
						$("#change").val("change");
						return false;
					},					
					change: function(event, ui) {					
						if($('#agencyname').val()!="") {
							if($('#agency').val()!=$('#agencyname').val()) {
								$('#agencyid').val("");
								$('#agencyname').val("");
								$("#agency").css("border-color","red");						
							}
						} 
						return false;
					},
					matchContains: false,
			  		matchSubset:1

				});
			}
		});  	  
	    $.ajax({		    
			url : "cpmgr.do?a=auto_corp&corptype=1",
		    datatype:"json",
		    success:function(data, type){	     
		        test = eval("(" + data + ")");	      
				$( "#client" ).autocomplete({
					source:test,
					focus: function(event, ui) {
						return false;
					},
					select: function(event, ui) {
						$('#client').val(ui.item.label);
						$('#clientid').val(ui.item.value);
						$('#clientname').val(ui.item.label);
						$("#client").css("border-color","green").focus();
						$("#change").val("change");
						return false;
					},					
					change: function(event, ui) {					
						if($('#clientname').val()!="") {
							if($('#client').val()!=$('#clientname').val()) {
								$('#clientid').val("");
								$('#clientname').val("");
								$("#client").css("border-color","red");						
							}
						} 
						return false;
					}		

				});
			}
		});
	    
	    
	    $.ajax({		    
			url : "cpmgr.do?a=auto_corp&corptype=3",
		    datatype:"json",
		    success:function(data, type){	     
		        test = eval("(" + data + ")");	      
				$( "#medrep" ).autocomplete({
					source:test,
					focus: function(event, ui) {
						return false;
					},
					select: function(event, ui) {
						$('#medrep').val(ui.item.label);
						$('#medrepid').val(ui.item.value);
						$('#medrepname').val(ui.item.label);
						$("#medrep").css("border-color","green").focus();
						$("#change").val("change");
						return false;
					},					
					change: function(event, ui) {					
						if($('#medrepname').val()!="") {
							if($('#medrep').val()!=$('#medrepname').val()) {
								$('#medrepid').val("");
								$('#medrepname').val("");
								$("#medrep").css("border-color","red");						
							}
						} 
						return false;
					}		

				});
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
                    <div class="title">캠페인 <%=modestr%></div>
                    <div class="breadcrumbs"><span class="glyIcon"><img src="<%=web%>/img/navIcon.png" alt=""></span> 현재위치 : 캠페인 > 캠페인 <%=modestr%></div>
                    <!-- title End -->
                </div>

                <!-- add Table Start -->
     			<form id="frmDel" method="post" role="form" action="cpmgr.do?a=modDelCampaign">
				<input type="hidden" name="cpid" value="<%=cpid%>"/>
				</form>
 				<form id="frmCopy" method="post" role="form" action="cpmgr.do?a=campaignCopy">
				<input type="hidden" name="cpid" value="<%=cpid %>"/>
				</form>               
				<form name="frmRegist" id="frmRegist" role="form" action="cpmgr.do?a=cpRegist" method="POST">
                     <input type="hidden" name="a" value="cpRegist">
                     <input type="text" id="cpid" name="cpid" class="debug">
                     <input type="text" id="change" name="change" value="" class="debug">
					<table class="addTable" style="width:980px">
                        <colgroup>
                            <col width="15%">
                                <col width="85%">
                        </colgroup>
                        <tr>
                            <th>캠페인명<span style="color:red"> * </span></th>
                            <td class="form-inline">
                                <input type="text" id="cpname" name="cpname" class="form-control input-sm" style="width:320px" value="<%=DateUtil.curDate()%>_">
                                <!--  a class="btn btn-success btn-sm" href="#" role="button">중복확인</a-->
                            </td>
                        </tr>
                        <tr>
                            <th>광고주<span style="color:red"> * </span></th>
                            <td>
 					    		<input class="debug" size=8 type="text" name="clientname" id="clientname"/>
					    		<input class="debug" size=4 type="text" name="clientid" id="clientid"/>
                                <input type="text"  id="client" class="form-control input-sm" autocomplete="off" style="width:240px" placeholder="">
					     
                            </td>
                        </tr>
                        <tr>
                            <th>대행사</th>
                            <td>
  					    		<input class="debug" size=8 type="text" name="agencyname" id="agencyname"/>
					    		<input class="debug" size=4 type="text" name="agencyid" id="agencyid"/>
                                <input type="text" id="agency" class="form-control input-sm" autocomplete="off" style="width:240px" placeholder="">
                            </td>
                        </tr>
                        <tr>
                            <th>미디어렙</th>
                            <td>
    					    	<input class="debug" size=8 type="text" name="medrepname" id="medrepname"/>
					    		<input class="debug" size=4 type="text" name="medrepid" id="medrepid"/>
                                <input type="text" id="medrep" class="form-control input-sm" autocomplete="off" style="width:240px" placeholder="">
                             
                            </td>
                        </tr>
                        <tr>
                            <th>집행금액<span style="color:red"> * </span></th>
                            <td>
                                <input type="text" id="budget" name="budget" class="form-control input-sm numinput" style="width:190px; text-align:right;" value="">
                            </td>
                        </tr>
                        <tr>
                            <th>캠페인 기간<span style="color:red"> * </span></th>
                            <td>
                                <div class="form-inline">
                             		<input type="text" class="form-control input-sm" name="startdate" id="start" style="width:120px" placeholder="캠페인 시작일">
                            		<a class="btn btn-success btn-sm" href="#none" role="button" id="btnSday"><span class="glyphicon glyphicon-calendar"></span></a>
                                ~
                             		<input type="text" class="form-control input-sm" name="enddate" id="end" style="width:120px" placeholder="캠페인 종료일">
                            		<a class="btn btn-success btn-sm" href="#none" role="button" id="btnEday"><span class="glyphicon glyphicon-calendar"></span></a>
                                 </div>
                            </td>
                        </tr>
                        
                        <tr>
                            <th>담당자<span style="color:red"> * </span></th>
                            <td>
                                <select name="tcid"  class="form-control input-sm" style="width:120px">
                                <%for(int k=0; k<tclist.size(); k++){
					    User master = tclist.get(k);%>
					    <option value="<%=master.getUserid()%>" <%=userID.equals(master.getUserid())?"selected":"" %>><%=master.getUsername()%></option>
					    <%} %>	
                            </select>
                           </td>
                        </tr>
                         <tr>
                            <th>설명</th>
                            <td>
                                <textarea id="memo" name="memo" class="form-control input-sm" rows="8" name="" style="width:600px" maxlength="50"></textarea>
                            </td>
                        </tr>

                        <%if(mode.equals("E")) {%>
                        <tr>
						<th class="modify">최종수정</th>
                          <td class="form-inline" id="updatedate"><%=DateUtil.getYMDHM(cp.getUpdatedate(),"-") %></td>
                      	</tr> 
                       <tr class="modify">                       
                       <th>수정인</th>
                           <td class="form-inline" id="updateuser"><%=cp.getUpdateusername() %></td>
                       </tr> 
                       <%}else{ %>
                       <tr class="new">
                            <th>등록일</th>
                            <td class="form-inline">
                                <%=DateUtil.getYMD(DateUtil.curDate(), "-")  %> 
                            </td>
                        </tr>            
                       <tr class="new">
                            <th>등록인</th>
                            <td><%=userName %><input type="text" name="insertuser" class="debug" value="userID"></td>
                        </tr>                       
                        <%} %>                                 
                   </table>
                </form>
                <!-- add Table End -->
                <!-- button group Start -->
                <div class="buttonGroup" style="width:980px">
                    <span id="warningMsg" style="color:#a00"></span>					
                     <%if(mode.equals("E")) {%>
                     <!-- 
                     <a role="button" class="btn btn-default btn-sm" href="javascript:resetData()">Reset</a>
                      -->
                   	<button type="button" class="btn btn-danger btn-sm" id="btnRegist">수정</button>
                   	
                     <button type="button" class="btn btn-warning btn-sm" id="btnCopy">복사</button>
                    <a role="button" class="btn btn-default btn-sm" href="cpmgr.do?a=cpAdsList&cpid=<%=cp.getCpid()%>">애즈목록</a>
                    <a role="button" class="btn btn-default btn-sm" href="cpmgr.do?a=cpList">캠페인목록</a>
                     <a class="btn btn-default btn-sm" href="#none" name="btnDel">삭제</a>
                    <a role="button" class="btn btn-default btn-sm" href="rptmgr.do?a=summary&cpid=<%=cp.getCpid()%>">리포트</a>
                      	
                   	
                   	
                   	
                   	
                   	
                   	
                   	
                   	
                   	
                   	
                   	
                   	
                    <%}else{ %>
                     <a role="button" class="btn btn-default btn-sm" href="cpmgr.do?a=cpList">목록</a>
                    <button type="button" class="btn btn-danger btn-sm" id="btnRegist">등록</button>
                    <%} %>
 
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
