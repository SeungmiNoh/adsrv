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
<%@page import="tv.pandora.adsrv.domain.Ads"%>    
<%@page import="tv.pandora.adsrv.domain.User"%>    
<%	
try
{
	
	String a = request.getParameter("a");
	
	Map<String,Object> map = (Map<String,Object>)request.getAttribute("response");

	
	Campaign cp = (Campaign)map.get("cp");
	Ads ads = (Ads)map.get("ads");

	List<Ads> adslist = (List<Ads>)map.get("adslist"); 
	List<Map<String,String>> targetlist = (List<Map<String,String>>)map.get("targetlist");
	List<Map<String,String>> codelist = (List<Map<String,String>>)map.get("codelist");
	
	JSONArray target_data = JSONArray.fromObject(targetlist);
 
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
	$(".debug").css("display","none");
	  $("#moveid").on("change", function(e){
			if($("#adsid").val()!= $("#moveid").val()) 
			{
				$("#frmAds input[name=adsid]").val($("#moveid").val());
				$("#frmAds").submit();
			}
			
		});
	  
		/*********************** 타겟 선택 데이터 출력 *****************************/
		var target_data = <%=target_data%>;
		var cur_type = "";
		var htmlstr = "";
		for(var k=0; k<target_data.length; k++) {
			if(cur_type != target_data[k].targettype) {
				$("#target"+cur_type).append(htmlstr);
				console.log(htmlstr);
				htmlstr = "";
				htmlstr = '<option value="0"></option>';
				cur_type = target_data[k].targettype;
			}
			htmlstr += '<option value="'+target_data[k].tid+'"';
			
			var choice = 0;
			
			if(target_data[k].targetid==target_data[k].tid){  								
					htmlstr += ' selected';	
			}			
			htmlstr += '>'+target_data[k].targetname+'</option>';
					
		}
		$("#target"+cur_type).append(htmlstr);

		$('#frmRegist select').change(function(e){	
			$("#change").val("change");
		});
		
		$("#btnRegist").on("click", function(e){		
			$("#frmRegist input, #frmRegist select").css("border-color", "#ccc");
			e.preventDefault();
		
			/*if($("#change").val() != "change"){
				alert("변경된 내용이 없습니다.");
				return;
			}else{*/
				
					var total = 0;
					for(var i=0;i<$("[name=tid]").size();i++){
						if($("[name=tid]").eq(i).val()!='') {
							total++;
						}
					}
					if(total==0){
						$("[name=tid]").eq(0).css("border-color","red").focus();
						$("#warningMsg").text("타겟팅울 선택해 주세요.");
						return;
					}
			
					if(confirm("애즈에 타겟팅을 등록하시겠습니까?")) {
						$("#frmRegist").submit();	
					}
						
	
			//}
			
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
                    <div class="title">애즈 상세 정보</div>
                    <div class="breadcrumbs"><span class="glyIcon"><img src="<%=web%>/img/navIcon.png" alt=""></span> 현재위치 : 캠페인 > 캠페인 정보</div>
                    <!-- title End -->
                </div>      
                <table class="viewTable" style="width:900px">
				<colgroup>
				<col width="10%">
				<col width="23%">
				<col width="10%">
				<col width="23%">
				<col width="10%">
				<col width="">
				</colgroup>
                    <tr>
                        <th>캠페인명</th>
                        <td colspan="3"><%=cp.getCpname() %></td>
                        <th>담당자</th>
                        <td><%=cp.getTcname() %></td>
                    </tr>
                    <tr>
                        <th>광고주</th>
                        <td><%=cp.getClientname() %></td>
                        <th>대행사</th>
                        <td><%=StringUtil.isNull(cp.getAgencyname()) %></td>
                        <th>미디어렙</th>
                        <td><%=StringUtil.isNull(cp.getMedrepname()) %></td>
                    </tr>
                    <tr>
                        <th>보장량</th>
                        <td></td>
                        <th>목표량</th>
                        <td></td>
                        <th>집행금액</th>
                        <td><%=StringUtil.addComma(cp.getBudget()) %></td>
                    </tr>
                    <tr>
                        <th>시작일</th>
                        <td><%=DateUtil.getYMD(cp.getStartdate(), "-") %></td>
                        <th>종료일</th>
                        <td><%=DateUtil.getYMD(cp.getEnddate(), "-") %></td>
                        <th>상태</th>
                        <td></td>
                    </tr>
                </table>
                <br>
                <!-- view Table End -->
                <!-- campaign view End -->
                <!-- select ads Start -->
                <div>
 	                <form id="frmAds" method="get" action="cpmgr.do">
	                <input type="hidden" name="a" value="<%=a %>"/>
	                <input type="hidden" name="adsid"/>
	                    <select id="moveid" class="form-control input-sm" style="width:300px;">
<%

for(int k=0; k<adslist.size(); k++){
                                        
    Ads mads = adslist.get(k);
    
	 
 %>                     
                        <option value="<%=mads.getAdsid()%>" <%=ads.getAdsid().equals(mads.getAdsid())?"selected":"" %>><%=mads.getAdsname() %></option>
 <%} %>                 </select>
                	</form>                
               	</div>

                <!-- select ads End -->
                <!-- ads add title Start -->
                <div class="boxtitle2">
                     <!-- title Start 
                    <div class="title3">애즈</div>
                    <!-- title End -->
                    <div class="tapBox">
                        <nav class="tapMenu">
                            <ul>
                                <li><a href="cpmgr.do?a=cpAdsList&cpid=<%=ads.getCpid()%>">캠페인 상세 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="cpmgr.do?a=adsInfo&adsid=<%=ads.getAdsid()%>">애즈 정보 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="cpmgr.do?a=adsTarget&adsid=<%=ads.getAdsid()%>" class="active">타겟팅 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="cpmgr.do?a=adsCreative&adsid=<%=ads.getAdsid()%>">광고물 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="cpmgr.do?a=adsSlot&adsid=<%=ads.getAdsid()%>">광고지면 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
                <!-- ads add title End -->
                <!-- ads add Table Start -->
                <input type="hidden" name="cpid" value="<%=cp.getCpid() %>"/>
                   <%--  
                    <table class="viewTable">
                        <colgroup>
                        <col width="9%">
                        <col width="22%">
                        <col width="9%">
                        <col width="24%">
                        <col width="9%">
                        <col width="27%">
                        </colgroup>
                        <tr>
                            <th>애즈명</th>
                            <td colspan="3">
                                <%=ads.getAdsname()%>
                                <input type="hidden" id="adsid" value="<%=ads.getAdsid()%>"/>
                            </td>
                            <th>판매방식</th>
                            <td>
                                <%=ads.getSalestypename() %>
                            </td>
                        </tr>
                        <tr>
                            <th>기간</th>
                            <td>
                                <%=ads.getPeriod().equals("0")?"No ":"" %>Period
                            </td>
                            <th>시작일</th>
                            <td>
                                <%=DateUtil.getYMD(ads.getStartdate()) %> (<%=ads.getStart_hour()%>시 <%=ads.getStart_min() %>분)
                            </td>
                            <th>종료일</th>
                            <td>
                                <%=DateUtil.getYMD(ads.getEnddate()) %> (<%=ads.getEnd_hour() %>시 <%=ads.getEnd_min() %>분)
                            </td>
                        </tr>
                       <tr>
                             <th>목표타입</th>
                            <td>
                                <%=ads.getGoaltypename() %>
                            </td>	
                            <th><label id="goalText">노출 목표량</label></th>
                            <td>
                               <%=StringUtil.addComma(ads.getGoal_total()) %>
							</td>
                             <th>일 목표 노출량</th>
                            <td>
                                <%=StringUtil.addComma(ads.getGoal_daily()) %>
                            </td>
   						</tr>
                         
   						<tr>
                             
                           <th>광고상품</th>
                            <td>
                                <%=ads.getPrtypename() %>
                            </td>
                              <th>집행금액</th>
                            <td>
                                <%=StringUtil.addComma(ads.getBudget()) %>
                            </td>
                            <th><label id="goalText">보장량</label></th>
                            <td>
                                <%=StringUtil.addComma(ads.getBook_total()) %>                             
							</td>
                        </tr>  
                        <tr>
                        <th>상태</th>
                            <td>
                                <%=ads.getAds_statename() %>
                            </td>
                                          
                        <th>수정일</th>
                            <td>
                                <%=DateUtil.getYMDHM(ads.getUpdatedate(),".") %>
                            </td>
                                            
                        <th>최종수정</th>
                            <td>
                                <%=DateUtil.getYMD(ads.getUpdateusername()) %>
                            </td>
                        </tr>                      
                    </table>--%>
               
<!-- add Table End -->
                <!-- targeting title -->
                <!-- title Start -->
                <div class="boxtitle3" style="width:800px;">                   
                    <h1 class="title4"><span class="glyphicon glyphicon-ok"></span> 타겟팅</h1>
                    <!-- title End -->
                </div>
				<form id="frmRegist" action="cpmgr.do?a=adsTargetSave">
				<input type="hidden" name="a" value="adsTargetSave"/> 
 				<input type="hidden" name="adsid" value="<%=ads.getAdsid()%>"/> 
 				<input type="text" class="debug" name="change" /> 
                <!-- targeting Table Start -->
                <table class="viewTable" style="width:800px;">
                    <colgroup>
                            <col width="10%">
                                <col width="40%">
                           <col width="10%">
                                <col width="40%">
                    </colgroup>                   
                    <tbody>
                                
 <%for(int i=0;i<codelist.size();i++){ 
	Map<String,String> code = codelist.get(i);
	
	if(i%2==0) {
		if(i>0) {
		%>
		</tr>
		<%} %>
		<tr>
		<%
	}
%>
                               <th><%=String.valueOf(code.get("isname")) %></th>
                                <td class="textCenter">
                                <input type="text" size=1 name="targettype" class="debug" value="<%= String.valueOf(code.get("isid"))%>"/>
                                 
                                <select id="target<%=String.valueOf(code.get("isid")) %>" name="tid" class="form-control input-sm" style="width:260px;"></select>
                                 
                                 </td>
                          
						 
<%} %>      
<th></th>
<td></td>


</tr>                
                                                     </tbody>
                </table>
                </form>
                <!-- targeting Table End -->
                <!-- button group Start -->
                <div class="buttonGroup" style="width:800px">
                <span id="warningMsg" style="color:#a00"></span>
                    <button type="button" class="btn btn-danger btn-sm" id="btnRegist">등록</button>
                    <button type="button" class="btn btn-default btn-sm">취소</button>
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
