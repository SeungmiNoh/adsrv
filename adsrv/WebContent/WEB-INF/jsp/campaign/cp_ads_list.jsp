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
	
	Map<String,Object> map = (Map)request.getAttribute("response");

	Campaign cp = (Campaign)map.get("cp");
	List<Ads> adslist = (List<Ads>)map.get("adslist"); 
	List<Creative> crlist = (List<Creative>)map.get("crlist"); 
	List<Map<String, String>> targetlist = (List<Map<String, String>>)map.get("targetlist"); 
	List<Map<String, String>> adsslotlist = (List<Map<String, String>>)map.get("adsslotlist"); 	
	
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
 

</head>

<body>
    <div class="container-fluid containerBg">
        <div class="containerBox">
        <%@ include file="../common/header.jsp"  %>
            <section class="sectionBox">
                <div class="boxTitle">
                    <!-- title Start -->
                    <div class="title">캠페인 상세 정보</div>
                    <div class="breadcrumbs"><span class="glyIcon"><img src="<%=web%>/img/navIcon.png" alt=""></span> 현재위치 : 캠페인 > 캠페인 애즈 목록</div>
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
                <div class="buttonGroup" style="width:900px">
                                         
                </div>
               
                <!-- view Table End -->
                <!-- campaign view End -->
                <!-- ads add Table Start -->

                
                <%--
                <!-- ads add title Start -->
                <div class="boxtitle2">
                     <!-- title Start -->
                    <div class="title3">애즈</div>
                    <!-- title End -->
                    <div class="tapBox">
                        <nav class="tapMenu">
                            <ul>
                               <li><a href="<%if(!cp.getMax_adsid().equals("0")){%>cpmgr.do?a=adsInfo&adsid=<%=cp.getMax_adsid() %><%}else{ %>#none<%} %>" class="active">캠페인 상세<span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="<%if(!cp.getMax_adsid().equals("0")){%>cpmgr.do?a=adsInfo&adsid=<%=cp.getMax_adsid() %><%}else{ %>#none<%} %>">애즈 정보 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="<%if(!cp.getMax_adsid().equals("0")){%>cpmgr.do?a=adsTarget&adsid=<%=cp.getMax_adsid() %><%}else{ %>#none<%} %>">타겟팅 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="<%if(!cp.getMax_adsid().equals("0")){%>cpmgr.do?a=adsCreative&adsid=<%=cp.getMax_adsid() %><%}else{ %>#none<%} %>">광고물 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="<%if(!cp.getMax_adsid().equals("0")){%>cpmgr.do?a=adsSlot&adsid=<%=cp.getMax_adsid() %><%}else{ %>#none<%} %>">광고지면 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div> --%>
                <!--                        <a class="btn btn-danger" href="cpmgr.do?a=adsAddForm&cpid=<%=cp.getCpid() %>" role="button">애즈등록</a>
  -->
                <!-- ads add title End -->
                
                
                
                
                  <div class="boxtitle2">
                     <!-- title Start -->
                    <div class="title3">애즈</div>
                    <!-- title End -->
                    
                    <div class="tapBox">
                    
                        <nav class="tapMenu">
                            <ul>  
                               <li><a href="cpmgr.do?a=adsAddForm&cpid=<%=cp.getCpid() %>">애즈등록<span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="#none" class="active">애즈 목록<span class="glyphicon glyphicon-menu-right"></span></a>
                               </li>
                                <li><a href="<%if(!cp.getMax_adsid().equals("0")){%>cpmgr.do?a=adsInfo&adsid=<%=cp.getMax_adsid() %><%}else{ %>#none<%} %>">애즈 정보 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="<%if(!cp.getMax_adsid().equals("0")){%>cpmgr.do?a=adsEdit&adsid=<%=cp.getMax_adsid() %><%}else{ %>#none<%} %>">애즈 수정 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>                               
                            </ul>
                        </nav>
                    </div>
                </div>
                
                
                
                
                
                <table class="listTable" style="width:1200px">
 				<colgroup>
				<col width="40">
				<col width="240"><!-- 애즈명 -->
				<col width="100"><!-- 시작일 -->
				<col width="100"><!-- 종료일 -->
				<col width="80"><!-- 집행금액 -->
				<col width="80"><!-- 보장량량 -->
				<col width="80"><!-- 목표량 -->
				<col width="80"><!-- 노출 -->
				<col width="60"><!-- 달성율 -->
				<col width="80"><!-- 클릭 -->
				<col width="40"><!-- CTR -->
			    <col width="80"><!-- 등록일 -->
				<col width="60"><!-- 담당자 -->
				<col width="40"><!-- 상태 -->	
					</colgroup>                   
	                    <thead>
                        <tr>
                            <th>No</th>
                            <th>애즈명</th>
                            <th>시작일</th>
                            <th>종료일</th>
                            <th>집행금액</th>
                            <th>보장량</th>
                            <th>목표량</th>
                            <th>노출</th>
                            <th>달성율</th>
                            <th>클릭</th>
                            <th>CTR</th>
                            <th>상태</th>
                        </tr>
                    </thead>
                    <tbody>
