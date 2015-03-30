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
<%@page import="tv.pandora.adsrv.domain.User"%>    
<%	
try
{
	String tgtype = StringUtil.isNullReplace(request.getParameter("tgtype"),"1");
	String siteid = StringUtil.isNullReplace(request.getParameter("siteid"),"1");

	Map map = (Map)request.getAttribute("response");

	List<Map<String,String>> codelist = (List<Map<String,String>>)map.get("codelist");   
	List<Map<String,String>> tgcodelist = (List<Map<String,String>>)map.get("tgcodelist");   
	
	List<Map<String,String>> sitelist = (List<Map<String,String>>)map.get("sitelist");   
	List<Map<String,String>> seclist = (List<Map<String,String>>)map.get("seclist");   
	List<Map<String,String>> slotlist = (List<Map<String,String>>)map.get("slotlist");   

	//JSONArray code_data = JSONArray.fromObject(tgcodelist);
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
var arrSection = <%=sec_data%>;
var arrSlot = <%=slot_data%>;

$(function(){
	
		
		$("#siteid").change(function(e){		
			$("#secid").html('<option value="0">섹션</option>');
			$("#slotid").html('<option value="0">위치</option>');
			if($("#siteid").val()!=0){
			
				for(var i=0;i<arrSection.length;i++){
					if($("#siteid").val()==arrSection[i].siteid) {
						$("#secid").append('<option value="'+arrSection[i].secid+'">'+arrSection[i].secname+'</option>');
					}
				}			
			}		
		});
		$("#secid").change(function(e){		
			$("#slotid").html('<option value="0">위치</option>');
			if($("#secid").val()!=0){
			
				for(var i=0;i<arrSlot.length;i++){
					if($("#secid").val()==arrSlot[i].secid) {
						$("#slotid").append('<option value="'+arrSlot[i].slotid+'">'+arrSlot[i].slotname+'</option>');
					}
				}			
			}		
		});
		
		$("#btnRegist").on("click", function(e){
			e.preventDefault();
			$("#frmRegist input, #frmRegist select").css("border-color", "#ccc");
			if($.trim($("#targetname").val()).length==0){
				$("#targetname").css("border-color","red").focus();
				$("#warningMsg").text("타겟팅 이름을 입력해주세요.");
				return;
			}else {		
				var ipcnt = 0;
				
				for(var i=0;i<$("[name=channelid]").size();i++){

					var channelid = $.trim($("[name=channelid]").eq(i).val());
					var channelname = $.trim($("[name=channelname]").eq(i).val());
				
					if(channelid.length > 0) {						
						ipcnt++;				
					}
				}
				if(ipcnt==0){
					$("[name=channelid]").eq(0).css("border-color","red").focus();
					$("#warningMsg").text("채널 아이디를 입력해주세요.");
					return;
				} else {
					if(confirm("타겟팅을 등록하시겠습니까?")){
						$("#frmRegist").submit();					
					}
				}
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
                    <div class="title">타겟팅 등록</div>
                    <div class="breadcrumbs"><span class="glyIcon"><img src="../img/navIcon.png" alt=""></span> 현재위치 : 캠페인 > 타겟팅 > 타겟팅 등록 > 시스템 </div>
                    <!-- title End -->
                </div>
                <!-- tap menu Start -->
                <div class="tapBox2">
                    <nav class="tapMenu">
                        <ul>
                        <%for(int i=0;i<codelist.size();i++){ 
                                	Map<String,String> code = codelist.get(i);
                         %>
                                <li><a href="cpmgr.do?a=targetForm&tgtype=<%=String.valueOf(code.get("isid")) %>" class="<%=tgtype.equals(String.valueOf(code.get("isid")))?"active":"" %>" value="<%=String.valueOf(code.get("isid")) %>"><%=String.valueOf(code.get("isname")) %></a>
						   		</li>                          
						  <%} %> 
                        </ul>
                    </nav>
                </div>
                <!-- tap menu End -->
                <!-- add Table Start -->
                <form id="frmRegist" name="frmRegist" method="post" action="cpmgr.do?a=targetRegist">
                <input type="hidden" name="tgtype" value="<%=tgtype%>"/>
                    <table class="addTable" style="width:800px;">
                         <colgroup>
                            <col width="20%">
                                <col width="8%">
                                <col width="54%">
                                <col width="28%">
                        </colgroup>
                       <tr>
                            <th>타겟팅명</th>
                            <td class="form-inline" colspan="3">
                                <input type="text" name="targetname" id="targetname" class="form-control input-sm" style="width:300px">
                            </td>
                        </tr>
                        <tr>
                            <th>지정제외</th>
                            <td colspan="3">
                                <label class="radio-inline"><input type="radio" name="excflag" value="0" checked> 선택</label>
                                <label class="radio-inline"><input type="radio" name="excflag" value="1"> 제외</label>
                            </td>
                        </tr>
                        <tr>
                            <th>위치 지정</th>
                            <td class="form-inline" colspan="3">
	                           <select id="siteid" name="siteid" class="form-control input-sm" style="width:140px">
	                                <option value="0">사이트</option>
	                                <%for(int i=0;i<sitelist.size();i++){ 
	                                	Map<String,String> site = sitelist.get(i);
	                                %>
	                               <option value="<%=String.valueOf(site.get("siteid")) %>" <%=siteid.equals(String.valueOf(site.get("siteid")))?"selected":"" %>><%=site.get("sitename") %></option>                               
	                                  <%} %>
	                            </select>
	                            <select id="secid" name="secid" class="form-control input-sm" style="width:140px">
	                                <option value="0">섹션</option>
	                                <%
	                                if(!siteid.equals("")){
		                                for(int i=0;i<seclist.size();i++){ 
		                                	Map<String,String> sec = seclist.get(i);
		                                %>
		                               <option value="<%=String.valueOf(sec.get("secid")) %>" ><%=sec.get("secname") %></option>                               
		                                  <%} 
	                                } %>
	                            </select>
	                            <select id="slotid" name="slotid" class="form-control input-sm" style="width:220px">
	                                <option value="0">위치</option>
	                                <%
	                                if(!siteid.equals("")){
		                                for(int i=0;i<slotlist.size();i++){ 
		                                	Map<String,String> slot = slotlist.get(i);
		                                %>
		                               <option value="<%=String.valueOf(slot.get("slotid")) %>"><%=slot.get("slotname") %></option>                               
		                                  <%} 
	                                } %>
	                            </select>                            
	                            </td>
                        </tr>
                        <% int no = 1; %>
                         <tr>
                            <th rowspan="11">채널지정</th>
                            <th class="textCenter">No</th>
                            <th class="textCenter">아이디</th>
                            <th class="textCenter">채널명</th>
                        </tr>
                        <tr>
                            <td class="form-inline textCenter"><%=no++ %></td>
                            <td class="form-inline textCenter"><input type="text" name="channelid" class="form-control input-xs" style="width:180px"></td>
                            <td class="form-inline textCenter"><input type="text" name="channelname" class="form-control input-xs" style="width:180px"></td>
                        </tr>
                        <tr>
                            <td class="form-inline textCenter"><%=no++ %></td>
                            <td class="form-inline textCenter"><input type="text" name="channelid" class="form-control input-xs" style="width:180px"></td>
                            <td class="form-inline textCenter"><input type="text" name="channelname" class="form-control input-xs" style="width:180px"></td>
                        </tr>
                          <tr>
                            <td class="form-inline textCenter"><%=no++ %></td>
                            <td class="form-inline textCenter"><input type="text" name="channelid" class="form-control input-xs" style="width:180px"></td>
                            <td class="form-inline textCenter"><input type="text" name="channelname" class="form-control input-xs" style="width:180px"></td>
                        </tr>
                          <tr>
                            <td class="form-inline textCenter"><%=no++ %></td>
                            <td class="form-inline textCenter"><input type="text" name="channelid" class="form-control input-xs" style="width:180px"></td>
                            <td class="form-inline textCenter"><input type="text" name="channelname" class="form-control input-xs" style="width:180px"></td>
                        </tr>
                          <tr>
                            <td class="form-inline textCenter"><%=no++ %></td>
                            <td class="form-inline textCenter"><input type="text" name="channelid" class="form-control input-xs" style="width:180px"></td>
                            <td class="form-inline textCenter"><input type="text" name="channelname" class="form-control input-xs" style="width:180px"></td>
                        </tr>
                          <tr>
                            <td class="form-inline textCenter"><%=no++ %></td>
                            <td class="form-inline textCenter"><input type="text" name="channelid" class="form-control input-xs" style="width:180px"></td>
                            <td class="form-inline textCenter"><input type="text" name="channelname" class="form-control input-xs" style="width:180px"></td>
                        </tr>
                          <tr>
                            <td class="form-inline textCenter"><%=no++ %></td>
                            <td class="form-inline textCenter"><input type="text" name="channelid" class="form-control input-xs" style="width:180px"></td>
                            <td class="form-inline textCenter"><input type="text" name="channelname" class="form-control input-xs" style="width:180px"></td>
                        </tr>
                          <tr>
                            <td class="form-inline textCenter"><%=no++ %></td>
                            <td class="form-inline textCenter"><input type="text" name="channelid" class="form-control input-xs" style="width:180px"></td>
                            <td class="form-inline textCenter"><input type="text" name="channelname" class="form-control input-xs" style="width:180px"></td>
                        </tr>
                          <tr>
                            <td class="form-inline textCenter"><%=no++ %></td>
                            <td class="form-inline textCenter"><input type="text" name="channelid" class="form-control input-xs" style="width:180px"></td>
                            <td class="form-inline textCenter"><input type="text" name="channelname" class="form-control input-xs" style="width:180px"></td>
                        </tr>
                          <tr>
                            <td class="form-inline textCenter"><%=no++ %></td>
                            <td class="form-inline textCenter"><input type="text" name="channelid" class="form-control input-xs" style="width:180px"></td>
                            <td class="form-inline textCenter"><input type="text" name="channelname" class="form-control input-xs" style="width:180px"></td>
                        </tr>                    
                        </table>
                </form>

                <!-- add Table End -->
                <!-- button group Start -->
                <div class="buttonGroup" style="width:800px;">
                	<span id="warningMsg" style="color:#a00"></span>
                    <button type="button" class="btn btn-danger btn-sm" id="btnRegist">등록</button>
               </div>
                <!-- button group End -->
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
