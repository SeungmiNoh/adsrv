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
<%@page import="tv.pandora.adsrv.domain.Ads"%>    
<%@page import="tv.pandora.adsrv.domain.Creative"%>     
<%	
try
{
	String a = request.getParameter("a");
	
	Map<String,Object> map = (Map<String,Object>)request.getAttribute("response");

	
	
	Ads ads = (Ads)map.get("ads");

	
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
<!--********************************************************************************************
                                          애즈 
**********************************************************************************************-->
<div style="border: 0px solid #d3d2d2; padding:0px">
				<form id="frmAdsDel" method="post" role="form" action="cpmgr.do?a=modDelAds">
				<input type="hidden" id="adsid"  name="adsid" value="<%=ads.getAdsid() %>"/>
				<input type="hidden" id="cpid"  name="cpid" value="<%=ads.getCpid() %>"/>
				</form>
 				<form id="frmAdsCopy" method="post" role="form" action="cpmgr.do?a=adsCopy">
				<input type="hidden" id="adsid"  name="adsid" value="<%=ads.getAdsid() %>"/>
				</form>
                <form id="frmAdsInfo" method="post" role="form" action="cpmgr.do?a=adsRegist">
                <input type="hidden" name="cpid" value="<%=ads.getCpid() %>"/>
                <input type="hidden" id="change" size="4"/>
                <input type="hidden" id="adsid"  name="adsid" value="<%=ads.getAdsid() %>"/>
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
                            <th>애즈명</th>
                            <td class="form-inline" colspan="3">
                                <input type="text" name="adsname" id="adsname" class="form-control input-sm" value="<%=ads.getAdsname()%>" style="width:280px">
                            </td>
                            <th>광고상품</th>
                            <td class="form-inline">
                                <select id="prtype" name="prtype" class="form-control input-sm" style="width:100px;">
                                 </select>
                            </td>
                        </tr>
  						<tr>
                             <th>세일즈 구분</th>
                            <td class="form-inline">
                                <select id="salestype" name="salestype" class="form-control input-sm"  style="width:100px;">
                                </select>
                            </td>
                             <th>집행금액</th>
                            <td class="form-inline">
                                <input type="text" name="budget" id="budget" class="form-control input-sm numinput" style="width:160px; text-align:right">
                            </td>
                       		<th>상태</th>
                            <td class="form-inline">
                                <select id="ads_state" name="ads_state" style="width:100px" class="form-control input-sm" <%if(StringUtil.isNull(ads.getAdsid()).equals("")) {%>disabled="disabled"<%} %>>
                                 </select>
                            </td>
                        </tr>  
                        <tr>
                            <th>기간</th>
                            <td class="form-inline">
                                <label class="radio-inline"><input type="radio" name="period" value="1"> Period</label>
                                <label class="radio-inline"><input type="radio" name="period" value="0"> No Period</label>
                            </td>
                            <th>시작일</th>
                            <td class="form-inline">
                                <input type="text" id="start" class="start form-control nopad datepicker period" style="width:90px">                                
                                	<select id="start_hour" name="start_hour" class="form-control nopad input-sm period">
                                     <%for(int i=0;i<=23;i++){ %>
                                    <option value="<%=DateUtil.getMMStr(String.valueOf(i))%>" <%=ads.getStart_hour().equals(DateUtil.getMMStr(String.valueOf(i)))?"selected":""%>><%=DateUtil.getMMStr(String.valueOf(i))%>시</option>
                                    <%} %>
                                </select>
                                <select id="start_min" name="start_min" class="form-control nopad input-sm period">
                                       <%for(int i=0;i<6;i++){ %>
                                    <option value="<%=DateUtil.getMMStr(String.valueOf(i*10))%>" <%=ads.getStart_min().equals(DateUtil.getMMStr(String.valueOf(i*10)))?"selected":""%>><%=DateUtil.getMMStr(String.valueOf(i*10))%>분</option>
                                    <%} %>                                    
                                </select>
                                <input type="hidden" id="startdate" name="startdate" size=10/>
                            </td>
                             <th>종료일</th>
                            <td class="form-inline">
                                 <input type="text" id="end" class="end form-control nopad input-xs datepicker period" style="width:90px">                                
                                	<select id="end_hour" name="end_hour" class="form-control nopad input-sm period">
                                     <%for(int i=0;i<=24;i++){ %>
                                    <option value="<%=DateUtil.getMMStr(String.valueOf(i))%>"  <%=ads.getEnd_hour().equals(DateUtil.getMMStr(String.valueOf(i)))?"selected":""%>><%=DateUtil.getMMStr(String.valueOf(i))%>시</option>
                                    <%} %>
                                </select>
                                <select id="end_min" name="end_min" class="form-control nopad input-sm period">
                                      <%for(int i=0;i<6;i++){ %>
                                    <option value="<%=DateUtil.getMMStr(String.valueOf(i*10))%>"  <%=ads.getEnd_min().equals(DateUtil.getMMStr(String.valueOf(i*10)))?"selected":""%>><%=DateUtil.getMMStr(String.valueOf(i*10))%>분</option>
                                    <%} %>                                    
                                </select>
                                <input type="hidden" id="enddate" name="enddate" size=10/>
                         </td>
                        </tr>
                       <tr>
                            <th>목표타입</th>
                            <td class="form-inline">
                                <select id="goaltype" name="goaltype" class="form-control input-sm" style="width:100px">
                                </select>
                            </td>
                            <th><label class="goalText" id="goalText">노출</label> 보장량</th>
                            <td class="form-inline">
                                <input type="text" name="book_total" id="book_total" class="form-control input-sm numinput goal" style="width:160px; text-align:right" placeholder="보장량">                             
							</td>                            	
                            <th><label class="goalText">노출</label> 목표량</th>
                            <td class="form-inline">
                                <input type="text" name="goal_total" id="goal_total" class="form-control input-sm numinput goal" style="width:160px; text-align:right" placeholder="목표 노출량">                             
							</td>
   						</tr>
                         <tr>
  							<th>일 목표 노출량</th>
                            <td class="form-inline">
                                <input type="text" id="goal_daily" name="goal_daily" class="form-control input-sm numinput" style="width:160px; text-align:right" placeholder="일간 목표 노출량">
                            </td>                       
                            <th>최종수정일</th>
                            <td class="form-inline" id="updatedate"></td>
                        	<th>수정인</th>
                            <td class="form-inline" id="updateusername"></td>
                        </tr>  
                        <tr>
                        <th colspan="6" style="background-color:#f3f3f3">
                        <div class="buttonGroup">
                 	<span id="warningMsg" style="color:#a00"></span>
                    <button type="button" class="btn btn-success btn-sm" id="btnAdsSave">수정</button>
                    <button type="button" class="btn btn-warning btn-sm" id="btnAdsCopy">복사</button>
                     <a class="btn btn-default btn-sm" href="#none" name="btnAdsDel">삭제</a>
                    <a role="button" class="btn btn-default btn-sm" href="javascript:resetData()">리포트</a>
                	</div>
                	</th>
                        </tr>                    
                    </table>
                	
                </form>
</div>
<!--********************************************************************************************
                                          광고물 
**********************************************************************************************-->
               <div class="boxtitle3">
                    <!-- saveBtn Start -->
                    <div class="saveBtn4">
                        <a class="btn btn-default btn-sm" id="btnNewCr">신규 업로드</a> 
                        <a class="btn btn-danger btn-sm" href="#none" id="btnCrPopup" data-target="#myModal">광고물추가</a>
                    </div>
                    <form id="frmNewCr" action="cpmgr.do?a=crAddForm" method="post">   
                     <input type="hidden" name="a" value="crAddForm"/>
                     <input type="hidden" name="newClientid" value="<%=ads.getClientid() %>"/>
                     <input type="hidden" name="newClientname" value="<%=ads.getClientname() %>"/>                   
                    </form>
                    <!-- saveBtn End -->
                    <h1 class="title4"><span class="glyphicon glyphicon-menu-down"></span> 광고물</h1>
                </div>
                <!-- title End -->
                <!-- creative Table Start -->
                
                <form id="frmCrDel" action="cpmgr.do?a=adsCreativeDelete" method="post">
                <input type="hidden" name="adsid" value="<%=ads.getAdsid()%>"/>
                <input type="hidden" name="crstr" value=""/>
                </form>
                <form id="frmCrMod" action="cpmgr.do?a=adsCreativeUpdate" method="post">
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
                            <td class="textLeft"><a href="cpmgr.do?a=crView&crid=<%=cr.getCrid()%>"><%=cr.getCrname() %></a></td>
                            <td>
                            <input type="hidden" size=2 name="crid" value="<%=cr.getCrid()%>" class="credit"/>
                            <%=cr.getWidth() %> x <%=cr.getHeight() %>
                            </td>
                            <td class="form-inline">
                                <div class="info"><span class="txtBlack mr4"><%=DateUtil.getYMD(cr.getStartdate(),"-") %></span><%=DateUtil.getCutHH(cr.getStartdate())%>:<%=DateUtil.getCutMM(cr.getStartdate())%></div>
                                <div class="edit">
                                <input type="text" name="start" id="start<%=(k+1) %>" value="<%=DateUtil.getYMD(cr.getStartdate()) %>" class="start form-control nopad credit datepicker" style="width:70px">                                
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
                            	<input type="text" id="end<%=(k+1) %>" name="end" value="<%=DateUtil.getYMD(cr.getEnddate()) %>" class="end form-control nopad credit datepicker" style="width:70px">
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
 <script>
/********************* 화면 셋팅 *************************/   
$(document).ready(function() {
	// 공통
	$(".debug").css("display","none");	
	$(".credit").attr("disabled", true);
	$(".credit").css("display","none");
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
	
	
  	defaultDate = function() {
		$("#startdate").val("<%=ads.getStartdate()%>");
		$("#enddate").val("<%=ads.getEnddate()%>");
		$("#start").val("<%=DateUtil.getYMD(ads.getStartdate())%>");
		$("#start_hour").val("<%=ads.getStart_hour()%>");
		$("#start_min").val("<%=ads.getStart_min()%>");
		$("#end").val("<%=DateUtil.getYMD(ads.getEnddate())%>");
		$("#end_hour").val("<%=ads.getEnd_hour()%>");
		$("#end_min").val("<%=ads.getEnd_min()%>");
		$("#updatedate").html("<%=DateUtil.getYMDHM(ads.getUpdatedate(),"-")%>");
		$("#updateusername").html("<%=ads.getUpdateusername()%>");
	}
   resetData = function() {
		$("#adsname").val("<%=ads.getAdsname()%>");
		$("#salestype").val("<%=ads.getSalestype()%>");
		
		$("input:radio[name='period']:radio[value='<%=ads.getPeriod()%>']").prop('checked',true);
		
		$("#goaltype").val("<%=ads.getGoaltype()%>");
		$("#goal_total").val("<%=StringUtil.addComma(ads.getGoal_total())%>");
		$("#book_total").val("<%=StringUtil.addComma(ads.getBook_total())%>");
		$("#goal_daily").val("<%=StringUtil.addComma(ads.getGoal_daily())%>");
		$("#prtype").val("<%=ads.getPrtype()%>");
		$("#budget").val("<%=StringUtil.addComma(ads.getBudget())%>");
		$("#ads_state").val("<%=ads.getAds_state()%>");
		defaultDate();
	}
	
   
   
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
		}
	    setDate = function () {
			var startdate = delDash($("#start").val())+$("#start_hour").val()+$("#start_min").val();				
			var enddate = delDash($("#end").val())+$("#end_hour").val()+$("#end_min").val();
			$("#startdate").val(startdate);
			$("#enddate").val(enddate);
			
		}
		
		// 로딩시
		resetData();
		setGoaltype();		
		
		
});
		
	  


