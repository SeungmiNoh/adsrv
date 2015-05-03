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
	
	Map<String,Object> map = (Map<String,Object>)request.getAttribute("response");

	Map<String,String> tmp = (Map<String,String>)map.get("tmp");
	
	String mode = (String)map.get("mode");
	String title = "등록";
	
	if(mode.equals("E")) {
		title = "수정";
	}
	JSONObject code_data = JSONObject.fromObject(tmp);
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
		
	var code = <%=code_data%>;
  
  	<%if(tmp != null) {%>	
	resetData();
	
	
	function resetData()  {
		$("#tmpid").val(code.tmpid);
		$("#tmpname").val(code.tmpname);
		$("#memo").val(code.memo);
		//$("#tmpcode").val(code.tmpcode);
		$("#tmpcode").text(decodeURIComponent(code.tmpcode).replace(/\+/g, " "));
	}
	<%}%>
	$("#btnRegist").on("click", function(e){		
		$("#frmRegist input, #frmRegist select").css("border-color", "#ccc");
		e.preventDefault();
		
		if($.trim($("#tmpname").val()).length==0){
			$("#tmpname").css("border-color","red").focus();
			$("#warningMsg").text("템플릿명을 입력해주세요.");
			return;
		} else if($.trim($("#memo").val()).length==0){
			$("#memo").css("border-color","red").focus();
			$("#warningMsg").text("설명을 입력해주세요.");
			return;
		} else if($.trim($("#tmpcode").val()).length==0){
			$("#tmpcode").css("border-color","red").focus();
			$("#warningMsg").text("템플릿 코드를 입력해주세요.");
			return;
		} 
		else{	
			if(confirm("템플릿을 "+$("#btnRegist").text()+"하시겠습니까?")){
				
				$("#frmRegist").submit();	
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
                    <div class="title">템플릿 <%=title %></div>
                    <div class="breadcrumbs"><span class="glyIcon"><img src="<%=web%>/img/navIcon.png" alt=""></span> 현재위치 : 템플릿 > 템플릿 <%=title %></div>
                    <!-- title End -->
                </div>

                <!-- add Table Start -->
               <form id="frmRegist" name="frmRegist" method="post" action="cpmgr.do?a=tmpSave">
                    <input type="hidden" name="tmpid" id="tmpid">
                    <input type="hidden" name="mode" value=<%=mode %>>
                        <table class="addTable" style="width:980px;height:600px;">
                            <colgroup>
                                <col width="20%">
                                    <col width="">
                            </colgroup>
                            <tr>
                                <th>템플릿명<span style="color:red"> * </span></th>
                                <td>                              
                                     <input type="text" name="tmpname" id="tmpname" class="form-control input-sm"  style="width:280px">                                    
	 					         </td>
                            </tr>
                            <tr>
                                <th>설명<span style="color:red"> * </span></th>
                                <td class="form-inline">
                                    <input type="text" name="memo" id="memo" class="form-control input-sm" style="width:600px">                                    
                                </td>
                            </tr>
                             <tr>
                                <th>템플릿 코드<span style="color:red"> * </span></th>
                                <td class="form-inline">
                                   <textarea id="tmpcode" name="tmpcode" class="form-control input-sm" rows="10" style="width:770px;height:380px;"></textarea>
                            </td>
                            </tr>
							<tr>
                            <th></th>
                            <td>
                                <table class="opacityTable" style="width:680px;">
						<colgroup>
						<col width="10%"><col width="">
						<col width="10%"><col width="">
						<col width="10%"><col width="">
						</colgroup>
						<tr>
						<th>--IMG--</th>
						<td class="txtGray">: 광고물 위치</td>
						<th>--WIDTH--</th>
						<td class="txtGray">: 가로</td>
						<th>--HEIGHT--</th>
						<td class="txtGray">: 세로</td>
						<th></th>
						<td></td>

						</tr>
						<tr>
						<th>--IMP--</th>
						<td class="txtGray">: 노출 태그</td>			
						<th>--VIEW--</th>
						<td class="txtGray">: 15초 뷰 태그</td>
						<th>--SKIP--</th>
						<td class="txtGray">: 스킵 태그</td>
						<th>--CLICK--</th>
						<td class="txtGray">: 클릭 링크</td>
							</tr>
						
						</table>
                            </td>
                        </tr>
                         <tr>
                         <th><%=title %>일</th>
                            <td class="form-inline">
                                
                                
                                <%if(mode.equals("E")) {%>
                   	<%=tmp.get("updateusername") %> ( <%=DateUtil.getTimeStr(String.valueOf(tmp.get("updatedate"))) %> )
                    <%}else{ %>
                    <%=userName %> ( <%=DateUtil.getYMD(DateUtil.curDate()) %> )
                    <%} %>      
                                
                            </td>
                        </tr> 
                                               
                        </table>
                    </form>
                <!-- add Table End -->
                <!-- button group Start -->
 				<!-- button group Start -->
                <div class="buttonGroup" style="width:980px;">
                	<span id="warningMsg" style="color:#a00"></span>
                     <%if(mode.equals("E")) {%>
                   	<button type="button" class="btn btn-danger btn-sm" id="btnRegist">수정</button>
                    <a role="button" class="btn btn-default btn-sm" href="javascript:resetData()">Reset</a>
                    <%}else{ %>
                    <button type="button" class="btn btn-danger btn-sm" id="btnRegist">등록</button>
                    <%} %>                
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
