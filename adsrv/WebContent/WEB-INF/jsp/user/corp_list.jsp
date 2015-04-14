<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/common.jsp" %>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="tv.pandora.adsrv.common.util.StringUtil"%>
<%@page import="tv.pandora.adsrv.common.util.DateUtil"%>      
<%	
try
{
	String sch_text = StringUtil.isNull(request.getParameter("sch_text"));
	String s_type = StringUtil.isNull(request.getParameter("s_type"));
	
	sch_text = new String (sch_text.getBytes("8859_1"),"UTF-8");
	  
	Map<String,Object> map = (Map)request.getAttribute("response");

	List<Map<String,String>> corplist = (List<Map<String,String>>)map.get("corplist");   
    Integer skip = (Integer)map.get("skip");
    Integer max = (Integer)map.get("max");
    
    String totalCount = map.get("totalCount").toString();
    String countPerPage = map.get("countPerPage").toString();
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

  
<script type="text/javascript">
$(function(){
	$(".debug").css("display","none");
	
	$("#btnPopup").click(function(e){
		$("#frmRegist input, #frmRegist select").css("border-color", "#ccc");
		e.preventDefault();
		$('#myModal').modal();
		$(".modify").css("display", "none");
		$(".new").css("display", "");
		$(".cvalue").val(""); //값 초기화	 (corpid, beforetype, change)	
		$('#corpname').focus();
		$("input:radio[name='corptype']:radio[value=1]").prop('checked',true);
	});
	$('#frmRegist').change(function(e){	
		$("#change").val("change");
	});
	$("span[name=corpmod]").click(function(e){	
		$("#frmRegist input, #frmRegist select").css("border-color", "#ccc");
		$(".cvalue").val(""); //값 초기화	 (corpid, beforetype, change)	
		var corpid = $(this).attr("corpid");
		$('#myModal').modal();
		
		
		$(".modify").css("display","");
		$(".new").css("display", "none");
		
		MasDwrService.getCorporation(corpid,
		   		function(data) {
					console.log(data.error);
					$("#corpid").val(corpid);
					$("#beforetype").val(data.corptype);
				    $("#corpname").val(data.corpname);
					$("input:radio[name='corptype']:radio[value="+data.corptype+"]").prop('checked',true);
					$("#updatedate").html(getYMDHM(data.updatedate, '-'));
					$("#updateuser").html(data.updateusername);
				});
	});

	$("#btnUpdate").on("click", function(e){		
		$("#frmRegist input, #frmRegist select").css("border-color", "#ccc");
		e.preventDefault();
		if($("#change").val() != "change"){
			alert("변경된 내용이 없습니다.");
			return;
		}
		else if($.trim($("#corpname").val()).length==0){
			$("#corpname").css("border-color","red").focus();
			$("#warningMsg").text("이름을 입력해주세요.");
			return;
		}
		else{	
			var cname = $('#corpname').val();	
			var cid = $('#corpid').val();	
			MasDwrService.getCorpCnt(cname, cid,
		   		function(data) {
					if(data>0) {
						$("#corpname").css("border-color","red").select();
						$("#warningMsg").text("중복된 이름이 있습니다.");
						return;				
					} else {
						var qstr = "";
						console.log("beforetype="+$("#beforetype").val());
						console.log("corptype="+$("input:radio[name='corptype']:checked").val());
						
						
						
						
						if($("input:radio[name='corptype']:checked").val() != $("#beforetype").val()) {
							qstr = "업체 구분을 변경되면 이미 등록된 캠페인의 정보가\r\n제대로 보이지 않을 수 있습니다.\r\n업체 정보를 수정하시겠습니까?";
						} else {
							qstr = "기존 캠페인의 정보도 같이 수정됩니다.\r\n업체 정보를 수정하시겠습니까?";
						}
						if(confirm(qstr)){
							$("#frmRegist").submit();	
						}

						
					}
			});
		}
		
	});
	$("#btnRegist").on("click", function(e){		
		$("#frmRegist input, #frmRegist select").css("border-color", "#ccc");
		e.preventDefault();
		if($.trim($("#corpname").val()).length==0){
			$("#corpname").css("border-color","red").focus();
			$("#warningMsg").text("이름을 입력해주세요.");
			return;
		}
		else{	
			var cname = $('#corpname').val();	
			var cid = $('#corpid').val();	
			MasDwrService.getCorpCnt(cname, 
		   		function(data) {
					if(data>0) {
						$("#corpname").css("border-color","red").select();
						$("#warningMsg").text("중복된 이름이 있습니다.");
						return;				
					} else {						
						if(confirm("업체를 등록하시겠습니까?")){
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
                    <div class="title">업체목록</div>
                    <div class="breadcrumbs"><span class="glyIcon"><img src="<%=web%>/img/navIcon.png" alt=""></span> 현재위치 : 계정 > 업체 목록</div>
                    <!-- title End -->
                </div>
                <!-- ads add title Start -->
                <!-- search group Start -->
				<form id="frmList" name="frmList" method="get" action="usermgr.do?a=corpList">
 				<input type="hidden" name="a" value="corpList"/>
				<input type="hidden" name="p" id="page"/>
                    <div class="form-inline">
                        <div class="form-group">
                            <select name="s_type" class="form-control input-sm">
                                <option value="">업체구분</option>
                                <option value="1" <%=s_type.equals("1")?"selected":"" %>>광고주</option>
                                <option value="2" <%=s_type.equals("2")?"selected":"" %>>대행사</option>
                                <option value="3" <%=s_type.equals("3")?"selected":"" %>>미디어렙</option>
                                <option value="4" <%=s_type.equals("4")?"selected":"" %>>미디어</option>
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
                    <a class="btn btn-danger" href="#"  data-target="#myModal" id="btnPopup">업체등록</a>
                </div>                  
                <!-- saveBtn End -->
                <br>
                <!-- list Table Start -->
                <table class="listTable">
				<colgroup>
				<col width="40">
				<col width="160"><!-- 업체구분 -->
				<col width="260"><!-- 업체명 -->
			    <col width="160"><!-- 등록일 -->
				<col width="160"><!-- 담당자 -->
					</colgroup>                   
				<thead>
                        <tr>
                            <th>No</th>
                            <th>업체구분</th>
                            <th>업체명</th>  
                            <th>등록일</th>
                            <th>등록자</th>
                            
                        </tr>
                    </thead>
                    <tbody>
<%

for(int k=0; k<corplist.size(); k++){
                                        
	Map<String,String> corp = corplist.get(k);
    
	 
 %>                    
                    
                    
                        <tr>
                            <td><%=skip+(k+1) %></td>
                            <td><%=corp.get("corptypename") %></td>
                             <td class="textLeft">
                             <span name="corpmod" corpid="<%=String.valueOf(corp.get("corpid"))%>" role="button" class="point label label-<%=corp.get("text") %>" style="cursor:pointer; width:80px; margin-right:10px"><%=corp.get("corptypename") %></span>                           
                             <a href="usermgr.do?a=corpView&corpid=<%=String.valueOf(corp.get("corpid"))%>"><%=corp.get("corpname") %></a></td>                           
                            <td><%=DateUtil.getYMDHM(String.valueOf(corp.get("insertdate")),"-") %></td>
                            <td><%=corp.get("insertusername") %></td>                            
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
                    <h4 class="modal-title new">업체 등록</h4><h4 class="modal-title modify">업체 수정</h4>
                </div>
                <div class="modal-body">
                    <!-- search form Start -->
                    <form id="frmRegist" name="frmRegist" method="post" action="usermgr.do?a=corpRegist">
                    <input type="hidden" id="corpid" name="corpid" class="cvalue">
                    <input type="hidden" id="beforetype" name="beforetype" class="cvalue">
                    <input type="hidden" id="change" name="change" value="" class="cvalue">
                        <table class="addTable">
                            <colgroup>
                                <col width="20%">
                                    <col width="">
                            </colgroup>
                            <tr>
                                <th>업체명</th>
                                <td class="form-inline">
                                    <input type="text" name="corpname" id="corpname" class="form-control input-sm" width="">
                                    <!--  a class="btn btn-success btn-sm"  href="javascript:msg('승미')" role="button">중복확인</a-->
                                </td>
                            </tr>
                            <tr>
                                <th>업체구분</th>
                                <td>
                                    <label class="radio-inline">
                                        <input type="radio" name="corptype" value="1"> 광고주
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="corptype" value="2"> 대행사
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="corptype" value="3"> 미디어렙
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="corptype" value="4"> 미디어
                                    </label>   
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
                            <td class="form-inline" id="updatedate"><%=DateUtil.getYMDHM(DateUtil.curDate(),"-") %></td>
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
                    <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                    <button type="button" class="new btn btn-danger btn-sm" id="btnRegist">등록</button>                    
                    <button type="button" class="modify btn btn-danger btn-sm" id="btnUpdate">수정</button>                    
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->

    <!-- modal End -->

    <!-- js start -->
    <script src="<%=web%>/js/common.js"></script>
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