/************** 애즈 정보 옵션 제어 ******************/
	
	$('#frmAdsInfo').on("change", function(e){	
		$("#frmAdsInfo #change").val("change");
	});
	
	$("[name=period]").on("click", function(e){
		
		if($('input:radio[name="period"]:checked').val()==0){
			
			$("#start").val("<%--DateUtil.getYMD(cp.getStartdate())--%>");
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
	$("#btnAdsCopy").on("click", function(e){	
		if(confirm("애즈를 복사하시겠습니까?")) {								
			$("#frmAdsCopy").submit();
		}					
	});	
	$(document).on("click", "a[name=btnAdsDel]", function(e){
		if(confirm("애즈를 삭제하시겠습니까?")) {								
			$("#frmAdsDel").submit();
		}					
	});	
	$("#btnAdsSave").on("click", function(e){
		e.preventDefault();
		$("#frmAdsInfo input, #frmAdsInfo select").css("border-color", "#ccc");
		if($("#frmAdsInfo #change").val() != "change"){
			alert("변경된 내용이 없습니다.");
			return;
		}else if($.trim($("#adsname").val()).length==0){
			$("#adsname").css("border-color","red").focus();
			$("#warningMsg").text("애즈명을 입력해주세요.");
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
		}else if($.trim($("#budget").val()).length==0){
			$("#budget").css("border-color","red").focus();
			$("#warningMsg").text("집행 금액을 입력해주세요.");
			return;
		}else if($("#period").val()!=0 && delDash($("#end").val()) > $("[name=cp_enddate]").val()) {
			$("#end").css("border-color","red").focus();				
	      	$("#warningMsg").text("애즈 기간은 캠페인 기간을 벗어날 수 없습니다.");
			return;
	    }else if($.trim($("#goal_total").val()).length==0){
			$("#goal_total").css("border-color","red").focus();
			$("#warningMsg").text($("#goalText")+"목표량을 입력해주세요.");
			return;
		}else{
			setDate();
		}
		
		if(confirm("애즈 정보를 수정하시겠습니까?")){
			$('.numinput').onlyNumberDelComma();
			$("#frmAdsInfo").submit();					
		}
	});	
	
	
	
	
	
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
	
	$("#btnNewCr").click(function(e){		
		   $("#frmNewCr").target = "_new";
		   $("#frmNewCr").submit();
		   
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
					console.log("htmlstr="+htmlstr);
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
				$("#frmCrMod [name=startdate]").val(startdate);
				if (startdate < $("#frmAdsInfo input[name=startdate]").val()) {
					
					console.log(i+ "crid startdate = "+startdate);
					console.log(i+ "ads startdate = "+$("#frmAdsInfo input[name=startdate]").val());
					
					
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
					$("#frmCrMod [name=enddate]").val(enddate);
					if (enddate > $("#frmAdsInfo [name=enddate]").val()) {
						
						console.log(i+ "crid enddate = "+enddate);
						console.log(i+ "ads enddate = "+$("#frmAdsInfo input[name=enddate]").val());

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
	
	
		


  </script> 
<%
} catch(Exception e) {
    e.getMessage();
}
%> 

    
</body>

</html>
