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
<%@page import="tv.pandora.adsrv.domain.User"%>    
<%	
try
{
	
	Map<String,Object> map = (Map<String,Object>)request.getAttribute("response");

	
	Campaign cp = (Campaign)map.get("cp");
	Ads ads = (Ads)map.get("ads");

	List<Ads> adslist = (List<Ads>)map.get("adslist"); 
	      
%>  
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Prism Ad Network</title>
    <!-- css start -->
    <link rel="stylesheet" href="../css/bootstrap.css">
    <link rel="stylesheet" href="../css/bootstrap-theme.css">
    <link rel="stylesheet" href="../css/design.css">
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
  <link rel="stylesheet" href="/resources/demos/style.css">

  <script src="../js/bootstrap.js"></script>
  <script src="../js/basic.js"></script>
 <script src="../js/common.js"></script>
  
  
<script>
$(document).ready(function() {
	  $("#moveid").on("change", function(e){
		  alert($("#adsid").val() + " / "+$("#moveid").val());
			if($("#adsid").val()!= $("#moveid").val()) 
			{
				location.href="cpmgr.do?a=adsInfo&adsid="+$("#moveid").val();
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
                    <div class="breadcrumbs"><span class="glyIcon"><img src="../img/navIcon.png" alt=""></span> 현재위치 : 캠페인 > 캠페인 정보</div>
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
                                <li><a href="" class="active">애즈 정보 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="">타겟팅 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="">광고물 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="">광고지면 <span class="glyphicon glyphicon-menu-right"></span></a>
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
                                <%--ads.getAdsname() --%>
                                <input type="hidden" id="adsid" value="<%=ads.getAdsid()%>"/>
                    <select id="moveid" style="width:300px;">
<%

for(int k=0; k<adslist.size(); k++){
                                        
    Ads mads = adslist.get(k);
    
	 
 %>                     
                        <option value="<%=mads.getAdsid()%>" <%=ads.getAdsid().equals(mads.getAdsid())?"selected":"" %>><%=mads.getAdsname() %></option>
 <%} %>                       
                    </select>                   
                                <a class="btn btn-primary btn-xs" href="cpmgr.do?a=adsEditForm&adsid=<%=ads.getAdsid() %>" role="button">수정</a>
                                <a class="btn btn-success btn-xs" href="cpmgr.do?a=adsAddForm&cpid=<%=cp.getCpid() %>" role="button" style="float:right">애즈등록</a>
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
                                <%=DateUtil.getYMD(ads.getStartdate()) %> <%=DateUtil.getMMStr(ads.getStart_hour()) %>시 <%=DateUtil.getMMStr(ads.getStart_min()) %> 분
                            </td>
                            <th>종료일</th>
                            <td>
                                <%=DateUtil.getYMD(ads.getEnddate()) %> <%=DateUtil.getMMStr(ads.getEnd_hour()) %>시 <%=DateUtil.getMMStr(ads.getEnd_min()) %> 분
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
                                <%=ads.getUpdatedate() %>
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
                <div class="boxtitle3" style="width:600px;">
                    <!-- saveBtn Start -->
                    <div class="saveBtn4">
                        <a class="btn btn-danger btn-sm" href="#" role="button">타겟팅 수정</a>
                    </div>
                    <!-- saveBtn End -->
                    <h1 class="title4"><span class="glyphicon glyphicon-ok"></span> 타겟팅</h1>
                    <!-- title End -->
                </div>

                <!-- targeting Table Start -->
                <table class="listTable" style="width:600px;">
                    <colgroup>
                        <col width="5%">
                            <col width="25%">
                                <col width="70%">
                    </colgroup>
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>타겟팅 구분</th>
                            <th>타겟팅명</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1</td>
                            <td>시스템</td>
                            <td>월화수목_주중 타겟팅</td>
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
                                        <col width="">
                                            <col width="10%">
                    </colgroup>
                    <thead>
                        <tr>
                            <th></th>
                            <th>No</th>
                            <th>광고물 명</th>
                            <th>에즈 명</th>
                            <th>기간</th>
                            <th>상태</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <input type="checkbox" name="">
                            </td>
                            <td>1</td>
                            <td>광고물B</td>
                            <td>애즈1</td>
                            <td>2015.01.01 00:00 ~ 2015.01.02 23:59</td>
                            <td>예약</td>
                        </tr>
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
                        <col width="5%">
                            <col width="">
                                <col width="10%">
                                    <col width="">
                                        <col width="10%">
                                            <col width="10%">
                                                <col width="10%">
                                                    <col width="">
                    </colgroup>
                    <thead>
                        <tr>
                            <th></th>
                            <th>위치</th>
                            <th>사이즈</th>
                            <th>위치 정보</th>
                            <th>상태</th>
                            <th>중지/진행</th>
                            <th>등록자</th>
                            <th>등록일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>x</td>
                            <td>/site/section/page/location</td>
                            <td>100 X 100</td>
                            <td>사이트/섹션/페이지/메인</td>
                            <td>진행</td>
                            <td></td>
                            <td>User1</td>
                            <td>2015.01.01 00:00</td>
                        </tr>
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
