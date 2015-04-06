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
	

	JSONArray code_data = JSONArray.fromObject(tgcodelist);

         
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
function checkIp(ip_addr)
{
	console.log("ip_addr=="+ip_addr);

	var filter = /^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$/;
	
	console.log("filter.test(ip_addr)="+filter.test(ip_addr));

	var result = filter.test(ip_addr);

	return result;

}
$(document).ready(function() {
		$("input[name=ip_from]").on("blur change", function(e){
			var idx = $("input[name=ip_from]").index($(this));			
			var ip_from = $(this).val();
						
			$.each(this,function() {				
				$("input[name=ip_to]").eq(idx).val(ip_from);
			});	
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
				
				for(var i=0;i<$("[name=ip_from]").size();i++){

					var ip_f = $.trim($("[name=ip_from]").eq(i).val());
					var ip_t = $.trim($("[name=ip_to]").eq(i).val());

					
					if(ip_f.length > 0) {
						
						ipcnt++;
						
						if(ip_t.length ==0) {
							$("[name=ip_to]").eq(i).css("border-color","red").focus();
							$("#warningMsg").text("IP 범위가 올바르게 입력되지 않았습니다.");
							return;
						} else {
							var chk_f = checkIp(ip_f);
							if(!chk_f){
								$("[name=ip_form]").eq(i).css("border-color","red").focus();
								$("#warningMsg").text("IP 가 유효하지 않습니다. ("+ip_f+")");
								return;
							} else if(ip_f != ip_t) {
								var chk_t = checkIp(ip_t);
								if(!chk_t){
									$("[name=ip_to]").eq(i).css("border-color","red").focus();
									$("#warningMsg").text("IP 가 유효하지 않습니다. ("+ip_t+")");
									return;
								}						
							}
						}
					}
				}
				if(ipcnt==0){
					$("[name=ip_from]").eq(0).css("border-color","red").focus();
					$("#warningMsg").text("IP를 입력해주세요.");
					return;
				} else {
					if(confirm(ipcnt + "타겟팅을 등록하시겠습니까?")){
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
                    <div class="breadcrumbs"><span class="glyIcon"><img src="<%=web%>/img/navIcon.png" alt=""></span> 현재위치 : 캠페인 > 타겟팅 > 타겟팅 등록 > 시스템 </div>
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
                            <th rowspan="11">아이피</th>
                            <th class="textCenter">No</th>
                            <th class="textCenter">아이피</th>
                            <th class="textCenter">별칭</th>
                        </tr>
                         <% int no = 1; %>
                        <tr>
                            <td class="textCenter"><%=no++ %></td>
                             <td class="form-inline textCenter">
                            	<input type="text" name="ip_from" class="ip_from form-control input-xs" style="width:160px"> ~ 
                                <input type="text" name="ip_to" class="ip_to form-control input-xs" style="width:160px">
                            </td>
                            <td class="textCenter"><input type="text" name="ip_alias" class="ip_alias form-control input-xs" style="width:140px"></td>
                        </tr>
                       <tr>
                            <td class="textCenter"><%=no++ %></td>
                             <td class="form-inline textCenter">
                            	<input type="text" name="ip_from" class="ip_from form-control input-xs" style="width:160px"> ~ 
                                <input type="text" name="ip_to" class="ip_to form-control input-xs" style="width:160px">
                            </td>
                            <td class="textCenter"><input type="text" name="ip_alias" class="ip_alias form-control input-xs" style="width:140px"></td>
                        </tr>
                       <tr>
                            <td class="textCenter"><%=no++ %></td>
                             <td class="form-inline textCenter">
                            	<input type="text" name="ip_from" class="ip_from form-control input-xs" style="width:160px"> ~ 
                                <input type="text" name="ip_to" class="ip_to form-control input-xs" style="width:160px">
                            </td>
                            <td class="textCenter"><input type="text" name="ip_alias" class="ip_alias form-control input-xs" style="width:140px"></td>
                        </tr>
                       <tr>
                            <td class="textCenter"><%=no++ %></td>
                             <td class="form-inline textCenter">
                            	<input type="text" name="ip_from" class="ip_from form-control input-xs" style="width:160px"> ~ 
                                <input type="text" name="ip_to" class="ip_to form-control input-xs" style="width:160px">
                            </td>
                            <td class="textCenter"><input type="text" name="ip_alias" class="ip_alias form-control input-xs" style="width:140px"></td>
                        </tr>
                       <tr>
                            <td class="textCenter"><%=no++ %></td>
                             <td class="form-inline textCenter">
                            	<input type="text" name="ip_from" class="ip_from form-control input-xs" style="width:160px"> ~ 
                                <input type="text" name="ip_to" class="ip_to form-control input-xs" style="width:160px">
                            </td>
                            <td class="textCenter"><input type="text" name="ip_alias" class="ip_alias form-control input-xs" style="width:140px"></td>
                        </tr>
                       <tr>
                            <td class="textCenter"><%=no++ %></td>
                             <td class="form-inline textCenter">
                            	<input type="text" name="ip_from" class="ip_from form-control input-xs" style="width:160px"> ~ 
                                <input type="text" name="ip_to" class="ip_to form-control input-xs" style="width:160px">
                            </td>
                            <td class="textCenter"><input type="text" name="ip_alias" class="ip_alias form-control input-xs" style="width:140px"></td>
                        </tr>
                       <tr>
                            <td class="textCenter"><%=no++ %></td>
                             <td class="form-inline textCenter">
                            	<input type="text" name="ip_from" class="ip_from form-control input-xs" style="width:160px"> ~ 
                                <input type="text" name="ip_to" class="ip_to form-control input-xs" style="width:160px">
                            </td>
                            <td class="textCenter"><input type="text" name="ip_alias" class="ip_alias form-control input-xs" style="width:140px"></td>
                        </tr>
                       <tr>
                            <td class="textCenter"><%=no++ %></td>
                             <td class="form-inline textCenter">
                            	<input type="text" name="ip_from" class="ip_from form-control input-xs" style="width:160px"> ~ 
                                <input type="text" name="ip_to" class="ip_to form-control input-xs" style="width:160px">
                            </td>
                            <td class="textCenter"><input type="text" name="ip_alias" class="ip_alias form-control input-xs" style="width:140px"></td>
                        </tr>
                       <tr>
                            <td class="textCenter"><%=no++ %></td>
                             <td class="form-inline textCenter">
                            	<input type="text" name="ip_from" class="ip_from form-control input-xs" style="width:160px"> ~ 
                                <input type="text" name="ip_to" class="ip_to form-control input-xs" style="width:160px">
                            </td>
                            <td class="textCenter"><input type="text" name="ip_alias" class="ip_alias form-control input-xs" style="width:140px"></td>
                        </tr>
                       <tr>
                            <td class="textCenter"><%=no++ %></td>
                             <td class="form-inline textCenter">
                            	<input type="text" name="ip_from" class="ip_from form-control input-xs" style="width:160px"> ~ 
                                <input type="text" name="ip_to" class="ip_to form-control input-xs" style="width:160px">
                            </td>
                            <td class="textCenter"><input type="text" name="ip_alias" class="ip_alias form-control input-xs" style="width:140px"></td>
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
