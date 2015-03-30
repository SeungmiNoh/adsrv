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
	Map<String,Object> map = (Map)request.getAttribute("response");

	Map<String,String> corp = (Map<String,String>)map.get("corp");
	List<User> userlist = (List<User>)map.get("userlist");   

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
		
		MasDwrService.getUserPerList(
		   		function(data) {
					var htmlstr = "";
					for(var i=0;i<data.length;i++) {
						htmlstr += '<option value="'+data[i].perid+'">'+data[i].pername+'</option>';						
					}
					$("#perid").html(htmlstr);	
						
			}); 	 
		e.preventDefault();
		$('#myModal').modal();
		$('#username').focus();
		});


	$("#btnRegist").on("click", function(e){		
		$("#frmRegist input, #frmRegist select").css("border-color", "#ccc");
		e.preventDefault();
		
		var chk_pw = checkPwd($("#passwd").val());
		var loginid = $("#loginid").val();
		
		if($.trim($("#username").val()).length==0){
			$("#username").css("border-color","red").focus();
			$("#warningMsg").text("이름을 입력해주세요.");
			return;
		}
		else if($.trim($("#loginid").val()).length<6 || $.trim($("#loginid").val()).length > 20){
			$("#loginid").css("border-color","red").focus();
			$("#warningMsg").text("로그인 아이디는 6자 이상 20자 이하로 입력해주세요.");
			return;
		}
		else if(!chk_pw){
			$("#passwd").css("border-color","red").focus();
			$("#warningMsg").text("비밀번호 형식이 맞지 않습니다.");
			return;
		}
		else if($("#perid").val()==0){
			$("#perid").css("border-color","red").focus();
			$("#warningMsg").text("유저 권한을 선택해주세요.");
			return;
		}
		else{	
						
			MasDwrService.getUserCnt(loginid, 0,
		   		function(data) {
					if(data>0) {
						$("#loginid").css("border-color","red").select();
						$("#warningMsg").text(loginid +"는 사용할 수 없는 아이디 입니다.");
						return;				
					} else {
						if(confirm("사용자를 등록하시겠습니까?")) {
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
                    <div class="title">업체 정보</div>
                 	<div class="breadcrumbs"><span class="glyIcon"><img src="../img/navIcon.png" alt=""></span> 현재위치 : 계정 > 업체 > 업체정보</div>
                    <!-- title End -->
                </div>
                <!-- list Table Start -->
                                <table class="viewTable" style="width:680px">
				<colgroup>
				<col width="100">
				<col width="220">
				<col width="100">
				<col width="260">								
				</colgroup>
                    <tr>
                        <th>업체구분</th>
                        <td class="txtCenter"><%=corp.get("corptypename") %></td>
                        <th>업체명</th>
                        <td class="txtCenter"><%=corp.get("corpname") %></td>
                        <!--  
                        <th>등록자
                        <td class="txtCenter"><%=corp.get("insertusername") %> ( <%=DateUtil.getYMD(String.valueOf(corp.get("insertdate"))) %> )</td>
                      -->
                    </tr>
                </table>
                <br/>
             <div class="boxtitle3">
                    <!-- saveBtn Start -->
                    <div class="saveBtn4">
                        <!--  a class="btn btn-default btn-xs" href="#" id="btnPopup" data-toggle="modal" data-target="#myModal">업체수정</a-->
                        <a class="btn btn-danger btn-xs" href="#"  data-target="#myModal" id="btnPopup">사용자 등록</a>
                    </div>
                    <!-- saveBtn End -->
                    <h1 class="title4"><span class="glyphicon glyphicon-ok"></span> 사용자 목록</h1>
                </div>
                
                            
                <!-- list Table Start -->
                <table class="listTable3" style="width:800x">
				<colgroup>
				<col width="40">
			    <col width="160"><!-- 아이디 -->
			    <col width=""><!-- 사용자명 -->
				<col width="160"><!-- 계정 -->
				<col width="260"><!-- 업체명 -->
			    <col width="100"><!-- 권한 -->
			    <col width="160"><!-- 등록일 -->
				<col width="80"><!-- 담당자 -->
			   </colgroup>                   
				<thead>
                        <tr>
                            <th>No</th>
                            <th>아이디</th>
                            <th>사용자명</th>
                            <th>계정</th>
                            <th>업체명</th>  
                            <th>권한</th>
                            <th>등록일</th>
                            <th>등록자</th>
                            
                        </tr>
                    </thead>
                    <tbody>
<%

for(int k=0; k<userlist.size(); k++){
                                        
	User user = userlist.get(k);
    
	 
 %>                    
                    
                    
                        <tr>
                            <td><%=(k+1) %></td>
                             <td class="textLeft"><%=user.getLoginid() %></td>                           
                            <td class="textLeft"><a href="usermgr.do?a=userList&userid=<%=user.getUserid()%>"><%=user.getUsername() %></a></td>                           
                            <td><%=user.getCorptypename() %></td>
                            <td class="textLeft"><%=user.getCorpname() %></td>                           
                            <td class="textLeft"><%=user.getPername() %></td>                           
                            <td><%=user.getUpdatedate() %></td>
                            <td><%=user.getUpdateusername() %></td>                            
                        </tr>
<%} %>                        
                        
                        
                    </tbody>
                </table>
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
                    <h4 class="modal-title">사용자 등록</h4>
                </div>
                <div class="modal-body">
                    <!-- search form Start -->
                    <form id="frmRegist" name="formRegist2" method="post" action="usermgr.do?a=userRegist">
                        <table class="addTable">
                            <colgroup>
                                <col width="20%">
                                    <col width="">
                            </colgroup>
                            <tr>
                                <th>업체</th>
                                <td class="form-inline">
                                    <input type="hidden" name="corpid" id="corpid" value="<%=String.valueOf(corp.get("corpid")) %>"/>
                                    <span class="point label label-<%=corp.get("text") %>" style="width:80px; margin-right:10px"><%=corp.get("corptypename") %></span>                           
                             		<%=corp.get("corpname") %>
                                </td>
                            </tr>
               				<tr>
                                <th>사용자 이름</th>
                                <td class="form-inline">
                                    <input type="text" name="username" id="username" class="form-control input-sm" style="width:160px">
                                </td>
                            </tr>               				
                            <tr>
                                <th>로그인아이디</th>
                                <td class="form-inline">
                                    <input type="text" name="loginid" id="loginid" class="form-control input-sm" style="width:160px">
                                </td>
                            </tr>
               				<tr>
                                <th>비밀번호</th>
                                <td class="form-inline">
                                    <input type="text" name="passwd" id="passwd" class="form-control input-sm" style="width:160px">
                                    <span style="color:green;font-size:8pt;margin-left:20px">* 최소 1개의 숫자 혹은 특수 문자를 포함하여 6~20자로 입력해주세요.</span>
                                </td>
                            </tr>
                			<tr>
                                <th>권한</th>
                                <td class="form-inline">
                                    <select id="perid" name="perid" class="form-control input-sm" style="width:140px">
                                    </select>
                                </td>
                            </tr>
                            
                			<tr>
                                <th>허용아이피</th>
                                <td class="form-inline">
                                    <input type="text" name="ipstr" id="ipstr" class="form-control input-sm" mexlength=200 style="width:360px">
                                    <br/>
                                    <span style="color:green;font-size:8pt;margin-left:0px">
                                     * 허용 아이피는 , 구분자로 복수 입력 가능하며 아이피 대역은 %로 구분합니다.(최대 200byte 입력가능). 
                                    <br/>ex)192.168.0.1,192.168.0.%</span>
                                </td>
                            </tr>
                			<tr>
                                <th>현재 아이피</th>
                                <td class="form-inline">
                                    <%=request.getRemoteHost()%>
                                </td>
                            </tr>                             
                            <tr>                           
                        <th>등록일</th>
                            <td class="form-inline">
                                <%=DateUtil.getYMDHM(String.valueOf(corp.get("insertdate")), "-") %>
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

