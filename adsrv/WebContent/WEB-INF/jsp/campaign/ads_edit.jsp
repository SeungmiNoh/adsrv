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
	String mode = "E";
	String s_siteid = StringUtil.isNull(request.getParameter("s_siteid"));
	String s_secid = StringUtil.isNull(request.getParameter("s_secid"));
	String s_slotid = StringUtil.isNull(request.getParameter("s_slotid"));

	Map<String,Object> map = (Map<String,Object>)request.getAttribute("response");

	
	Campaign cp = (Campaign)map.get("cp");
	Ads ads = (Ads)map.get("ads");

	List<Ads> adslist = (List<Ads>)map.get("adslist"); 
	List<Map<String,String>> codelist = (List<Map<String,String>>)map.get("codelist");
	List<Map<String,String>> tglist = (List<Map<String,String>>)map.get("tglist");
	List<Creative> crlist = (List<Creative>)map.get("crlist");
	JSONArray target_data = JSONArray.fromObject(tglist);
	
	
	List<Map<String, String>> grouplist = (List<Map<String, String>>)map.get("grouplist");   
	List<Slot> slotlist = (List<Slot>)map.get("slotlist");   
	List<Map<String,String>> sitelist = (List<Map<String,String>>)map.get("sitelist");   
	List<Map<String,String>> seclist = (List<Map<String,String>>)map.get("seclist");   
	List<Slot> adsslotlist = (List<Slot>)map.get("adsslotlist");   
	List<Map<String, String>> ads_code = (List<Map<String, String>>)map.get("ads_code");   
	List<Map<String, String>> crstat_code = (List<Map<String, String>>)map.get("crstat_code");   
	
	JSONArray ads_code_data = JSONArray.fromObject(ads_code);
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
                    
                    <span class="txtBlue" style="font-size:9pt"><span class="glyphicon glyphicon-menu-right"></span> <%=ads.getAdsname() %> </span>  
                    </div>
                <div class="breadcrumbs"><span class="glyIcon"><img src="<%=web%>/img/navIcon.png" alt=""></span> 현재위치 : 캠페인  > 캠페인 정보 > 애즈 수정</div>
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
                        <td><%=StringUtil.addComma(cp.getBook_total()) %></td>
                        <th>목표량</th>
                        <td><%=StringUtil.addComma(cp.getGoal_total()) %></td>
                        <th>집행금액</th>
                        <td><%=StringUtil.addComma(cp.getBudget()) %></td>
                    </tr>
                    <tr>
                        <th>시작일</th>
                        <td><%=DateUtil.getYMD(cp.getStartdate(), "-") %></td>
                        <th>종료일</th>
                        <td><%=DateUtil.getYMD(cp.getEnddate(), "-") %></td>
                        <th>상태</th>
                        <td><span class="<%=cp.getText()%>"><%=StringUtil.isNull(cp.getCp_statename()) %></span></td>
                    </tr>
                </table>
                <br>
                <!-- view Table End -->
                <!-- campaign view End -->
                   <div class="boxtitle2">
                     <!-- title Start -->
                    <div class="taptitle">애즈</div>
                    <!-- title End -->
                   <div class="tapBox" >
                        <nav class="tapMenu">
                        <ul>
                              <li><a href="cpmgr.do?a=cpAdsList&cpid=<%=ads.getCpid()%>">애즈 목록 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <!--  
                           	    <li><a href="cpmgr.do?a=adsAddForm&cpid=<%=cp.getCpid() %>">애즈등록<span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>-->
                                <li><a href="cpmgr.do?a=adsInfo&adsid=<%=ads.getAdsid()%>" class="active">애즈 상세 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="cpmgr.do?a=adsEditTarget&adsid=<%=ads.getAdsid()%>">타겟팅<span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="cpmgr.do?a=adsEditCreative&adsid=<%=ads.getAdsid()%>">광고물 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>                               
                                <li><a href="cpmgr.do?a=adsEditSlot&adsid=<%=ads.getAdsid()%>">광고 위치<span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                </ul>
                        
                        <%--
                                <li><a href="cpmgr.do?a=cpAdsList&cpid=<%=ads.getCpid()%>">애즈 목록 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                           	    <li><a href="cpmgr.do?a=adsAddForm&cpid=<%=cp.getCpid() %>">애즈등록<span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="cpmgr.do?a=adsInfo&adsid=<%=ads.getAdsid()%>">애즈 정보 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="cpmgr.do?a=adsEdit&adsid=<%=ads.getAdsid()%>" class="active">애즈 수정 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li> 
                                 --%>                              
                            </ul>
                        </nav>
                    </div>
                    <div class="tapBox_ads">                   	
	 					<form id="frmAds" method="get" action="cpmgr.do">
		                <input type="hidden" name="a" value="<%=a %>"/>
		                <input type="hidden" name="adsid" value="<%=ads.getAdsid()%>"/>
		                <input type="hidden" name="cp_startdate" value="<%=cp.getStartdate() %>"/>
		                <input type="hidden" name="cp_enddate" value="<%=cp.getEnddate() %>"/>		                
	                    <select id="moveid" class="form-control input-sm" style="width:300px;">
