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
	String sch_text = StringUtil.isNull(request.getParameter("sch_text"));
	String s_type = StringUtil.isNull(request.getParameter("s_type"));
	
	Map<String,Object> map = (Map<String,Object>)request.getAttribute("response");

	User user = (User)map.get("user");   
	
	List<Map<String,String>> perlist = (List<Map<String,String>>)map.get("perlist");   

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
<script type="text/javascript">


$(function(){

	$('#myModal').modal();

	$("#btnRegist").on("click", function(e){		
		e.preventDefault();
		if($.trim($("#corpname").val()).length==0){
			$("#corpname").css("border-color","red").focus();
			$("#warningMsg").text("이름을 입력해주세요.");
			return;
		}
		else{	
			var cname = $('#corpname').val();			
			MasDwrService.getCorpCnt(cname,
		   		function(data) {
					if(data>0) {
						$("#corpname").css("border-color","red").select();
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
    <!-- modal Start -->
    <div class="modal fade" id="myModal">
        <!-- modal-lg  | default | modal-sm -->
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">사용자 정보 수정</h4>
                </div>
                <div class="modal-body">
                    <!-- search form Start -->
                    <form id="frmRegist" name="formRegist2" method="post" action="usermgr.do?a=userRegist">
                    	<input type="hidden" name="a" value="userRegist"/>
                    	<input type="hidden" name="userid" value="<%=user.getUserid()%>"/>
                        <table class="addTable">
                            <colgroup>
                                <col width="20%">
                                    <col width="">
                            </colgroup>
                            <tr>
                                <th>업체</th>
                                <td class="form-inline">
                                    <input type="hidden" name="corpid" id="corpid" value="<%=user.getCorpid()%>"/>
                                    <span class="point label label-<%=user.getText()%>" style="width:80px; margin-right:10px"><%=user.getCorptype()%></span>                           
                             		<%=user.getCorpname()%>
                                </td>
                            </tr>
               				<tr>
                                <th>사용자 이름</th>
                                <td class="form-inline">
                                    <input type="text" name="username" id="username" value="<%=user.getUsername()%>" class="form-control input-sm" style="width:160px">
                                </td>
                            </tr>               				
                            <tr>
                                <th>로그인아이디</th>
                                <td class="form-inline">
                                    <input type="text" name="loginid" id="loginid" value="<%=user.getLoginid()%>" class="form-control input-sm" style="width:160px">
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
                                    <input type="text" name="allowip" id="allowip" value="<%=user.getAllowip()%>" class="form-control input-sm" mexlength=200 style="width:360px">
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
                        <th>최종수정일</th>
                            <td class="form-inline"><%=DateUtil.getYMDHM(user.getUpdatedate(), "-") %></td>
                        </tr> 
                        <tr>                       
                        <th>수정인</th>
                            <td class="form-inline"><%=user.getUpdateusername() %></td>
                        </tr>                        
                        </table>
                    </form>
                 </div>
                <div class="modal-footer">
                	<span id="warningMsg" style="color:#a00"></span>
                    <button type="button" class="btn btn-danger btn-sm" id="btnRegist">수정</button>                                       
                    <a class="btn btn-default" href="javascript:parent.closeModalPopup()">닫기</a>
                
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->

    <!-- modal End -->

</body>
<%
} catch(Exception e) {
    out.println(e.getMessage());
}
%>
</html>

