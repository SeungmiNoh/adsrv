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
	
	Map<String,Object> map = (Map)request.getAttribute("response");

	Campaign cp = (Campaign)map.get("cp");
	List<Ads> adslist = (List<Ads>)map.get("adslist"); 
	List<Creative> crlist = (List<Creative>)map.get("crlist"); 
	List<Map<String, String>> targetlist = (List<Map<String, String>>)map.get("targetlist"); 
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
 

</head>

<body>
    <div class="container-fluid containerBg">
        <div class="containerBox">
        <%@ include file="../common/header.jsp"  %>
            <section class="sectionBox">
                <div class="boxTitle">
                    <!-- title Start -->
                          <div class="title">캠페인 애즈 목록 <span class="txtBlue" style="margin-left:10px;font-size:9pt"><span class="glyphicon glyphicon-play-circle"></span> <%=cp.getCpname() %> </span></div>
                    <div class="breadcrumbs"><span class="glyIcon"><img src="<%=web%>/img/navIcon.png" alt=""></span> 현재위치 : 캠페인  > 캠페인 정보</div>
                    <!-- title End -->
                </div>      
             	<%-- **************** 캠페인 정보 ********************* --%>
 				<%@ include file="./com_cpinfo.jsp" %>
              	<%-- ************************************************ --%>
 
                <div class="buttonGroup" style="width:900px">
                                         
                </div>
                  <div class="boxtitle2">
                     <!-- title Start -->
                    <div class="taptitle">애즈</div>
                    <!-- title End -->                   
                    <div class="tapBox">                   
                       <nav class="tapMenu">
                            <ul>  
                                <li><a href="#none" class="active">애즈 목록<span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li style="background-color:red"><a href="cpmgr.do?a=adsAddForm&cpid=<%=cp.getCpid() %>">애즈등록<span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>                                
                                <li><a href="<%if(!cp.getMax_adsid().equals("0")){%>cpmgr.do?a=adsEditTarget&adsid=<%=cp.getMax_adsid() %><%}else{ %>#none<%} %>">타겟팅<span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="<%if(!cp.getMax_adsid().equals("0")){%>cpmgr.do?a=adsEditCreative&adsid=<%=cp.getMax_adsid() %><%}else{ %>#none<%} %>">광고물 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>                               
                                <li><a href="<%if(!cp.getMax_adsid().equals("0")){%>cpmgr.do?a=adsEditSlot&adsid=<%=cp.getMax_adsid() %><%}else{ %>#none<%} %>">광고 위치<span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <!-- 
                               <li><a href="<%if(!cp.getMax_adsid().equals("0")){%>cpmgr.do?a=adsInfo&adsid=<%=cp.getMax_adsid() %><%}else{ %>#none<%} %>">애즈 정보 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="<%if(!cp.getMax_adsid().equals("0")){%>cpmgr.do?a=adsEdit&adsid=<%=cp.getMax_adsid() %><%}else{ %>#none<%} %>">애즈 수정 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>  -->                              
                            </ul>
                        </nav>
                    </div>
                </div>
                 <table class="listTable" style="width:1200px">
 				<colgroup>
				<col width="40">
				<col width="80"><!-- 광고상품 -->
				<col width="180"><!-- 애즈명 -->
				<col width="240"><!-- 종료일 -->
				<col width="80"><!-- 집행금액 -->
				<col width="100"><!-- 목표타입 -->
				<col width="80"><!-- 보장량량 -->
				<col width="80"><!-- 목표량 -->
				<%-- 
				<col width="80"><!-- 노출 -->
				<col width="60"><!-- 달성율 -->
				<col width="80"><!-- 클릭 -->
				<col width="40"><!-- CTR -->
				--%>
			    <col width="80"><!-- 등록일 -->
				<col width="60"><!-- 담당자 -->
				<col width="40"><!-- 상태 -->	
					</colgroup>                   
	                    <thead>
                        <tr>
                            <th>No</th>
                            <th>광고상품</th>
                            <th>애즈명</th>
                            <th>기간</th>
                            <th>집행금액</th>
                            <th>목표타입</th>
                            <th>보장량</th>
                            <th>목표량</th>
                            <!--  
                            <th>노출</th>
                            <th>달성율</th>
                            <th>클릭</th>
                            <th>CTR</th>-->
                            <th>상태</th>
                        </tr>
                    </thead>
                    <tbody>
<%