<%

for(int k=0; k<adslist.size(); k++){
                                        
    Ads mads = adslist.get(k);
    
	 
 %>                     
                        <option value="<%=mads.getAdsid()%>" <%=ads.getAdsid().equals(mads.getAdsid())?"selected":"" %>><%=mads.getAdsname() %></option>
 <%} %>                 </select>
                		</form>         
                		
                    	</div>  
                </div>
                <!-- ads add title End -->
                <!-- ads add Table Start -->
<!--********************************************************************************************
                                          애즈 
**********************************************************************************************-->
<%@ include file="../campaign/ads_edit_info.jsp" %>
<!-- add Table End -->
<!--********************************************************************************************
                                          타겟팅 
**********************************************************************************************-->
                <div class="boxtitle3" style="width:900px;">                   
                    <h1 class="title4"><span class="glyphicon glyphicon-menu-down"></span> 타겟팅</h1>
                </div>
				<form id="frmTarget" action="cpmgr.do?a=adsTargetSave">
				<input type="hidden" name="a" value="adsTargetSave"/> 
 				<input type="hidden" name="adsid" value="<%=ads.getAdsid()%>"/> 
 				<input type="hidden" id="change" size=2/> 
                <table class="viewTable" style="width:900px;">
                    <colgroup>
                    <col width="10%">
                    <col width="40%">
                    <col width="10%">
                    <col width="40%">
                    </colgroup>                   
                    <tbody>
                                
 <%for(int i=0;i<codelist.size();i++){ 
	Map<String,String> code = codelist.get(i);
	
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
                                <input type="text" size=1 name="targettype" class="debug" value="<%= String.valueOf(code.get("isid"))%>"/>
                                 
                                <select id="target<%=String.valueOf(code.get("isid")) %>" name="tid" class="form-control input-sm" style="width:260px;"></select>
                                 
                                 </td>
                          
						 
<%} %>      
				<th></th>
				<td class="textRight">
				<span id="warningMsg" style="color:#a00"></span>
                <button type="button" class="btn btn-success btn-sm" id="btnTgRegist">수정</button>
                </td>
				</tr>                
                </tbody>
                </table>
                </form>
              
                <!-- targeting Table End -->
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
                     <input type="hidden" name="newClientid" value="<%=cp.getClientid() %>"/>
                     <input type="hidden" name="newClientname" value="<%=cp.getClientname() %>"/>                   
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
                            <td class="textLeft"><a href="cpmgr.do?a=crEdit&crid=<%=cr.getCrid()%>"><%=cr.getCrname() %></a></td>
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
                <input type="hidden" name="adsid" value="<%=ads.getAdsid()%>"/>
                <input type="hidden" name="slotstr" value=""/>
                </form>
                <form id="frmSlotMod" action="cpmgr.do?a=adsSlotUpdate" method="post">
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
            </section>
        </div>
    </div>
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
               <input type="hidden" id="clientid" value="<%=cp.getClientid()%>"/>
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
    <!-- /.modal -->

    <!-- modal End --> 
    
    
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
                <input type="hidden" name="a" value="adsCreativeSave"/>
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
   <script>

   
   
   

   
/********************* 화면 셋팅 *************************/   
$(document).ready(function() {
	
	
	
	
	// 공통
	$(".debug").css("display","none");	
	  $('.numinput').numberOnly();
   $("#clientid").val("<%=cp.getClientid()%>");
   
	
	
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
		
	

	$('#frmTarget select').on("change", function(e){	
		$("#frmTarget #change").val("change");
	});
	

	$("#btnTgRegist").on("click", function(e){		
		$("#frmTarget input, #frmTarget select").css("border-color", "#ccc");
		e.preventDefault();

		if($("#frmTarget #change").val() != "change"){
			alert("변경된 내용이 없습니다.");
			return;
		}else{		
				if(confirm("애즈 타겟팅 정보를 수정하시겠습니까?")) {
					$("#frmTarget").submit();	
				}
		}		
	});	
	
	
	
/**************************** 광고물  ******************************/
	

	$(".credit").attr("disabled", true);
	$(".credit").css("display","none");
		
	$(".ckcr").on("click", function(e){
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
	$(".ckcr_all").on("click", function(e){
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
  
<%
} catch(Exception e) {
    e.getMessage();
}
%> 

    
</body>

</html>
