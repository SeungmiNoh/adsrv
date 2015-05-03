<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/common.jsp" %>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.google.gson.Gson"%> 
<%@page import="tv.pandora.adsrv.common.util.StringUtil"%>
<%@page import="tv.pandora.adsrv.common.util.DateUtil"%>    
<%@page import="tv.pandora.adsrv.domain.SiteReport"%>       
<%	
try
{
	String a = StringUtil.isNull(request.getParameter("a"));

	Map<String,Object> map = (Map)request.getAttribute("response");
	
	Map<String, String> paramap = (Map<String,String>)map.get("paramap");
	JSONObject param_data = JSONObject.fromObject(paramap);
	
	
	//String totalLiveAdsCnt = (String)map.get("totalLiveAdsCnt"); 	
	//String totalSlotCnt = (String)map.get("totalSlotCnt"); 	
	
	
	
	List<SiteReport> rptlist = (List<SiteReport>)map.get("rptlist"); 	
	//SiteReport tot = (SiteReport)map.get("rpttotal"); 	
	List<Map<String,String>> sitetypelist = (List<Map<String,String>>)map.get("sitetypelist");
	List<Map<String,String>> prtypelist = (List<Map<String,String>>)map.get("prtypelist");	
	List<Map<String,String>> grouplist = (List<Map<String,String>>)map.get("grouplist");
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
<script type="text/javascript">
$(document).ready(function() {
	/*********************** 파라미터 선택옵션 *****************************/
	var obj = <%=param_data%>;
	
	jQuery.each(obj, function(i, val) {
		  $("#" + i).append(document.createTextNode(" - " + val));
		  $("#"+i).val(val);
		  console.log("#"+i+" = "+val)
	});
	
	
	$("a[name=slot]").bind('click', function(){
		var slotid = $(this).attr("slotid");		
		 console.log("slotid:::::"+slotid);		
		var paramstr = "&slotid="+slotid;

		
		/* 
		var hideTr = $("#HiddenTR").html();
		
		$(hideTr).insertAfter($(this).closest('tr'));
		*/
		
		if($("#rptArea"+slotid).length>0)
		{
			$("#rptArea"+slotid).parent("tr").remove();
		}
		else 
		{
			var hideHtml = ""; 
			hideHtml +='<tr class="hideBg nohover">';
			hideHtml +='<td></td>';
			hideHtml +='<td colspan="10" id="rptArea'+slotid+'" >';
			hideHtml +='</td>';
			hideHtml +='</tr>';
	        
			$(hideHtml).insertAfter($(this).closest('tr'));
			$("#rptArea"+slotid).html($("#hideTable").html());
      	
		
			$.ajax({		    
		    	url : "rptmgr.do?a=ckSlotAdsMonitoring"+paramstr,
		    	dataType: "json",
	            success: function (data) {
	      		  	
	            	$.each(data, function (index, item) {
	               	   
	                	var htmlStr = "";
	                   	htmlStr +='<tr>';
	                   	htmlStr +='<td rowspan="2">'+item.adsname+'</td>';
	                   	htmlStr +='<td rowspan="2">'+getYMD(item.startdate,"-")+'~'+getYMD(item.enddate,"-")+'</td>';
	                   	htmlStr +='<td>'+item.remaindays+'</td>';
	                   	htmlStr +='<td class="textRight">'+addComma(item.book_total)+'</td>';
	                   	htmlStr +='<td class="textRight">'+addComma(item.goal_total)+'</td>';
	                   	htmlStr +='<td class="textRight">'+addComma(item.total_imp)+'</td>';
	                   	htmlStr +='<td class="textRight">'+item.total_ctr+'%</td>';
	                   	htmlStr +='<td rowspan="2" class="textRight">'+addComma(item.goal_daily )+'</td>';
	                   	htmlStr +='<td class="textRight">'+addComma(item.today_imp )+'</td>';
	                   	htmlStr +='<td class="textRight">'+item.today_ctr+'%</td>';
	                   	htmlStr +='<td  rowspan="2">'+item.ads_state+'</td>';
	                   	htmlStr +='</tr>'; 
	                   	htmlStr +='<tr>';	           	
	                   	htmlStr +='<td class="greenTD">'+item.go_rate+'%</td>';
	                   	htmlStr +='<td class="greenTD">'+item.bookrate+'%</td>';
	                   	htmlStr +='<td class="greenTD">'+item.goalrate+'%</td>';
	                   	htmlStr +='<td class="greenTD">'+addComma(item.slot_total_imp)+'</td>';
	                   	htmlStr +='<td class="greenTD">'+item.slot_total_ctr+'%</td>';
	                   	htmlStr +='<td class="greenTD">'+addComma(item.slot_today_imp )+'</td>';
	                   	htmlStr +='<td class="greenTD">'+item.slot_today_ctr+'%</td>';
	                   	htmlStr +='</tr>'; 
	                   	$("#rptArea"+slotid).find(".tbodyRPT").append(htmlStr);
	        		});          
	            },
	            error: function () {
	                console.log("에러 발생");
	               
	            }
			});	
		}	
	});
});
</script>

</head></head>
<body>
    <div class="container-fluid containerBg">
        <div class="containerBox">
        <%@ include file="../common/header.jsp"  %>
            <section class="sectionBox">
                <div class="boxTitle">
                    <!-- title Start -->
                    <div class="title">위치 모니터링</div>
                    <div class="breadcrumbs"><span class="glyIcon"><img src="<%=web %>/img/navIcon.png" alt=""></span> 현재위치 : 광고운영 > 위치 모니터링</div>
                    <!-- title End -->
                </div>
                <!-- search group Start -->
  				<form id="frmRpt" action="rptmgr.do" method="get">
                <input type="hidden" name="a" value="<%=a %>">
                        <div class="form-inline" >
                        <div class="form-group formGroupPadd">
                            <label>데이터 조회 기간</label>
                            <select id="dperiod" name="dperiod" class="form-control input-sm" style="width:110px">
                                <option value="1">최근일주일</option>
                                <option value="2">최근한달</option>
                            </select>
                            <select id="live" name="live" class="form-control input-sm" style="width:110px">
                                <option value="Y">라이브</option>
                                <option value="N">라이브제외</option>
                                <option value="A">전체</option>
                            </select>
                            
	                        <select id="sitetype" name="sitetype" class="form-control input-sm" style="width:140px">
	                             <option value="">사이트구분</option>
	                                <%for(int i=0;i<sitetypelist.size();i++){ 
	                                	Map<String,String> code = sitetypelist.get(i);
	                                %>
	                                <option value="<%=String.valueOf(code.get("isid")) %>"><%=code.get("isname") %></option>                               
	                                <%} %>
	                            </select>    
                            <select id="groupid" name="groupid" class="form-control input-sm" style="width:180px">
                                <option value="">위치그룹</option>
 	                       <%for(int i=0;i<grouplist.size();i++){ 
							Map<String,String> group = grouplist.get(i);
							%>
							<option value="<%=String.valueOf(group.get("groupid")) %>"><%=group.get("groupname") %></option>                               
							<%} %>	                          
							 </select>
                            <select id="sch_column" name="sch_column"  class="form-control input-sm" style="width:100px">
                                <option value="sitename">사이트명</option>
                                <option value="slotname">위치명</option>
                            </select>
                            <input type="text" class="form-control input-sm" id="sch_text" name="sch_text">
                         </div>
                         <%-- 
                         <div class="form-group formGroupPadd" style="padding:10px 20px 10px 20px;background-color:#eee">
	                       
	                        <%for(int i=0;i<sitetypelist.size();i++){ 
                              	Map<String,String> code = sitetypelist.get(i);
                              %>
                              <label class="checkbox-inline"><input type="checkbox" name="sitetype" value="<%=String.valueOf(code.get("isid")) %>"> <%=String.valueOf(code.get("isname")) %></label>                               
                              <%} %>	
                         </div>
--%>
                        <div class="form-group">
                            <button type="submit" class="btn btn-warning btn-sm">조회</button>
                        </div>
                    </div>
                </form>
                <!-- search group End -->
                <br>
                <!-- list Table Start -->
                <table class="listTable2">
                <colgroup>
				<col width="40">
				<col width="120"><!-- 사이트 -->
				<col width="*"><!-- 위치 -->
				<col width="180"><!-- 사이즈 -->
				<col width="120"><!-- 일 평균 lnv. -->
				<col width="120"><!-- 금일노출 -->
				<col width="120"><!-- 잔여 lnv. -->
				<col width="100"><!-- lnv. 사용율 -->
				<col width="100"><!-- 금일 CTR -->
				<col width="80"><!-- 라이브 애즈 -->
				</colgroup>
				    <thead>
                        <tr>
                            <th>No</th>
                            <th>사이트</th>
                            <th>위치</th>
                            <th>사이즈</th>
                            <th>일 평균 lnv.</th>
                            <th>금일노출</th>
                            <th>잔여 lnv.</th>
                            <th>lnv. 사용율</th>
                            <th>금일 CTR</th>
                            <th>라이브 애즈</th>
                        </tr>
                    </thead>
                    <tbody class="sum">
 <%--
if(tot!=null) {%> 	                       
						<tr>
                            <td colspan="5" class="textCenter">Total [<%=totalSlotCnt %>]</td>
                            <td class="textRight"><%=StringUtil.addComma(tot.getInv()) %></td>
                            <td class="textRight"><%=StringUtil.addComma(tot.getImp()) %></td>
                            <td class="textRight"><%=StringUtil.addComma(tot.getRemain()) %></td>
                            <td class="textRight"><%=tot.getFillrate()%>%</td>
                            <td class="textRight"><%=tot.getCtr()%>%</td>
                            <td class="textRight"><%=totalLiveAdsCnt%></td>
                        </tr>
<%
	}
--%>                       
                    </tbody>
                    <tbody>
 <%
 	for(int k=0; k<rptlist.size(); k++){
     SiteReport rpt = rptlist.get(k);
 %>                         <tr>
                            <td><%=k+1%></td>
                            <td class="textLeft"><%=rpt.getSitename()%></td>
                            <td class="textLeft"><%
                            	if(!rpt.getLivecnt().equals("0")){
                            %><a href="#none" name="slot" slotid="<%=rpt.getSlotid()%>"><%=rpt.getSitename()%> > <%=rpt.getSlotname()%></a><%
                            	}else{
                            %><%=rpt.getSlotname()%><%
                            	}
                            %></td>
                            <td class="textCenter"><%=rpt.getWidth()%> x <%=rpt.getHeight()%></td>
                            <td class="textRight"><%=StringUtil.addComma(rpt.getInv())%></td>
                            <td class="textRight"><%=StringUtil.addComma(rpt.getImp())%></td>
                            <td class="textRight"><%=StringUtil.addComma(rpt.getRemain())%></td>
                            <td class="textRight"><%=rpt.getFillrate()%>%</td>
                            <td class="textRight"><%=rpt.getCtr()%>%</td>
                            <td class="textRight"><%=rpt.getLivecnt()%></td>
                        </tr> 
                       
<%} %>                     
                    </tbody>
                </table>
                <!-- list Table End -->
                <div id="hideTable" style="display:none">
                         <table class="listTable3" >
                         <colgroup>
						<col width="120"><!-- 애즈명 -->
						<col width="*"><!-- 기간 -->
						<col width="80"><!-- 잔여일 -->
						<col width="120"><!-- 보장량 -->
						<col width="120"><!-- 목표랑 -->
						<col width="120"><!-- 총노출-->
						<col width="80"><!-- 총 CTR -->
						<col width="60"><!-- 금일목표-->
						<col width="120"><!-- 금일노출량-->
						<col width="60"><!-- 금일 CTR -->
						<col width="80"><!-- 상태 -->
						</colgroup>
                                 <thead>
                                     <tr>
                                         <th rowspan="2">애즈명</th>
                                         <th rowspan="2">기간</th>
                                         <th>잔여일</th>
                                         <th>보장량</th>
                                         <th>목표량</th>
                                         <th>총 노출</th>
                                         <th>총 CTR</th>
                                         <th rowspan="2">금일목표</th>
                                         <th rowspan="2">금일노출량</th>
                                         <th rowspan="2">금일CTR</th>
                                         <th rowspan="2">상태</th>
                                     </tr>
                                     <tr>
                                         <th class="greenTH">진행율</th>
                                         <th class="greenTH">도달율</th>
                                         <th class="greenTH">도달율</th>
                                         <th class="greenTH">지면노출</th>
                                         <th class="greenTH">지면 CTR</th>
                                     </tr>
                                 </thead>
                                 <tbody class="tbodyRPT">
                                    
                                 </tbody>
                          </table>
            		</div>
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
