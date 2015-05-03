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
<%@page import="tv.pandora.adsrv.domain.Creative"%>    
<%@page import="tv.pandora.adsrv.domain.Slot"%>    
<%	
try
{
	String a = request.getParameter("a");

	Map<String,Object> map = (Map<String,Object>)request.getAttribute("response");
	String mode = StringUtil.isNull((String)map.get("mode"));

	Campaign cp = (Campaign)map.get("cp");

	List<Ads> adslist = (List<Ads>)map.get("adslist"); 
	Ads ads = (Ads)map.get("ads");
	String adsid = ads.getAdsid();
	String adsname = ads.getAdsname();


	List<Map<String,String>> codelist = (List<Map<String,String>>)map.get("codelist");
	List<Creative> crlist = (List<Creative>)map.get("crlist");

	
	
	List<Map<String, String>> ads_code = (List<Map<String, String>>)map.get("ads_code");   
	List<Map<String, String>> crstat_code = (List<Map<String, String>>)map.get("crstat_code");   
	
	JSONArray ads_code_data = JSONArray.fromObject(ads_code);	
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
</head>
<body>

<div id="somediv" title="광고물 등록" style="display:none;">
    <iframe id="thedialog" width="100%" height="100%" frameborder="0" scrolling="yes" allowtransparency="true"></iframe>
</div>
<script>
$(document).ready(function () {
    $(".test").click(function () {
        $("#thedialog").attr('src', $(this).attr("href"));
        $("#somediv").dialog({
            width: 980,
            height: 680,
            modal: true,
            close: function () {
                $("#thedialog").attr('src', "about:blank");
            }
        });
        return false;
    });
});
</script>



    <div class="container-fluid containerBg">
        <div class="containerBox">
        <%@ include file="../common/header.jsp"  %>
            <section class="sectionBox">
                <div class="boxTitle">
                    <!-- title Start -->
                  <div class="title">캠페인 애즈 수정
                    <span class="txtBlue" style="margin-left:10px;font-size:9pt"><span class="glyphicon glyphicon-play-circle"></span> <%=cp.getCpname() %> </span>  
                    
                    <span class="txtBlue" style="font-size:9pt"><span class="glyphicon glyphicon-menu-right"></span> <%=adsname %> </span>  
                    </div>
                <div class="breadcrumbs"><span class="glyIcon"><img src="<%=web%>/img/navIcon.png" alt=""></span> 현재위치 : 캠페인  > 캠페인 정보 > 애즈 수정</div>
                    <!-- title End -->
                </div>      
              	<%-- **************** 캠페인 정보 ********************* --%>
 				<%@ include file="./com_cpinfo.jsp" %>
              	<%-- ************************************************ --%>                
                <br>
 				<%-- **************** 애즈 수정 ********************* --%>			
				<%@ include file="../campaign/ads_edit_info.jsp" %>
				
				
				<!--********************************************************************************************
				                                          광고물 
				**********************************************************************************************-->
               <div class="boxtitle3">
                    <!-- saveBtn Start -->
                    <div class="saveBtn4">
                        <a class="btn btn-primary btn-sm test" href="cpmgr.do?a=adsCrAdd&adsid=<%=ads.getAdsid() %>&newClientid=<%=cp.getClientid() %>&newClientname=<%=cp.getClientname() %>">신규 업로드</a>
                      
                        
                        
                        <a class="btn btn-danger btn-sm" href="#none" id="btnCrPopup" data-target="#myModal">광고물추가</a>
                    </div>
                    <form id="frmNewCr" action="cpmgr.do?a=crAddForm" method="post">   
                     <input type="hidden" name="a" value="crAddForm"/>
 					 <input type="hidden" id="mode" value="<%=mode%>"/>
                      <input type="hidden" name="newClientid" value="<%=cp.getClientid() %>"/>
                     <input type="hidden" name="newClientname" value="<%=cp.getClientname() %>"/>                   
                    </form>
                    <!-- saveBtn End -->
                    <h1 class="title4"><span class="glyphicon glyphicon-menu-down"></span> 광고물</h1>
                </div>
                <!-- title End -->
                <!-- creative Table Start -->
                
                <form id="frmCrDel" action="cpmgr.do?a=adsCreativeDelete" method="post">
  				<input type="hidden" name="backuri" value="<%=a%>"/>
                <input type="hidden" name="adsid" value="<%=ads.getAdsid()%>"/>
                <input type="hidden" name="crstr" value=""/>
                </form>
                <form id="frmCrMod" action="cpmgr.do?a=adsCreativeUpdate" method="post">
   				<input type="hidden" name="backuri" value="<%=a%>"/>
                <input type="hidden" name="adsid" value="<%=ads.getAdsid()%>"/>
                <table class="listTable">
                    <colgroup>
                    <col width="40px">
                    <col width="80px">
                    <col width="200px">
                    <col width="100px">
                    <col width="200px">
                    <col width="200px">
                    <col width="70px">
                    <col width="70px">
                    <col width="80px">
                    <col width="160px">
                    </colgroup>
                    <thead>
                        <tr>
                            <th><input type="checkbox" class="ckcr_all"/></th>
                            <th>광고상품</th>
                            <th>광고물</th>
                            <th>사이즈</th>
                            <th>시작일</th>
                            <th>종료일</th>
                            <th>비중</th>
                            <th>상태</th>
                            <th>등록자</th>
                            <th>최종 수정</th>
                        </tr>
                    </thead>
                    <tbody>
 <%

for(int k=0; k<crlist.size(); k++){
                                        
    Creative cr = crlist.get(k);
 %>                    
                        <tr class="cr<%=cr.getCrid()%>">
                            <td><input type="checkbox" crid="<%=cr.getCrid() %>" class="ckcr"/></td>
                            <td class="textCenter"><%=cr.getPrtypename() %></td>
                            <td class="textLeft"><a href="cpmgr.do?a=crInfo&crid=<%=cr.getCrid()%>"><%=cr.getCrname() %></a></td>
                            <td>
                            <input type="hidden" size=2 name="crid" value="<%=cr.getCrid()%>" class="credit"/>
                            <%=cr.getWidth() %> x <%=cr.getHeight() %>
                            </td>
                            <td class="form-inline">
                                <div class="info"><span class="txtBlack mr4"><%=DateUtil.getYMD(cr.getStartdate(),"-") %></span><%=DateUtil.getCutHH(cr.getStartdate())%>:<%=DateUtil.getCutMM(cr.getStartdate())%></div>
                                <div class="edit">
                                <input type="text" name="start" id="start<%=(k+1) %>" value="<%=DateUtil.getYMD(cr.getStartdate()) %>" class=" form-control nopad credit datepicker" style="width:70px">                                
                               	<select id="start_hour" name="start_hour" class="form-control nopad credit" style="width:48px">
                                     <%for(int i=0;i<=23;i++){ %>
                                    <option value="<%=DateUtil.getMMStr(String.valueOf(i))%>" <%=DateUtil.getCutHH(cr.getStartdate()).equals(DateUtil.getMMStr(String.valueOf(i)))?"selected":""%>><%=DateUtil.getMMStr(String.valueOf(i))%></option>
                                    <%} %>
                                </select>
                                <select id="start_min<%=(k+1) %>" name="start_min" class="form-control nopad credit" style="width:48px">
                                       <%for(int i=0;i<6;i++){ %>
                                    <option value="<%=DateUtil.getMMStr(String.valueOf(i*10))%>" <%=DateUtil.getCutMM(cr.getStartdate()).equals(DateUtil.getMMStr(String.valueOf(i*10)))?"selected":""%>><%=DateUtil.getMMStr(String.valueOf(i*10))%></option>
                                    <%} %>                                    
                                </select>
                                <input type="hidden" size="10" name="startdate"  value="<%=cr.getStartdate() %>" class="credit"/>
                                </div>
                            </td>
                            <td class="form-inline">
                            	<div class="info"><span class="txtBlack mr4"><%=DateUtil.getYMD(cr.getEnddate(),"-") %></span><%=DateUtil.getCutHH(cr.getEnddate())%>:<%=DateUtil.getCutMM(cr.getEnddate())%></div>
                                <div class="edit">
                            	<input type="text" id="end<%=(k+1) %>" name="end" value="<%=DateUtil.getYMD(cr.getEnddate()) %>" class=" form-control nopad credit datepicker" style="width:70px">
                               	<select id="end_hour" name="end_hour" class="form-control nopad credit" style="width:48px">
                                    <%for(int i=0;i<=24;i++){ %>
                                   <option value="<%=DateUtil.getMMStr(String.valueOf(i))%>" <%=DateUtil.getCutHH(cr.getEnddate()).equals(DateUtil.getMMStr(String.valueOf(i)))?"selected":""%>><%=DateUtil.getMMStr(String.valueOf(i))%></option>
                                   <%} %>
                               </select>
                                <select id="end_min" name="end_min" class="form-control nopad credit" style="width:48px">
                                      <%for(int i=0;i<6;i++){ %>
                                    <option value="<%=DateUtil.getMMStr(String.valueOf(i*10))%>" <%=DateUtil.getCutMM(cr.getEnddate()).equals(DateUtil.getMMStr(String.valueOf(i*10)))?"selected":""%>><%=DateUtil.getMMStr(String.valueOf(i*10))%></option>
                                    <%} %>                                    
                                </select>
                                <input type="hidden" size="10" name="enddate"  value="<%=cr.getStartdate() %>" class="credit"/>
                                
                                </div>
                            </td>
                            <td>
                              <div class="info"><%=cr.getWeight() %></div>
                              <div class="edit">
                              <input type="text" name="weight" value="<%=cr.getWeight() %>" class="form-control nopad credit numinput" style="width:40px;" >
                              </div>
                            </td>
                            <td>
                            <div class="info"><span class="<%=cr.getText() %>"><%=cr.getCr_statename() %></span></div>
                            <div class="edit">
                            <select name="cr_state" class="form-control nopad credit" style="width:50px">
                            <%for(int i=0;i<crstat_code.size(); i++){
                            	Map<String,String> code = crstat_code.get(i);
                            %>
                                <option value="<%=String.valueOf(code.get("isid"))%>"  <%=cr.getCr_state().equals(String.valueOf(code.get("isid")))?"selected":""%>><%=code.get("isname") %></option>
                            <%} %>
                           </select>
                           </div>
                            </td>
                            <td><%=cr.getUpdateusername()%></td>
                            <td><%=DateUtil.getYMDHM(cr.getUpdatedate(),".") %></td>
                            
                        </tr>
<%} if(crlist.size()==0){
%>

                        <tr>
                            <td colspan="10"> 광고물이 등록되지 않았습니다.</td>                            
                        </tr> 
<%} %> 
                        </tbody>
                       </table>
                       
                       <%if(crlist.size()>0){%>
                 		<div class="buttonGroup">
                 		<span id="warningMsg" style="color:#a00"></span>
                 		<button type="button" class="btn btn-default btn-xs" id="btnCrMod">선택수정</button>
                 		<button type="button" class="btn btn-default btn-xs" id="btnCrDel">선택삭제</button>
                		</div>
                		<%} %>
						</form>
                
 
<!--********************************************************************************************
                                         광고물 선택 팝업
**********************************************************************************************-->
<!-- modal Start -->
    <div class="modal fade" id="myModal">
        <!-- modal-lg  | default | modal-sm -->
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="dt small modal-title"><b>광고물 선택</b></h4>
                </div>
                <form id="frmCrPopup" method="post" class="form-inline" action="cpmgr.do?a=adsCreativeSave">
                <input type="hidden" name="a" value="adsCreativeSave"/>
                <input type="hidden" id="mode" value="<%=mode%>"/>
 				<input type="hidden" name="backuri" value="<%=a%>"/>
                <input type="hidden" id="clientid" value="<%=ads.getClientid()%>"/>
                <input type="hidden" name="adsid" value="<%=ads.getAdsid() %>"/>
                <input type="hidden" name="ads_state" value="<%=ads.getAds_state() %>"/>              
                <input type="hidden" name="ads_startdate" value="<%=ads.getStartdate() %>"/>
                <input type="hidden" name="ads_enddate" value="<%=ads.getEnddate() %>"/>
                <input type="hidden" name="ads_realenddate" value="<%=ads.getRealenddate() %>"/>
                <div class="modal-body">
                    <!-- search form Start -->
                     
                    <div class="form-group">
                            <label>등록일</label>
                            <input type="text" id="s_start" value="<%=DateUtil.getYMD(DateUtil.getPreMon(DateUtil.curDate(),1)) %>" class="start form-control input-sm" style="width:100px">
                            <input type="text" id="s_end" value="<%=DateUtil.getYMD(DateUtil.curDate()) %>" class="end form-control input-sm" style="width:100px">
                            <input type="text" class="form-control">
                            <button type="submit" class="btn btn-warning" id="btnSearch">검색</button>
                        </div>
                     <!-- search form End -->
                    <br>
                    <!-- data table Start -->
                    <div style="height:200px;padding:2px;overflow-y:scroll;vertical-align:top">
                   <table class="listTable3">
					<colgroup>
					<col width="5%">
					<col width="14%">
					<col width="">
					<col width="12%">
					<col width="16%">
					<col width="8%">
					</colgroup>
					<thead>
					<tr>
					<th><input type="checkbox" id="ckall" name="ckall"/></th>
					<th>광고상품</th>
					<th>광고물</th>
					<th>사이즈</th>
					<th>등록일</th>
					<th>등록인</th>
					</tr>
					</thead>
					<tbody id="searchList">                            
					</tbody>
					</table>
					</div>
					<!-- data table End -->
					<br>
					<!-- check table Start -->
					<table class="listTable">
					<colgroup>
					<col width="5%">
					<col width="">
					</colgroup>
					<thead>
					<tr>
					<th>삭제</th>
					<th>선택된 광고물 명</th>
					</tr>
					</thead>
					<tbody id="addList">					
					</tbody>
					</table>
                    <!-- check table End -->
                </div>
                <div class="modal-footer">
 					<span id="warningMsg" style="color:#a00"></span>
                    <button type="button" class="btn btn-danger" id="btnCrRegist">저장</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                </div>
                </form>
                
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- modal End -->
    
    <!-- Modal -->

</section>
</div>
</div>
 
</body>

<script>
/********************* 화면 셋팅 *************************/   
$(document).ready(function() {
	
	var ads_code = <%=ads_code_data%>;
	
	$("[name=start]").datepicker({
		dateFormat: 'yy-mm-dd',
		changeMonth:true,
		changeYear:true,
		onClose: function(selectDate){
				$("[name=end]").datepicker("option","minDate",selectDate);
				console.log("minDate");
				$(this).trigger("change");
		}
	});
	$("[name=end]").datepicker({
		dateFormat: 'yy-mm-dd',
		changeMonth:true,
		changeYear:true,
		onClose: function(selectDate){
				$("[name=start]").datepicker("option","maxDate",selectDate);
				$(this).trigger("change");
		}
	});

	
	
	
	
	// 공통
	$(".debug").css("display","none");	
	
	<%if(!mode.equals("N")){%>
	$(".credit").attr("disabled", true);
	$(".credit").css("display","none");
	<%}else{%>
	$(".info").css("display","none");
	<%}%>
	$('.numinput').numberOnly();
	
	
	$(document).on("click", ".ckcr", function(e){
	  	var ck = $(this).is(':checked');
	  	var crid = $(this).attr("crid");
	  	if(ck){
	  		
	  		$( ".cr"+crid).find(".credit").attr("disabled", false);
	  		$( ".cr"+crid).find(".credit").css("display","");
	  		$( ".cr"+crid).find(".info").css("display","none");
	  	} else {
	  		$( ".cr"+crid).find(".credit").attr("disabled", true);
	  		$( ".cr"+crid).find(".credit").css("display","none");
	  		$( ".cr"+crid).find(".info").css("display","");
	  	}
	});
	$(document).on("click", ".ckcr_all", function(e){
	  	var ck = $(this).is(':checked');
	  	$(".ckcr").prop('checked',ck);
	  	
	  	if(ck){
	  		$(".credit").attr("disabled", false);	  		
	  		$(".credit").css("display","");
	  		$(".info").css("display","none");
	  	} else {
	  		$(".credit").attr("disabled", true);
	  		$(".credit").css("display","none");
	  		$(".info").css("display","");
	  	}
	});
	
	/**************************** 광고물 신규 업로드 ******************************/
	/*
	$("#btnNewCr").click(function(e){		
	    e.preventDefault();
	    var url = $(this).attr('href');
	    $("#OutModal .modal-body").html('<iframe id="newCrFrame" width="100%" height="100%" frameborder="0" scrolling="yes" allowtransparency="true" src="'+url+'"></iframe>');
	});	
	
	*/
	
	
	
	/**************************** 광고물 팝업 ******************************/
	
	//광고물 선택 시 하단 출력
	addCreative = function(obj) {
		$("#change").val("change");
	
		var crid = $(obj).val();
		var crname = $(obj).attr("crname");
		if($(obj).is(':checked')) {
			if($('#frmCrPopup #add'+crid).length==0){
				var str = '<tr id="add'+crid+'">';
				str += '<td><a href="#" name="btnSecRemove" crid='+crid+'><span class="glyphicon glyphicon-remove" style="width:30px"></span></a></td>';
				str += '<td class="textLeft">'+crname+'<input type="hidden" name="crid" value="'+crid+'"/></td>';
				str += '</tr>';		
	           <!--td><button type="button" class="btn btn-default btn-xs">X</button></td-->
				$("#addList").append( str );
			}
		}else {
			$("#add"+crid).remove();
		}
	}
	//체크박스 전체 선택 
	$("#frmCrPopup input:checkbox[name='ckall']").click(function(e){	
		var ischked = $(this).is(':checked');
		$("#frmCrPopup [name='ckpop']").prop("checked", ischked);	
		for(var i=0; i<$("#frmCrPopup [name='ckpop']").length; i++){
			addCreative($("#frmCrPopup [name='ckpop']").eq(i));		
		}
	});
	
 
	$("#btnSlotPopup").click(function(e){	
		$('#myModal2').modal();
		$("#slotSearchList").html("");
		$("#runAdsList").html("");	
	});
	
	//광고물 추가 팝업
	$("#btnCrPopup").click(function(e){	
		$("#searchList").html("");
		$("#addList").html("");

		
		e.preventDefault();
		$('#myModal').modal();
		$(".modify").css("display", "none");
		$(".new").css("display", "");
		$("#frmCrMod.debug").val(""); //값 초기화	 (siteid, change)	
		$("#frmCrPopup input:checkbox").prop("checked", false);	 //값 초기화	 (siteid, change)	
		
		var start = $("#s_start").val();
		var end = $("#e_end").val();
		var clientid = $("#clientid").val();
		var adsid = $("#frmCrMod input[name=adsid]").val();
		
		MasDwrService.getCrList(start, end, clientid, adsid,
		   		function(data) {
					var htmlstr = '';
					
					if(data.length >0) 
					{
						for(var k=0; k<data.length; k++) {
							htmlstr += '<tr>';
							htmlstr += '<td>';
							if(data[k].selected=='0') {
								htmlstr += '<input type="checkbox" name="ckpop" onclick="addCreative(this)"';
								htmlstr += ' id="chkBox'+data[k].crid+'"'; 
								htmlstr += ' value="'+data[k].crid+'"'; 
								htmlstr += ' crname="'+data[k].crname+'"'; 								
								htmlstr +='"/>';
							}
							htmlstr += '</td>';
							htmlstr += '<td>'+data[k].prtypename+'</td>';
							htmlstr += '<td class="textLeft">';
							if(data[k].crurl!=""){ 
								htmlstr += '<a href=javascript:newTab("'+data[k].crurl+'")><span class="glyphicon glyphicon-download"></span></a> ';
							} 
                            
							htmlstr += '<a href="cpmgr.do?a=crInfo&crid='+data[k].crid+'" target="_new">'+data[k].crname+'</a></td>';
							htmlstr += '<td class="textLeft">'+data[k].width+' x '+data[k].height+'</td>';
							htmlstr += '<td>'+getYMDHM(data[k].updatedate,'-')+'</td>';
							htmlstr += '<td>'+data[k].updateusername+'</td>';
							htmlstr += '</tr>';							
						}
					} else {
						htmlstr += '<tr>';
						htmlstr += '<td colspan="7 ">조건에 맞는 광고물이 없습니다.</td>';
						htmlstr += '</tr>';
						
					}
					//console.log("htmlstr="+htmlstr);
					$("#searchList").append(htmlstr);
			});
	});	 
	//광고물 조건 선택
	$("#btnSearch").click(function(e){		
		var width = $("#width").val();
		var height = $("#height").val();
		var start = $("#start").val();
		var end = $("#end").val();
		var clientid = $("#clientid").val();
		
		$("#searchList").html("");
	});	
	//팝업 광고물 추가
	$("#btnCrRegist").on("click", function(e){		
		$("#frmCrPopup input, #frmCrPopup select").css("border-color", "#ccc");
		e.preventDefault();
	
		if($("#frmCrPopup [name=crid]").size()==0){
			$("#frmCrPopup #warningMsg").text("광고물을 선택해 주세요.");
			return;
		} else {							
			//if(confirm("애즈에 광고물을 추가하시겠습니까?")) {
				$("#frmCrPopup").submit();	
			//}
		}			
	});
	/**************************** 광고물 팝업 end ******************************/
	/*
	$('#frmCrPopup select').change(function(e){	
		$("#change").val("change");
	});*/
	
	
	
	// 광고물 선택 삭제
	$("#frmCrMod #btnCrDel").on("click", function(e){
		$("#frmCrMod input, #frmCrMod select").css("border-color", "#ccc");
		
					
		if($("#frmCrMod input:checkbox.ckcr:checked").length < 1){
			$("#frmCrMod #warningMsg").text("삭제할 광고물을 선택해 주세요.");
          	result = false;
		} else{		
			var crstr = "";
			$("#frmCrMod input:checkbox.ckcr:checked").each(function (i) {
				crstr += $(this).attr("crid")+",";
			});
			crstr = crstr.substring(0, crstr.length-1);
			$("#frmCrDel [name=crstr]").val(crstr);
			 
			if(confirm("애즈 광고물을 삭제하시겠습니까?")){
				$("#frmCrDel").submit();
			}			
		}
	});	
	
	// 광고물 선택 수정
	$("#frmCrMod #btnCrMod").on("click", function(e){
		$("#frmCrMod input, #frmCrMod select").css("border-color", "#ccc");
		
		var result = true;				
		if($("#frmCrMod input:checkbox.ckcr:checked").length < 1){
			$("#frmCrMod #warningMsg").text("수정할 광고물을 선택해 주세요.");
          	result = false;
		} else{
			$('#frmCrMod [name=start]').each(function (i) {
				var startdate = delDash($(this).val())
								+$("#frmCrMod [name=start_hour]").eq(i).val()
								+$("#frmCrMod [name=start_min]").eq(i).val();
				$("#frmCrMod [name=startdate]").eq(i).val(startdate);
				if (startdate < $("#frmAdsInfo input[name=startdate]").val()) {
					
					
					
					$(this).css("border-color","red").focus();				
		          	$("#frmCrMod #warningMsg").text("광고물 기간은 애즈 기간을 벗어날 수 없습니다.");
		          	result = false;
		          	return result;
		        }
		      });
	
			  $('#frmCrMod [name=end]').each(function (i) {
					var enddate = delDash($(this).val())
									+$("#frmCrMod [name=end_hour]").eq(i).val()
									+$("#frmCrMod [name=end_min]").eq(i).val();
					$("#frmCrMod [name=enddate]").eq(i).val(enddate);
					if (enddate > $("#frmAdsInfo [name=enddate]").val()) {
						

						$(this).css("border-color","red").focus();				
			          	$("#frmCrMod #warningMsg").text("광고물 기간은 애즈 기간을 벗어날 수 없습니다.");
			          	result = false;
			          	return result;
			        }
			   });		
		}  
		if(result){
			if(confirm("애즈 광고물 정보를 수정하시겠습니까?")){
				$("#frmCrMod").submit();
			}
			
		}
	});	
	
	
});	


  </script> 
</html>
<%
} catch(Exception e) {
    e.getMessage();
}
%> 