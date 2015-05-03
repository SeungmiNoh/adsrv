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
	String adsid = (String)map.get("adsid");
	String adsname = (String)map.get("adsname");
	
	Campaign cp = (Campaign)map.get("cp");

	List<Ads> adslist = (List<Ads>)map.get("adslist"); 
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
                                 <li><a href="cpmgr.do?a=adsInfo&adsid=<%=adsid%>">애즈 목록<span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="cpmgr.do?a=adsInfo&adsid=<%=adsid%>">애즈 상세 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="cpmgr.do?a=adsInfo&adsid=<%=adsid%>">타겟팅<span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="cpmgr.do?a=adsEdit&adsid=<%=adsid%>" class="active">광고물 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>                               
                                <li><a href="cpmgr.do?a=adsInfo&adsid=<%=adsid%>">광고 위치<span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                             </ul>
                        </nav>
                    </div>
                    <div class="tapBox_ads">                   	
	 					<form id="frmAds" method="get" action="cpmgr.do">
		                <input type="hidden" name="a" value="<%=a %>"/>
		                <input type="hidden" name="adsid" value="<%=adsid%>"/>
		                <input type="hidden" name="cp_startdate" value="<%=cp.getStartdate() %>"/>
		                <input type="hidden" name="cp_enddate" value="<%=cp.getEnddate() %>"/>		                
	                    <select id="moveid" class="form-control input-sm" style="width:300px;">
<%

for(int k=0; k<adslist.size(); k++){
                                        
    Ads mads = adslist.get(k);
    
	 
 %>                     
                        <option value="<%=mads.getAdsid()%>" <%=adsid.equals(mads.getAdsid())?"selected":"" %>><%=mads.getAdsname() %></option>
 <%} %>                 </select>
                		</form>         
                		
                    	</div>  
                </div>				
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
