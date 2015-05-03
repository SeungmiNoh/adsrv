<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/common.jsp" %>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.google.gson.Gson"%> 
<%@page import="tv.pandora.adsrv.common.util.StringUtil"%>
<%@page import="tv.pandora.adsrv.common.util.DateUtil"%>    
<%@page import="tv.pandora.adsrv.domain.Creative"%> 
<% 
try
{
	String client = StringUtil.isNull(request.getParameter("client"));
	


	Map<String,Object> map = (Map)request.getAttribute("response");

	String mode = StringUtil.isNull((String)map.get("mode"));   
	String modestr = "등록";
	if(mode.equals("E")) {
		modestr = "수정";
	}
	
	Creative cr = (Creative)map.get("cr");
	List<Map<String,String>> filelist = (List<Map<String,String>>)map.get("filelist");   
	List<Map<String,String>> clicklist = (List<Map<String,String>>)map.get("clicklist");   
	List<Map<String,String>> codelist = (List<Map<String,String>>)map.get("codelist");   
	List<Map<String,String>> tmplist = (List<Map<String,String>>)map.get("tmplist");   
	String newClientid = StringUtil.isNull((String)map.get("newClientid"));
	String newClientname = StringUtil.isNull((String)map.get("newClientname"));
	JSONArray click_data = JSONArray.fromObject(clicklist);
	
	
	Gson gson = new Gson();
	String outString = gson.toJson(clicklist);

	JSONObject crdata = JSONObject.fromObject(cr);		
	
	
	String crid = "";
	String crname = "";
	String clientid = "";
	String clientname = "";
	String crurl = "";
	String width = "";
	String height = "";
	String tmpid = "";
	String richmedia = "";
	String prtype = "";
	
	
	if(cr != null) {
		crid = cr.getCrid();
		crname = cr.getCrname();
		clientid = cr.getClientid();
		clientname = cr.getClientname();
		crurl = StringUtil.isNull(cr.getCrurl());
		width = StringUtil.isNull(cr.getWidth());
		height = StringUtil.isNull(cr.getHeight());
		tmpid = StringUtil.isNullZero(cr.getTmpid());
		richmedia = StringUtil.isNull(cr.getRichmedia());
		prtype = StringUtil.isNull(cr.getPrtype());
	}
			
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
function del(idx) {
	$("#url"+idx).remove();	
	$("#img"+idx).remove();	
}

function newTab(link){
	if(link.length>0) {
		var tab=window.open(link,'_blank'); 
		   //tab.focus(); 
	}
}


$(function(){
	delFile = function(fileidx){
		var crid = $("#crid").val();
	    if(confirm("파일을 삭제하시겠습니까?")){
			MasDwrService.delFile(crid, fileidx, 
			   		function(data) {
						if(data===1) {
							$("#url"+fileidx).remove();	
					    	$("#img"+fileidx).remove();
						}
				});
	    }
	}
	
	setClickName = function(cname){
		var ckno = $("input[name=clickname]").length;
		var ckname = "CLICK";
		
		if(cname!='')
		{
			ckname = cname;
		} else {
			if(ckno>0) {
				ckname+=ckno;
			}
		}		
		$("#new_clickname").val(ckname);
		$("#new_clickurl").val("");
	}

	htmlClick=function(cid, cname, curl){
		var htmlstr = "";
	    htmlstr += '<div class="clickLinkBox txtNavy" id="'+cname+'">';
	    htmlstr += '<input type="hidden" name="ckid" value="'+cid+'" size="2" />';
		htmlstr += '<span class="clickName">'+cname+'<input type="hidden" name="clickname" value="'+cname+'"/></span>';
		htmlstr += '<span class="clicklink"><a href="'+curl+'" class="txtBlack">'+curl+'</a><input type="hidden" name="clickurl" value="'+curl+'"/></span>';
		htmlstr += '<a href="#none" class="btn btn-link" name="btnRemove"  ckid='+cid+' delname="'+cname+'">';		
		htmlstr += '<span class="glyphicon glyphicon-remove"></span></a>';
		htmlstr += '</div>';

		$("#divClick").append(htmlstr);
		setClickName('');
		
	}
	
	
	
	<%if(cr != null) {%>
	var crdata = <%=crdata%>;
	resetData();
	function resetData()  {
		$("#crid").val("<%=crid%>");
		$("#crname").val("<%=crname%>");
		$("#clientid").val("<%=clientid%>");
		$("#clientname").val("<%=clientname%>");
		$("#client").val("<%=clientname%>");
		$("#crurl").val("<%=crurl%>");
		$("#width").val("<%=width%>");
		$("#height").val("<%=height%>");
		$("#height").val("<%=height%>");
		$("#prtype").val("<%=prtype%>");
		$("#tmpid").val("<%=tmpid%>");
		
		$("#richmedia").text(decodeURIComponent(crdata.richmedia).replace(/\+/g, " "));
		var data =  <%=outString%>;
		
		$.each(data, function(index, item){
			htmlClick(item.ckid, item.clickname, item.clickurl);
		});
	}
	<%}%>
	
	$("#btnBack").on("click", function(e){
		history.back();
	});
	$("#btnCrurl").on("click", function(e){
		var link = $("#crurl").val();
		if(link.length>0) {
			window.open(link,'_blank'); 
		}
	});
	
	
	
	
	
    //폼전송 : 해당폼의 submit 이벤트가 발생했을경우 실행  
    $('#frmFile').ajaxForm({
       cache: false,
       dataType:"json",
       //보내기전 validation check가 필요할경우
       beforeSubmit: function (data, frm, opt) {
           return true;
       },
       //submit이후의 처리
       success: function(data, statusText){
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
           if (/(MSIE|Trident)/.test(navigator.userAgent)) {
               // ie 일때 input[type=file] init.
               $("#frmFile input[type=file]").each(function(index){
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
	  	
	 <%if(newClientid.equals("")){%>
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
	  <%}%>
	    
		$("#btnAddClick").on("click", function(e){
			$("#new_clickname, #new_clickurl").css("border-color", "#ccc");
			$("#swarningMsg").text("");
			e.preventDefault();
			if($.trim($("#new_clickname").val()).length==0){
				$("#new_clickname").css("border-color","red").focus();
				$("#swarningMsg").text("클릭명을 입력해주세요.");
				return false;
			}else if($("#"+$.trim($("#new_clickname").val())).size()>0){
				$("#new_clickname").css("border-color","red").focus();
				$("#swarningMsg").text("중복된 클릭명이 있습니다.");
				return false;
			}else if($.trim($("#new_clickurl").val()).length==0){
				$("#new_clickurl").css("border-color","red").focus();
				$("#swarningMsg").text("클릭 URL을 입력해주세요.");
				return false;
			}else if(checkURL($.trim($("#new_clickurl").val()))==false) {
				$("#new_clickurl").css("border-color","red").focus();
				$("#swarningMsg").text("클릭 URL 형식이 올바르지 않습니다.");
				return false;
			}else{
				var htmlstr = "";
				
				var cname = $.trim($("#new_clickname").val());
				var curl = $.trim($("#new_clickurl").val());
				
				htmlClick(0, cname, curl);
            
			}
			
		});

		$(document).on("click", "a[name=btnRemove]", function(e){
			
			
			var crid = $("#crid").val();
			var ckid = $(this).attr("ckid");
			var delname = $(this).attr("delname");
			
			if(ckid != 0){
			    //if(confirm("클릭 URL을 삭제하시겠습니까?")){
				MasDwrService.delClick(crid, ckid, 
				   		function(data) {
							/*(if(data===1) {
								$("#ckid"+ckid).remove();						    	
							}*/
					});
		    //}
			}
			$(this).parent("div").remove();
			setClickName(delname);
		});	 
		
		
		
		
		
		
		
		$("#btnSave").on("click", function(e){	
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
				var crid = $('#crid').val();							
				MasDwrService.getCreativeCnt(cname, crid, 
			   		function(data) {
						if(data>0) {
							$("#crname").css("border-color","red").select();
							$("#warningMsg").text("중복된 이름이 있습니다.");
							return;				
						} else {
							if(confirm("광고물을 <%=modestr%>하시겠습니까?")) {								
								  $("#frmRegist").submit();																	
							}					
						}
				});
			}
		});
		$("#btnDelete").on("click", function(e){	
			if(confirm("광고물을 삭제하시겠습니까?")) {								
				location.href = "cpmgr.do?a=crDel&crid=<%=crid%>";
			}					
		});
		$("#btnCopy").on("click", function(e){	
			if(confirm("광고물을 복사하시겠습니까?")) {								
				location.href = "cpmgr.do?a=crCopy&crid=<%=crid%>";
			}					
		});		
		$("#tagTmp").on("change", function(e){
			e.preventDefault();
			var tmpid = $(this).val();
			MasDwrService.getTemplate(tmpid,
			   		function(data) {
						$("#richmedia").text(decodeURIComponent(data.tmpcode).replace(/\+/g, " "));
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
                    <div class="title">광고물 <%=modestr%></div>
                    <div class="breadcrumbs"><span class="glyIcon"><img src="<%=web%>/img/navIcon.png" alt=""></span> 현재위치 : 캠페인 > 광고물 > 광고물 <%=modestr%></div>
                    <!-- title End -->
                </div>
                <!-- add Table Start -->
                   <form name="frmRegist" id="frmRegist" class="mfsubmit" action="cpmgr.do?a=crRegist" method="POST">
                   <input type="hidden" id="crid" name="crid" value="0"/>    
                    <table class="addTable" style="width:980px">
					<colgroup>	
					<col width="150px">
					<col width="*"><col width="150px">
					<col width="*">
					</colgroup>
					<tr>
					<th>광고물명<span style="color:red"> * </span></th>
					<td>
					<input type="text" id="crname" name="crname" value="" class="form-control input-sm" style="width:240px">
					</td>					
					<th>광고주<span style="color:red"> * </span></th>
					<td>
						<%if(newClientid.equals("")){ %>
						<input class="debug" size=8 type="hidden" name="clientname" id="clientname" value=""/>
						<input class="debug" size=4 type="hidden" name="clientid" id="clientid" value=""/>
						<input type="text"  id="client" class="form-control input-sm" value="" autocomplete="off" style="width:300px" placeholder="">					     
						<%}else{ %>
						<%=newClientname %><input type="hidden" name="clientid" value="<%=newClientid %>"/>
						<%} %>
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
					<th>사이즈<span style="color:red"> * </span></th>
					<td>
					<div class="form-inline">
					<input type="text" name="width" id="width" class="form-control input-sm" style="width:60px" value="" placeholder="가로"> x
					<input type="text" name="height" id="height" class="form-control input-sm" style="width:60px" value="" placeholder="세로">
					</div>
					</td>
					</tr>
					<tr>
					<th>광고물위치</th>
					<td colspan="3">
						<div class="input-group" style="width:581px">
						<input id="crurl" name="crurl" type="text" class="form-control form-sm">
						<span class="input-group-btn">
						<button class="btn btn-success btn-sm" type="button" id="btnCrurl"><span class="glyphicon glyphicon-map-marker"></span></button>
						</span>
						</div>
					</td>
					</tr>
					<tr>                            
					<th>템플릿</th>
					<td colspan="3">
					<select id="tagTmp" name="tmpid" class="form-control form-sm" style="width:280px">
					<option value="0">선택</option>
					<%for(int i=0;i<tmplist.size();i++){ 
					Map<String,String> tmp = tmplist.get(i);
					%>
					<option value="<%=String.valueOf(tmp.get("tmpid")) %>"><%=tmp.get("tmpname") %></option>                               
					<%} %>
					</select>
					</td>                          
                    </tr>
                    <tr>      
					<th>코드</th>
					<td colspan="3">
						<textarea id="richmedia" name="richmedia" class="form-control input-sm" rows="18" style="width:680px"></textarea>
						<table class="opacityTable" style="width:680px;">
						<colgroup>
						<col width="10%"><col width="">
						<col width="10%"><col width="">
						<col width="10%"><col width="">
						</colgroup>
						<tr>
						<th>--IMG--</th>
						<td class="txtGray">: 광고물 위치</td>
						<th>--WIDTH--</th>
						<td class="txtGray">: 가로</td>
						<th>--HEIGHT--</th>
						<td class="txtGray">: 세로</td>
						<th></th>
						<td></td>

						</tr>
						<tr>
						<th>--IMP--</th>
						<td class="txtGray">: 노출 태그</td>			
						<th>--VIEW--</th>
						<td class="txtGray">: 15초 뷰 태그</td>
						<th>--SKIP--</th>
						<td class="txtGray">: 스킵 태그</td>
						<th>--CLICK--</th>
						<td class="txtGray">: 클릭 링크</td>
							</tr>
						
						</table>
						<div id="divClick2"></div>
						<div id="result2"></div>                            
					</td>
					</tr>
					<tr>
					<th>클릭링크</th>
					<td colspan="3">
					<div class="form-inline"  style="height:40px">
					<input type="text" id="new_clickname" class="form-control input-sm" style="width:100px" placeholder="클릭명" value="CLICK">
					<input type="text" id="new_clickurl" class="form-control input-sm" style="width:410px" placeholder="클릭 URL">
					<button class="btn btn-info btn-sm" id="btnAddClick"><span class="glyphicon glyphicon-plus"></span></button>
					</div>
					<span id="swarningMsg" style="color:#a00"></span>
					</td>
					</tr>
					<tr>      
					<th></th>
					<td style="vertical-align:top"  colspan="3">     
					<div id="divClick" style="min-height: 20px;">
					
					</div>
					</td>
					</tr>
					<tr>
					<th>업로드<br/>파일 목록</th>
					<td style="height:100px"  colspan="3">
					 
						<div id="result">    
						 <%
						if(filelist != null) 
						{
							 for(int i=0;i<filelist.size();i++){ 
								Map<String,String> f = filelist.get(i);
						%>  
							<div class="clickLinkBox" id='url<%=String.valueOf(f.get("fileidx")) %>'>
							<a href='<%=f.get("imgurl")%>' target='_new'><span class='glyphicon glyphicon-download'></span></a>
							<span style="display: inline-block;width:400px"><%=f.get("imgurl")%></span>
							<a href="javascript:delFile(<%=String.valueOf(f.get("fileidx")) %>)" class="btn btn-link" name="btnDel"  idx='<%=String.valueOf(f.get("fileidx")) %>'><span class="glyphicon glyphicon-remove"></span></a>
							<span class="clickName"><%=f.get("updateusername")%> (<%=DateUtil.getYMDHM(String.valueOf(f.get("updatedate")), "-") %>)</span>
							</div>
						<% 
							}
						}
						%>           
													  
						</div>
						<div id="imgs" style="float:left" style="height:100px">
						  <%
						if(filelist != null) 
						{                                
						  
						  for(int i=0;i<filelist.size();i++){ 
							Map<String,String> f = filelist.get(i);
							%>                                
							<span id='img<%=String.valueOf(f.get("fileidx")) %>'><a href='<%=f.get("imgurl")%>' target='_new' download><img src='<%=f.get("imgurl")%>' style='width:100px;'/></a></span>
						<% 
							}
						}
						%>                                
						</div>
                             <!--    
                                <div id="result" style="font-size:1em;height:80px;width:430px;border:1px solid #ccc;overflow:auto;"></div>
-->
                        </td>
                        </tr>
                    </table>
                </form>
					<table class="addTable" style="width:980px">
					<colgroup>	
					<col width="150px">
					<col width="*">
					</colgroup>
					<tr>
					<th>파일업로드</th>
					<td>
					<form name="frmFile" id="frmFile" action="FileUploadServlet" method="POST" enctype="multipart/form-data">
					<div class="input-group" style="width:276px">
					<input type="text" class="form-control form-sm" style="width:210px" readonly>
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
                <div class="buttonGroup" style="width:980px">
                	<span id="warningMsg" style="color:#a00"></span>
                    <%if(mode.equals("E")) {%>
                     <button type="button" class="btn btn-default btn-sm" id="btnBack">뒤로</button>
                     <button type="button" class="btn btn-default btn-sm" id="btnCopy">복사</button>
                     <button type="button" class="btn btn-default btn-sm" id="btnDelete">삭제</button>
                     <button type="button" class="btn btn-danger btn-sm" id="btnSave">수정</button>
                    <%}else{ %>
                     <button type="button" class="btn btn-default btn-sm" id="btnBack">뒤로</button>
                    <button type="button" class="btn btn-danger btn-sm" id="btnSave">등록</button>
                    <%} %>  
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
