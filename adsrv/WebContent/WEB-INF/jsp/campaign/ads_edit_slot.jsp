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
	String s_siteid = StringUtil.isNull(request.getParameter("s_siteid"));
	String s_secid = StringUtil.isNull(request.getParameter("s_secid"));
	String s_slotid = StringUtil.isNull(request.getParameter("s_slotid"));


	Map<String,Object> map = (Map<String,Object>)request.getAttribute("response");
	String mode = StringUtil.isNull((String)map.get("mode"));

	Campaign cp = (Campaign)map.get("cp");

	List<Ads> adslist = (List<Ads>)map.get("adslist"); 
	Ads ads = (Ads)map.get("ads");
	String adsid = ads.getAdsid();
	String adsname = ads.getAdsname();
	
	
	List<Map<String, String>> ads_code = (List<Map<String, String>>)map.get("ads_code");   
	List<Map<String, String>> crstat_code = (List<Map<String, String>>)map.get("crstat_code");   
	
	JSONArray ads_code_data = JSONArray.fromObject(ads_code);	
	
	
	List<Map<String, String>> grouplist = (List<Map<String, String>>)map.get("grouplist");   
	List<Slot> slotlist = (List<Slot>)map.get("slotlist");   
	List<Map<String,String>> sitelist = (List<Map<String,String>>)map.get("sitelist");   
	List<Map<String,String>> seclist = (List<Map<String,String>>)map.get("seclist");   
	List<Slot> adsslotlist = (List<Slot>)map.get("adsslotlist");   
	JSONArray sec_data = JSONArray.fromObject(seclist);
	JSONArray slot_data = JSONArray.fromObject(slotlist);
	
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
 				<!--********************************************************************************************
				                                          애즈 
				**********************************************************************************************-->
				<div style="border: 0px solid #d3d2d2; padding:0px">
				<%@ include file="../campaign/ads_edit_info.jsp" %>
				</div>
				<!--********************************************************************************************
				                                          광고위치
				**********************************************************************************************-->
               <div class="boxtitle3">
                    <!-- saveBtn Start -->
                    <div class="saveBtn4">
                    <a class="btn btn-danger btn-sm" href="#none" id="btnSlotPopup" data-target="#myModal2">위치추가</a>
                    </div>                 
                    <!-- saveBtn End -->
                    <h1 class="title4"><span class="glyphicon glyphicon-menu-down"></span> 광고 위치</h1>
                </div>
                 <!-- search form End -->
                <form id="frmSlotDel" action="cpmgr.do?a=adsSlotDelete" method="post">
 				<input type="hidden" name="backuri" value="<%=a%>"/>
                <input type="hidden" name="adsid" value="<%=ads.getAdsid()%>"/>
                <input type="hidden" name="slotstr" value=""/>
                </form>
                <form id="frmSlotMod" action="cpmgr.do?a=adsSlotUpdate" method="post">
 				<input type="hidden" name="backuri" value="<%=a%>"/>
                <input type="hidden" name="adsid" value="<%=ads.getAdsid()%>"/>
                <input type="hidden" name="slotstr" value=""/>
                <input type="hidden" name="slot_state" value=""/>
                <!-- creative Table Start -->
                 <table class="listTable">
                    <colgroup>
                    <col width="4%">
                    <col width="">
                    <col width="10%">
                    <col width="">
                    <col width="10%">
                    <%-- 
                    <col width="6%">
                    <col width="5%">
                    --%>
   					<col width="10%">
                    <col width="">
                    </colgroup>
                    <thead>
                        <tr>
                            <th><input type="checkbox" id="ckall" name="ckall"/></th>                                            
                            <th>위치</th>
                            <th>사이즈</th>
                            <th>위치 정보</th>
                            <th>상태</th>
                            <!--  
                            <th>중지/진행</th>
                            <th>삭제</th>-->
                            <th>등록자</th>
                            <th>등록일</th>
                        </tr>
                    </thead>

                    <tbody>
 <%

 for(int k=0; k<adsslotlist.size(); k++){
     
		Slot slot = adsslotlist.get(k);
  %>                    
 						<tr id="adsSlot<%=slot.getSlotid()%>">
                            <td>
                                <input type="checkbox" name="ckslot" slotid="<%=slot.getSlotid()%>"/>
                            </td>
                            <td class="textLeft"><%=slot.getSlottag()%></td>
                            <td><%=slot.getWidth() %> x <%= slot.getHeight()%></td>
                            <td class="textLeft"><%=slot.getSlottag()%></td>
                            <td class="<%=slot.getSlot_state().equals("1")?"txtRed":"txtBlue"%>"><%=slot.getSlot_state().equals("1")?"진행":"중지"%></span>
                             </td>
                           <td><%=slot.getUpdateusername() %></td>
                           <td><%=DateUtil.getYMD(slot.getUpdatedate()) %></td>
                      </tr>
<%} if(adsslotlist.size()==0){
%>

                        <tr>
                            <td colspan="9"> 위치가 등록되지 않았습니다.</td>                            
                        </tr> 
                        <%} %> 
                        </tbody>
                       </table>
                <%if(adsslotlist.size()>0){ %>
                 <div class="buttonGroup">
                 	<span id="warningMsg" style="color:#a00"></span>
                 				<a href="#none" class="btn btn-default btn-xs" name="btnSelState" state="1">선택 <span class="glyphicon glyphicon-play"></span></a>
                 				<a href="#none" class="btn btn-default btn-xs" name="btnSelState" state="0">선택 <span class="glyphicon glyphicon-stop"></span></a>
                            	<button type="button" class="btn btn-default btn-xs" id="btnSlotDel">선택삭제</button>
                     <!--  a class="btn btn-default btn-sm" href="#" role="button">태그 확인</a-->
                </div>
    			<%} %>
    			</form>
  <!--********************************************************************************************
                                         광고위치 선택 팝업
