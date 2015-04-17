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

	
	Campaign cp = (Campaign)map.get("cp");
	Ads ads = (Ads)map.get("ads");

	List<Ads> adslist = (List<Ads>)map.get("adslist"); 
	List<Map<String,String>> codelist = (List<Map<String,String>>)map.get("codelist");
	List<Map<String,String>> tglist = (List<Map<String,String>>)map.get("tglist");
	List<Creative> crlist = (List<Creative>)map.get("crlist");
	List<Slot> adsslotlist = (List<Slot>)map.get("adsslotlist");
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
	$(".debug").css("display","none");
	  $("#moveid").on("change", function(e){
			if($("#adsid").val()!= $("#moveid").val()) 
			{
				$("#frmAds input[name=adsid]").val($("#moveid").val());
				$("#frmAds").submit();
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

                <!-- ads add title Start -->
                <div class="boxtitle2">
                     <!-- title Start -->
                    <div class="title3">애즈</div>
                    <!-- title End -->
                    
                    <div class="tapBox">
                    
                        <nav class="tapMenu">
                            <ul>
                            <li class="adsBox">
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
                	</li>
                                <li><a href="cpmgr.do?a=cpAdsList&cpid=<%=ads.getCpid()%>">애즈 목록 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                           	    <li><a href="cpmgr.do?a=adsAddForm&cpid=<%=cp.getCpid() %>">애즈등록<span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                 <li><a href="cpmgr.do?a=adsInfo&adsid=<%=ads.getAdsid()%>" class="active">애즈 정보 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="cpmgr.do?a=adsEdit&adsid=<%=ads.getAdsid()%>">애즈 수정 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>                               
                               </ul>
                        </nav>
                    </div>
                </div>
                <!-- ads add title End -->
                <!-- ads add Table Start -->
                <form id="frmRegAds" method="post" role="form" action="cpmgr.do?a=adsRegist">
                <input type="hidden" name="cpid" value="<%=cp.getCpid() %>"/>
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
                                <%--
                    <select id="moveid" style="width:300px;">
<%

for(int k=0; k<adslist.size(); k++){
                                        
    Ads mads = adslist.get(k);
    
	 
%>                     
                        <option value="<%=mads.getAdsid()%>" <%=ads.getAdsid().equals(mads.getAdsid())?"selected":"" %>><%=mads.getAdsname() %></option>
 <%} %>                       
                    </select>                   
                                <a class="btn btn-danger btn-xs" href="cpmgr.do?a=adsAddForm&cpid=<%=cp.getCpid() %>" role="button" style="float:right;margin-left:5px;">애즈등록</a>
                                <a class="btn btn-success btn-xs" href="cpmgr.do?a=adsEdit&adsid=<%=ads.getAdsid() %>" role="button" style="float:right;margin-left:5px;">수정</a>
                            --%></td>
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
                    </table>
                </form>
<!-- add Table End -->
                <!-- targeting title -->
                <!-- title Start -->
                <div class="boxtitle3" style="width:800px;">
                    <!-- saveBtn Start 
                    <div class="saveBtn4" style="vertical-align:bottom;">
                        <a class="btn btn-success btn-xs" href="cpmgr.do?a=adsTargetForm&adsid=<%=ads.getAdsid()%>" role="button" >타겟팅등록</a>
                    </div>
                     saveBtn End -->
                    <h1 class="title4"><span class="glyphicon glyphicon-ok"></span> 타겟팅</h1>
                    <!-- title End -->
                </div>

<table class="viewTable" style="width:1000px;">
                    <colgroup>
                            <col width="10%">
                                <col width="40%">
                           <col width="10%">
                                <col width="40%">
                    </colgroup>                   
                    <tbody>
                                
 <%for(int i=0;i<tglist.size();i++){ 
	Map<String,String> code = tglist.get(i);
	
	if(i%2==0) {
		if(i>0) {
		%>
		</tr>
		<%} %>
		<tr>
		<%
	}
%>
                               <th><%=code.get("targettypename") %></th>
                                <td>
                                <input type="text" size=1 name="targettype" class="debug" value="<%= String.valueOf(code.get("targettype"))%>"/>
                                <%=StringUtil.isNull(code.get("targetname")) %>
                                <!-- 
                                <select id="target<%=String.valueOf(code.get("isid")) %>" name="tid" class="form-control input-sm" style="width:260px;"></select>
                                 -->
                                 </td>
                          
						 
<%} %>      
				<th></th>
				<td></td>
				</tr>                
                </tbody>
                </table>

                <!-- targeting Table End -->
                <!-- creative title -->
                <!-- title Start -->
                <div class="boxtitle3">
                    <h1 class="title4"><span class="glyphicon glyphicon-ok"></span> 광고물</h1>
                </div>
                <!-- title End -->
                <!-- creative Table Start -->
                <table class="listTable">
                   <colgroup>
                   <col width="5%">
                   <col width="5%">
                   <col width="20%">
                   <col width="10%">
                   <col width="10%">
                   <col width="10%">
                   <col width="10%">
                   <col width="">
                   <col width="10%">
                   </colgroup>
                   <thead>
                        <tr>
                            <th>No</th>
                            <th>광고상품</th>
                            <th>광고물명</th>
                            <th>사이즈</th>
                            <th>시작일</th>
                            <th>종료일</th>
                            <th>비중</th>
                            <th>상태</th>
                            <th>최종수정</th>
                            <th>등록인</th>
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
                            <td class="textLeft"><a href=javascript:newTab("<%=cr.getCrurl() %>")><span class="glyphicon glyphicon-download"></span></a>
                            <a href="cpmgr.do?a=crInfo&crid=<%=cr.getCrid()%>"><%=cr.getCrname() %></a></td>
                            <td><%=cr.getWidth() %> x <%=cr.getHeight() %></td>
                            <td><span class="txtBlack mr4"><%=DateUtil.getYMD(cr.getStartdate(),"-") %></span>
                                 <%=DateUtil.getCutHH(cr.getStartdate())%>:<%=DateUtil.getCutMM(cr.getStartdate())%>
                            </td>
                            <td><span class="txtBlack mr4"><%=DateUtil.getYMD(cr.getEnddate(),"-") %></span>
                                 <%=DateUtil.getCutHH(cr.getEnddate())%>:<%=DateUtil.getCutMM(cr.getEnddate())%>
                            </td>
                              <td><%=cr.getWeight() %></td>
                             <td><span class="<%=cr.getText() %>"><%=cr.getCr_statename() %></span></td>
                            <td><%=DateUtil.getYMDHM(cr.getUpdatedate(),".") %></td>
                            <td><%=cr.getUpdateusername()%></td>
                        </tr>
<%} if(crlist.size()==0){
%>

                        <tr>
                            <td colspan="10"> 광고물이 등록되지 않았습니다.
                            <!--  a class="btn btn-default btn-xs" href="cpmgr.do?a=adsCreative&adsid=<%=ads.getAdsid()%>" role="button" style="margin-left:5px;float:left;">등록</a-->
                            </td>                            
                        </tr> 
                        <%} %> 
                        </tbody>
                       </table>
                <!-- targeting Table End -->
                <!-- creative title -->
                <!-- title Start -->
                <div class="boxtitle3">
                    <h1 class="title4"><span class="glyphicon glyphicon-ok"></span> 광고 지면</h1>
                </div>
                <!-- title End -->
                <!-- creative Table Start -->
                 <table class="listTable">
                    <colgroup>
                    <col width="4%">
                    <col width="">
                    <col width="10%">
                    <col width="">
                    <col width="10%">
                    <col width="10%">
                    <col width="">
                    </colgroup>
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>위치</th>
                            <th>사이즈</th>
                            <th>위치 정보</th>
                            <th>상태</th>
                            <th>등록일</th>
                            <th>등록인</th>
                        </tr>
                    </thead>

                    <tbody>
 <%

 for(int k=0; k<adsslotlist.size(); k++){
     
		Slot slot = adsslotlist.get(k);
  %>                    
 						<tr id="adsSlot<%=slot.getSlotid()%>">
                            <td>
                               <%=k+1 %> 
                            </td>
                            <td class="textLeft"><%=slot.getSlottag()%></td>
                            <td><%=slot.getWidth() %> x <%= slot.getHeight()%></td>
                            <td class="textLeft"><%=slot.getSlottag() %></td>
                            <td class="<%=slot.getSlot_state().equals("1")?"txtRed":"txtBlue"%>"><%=slot.getSlot_state().equals("1")?"진행":"중지"%></span>
                            <td><%=DateUtil.getYMDHM(slot.getUpdatedate(),"-") %></td>
                           
                           <td><%=slot.getUpdateusername() %>
                           <%-- 
                           imp/<%=slot.getSitetag()%>/?adsid=<%=slot.getAdsid()%>&cpid=<%=cp.getCpid()%>
                           --%></td>
                           
                      </tr>
<%} if(adsslotlist.size()==0){
%>

                        <tr>
                            <td colspan="7"> 위치가 등록되지 않았습니다.</td>                            
                        </tr> 
                        <%} %> 
                        </tbody>
                       </table>
                <!-- targeting Table End -->
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
