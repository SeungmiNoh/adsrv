<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/common.jsp" %>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="tv.pandora.adsrv.common.util.StringUtil"%>
<%@page import="tv.pandora.adsrv.common.util.DateUtil"%>    
<%@page import="tv.pandora.adsrv.domain.Campaign"%>    
<%	
try
{
	String s_siteid = StringUtil.isNull(request.getParameter("s_siteid"));
	String s_secid = StringUtil.isNull(request.getParameter("s_secid"));
	String secid = StringUtil.isNull(request.getParameter("secid"));
	String sch_text = StringUtil.isNull(request.getParameter("sch_text"));
	String s_type = StringUtil.isNull(request.getParameter("s_type"));
	   
	Map<String,Object> map = (Map)request.getAttribute("response");

	List<Map<String,String>> sitelist = (List<Map<String,String>>)map.get("sitelist");   
	List<Map<String,String>> seclist = (List<Map<String,String>>)map.get("seclist");   
	List<Map<String,String>> slotlist = (List<Map<String,String>>)map.get("grouplist");   

	Integer skip = (Integer)map.get("skip");
    Integer max = (Integer)map.get("max");
    
    String totalCount = map.get("totalCount").toString();
    String countPerPage = map.get("countPerPage").toString();
    String nowPage = map.get("nowPage").toString();
    
    JSONArray sec_data = JSONArray.fromObject(seclist);
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
<script type="text/javascript">

var arrSection = <%=sec_data%>;

function checkSlot(obj) {
	$("#change").val("change");

	var slotid = $(obj).val();
	var slotname = $(obj).attr("slotname");
	var sitename = $(obj).attr("sitename");
	//console.log('#add'+slotid);
	//console.log($('#add'+slotid).length);
	if($(obj).is(':checked')) {
		if($('#add'+slotid).length==0){
			var str = '<div id="add'+slotid+'" style="border-bottom:1px solid #eee;margin:1px;padding:3px;overflow:hidden;">';
			str += '<a href="#" name="btnSecRemove" slotid='+slotid+'><span class="glyphicon glyphicon-remove" style="width:30px"></span></a>';
			str += sitename+'<b> > </b> '+slotname;
			str += '<input type="hidden" name="slotid" value="'+slotid+'"/>';
			str += '</div>';		
			$("#addList").append( str );
		}
	}else {
		$("#add"+slotid).remove();
	}
}


$(function(){
	$(".debug").css("display","none");

	$("#s_siteid").change(function(e){		
		$("#s_secid").html('<option value="0">섹션</option>');
		if($("#s_siteid").val()!=0){
		
			for(var i=0;i<arrSection.length;i++){
				if($("#s_siteid").val()==arrSection[i].siteid) {
					$("#s_secid").append('<option value="'+arrSection[i].secid+'">'+arrSection[i].secname+'</option>');
				}
			}			
		}		
	});
	$("input:checkbox[name='ckall']").click(function(e){	
		var ischked = $(this).is(':checked');
		$("input:checkbox[name='ckslot']").prop("checked", ischked);	
		for(var i=0; i<$("input:checkbox[name='ckslot']").length; i++){
			checkSlot($("input:checkbox[name='ckslot']").eq(i));		
		}
	});	
	$("#btnPopup").click(function(e){	
		$("#searchList").html("");
		$("#addList").html("");
		$("#frmRegist input").val("");
		$("#frmRegist select").val("0");
		if($("#s_siteid").val()!=0){
			$("#siteid").val($("#s_siteid").val());			
			$("#secid").html($("#s_secid").html());			
		}
		
		e.preventDefault();
		$('#myModal').modal();
		$(".modify").css("display", "none");
		$(".new").css("display", "");
		$(".debug").val(""); //값 초기화	 (siteid, change)	
		$('#sitename').focus();
		$("input:radio[name='sitetype']:radio[value=1]").prop('checked',true);
	});

	$('#frmRegist').change(function(e){	
		$("#change").val("change");
	});
	$("a[name=groupmod]").click(function(e){	
		$("#frmRegist input, #frmRegist select").css("border-color", "#ccc");
		$(".debug").val(""); //값 초기화	 (groupid, change)	
		var groupid = $(this).attr("groupid");
		$('#myModal').modal();
		
		$("#searchList").html("");
		
		$(".modify").css("display","");
		$(".new").css("display", "none");
		console.log("-------------------groupid ---"+groupid);
		MasDwrService.getSlgroup(groupid,
		   		function(data) {
					console.log(data.error);
					$("#groupid").val(groupid);
					$("#groupname").val(data.groupname);
					$("#width").val(data.width);
					$("#height").val(data.height);
					$("#memo").val(data.memo);
					$("#updatedate").html(getYMDHM(data.updatedate, '-'));
					$("#updateuser").html(data.updateusername);
				});
		console.log("------------------getSlgroupInSlotList -groupid ---"+groupid);
		MasDwrService.getSlgroupInSlotList(groupid,
		   		function(data) {
					for(var k=0; k<data.length; k++){
						
						var slotid = data[k].slotid;
						var sitename = data[k].sitename;
						var slotname = data[k].slotname;
						
						var str = '<div id="add'+slotid+'" style="border-bottom:1px solid #eee;margin:1px;padding:3px;overflow:hidden;">';
						str += '<a href="#" name="btnSecRemove" slotid='+slotid+'><span class="glyphicon glyphicon-remove" style="width:30px"></span></a>';
						str += sitename+'<b> > </b> '+slotname;
						str += '<input type="hidden" name="slotid" value="'+slotid+'"/>';
						str += '</div>';		
						$("#addList").append( str );						
					}
				});
	});
	
	$("#btnSearch").click(function(e){		
		var width = $("#width").val();
		var height = $("#height").val();
		var siteid = $("#siteid").val();
		
		$("#searchList").html("");
		
		MasDwrService.getSlotList(width, height, siteid,
	   		function(data) {
				var htmlstr = '';
				
				if(data.length >0) 
				{
					for(var k=0; k<data.length; k++) {
						htmlstr += '<tr>';
						htmlstr += '<td><input type="checkbox" name="ckslot" onclick="checkSlot(this)"';
						htmlstr += ' id="chkBox'+data[k].slotid+'"'; 
						htmlstr += ' value="'+data[k].slotid+'"'; 
						htmlstr += ' sitename="'+data[k].sitename+'"'; 
						htmlstr += ' slotname="'+data[k].slotname+'"'; 
						if($('#add'+data[k].slotid).length>0) {
							htmlstr += ' checked';
						}
						htmlstr +='"/>';
						htmlstr +='</td>';
						htmlstr += '<td>'+data[k].sitename+'</td>';
						htmlstr += '<td class="textLeft">'+data[k].slotname+'</td>';
						htmlstr += '<td class="textLeft">'+data[k].width+' x '+data[k].height+'</td>';
						htmlstr += '<td class="textLeft">'+data[k].sitetag+'/'+data[k].sectag+'/'+data[k].slottag+'</td>';
						htmlstr += '</tr>';
					}
				} else {
					htmlstr += '<tr>';
					htmlstr += '<td colspan="5">조건에 맞는 위치가 없습니다.</td>';
					htmlstr += '</tr>';
					
				}
				console.log("htmlstr="+htmlstr);
				$("#searchList").append(htmlstr);
		});
	});

	$(document).on("click", "a[name=btnSecRemove]", function(e){
		var slotid = $(this).attr("slotid");		
		$("#chkBox"+slotid).prop("checked", false);
		$(this).parent("div").remove();
		$("#change").val("change");
	});
	$("#btnUpdate").on("click", function(e){		
		e.preventDefault();
		if($("#change").val() != "change"){
			alert("변경된 내용이 없습니다.");
			return;
		}else if($.trim($("#groupname").val()).length==0){
			
			console.log("groupname="+$("#groupname").val());
			$("#groupname").css("border-color","red").focus();
			$("#warningMsg").text("위치그룹 이름을 입력해주세요.");
			return;
		} else if($("[name=slotid]").length==0){
			//$("#siteid").css("border-color","red").focus();
			$("#warningMsg").text("위치를 선택해주세요.");
			return;
		} else if($.trim($("#width").val()).length==0){
			$("#width").css("border-color","red").focus();
			$("#warningMsg").text("사이즈를 입력해주세요.");
			return;
		} else if($.trim($("#height").val()).length==0){
			$("#height").css("border-color","red").focus();
			$("#warningMsg").text("사이즈를 입력해주세요.");
			return;
		}  
		else{	
			var cname = $('#groupname').val();			
			var cid = $('#groupid').val();		
			console.log("------------------cname---"+cname);
			console.log("------------------cid---"+cid);
		
		
			MasDwrService.getSlgroupCnt(cname, cid,
					
				function(data) {
					var cnt = parseInt(data,10);
					console.log("------------------cnt---"+cnt);
					if(cnt>0) {
						$("#groupname").css("border-color","red").select();
						$("#warningMsg").text("중복된 이름이 있습니다.");
						return;				
					} else {
						if(confirm("위치그룹 정보를 수정하시겠습니까?")) {
							$("#frmRegist").submit();	
						}					
					}
			});
		}		
	});	
	$("#btnRegist").on("click", function(e){		
		e.preventDefault();
		if($.trim($("#groupname").val()).length==0){
			$("#groupname").css("border-color","red").focus();
			$("#warningMsg").text("위치그룹 이름을 입력해주세요.");
			return;
		} else if($("[name=slotid]").length==0){
			//$("#siteid").css("border-color","red").focus();
			$("#warningMsg").text("위치를 선택해주세요.");
			return;
		} else if($.trim($("#width").val()).length==0){
			$("#width").css("border-color","red").focus();
			$("#warningMsg").text("사이즈를 입력해주세요.");
			return;
		} else if($.trim($("#height").val()).length==0){
			$("#height").css("border-color","red").focus();
			$("#warningMsg").text("사이즈를 입력해주세요.");
			return;
		} /*else if($("#memo").val().length > $("#memo").attr("maxlength")){
			$("#memo").css("border-color","red").focus();
			$("#warningMsg").text($("#siteurl").attr("maxlength")+"자 이하로 입력하셔야 합니다.");
			return;
		} */
		else{	
			var cname = $('#groupname').val();			
			var cid = $('#groupid').val();			
			
			MasDwrService.getSlotGroupCnt(cname, 0, 
		   		function(data) {
					if(data>0) {
						$("#groupname").css("border-color","red").select();
						$("#warningMsg").text("중복된 이름이 있습니다.");
						return;				
					} else {
						if(confirm("위치 그룹을 등록하시겠습니까?")) {
							$("#frmRegist").submit();	
						}
					}
			});
		}
		
	});	
});

</script>

<body>
    <div class="container-fluid containerBg">
 <div class="containerBox">
        <%@ include file="../common/header.jsp"  %>
             <section class="sectionBox">
                <div class="boxTitle">
                    <!-- title Start -->
                    <div class="title">위치그룹 목록</div>
                    <div class="breadcrumbs"><span class="glyIcon"><img src="<%=web%>/img/navIcon.png" alt=""></span> 현재위치 : 사이트 > 위치그룹 > 위치그룹 목록</div>
                    <!-- title End -->
                </div>
                <!-- ads add title Start -->
                <!-- search group Start -->
				<form id="frmList" name="frmList" method="get" action="sitemgr.do?a=slotGroupList">
				<input type="hidden" name="a" value="slotGroupList"/>
				<input type="hidden" name="p" id="page"/>
                    <div class="form-inline">
                        <div class="form-group">
                            <select id="s_siteid" name="s_siteid" class="form-control input-sm" style="width:140px">
                                <option value="0">사이트</option>
                                <%for(int i=0;i<sitelist.size();i++){ 
                                	Map<String,String> site = sitelist.get(i);
                                %>
                               <option value="<%=String.valueOf(site.get("siteid")) %>" <%=s_siteid.equals(String.valueOf(site.get("siteid")))?"selected":"" %>><%=site.get("sitename") %></option>                               
                                  <%} %>
                            </select>
                            <select id="s_secid" name="s_secid" class="form-control input-sm" style="width:140px">
                                <option value="0">섹션</option>
                                <%
                                if(!s_siteid.equals("")){
	                                for(int i=0;i<seclist.size();i++){ 
	                                	Map<String,String> sec = seclist.get(i);
	                                %>
	                               <option value="<%=String.valueOf(sec.get("secid")) %>" <%=s_secid.equals(String.valueOf(sec.get("secid")))?"selected":"" %>><%=sec.get("secname") %></option>                               
	                                  <%} 
                                } %>
                            </select>
                            <select name="sch_column" class="form-control input-sm" style="width:140px">
                            <option value="groupname">위치그룹</option>
                            <option value="slotname">위치</option>
                            <option value="secname">섹션</option>
                            <option value="sitename">사이트</option>
                            </select>
                        </div>
                        <div class="form-group formGroupPadd">
                            <input type="text" class="form-control input-sm" name="sch_text" value="<%=sch_text%>">
                         </div>
                        <div class="form-group formGroupPadd">
                            <button type="submit" class="btn btn-warning btn-sm">조회</button>
                        </div>
                    </div>
                </form>
                <!-- search group End -->
                <!-- saveBtn Start -->
  				<div class="outsaveBtn1">
                    <!--  a class="btn btn-danger" href="#" data-toggle="modal" data-target="#myModal" id="btnPopup">업체등록</a-->
                    <a class="btn btn-danger" href="#"  data-target="#myModal" id="btnPopup">위치그룹등록</a>
                </div>                  
                <!-- saveBtn End -->
                <br>
                <!-- list Table Start -->
                <table class="listTable">
				<colgroup>
				<col width="40">
				<col width="200"><!-- 그룹명 -->
				<col width="60"><!-- 사이즈 -->
			    <col width="60"><!-- 위치수 -->
			    <col width="60"><!-- 위치수 -->
			   <col width="100"><!-- 등록일 -->
				<col width="80"><!-- 담당자 -->
					</colgroup>                   
				<thead>
                        <tr>
                            <th>No</th>
                            <th>그룹명</th>  
                            <th>사이즈</th>  
                            <th>사이트 개수</th>  
                            <th>위치 개수</th>  
                            <th>최종수정</th>
                            <th>수정자</th>
                            
                        </tr>
                    </thead>
                    <tbody>
<%

for(int k=0; k<slotlist.size(); k++){
                                        
	Map<String,String> slot = slotlist.get(k);
    
	 
 %>                    
                    
                    
                        <tr>
                            <td><%=skip+(k+1) %></td>
                            <td><a href="#none" name="groupmod" groupid="<%=String.valueOf(slot.get("groupid"))%>"><%=slot.get("groupname") %></a></td>
                            <td><%=StringUtil.isNull(String.valueOf(slot.get("width"))) %> x <%=StringUtil.isNull(String.valueOf(slot.get("height"))) %></td>
                              <td><%=String.valueOf(slot.get("sitecnt")) %></td>
                          <td class="textLeft"><%--String.valueOf(slot.get("slotcnt")) --%><%=slot.get("slotstr").replaceAll("\n", "<br/>") %></td>
                            <td><%=DateUtil.getYMD(slot.get("updatedate")) %></td>
                            <td><%=slot.get("updateusername") %></td>                            
                        </tr>
<%} %>                        
                        
                        
                    </tbody>
                </table>
                <!--table Paging-->            
                <jsp:include page="../common/paging.jsp">
                <jsp:param name="actionForm" value="frmList"/>
                <jsp:param name="totalCount" value="<%=totalCount %>"/>
                <jsp:param name="countPerPage" value="<%=max %>"/>
                <jsp:param name="blockCount" value="10"/>
                <jsp:param name="nowPage" value="<%=nowPage %>"/>
            	</jsp:include>
            	<!--//table Paging-->                  <!-- list Table End -->
                <!-- list Table End -->

           
            </section>
        </div>
    </div>

    <!-- modal Start -->
    <div class="modal fade" id="myModal">
        <!-- modal-lg  | default | modal-sm -->
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                    </button>
                   <h4 class="modal-title new">위치그룹 등록</h4><h4 class="modal-title modify">위치그룹 수정</h4>
                </div>
                <div class="modal-body">
                    <!-- search form Start -->
                    <form id="frmRegist" name="frmRegist" method="post" action="sitemgr.do?a=slotGroupRegist">
                   		<input type="hidden" name="a" value="slotGroupRegist">
                     	<input type="text" id="groupid" name="groupid" class="debug">
                    	<input type="text" id="change" name="change" value="" class="debug">
                        <table class="addTable">
                            <colgroup>
                                <col width="16%">
                                    <col width="">
                            </colgroup>
                           <tr>
                                <th>위치그룹명<span style="color:red"> * unique</span></th>
                                <td class="form-inline">
                                     <input type="text" name="groupname" id="groupname" class="form-control input-sm" style="width:240px">                                    
                               </td>
                            </tr>
                            <tr>
                                <th>사이즈<span style="color:red"> * </span></th>
                                <td class="form-inline">
                                    <input type="text" name="width" id="width" class="form-control input-sm" style="width:60px" placeholder="넓이"> x
                                    <input type="text" name="height" id="height" class="form-control input-sm" style="width:60px" placeholder="높이">
                                    	<select id="siteid" name="siteid" class="form-control input-sm" style="width:200px">
                                	<option value="0">사이트</option>
	                                <%for(int i=0;i<sitelist.size();i++){ 
	                                	Map<String,String> site = sitelist.get(i);
	                                %>
	                                <option value="<%=String.valueOf(site.get("siteid")) %>" <%=s_type.equals(String.valueOf(site.get("sitename")))?"selected":"" %>><%=site.get("sitename") %></option>                               
	                                <%} %>
                                	</select>
                                    <a class="btn btn-success" href="#"  data-target="#myModal" id="btnSearch">조회</a>                                  
                                </td>
                            </tr>
                            
                                                                                                             
                      <tr>
                            <th>조회목록</th>
                            <td class="form-inline">
 								<div style="height:200px;padding:2px;overflow-y:scroll;vertical-align:top">
                                <!-- list Table Start --> 
                                <table class="listTable3" >
                                    <colgroup>
                                        <col width="8%">
                                        <col width="18%">
                                        <col width="16%">
                                        <col width="%">
                                    </colgroup>
                                    <thead>
                                        <tr style="height:20px">
                                            <th><input type="checkbox" id="ckall" name="ckall"/></th>
                                            <th>사이트</th>
                                            <th>위치명</th>                                           
                                            <th>사이즈</th>                                           
                                            <th>태그</th>                                           
                                        </tr>
                                    </thead>
                                    <tbody id="searchList">
                                    </tbody>
                                </table>
                              <!--list Table End -->
                             </div> 
                            </td>
                        </tr>
                        	<th>선택 위치<span style="color:red"> * </span></th>
                            <td class="form-inline"> 
  								<div id="addList" style="margin-top:2px;height:150px;padding:2px;overflow-y:scroll">
  								</div>
                            	
                            </td>
                            </tr>        
                        
                             <tr>
                                 <th>설명</th>
                                <td class="textLeft">
                                    <textarea name="memo" class="form-control" rows="3"  maxlength="100"></textarea>
                                </td>
                            </tr>
                         
  						<tr class="new">                           
                      	<th>등록일자</th>
                          <td class="form-inline"><%=DateUtil.getYMD(DateUtil.curDate()) %></td>
                      	</tr> 
                       <tr class="new">                       
                       <th>등록인</th>
                           <td class="form-inline"><%=userName %></td>
                       </tr>  
                          <tr class="modify">                           
                      	<th>최종수정</th>
                          <td class="form-inline" id="updatedate"><%=DateUtil.getYMD(DateUtil.curDate()) %></td>
                      	</tr> 
                       <tr class="modify">                       
                       <th>수정인</th>
                           <td class="form-inline" id="updateuser"><%=userName %></td>
                       </tr>                        
                          </table>
                    </form>
                 </div>
                <div class="modal-footer">
                	<span id="warningMsg" style="color:#a00"></span>
                    <button type="button" class="new btn btn-danger btn-sm" id="btnRegist">등록</button>                    
                    <button type="button" class="modify btn btn-danger btn-sm" id="btnUpdate">수정</button>                    
                    <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->

    <!-- modal End -->

    <!-- js start -->
    <script src="<%=web%>/js/jquery-1.11.1.js"></script>
    <script src="<%=web%>/js/bootstrap.js"></script>
    <script src="<%=web%>/js/basic.js"></script>
    <!-- js end -->
</body>
<%
} catch(Exception e) {
    e.getMessage();
}
%>
</html>