**********************************************************************************************-->
<!-- modal Start -->
    <div class="modal fade" id="myModal2">
        <!-- modal-lg  | default | modal-sm -->
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="dt small modal-title"><b>광고위치 선택</b></h4>
                </div>
                <form id="frmSlotPopup" method="post" class="form-inline" action="cpmgr.do?a=adsSlotSave">
              		<input type="hidden" name="backuri" value="<%=a%>"/>
                <input type="hidden" name="a" value="adsSlotSave"/>
                 <input type="hidden" name="adsid" value="<%=ads.getAdsid() %>"/>    
                <div class="modal-body">
                    <!-- search form Start -->
                     
                    <div class="form-group">
                           <select id="s_slgroup" name="" class="form-control input-sm" style="width:180px">
							<option value="0">위치그룹</option>
							<%for(int i=0;i<grouplist.size();i++){ 
							Map<String,String> group = grouplist.get(i);
							%>
							<option value="<%=String.valueOf(group.get("groupid")) %>"><%=group.get("groupname") %></option>                               
							<%} %>
							</select>
							<select id="s_siteid" name="s_siteid" class="form-control input-sm" style="width:140px">
							<option value="0">사이트</option>
							<%for(int i=0;i<sitelist.size();i++){ 
							Map<String,String> site = sitelist.get(i);
							%>
							<option value="<%=String.valueOf(site.get("siteid")) %>"><%=site.get("sitename") %></option>                               
							<%} %>
							</select>
							<select id="s_secid" name="s_secid" class="form-control input-sm" style="width:140px">
							<option value="0">섹션</option>                              
							<%
							if(!s_siteid.equals("")){
							for(int i=0;i<seclist.size();i++){ 
							Map<String,String> sec = seclist.get(i);
							if(s_siteid.equals(String.valueOf(sec.get("siteid")))){
							%>
							<option value="<%=String.valueOf(sec.get("secid")) %>" <%=s_secid.equals(String.valueOf(sec.get("secid")))?"selected":"" %>><%=sec.get("secname") %></option>                               
							<%} 
							}
							} %>                            
							</select>
							<select name="s_slotid"  id="s_slotid" class="form-control input-sm" style="width:240px">
							<option value="0">위치</option>
							<%
							if(!s_secid.equals("")){
							for(int i=0;i<slotlist.size();i++){ 
							Slot slot = slotlist.get(i);
							if(s_secid.equals(slot.getSecid())){
							%>
							<option value="<%=slot.getSlotid() %>" <%=s_slotid.equals(slot.getSlotid())?"selected":"" %>><%=slot.getSlotname() %></option>                               
							<%} 
							} 
							}%>                            
							</select>
							<!--  <button class="btn btn-danger btn-sm" id="btnAdd">추가</button>--> 
                          <a class="btn btn-warning btn-sm" id="btnSlotSearch">조회</a>
                            <!--  button type="submit" class="btn btn-warning" id="btnSlotSearch">검색</button-->
                        </div>
                     <!-- search form End -->
                    <br>
                    <!-- data table Start -->
                    <div id="slotDIV" style="height:200px;padding:2px;overflow-y:scroll;vertical-align:top">
                   <table class="listTable3" >
                     <colgroup>
                         <col width="8%">
                         <col width="18%">
                         <col width="16%">
                         <col width="%">
                     </colgroup>
                     <thead>
                         <tr style="height:20px">
                             <th><input type="checkbox" id="ckpopall" name="ckpopall"/></th>
                             <th>사이트</th>
                             <th>위치명</th>                                           
                             <th>사이즈</th>                                           
                             <th>태그</th>                                           
                         </tr>
                     </thead>
                     <tbody id="slotSearchList">
                     </tbody>
                     </table>
                     </div>
                     <div id="runAdsList">
                     
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
					<th>선택 광고위치</th>
					</tr>
					</thead>
					<tbody id="addSlotList">					
					</tbody>
					</table>
                    <!-- check table End -->
                </div>
                <div class="modal-footer">
 					<span id="warningMsg" style="color:#a00"></span>
                    <button type="button" class="btn btn-danger" id="btnSlotRegist">저장</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                </div>
                </form>
                
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->

    <!-- modal End -->      
