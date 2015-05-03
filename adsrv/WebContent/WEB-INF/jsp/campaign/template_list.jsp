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
	
	String sch_column = StringUtil.isNull(request.getParameter("sch_column"));
	String sch_text = StringUtil.isNull(request.getParameter("sch_text"));
	String s_type = StringUtil.isNull(request.getParameter("s_type"));
	
	sch_text = new String (sch_text.getBytes("8859_1"),"UTF-8");
	  
	Map<String,Object> map = (Map)request.getAttribute("response");

	List<Map<String,String>> tmplist = (List<Map<String,String>>)map.get("tmplist");   

	
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
$(function(){
		
	
});
</script>
<body>
    <div class="container-fluid containerBg">
 <div class="containerBox">
        <%@ include file="../common/header.jsp"  %>
             <section class="sectionBox">
                <div class="boxTitle">
                    <!-- title Start -->
                    <div class="title">템플릿 목록</div>
                    <div class="breadcrumbs"><span class="glyIcon"><img src="<%=web%>/img/navIcon.png" alt=""></span> 현재위치 : 캠페인 > 템플릿 > 템플릿 목록</div>
                    <!-- title End -->
                </div>
                <!-- ads add title Start -->
                <!-- search group Start -->
				<form id="frmList" name="frmList" method="get" action="cpmgr.do?a=tmpList">
 				<input type="hidden" name="a" value="tmpList"/>
				<input type="hidden" name="p" id="page"/>
                    <div class="form-inline">
                        <div class="form-group">
                             <select id="sch_column" name="sch_column" class="form-control input-sm">
                                <option value="tmpname" <%=sch_column.equals("tmpname")?"selected":"" %>>템플릿명</option>
                                <option value="tmpcode" <%=sch_column.equals("tmpcode")?"selected":"" %>>코드</option>
                                <option value="memo" <%=sch_column.equals("memo")?"selected":"" %>>설명</option>
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
                    <a class="btn btn-danger" href="cpmgr.do?a=tmpForm">템플릿등록</a>
                </div>                  
                <!-- saveBtn End -->
                <br>
                <!-- list Table Start -->
                <table class="listTable">
				<colgroup>
				<col width="40">
				<col width="280"><!-- 템플릿명 -->
				<col width="360"><!-- 설명 -->
			    <col width="280"><!-- 등록일 -->
				<col width="200"><!-- 담당자 -->
					</colgroup>                   
				<thead>
                        <tr>
                            <th>No</th>
                            <th>템플릿명</th>  
                            <th>설명</th>  
                            <th>등록일</th>
                            <th>등록자</th>
                            
                        </tr>
                    </thead>
                    <tbody>
<%

for(int k=0; k<tmplist.size(); k++){
                                        
	Map<String,String> tmp = tmplist.get(k);
    
	 
 %>                    
                    
                    
                        <tr>
                            <td><%=skip+(k+1) %></td>
                            <td class="textLeft"><a href="cpmgr.do?a=tmpView&tmpid=<%=String.valueOf(tmp.get("tmpid"))%>"><%=tmp.get("tmpname") %></a></td>                           
                            <td class="textLeft"><%=StringUtil.cutByteLength(tmp.get("memo"),80) %></td>
                            <td><%=DateUtil.getTimeStr(String.valueOf(tmp.get("updatedate"))) %></td>
                            <td><%=tmp.get("updateusername") %></td>                            
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
                    <h4 class="modal-title">템플릿 등록</h4>
                </div>
                <div class="modal-body">
                    <!-- search form Start -->
                    <form id="frmRegist" name="frmRegist" method="post" action="cpmgr.do?a=tmpRegist">
                    <input type="text" name="tmpid" id="tmpid" value=0/>
                        <table class="addTable" style="width:980px;height:600px;">
                            <colgroup>
                                <col width="20%">
                                    <col width="">
                            </colgroup>
                            <tr>
                                <th>템플릿명<span style="color:red"> * </span></th>
                                <td>                              
                                     <input type="text" name="tmpname" id="tmpname" class="form-control input-sm"  style="width:280px">                                    
	 					         </td>
                            </tr>
                            <tr>
                                <th>설명<span style="color:red"> * </span></th>
                                <td class="form-inline">
                                    <input type="text" name="memo" id="memo" class="form-control input-sm" style="width:600px">                                    
                                </td>
                            </tr>
                             <tr>
                                <th>템플릿 코드<span style="color:red"> * </span></th>
                                <td class="form-inline">
                                   <textarea id="tmpcode" name="tmpcode" class="form-control input-sm" rows="10" style="width:770px;height:300px;"></textarea>
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

