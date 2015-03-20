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
	List<Map<String,String>> slotlist = (List<Map<String,String>>)map.get("slotlist");   

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
		$("#s_secid").html('<option value="">섹션</option>');
		if($("#s_siteid").val()!=0){
		
			for(var i=0;i<arrSection.length;i++){
				if($("#s_siteid").val()==arrSection[i].siteid) {
					$("#s_secid").append('<option value="'+arrSection[i].secid+'">'+arrSection[i].secname+'</option>');
				}
			}			
		}		
	});
	$("#siteid").change(function(e){		
		$("#secid").html('<option value="">섹션</option>');
		if($("#siteid").val()!=0){
		
			for(var i=0;i<arrSection.length;i++){
				if($("#siteid").val()==arrSection[i].siteid) {
					$("#secid").append('<option value="'+arrSection[i].secid+'">'+arrSection[i].secname+'</option>');
				}
			}			
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
			
			MasDwrService.getSlotCnt(cname, siteid,
		   		function(data) {
					if(data>0) {
						$("#slottag").css("border-color","red").select();
						$("#warningMsg").text("중복된 태그 아이디가 있습니다.");
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
                    <div class="title">위치 목록</div>
                    <div class="breadcrumbs"><span class="glyIcon"><img src="../img/navIcon.png" alt=""></span> 현재위치 : 사이트 > 위치 > 위치 목록</div>
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
                                <option value="">사이트</option>
                                <%for(int i=0;i<sitelist.size();i++){ 
                                	Map<String,String> site = sitelist.get(i);
                                %>
                               <option value="<%=String.valueOf(site.get("siteid")) %>" <%=s_siteid.equals(String.valueOf(site.get("siteid")))?"selected":"" %>><%=site.get("sitename") %></option>                               
                                  <%} %>
                            </select>
                            <select id="s_secid" name="s_secid" class="form-control input-sm" style="width:140px">
                                <option value="">섹션</option>
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
                            <th>등록일</th>
                            <th>등록자</th>
                            
                        </tr>
                    </thead>
                    <tbody>
<%

for(int k=0; k<slotlist.size(); k++){
                                        
	Map<String,String> slot = slotlist.get(k);
    
	 
 %>                    
                    
                    
                        <tr>
                            <td><%=skip+(k+1) %></td>
                            <td><%=slot.get("sitename") %></td>
                            <td><%=slot.get("secname") %></td>
                            <td class="textLeft"><a href="sitemgr.do?a=slotView"><%=slot.get("slotname") %></a></td>                           
                            <td class="textLeft"><%=slot.get("sitetag") %>/<%=slot.get("sectag") %>/<%=slot.get("slottag") %></td>
                            <td><%=StringUtil.isNull(String.valueOf(slot.get("width"))) %> x <%=StringUtil.isNull(String.valueOf(slot.get("height"))) %></td>
                            <td><%=DateUtil.getYMD(String.valueOf(slot.get("insertdate"))) %></td>
                            <td><%=slot.get("insertusername") %></td>                            
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
                    <h4 class="modal-title">위치 등록</h4>
                </div>
                <div class="modal-body">
                    <!-- search form Start -->
                    <form id="formRegist" name="formRegist" method="post" action="sitemgr.do?a=slotRegist">
                        <table class="addTable">
                            <colgroup>
                                <col width="20%">
                                    <col width="">
                            </colgroup>
                            <tr>
                                <th>사이트<span style="color:red"> * </span></th>
                                <td>                              
                                	<select id="siteid" name="siteid" class="form-control input-sm" style="width:360px">
                                	<option value="0"></option>
	                                <%for(int i=0;i<sitelist.size();i++){ 
	                                	Map<String,String> site = sitelist.get(i);
	                                %>
	                                <option value="<%=String.valueOf(site.get("siteid")) %>" <%=s_type.equals(String.valueOf(site.get("sitename")))?"selected":"" %>><%=site.get("sitename") %></option>                               
	                                <%} %>
                                	</select>
	 					         </td>
                            </tr>
                            <tr>
                                <th>섹션<span style="color:red"> * </span></th>
                                <td>                              
                                	<select id="secid" name="secid" class="form-control input-sm" style="width:360px">
                                	<option value="0"></option>	                                
                                	</select>
	 					         </td>
                            </tr>
                            <tr>
                                <th>위치명<span style="color:red"> * </span></th>
                                <td class="form-inline">
                                     <input type="text" name="slotname" id="slotname" class="form-control input-sm" width="240px">                                    
                               </td>
                            </tr>
                             <tr>
                                <th>태그 아이디<span style="color:red"> * </span></th>
                                <td class="form-inline">
                                    <input type="text" name="slottag" id="slottag" class="form-control input-sm" width="240px" placeholder="">
                                </td>
                            </tr>
                            <tr>
                                <th>사이즈<span style="color:red"> * </span></th>
                                <td class="form-inline">
                                    <input type="text" name="width" id="width" class="form-control input-sm" width="80px" placeholder=""> x
                                    <input type="text" name="height" id="height" class="form-control input-sm" width="80px" placeholder="">
                                </td>
                            </tr>                           
                            <tr>
                                 <th>설명</th>
                                <td class="textLeft">
                                    <textarea name="memo" class="form-control" rows="6"  maxlength="100"></textarea>
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