</section>
</div>
</div>
 
</body>

<script>
/********************* 화면 셋팅 *************************/   
$(document).ready(function() {
	
	// 공통
	$(".debug").css("display","none");	
	$('.numinput').numberOnly();
	
	
	
	$("#btnSlotPopup").click(function(e){	
		$('#myModal2').modal();
		$("#slotSearchList").html("");
		$("#runAdsList").html("");	
	});
	
	/**************************************** 광고위치***********************************************/
	
	var arrSection = <%=sec_data%>;
	var arrSlot = <%=slot_data%>;
	
	$("#s_siteid").change(function(e){		
		$("#s_secid").html('<option value="0">섹션</option>');
		if($("#s_siteid").val()!=0){
		
			for(var i=0;i<arrSection.length;i++){
				if($("#s_siteid").val()==arrSection[i].siteid) {
					$("#s_secid").append('<option value="'+arrSection[i].secid+'">'+arrSection[i].secname+'</option>');
				}
			}			
		}		
	});
	$("#s_secid").change(function(e){		
		$("#s_slotid").html('<option value="0">위치</option>');
		if($("#s_secid").val()!=0){
		
			for(var i=0;i<arrSlot.length;i++){
				if($("#s_secid").val()==arrSlot[i].secid) {
					$("#s_slotid").append('<option value="'+arrSlot[i].slotid+'">'+arrSlot[i].slotname+'</option>');
				}
			}			
		}		
	});	
	$("#s_slgroup").on("change", function(e){
		
		var groupid = $("#s_slgroup").val();
		var slotid = $("#s_slotid").val();	
		if(groupid != 0 && slotid!=0) 
		{
			$("#s_slotid").val(0);
		}		
	});
	
	$("#s_slotid").on("change", function(e){
		var slotid = $("#s_slotid").val();
		var groupid = $("#s_slgroup").val();
		if(groupid != 0 && slotid!=0) 
		{
			$("#s_slgroup").val(0);
		}		
	});	
	
	$("input:checkbox[name='ckall']").click(function(e){	
		var ischked = $(this).is(':checked');
		var slot_str = "";
		$("input:checkbox[name='ckslot']").prop("checked", ischked);			
	});
	/*
	$("[name=btnSelState]").click(function(e){	
		var slot_str = "";
		for(var i=0; i<$("input:checkbox[name='ckslot']").length; i++){
			slot_str += $("input:checkbox[name='ckslot']").eq(i).val()+',';		
		}
		var state = $(this).attr("state");
		
		
		slot_str = slot_str.substring(0,slot_str.length-1);
		
		
		
		
	});*/
	
	$("#btnSlotSearch").click(function(e){		
		var adsid = <%=ads.getAdsid()%>;
		var prtype = <%=ads.getPrtype()%>;
		var groupid = $("#s_slgroup").val();
		var siteid = $("#s_siteid").val();
		var secid = $("#s_secid").val();
		var slotid = $("#s_slotid").val();
	
		$("#slotSearchList").html("");
		$("#runAdsList").html("");	
		if(groupid!="0"){
			MasDwrService.getSlgroupInSlotList(adsid, groupid,
				function(data) {
					setSlotHtml(data);
					if(data != null){
						//runAdsList(data[0].slotid, data[0].slottag);
					}
				});		
		} else {
			MasDwrService.getSlotSearchList(adsid, prtype, siteid, secid, slotid,
			   		function(data) {
						setSlotHtml(data);
						if(data != null){
							//runAdsList(data[0].slotid, data[0].slottag);
						}				
					});			
		}
		
	});
	
	$(document).on("click", "a[name=cancelSlot]", function(e)
	{
		var slotid = $(this).attr("slotid");	
		$("#addslot"+slotid).remove();
	});
	
	$(document).on("click", "span[name=slotinfo]", function(e)
	{
		var slotid = $(this).attr("slotid");		
		var slotname = $(this).attr("slotname");		
		runAdsList(slotid, slotname);		
	});
	runAdsList = function(slotid, slotname){	
		//$("#slotDIV").css("height","400px");
		var ads_startdate = <%=ads.getStartdate()%>;
		var ads_enddate = <%=ads.getEnddate()%>;
			
		MasDwrService.getSlotRunAdsList(slotid, ads_startdate, ads_enddate,
			function(data) {
				var htmlstr = '';
				htmlstr += '<h6 class="title4 txtNavy"><span class="glyphicon glyphicon-menu-down mt10"></span> '+slotname+' 애즈 현황'+'</h6>';
				htmlstr += '<table class="listTable2">';
				htmlstr += '<colgroup><col width="*"><col width="20%"><col width="10%"><col width="6%"><col width="10%"><col width="6%"></colgroup>';
				htmlstr += '<thead>';
				htmlstr += '<tr style="height:20px"><th>애즈명</th><th>기간</th><th colspan="2">목표량</th><th colspan="2">보장량</th></tr>';
			    htmlstr += '</thead>';
				htmlstr += '<tbody>';
				
				if(data.length >0) 
				{
					for(var k=0; k<data.length; k++) {
						htmlstr += '<tr>';
						htmlstr += '<td class="textLeft">'+data[k].adsname+'</td>';
						htmlstr += '<td class="textCenter">'+getYMD(data[k].startdate,"-")+' ~ '+getYMD(data[k].enddate,"-")+'</td>';
						htmlstr += '<td class="textRight">'+addComma(data[k].goal_total)+'</td>';
						htmlstr += '<td class="textRight">('+data[k].goal_rate+'%)</td>';
						htmlstr += '<td class="textRight">'+addComma(data[k].book_total)+'</td>';
						htmlstr += '<td class="textRight">('+data[k].book_rate+'%)</td>';
						htmlstr += '</tr>';
					}
				} else {
					htmlstr += '<tr>';
					htmlstr += '<td class="textCenter" colspan="6">진행중인 애즈가 없습니다.</td>';
					htmlstr += '</tr>';
				} 
				htmlstr += '</tbody>';
				htmlstr += '</div>';
				$("#runAdsList").html(htmlstr);		
			});		
	};
	
	setSlotHtml = function(data) {
		var htmlstr = '';
		
		if(data.length >0) 
		{
			for(var k=0; k<data.length; k++) {
				htmlstr += '<tr>';
				htmlstr += '<td>';
				if(data[k].selected=='0') {
					htmlstr += '<input type="checkbox" name="ckpop_slot" onclick="checkSlot(this)"';
					htmlstr += ' id="chkBox'+data[k].slotid+'"'; 
					htmlstr += ' value="'+data[k].slotid+'"'; 
					htmlstr += ' sitename="'+data[k].sitename+'"'; 
					htmlstr += ' slotname="'+data[k].slotname+'"';  
					if($("#addslot"+data[k].slotid).length>0){
						htmlstr +=' checked';
					}
					htmlstr +='"/>';
				}
				htmlstr +='</td>';
				htmlstr += '<td>'+data[k].sitename+'</td>';
				htmlstr += '<td class="textLeft">';
				htmlstr +=data[k].slotname+'</td>';
				htmlstr += '<td class="textLeft">'+data[k].width+' x '+data[k].height+'</td>';
				htmlstr += '<td class="textLeft">';
				htmlstr += '<span name="slotinfo" slotid="'+data[k].slotid+'" slotname="'+data[k].slottag+'" role="button" class="point label label-primary" style="cursor:pointer; width:80px; margin-right:10px">애즈현황</span> ';
				
				
				
				
				htmlstr += data[k].slottag+'</td>';
				htmlstr += '</tr>';
			}
		} else {
			htmlstr += '<tr>';
			htmlstr += '<td colspan="5">조건에 맞는 위치가 없습니다.</td>';
			htmlstr += '</tr>';			
		}	
		$("#slotSearchList").html(htmlstr);
	}
	
	//광고위치 선택 시 하단 출력
	checkSlot = function(obj) {
		$("#change").val("change");
	
		var slotid = $(obj).val();
		var slotname = $(obj).attr("slotname");
		if($(obj).is(':checked')) {
			if($('#frmSlotPopup #addslot'+slotid).length==0){
				var str = '<tr id="addslot'+slotid+'">';
				str += '<td><a href="#" name="cancelSlot" slotid='+slotid+'><span class="glyphicon glyphicon-remove" style="width:30px"></span></a></td>';
				str += '<td class="textLeft">'+slotname+'<input type="hidden" name="slotid" value="'+slotid+'"/></td>';
				str += '</tr>';		
	           <!--td><button type="button" class="btn btn-default btn-xs">X</button></td-->
				$("#addSlotList").append( str );
			}
		}else {
			console.log("체크해제#addslot"+slotid);
			$("#addslot"+slotid).remove();
		}
	}
	//검색 위치 체크박스 전체 선택 
	$("#frmSlotPopup input:checkbox[name='ckpopall']").click(function(e){	
		var ischked = $(this).is(':checked');
		$("#frmSlotPopup [name='ckpop_slot']").prop("checked", ischked);			
		$("#frmSlotPopup input:checkbox[name=ckpop_slot]").each(function (i) {
			checkSlot($(this));
		});				
	});
	//팝업 광고위치 추가 저장
	$("#btnSlotRegist").on("click", function(e){		
		$("#frmSlotPopup input, #frmCrPopup select").css("border-color", "#ccc");
		e.preventDefault();
	
		if($("#frmSlotPopup [name=slotid]").size()==0){
			$("#frmSlotPopup #warningMsg").text("광고위치를 선택해 주세요.");
			return;
		} else {							
			//if(confirm("애즈에 광고물을 추가하시겠습니까?")) {
				$("#frmSlotPopup").submit();	
			//}
		}			
	});
	
	
	// 위치 상태 변경
	$("[name=btnSelState]").on("click", function(e){
		var state = $(this).attr("state");
	
	
		if($("#frmSlotMod input:checkbox[name=ckslot]:checked").length < 1){
			$("#frmSlotMod #warningMsg").text("위치를 선택해 주세요.");
 		} else{		
			var slotstr = "";
			$("#frmSlotMod input:checkbox[name=ckslot]:checked").each(function (i) {
				slotstr += $(this).attr("slotid")+",";
			});
			slotstr = slotstr.substring(0, slotstr.length-1);
			
			$("#frmSlotMod [name=slotstr]").val(slotstr);
			$("#frmSlotMod [name=slot_state]").val(state);
			
			if(confirm("위치 상태를 변경하시겠습니까?")){
				$("#frmSlotMod").submit();
			}			
		}
	});
	// 위치 삭제
	$("#btnSlotDel").on("click", function(e){
		if($("#frmSlotMod input:checkbox[name=ckslot]:checked").length < 1){
			$("#frmSlotMod #warningMsg").text("위치를 선택해 주세요.");
 		} else{		
			var slotstr = "";
			$("#frmSlotMod input:checkbox[name='ckslot']:checked").each(function (i) {
				slotstr += $(this).attr("slotid")+",";
			});
			slotstr = slotstr.substring(0, slotstr.length-1);
			$("#frmSlotDel [name=slotstr]").val(slotstr);
			
			if(confirm("선택한 위치를 삭제하시겠습니까?")){
				$("#frmSlotDel").submit();
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