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
<%@page import="tv.pandora.adsrv.domain.Target"%>    
<%@page import="tv.pandora.adsrv.domain.User"%>    
<%	
try
{
	String tgtype = StringUtil.isNullReplace(request.getParameter("tgtype"),"1");
	

	Map<String,Object> map = (Map<String,Object>)request.getAttribute("response");

	List<Map<String,String>> codelist = (List<Map<String,String>>)map.get("codelist");   
	List<Map<String,String>> tgcodelist = (List<Map<String,String>>)map.get("tgcodelist");   
	String mode = (String)map.get("mode");   
	String tid = StringUtil.isNull((String)map.get("tid"));

	Target tginfo = (Target)map.get("tginfo");   
	Target valueinfo = (Target)map.get("valueinfo"); 
	
	JSONArray code_data = JSONArray.fromObject(tgcodelist);
	
	String targetname = "";
	Integer freqcap = 0;
	Integer freqday = 0;
	Integer day = 0;
	Integer browser = 0;
	Integer time = 0;
	
	
	
	if(tginfo != null && valueinfo != null)
	{	
		targetname = tginfo.getTargetname(); 
		tgtype = String.valueOf(tginfo.getTargettype());
		
		freqcap = valueinfo.getFreqcap(); 
		freqday = valueinfo.getFreqday(); 	
		day = valueinfo.getDay(); 
		browser = valueinfo.getBrowser(); 
		time = valueinfo.getTime(); 
	}
	
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
	
	
	
	/*********************** 타겟 선택 데이터 출력 *****************************/
	var code_data = <%=code_data%>;
	var cur_code = "";
	var htmlstr = "";
	for(var k=0; k<code_data.length; k++) {
		if(cur_code != code_data[k].entname) {
			cur_code = code_data[k].entname;
		}
		htmlstr = '<option value="'+code_data[k].tvalue+'"';
		
		var choice = 0;
		
		if(code_data[k].entname=="day"){  				
			choice = parseInt(<%=day%>,10) & parseInt(code_data[k].tvalue,10);
		} else if (code_data[k].entname=="browser") {
			choice = parseInt(<%=browser%>,10) & parseInt(code_data[k].tvalue,10);
		} else if (code_data[k].entname=="time") {
			choice = parseInt(<%=time%>,10) & parseInt(code_data[k].tvalue,10);
		}							
		if(choice>0) {
				htmlstr += ' selected';	
		}			
		htmlstr += '>'+code_data[k].tname+'</option>';
				
		$("#"+code_data[k].entname).append(htmlstr);
		//console.log(htmlstr);
	}
	/*********************** 데이터 선택 시 숫자 리턴 *****************************/
	$("select[multiple='multiple']").each(function(e){		
		
		var id = $(this).attr("id");
		console.log('<input type="text" id="'+id+'_num" name="'+id+'" value="0" class="tvalue debug"/>');
		$("#numValue").append('<input type="text" id="'+id+'_num" name="'+id+'" value="0" class="tvalue debug"/>');
	});

	$("select[multiple='multiple']").change(function(e){		
		
		var id = $(this).attr("id");
		var multipleValues = $(this).val() || [];
		var total = 0;
		$.each(multipleValues,function() {
			total += parseInt(this, 10);
		});
		$("#"+id+"_num").val(total);
	});
	
	$(".debug").css("display","none");

	<%if(mode.equals("E")) {%>	
	resetData();
	<%}%>
	
	function resetData()  {
		$("#targetname").val("<%=targetname%>");
		$("#freqday").val("<%=freqday%>");
		$("#freqcap").val("<%=freqcap%>");
		$("#day_num").val("<%=day%>");
		$("#time_num").val("<%=time%>");
		$("#browser_num").val("<%=browser%>");
	}
	
	
	$("#btnRegist").on("click", function(e){
		e.preventDefault();
		$("#frmRegist input, #frmRegist select").css("border-color", "#ccc");
		if($.trim($("#targetname").val()).length==0){
			$("#targetname").css("border-color","red").focus();
			$("#warningMsg").text("타겟팅 이름을 입력해주세요.");
			return;
		}else {
			if($.trim($("#freqday").val())!=0 && $.trim($("#freqcap").val())==0){
				$("#freqcap").css("border-color","red").focus();
				$("#warningMsg").text("프리퀀시 횟수(Frequency cap)를 입력해 주세요.");
				return;
			} else {
				var total = 0;
				for(var i=0;i<$(".tvalue").size();i++){
					total += parseInt($(".tvalue").eq(i).val(), 10);
				}
				if(total==0 && $.trim($("#freqcap").val())==0){
					$("#freqcap").css("border-color","red").focus();
					$("#warningMsg").text("프리퀀시 횟수(Frequency cap) 또는 원하시는 타겟팅을 선택해 주세요.");
					return;
				}
			}
		}
		if(confirm("타겟팅을 "+$("#btnRegist").text()+"하시겠습니까?")){
			$("#frmRegist").submit();					
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
                <form id="frmRegist" name="frmRegist" method="post" action="<%=mode.equals("E")?"cpmgr.do?a=targetUpdate":"cpmgr.do?a=targetRegist" %>">
                <input type="hidden" name="tgtype" value="<%=tgtype%>"/>
                <input type="hidden" name="tid" value="<%=tid%>"/>
 				<div id="numValue">
                </div>
                    <table class="addTable" style="width:800px;">
                        <colgroup>
                            <col width="10%">
                                <col width="40%">
                                    <col width="10%">
                                        <col width="40%">
                        </colgroup>
                        <tr>
                            <th>타겟팅명<span style="color:red"> * </span></th>
                            <td class="form-inline" colspan="3">
                                <input type="text" id="targetname" name="targetname" class="form-control input-sm" style="width:300px">                               
                            </td>
                        </tr>
                        <tr>
                            <th>프리퀀시</th>
                            <td class="form-inline" colspan="3">
                                <input type="text" id="freqday" name="freqday" class="form-control input-sm" style="width:40px" value="0"> 일 동안 &nbsp;&nbsp;&nbsp;
                                <input type="text" id="freqcap" name="freqcap" class="form-control input-sm" style="width:40px" value="0"> 회 노출
                                <span style="color:green;font-size:8pt">&nbsp;&nbsp; * 프리퀀시를 적용하지않으려면 0을 입력하세요.</span>
                            </td>
                        </tr>
                        <tr>
                            <th>요일</th>
                            <td>
                                <select id="day" multiple="multiple" class="form-control input-sm" style='height: 180px;'>
                                </select>
                            </td>
                            <th rowspan="2">시간</th>
                            <td rowspan="2">
                                <select id="time" multiple="multiple" class="form-control input-sm" style='height: 325px;'>
                                 </select>
                            </td>
                        </tr>
                        <tr>
                            <th>브라우저</th>
                            <td>
                                <select id="browser" multiple="multiple" class="form-control input-sm" style='height: 130px;'>
                                </select>
                            </td>
                        </tr>
                    </table>
                </form>
                <!-- add Table End -->
                <!-- button group Start -->
                <div class="buttonGroup" style="width:800px;">
                	<span id="warningMsg" style="color:#a00"></span>
                     <%if(mode.equals("E")) {%>
                     <a role="button" class="btn btn-default btn-sm" href="cpmgr.do?a=targetList">목록</a>
                     <a role="button" class="btn btn-default btn-sm" href="javascript:resetData()">Reset</a>
                   	<button type="button" class="btn btn-danger btn-sm" id="btnRegist">수정</button>
                    <%}else{ %>
                     <a role="button" class="btn btn-default btn-sm" href="cpmgr.do?a=targetList">목록</a>
                    <button type="button" class="btn btn-danger btn-sm" id="btnRegist">등록</button>
                    <%} %>
               </div>
                <!-- button group End -->
            </section>





        </div>
    </div>
<%
} catch(Exception e) {
	out.println(e.getMessage());
}
%> 

    
</body>

</html>