for(int k=0; k<adslist.size(); k++){
                                        
    Ads ads = adslist.get(k);
    
	 
 %>                        <tr>
                            <td><%=k+1 %></td>
                            <td>
                            <%--
                            if(ads.getGoaltype().equals("2")){%>
                            <span class="label label-primary" style="margin-right:6px">I</span> 
                            <%}else if(ads.getGoaltype().equals("3")){%>
                            <span class="label label-success" style="margin-right:6px">C</span> 
                            <%}else if(ads.getGoaltype().equals("4")){%>
                            <span class="label label-warning" style="margin-right:6px">P</span> 
                            <%}else {%>
                            <span class="label label-default" style="margin-right:6px">-</span> 
                            <%} --%>
                            
                            <%=ads.getPrtypename() %></td>
                            <td class="textLeft">
                            <!-- 
                            <span name="cpmod" adsid="<%=ads.getAdsid()%>" class="label label-<%=ads.getIstarget().equals("Y")?"info":"default"%>">T</span> 
                             --><span name="cpmod" adsid="<%=ads.getAdsid()%>" class="label label-<%=ads.getIsprism().equals("Y")?"warning":"default"%>" style="margin-right:6px">P</span> 
                            
                            
                            
                            
                            
                            <a href="cpmgr.do?a=adsInfo&adsid=<%=ads.getAdsid()%>" class="<%=ads.getText()%>"><%=ads.getAdsname() %><%=ads.getIstarget().equals("Y")?"<span class='txtRed' style='font-size:8pt;margin:4px'>targeting</span>":""%></a></td>
                            <td><span class="txtBlack mr4"><%=DateUtil.getYMD(ads.getStartdate()) %></span> <%=ads.getStart_hour() %>:<%=ads.getStart_min()%>
                            ~ <span class="txtBlack mr4"><%=DateUtil.getYMD(ads.getEnddate()) %></span> <%=ads.getEnd_hour() %>:<%=ads.getEnd_min()%></td>
                            <td class="textRight"><%=StringUtil.addComma(ads.getBudget()) %></td>
                            <td><%=ads.getGoaltypename() %></td>
                            <td class="textRight"><%=StringUtil.addComma(ads.getBook_total()) %></td>
                            <td class="textRight"><%=StringUtil.addComma(ads.getGoal_total()) %></td>
                            <!-- 
                            <td class="textRight">3,333,333</td>
                            <td class="textRight">101%</td>
                            <td class="textRight">33,333</td>
                            <td class="textRight">0.24%</td>
                             -->
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
                            <td class="textLeft"><a href="cpmgr.do?a=adsEditTarget&adsid=<%=String.valueOf(target.get("adsid"))%>"><%=target.get("adsname")%></a></td>
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
				<col width="80"><!-- 광고상품 -->
				<col width="240"><!-- 광고물명 -->
				<col width="240"><!-- 애즈명 -->
				<col width="120"><!-- 사이즈 -->
				<col width="250"><!-- 기간 -->
				<col width="60"><!-- 상태 -->	
				<col width="120"><!-- 종료일시 -->
				<col width="60"><!-- 상태 -->
					</colgroup>                   
	                    <thead>
                        <tr>
                            <th>No</th>
                            <th>광고상품</th>
                            <th>광고물명</th>
                            <th>애즈명</th>
                            <th>사이즈</th>
                            <th>기간</th>
                             <th>상태</th>
                             <th>최종수정</th>
                            <th>등록인</th>
                        </tr>
                    </thead>
                    <tbody>
<%

for(int k=0; k<crlist.size(); k++){
                                        
    Creative cr = crlist.get(k);
    
	 
 %>                        <tr>
                            <td><%=k+1 %></td>
                             <td><%=cr.getPrtypename() %></td>
                            <td class="textLeft">
                            <%if(!StringUtil.isNull(cr.getCrurl()).equals("")){ %><a href='<%=cr.getCrurl()%>' target='_new'><span class='glyphicon glyphicon-download'></span></a><%} %>
                            <a href="cpmgr.do?a=crInfo&crid=<%=cr.getCrid()%>"><%=cr.getCrname() %></a></td>
                            <td class="textLeft"><a href="cpmgr.do?a=adsEditCreative&adsid=<%=cr.getAdsid()%>"><%=cr.getAdsname() %></a></td>
                            <td><%=cr.getWidth()%> x <%=cr.getHeight() %></td>
                            <td><span class="txtBlack mr10"><%=DateUtil.getYMD(cr.getStartdate(),"-") %></span>
                                 <%=DateUtil.getCutHH(cr.getStartdate())%>:<%=DateUtil.getCutMM(cr.getStartdate())%>
                             ~ <span class="txtBlack mr10"><%=DateUtil.getYMD(cr.getEnddate(),"-") %></span>
                                 <%=DateUtil.getCutHH(cr.getEnddate())%>:<%=DateUtil.getCutMM(cr.getEnddate())%>
                            </td>
                            <td><span class="<%=cr.getText() %>"><%=cr.getCr_statename() %></span></td>                            
                            <td><%=DateUtil.getYMDHM(cr.getUpdatedate(),".") %></td>
                            <td><%=cr.getUpdateusername()%></td>
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
                    <col width="4%">
                    <col width="16%">
                    <col width="14%">
                    <col width="10%">
                    <col width="">
                    <col width="6%">
                    <col width="">
                    <col width="6%">
                    </colgroup>
                    <thead>
                        <tr>
                            <th></th>
                            <th>위치</th>
                            <th>애즈</th>
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
                            <td><%=k+1 %></td>
                             <td class="textLeft"><a href="javascript:newTab('<%=Constant.ADTAG_SERVER%>/<%=slot.getSlottag()%>/')"><%=slot.getSlottag()%></a></td>
                            <td class="textLeft"><a href="cpmgr.do?a=adsEditSlot&adsid=<%=slot.getAdsid()%>"><%=slot.getAdsname()%></a></td>
                             <td><%=slot.getWidth() %> x <%= slot.getHeight()%></td>
                            <td class="textLeft"><%=slot.getSitename() %> > <%=slot.getSecname() %> > <%=slot.getSlotname() %></td>
                            <td class="<%=slot.getSlot_state().equals("1")?"txtRed":"txtBlue"%>"><%=slot.getSlot_state().equals("1")?"진행":"중지"%></span>
                            <td><%=DateUtil.getYMDHM(slot.getUpdatedate(),"-") %></td>                      
                           <td><%=slot.getUpdateusername() %></td>
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
