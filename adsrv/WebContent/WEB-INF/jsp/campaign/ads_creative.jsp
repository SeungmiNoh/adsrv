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
<%	
try
{
	
	String a = request.getParameter("a");
	
	Map<String,Object> map = (Map<String,Object>)request.getAttribute("response");

	
	Campaign cp = (Campaign)map.get("cp");
	Ads ads = (Ads)map.get("ads");

	List<Ads> adslist = (List<Ads>)map.get("adslist"); 
	List<Creative> crlist = (List<Creative>)map.get("crlist");
	List<Map<String, String>> codelist = (List<Map<String, String>>)map.get("codelist");   
	
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
	<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
  	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
	<link rel="stylesheet" href="/resources/demos/style.css">
  
 <script type="text/javascript" src="<%=web%>/dwr/engine.js"></script>
<script type="text/javascript" src="<%=web%>/dwr/util.js"></script>
<script type="text/javascript" src="<%=web%>/dwr/interface/MasDwrService.js"></script>
  <script src="<%=web%>/js/bootstrap.js"></script>
  <script src="<%=web%>/js/basic.js"></script>
 <script src="<%=web%>/js/common.js"></script>
  
  
<script>
function addCreative(obj) {
	$("#change").val("change");

	var crid = $(obj).val();
	var crname = $(obj).attr("crname");
	if($(obj).is(':checked')) {
		if($('#add'+crid).length==0){
			var str = '<tr id="add'+crid+'">';
			str += '<td><a href="#" name="btnSecRemove" crid='+crid+'><span class="glyphicon glyphicon-remove" style="width:30px"></span></a></td>';
			str += '<td>'+crname+'<input type="hidden" name="crid" value="'+crid+'"/></td>';
			str += '</tr>';		
           <!--td><button type="button" class="btn btn-default btn-xs">X</button></td-->
			$("#addList").append( str );
		}
	}else {
		$("#add"+crid).remove();
	}
}/*
$(document).ready(function() {
	
	
	$("[name=start]").datepicker({
		dateFormat: 'yy-mm-dd',
		changeMonth:true,
		changeYear:true,
		onClose: function(selectDate){
				$("[name=enddate]").datepicker("option","minDate",selectDate);
				console.log("minDate");
				$(this).trigger("change");
		}
});
$("[name=end]").datepicker({
		dateFormat: 'yy-mm-dd',
		changeMonth:true,
		changeYear:true,
		onClose: function(selectDate){
				$("[name=startdate]").datepicker("option","maxDate",selectDate);
				$(this).trigger("change");
		}
});

	$(".start").datepicker({
		dateFormat: 'yy-mm-dd',
		changeMonth:true,
		changeYear:true,
		onClick: function(selectDate){
			alert("dd");
			var datagrp = $(this).attr('data-grp');
			console.log("datagrp="+datagrp);
				$(".end[data-grp='" + datagrp + "']").datepicker("option","minDate",selectDate);					
				//$(this).trigger("change");
		},
		onClose: function(selectDate){
			alert("dd");
			var datagrp = $(this).attr('data-grp');
			console.log("datagrp="+datagrp);
				$(".end[data-grp='" + datagrp + "']").datepicker("option","minDate",selectDate);					
				$(this).trigger("change");
		}
	});
	$(".end").datepicker({
		dateFormat: 'yy-mm-dd',
		changeMonth:true,
		changeYear:true,
		onClose: function(selectDate){
			var datagrp = $(this).attr('data-grp');
			console.log("datagrp="+datagrp);
				$(".start[data-grp='" + datagrp + "']").datepicker("option","maxDate",selectDate);
				$(this).trigger("change");
				
		}
	});
});	*/
	
$(function(){
	$(".debug").css("display","none");
	$('.numinput').numberOnly();
	$("#clientid").val("<%=cp.getClientid()%>");
	
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
			showOn: "button",
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
	
	$("input:checkbox[name='ckall']").click(function(e){	
		var ischked = $(this).is(':checked');
		$("input:checkbox[name='ckslot']").prop("checked", ischked);	
		for(var i=0; i<$("input:checkbox[name='ckslot']").length; i++){
			addCreative($("input:checkbox[name='ckslot']").eq(i));		
		}
	});	
	$("#btnPopup").click(function(e){	
		$("#searchList").html("");
		$("#addList").html("");

		
		e.preventDefault();
		$('#myModal').modal();
		$(".modify").css("display", "none");
		$(".new").css("display", "");
		$(".debug").val(""); //값 초기화	 (siteid, change)	
		console.log("s_start="+$("#s_start").val());
		var start = $("#s_start").val();
		var end = $("#e_end").val();
		var clientid = $("#clientid").val();
		
		
		MasDwrService.getCrList(start, end, clientid,
		   		function(data) {
					var htmlstr = '';
					
					if(data.length >0) 
					{
						for(var k=0; k<data.length; k++) {
							htmlstr += '<tr>';
							htmlstr += '<td><input type="checkbox" name="ckslot" onclick="  addCreative(this)"';
							htmlstr += ' id="chkBox'+data[k].crid+'"'; 
							htmlstr += ' value="'+data[k].crid+'"'; 
							htmlstr += ' crname="'+data[k].crname+'"'; 
							//if($('#add'+data[k].crid).length>0) {
							//	htmlstr += ' checked';
							//}
							htmlstr +='"/>';
							htmlstr +='</td>';
							htmlstr += '<td>'+data[k].prtypename+'</td>';
							htmlstr += '<td class="textLeft">'+data[k].crname+'</td>';
							htmlstr += '<td class="textLeft">'+data[k].width+' x '+data[k].height+'</td>';
							htmlstr += '<td class="textLeft">'+data[k].insertdate+'</td>';
							htmlstr += '<td class="textLeft">'+data[k].insertusername+'</td>';
							htmlstr += '<td class="textLeft"><button type="button" class="btn btn-success btn-xs">보기</button></td>';
							htmlstr += '</tr>';							
						}
					} else {
						htmlstr += '<tr>';
						htmlstr += '<td colspan="7 ">조건에 맞는 광고물이 없습니다.</td>';
						htmlstr += '</tr>';
						
					}
					console.log("htmlstr="+htmlstr);
					$("#searchList").append(htmlstr);
			});
	});
	
	  
	  
		$("#btnSearch").click(function(e){		
			var width = $("#width").val();
			var height = $("#height").val();
			var start = $("#start").val();
			var end = $("#end").val();
			var clientid = $("#clientid").val();
			
			$("#searchList").html("");
			
		
		});	

		$('#frmRegist select').change(function(e){	
			$("#change").val("change");
		});
		
		$("#btnRegist").on("click", function(e){		
			$("#frmRegist input, #frmRegist select").css("border-color", "#ccc");
			e.preventDefault();
		
			if($("[name=crid]").size()==0){
				$("#warningMsg").text("광고물을 선택해 주세요.");
				return;
			}else{							
					//if(confirm("애즈에 광고물을 추가하시겠습니까?")) {
						$("#frmRegist").submit();	
					//}
			}			
		});
	});

$("#moveid").on("change", function(e){
	if($("#adsid").val()!= $("#moveid").val()) 
	{
		$("#frmAds input[name=adsid]").val($("#moveid").val());
		$("#frmAds").submit();
	}
	
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
                    <div class="title">애즈 상세 정보</div>
                    <div class="breadcrumbs"><span class="glyIcon"><img src="<%=web%>/img/navIcon.png" alt=""></span> 현재위치 : 캠페인 > 캠페인 정보</div>
                    <!-- title End -->
                </div>      
                <table class="viewTable" style="width:900px">
				<colgroup>
				<col width="10%">
				<col width="23%">
				<col width="10%">
				<col width="23%">
				<col width="10%">
				<col width="">
				</colgroup>
                    <tr>
                        <th>캠페인명</th>
                        <td colspan="3"><%=cp.getCpname() %></td>
                        <th>담당자</th>
                        <td><%=cp.getTcname() %></td>
                    </tr>
                    <tr>
                        <th>광고주</th>
                        <td><%=cp.getClientname() %></td>
                        <th>대행사</th>
                        <td><%=StringUtil.isNull(cp.getAgencyname()) %></td>
                        <th>미디어렙</th>
                        <td><%=StringUtil.isNull(cp.getMedrepname()) %></td>
                    </tr>
                    <tr>
                        <th>보장량</th>
                        <td></td>
                        <th>목표량</th>
                        <td></td>
                        <th>집행금액</th>
                        <td><%=StringUtil.addComma(cp.getBudget()) %></td>
                    </tr>
                    <tr>
                        <th>시작일</th>
                        <td><%=DateUtil.getYMD(cp.getStartdate(), "-") %></td>
                        <th>종료일</th>
                        <td><%=DateUtil.getYMD(cp.getEnddate(), "-") %></td>
                        <th>상태</th>
                        <td></td>
                    </tr>
                </table>
                <br>
                <!-- view Table End -->
                <!-- campaign view End -->
                <!-- select ads Start -->
                <div class="adsBox">
 	                <form id="frmAds" method="get" action="cpmgr.do">
	                <input type="hidden" name="a" value="<%=a %>"/>
	                <input type="hidden" name="adsid"/>
	                    <select id="moveid" class="form-control input-sm" style="width:300px;">
<%

for(int k=0; k<adslist.size(); k++){
                                        
    Ads mads = adslist.get(k);
    
	 
 %>                     
                        <option value="<%=mads.getAdsid()%>" <%=ads.getAdsid().equals(mads.getAdsid())?"selected":"" %>><%=mads.getAdsname() %></option>
 <%} %>                 </select>
                	</form>                
               	</div>

                <!-- select ads End -->
                <!-- ads add title Start -->
                <div class="boxtitle2">
                     <!-- title Start -->
                    <div class="title3">애즈</div>
                    <!-- title End -->
                    <div class="tapBox">
                        <nav class="tapMenu">
                            <ul>
                                <li><a href="cpmgr.do?a=cpAdsList&cpid=<%=ads.getCpid()%>">캠페인 상세 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="cpmgr.do?a=adsInfo&adsid=<%=ads.getAdsid()%>">애즈 정보 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="cpmgr.do?a=adsTarget&adsid=<%=ads.getAdsid()%>" >타겟팅 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="cpmgr.do?a=adsCreative&adsid=<%=ads.getAdsid()%>" class="active">광고물 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="cpmgr.do?a=adsSlot&adsid=<%=ads.getAdsid()%>">광고지면 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
                <!-- ads add title End -->
                <!-- ads add Table Start -->
                <input type="hidden" name="cpid" value="<%=cp.getCpid() %>"/>
                    <%--
                    <table class="viewTable">
                        <colgroup>
                        <col width="9%">
                        <col width="22%">
                        <col width="9%">
                        <col width="24%">
                        <col width="9%">
                        <col width="27%">
                        </colgroup>
                        <tr>
                            <th>애즈명</th>
                            <td colspan="3">
                                <%=ads.getAdsname()%>
                                <input type="hidden" id="adsid" value="<%=ads.getAdsid()%>"/>
                            </td>
                            <th>판매방식</th>
                            <td>
                                <%=ads.getSalestypename() %>
                            </td>
                        </tr>
                        <tr>
                            <th>기간</th>
                            <td>
                                <%=ads.getPeriod().equals("0")?"No ":"" %>Period
                            </td>
                            <th>시작일</th>
                            <td>
                                <%=DateUtil.getYMD(ads.getStartdate()) %> (<%=ads.getStart_hour()%>시 <%=ads.getStart_min() %>분)
                            </td>
                            <th>종료일</th>
                            <td>
                                <%=DateUtil.getYMD(ads.getEnddate()) %> (<%=ads.getEnd_hour() %>시 <%=ads.getEnd_min() %>분)
                            </td>
                        </tr>
                       <tr>
                             <th>목표타입</th>
                            <td>
                                <%=ads.getGoaltypename() %>
                            </td>	
                            <th><label id="goalText">노출 목표량</label></th>
                            <td>
                               <%=StringUtil.addComma(ads.getGoal_total()) %>
							</td>
                             <th>일 목표 노출량</th>
                            <td>
                                <%=StringUtil.addComma(ads.getGoal_daily()) %>
                            </td>
   						</tr>
                         
   						<tr>
                             
                           <th>광고상품</th>
                            <td>
                                <%=ads.getPrtypename() %>
                            </td>
                              <th>집행금액</th>
                            <td>
                                <%=StringUtil.addComma(ads.getBudget()) %>
                            </td>
                            <th><label id="goalText">보장량</label></th>
                            <td>
                                <%=StringUtil.addComma(ads.getBook_total()) %>                             
							</td>
                        </tr>  
                        <tr>
                        <th>상태</th>
                            <td>
                                <%=ads.getAds_statename() %>
                            </td>
                                          
                        <th>수정일</th>
                            <td>
                                <%=DateUtil.getYMDHM(ads.getUpdatedate(),".") %>
                            </td>
                                            
                        <th>최종수정</th>
                            <td>
                                <%=DateUtil.getYMD(ads.getUpdateusername()) %>
                            </td>
                        </tr>                      
                    </table> --%>
                <!-- add Table End -->
                <br>
                <!-- creative title -->
                <!-- title Start -->
                <div class="boxtitle3">
                    <!-- saveBtn Start -->
                    <div class="saveBtn4">
                        <a class="btn btn-default btn-sm" href="#none" id="btnPopup" data-target="#myModal">추가</a>
                        <a class="btn btn-default btn-sm" href="#" role="button" data-toggle="modal" data-target=".bs-example-modal-lg">신규 업로드</a>
                    </div>
                    <!-- saveBtn End -->
                    <h1 class="title4"><span class="glyphicon glyphicon-ok"></span> 광고물</h1>
                </div>
                <!-- title End -->
                <!-- creative Table Start -->
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
                            <th></th>
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
                    
                    
                        <tr>
                            <td><%=(k+1) %></td>
                            <td class="textCenter"><%=cr.getPrtypename() %></td>
                            <td class="textLeft"><a href="cpmgr.do?a=crView&crid=<%=cr.getCrid()%>"><%=cr.getCrname() %></a></td>
                            <td><%=cr.getWidth() %> x <%=cr.getHeight() %></td>
                            <td class="form-inline">
                                <input type="text" id="start<%=(k+1) %>" datagrp="<%=(k+1) %>" name="startdate" value="<%=DateUtil.getYMD(cr.getStartdate()) %>" class="start form-control input-xs datepicker" style="width:70px">                                
                               	<select id="start_hour" name="start_hour" class="form-control input-xs period" style="width:48px">
                                     <%for(int i=0;i<=23;i++){ %>
                                    <option value="<%=String.valueOf(i)%>" <%=DateUtil.getCutHH(cr.getStartdate()).equals(String.valueOf(i))?"selected":""%>><%=DateUtil.getMMStr(String.valueOf(i))%></option>
                                    <%} %>
                                </select>
                                <select id="start_min<%=(k+1) %>" name="start_min" class="form-control input-xs period" style="width:48px">
                                       <%for(int i=0;i<6;i++){ %>
                                    <option value="<%=String.valueOf(i*10)%>" <%=DateUtil.getCutMM(cr.getStartdate()).equals(String.valueOf(i))?"selected":""%>><%=DateUtil.getMMStr(String.valueOf(i*10))%></option>
                                    <%} %>                                    
                                </select>
                            </td>
                            <td class="form-inline">
                            	<input type="text" id="end<%=(k+1) %>" datagrp="<%=(k+1) %>" name="enddate" value="<%=DateUtil.getYMD(cr.getEnddate()) %>" class="end form-control input-xs datepicker" style="width:70px">
                               	<select id="end_hour" name="end_hour" class="form-control input-xs period" style="width:48px">
                                    <%for(int i=0;i<=24;i++){ %>
                                   <option value="<%=String.valueOf(i)%>" <%=DateUtil.getCutHH(cr.getEnddate()).equals(String.valueOf(i))?"selected":""%>><%=DateUtil.getMMStr(String.valueOf(i))%></option>
                                   <%} %>
                               </select>
                                <select id="end_min" name="end_min" class="form-control input-xs period" style="width:48px">
                                      <%for(int i=0;i<6;i++){ %>
                                    <option value="<%=String.valueOf(i*10)%>" <%=DateUtil.getCutMM(cr.getEnddate()).equals(String.valueOf(i))?"selected":""%>><%=DateUtil.getMMStr(String.valueOf(i*10))%></option>
                                    <%} %>                                    
                                </select>
                            </td>
                            <td class="textCenter"><input type="text" name="weight" value="<%=cr.getWeight() %>" class="form-control input-xs numinput" style="width:40px;" ></td>
                            <td>
                            <select name="cp_state" class="form-control input-xs" style="width:60px">
                            <%for(int i=0;i<codelist.size(); i++){
                            	Map<String,String> code = codelist.get(i);
                            %>
                                <option value="<%=String.valueOf(code.get("isid"))%>"  <%=cr.getCr_state().equals(String.valueOf(code.get("isid")))?"selected":""%>><%=code.get("isname") %></option>
                            <%} %>
                           </select>
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
                <!-- targeting Table End -->
                <!-- creative title -->
            </section>



        </div>
    </div>
    
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
                <div class="modal-body">
                    <!-- search form Start -->
                    <form id="frmRegist" method="post" class="form-inline" action="cpmgr.do?a=adsCreativeSave">
                    <input type="hidden" name="a" value="adsCreativeSave"/>
                    <input type="hidden" id="clientid" value="<%=cp.getClientid()%>"/>
                    <input type="hidden" name="adsid" value="<%=ads.getAdsid() %>"/>
                    <input type="hidden" name="ads_startdate" value="<%=ads.getStartdate() %>"/>
                    <input type="hidden" name="ads_enddate" value="<%=ads.getEnddate() %>"/>
                    <input type="hidden" name="ads_realenddate" value="<%=ads.getRealenddate() %>"/>
                    
                    <div class="form-group">
                            <label>기간</label>
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
                        <col width="10%">
                        <col width="20%">
                        <col width="20%">
                        <col width="">
                        <col width="10%">
                        <col width="10%">
                        </colgroup>
                        <thead>
                            <tr>
                                <th><input type="checkbox" id="ckall" name="ckall"/></th>
                                <th>광고상품</th>
                                <th>광고물 명</th>
                                <th>사이즈</th>
                                <th>등록일</th>
                                <th>등록자</th>
                                <th>미리보기</th>
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
                    </form>                   
                    <!-- check table End -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" id="btnRegist">저장</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->

    <!-- modal End -->
<%
} catch(Exception e) {
    e.getMessage();
}
%> 

    
</body>

</html>
