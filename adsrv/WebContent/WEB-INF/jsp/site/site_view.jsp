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
	Map<String,Object> map = (Map)request.getAttribute("response");

	Map<String,String> site = (Map<String,String>)map.get("site");
	List<Slot> slotlist = (List<Slot>)map.get("slotlist");   
	List<Map<String,String>> seclist = (List<Map<String,String>>)map.get("seclist");   
	List<Map<String,String>> codelist = (List<Map<String,String>>)map.get("codelist");   
   
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


<body>
    <div class="container-fluid containerBg">
 <div class="containerBox">
        <%@ include file="../common/header.jsp"  %>
             <section class="sectionBox">
                <div class="boxTitle">
                    <!-- title Start -->
                    <div class="title">업체 정보</div>
                 	<div class="breadcrumbs"><span class="glyIcon"><img src="<%=web%>/img/navIcon.png" alt=""></span> 현재위치 : 계정 > 업체 > 업체정보</div>
                    <!-- title End -->
                </div>
                <!-- list Table Start -->
                
                
 
<!-- Modal -->
<div class="modal fade" id="OutModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
      </div>
      </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
                
                
                <table class="viewTable" style="width:680px">
				<colgroup>
				<col width="100">
				<col width="220">
				<col width="100">
				<col width="260">								
				</colgroup>
                    <tr>
                        <th>사이트명</th>
                        <td class="txtCenter"><%=site.get("sitename") %></td>
                         <th>업체</th>
                        <td class="txtCenter"><%=site.get("corpname") %></td>
                    </tr>
                    <tr>
                       <th>사이트구분</th>
                        <td class="txtCenter"><%=site.get("sitetypename") %></td>
                      <th>태그아이디</th>
                        <td class="txtCenter"><%=site.get("sitetag") %></td>
                         
                    </tr>
                   <tr>
                       <th>URL</th>
                        <td class="txtLeft"><%=StringUtil.isNull(site.get("siteurl")) %></td>
                      <th>설명</th>
                        <td class="txtLeft"><%=StringUtil.isNull(site.get("memo")) %></td>
                        
                    </tr>
                </table>
                <br/>
             <div class="boxtitle3">
                    <!-- saveBtn Start -->
                    <div class="saveBtn4">
                        <!--  a class="btn btn-default btn-xs" href="#" id="btnPopup" data-toggle="modal" data-target="#myModal">업체수정</a-->
                         <a class="btn btn-success btn-sm" href="#none" id="btnPopup2" data-target="#myModal2">섹션 등록</a>
                    
                        <a class="btn btn-danger btn-sm" href="#"  data-target="#myModal" id="btnPopup">위치 등록</a>
                    </div>
                    <!-- saveBtn End -->
                    <h1 class="title4"><span class="glyphicon glyphicon-menu-down"></span> 위치 목록</h1>
                </div>
                
                            
                <!-- list Table Start -->
                <table class="listTable3" style="width:800x">
				<colgroup>
				<col width="40">
			     <col width="160"><!-- 사이트 -->
			   <col width="160"><!-- 섹션 -->
			    <col width=""><!-- 위치 -->
				<col width="260"><!-- 업체명 -->
			    <col width="100"><!-- 권한 -->
			    <col width="160"><!-- 등록일 -->
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
                            <td><%=(k+1) %></td>
                             <td><%=slot.getSitename() %></td>
                            <td><%=slot.getSecname() %></td>
                             <td class="textLeft"><a href="#none" name="slotmod" slotid="<%=slot.getSlotid()%>"><%=slot.getSlotname() %></a></td>                           
                            <td class="textLeft">
                            <!--  a href="javascript:newTab2('<%=Constant.ADTAG_SERVER%>/<%=slot.getSlottag()%>/')"-->
                            
                            <a class="btn btn-primary btn-lg external" data-toggle="modal" width="<%=slot.getWidth() %>" width="<%=slot.getHeight() %>" href="<%=Constant.ADTAG_SERVER%>/<%=slot.getSlottag()%>/" data-target="#OutModal">Click me</a>
                            
                            <%=slot.getSlottag()%></a></td>
                            <td><%=slot.getWidth() %> x <%= slot.getHeight()%></td>
                           <td><%=DateUtil.getYMD(slot.getUpdatedate()) %></td>
                            <td><%=slot.getUpdateusername() %></td>
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
              <form id="frmSlot" name="frmSlot" method="post" action="sitemgr.do?a=slotRegist">
             	<input type="hidden" name="a" value="slotRegist">
                <input type="hidden" name="siteid" value=<%=String.valueOf(site.get("siteid")) %>"/>
               	<input type="text" id="slotid" name="slotid" class="debug">
              	<input type="text" id="change" name="change" value="" class="debug">
               <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                    </button>
                   <h4 class="modal-title new">위치 등록</h4><h4 class="modal-title modify">위치 수정</h4>
                 </div>
                <div class="modal-body">
                    <!-- search form Start -->
                       <table class="addTable" style="width:560px">
                            <colgroup>
                                <col width="20%">
                                    <col width="">
                            </colgroup>
 	                        <tr>
                                <th>사이트<span style="color:red"> * </span></th>
                                <td><%=site.get("sitename") %> (<%=site.get("sitetag") %>)
	 					         </td>
                            </tr>
                            <tr>
                                <th>섹션<span style="color:red"> * </span></th>
                                <td>                              
                                	<select id="secid" name="secid" class="new form-control input-sm" style="width:160px">
                                	<option value="0">선택</option>	                                
 	                                <% for(int i=0;i<seclist.size();i++){ 
	                                	Map<String,String> sec = seclist.get(i);
	                                %>
	                               <option value="<%=String.valueOf(sec.get("secid")) %>" sectag="<%=sec.get("sectag") %>"><%=sec.get("secname") %></option>                               
	                                  <%} %>
                                	</select>
                                	<span id="secname" class="modify"></span>
                                	
	 					         </td>
                            </tr>                                                     
                           <tr>
                                <th>위치명<span style="color:red"> * </span></th>
                                <td class="form-inline">
                                     <input type="text" name="slotname" id="slotname" class="form-control input-sm" style="width:280px">                                    
                               </td>
                            </tr>
                             <tr>
                                <th>태그 아이디<span style="color:red"> * unique</span></th>
                                <td class="form-inline"><span id="tagstr" style="padding:5px;font-size:11pt"></span>
                                  <input type="text" size=4 id="sitetag" class="debug" value="<%=site.get("sitetag") %>"/>
                                    <input type="text" size=4 id="sectag" class="debug"/>
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
                 </div>
                <div class="modal-footer">
                	<span id="warningMsg" style="color:#a00"></span>
                      <button type="button" class="new btn btn-danger btn-sm" id="btnSlotRegist">등록</button>                    
                    <button type="button" class="modify btn btn-danger btn-sm" id="btnSlotUpdate">수정</button>                    
                   <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
               </div>
                   </form>
             </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->

    <!-- modal End -->

 <!-- modal Start -->
    <div class="modal fade" id="myModal2">
        <!-- modal-lg  | default | modal-sm -->
        <div class="modal-dialog default">
            <div class="modal-content">
               <form id="frmSec" name="frmRegist" method="post" action="sitemgr.do?a=secRegist">
               		<input type="hidden" name="a" value="secRegist">
                 	<input type="hidden" id="secid" name="secid" class="debug">
                	<input type="hidden" id="change" name="change" value="" class="debug">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title new">섹션 등록</h4><h4 class="modal-title modify">섹션 수정</h4>
                </div>
                <div class="modal-body">
                    <!-- search form Start -->
                        <table class="addTable" style="width:560px">
                            <colgroup>
                                <col width="20%">
                                    <col width="">
                            </colgroup>
                            <tr>
                                <th>사이트<span style="color:red"> * </span></th>
                                <td>
                                <%=site.get("sitename") %> (<%=site.get("sitetag") %>)<input type="hidden" name="siteid" value=<%=String.valueOf(site.get("siteid")) %>"/>
	 					         </td>
                            </tr>
                            <tr>
                      
                                <th>섹션명<span style="color:red"> * </span></th>
                                <td class="form-inline">
                                    <input type="text" name="secname" id="secname" class="form-control input-sm" width="240px">                                    
                                </td>
                            </tr>
                            <tr>
                                <th>태그 아이디<span style="color:red"> * unique</span></th>
                                <td class="form-inline">
                                    <input type="text" name="sectag" id="sectag" class="form-control input-sm" width="240px" placeholder="">
                                </td>
                            </tr>
                        <tr>
                                <th>설명</th>
                                <td class="textLeft">
                                    <textarea name="memo" id="memo" class="form-control" rows="6"  maxlength="100" style="width:360px"></textarea>
                                </td>
                            </tr>
                         
                        <tr>                           
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
                 </div>
                <div class="modal-footer">
                	<span id="warningMsg" style="color:#a00;font-size:8pt"></span>
                      <button type="button" class="new btn btn-danger btn-sm" id="btnSecRegist">등록</button>                    
                    <button type="button" class="modify btn btn-danger btn-sm" id="btnSecUpdate">수정</button>                    
                   <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
               </div>
               </form>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->



    
    
       <!-- js start -->
    <script src="<%=web%>/js/jquery-1.11.1.js"></script>
    <script src="<%=web%>/js/bootstrap.js"></script>
    <script src="<%=web%>/js/basic.js"></script>
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    <!-- js end -->
<script type="text/javascript">

