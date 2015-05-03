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
	
	<script src="<%=web%>/js/bootstrap.js"></script>
	<script src="<%=web%>/js/basic.js"></script>
	<script src="<%=web%>/js/common.js"></script>
	<script src="<%=web%>/js/jquery.form.min.js"></script>
	<script>
/*jQuery form 플러그인을 사용하여 폼데이터를 ajax로 전송*/

var downGroupCnt =0; //다운로드그룹 개수카운트

$(function(){
   //폼전송 : 해당폼의 submit 이벤트가 발생했을경우 실행  
    $('#multiform').ajaxForm({
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
           console.log(data); //응답받은 데이터 콘솔로 출력         
           //$("#result").empty(); //내용 비우기, 업로드 후 하나의 그룹만 볼려면 사용
           
           //업로드한 파일을 다운로드할수있도록 화면 구성
           //$("#result").append("<h3>("+(++downGroupCnt)+") 다운로드</h3>");
           //$("#result").append("제목:"+data.title+"<br/>");
           //$("#result").append("설명:"+data.description+"<br/>");
     		$("#crname").val(data.crname);
     		$("#clientname").val(data.clientname);
    		$("#clientid").val(data.clientid);
    		$("#client").val(data.client);
       		$("#prtype").val(data.prtype);
      		$("#width").val(data.width);
      		$("#height").val(data.height);
      		$("#tmpid").val(data.tmpid);
      		$("#tmpcode").val(data.tmpcode);       	    		                      
           if(data.file){
              var link = "FileDownload?f="+data.file.uploadedFileName+"&of="+data.file.fileName;
              $("#result").append("<a href='"+ data.file.imgUrl +"' target='_new'>"+data.file.imgUrl+"</a>");
              $("#result").append("<br/>");
           }
           
           //다운로드시 크롬에서 다음 오류 발생.
           //오류 : Resource interpreted as Document but transferred with MIME type 
           //       application/octet-stream 
           //해결 :
           //You can specify the HTML5 download attribute in your <a> tag.
           //<a href='http://example.com/archive.zip' download>Export</a>
           //https://developer.mozilla.org/en-US/docs/Web/HTML/Element/a#attr-download
                                 
           //$('#multiform')[0].reset(); //폼 초기화(리셋);
           
           //IE에서 폼 리셋후 input[type=file] 초기화 안되는 문제. 
           //(파일이름은 지워지지만 files 프로퍼티에는 파일정보 남아있음.)
           //참고 : http://javaking75.blog.me/220073388169
           //console.log(navigator.userAgent);           
           if (/(MSIE|Trident)/.test(navigator.userAgent)) {
               // ie 일때 input[type=file] init.
               $("#multiform input[type=file]").each(function(index){
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
			$("#clickname, #clickurl").css("border-color", "#ccc");
			$("#swarningMsg").text("");
			e.preventDefault();
			
			if($.trim($("#clickname").val()).length==0){
				$("#clickname").css("border-color","red").focus();
				$("#swarningMsg").text("클릭명을 입력해주세요.");
				return false;
			}else if($.trim($("#clickurl").val()).length==0){
				$("#clickurl").css("border-color","red").focus();
				$("#swarningMsg").text("클릭 URL을 입력해주세요.");
				return false;
			}else if($("#"+$.trim($("#clickname").val())).size()>0){
				$("#clickname").css("border-color","red").focus();
				$("#swarningMsg").text("중복된 클릭명이 있습니다.");
				return false;
			}else{
				var htmlstr = "";
				
				var cname = $.trim($("#clickname").val());
				var curl = $.trim($("#clickurl").val());
				

				htmlstr += '<div class="clickLinkBox" id="'+cname+'">';
				htmlstr += '<span class="clickName">'+cname+'<input type="hidden" name="clickname" value="'+cname+'"/></span>';
				htmlstr += '<span class="clicklink"><a href="'+curl+'">'+curl+'</a><input type="hidden" name="clickurl" value="'+curl+'"/></span>';
				htmlstr += '<a href="#none" class="btn btn-link" name="btnRemove"><span class="glyphicon glyphicon-remove"></span></a>';
				htmlstr += '</div>';

				$("#divClick").append(htmlstr);
				$("#clickname").val("");
				$("#clickurl").val("");
            
			}
			
		});

		$(document).on("click", "a[name=btnRemove]", function(e){
			$(this).parent("div").remove();
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
                <%-- 
<form id="ajaxform" action="/saveFileTest.do" method="post" enctype="multipart/form-data">
		<input type="text" name="test2"/><br/>
		<textarea rows="10" cols="10" name="test3"></textarea><br/>
		<input type="file" name="test4" />
		<input type="button" id="btn" value="전송" />
</form>
 --%>

<h3>jQuery ajax fileupload (ajax 파일업로드)</h3>
<form name="multiform" id="multiform" action="FileUploadServlet"
                                      method="POST" enctype="multipart/form-data">
     
    crname: <input type="text" name="crname"  value=""/> <br/>
    prtype :<input type="text" name="prtype"  value="" /> <br/>
    <!-- 다중 파일업로드  -->
    photo :<input type="file" name="photo" /> <br/> 
    photo :<input type="file" name="photo" /> <br/>
    photo :<input type="file" name="photo" /> <br/>
    
    <!-- 단일 파일업로드 -->
    file :<input type="file" name="file" /> <br/>
    <input type="submit" id="btnSubmit" value="전송"/><br/>
</form>    


<div id="result">
    
</div>
<%--
               <!-- add Table Start -->
                <form name="multiform2" id="multiform2" action="FileUploadServlet" method="POST" enctype="multipart/form-data">
                    <table class="addTable">
                        <colgroup>
                            <col width="15%">
                                <col width="85%">
                        </colgroup>
                        <tr>
                            <th>광고물명</th>
                            <td>
                                <input type="text" id="crname" name="crname" class="form-control input-sm" style="width:300px">
                            </td>
                        </tr>
                        <tr>
                            <th>광고주<span style="color:red"> * </span></th>
                            <td>
 					    		<input class="debug" size=8 type="text" name="clientname" id="clientname"/>
					    		<input class="debug" size=4 type="text" name="clientid" id="clientid"/>
                                <input type="text"  id="client" class="form-control input-sm" autocomplete="off" style="width:300px" placeholder="">					     
                            </td>
                          </tr>
                        <tr>
                            <th>광고상품</th>
                            <td>
	                            <select id="prtype" name="prtype" class="form-control input-sm" style="width:100px">
	                             <option value=""></option>
	                                <%for(int i=0;i<codelist.size();i++){ 
	                                	Map<String,String> code = codelist.get(i);
	                                %>
	                                <option value="<%=String.valueOf(code.get("isid")) %>"><%=code.get("isname") %></option>                               
	                                <%} %>
	                            </select>
                            </td>
                        </tr>
                        <tr>
                            <th>광고물위치</th>
                            <td>
                                <div class="input-group" style="width:341px">
                                    <input type="text" class="form-control form-sm">
                                    <span class="input-group-btn">
                                    <button class="btn btn-success btn-sm" type="button"><span class="glyphicon glyphicon-map-marker"></span>
                                    </button>
                                    </span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>파일업로드</th>
                            <td class="form-inline">
                                       <!-- file btn Start 
                             <div class="input-group" style="width:376px">
                                    <input type="text" class="form-control form-sm" readonly>
                                    <span class="input-group-btn">
                                        <span class="btn btn-success btn-sm btn-file">
                                            <span class="glyphicon glyphicon-paperclip"></span>
                                    		<input type="file" name="file" class="form-sm" multiple>
                                    	</span>
                                    </span>
                                      <input type="submit" id="btnSubmit" value="전송"/>
                                  
                                </div>  file btn End -->
                                 file :<input type="file" name="file" /> <br/>
    <input type="submit" id="btnSubmit" value="전송"/><br/>
                            </td>
                        </tr>
                        
                        <tr>
                            <th>업로드 파일 목록</th>
                            <td>
                            
                                <div id="result" class="fileLink">
                                  
                                </div>
                              <!--    
                                <div id="result" style="font-size:1em;height:80px;width:430px;border:1px solid #ccc;overflow:auto;"></div>
-->
                            </td>
                        </tr>
                        <tr>
                            <th>사이즈</th>
                            <td>
                                <div class="form-inline">
                                    <input type="text" name="" class="form-control input-sm" style="width:60px"> x
                                    <input type="text" name="" class="form-control input-sm" style="width:60px">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>템플릿</th>
                            <td>
                                <select id="tagTmp" name="tmpid" class="form-control form-sm" style="width:600px">
	                             <option value=""></option>
	                                <%for(int i=0;i<tmplist.size();i++){ 
	                                	Map<String,String> tmp = tmplist.get(i);
	                                %>
	                                <option value="<%=String.valueOf(tmp.get("tmpid")) %>" ><%=tmp.get("tmpname") %></option>                               
	                                <%} %>
                               </select>
                            </td>
                        </tr>
                        <tr>
                            <th>코드</th>
                            <td>
                                <textarea id="richmedia" name="richmedia" class="form-control input-sm" rows="10" style="width:600px"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <th>클릭링크</th>
                            <td>
                                <div class="form-inline">
                                    <input type="text" id="clickname" class="form-control input-sm" style="width:150px" placeholder="클릭명">
                                    <input type="text" id="clickurl" class="form-control input-sm" style="width:410px" placeholder="클릭 URL">
                                    <button class="btn btn-success btn-sm" id="btnAddClick"><span class="glyphicon glyphicon-plus"></span>
                                    </button>
                                </div>
                                <span id="swarningMsg" style="color:#a00"></span>
                                <div id="divClick">
	                            </div>
                            </td>
                        </tr>
                    </table>
                </form>
                <!-- add Table End -->
                <!-- button group Start -->
                <div class="buttonGroup">
                    <button type="button" class="btn btn-default btn-sm">수정</button>
                    <button type="button" class="btn btn-default btn-sm">복사</button>
                    <button type="button" class="btn btn-default btn-sm">삭제</button>
                    <button type="button" class="btn btn-danger btn-sm">리포트</button>
                </div>
                <!-- button group End -->
            </section>
 --%>

        </div>
    </div>
<%
} catch(Exception e) {
    e.getMessage();
}
%> 
</body>

</html>
