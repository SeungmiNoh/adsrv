<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/common.jsp" %>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="tv.pandora.adsrv.common.util.StringUtil"%>
<%@page import="tv.pandora.adsrv.common.util.DateUtil"%>    
<%@page import="tv.pandora.adsrv.domain.Slot"%>    
<%	
try
{
	String s_siteid = StringUtil.isNull(request.getParameter("s_siteid"));
	String s_secid = StringUtil.isNull(request.getParameter("s_secid"));
	String s_prtype = StringUtil.isNull(request.getParameter("s_prtype"));
	
	
	if(s_prtype.equals("")) s_prtype = "1";
	String secid = StringUtil.isNull(request.getParameter("secid"));
	String sch_text = StringUtil.isNull(request.getParameter("sch_text"));
	String s_type = StringUtil.isNull(request.getParameter("s_type"));
	   
	Map<String,Object> map = (Map)request.getAttribute("response");

	List<Map<String,String>> sitelist = (List<Map<String,String>>)map.get("sitelist");   
	List<Map<String,String>> seclist = (List<Map<String,String>>)map.get("seclist");   
	List<Slot> slotlist = (List<Slot>)map.get("slotlist");   
	List<Map<String,String>> codelist = (List<Map<String,String>>)map.get("codelist");   

	Integer skip = (Integer)map.get("skip");
    Integer max = (Integer)map.get("max");
    
    String totalCount = map.get("totalCount").toString();
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
var s_siteid = '<%=s_siteid%>';
var s_secid = '<%=s_secid%>';
var arrSection = <%=sec_data%>;

$(document).ready(function() {

	formReset = function(){
		$("form").each(function() {  
            if(this.id == "frmRegist") this.reset();  
         }); 
		$("#tagstr").text("");
	}
	tagStr = function(){
		var tag_str = "";		
		if($("#sitetag").val() != "") {
			tag_str += $("#sitetag").val()+"/";
        }		
		if($("#sectag").val() != "") {
			tag_str += $("#sectag").val()+"/";
        }
		$("#tagstr").text(tag_str);
     }	
 });
$(function(){
	
	//$(".debug").css("display","none");

	$("#btnPopup").click(function(e){
		formReset();
	
		if(s_secid !="" && s_siteid!=""){
			var siteid = $("select[name='siteid']").val();
			var sitetag = $("select[name='siteid'] option[value="+siteid+"]:selected").attr("sitetag");
			$("#sitetag").val(sitetag);
			var secid = $("select[name='secid']").val();
			var sectag = $("select[name='secid'] option[value="+secid+"]:selected").attr("sectag");
			$("#sectag").val(sectag);
			tagStr();
		}
		
		
		e.preventDefault();
		$('#myModal').modal();
		$(".modify").css("display", "none");
		$(".new").css("display", "");			
		$('#sitename').focus();
		$("input:radio[name='sitetype']:radio[value=1]").prop('checked',true);
		
	});
	
	$('#frmRegist').change(function(e){	
		$("#change").val("change");
	});
	
	$("a[name=slotmod]").click(function(e){	
		$("#frmRegist input, #frmRegist select").css("border-color", "#ccc");
		formReset();
		var slotid = $(this).attr("slotid");
		$('#myModal').modal();
		
		
		$(".modify").css("display","");
		$(".new").css("display", "none");
		
		MasDwrService.getSlot(slotid,
		   		function(data) {
					console.log(data.error);
					$("#slotid").val(slotid);
					$("#siteid").val(data.siteid);
					$("#sitename").text(data.sitename);
					$("#secid").val(data.secid);
					$("#secname").text(data.secname);
					$("#sitetag").val(data.sitetag);
					$("#sectag").val(data.sectag);
					$("#tagstr").text(data.sitetag+"/"+data.sectag+"/");
					$("#slotname").val(data.slotname);
					$("#slottag").val(data.slottag);
					$("#width").val(data.width);
					$("#height").val(data.height);
					$("#memo").text(data.memo);
					$("#updatedate").html(getYMDHM(data.updatedate, '-'));
					$("#updateuser").html(data.updateusername);
				});
	});
	$("#s_siteid").change(function(e){		
		$("#s_secid").html('<option value="">섹션 선택</option>');
		if($("#s_siteid").val()!=0){
		
			for(var i=0;i<arrSection.length;i++){
				if($("#s_siteid").val()==arrSection[i].siteid) {
					$("#s_secid").append('<option value="'+arrSection[i].secid+'">'+arrSection[i].secname+'</option>');
				}
			}			
		}		
	});
	$("#siteid").change(function(e){	
		

		var siteid = $("select[name='siteid']").val();
		var sitetag = $("select[name='siteid'] option[value="+siteid+"]:selected").attr("sitetag");
		
		
		$("#sitetag").val(sitetag);
		$("#secid").html('<option value="">섹션 선택</option>');
		$("#sectag").val("");
		tagStr();
		if($("#siteid").val()!=0){
		
			for(var i=0;i<arrSection.length;i++){
				if($("#siteid").val()==arrSection[i].siteid) {
					$("#secid").append('<option value="'+arrSection[i].secid+'" sectag="'+arrSection[i].sectag+'">'+arrSection[i].secname+'</option>');
				}
			}			
		}	
	});
	
	$('#secid').change(function(e){	
		var secid = $("#secid").val();
		var sectag = "";
		if(secid!=0){
			sectag = $("select[name='secid'] option[value="+secid+"]:selected").attr("sectag");					
		} 
		$("#sectag").val(sectag);	
		tagStr();
	});	
	
	$('#siteid').change(function(e){	
		var siteid = $("#siteid").val();
		var sitetag = "";
		if(siteid !=0) {
			sitetag = $("select[name='siteid'] option[value="+siteid+"]:selected").attr("sitetag");
		}
		$("#sitetag").val(sitetag);
		tagStr();
	});	
	
		
	
	
	$("#btnUpdate").on("click", function(e){		
		e.preventDefault();
		if($("#change").val() != "change"){
			alert("변경된 내용이 없습니다.");
			return;
		} else if($.trim($("#slotname").val()).length==0){
			$("#slotname").css("border-color","red").focus();
			$("#warningMsg").text("위치 이름을 입력해주세요.");
			return;
		} else if($.trim($("#slottag").val()).length==0){
			$("#slottag").css("border-color","red").focus();
			$("#warningMsg").text("태그 아이디를 입력해주세요.");
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
			var cname = $('#slottag').val();			
			var siteid = $('#siteid').val();		
			var slotid = $('#slotid').val();		
			console.log("siteid="+siteid);
			console.log("slotid="+slotid);
			MasDwrService.getSlotCnt(cname, siteid, slotid,
					
				function(data) {
					var cnt = parseInt(data,10);
					if(cnt>0) {
						$("#slottag").css("border-color","red").select();
						$("#warningMsg").text("사이트 내에 중복된 태그 아이디가 있습니다.\r\n다른 태그 아이디를 입력해주세요.");
						return;				
					} else {
						if(confirm("위치 정보를 수정하시겠습니까?")) {
							$("#frmRegist").submit();	
						}					
					}
			});
		}		
	});
	
	$("#btnRegist").on("click", function(e){		
		e.preventDefault();
		if($("#siteid").val()==0){
			$("#siteid").css("border-color","red").focus();
			$("#warningMsg").text("사이트를 선택해주세요.");
			return;
		} else if($("#secid").val()==0){
			$("#secid").css("border-color","red").focus();
			$("#warningMsg").text("섹션을 선택해주세요.");
			return;
		} else if($.trim($("#slottag").val()).length==0){
			$("#slottag").css("border-color","red").focus();
			$("#warningMsg").text("태그 아이디를 입력해주세요.");
			return;
		} else if($.trim($("#slotname").val()).length==0){
			$("#slotname").css("border-color","red").focus();
			$("#warningMsg").text("위치 이름을 입력해주세요.");
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
			var cname = $('#slottag').val();			
			var siteid = $('#siteid').val();		
			
			MasDwrService.getSlotCnt(cname, siteid, 0, 
		   		function(data) {
					if(data>0) {
						$("#slottag").css("border-color","red").select();
						$("#warningMsg").text("중복된 태그 아이디가 있습니다.");
						return;				
					} else {
						if(confirm("위치를 등록하시겠습니까?")) {
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
                    <div class="title">위치 목록</div>
                    <div class="breadcrumbs"><span class="glyIcon"><img src="<%=web%>/img/navIcon.png" alt=""></span> 현재위치 : 사이트 > 위치 > 위치 목록</div>
                    <!-- title End -->
                </div>
                <!-- ads add title Start -->
                <!-- search group Start -->
				<form id="frmList" name="frmList" method="get" action="sitemgr.do?a=slotList">
				<input type="hidden" name="a" value="slotList"/>
				<input type="hidden" name="p" id="page"/>
                    <div class="form-inline">
                        <div class="form-group">
                            <select id="s_siteid" name="s_siteid" class="form-control input-sm" style="width:140px">
                                <option value="">사이트 선택</option>
                                <%for(int i=0;i<sitelist.size();i++){ 
                                	Map<String,String> site = sitelist.get(i);
                                %>
                               <option value="<%=String.valueOf(site.get("siteid")) %>" <%=s_siteid.equals(String.valueOf(site.get("siteid")))?"selected":"" %>><%=site.get("sitename") %></option>                               
                                  <%} %>
                            </select>
                            <select id="s_secid" name="s_secid" class="form-control input-sm" style="width:140px">
                                <option value="">섹션 선택</option>
                                <%
                                if(!s_siteid.equals("")){
	                                for(int i=0;i<seclist.size();i++){ 
	                                	Map<String,String> sec = seclist.get(i);
	                                %>
	                               <option value="<%=String.valueOf(sec.get("secid")) %>" <%=s_secid.equals(String.valueOf(sec.get("secid")))?"selected":"" %>><%=sec.get("secname") %></option>                               
	                                  <%} 
                                } %>
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
                    <a class="btn btn-danger" href="#"  data-target="#myModal" id="btnPopup">위치등록</a>
                </div>                  
                <!-- saveBtn End -->
                <br>
                <!-- list Table Start -->
                <table class="listTable">
				<colgroup>
				<col width="40">
				<col width="80"><!-- 사이트 -->
				<col width="80"><!-- 섹션 -->
				<col width="200"><!-- 위치 -->
				<col width="100"><!-- 이름 -->
			    <col width="60"><!-- 사이즈 -->
			    <col width="100"><!-- 등록일 -->
				<col width="80"><!-- 담당자 -->
					</colgroup>                   
				<thead>
                        <tr>
                            <th>No</th>
                            <th>사이트</th>  
                            <th>섹션</th>  
                            <th>이름</th>  
                            <th>위치태그</th>  
                            <th>사이즈</th>  
                             <th>등록자</th>
                           <th>등록일</th>
                            
                        </tr>
                    </thead>
                    <tbody>
<%
for(int k=0; k<slotlist.size(); k++){
                                        
	Slot slot = slotlist.get(k);
    
 %>                    
                    
                    
                        <tr>
                            <td><%=skip+(k+1) %></td>
                            <td class="textLeft"><%=slot.getSitename() %></td>
                            <td class="textLeft"><%=slot.getSecname() %></td>
                             <td class="textLeft"><a href="#none" name="slotmod" slotid="<%=slot.getSlotid()%>"><%=slot.getSlotname() %></a></td>                           
                            <td class="textLeft"><a href="javascript:newTab('<%=Constant.ADTAG_SERVER%>/<%=slot.getSlottag()%>/')"><%=slot.getSlottag()%></a></td>
                            <td><%=slot.getWidth() %> x <%= slot.getHeight()%></td>
                           <td><%=DateUtil.getYMD(slot.getUpdatedate()) %></td>
                            <td><%=slot.getUpdateusername() %></td>
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
            	<!--//table Paging-->          
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
                   <h4 class="modal-title new">위치 등록</h4><h4 class="modal-title modify">위치 수정</h4>
                 </div>
                <div class="modal-body">
                    <!-- search form Start -->
                   <form id="frmRegist" name="frmRegist" method="post" action="sitemgr.do?a=slotRegist">
                   		<input type="hidden" name="a" value="slotRegist">
                     	<input type="hidden" id="slotid" name="slotid" class="debug">
                    	<input type="hidden" id="change" name="change" value="" class="debug">
                       <table class="addTable" style="width:560px">
                            <colgroup>
                                <col width="20%">
                                    <col width="">
                            </colgroup>
 	                        <tr>
                                <th>사이트<span style="color:red"> * </span></th>
                                <td>                              
                                	<select id="siteid" name="siteid" class="new form-control input-sm" style="width:160px">
                                	<option value="0"></option>
	                                <%for(int i=0;i<sitelist.size();i++){ 
	                                	Map<String,String> site = sitelist.get(i);
	                                %>
	                                <option value="<%=String.valueOf(site.get("siteid")) %>" sitetag="<%=site.get("sitetag")%>"  <%=s_siteid.equals(String.valueOf(site.get("siteid")))?"selected":"" %>><%=site.get("sitename") %></option>                               
	                                <%} %>
                                	</select>
                               		<span id="sitename" class="modify"></span>
	 					         </td>
                            </tr>
                            <tr>
                                <th>섹션<span style="color:red"> * </span></th>
                                <td>                              
                                	<select id="secid" name="secid" class="new form-control input-sm" style="width:160px">
                                	<option value="0"></option>	                                
                               <%
                                if(!s_siteid.equals("")){
	                                for(int i=0;i<seclist.size();i++){ 
	                                	Map<String,String> sec = seclist.get(i);
	                                %>
	                               <option value="<%=String.valueOf(sec.get("secid")) %>" sectag="<%=sec.get("sectag") %>" <%=s_secid.equals(String.valueOf(sec.get("secid")))?"selected":"" %>><%=sec.get("secname") %></option>                               
	                                  <%} 
                                } %>
                                	</select>
                                	<span id="secname" class="modify"></span>
                                	
	 					         </td>
                            </tr>
                           <tr>
                                <th>위치명<span style="color:red"> * </span></th>
                                <td class="form-inline">
                                     <input type="text" name="slotname" id="slotname" class="form-control input-sm" style="width:180px">                                    
                               </td>
                            </tr>
                             <tr>
                                <th>태그 아이디<span style="color:red"> * unique</span></th>
                                <td class="form-inline"><span id="tagstr" style="padding:5px;font-size:11pt"></span>
                                     <input type="hidden" size=4 id="sitetag" class="debug"/>
                                    <input type="hidden" size=4 id="sectag" class="debug"/>
                                    <input type="text" name="slottag" id="slottag" class="form-control input-sm" width="240px" placeholder="">
                                </td>
                            </tr>
                            <tr>
                                <th>사이즈<span style="color:red"> * </span></th>
                                <td class="form-inline">
                                    <input type="text" name="width" id="width" class="form-control input-sm" style="width:80px" placeholder="가로"> x
                                    <input type="text" name="height" id="height" class="form-control input-sm" style="width:80px" placeholder="세로">
                                </td>
                            </tr>                           
                            <tr>
                                 <th>설명</th>
                                <td class="textLeft">
                                    <textarea name="memo" id="memo"  class="form-control" rows="6"  maxlength="100" style="width:360px"></textarea>
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
    out.println(e.getMessage());
}
%>
</html>

