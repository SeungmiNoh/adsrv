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
 <script type="text/javascript" src="/dwr/engine.js"></script>
<script type="text/javascript" src="/dwr/util.js"></script>
<script type="text/javascript" src="/dwr/interface/MasDwrService.js"></script>
  <script src="../js/bootstrap.js"></script>
  <script src="../js/basic.js"></script>
 <script src="../js/common.js"></script>
<script type="text/javascript">

var arrSection = <%=sec_data%>;

function checkSlot(obj) {
	var slotid = $(obj).val();
	var slotname = $(obj).attr("slotname");
	var sitename = $(obj).attr("sitename");

	if($(obj).is(':checked')) {
		var str = '<div id="add'+slotid+'" style="border:1px solid #777;margin:1px;padding:3px;white-space:nowrap;overflow:hidden;">';
		str += '<a href="#" name="btnSecRemove" slotid='+slotid+'><span class="glyphicon glyphicon-remove" style="width:30px"></span></a>';
		str += sitename+'<b> > </b> '+slotname;
		str += '<input type="hidden" name="slotid" value="'+slotid+'"/>';
		str += '</div>';		
		$("#addList").append( str );
	}else {
		$("#add"+slotid).remove();
	}
}


$(function(){
	
	
	$("#btnPopup").click(function(e){		
		if($("#s_siteid").val()!=0){
			$("#siteid").val($("#s_siteid").val());			
			$("#secid").html($("#s_secid").html());			
		}
		
		e.preventDefault();
		$('#myModal').modal();
		$('#sitename').focus();
		$("input:radio[name='sitetype']:radio[value=1]").prop('checked',true);
	});

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
	
	
	$("#btnSearch").click(function(e){		
		var width = $("#width").val();
		var height = $("#height").val();
		var siteid = $("#siteid").val();
		

	
		MasDwrService.getSlotList(width, height, siteid,
	   		function(data) {
				var htmlstr = '';
				
				if(data.length >0) 
				{
					for(var k=0; k<data.length; k++) {
						htmlstr += '<tr>';
						htmlstr += '<td><input type="checkbox"  onclick="checkSlot(this)" id="chkBox'+data[k].slotid+'" value="'+data[k].slotid+'" sitename="'+data[k].sitename+'" slotname="'+data[k].slotname+'"/> </td>';
						htmlstr += '<td>'+data[k].sitename+'</td>';
						htmlstr += '<td class="textLeft">'+data[k].slotname+'</td>';
						htmlstr += '<td class="textLeft">'+data[k].width+' x '+data[k].height+'</td>';
						htmlstr += '<td class="textLeft">'+data[k].sitetag+'/'+data[k].sectag+'/'+data[k].slottag+'</td>';
						htmlstr += '</tr>';
					}
				} else {
					htmlstr += '<tr>';
					htmlstr += '<td colspan="4">조건에 맞는 위치가 없습니다.</td>';
					htmlstr += '</tr>';
					
				}
				$("#slotTable").append(htmlstr);
		});
	});

	$(document).on("click", "a[name=btnSecRemove]", function(e){
		var slotid = $(this).attr("slotid");		
		$("#chkBox"+slotid).prop("checked", false);
		$(this).parent("div").remove();
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
			
			MasDwrService.getSlotGroupCnt(cname, 
		   		function(data) {
					if(data>0) {
						$("#groupname").css("border-color","red").select();
						$("#warningMsg").text("중복된 이름이 있습니다.");
						return;				
					} else {
						$("#formRegist").submit();	
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
                    <div class="breadcrumbs"><span class="glyIcon"><img src="../img/navIcon.png" alt=""></span> 현재위치 : 사이트 > 위치그룹 > 위치그룹 목록</div>
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
                            <td><%=slot.get("groupname") %></td>
                            <td><%=StringUtil.isNull(String.valueOf(slot.get("width"))) %> x <%=StringUtil.isNull(String.valueOf(slot.get("height"))) %></td>
                              <td><%=String.valueOf(slot.get("sitecnt")) %></td>
                          <td><%=String.valueOf(slot.get("slotcnt")) %></td>
                            <td><%=String.valueOf(slot.get("updatedate")) %></td>
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
                    <h4 class="modal-title">위치그룹 등록</h4>
                </div>
                <div class="modal-body">
                    <!-- search form Start -->
                    <form id="formRegist" name="formRegist" method="post" action="sitemgr.do?a=slotGroupRegist">
                        <table class="addTable">
                            <colgroup>
                                <col width="20%">
                                    <col width="">
                            </colgroup>
                           <tr>
                                <th>위치그룹명<span style="color:red"> * </span></th>
                                <td class="form-inline">
                                     <input type="text" name="groupname" id="groupname" class="form-control input-sm" width="240px">                                    
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
   			
   			<!--  <div id="subsec" style="margin-top:10px;height:300px;border:1px solid #ccc;padding:8px;overflow-y:scroll;vertical-align:top">
				<div id="accordion">
				</div>
			</div>

			<div id="addList" style="margin-top:10px;height:150px;border:1px solid #ccc; padding:8px;overflow-y:scroll">
			</div>-->
								<div style="height:200px;border:1px solid #ccc;padding:8px;overflow-y:scroll;vertical-align:top">
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
                                            <th></th>
                                            <th>사이트</th>
                                            <th>위치명</th>                                           
                                            <th>사이즈</th>                                           
                                            <th>태그</th>                                           
                                        </tr>
                                    </thead>
                                    <tbody id="slotTable">
                                    </tbody>
                                </table>
                              <!--list Table End -->
                              
                             </div> 
                            </td>
                        </tr>
                        	<th>선택 위치</th>
                            <td class="form-inline"> 
                            	<div id="addList" style="margin-top:10px;height:150px;border:1px solid #ccc; padding:8px;overflow-y:scroll">
			                	</div>
                            </td>
                            </tr>        
                        
                             <tr>
                                 <th>설명</th>
                                <td class="textLeft">
                                    <textarea name="memo" class="form-control" rows="3"  maxlength="100"></textarea>
                                </td>
                            </tr>
                         
                        <tr>                           
                        <th>등록일</th>
                            <td class="form-inline">
                                <%=DateUtil.getYMD(DateUtil.curDate()) %>
                            </td>
                        </tr> 
                        <tr>                       
                        <th>등록자</th>
                            <td class="form-inline">
                                <%=userName %>
                            </td>
                        </tr>                        
                        </table>
                    </form>
                 </div>
                <div class="modal-footer">
                	<span id="warningMsg" style="color:#a00"></span>
                    <button type="button" class="btn btn-danger btn-sm" id="btnRegist">등록</button>                    
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
    <script src="../js/jquery-1.11.1.js"></script>
    <script src="../js/bootstrap.js"></script>
    <script src="../js/basic.js"></script>
    <!-- js end -->
</body>
<%
} catch(Exception e) {
    e.getMessage();
}
%>
</html>

