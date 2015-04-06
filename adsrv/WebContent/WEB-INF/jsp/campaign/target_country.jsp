<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/common.jsp" %>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="tv.pandora.adsrv.common.util.StringUtil"%>
<%@page import="tv.pandora.adsrv.common.util.DateUtil"%>    
<%@page import="tv.pandora.adsrv.domain.Campaign"%>    
<%@page import="tv.pandora.adsrv.domain.User"%>    
<%	
try
{
	String tgtype = StringUtil.isNullReplace(request.getParameter("tgtype"),"1");

	Map map = (Map)request.getAttribute("response");

	List<Map<String,String>> codelist = (List<Map<String,String>>)map.get("codelist");   
	List<Map<String,String>> tgcodelist = (List<Map<String,String>>)map.get("tgcodelist");   
	
	JSONArray code_data = JSONArray.fromObject(tgcodelist);
	      
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
<script>
  $(document).ready(function() {
		
		/*********************** 타겟 선택 데이터 출력 *****************************/
		var code_data = [{"tvalue":1,"entname":"country","tname":"Anonymous Proxy","text":"country","tseq":1,"entno":1},{"tvalue":2,"entname":"country","tname":"Satellite Provider","text":"country","tseq":2,"entno":1},{"tvalue":4,"entname":"country","tname":"Other Country","text":"country","tseq":3,"entno":1},{"tvalue":8,"entname":"country","tname":"Andorra","text":"country","tseq":4,"entno":1},{"tvalue":16,"entname":"country","tname":"United Arab Emirates","text":"country","tseq":5,"entno":1},{"tvalue":32,"entname":"country","tname":"Afghanistan","text":"country","tseq":6,"entno":1},{"tvalue":64,"entname":"country","tname":"Antigua and Barbuda","text":"country","tseq":7,"entno":1},{"tvalue":128,"entname":"country","tname":"Anguilla","text":"country","tseq":8,"entno":1},{"tvalue":256,"entname":"country","tname":"Albania","text":"country","tseq":9,"entno":1},{"tvalue":512,"entname":"country","tname":"Armenia","text":"country","tseq":10,"entno":1},{"tvalue":1024,"entname":"country","tname":"Angola","text":"country","tseq":11,"entno":1},{"tvalue":2048,"entname":"country","tname":"Asia/Pacific Region","text":"country","tseq":12,"entno":1},{"tvalue":4096,"entname":"country","tname":"Antarctica","text":"country","tseq":13,"entno":1},{"tvalue":8192,"entname":"country","tname":"Argentina","text":"country","tseq":14,"entno":1},{"tvalue":16384,"entname":"country","tname":"American Samoa","text":"country","tseq":15,"entno":1},{"tvalue":32768,"entname":"country","tname":"Austria","text":"country","tseq":16,"entno":1},{"tvalue":65536,"entname":"country","tname":"Australia","text":"country","tseq":17,"entno":1},{"tvalue":131072,"entname":"country","tname":"Aruba","text":"country","tseq":18,"entno":1},{"tvalue":262144,"entname":"country","tname":"Aland Islands","text":"country","tseq":19,"entno":1},{"tvalue":524288,"entname":"country","tname":"Azerbaijan","text":"country","tseq":20,"entno":1},{"tvalue":1048576,"entname":"country","tname":"Bosnia and Herzegovina","text":"country","tseq":21,"entno":1},{"tvalue":2097152,"entname":"country","tname":"Barbados","text":"country","tseq":22,"entno":1},{"tvalue":4194304,"entname":"country","tname":"Bangladesh","text":"country","tseq":23,"entno":1},{"tvalue":8388608,"entname":"country","tname":"Belgium","text":"country","tseq":24,"entno":1},{"tvalue":16777216,"entname":"country","tname":"Burkina Faso","text":"country","tseq":25,"entno":1},{"tvalue":33554432,"entname":"country","tname":"Bulgaria","text":"country","tseq":26,"entno":1},{"tvalue":67108864,"entname":"country","tname":"Bahrain","text":"country","tseq":27,"entno":1},{"tvalue":134217728,"entname":"country","tname":"Burundi","text":"country","tseq":28,"entno":1},{"tvalue":268435456,"entname":"country","tname":"Benin","text":"country","tseq":29,"entno":1},{"tvalue":536870912,"entname":"country","tname":"Saint Bartelemey","text":"country","tseq":30,"entno":1},{"tvalue":1073741824,"entname":"country","tname":"Bermuda","text":"country","tseq":31,"entno":1},{"tvalue":2147483647,"entname":"country","tname":"Brunei Darussalam","text":"country","tseq":32,"entno":1},{"tvalue":1,"entname":"country","tname":"Bolivia","text":"country","tseq":33,"entno":1},{"tvalue":2,"entname":"country","tname":"Bonaire, Saint Eustatius and Saba","text":"country","tseq":34,"entno":1},{"tvalue":4,"entname":"country","tname":"Brazil","text":"country","tseq":35,"entno":1},{"tvalue":8,"entname":"country","tname":"Bahamas","text":"country","tseq":36,"entno":1},{"tvalue":16,"entname":"country","tname":"Bhutan","text":"country","tseq":37,"entno":1},{"tvalue":32,"entname":"country","tname":"Bouvet Island","text":"country","tseq":38,"entno":1},{"tvalue":64,"entname":"country","tname":"Botswana","text":"country","tseq":39,"entno":1},{"tvalue":128,"entname":"country","tname":"Belarus","text":"country","tseq":40,"entno":1},{"tvalue":256,"entname":"country","tname":"Belize","text":"country","tseq":41,"entno":1},{"tvalue":512,"entname":"country","tname":"Canada","text":"country","tseq":42,"entno":1},{"tvalue":1024,"entname":"country","tname":"Cocos (Keeling) Islands","text":"country","tseq":43,"entno":1},{"tvalue":2048,"entname":"country","tname":"Congo, The Democratic Republic of the","text":"country","tseq":44,"entno":1},{"tvalue":4096,"entname":"country","tname":"Central African Republic","text":"country","tseq":45,"entno":1},{"tvalue":8192,"entname":"country","tname":"Congo","text":"country","tseq":46,"entno":1},{"tvalue":16384,"entname":"country","tname":"Switzerland","text":"country","tseq":47,"entno":1},{"tvalue":32768,"entname":"country","tname":"Cote d'Ivoire","text":"country","tseq":48,"entno":1},{"tvalue":65536,"entname":"country","tname":"Cook Islands","text":"country","tseq":49,"entno":1},{"tvalue":131072,"entname":"country","tname":"Chile","text":"country","tseq":50,"entno":1},{"tvalue":262144,"entname":"country","tname":"Cameroon","text":"country","tseq":51,"entno":1},{"tvalue":524288,"entname":"country","tname":"China","text":"country","tseq":52,"entno":1},{"tvalue":1048576,"entname":"country","tname":"Colombia","text":"country","tseq":53,"entno":1},{"tvalue":2097152,"entname":"country","tname":"Costa Rica","text":"country","tseq":54,"entno":1},{"tvalue":4194304,"entname":"country","tname":"Cuba","text":"country","tseq":55,"entno":1},{"tvalue":8388608,"entname":"country","tname":"Cape Verde","text":"country","tseq":56,"entno":1},{"tvalue":16777216,"entname":"country","tname":"Curacao","text":"country","tseq":57,"entno":1},{"tvalue":33554432,"entname":"country","tname":"Christmas Island","text":"country","tseq":58,"entno":1},{"tvalue":67108864,"entname":"country","tname":"Cyprus","text":"country","tseq":59,"entno":1},{"tvalue":134217728,"entname":"country","tname":"Czech Republic","text":"country","tseq":60,"entno":1},{"tvalue":268435456,"entname":"country","tname":"Germany","text":"country","tseq":61,"entno":1},{"tvalue":536870912,"entname":"country","tname":"Djibouti","text":"country","tseq":62,"entno":1},{"tvalue":1073741824,"entname":"country","tname":"Denmark","text":"country","tseq":63,"entno":1},{"tvalue":2147483647,"entname":"country","tname":"Dominica","text":"country","tseq":64,"entno":1},{"tvalue":1,"entname":"country","tname":"Dominican Republic","text":"country","tseq":65,"entno":1},{"tvalue":2,"entname":"country","tname":"Algeria","text":"country","tseq":66,"entno":1},{"tvalue":4,"entname":"country","tname":"Ecuador","text":"country","tseq":67,"entno":1},{"tvalue":8,"entname":"country","tname":"Estonia","text":"country","tseq":68,"entno":1},{"tvalue":16,"entname":"country","tname":"Egypt","text":"country","tseq":69,"entno":1},{"tvalue":32,"entname":"country","tname":"Western Sahara","text":"country","tseq":70,"entno":1},{"tvalue":64,"entname":"country","tname":"Eritrea","text":"country","tseq":71,"entno":1},{"tvalue":128,"entname":"country","tname":"Spain","text":"country","tseq":72,"entno":1},{"tvalue":256,"entname":"country","tname":"Ethiopia","text":"country","tseq":73,"entno":1},{"tvalue":512,"entname":"country","tname":"Europe","text":"country","tseq":74,"entno":1},{"tvalue":1024,"entname":"country","tname":"Finland","text":"country","tseq":75,"entno":1},{"tvalue":2048,"entname":"country","tname":"Fiji","text":"country","tseq":76,"entno":1},{"tvalue":4096,"entname":"country","tname":"Falkland Islands (Malvinas)","text":"country","tseq":77,"entno":1},{"tvalue":8192,"entname":"country","tname":"Micronesia, Federated States of","text":"country","tseq":78,"entno":1},{"tvalue":16384,"entname":"country","tname":"Faroe Islands","text":"country","tseq":79,"entno":1},{"tvalue":32768,"entname":"country","tname":"France","text":"country","tseq":80,"entno":1},{"tvalue":65536,"entname":"country","tname":"Gabon","text":"country","tseq":81,"entno":1},{"tvalue":131072,"entname":"country","tname":"United Kingdom","text":"country","tseq":82,"entno":1},{"tvalue":262144,"entname":"country","tname":"Grenada","text":"country","tseq":83,"entno":1},{"tvalue":524288,"entname":"country","tname":"Georgia","text":"country","tseq":84,"entno":1},{"tvalue":1048576,"entname":"country","tname":"French Guiana","text":"country","tseq":85,"entno":1},{"tvalue":2097152,"entname":"country","tname":"Guernsey","text":"country","tseq":86,"entno":1},{"tvalue":4194304,"entname":"country","tname":"Ghana","text":"country","tseq":87,"entno":1},{"tvalue":8388608,"entname":"country","tname":"Gibraltar","text":"country","tseq":88,"entno":1},{"tvalue":16777216,"entname":"country","tname":"Greenland","text":"country","tseq":89,"entno":1},{"tvalue":33554432,"entname":"country","tname":"Gambia","text":"country","tseq":90,"entno":1},{"tvalue":67108864,"entname":"country","tname":"Guinea","text":"country","tseq":91,"entno":1},{"tvalue":134217728,"entname":"country","tname":"Guadeloupe","text":"country","tseq":92,"entno":1},{"tvalue":268435456,"entname":"country","tname":"Equatorial Guinea","text":"country","tseq":93,"entno":1},{"tvalue":536870912,"entname":"country","tname":"Greece","text":"country","tseq":94,"entno":1},{"tvalue":1073741824,"entname":"country","tname":"South Georgia and the South Sandwich Islands","text":"country","tseq":95,"entno":1},{"tvalue":2147483647,"entname":"country","tname":"Guatemala","text":"country","tseq":96,"entno":1},{"tvalue":1,"entname":"country","tname":"Guam","text":"country","tseq":97,"entno":1},{"tvalue":2,"entname":"country","tname":"Guinea-Bissau","text":"country","tseq":98,"entno":1},{"tvalue":4,"entname":"country","tname":"Guyana","text":"country","tseq":99,"entno":1},{"tvalue":8,"entname":"country","tname":"Hong Kong","text":"country","tseq":100,"entno":1},{"tvalue":16,"entname":"country","tname":"Heard Island and McDonald Islands","text":"country","tseq":101,"entno":1},{"tvalue":32,"entname":"country","tname":"Honduras","text":"country","tseq":102,"entno":1},{"tvalue":64,"entname":"country","tname":"Croatia","text":"country","tseq":103,"entno":1},{"tvalue":128,"entname":"country","tname":"Haiti","text":"country","tseq":104,"entno":1},{"tvalue":256,"entname":"country","tname":"Hungary","text":"country","tseq":105,"entno":1},{"tvalue":512,"entname":"country","tname":"Indonesia","text":"country","tseq":106,"entno":1},{"tvalue":1024,"entname":"country","tname":"Ireland","text":"country","tseq":107,"entno":1},{"tvalue":2048,"entname":"country","tname":"Israel","text":"country","tseq":108,"entno":1},{"tvalue":4096,"entname":"country","tname":"Isle of Man","text":"country","tseq":109,"entno":1},{"tvalue":8192,"entname":"country","tname":"India","text":"country","tseq":110,"entno":1},{"tvalue":16384,"entname":"country","tname":"British Indian Ocean Territory","text":"country","tseq":111,"entno":1},{"tvalue":32768,"entname":"country","tname":"Iraq","text":"country","tseq":112,"entno":1},{"tvalue":65536,"entname":"country","tname":"Iran, Islamic Republic of","text":"country","tseq":113,"entno":1},{"tvalue":131072,"entname":"country","tname":"Iceland","text":"country","tseq":114,"entno":1},{"tvalue":262144,"entname":"country","tname":"Italy","text":"country","tseq":115,"entno":1},{"tvalue":524288,"entname":"country","tname":"Jersey","text":"country","tseq":116,"entno":1},{"tvalue":1048576,"entname":"country","tname":"Jamaica","text":"country","tseq":117,"entno":1},{"tvalue":2097152,"entname":"country","tname":"Jordan","text":"country","tseq":118,"entno":1},{"tvalue":4194304,"entname":"country","tname":"Japan","text":"country","tseq":119,"entno":1},{"tvalue":8388608,"entname":"country","tname":"Kenya","text":"country","tseq":120,"entno":1},{"tvalue":16777216,"entname":"country","tname":"Kyrgyzstan","text":"country","tseq":121,"entno":1},{"tvalue":33554432,"entname":"country","tname":"Cambodia","text":"country","tseq":122,"entno":1},{"tvalue":67108864,"entname":"country","tname":"Kiribati","text":"country","tseq":123,"entno":1},{"tvalue":134217728,"entname":"country","tname":"Comoros","text":"country","tseq":124,"entno":1},{"tvalue":268435456,"entname":"country","tname":"Saint Kitts and Nevis","text":"country","tseq":125,"entno":1},{"tvalue":536870912,"entname":"country","tname":"Korea, Democratic People's Republic of","text":"country","tseq":126,"entno":1},{"tvalue":1073741824,"entname":"country","tname":"Korea, Republic of","text":"country","tseq":127,"entno":1},{"tvalue":2147483647,"entname":"country","tname":"Kuwait","text":"country","tseq":128,"entno":1},{"tvalue":1,"entname":"country","tname":"Cayman Islands","text":"country","tseq":129,"entno":1},{"tvalue":2,"entname":"country","tname":"Kazakhstan","text":"country","tseq":130,"entno":1},{"tvalue":4,"entname":"country","tname":"Lao People's Democratic Republic","text":"country","tseq":131,"entno":1},{"tvalue":8,"entname":"country","tname":"Lebanon","text":"country","tseq":132,"entno":1},{"tvalue":16,"entname":"country","tname":"Saint Lucia","text":"country","tseq":133,"entno":1},{"tvalue":32,"entname":"country","tname":"Liechtenstein","text":"country","tseq":134,"entno":1},{"tvalue":64,"entname":"country","tname":"Sri Lanka","text":"country","tseq":135,"entno":1},{"tvalue":128,"entname":"country","tname":"Liberia","text":"country","tseq":136,"entno":1},{"tvalue":256,"entname":"country","tname":"Lesotho","text":"country","tseq":137,"entno":1},{"tvalue":512,"entname":"country","tname":"Lithuania","text":"country","tseq":138,"entno":1},{"tvalue":1024,"entname":"country","tname":"Luxembourg","text":"country","tseq":139,"entno":1},{"tvalue":2048,"entname":"country","tname":"Latvia","text":"country","tseq":140,"entno":1},{"tvalue":4096,"entname":"country","tname":"Libyan Arab Jamahiriya","text":"country","tseq":141,"entno":1},{"tvalue":8192,"entname":"country","tname":"Morocco","text":"country","tseq":142,"entno":1},{"tvalue":16384,"entname":"country","tname":"Monaco","text":"country","tseq":143,"entno":1},{"tvalue":32768,"entname":"country","tname":"Moldova, Republic of","text":"country","tseq":144,"entno":1},{"tvalue":65536,"entname":"country","tname":"Montenegro","text":"country","tseq":145,"entno":1},{"tvalue":131072,"entname":"country","tname":"Saint Martin","text":"country","tseq":146,"entno":1},{"tvalue":262144,"entname":"country","tname":"Madagascar","text":"country","tseq":147,"entno":1},{"tvalue":524288,"entname":"country","tname":"Marshall Islands","text":"country","tseq":148,"entno":1},{"tvalue":1048576,"entname":"country","tname":"Macedonia","text":"country","tseq":149,"entno":1},{"tvalue":2097152,"entname":"country","tname":"Mali","text":"country","tseq":150,"entno":1},{"tvalue":4194304,"entname":"country","tname":"Myanmar","text":"country","tseq":151,"entno":1},{"tvalue":8388608,"entname":"country","tname":"Mongolia","text":"country","tseq":152,"entno":1},{"tvalue":16777216,"entname":"country","tname":"Macao","text":"country","tseq":153,"entno":1},{"tvalue":33554432,"entname":"country","tname":"Northern Mariana Islands","text":"country","tseq":154,"entno":1},{"tvalue":67108864,"entname":"country","tname":"Martinique","text":"country","tseq":155,"entno":1},{"tvalue":134217728,"entname":"country","tname":"Mauritania","text":"country","tseq":156,"entno":1},{"tvalue":268435456,"entname":"country","tname":"Montserrat","text":"country","tseq":157,"entno":1},{"tvalue":536870912,"entname":"country","tname":"Malta","text":"country","tseq":158,"entno":1},{"tvalue":1073741824,"entname":"country","tname":"Mauritius","text":"country","tseq":159,"entno":1},{"tvalue":2147483647,"entname":"country","tname":"Maldives","text":"country","tseq":160,"entno":1},{"tvalue":1,"entname":"country","tname":"Malawi","text":"country","tseq":161,"entno":1},{"tvalue":2,"entname":"country","tname":"Mexico","text":"country","tseq":162,"entno":1},{"tvalue":4,"entname":"country","tname":"Malaysia","text":"country","tseq":163,"entno":1},{"tvalue":8,"entname":"country","tname":"Mozambique","text":"country","tseq":164,"entno":1},{"tvalue":16,"entname":"country","tname":"Namibia","text":"country","tseq":165,"entno":1},{"tvalue":32,"entname":"country","tname":"New Caledonia","text":"country","tseq":166,"entno":1},{"tvalue":64,"entname":"country","tname":"Niger","text":"country","tseq":167,"entno":1},{"tvalue":128,"entname":"country","tname":"Norfolk Island","text":"country","tseq":168,"entno":1},{"tvalue":256,"entname":"country","tname":"Nigeria","text":"country","tseq":169,"entno":1},{"tvalue":512,"entname":"country","tname":"Nicaragua","text":"country","tseq":170,"entno":1},{"tvalue":1024,"entname":"country","tname":"Netherlands","text":"country","tseq":171,"entno":1},{"tvalue":2048,"entname":"country","tname":"Norway","text":"country","tseq":172,"entno":1},{"tvalue":4096,"entname":"country","tname":"Nepal","text":"country","tseq":173,"entno":1},{"tvalue":8192,"entname":"country","tname":"Nauru","text":"country","tseq":174,"entno":1},{"tvalue":16384,"entname":"country","tname":"Niue","text":"country","tseq":175,"entno":1},{"tvalue":32768,"entname":"country","tname":"New Zealand","text":"country","tseq":176,"entno":1},{"tvalue":65536,"entname":"country","tname":"Oman","text":"country","tseq":177,"entno":1},{"tvalue":131072,"entname":"country","tname":"Panama","text":"country","tseq":178,"entno":1},{"tvalue":262144,"entname":"country","tname":"Peru","text":"country","tseq":179,"entno":1},{"tvalue":524288,"entname":"country","tname":"French Polynesia","text":"country","tseq":180,"entno":1},{"tvalue":1048576,"entname":"country","tname":"Papua New Guinea","text":"country","tseq":181,"entno":1},{"tvalue":2097152,"entname":"country","tname":"Philippines","text":"country","tseq":182,"entno":1},{"tvalue":4194304,"entname":"country","tname":"Pakistan","text":"country","tseq":183,"entno":1},{"tvalue":8388608,"entname":"country","tname":"Poland","text":"country","tseq":184,"entno":1},{"tvalue":16777216,"entname":"country","tname":"Saint Pierre and Miquelon","text":"country","tseq":185,"entno":1},{"tvalue":33554432,"entname":"country","tname":"Pitcairn","text":"country","tseq":186,"entno":1},{"tvalue":67108864,"entname":"country","tname":"Puerto Rico","text":"country","tseq":187,"entno":1},{"tvalue":134217728,"entname":"country","tname":"Palestinian Territory","text":"country","tseq":188,"entno":1},{"tvalue":268435456,"entname":"country","tname":"Portugal","text":"country","tseq":189,"entno":1},{"tvalue":536870912,"entname":"country","tname":"Palau","text":"country","tseq":190,"entno":1},{"tvalue":1073741824,"entname":"country","tname":"Paraguay","text":"country","tseq":191,"entno":1},{"tvalue":2147483647,"entname":"country","tname":"Qatar","text":"country","tseq":192,"entno":1},{"tvalue":1,"entname":"country","tname":"Reunion","text":"country","tseq":193,"entno":1},{"tvalue":2,"entname":"country","tname":"Romania","text":"country","tseq":194,"entno":1},{"tvalue":4,"entname":"country","tname":"Serbia","text":"country","tseq":195,"entno":1},{"tvalue":8,"entname":"country","tname":"Russian Federation","text":"country","tseq":196,"entno":1},{"tvalue":16,"entname":"country","tname":"Rwanda","text":"country","tseq":197,"entno":1},{"tvalue":32,"entname":"country","tname":"Saudi Arabia","text":"country","tseq":198,"entno":1},{"tvalue":64,"entname":"country","tname":"Solomon Islands","text":"country","tseq":199,"entno":1},{"tvalue":128,"entname":"country","tname":"Seychelles","text":"country","tseq":200,"entno":1},{"tvalue":256,"entname":"country","tname":"Sudan","text":"country","tseq":201,"entno":1},{"tvalue":512,"entname":"country","tname":"Sweden","text":"country","tseq":202,"entno":1},{"tvalue":1024,"entname":"country","tname":"Singapore","text":"country","tseq":203,"entno":1},{"tvalue":2048,"entname":"country","tname":"Saint Helena","text":"country","tseq":204,"entno":1},{"tvalue":4096,"entname":"country","tname":"Slovenia","text":"country","tseq":205,"entno":1},{"tvalue":8192,"entname":"country","tname":"Svalbard and Jan Mayen","text":"country","tseq":206,"entno":1},{"tvalue":16384,"entname":"country","tname":"Slovakia","text":"country","tseq":207,"entno":1},{"tvalue":32768,"entname":"country","tname":"Sierra Leone","text":"country","tseq":208,"entno":1},{"tvalue":65536,"entname":"country","tname":"San Marino","text":"country","tseq":209,"entno":1},{"tvalue":131072,"entname":"country","tname":"Senegal","text":"country","tseq":210,"entno":1},{"tvalue":262144,"entname":"country","tname":"Somalia","text":"country","tseq":211,"entno":1},{"tvalue":524288,"entname":"country","tname":"Suriname","text":"country","tseq":212,"entno":1},{"tvalue":1048576,"entname":"country","tname":"South Sudan","text":"country","tseq":213,"entno":1},{"tvalue":2097152,"entname":"country","tname":"Sao Tome and Principe","text":"country","tseq":214,"entno":1},{"tvalue":4194304,"entname":"country","tname":"El Salvador","text":"country","tseq":215,"entno":1},{"tvalue":8388608,"entname":"country","tname":"Sint Maarten","text":"country","tseq":216,"entno":1},{"tvalue":16777216,"entname":"country","tname":"Syrian Arab Republic","text":"country","tseq":217,"entno":1},{"tvalue":33554432,"entname":"country","tname":"Swaziland","text":"country","tseq":218,"entno":1},{"tvalue":67108864,"entname":"country","tname":"Turks and Caicos Islands","text":"country","tseq":219,"entno":1},{"tvalue":134217728,"entname":"country","tname":"Chad","text":"country","tseq":220,"entno":1},{"tvalue":268435456,"entname":"country","tname":"French Southern Territories","text":"country","tseq":221,"entno":1},{"tvalue":536870912,"entname":"country","tname":"Togo","text":"country","tseq":222,"entno":1},{"tvalue":1073741824,"entname":"country","tname":"Thailand","text":"country","tseq":223,"entno":1},{"tvalue":2147483647,"entname":"country","tname":"Tajikistan","text":"country","tseq":224,"entno":1},{"tvalue":1,"entname":"country","tname":"Tokelau","text":"country","tseq":225,"entno":1},{"tvalue":2,"entname":"country","tname":"Timor-Leste","text":"country","tseq":226,"entno":1},{"tvalue":4,"entname":"country","tname":"Turkmenistan","text":"country","tseq":227,"entno":1},{"tvalue":8,"entname":"country","tname":"Tunisia","text":"country","tseq":228,"entno":1},{"tvalue":16,"entname":"country","tname":"Tonga","text":"country","tseq":229,"entno":1},{"tvalue":32,"entname":"country","tname":"Turkey","text":"country","tseq":230,"entno":1},{"tvalue":64,"entname":"country","tname":"Trinidad and Tobago","text":"country","tseq":231,"entno":1},{"tvalue":128,"entname":"country","tname":"Tuvalu","text":"country","tseq":232,"entno":1},{"tvalue":256,"entname":"country","tname":"Taiwan","text":"country","tseq":233,"entno":1},{"tvalue":512,"entname":"country","tname":"Tanzania, United Republic of","text":"country","tseq":234,"entno":1},{"tvalue":1024,"entname":"country","tname":"Ukraine","text":"country","tseq":235,"entno":1},{"tvalue":2048,"entname":"country","tname":"Uganda","text":"country","tseq":236,"entno":1},{"tvalue":4096,"entname":"country","tname":"United States Minor Outlying Islands","text":"country","tseq":237,"entno":1},{"tvalue":8192,"entname":"country","tname":"United States","text":"country","tseq":238,"entno":1},{"tvalue":16384,"entname":"country","tname":"Uruguay","text":"country","tseq":239,"entno":1},{"tvalue":32768,"entname":"country","tname":"Uzbekistan","text":"country","tseq":240,"entno":1},{"tvalue":65536,"entname":"country","tname":"Holy See (Vatican City State)","text":"country","tseq":241,"entno":1},{"tvalue":131072,"entname":"country","tname":"Saint Vincent and the Grenadines","text":"country","tseq":242,"entno":1},{"tvalue":262144,"entname":"country","tname":"Venezuela","text":"country","tseq":243,"entno":1},{"tvalue":524288,"entname":"country","tname":"Virgin Islands, British","text":"country","tseq":244,"entno":1},{"tvalue":1048576,"entname":"country","tname":"Virgin Islands, U.S.","text":"country","tseq":245,"entno":1},{"tvalue":2097152,"entname":"country","tname":"Vietnam","text":"country","tseq":246,"entno":1},{"tvalue":4194304,"entname":"country","tname":"Vanuatu","text":"country","tseq":247,"entno":1},{"tvalue":8388608,"entname":"country","tname":"Wallis and Futuna","text":"country","tseq":248,"entno":1},{"tvalue":16777216,"entname":"country","tname":"Samoa","text":"country","tseq":249,"entno":1},{"tvalue":33554432,"entname":"country","tname":"Yemen","text":"country","tseq":250,"entno":1},{"tvalue":67108864,"entname":"country","tname":"Mayotte","text":"country","tseq":251,"entno":1},{"tvalue":134217728,"entname":"country","tname":"South Africa","text":"country","tseq":252,"entno":1},{"tvalue":268435456,"entname":"country","tname":"Zambia","text":"country","tseq":253,"entno":1},{"tvalue":536870912,"entname":"country","tname":"Zimbabwe","text":"country","tseq":254,"entno":1}];

		var cur_code = "";
		var htmlstr = "";
		for(var k=0; k<code_data.length; k++) {
			if(cur_code != code_data[k].entname) {
				cur_code = code_data[k].entname;
			}
			htmlstr = '<option tseq='+Math.floor((code_data[k].tseq-1)/32)+' value="'+code_data[k].tvalue+'"';
			if(code_data[k].isdefault=="1"){  
				htmlstr += ' selected';				
			}
			htmlstr += '>'+code_data[k].tname+'</option>';
			
			
			$("#"+code_data[k].entname).append(htmlstr);
			
		}
		
		$( "select" ).change(function() {	    
		    $( "select option:selected" ).each(function() {
				
	            var value = $(this).val();
	            var tseq = $(this).attr("tseq");
	            var total = 0;

				var seqOption = $("select[multiple='multiple'] option[tseq="+tseq+"]:selected");
			
				console.log("size = "+ $(seqOption).size());


				for(var i=0;i< $(seqOption).size();i++) {
				                total += parseInt($(seqOption).eq(i).val(), 10);
			
				}
	          $("#country_num"+(parseInt(tseq,10)+1)).val(total);
		    });
		  })
		
		$("#btnRegist").on("click", function(e){
			e.preventDefault();
			$("#frmRegist input, #frmRegist select").css("border-color", "#ccc");
			if($.trim($("#targetname").val()).length==0){
				$("#targetname").css("border-color","red").focus();
				$("#warningMsg").text("타겟팅 이름을 입력해주세요.");
				return;
			}else {
		
					var num = 0;
					for(var i=0;i<$(".tvalue").size();i++){
						if($(".tvalue").eq(i).val()>0) {
							num++;
						}
					}
					if(num==0){
						$("#country").css("border-color","red").focus();
						$("#warningMsg").text("국가를 선택해 주세요.");
						return;
					}
				
			}
			if(confirm("타겟팅을 등록하시겠습니까?")){
				$("#frmRegist").submit();					
			}
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
                    <div class="title">타겟팅 등록</div>
                    <div class="breadcrumbs"><span class="glyIcon"><img src="<%=web%>/img/navIcon.png" alt=""></span> 현재위치 : 캠페인 > 타겟팅 > 타겟팅 등록 > 시스템 </div>
                    <!-- title End -->
                </div>
                <!-- tap menu Start -->
                <div class="tapBox2">
                    <nav class="tapMenu">
                        <ul>
                        <%for(int i=0;i<codelist.size();i++){ 
                                	Map<String,String> code = codelist.get(i);
                         %>
                                <li><a href="cpmgr.do?a=targetForm&tgtype=<%=String.valueOf(code.get("isid")) %>" class="<%=tgtype.equals(String.valueOf(code.get("isid")))?"active":"" %>" value="<%=String.valueOf(code.get("isid")) %>"><%=String.valueOf(code.get("isname")) %></a>
						   		</li>                          
						  <%} %> 
                        </ul>
                    </nav>
                </div>
                <!-- tap menu End -->
                <!-- add Table Start -->
                <form id="frmRegist" name="frmRegist" method="post" action="cpmgr.do?a=targetRegist">
                <input type="hidden" name="tgtype" value="<%=tgtype%>"/>
 				<div id="numValue">
 				<input type="text" id="country_num1" name="country1" value="0" class="tvalue debug"/>
 				<input type="text" id="country_num2" name="country2" value="0" class="tvalue debug"/>
 				<input type="text" id="country_num3" name="country3" value="0" class="tvalue debug"/>
 				<input type="text" id="country_num4" name="country4" value="0" class="tvalue debug"/>
 				<input type="text" id="country_num5" name="country5" value="0" class="tvalue debug"/>
 				<input type="text" id="country_num6" name="country6" value="0" class="tvalue debug"/>
 				<input type="text" id="country_num7" name="country7" value="0" class="tvalue debug"/>
				<input type="text" id="country_num8" name="country8" value="0" class="tvalue debug"/>
                </div>
                    <table class="addTable" style="width:600px;">
                        <colgroup>
                        <col width="20%">
                        <col width="80%">
                        </colgroup>
                        <tr>
                            <th>타겟팅명</th>
                            <td class="form-inline">
                                <input type="text" name="targetname" id="targetname" class="form-control input-sm" style="width:300px">                               
                            </td>
                        </tr>
                        <tr>
                            <th>지정제외</th>
                            <td class="form-inline">
                                <label class="radio-inline"><input type="radio" name="excflag" value="0" checked> 선택</label>
                                <label class="radio-inline"><input type="radio" name="excflag" value="1"> 제외</label>
                           </td>
                        </tr>
                        <tr>
                            <th>국가</th>
                            <td style='height:500px;'>
                                <select id="country" multiple="multiple" class="form-control input-sm" style='height:480px;'>
                                </select>
                            </td>
                        </tr>
                    </table>
                </form>
                <!-- add Table End -->
                <!-- button group Start -->
                <div class="buttonGroup" style="width:600px;">
               	<span id="warningMsg" style="color:#a00"></span>
                    <button type="button" class="btn btn-danger btn-sm" id="btnRegist">등록</button>
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