<%

for(int k=0; k<adslist.size(); k++){
                                        
    Ads ads = adslist.get(k);
    
	 
 %>                        <tr>
                            <td><%=k+1 %></td>
                            <td class="textLeft"><span style="width=60px"></span><a href="cpmgr.do?a=adsInfo&adsid=<%=ads.getAdsid()%>" class="<%=ads.getText()%>"><%=ads.getAdsname() %></a></td>
                            <td><%=DateUtil.getYMD(ads.getStartdate()) %> <%=ads.getStart_hour() %>:<%=ads.getStart_min()%></td>
                            <td><%=DateUtil.getYMD(ads.getEnddate()) %> <%=ads.getEnd_hour() %>:<%=ads.getEnd_min()%></td>
                            <td class="textRight"><%=StringUtil.addComma(ads.getBudget()) %></td>
                            <td class="textRight"><%=StringUtil.addComma(ads.getBook_total()) %></td>
                            <td class="textRight"><%=StringUtil.addComma(ads.getGoal_total()) %></td>
                            <td class="textRight">3,333,333</td>
                            <td class="textRight">101%</td>
                            <td class="textRight">33,333</td>
                            <td class="textRight">0.24%</td>
                            <td><a href="cpmgr.do?a=adsEdit&adsid=<%=ads.getAdsid()%>" class="<%=ads.getText()%>"><span class="<%=ads.getText()%>"><%=ads.getAds_statename() %></span></a></td>
                        </tr>
 <%} %>                     
 				</tbody>
                </table>
                <!-- list Table End -->
                <!-- ads list End -->
                <!-- target list Start -->
                <div class="boxtitle2">                    
                     <!-- 2th title Start -->
                    <h2 class="title3">타겟팅</h2>
                    <!-- 2th title End -->
                </div>
                <!-- list Table Start -->
                <table class="listTable" style="width:1200px">
 				<colgroup>
				<col width="40">
				<col width="240"><!-- 애즈명 -->
				<col width="120"><!-- 타겟팅구분 -->
				<col width="240"><!-- 타겟팅명 -->
				<col width="100"><!-- 등록일 -->
				<col width="100"><!-- 등록인 -->
					</colgroup>                   
	                    <thead>
                        <tr>
                            <th>No</th>
                            <th>애즈명</th>
                            <th>타겟팅구분</th>
                            <th>타겟팅명</th>
                            <th>등록일</th>
                            <th>등록인</th>
                        </tr>
                    </thead>
                    <tbody>
<%

