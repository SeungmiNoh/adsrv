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
	String mode = "";


	Map<String,Object> map = (Map<String,Object>)request.getAttribute("response");
	
	Campaign cp = (Campaign)map.get("cp");
	List<Ads> adslist = (List<Ads>)map.get("adslist"); 	
	Ads ads = (Ads)map.get("ads");
	String adsid = ads.getAdsid();
	String adsname = ads.getAdsname();
	
	List<Map<String, String>> ads_code = (List<Map<String, String>>)map.get("ads_code");   
	List<Map<String,String>> tgcodelist = (List<Map<String,String>>)map.get("tgcodelist");
	List<Map<String,String>> tglist = (List<Map<String,String>>)map.get("tglist");
	
	JSONArray target_data = JSONArray.fromObject(tglist);
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
                    
                    <span class="txtBlue" style="font-size:9pt"><span class="glyphicon glyphicon-menu-right"></span> <%=ads.getAdsname() %> </span>  
                    </div>
                <div class="breadcrumbs"><span class="glyIcon"><img src="<%=web%>/img/navIcon.png" alt=""></span> 현재위치 : 캠페인  > 캠페인 정보 > 애즈 수정</div>
                    <!-- title End -->
                </div>      
              	<%-- **************** 캠페인 정보 ********************* --%>
 				<%@ include file="./com_cpinfo.jsp" %>
              	<%-- ************************************************ --%>                
                <br>
 				<%-- **************** 애즈 수정 ********************* --%>			
				<%@ include file="../campaign/ads_edit_info.jsp" %>
 				<!--********************************************************************************************
				                                          타겟팅 
				**********************************************************************************************-->
                <div class="boxtitle3" style="width:900px;">                   
                    <h1 class="title4"><span class="glyphicon glyphicon-menu-down"></span> 타겟팅</h1>
                </div>
				<form id="frmTarget" action="cpmgr.do?a=adsTargetSave">
				<input type="hidden" name="a" value="adsTargetSave"/> 
 				<input type="hidden" name="backuri" value="<%=a%>"/>
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
                                
 <%for(int i=0;i<tgcodelist.size();i++){ 
	Map<String,String> code = tgcodelist.get(i);
	
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
                                <input type="hidden" size=1 name="targettype" class="debug" value="<%= String.valueOf(code.get("isid"))%>"/>
                                 
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
                </section>
</div>
</div>
</body>
















<script>
/********************* 화면 셋팅 *************************/   
$(document).ready(function() {
	
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
});	


</script> 

    
<%
} catch(Exception e) {
    e.getMessage();
}
%>

</html>