$('a.external').on('click', function(e) {
    e.preventDefault();
    var url = $(this).attr('href');
    $("#OutModal .modal-body").html('<iframe width="100%" height="100%" frameborder="0" scrolling="yes" allowtransparency="true" src="'+url+'"></iframe>');

});

$('#OutModal').on('show.bs.modal', function () {
	   var myWidth = $(this).attr('width');
	    var myHeight = $(this).attr('height');
	 
    $(this).find('#OutModal .modal-dialog').css({
              width: myWidth, //choose your width
              height:myHeight, 
              'padding':'0'
       });
     $(this).find('#OutModal .modal-content').css({
              height:'100%', 
              'border-radius':'0',
              'padding':'0'
       });
     $(this).find('#OutModal .modal-body').css({
              width:'auto',
              height:'100%', 
              'padding':'0'
       });
})














function newTab2(link){
	if(link.length>0) {
		var tab=window.modal(link,'_blank'); 
		   //tab.focus(); 
	}
}

$(document).ready(function() 
{
	formReset = function(frmId){
		$("form").each(function() {  
            if(this.id == frmId) this.reset();  
         }); 		
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
	$('#secid').change(function(e){	
		var secid = $("#secid").val();
		var sectag = "";
		if(secid!=0){
			sectag = $("select[name='secid'] option[value="+secid+"]:selected").attr("sectag");					
		} 
		$("#sectag").val(sectag);	
		tagStr();
	});	
	$("#btnPopup").click(function(e){
				
		e.preventDefault();
		formReset("frmSlot");
		tagStr();
		$('#myModal').modal();
		$("#frmSlot .modify").css("display", "none");
		$("#frmSlot.new").css("display", "");
		$("#frmSlot.debug").val(""); //값 초기화	 (siteid, change)	
	});
$("#btnSlotRegist").on("click", function(e){		
	e.preventDefault();
	if($("#frmSlot select[name=secid]").val()==0){
		$("#frmSlot select[name=secid]").css("border-color","red").focus();
		$("#frmSlot #warningMsg").text("섹션을 선택해주세요.");
		return;
	} else if($.trim($("#frmSlot [name=slottag]").val()).length==0){
		$("#slottag [name=slottag]").css("border-color","red").focus();
		$("#frmSlot #warningMsg").text("태그 아이디를 입력해주세요.");
		return;
	} else if($.trim($("#frmSlot [name=slotname]").val()).length==0){
		$("#frmSlot [name=slotname]").css("border-color","red").focus();
		$("#frmSlot #warningMsg").text("위치 이름을 입력해주세요.");
		return;
	} else if($.trim($("#width").val()).length==0){
		$("#width").css("border-color","red").focus();
		$("#frmSlot #warningMsg").text("사이즈를 입력해주세요.");
		return;
	} else if($.trim($("#height").val()).length==0){
		$("#height").css("border-color","red").focus();
		$("#frmSlot #warningMsg").text("사이즈를 입력해주세요.");
		return;
	} /*else if($("#memo").val().length > $("#memo").attr("maxlength")){
		$("#memo").css("border-color","red").focus();
		$("#warningMsg").text($("#siteurl").attr("maxlength")+"자 이하로 입력하셔야 합니다.");
		return;
	} */
	else{	
		var cname = $.trim($('#frmSlot [name=slottag]').val());			
		var siteid = $('#frmSlot [name=siteid]').val();		
		
		MasDwrService.getSlotCnt(cname, siteid, 0, 
	   		function(data) {
				if(data>0) {
					$("#frmSlot [name=slottag]").css("border-color","red").select();
					$("#frmSlot #warningMsg").text("중복된 태그 아이디가 있습니다.");
					return;				
				} else {
					if(confirm("위치를 등록하시겠습니까?")) {
						$("#frmSlot").submit();	
					}					
				}
		});
	}

});

$("#btnPopup2").click(function(e){	
	$('#myModal2').modal();
	e.preventDefault();
	$("#frmSec .modify").css("display", "none");
	$("#frmSec .new").css("display", "");
	$('#frmSec [name=secname]').focus();
});
$("#btnSecRegist").on("click", function(e){		
	console.log("btnSecRegist");
	
	e.preventDefault();
	if($.trim($("#secname").val()).length==0){
		$("#secname").css("border-color","red").focus();
		$("#warningMsg").text("섹션 이름을 입력해주세요.");
		return;
	} else if($.trim($("#sectag").val()).length==0){
		$("#sectag").css("border-color","red").focus();
		$("#warningMsg").text("태그 아이디를 입력해주세요.");
		return;
	} 
	else{	
		var cname = $.trim($('#frmSec [name=sectag]').val());			
		var siteid = $('#frmSec [name=siteid]').val();		
		
		MasDwrService.getSecCnt(cname, siteid, 0,  
				
			function(data) {
					var cnt = parseInt(data,10);
					if(cnt>0) {
						$("#sectag").css("border-color","red").select();
						$("#warningMsg").text("사이트 내에 중복된 태그 아이디가 있습니다.\r\n다른 태그 아이디를 입력해주세요.");
						return;				
					} else {
						if(confirm("섹션을 등록하시겠습니까?")) {
							$("#frmSec").submit();	
						}					
					}
				
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

