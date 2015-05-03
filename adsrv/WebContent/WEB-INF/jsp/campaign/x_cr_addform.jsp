<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/common.jsp" %>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="tv.pandora.adsrv.common.util.StringUtil"%>
<%@page import="tv.pandora.adsrv.common.util.DateUtil"%>    
<%@page import="tv.pandora.adsrv.domain.Creative"%>    
<% 
try
{
	String client = StringUtil.isNull(request.getParameter("client"));

	Map<String,Object> map = (Map)request.getAttribute("response");

	List<Map<String,String>> codelist = (List<Map<String,String>>)map.get("codelist");   
	List<Map<String,String>> tmplist = (List<Map<String,String>>)map.get("tmplist");   
	
  	
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
<script src="<%=web%>/js/jquery.form.min.js"></script>
<script>
/*jQuery form 플러그인을 사용하여 폼데이터를 ajax로 전송*/

var downGroupCnt =0; //다운로드그룹 개수카운트

function del(idx) {
	$("#url"+idx).remove();	
	$("#img"+idx).remove();	
}
$(function(){
    
    //폼전송 : 해당폼의 submit 이벤트가 발생했을경우 실행  
    $('#frmFile').ajaxForm({
       cache: false,
       dataType:"json",
       //보내기전 validation check가 필요할경우
       beforeSubmit: function (data, frm, opt) {
           //console.log(data);
           //alert("전송전!!");
           return true;
       },
       //submit이후의 처리
       success: function(data, statusText){
           
           //alert("전송성공!!");
           console.log("data=="+data); //응답받은 데이터 콘솔로 출력         
           //$("#result").empty(); //내용 비우기, 업로드 후 하나의 그룹만 볼려면 사용
           
           //업로드한 파일을 다운로드할수있도록 화면 구성
            if(data.photo){
               $.each(data.photo, function(index, item){
            	   console.log("item.imgUrl="+item.imgUrl);
               	   console.log("item.fileName="+item.fileName);
               	   var htmlStr = "";
               	   //var link = "FileDownload?f="+item.imgUrl+"&of="+item.fileName;
                  
               	   
				  	htmlStr += "<div id='url"+item.fileIdx+"' style='border-bottom:1px solid #eee;margin:1px;padding:3px;overflow:hidden;'>";                   
					htmlStr += "<a href='javascript:del("+item.fileIdx+")' name='btnDel' idx='"+item.fileIdx+"'><span class='glyphicon glyphicon-remove' style='width:30px'></span></a>";					
					htmlStr += "<a href='"+ item.imgUrl +"' target='_new'><span class='glyphicon glyphicon-download' style='width:30px'></span></a>";					
					htmlStr += "<input type='hidden' name='filename' value='"+item.fileName+"'>";
					htmlStr += "<input type='hidden' name='filesize' value='"+item.fileSize+"'>";
					htmlStr += "<input type='hidden' name='imgurl' value='"+item.imgUrl+"'>";
					htmlStr += "<input type='hidden' name='contenttype' value='"+item.contentType+"'>";
					htmlStr += "<input type='hidden' name='fileidx' value='"+item.fileIdx+"'>";
					//htmlStr += "<a href='"+ item.imgUrl +"' target='_new' download>"+
					htmlStr += item.imgUrl;
					//+"</a>";
					htmlStr += "</div>";                 
                    $("#result").append(htmlStr);
                   $("#imgs").append("<span id='img"+item.fileIdx+"'><a href='"+ item.imgUrl +"' target='_new' download><img src='"+ item.imgUrl +"' style='width:100px;'/></a></span>");                  
              });
           }     
           /*       
           if(data.photo){
           $("#result").append("포토:<br/>");           
           $.each(data.photo, function(index, item){
               var link = "FileDownload?f="+item.uploadedFileName+"&of="+item.fileName;
               $("#result").append("<a href='"+ link +"' download>"+item.fileName+"</a>");
               $("#result").append("<br/>");                   
           });
       }           
       if(data.file){
          var link = "FileDownload?f="+data.file.uploadedFileName+"&of="+data.file.fileName;
          $("#result").append("파일 :<a href='"+ link +"' download>"+data.file.fileName+"</a>");
          $("#result").append("<br/>");
       }
           */
           
           //다운로드시 크롬에서 다음 오류 발생.
           //오류 : Resource interpreted as Document but transferred with MIME type 
           //       application/octet-stream 
           //해결 :
           //You can specify the HTML5 download attribute in your <a> tag.
           //<a href='http://example.com/archive.zip' download>Export</a>
           //https://developer.mozilla.org/en-US/docs/Web/HTML/Element/a#attr-download
                                 
          // $('#multiform')[0].reset(); 폼 초기화(리셋);
           
           //IE에서 폼 리셋후 input[type=file] 초기화 안되는 문제. 
           //(파일이름은 지워지지만 files 프로퍼티에는 파일정보 남아있음.)
           //참고 : http://javaking75.blog.me/220073388169
           //console.log(navigator.userAgent);           
           if (/(MSIE|Trident)/.test(navigator.userAgent)) {
               // ie 일때 input[type=file] init.
               $("#frmRegist input[type=file]").each(function(index){
                   $(this).replaceWith( $(this).clone(true) );
               });        
           }
       },
       //ajax error
       error: function(e){
           alert("에러발생!!");
           console.log(e);
       }                               
    });
    
    $("a[name=btnDel]").on("click", function(e){
    	alert("aaa");
		var fileIdx = $(this).attr("idx");
		console.log("btnDel fileIdx=="+fileIdx);
		$(this).parent("div").remove();
		$("#img"+fileIdx).remove();			
		
	});	

});

</script>
<script type="text/javascript">

  $(document).ready(function() {
	  
	    $.ajax({		    
			url : "cpmgr.do?a=auto_corp&corptype=1",
		    datatype:"json",
		    success:function(data, type){	     
		        test = eval("(" + data + ")");	      
				$( "#client" ).autocomplete({
					source:test,
					focus: function(event, ui) {
						return false;
					},
					select: function(event, ui) {
						$('#client').val(ui.item.label);
						$('#clientid').val(ui.item.value);
						$('#clientname').val(ui.item.label);
						$("#client").css("border-color","green").focus();
						return false;
					},					
					change: function(event, ui) {					
						if($('#clientname').val()!="") {
							if($('#client').val()!=$('#clientname').val()) {
								$('#clientid').val("");
								$('#clientname').val("");
								$("#client").css("border-color","red");						
							}
						} 
						return false;
					}		

				});
			}
		});
	    
		$("#btnAddClick").on("click", function(e){
			$("#new_clickname, #new_clickurl").css("border-color", "#ccc");
			$("#swarningMsg").text("");
			e.preventDefault();
			
			if($.trim($("#new_clickname").val()).length==0){
				$("#new_clickname").css("border-color","red").focus();
				$("#swarningMsg").text("클릭명을 입력해주세요.");
				return false;
			}else if($.trim($("#new_clickurl").val()).length==0){
				$("#new_clickurl").css("border-color","red").focus();
				$("#swarningMsg").text("클릭 URL을 입력해주세요.");
				return false;
			}else if($("#"+$.trim($("#new_clickname").val())).size()>0){
				$("#new_clickname").css("border-color","red").focus();
				$("#swarningMsg").text("중복된 클릭명이 있습니다.");
				return false;
			}else{
				var htmlstr = "";
				
				var cname = $.trim($("#new_clickname").val());
				var curl = $.trim($("#new_clickurl").val());
				

				htmlstr += '<div class="clickLinkBox" id="'+cname+'">';
				htmlstr += '<span class="clickName">'+cname+'<input type="hidden" name="clickname" value="'+cname+'"/></span>';
				htmlstr += '<span class="clicklink"><a href="'+curl+'">'+curl+'</a><input type="hidden" name="clickurl" value="'+curl+'"/></span>';
				htmlstr += '<a href="#none" class="btn btn-link" name="btnRemove"><span class="glyphicon glyphicon-remove"></span></a>';
				htmlstr += '</div>';

				$("#divClick").append(htmlstr);
				$("#new_clickname").val("");
				$("#new_clickurl").val("");
            
			}
			
		});

		$(document).on("click", "a[name=btnRemove]", function(e){
			$(this).parent("div").remove();
		});	  
		$("#btnRegist").on("click", function(e){	
			
			
			$("#frmRegist input, #frmRegist select").css("border-color", "#ccc");
			$("#warningMsg").text("");
			e.preventDefault();
			if($("#crname").val()==0){
				$("#crname").css("border-color","red").focus();
				$("#warningMsg").text("광고물 이름을 입력해주세요.");
				return;
			} else if($("#clientid").val()==0){
				$("#client").css("border-color","red").focus();
				$("#warningMsg").text("광고주를 선택해주세요.");
				return false;
			} else if($("#prtype").val()==0){
				$("#prtype").css("border-color","red").focus();
				$("#warningMsg").text("광고상품을 선택해주세요.");
				return;
			} else if($.trim($("#width").val()).length==0){
				$("#width").css("border-color","red").focus();
				$("#warningMsg").text("사이즈를 입력해주세요.");
				return;
			} else if($.trim($("#height").val()).length==0){
				$("#height").css("border-color","red").focus();
				$("#warningMsg").text("사이즈를 입력해주세요.");
				return;
			} else{	
				var cname = $('#crname').val();			
				
				MasDwrService.getCreativeCnt(cname, 0, 
			   		function(data) {
						if(data>0) {
							$("#crname").css("border-color","red").select();
							$("#warningMsg").text("중복된 이름이 있습니다.");
							return;				
						} else {
							if(confirm("광고물을 등록하시겠습니까?")) {
								
								  $("#frmRegist").submit();	
																
							}					
						}
				});
			}
		});
		
		$("#tagTmp").on("change", function(e){
			e.preventDefault();
			var tmpid = $(this).val();
			MasDwrService.getTemplate(tmpid,
			   		function(data) {
						$("#richmedia").text(data.tmpcode);
				});
		});


  });
  
 </script>
</head>

<body>
    <div class="container-fluid containerBg">
        <div class="containerBox">
        <%@ include file="../common/header.jsp"  %>
<section class="sectionBox">
                <div class="boxTitle">
                    <!-- title Start -->
                    <div class="title">광고물 등록</div>
                    <div class="breadcrumbs"><span class="glyIcon"><img src="<%=web%>/img/navIcon.png" alt=""></span> 현재위치 : 캠페인 > 광고물 > 광고물 등록</div>
                    <!-- title End -->
                </div>
                <!-- add Table Start -->
                   <form name="frmRegist" id="frmRegist" class="mfsubmit" action="cpmgr.do?a=crRegist" method="POST">    
                    <table class="addTable" style="width:1080px">
                        <colgroup>	
                            <col width="8%">
                            <col width="42%">
                            <col width="8%">
                            <col width="42%">                        
                        </colgroup>
                          <tr>
                            <th>광고물명<span style="color:red"> * </span></th>
                            <td>
                                <input type="text" id="crname" name="crname" class="form-control input-sm" style="width:240px">
                            </td>
                            <th>템플릿</th>
                            <td>
                                <select id="tagTmp" name="tmpid" class="form-control form-sm" style="width:280px">
	                             <option value="0">선택</option>
	                                <%for(int i=0;i<tmplist.size();i++){ 
	                                	Map<String,String> tmp = tmplist.get(i);
	                                %>
	                                <option value="<%=String.valueOf(tmp.get("tmpid")) %>" ><%=tmp.get("tmpname") %></option>                               
	                                <%} %>
                               </select>
                               
                               
                            </td>
                        </tr>
                        <tr>
                            <th>광고주<span style="color:red"> * </span></th>
                            <td>
 					    		<input class="debug" size=8 type="hidden" name="clientname" id="clientname"/>
					    		<input class="debug" size=4 type="hidden" name="clientid" id="clientid" value="0"/>
                                <input type="text"  id="client" class="form-control input-sm" autocomplete="off" style="width:300px" placeholder="">					     
                            </td>
                            <th rowspan="7">코드</th>
                            <td rowspan="7">
                                <textarea id="richmedia" name="richmedia" class="form-control input-sm" rows="32" style="width:400px"></textarea>
                            <table class="opacityTable">
                                    <colgroup>
                                        <col width="20%">
                                        <col width="">
                                        <col width="20%">
                                        <col width="">
                                    </colgroup>
                                    <tr>
                                        <th>--IMG--</th>
                                        <td>: 광고물위치</td>
                                        <th>--ICONIMG--</th>
                                        <td>: 아이콘</td>
                                    </tr>
                                    <tr>
                                        <th>--WIDTH--</th>
                                        <td>: 가로</td>
                                        <th>--ICONWIDTH--</th>
                                        <td>: 아이콘 가로</td>
                                    </tr>
                                    <tr>
                                        <th>--HEIGHT--</th>
                                        <td>: 세로</td>
                                        <th>--ICONHEIGHT-</th>
                                        <td>: 아이콘 세로</td>
                                    </tr>
                                 </table>
                            	<div id="divClick2"></div>
                            	<div id="result2"></div>
                            
                            </td>
                          </tr>
                        <tr>
                            <th>광고상품<span style="color:red"> * </span></th>
                            <td>
	                            <select name="prtype" id="prtype" class="form-control input-sm" style="width:100px">
	                                <%for(int i=0;i<codelist.size();i++){ 
	                                	Map<String,String> code = codelist.get(i);
	                                %>
	                                <option value="<%=String.valueOf(code.get("isid")) %>"><%=code.get("isname") %></option>                               
	                                <%} %>
	                            </select>
                            </td>
                        </tr>
                        <tr>
                            <th>사이즈<span style="color:red"> * </span></th>
                            <td>
                                <div class="form-inline">
                                    <input type="text" name="width" id="width" class="form-control input-sm" style="width:60px" placeholder="가로"> x
                                    <input type="text" name="height" id="height" class="form-control input-sm" style="width:60px" placeholder="세로">
                                </div>
                            </td>
                        </tr>
                       
                        <!--  
                        <tr>
                            <th>광고물위치</th>
                            <td>
                                <div class="input-group" style="width:341px">
                                    <input id="imgUrl" type="text" class="form-control form-sm">
                                    <span class="input-group-btn">
                                    <button class="btn btn-success btn-sm" type="button" target="_new" id="btnImgUrl"><span class="glyphicon glyphicon-map-marker"></span>
                                    </button>
                                    </span>
                                </div>
                            </td>
                        </tr>-->

              
                        
                         
                        
                        <tr>
                            <th>클릭링크</th>
                            <td style="vertical-align:'top'">
                                <div class="form-inline"  style="height:30px">
                                    <input type="text" id="new_clickname" class="form-control input-sm" style="width:100px" placeholder="클릭명" value="CLICK">
                                    <input type="text" id="new_clickurl" class="form-control input-sm" style="width:210px" placeholder="클릭 URL">
                                    <button class="btn btn-success btn-sm" id="btnAddClick"><span class="glyphicon glyphicon-plus"></span>
                                    </button>
                                </div>
                                <span id="swarningMsg" style="color:#a00"></span>
                            </td>
                          </tr>
                          <tr>      
                           <th>클릭링크</th>
                           <td>     
                                <div id="divClick" style="height:100px">
	                            </div>
                            </td>
                        </tr>
                        <tr>
                            <th>업로드<br/>파일 목록</th>
                            <td style="height:100px">
                             
                                <div id="result">                                  
                                </div>
                                <div id="imgs" style="float:left" style="height:100px">
                                </div>
                             <!--    
                                <div id="result" style="font-size:1em;height:80px;width:430px;border:1px solid #ccc;overflow:auto;"></div>
-->
                            </td>
                        </tr>
                    </table>
                </form>
                        <table class="addTable" style="width:1080px">
                        <colgroup>	
                            <col width="8%">
                             <col width="*">                        
                        </colgroup>
                          <tr>
                            <th>파일업로드</th>
                            <td>
                                <form name="frmFile" id="frmFile" action="FileUploadServlet" method="POST" enctype="multipart/form-data">
            					<div class="input-group" style="width:276px">
                                    <input type="text" class="form-control form-sm" readonly>
                                    <span class="input-group-btn">
                                        <span class="btn btn-success btn-sm btn-file">
                                            <span class="glyphicon glyphicon-paperclip"></span>
                                    		<input name="photo" type="file" class="form-sm" multiple>
                                    	</span>
                                    	<span  style="padding:4px"><input type="submit" id="btnSubmit" value="업로드" class="btn btn-default btn-sm"/></span>
                                    </span>
                                               
                                </div>
                                </form> 
                            </td>
                   </tr>
                   </table>
                <!-- add Table End -->
                <!-- button group Start -->
                <div class="buttonGroup" style="width:1080px">
                	<span id="warningMsg" style="color:#a00"></span>
                    <button type="button" class="btn btn-default btn-sm" id="btnCopy">뒤로</button>
                    <button type="button" class="btn btn-default btn-sm" id="btnCopy">복사</button>
                    <button type="button" class="btn btn-default btn-sm" id="btnRegist">삭제</button>
                    <button type="button" class="btn btn-default btn-sm" id="btnRegist">수정</button>
               		<button type="button" class="btn btn-default btn-sm" id="btnCopy">리포트</button>
                </div>
                <!-- button group End -->
            </section>


        </div>
    </div>
<%
} catch(Exception e) {
    e.getMessage();
}
%> 
</body>

</html>
