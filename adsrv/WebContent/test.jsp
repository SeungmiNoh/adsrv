<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<head>
    <meta charset="utf-8">   
   <script type="text/javascript">
function msg(n){
	alert("msg"+n);
	Test.getMessage(n, view);
}
function view(data){
	alert(data);
	viewData.innerHtml= data;
}
  </script>
 <script type="text/javascript" src="dwr/interface/Test.js"></script>
 <script type="text/javascript" src="dwr/engine.js"></script>
 <script type="text/javascript" src="dwr/util.js"></script>
 </head>
 <body>
 <input type="button" value="Message" onclick="msg('마루치')">
 <div id="viewData"></div>
 </body>
  