for(int k=0; k<targetlist.size(); k++){
                                        
    Map<String,String> target = targetlist.get(k);
    
	 
 %>                        	<tr>
                            <td><%=k+1 %></td>
                            <td><%=target.get("adsname")%></td>
                            <td class="textLeft"><%=target.get("targettypename") %></td>
                            <td class="textLeft"><a href="cpmgr.do?a=targetView&tid=<%=String.valueOf(target.get("tid"))%>"><%=target.get("targetname") %></a></td>
                            <td><%=DateUtil.getYMDHM(String.valueOf(target.get("updatedate")),"-")%></td>
                            <td><%=target.get("updateusername")%></td>
                        	</tr>
 <%} %>                     
 				</tbody>
                </table>
                <!-- list Table End -->
                <!-- creative list End -->                 <!-- creative list Start -->
                <div class="boxtitle2">                    
                    <!-- 2th title Start -->
                    <h2 class="title3">광고물</h2>
                    <!-- 2th title End -->
                </div>
                <!-- list Table Start -->
                <table class="listTable" style="width:1200px">
 				<colgroup>
				<col width="40">
				<col width="240"><!-- 광고물명 -->
				<col width="240"><!-- 애즈명 -->
				<col width="120"><!-- 사이즈 -->
				<col width="100"><!-- 시작일시 -->
				<col width="100"><!-- 종료일시 -->
				<col width="40"><!-- 상태 -->	
					</colgroup>                   
	                    <thead>
                        <tr>
                            <th>No</th>
                            <th>애즈명</th>
                            <th>광고물명</th>
                            <th>사이즈</th>
                            <th>시작일</th>
                            <th>종료일</th>
                             <th>상태</th>
                        </tr>
                    </thead>
                    <tbody>
<%

for(int k=0; k<crlist.size(); k++){
                                        
    Creative cr = crlist.get(k);
    
	 
 %>                        <tr>
                            <td><%=k+1 %></td>
                            <td class="textLeft"><%=cr.getAdsname() %></td>
                            <td class="textLeft"><a href="cpmgr.do?a=adsInfo&adsid=<%=cr.getCrid()%>"><%=cr.getCrname() %></a></td>
                            <td><%=cr.getWidth()%> x <%=cr.getHeight() %></td>
                            <td><%=DateUtil.getYMDHM(cr.getStartdate(),"-") %></td>
                            <td><%=DateUtil.getYMDHM(cr.getEnddate(),"-") %></td>
                            <td><%=cr.getCr_statename() %></td>
                        </tr>
 <%} %>                     
 				</tbody>
                </table>
                <!-- list Table End -->
                <!-- creative list End -->           
 <!-- title Start -->
                 <div class="boxtitle2">                    
                    <!-- 2th title Start -->
                    <h2 class="title3">광고 위치</h2>
                    <!-- 2th title End -->
                </div>                <!-- title End -->
                <!-- creative Table Start -->
                 <table class="listTable">
                    <colgroup>
                    <col width="2%">
                    <col width="">
                    <col width="">
                    <col width="10%">
                    <col width="">
                    <col width="10%">
                    <col width="10%">
                    <col width="">
                    </colgroup>
                    <thead>
                        <tr>
                            <th></th>
                            <th>애즈</th>
                            <th>위치</th>
                            <th>사이즈</th>
                            <th>위치 정보</th>
                            <th>상태</th>
                            <th>등록자</th>
                            <th>등록일</th>
                        </tr>
                    </thead>

                    <tbody>
 <%

 for(int k=0; k<adsslotlist.size(); k++){
     
		Map<String,String> slot = adsslotlist.get(k);
  %>                    
 						<tr id="adsSlot<%=String.valueOf(slot.get("slotid"))%>">
                            <td>
                                
                            </td>
                             <td><%=slot.get("adsname") %></td>
                            <td class="textLeft"><%=slot.get("sitetag") %>/<%=slot.get("sectag") %>@<%=slot.get("slottag") %></td>
                            <td><%=StringUtil.isNull(String.valueOf(slot.get("width"))) %> x <%=StringUtil.isNull(String.valueOf(slot.get("height"))) %></td>
                            <td class="textLeft"><%=slot.get("sitename") %> / <%=slot.get("secname") %> / <%=slot.get("slotname") %></td>
                            <td><%=String.valueOf(slot.get("slot_state")).equals("1")?"진행":"중지"%></td>
                            <td><%=slot.get("insertusername") %></td>
                            <td><%=DateUtil.getYMD(String.valueOf(slot.get("insertdate"))) %></td>
                      </tr>
<%} if(adsslotlist.size()==0){
%>

                        <tr>
                            <td colspan="8"> 위치가 등록되지 않았습니다.</td>                            
                        </tr> 
                        <%} %> 
                        </tbody>
                       </table>               </section>



        </div>
    </div>
<%
} catch(Exception e) {
    e.getMessage();
}
%> 

    
</body>

</html>
