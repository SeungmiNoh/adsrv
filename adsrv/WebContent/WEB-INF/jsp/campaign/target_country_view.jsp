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

	Map map = (Map)request.getAttribute("response");

	List<Map<String,String>> codelist = (List<Map<String,String>>)map.get("codelist");   
	List<Map<String,String>> tgcodelist = (List<Map<String,String>>)map.get("tgcodelist");   
	String mode = (String)map.get("mode");   
	String tid = StringUtil.isNull((String)map.get("tid"));

	Target tginfo = (Target)map.get("tginfo");   
	Target valueinfo = (Target)map.get("valueinfo"); 
	
	JSONArray code_data = JSONArray.fromObject(tgcodelist);
	
	String targetname = "";
	Integer excflag = 0;
	Long country1 = 0L;
	Long country2 = 0L;
	Long country3 = 0L;
	Long country4 = 0L;
	Long country5 = 0L;
	Long country6 = 0L;
	Long country7 = 0L;
	Long country8 = 0L;
	
	if(tginfo != null && valueinfo != null)
	{	
		targetname = tginfo.getTargetname(); 
		tgtype = String.valueOf(tginfo.getTargettype());
		excflag = valueinfo.getExcflag(); 
		country1 = valueinfo.getCountry1(); 	
		country2 = valueinfo.getCountry2(); 	
		country3 = valueinfo.getCountry3(); 	
		country4 = valueinfo.getCountry4(); 	
		country5 = valueinfo.getCountry5(); 	
		country6 = valueinfo.getCountry6(); 	
		country7 = valueinfo.getCountry7(); 	
		country8 = valueinfo.getCountry8(); 	
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
		$(".debug").css("display","none");

		/*********************** 타겟 선택 데이터 출력 *****************************/
		var code_data = <%=code_data%>;

		var cur_code = "";
		var htmlstr = "";
		var tseq = 0;
		var num = [<%=country1%>,<%=country2%>,<%=country3%>,<%=country4%>,<%=country5%>,<%=country6%>,<%=country7%>,<%=country8%>];
	
		for(var k=0; k<code_data.length; k++) {
			if(cur_code != code_data[k].entname) {
				cur_code = code_data[k].entname;
			}
			tseq = Math.floor((code_data[k].tseq-1)/32);
			htmlstr = '<option tseq='+tseq+' value="'+code_data[k].tvalue+'"';
			
			if( (num[tseq] & code_data[k].tvalue) > 0) {
				htmlstr += ' selected';	
				console.log(tseq + "/" + code_data[k].tname + "( "+code_data[k].tvalue+") num["+tseq+"] = "+ num[tseq] + "/" + (num[tseq] & code_data[k].tvalue));
			}
			//console.log((num[tseq] & code_data[k].tvalue));
			
			
			htmlstr += '>'+code_data[k].tname+'</option>';
			
			
			$("#"+code_data[k].entname).append(htmlstr);
			
		}
		

		<%if(mode.equals("E")) {%>	
		resetData();
		<%}%>
		
		function resetData()  {
			$("#targetname").val("<%=targetname%>");
			$("input:radio[name='excflag']:radio[value='<%=excflag%>']").prop('checked',true);
			$("#country_num1").val("<%=country1%>");
			$("#country_num2").val("<%=country2%>");
			$("#country_num3").val("<%=country3%>");
			$("#country_num4").val("<%=country4%>");
			$("#country_num5").val("<%=country5%>");
			$("#country_num6").val("<%=country6%>");
			$("#country_num7").val("<%=country7%>");
			$("#country_num8").val("<%=country8%>");
		}

		
		$("#btnRegist").on("click", function(e){
			e.preventDefault();
			$("#frmRegist input, #frmRegist select").css("border-color", "#ccc");
			if($.trim($("#targetname").val()).length==0){
				$("#targetname").css("border-color","red").focus();
				$("#warningMsg").text("타겟팅 이름을 입력해주세요.");
				return;
			}else {
				
				
				
				
					
				for(var t=0;t<8;t++) {
					var total = 0;
					var seqOption = $("select[multiple='multiple'] option[tseq="+t+"]:selected");
					
					for(var i=0;i< $(seqOption).size();i++) {
						total |= parseInt($(seqOption).eq(i).val(), 10);
					}
					 $("#country_num"+(parseInt(t,10)+1)).val(total);
				}
		
					var num = 0;
					for(var i=0;i<$(".tvalue").size();i++){
						if($(".tvalue").eq(i).val()>0) {
							num++;
						}
					}
					if(num==0){
						$("#country").css("border-color","red").focus();
						$("#warningMsg").text("국가를 선택해 주세요.");
						return;
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
 				<input type="text" id="country_num1" name="country1" value="0" class="tvalue debug"/>
 				<input type="text" id="country_num2" name="country2" value="0" class="tvalue debug"/>
 				<input type="text" id="country_num3" name="country3" value="0" class="tvalue debug"/>
 				<input type="text" id="country_num4" name="country4" value="0" class="tvalue debug"/>
 				<input type="text" id="country_num5" name="country5" value="0" class="tvalue debug"/>
 				<input type="text" id="country_num6" name="country6" value="0" class="tvalue debug"/>
 				<input type="text" id="country_num7" name="country7" value="0" class="tvalue debug"/>
				<input type="text" id="country_num8" name="country8" value="0" class="tvalue debug"/>
                </div>
                    <table class="addTable" style="width:600px;">
                        <colgroup>
                        <col width="20%">
                        <col width="80%">
                        </colgroup>
                        <tr>
                            <th>타겟팅명</th>
                            <td class="form-inline">
                                <input type="text" name="targetname" id="targetname" class="form-control input-sm" style="width:300px">                               
                            </td>
                        </tr>
                        <tr>
                            <th>지정제외</th>
                            <td class="form-inline">
                                <label class="radio-inline"><input type="radio" name="excflag" value="0" checked> 선택</label>
                                <label class="radio-inline"><input type="radio" name="excflag" value="1"> 제외</label>
                           </td>
                        </tr>
                        <tr>
                            <th>국가</th>
                            <td style='height:500px;'>
                                <select id="country" multiple="multiple" class="form-control input-sm" style='height:480px;'>
                                </select>
                            </td>
                        </tr>
                    </table>
                </form>
                <!-- add Table End -->
                <!-- button group Start -->
                <div class="buttonGroup" style="width:600px;">
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
    e.getMessage();
}
%> 

    
</body>

</html>
