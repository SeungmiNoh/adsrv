<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/common.jsp" %>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="tv.pandora.adsrv.common.util.StringUtil"%>
<%@page import="tv.pandora.adsrv.common.util.DateUtil"%>      
<%@page import="tv.pandora.adsrv.domain.User"%> 
<%	
try
{
	
	Map<String,Object> map = (Map<String,Object>)request.getAttribute("response");

	List<Map<String,String>> menulist = (List<Map<String,String>>)map.get("menulist");   
	List<Map<String,String>> schemlist = (List<Map<String,String>>)map.get("schemlist");   
	List<Map<String,String>> userscemlist = (List<Map<String,String>>)map.get("userscemlist");   
  
    JSONArray menu_data = JSONArray.fromObject(menulist);

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


<body>
    <div class="container-fluid containerBg">
 <div class="containerBox">
        <%@ include file="../common/header.jsp"  %>
		<section class="sectionBox">
                <div class="boxTitle">
                    <!-- title Start -->
                    <div class="title">퍼미션 스키마</div>
                    <div class="breadcrumbs"><span class="glyIcon"><img src="<%=web%>/img/navIcon.png" alt=""></span> 현재위치 : 계정 > 퍼미션 목록</div>
                    <!-- title End -->
                </div>
                <br>
                <form id="frmRegist" method="post" action="usermgr.do?a=userPerSave">
                <input type="text" class="debug" size=2 name="perid"/>               
                <input type="text" class="debug" size=2 name="pername"/> 
<%
	for(int m=0; m<menulist.size(); m++)
	{                      
	   	Map<String,String> mu = menulist.get(m);
 %>                          
                 <input type="hidden" class="debug" size=2 name="menu" value="<%=String.valueOf(mu.get("menu_id"))%>"/>
                 <input type="text" class="debug" size=2 name="menuval<%=String.valueOf(mu.get("menu_id"))%>" />
 <%} %>                 
 				
                <!-- list Table Start -->
                <table class="listTable">
                    <colgroup>
                        <col width="15%">
                            <col width="">
                                <col width="">
                                    <col width="">
                                        <col width="">
                                            <col width="">
                                                <col width="8%">
                                                    <col width="8%">
                    </colgroup>
                    <thead>
                        <tr>
                            <th rowspan="2">권한명</th>
                            <th colspan="<%=menulist.size()%>">메뉴</th>
                            <th rowspan="2">삭제</th>
                            <th rowspan="2">수정</th>
                        </tr>
                        <tr>
<%
	for(int m=0; m<menulist.size(); m++)
	{                      
	   	Map<String,String> mu = menulist.get(m);
 %>                          
                            <th class="thBg"><%=mu.get("menu_name") %></th>
 <%} %>                           
                        </tr>
                    </thead>
                    <tbody>
 
<%
	String cur_perid = "";
	String cur_menu = "";
	
	int percnt = 0;

	for(int s=0; s<schemlist.size(); s++)
	{                      
	   	Map<String,String> schm = schemlist.get(s);
	   	
	   	if(!cur_perid.equals(String.valueOf(schm.get("perid")))) {
	   		percnt++;
	   		
	   		if(!cur_perid.equals("")) {
%>
                           <td><%if(!cur_perid.equals("1")){ %><a name="delbtn" per="<%=cur_perid%>" class="btn btn-default btn-xs" href="#none" role="button">x</a><%} %></td>
                           <td><a name="modbtn" per="<%=cur_perid%>" class="btn btn-warning btn-xs" href="#none" role="button">수정</a></td>                        
                        </tr>
             <%} %>
                        <tr>  
                        	<td class="form-group">
                            <input type="text" id="pername<%=String.valueOf(schm.get("perid"))%>" value="<%=String.valueOf(schm.get("pername"))%>" class="form-control input-sm" />        
<% 	   	
			cur_perid = String.valueOf(schm.get("perid"));
	   	}
	   	
	   	if(!cur_menu.equals(String.valueOf(schm.get("menu_id")))) {
%>	   		
                            </td>
                            <td class="form-inline">
                            <input type="text" class="debug" size=2 value="<%=String.valueOf(schm.get("menu_val"))%>" id="<%=String.valueOf(schm.get("perid"))%>_menunum_<%=String.valueOf(schm.get("menu_id"))%>"/>  
<% 	   	
			cur_menu = String.valueOf(schm.get("menu_id"));
	   	}
 %>                         
                                <label class="checkbox-inline">
                                    <input type="checkbox" id="ck" per="<%=cur_perid%>" menu="<%=cur_menu %>"  value="<%=String.valueOf(schm.get("svalue"))%>" <%=!String.valueOf(schm.get("ischoice")).equals("0")?"checked":"" %>> <%= schm.get("isname")%>
                                </label>
<%} %>
<%if(percnt>0) { %>

                           <td><a name="delbtn" per="<%=cur_perid%>" class="btn btn-default btn-xs" href="#none" role="button">x</a></td>
                           <td><a name="modbtn" per="<%=cur_perid%>" class="btn btn-warning btn-xs" href="#none" role="button">수정</a></td>
                        </tr>
 <%} %>   
                 
 <tr>
                            <td class="form-group">
                            	<input type="text" class="form-control input-sm" id="pername0">
                            </td>
<%   
	/************ 신규 등록 하는 라인 *************/
	cur_menu = "";
   	for(int s=0; s<userscemlist.size(); s++)
	{      
   		Map<String,String> newsc = userscemlist.get(s);
   		
	   	if(!cur_menu.equals(String.valueOf(newsc.get("menu_id")))) {
%>	   		
                            <%if(!cur_menu.equals("")) {%></td><%} %>
                            <td class="form-inline">
                            <input type="text" class="debug" size=2 value="0" id="0_menunum_<%=String.valueOf(newsc.get("menu_id"))%>"/>  
<% 	   	
			cur_menu = String.valueOf(newsc.get("menu_id"));
	   	}    
%>	   	
        <label class="checkbox-inline">
        <input type="checkbox" id="ck" per="0" menu="<%=cur_menu %>"  value="<%=String.valueOf(newsc.get("svalue"))%>"> <%= newsc.get("isname")%>
    	</label>
<%} %>                            
                            <td></td>
                            <td><a name="modbtn" per="0" class="btn btn-danger btn-xs" href="#none" role="button">추가</a></td>
                        </tr>
 
                    </tbody>
                </table>
                        </form>                 
                        <!-- list Table End -->
            </section>

        </div>
    </div>

     

    <!-- js start -->
    <script src="<%=web%>/js/jquery-1.11.1.js"></script>
    <script src="<%=web%>/js/bootstrap.js"></script>
    <script src="<%=web%>/js/basic.js"></script>
    <!-- js end -->
<script type="text/javascript">
var arrMenu = <%=menu_data%>;


$(function(){
	$(".debug").css("display","none");
	
	$(":checkbox").click(function(e){	
		var perid = $(this).attr("per");
		var menu_id = $(this).attr("menu");
		var val = parseInt($(this).val(),10);		
		var total = parseInt($("#"+perid+"_menunum_"+menu_id).val());

		if($(this).is(":checked")){
			total= total+val;		
		} else {
			total= total-val;
		}
		$("#"+perid+"_menunum_"+menu_id).val(total);
		
	});

	
	

	$("a[name=modbtn]").on("click", function(e){	
		var perid = $(this).attr("per");
		console.log("perid="+perid);
		var pername = $("#pername"+perid).val();
		e.preventDefault();
		

		if($.trim(pername).length==0){
			$("#pername"+perid).focus();
			alert("권한명을 입력해 주세요.");
			return;
		}		
		else{	
			
			MasDwrService.getUserPerCnt(pername, perid,
		   		function(data) {
					if(data>0) {
						$("#pername"+perid).focus();
						alert("중복된 권한명이 있습니다.");
						return;				
					} else {
						$("[name=perid]").val(perid);
						$("[name=pername]").val(pername);
						for(var i=0;i<$("[name=menu]").length;i++){
							var muid = $("[name=menu]").eq(i).val();							
							var mval = $("#"+perid+"_menunum_"+muid).val();
							$("[name=menuval"+muid+"]").val(mval);						
						}
						if(perid==0) {
							if(confirm("권한을 등록하시겠습니까?")) {

								$("#frmRegist").submit();	
							}
						}else{
							if(confirm("권한을 수정하시겠습니까?")) {

								$("#frmRegist").submit();	
							}
						}
					}
			});
		}
		
	});
	
	$("a[name=delbtn]").on("click", function(e){	
		var perid = $(this).attr("per");
		console.log("perid="+perid);
		var pername = $("#pername"+perid).val();
		e.preventDefault();
		

		if(confirm("["+pername+"] 권한을 삭제하시겠습니까?")) {

			MasDwrService.delPermission(perid, <%=userID%>,
			   		function(data) {
						document.reload();
					});
				}	
			
		
		
	});
	
	
});
</script></body>
<%
} catch(Exception e) {
    e.getMessage();
}
%>
</html>

