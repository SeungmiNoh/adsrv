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
	String sch_text = StringUtil.isNull(request.getParameter("sch_text"));
	String s_type = StringUtil.isNull(request.getParameter("s_type"));
	   
	Map<String,Object> map = (Map)request.getAttribute("response");

	List<Map<String,String>> sitelist = (List<Map<String,String>>)map.get("sitelist");   
	List<Map<String,String>> codelist = (List<Map<String,String>>)map.get("codelist");   

	Integer skip = (Integer)map.get("skip");
    Integer max = (Integer)map.get("max");
    
    String totalCount = map.get("totalCount").toString();
    String nowPage = map.get("nowPage").toString();

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


$(function(){
	
	
	$("#btnPopup").click(function(e){
		
		
		//$(".modify").css("display","none");
		//$(".modal-title").text("업체 등록");
		
		$.ajax({		    
			url : "cpmgr.do?a=auto_corp&corptype=4",
		    datatype:"json",
		    success:function(data, type){	     
		        test = eval("(" + data + ")");	     
		        for(var k=0; k<test.length; k++) {
		        	$('#media').append('<option value="'+test[k].value+'">'+test[k].label+'</option>');
		        }
			}
		});  	 

		
		
		
		e.preventDefault();
		$('#myModal').modal();
		$('#sitename').focus();
		$("input:radio[name='sitetype']:radio[value=1]").prop('checked',true);
	});


	$("#btnRegist").on("click", function(e){		
		$("#frmRegist input, #frmRegist select").css("border-color", "#ccc");
		e.preventDefault();
		
		if($("#media").val()==0){
			$("#media").css("border-color","red").focus();
			$("#warningMsg").text("미디어를 선택해주세요.");
			return;
		} else if($.trim($("#sitename").val()).length==0){
			$("#sitename").css("border-color","red").focus();
			$("#warningMsg").text("사이트 이름을 입력해주세요.");
			return;
		} else if($.trim($("#sitetag").val()).length==0){
			$("#sitetag").css("border-color","red").focus();
			$("#warningMsg").text("태그 아이디를 입력해주세요.");
			return;
		} else if($("input:radio[name='sitetype']").is(":checked") == false ){
			$("input:radio[name='sitetype']").css("border-color","red").focus();
			$("#warningMsg").text("스크린을 선택해주세요.");
			return;
		} /*else if(($("#siteurl").val()).length > 0 && ($("#siteurl").val()).length > $("#siteurl").attr("maxlength")){
			$("#siteurl").css("border-color","red").focus();
			var maxleng = $("#siteurl").attr("maxlength");
			$("#warningMsg").text("URL은 "+maxleng+"자 이하로 입력하셔야 합니다.");
			return;
		} else if(($("#memo").val()).length > 0 && ($("#memo").val()).length > $("#memo").attr("maxlength")){
			$("#memo").css("border-color","red").focus();
			var maxleng = $("#siteurl").attr("maxlength");	
			$("#warningMsg").text("설명은 "+maxleng+"자 이하로 입력하셔야 합니다.");
			return;
		}*/
		else{	
			var cname = $('#sitetag').val();			
			MasDwrService.getSiteCnt(cname,
		   		function(data) {
					if(data>0) {
						$("#sitetag").css("border-color","red").select();
						$("#warningMsg").text("중복된 태그 아이디가 있습니다.");
						return;				
					} else {
						$("#frmRegist").submit();	
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
                    <div class="title">사이트 목록</div>
                    <div class="breadcrumbs"><span class="glyIcon"><img src="../img/navIcon.png" alt=""></span> 현재위치 : 사이트 > 사이트 목록</div>
                    <!-- title End -->
                </div>
                <!-- ads add title Start -->
                <!-- search group Start -->
				<form id="frmList" name="frmList" method="get" action="sitemgr.do?a=siteList">
				<input type="hidden" name="a" value="siteList"/>
				<input type="hidden" name="p" id="page"/>
                    <div class="form-inline">
                        <div class="form-group">
                            <select name="s_type" class="form-control input-sm">
                                <option value="">사이트구분</option>
                                <%for(int i=0;i<codelist.size();i++){ 
                                	Map<String,String> code = codelist.get(i);
                                %>
                                <option value="<%=String.valueOf(code.get("isid")) %>" <%=s_type.equals(String.valueOf(code.get("isid")))?"selected":"" %>><%=String.valueOf(code.get("isname")) %></option>                               
                                <%} %>
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
                    <a class="btn btn-danger" href="#"  data-target="#myModal" id="btnPopup">사이트등록</a>
                </div>                  
                <!-- saveBtn End -->
                <br>
                <!-- list Table Start -->
                <table class="listTable">
				<colgroup>
				<col width="40">
				<col width="100"><!-- 스크린 -->
				<col width="160"><!-- 사이트명 -->
				<col width="160"><!-- 태그 -->
				<col width="220"><!-- URL -->
			    <col width="100"><!-- 등록일 -->
				<col width="80"><!-- 담당자 -->
					</colgroup>                   
				<thead>
                        <tr>
                            <th>No</th>
                            <th>스크린</th>
                            <th>사이트명</th>  
                            <th>태그</th>  
                            <th>URL</th>  
                            <th>등록일</th>
                            <th>등록자</th>
                            
                        </tr>
                    </thead>
                    <tbody>
<%

for(int k=0; k<sitelist.size(); k++){
                                        
	Map<String,String> site = sitelist.get(k);
    
	 
 %>                    
                    
                    
                        <tr>
                            <td><%=skip+(k+1) %></td>
                            <td><%=site.get("sitetypename") %></td>
                            <td class="textLeft"><a href="sitemgr.do?a=siteView"><%=site.get("sitename") %></a></td>                           
                            <td class="textLeft"><a href="sitemgr.do?a=secList&s_siteid=<%=String.valueOf(site.get("siteid"))%>"><%=site.get("sitetag") %></a></td>                           
                            <td class="textLeft"><%=site.get("siteurl") %></td>
                            <td><%=DateUtil.getYMD(String.valueOf(site.get("insertdate"))) %></td>
                            <td><%=site.get("insertusername") %></td>                            
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
                    <h4 class="modal-title">사이트 등록</h4>
                </div>
                <div class="modal-body">
                    <!-- search form Start -->
                    <form id="frmRegist" name="frmRegist" method="post" action="sitemgr.do?a=siteRegist">
                        <table class="addTable">
                            <colgroup>
                                <col width="20%">
                                    <col width="">
                            </colgroup>
                            <tr>
                                <th>미디어<span style="color:red"> * </span></th>
                                <td>                              
                                	<select id="media" name="corpid" class="form-control input-sm" style="width:360px">
                                	<option value="0"></option>
                                	</select>
	 					         </td>
                            </tr>
                            <tr>
                                <th>사이트명<span style="color:red"> * </span></th>
                                <td class="form-inline">
                                    <input type="text" name="sitename" id="sitename" class="form-control input-sm" width="240px">                                    
                                </td>
                            </tr>
                             <tr>
                                <th>태그 아이디<span style="color:red"> * </span></th>
                                <td class="form-inline">
                                    <input type="text" name="sitetag" id="sitetag" class="form-control input-sm" width="240px" placeholder="">
                                </td>
                            </tr>
                             <tr>
                                <th>스크린<span style="color:red"> * </span></th>
                                <td>
                                <%for(int i=0;i<codelist.size();i++){ 
                                	Map<String,String> code = codelist.get(i);
                                %>
                                <label class="radio-inline"><input type="radio" name="sitetype" value="<%=String.valueOf(code.get("isid")) %>"> <%=String.valueOf(code.get("isname")) %></label>                               
                                <%} %>
                                </td>
                            </tr> 
                        <tr>                           
                             <tr>
                                <th>URL</th>
                                <td class="form-inline">
                                    <input type="text" name="siteurl" id="siteurl" class="form-control input-sm" width="360px" maxlength="60">                                    
                                </td>
                            </tr>                           
    					<tr>
                                <th>설명</th>
                                <td class="textLeft">
                                    <textarea name="memo" id="memo" class="form-control" rows="6"  maxlength="100"></textarea>
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

