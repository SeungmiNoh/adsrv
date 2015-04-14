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
	
	Map<String, Object> map = (Map<String, Object>)request.getAttribute("response");

	
	Campaign cp = (Campaign)map.get("cp");
	Ads ads = (Ads)map.get("ads");

	List<Map<String, String>> codelist = (List<Map<String, String>>)map.get("codelist");   
	JSONArray code_data = JSONArray.fromObject(codelist);
	
	      
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
		$('.numinput').onlyNumber();
		$("#adsname").focus();
		$(".debug").css("display","none");
		defaultDate();
		
		resetData();
		
		$("[name=period]").on("click", function(e){
			
			if($('input:radio[name="period"]:checked').val()==0){
				
				$("#start").val("<%=DateUtil.getYMD(cp.getStartdate())%>");
				$("#end").val("9999-12-31");

				$(".period").val("0");				
				$(".period").prop( "disabled", true );
				
				$(".datepicker").prop( "disabled", true );
				$(".datepicker").datepicker( "option", "disabled", true );
			} else {
				$(".period").prop( "disabled", false );
				defaultDate();
				$(".datepicker").datepicker( "option", "disabled", false );
			}
		});
		/*********************** 선택옵션 *****************************/
		var code_data = <%=code_data%>;
		var cur_code = "";
		var htmlstr = "";
		for(var k=0; k<code_data.length; k++) {
			if(cur_code != code_data[k].code) {
				cur_code = code_data[k].code;
			}
			htmlstr = '<option value="'+code_data[k].isid+'"';
			if(code_data[k].isdefault=="1"){  
				htmlstr += ' selected';				
			}
			htmlstr += '>'+code_data[k].isname+'</option>';
			
			
			$("#"+code_data[k].code).append(htmlstr);
			console.log(htmlstr);
		}
	});
  

 
  $(function() {
	  

	  

		
		
		
		$("#goaltype").on("change", function(e){				
			setGoaltype();
		});		
		
		
		$("#salestype").on("change", function(e){
			if($("#salestype").val()==3) // 하우스경우 
			{
				$("#goal_daily").prop( "disabled", true );			
				$("#goal_daily").val("0");
				
			} else {
				$("#goaltype").val("1");
				$("#goal_daily").prop( "disabled", false );			
			}
			setGoaltype();

		});		
		
		
		$("#btnRegist").on("click", function(e){
			e.preventDefault();
			$("#btnRegist input, #btnRegist select").css("border-color", "#ccc");
			if($.trim($("#adsname").val()).length==0){
				$("#adsname").css("border-color","red").focus();
				$("#warningMsg").text("애즈명을 입력해주세요.");
				return;
			}else if($.trim($("#start").val()).length!=10){
				$("#start").css("border-color","red").focus();
				$("#warningMsg").text("시작일을 선택해주세요.");
				return;
			}else if($.trim($("#end").val()).length!=10){
				$("#end").css("border-color","red").focus();
				$("#warningMsg").text("종료일을 선택해주세요.");
				return;
			}else if($.trim($("#goal_total").val()).length==0){
				$("#goal_total").css("border-color","red").focus();
				$("#warningMsg").text($("#goalText")+"을 입력해주세요.");
				return;
			}else if($.trim($("#budget").val()).length==0){
				$("#budget").css("border-color","red").focus();
				$("#warningMsg").text("집행 금액을 입력해주세요.");
				return;
			}else if($.trim($("#book_total").val()).length==0){
				$("#book_total").css("border-color","red").focus();
				$("#warningMsg").text("보쟝량을 입력해주세요.");
				return;
			}else{
				;
			}
			if(confirm("애즈를 등록하시겠습니까?")){
				$("#frmRegAds").submit();					
			}
		});

		
		$.datepicker.regional['ko'] = {
				closeText: '닫기',
				prevText: '이전달',
				nextText: '다음달',
				currentText: '오늘',
				monthNames: ['1월','2월','3월','4월','5월','6월', '7월','8월','9월','10월','11월','12월'],
				monthNamesShort: ['1월','2월','3월','4월','5월','6월', '7월','8월','9월','10월','11월','12월'],
				dayNames: ['일','월','화','수','목','금','토'],
				dayNamesShort: ['일','월','화','수','목','금','토'],
				dayNamesMin: ['일','월','화','수','목','금','토'],
				weekHeader: 'Wk',
				dateFormat: 'yy-mm-dd',
				firstDay: 0,
				isRTL: false,
				duration:200,
				showAnim:'show',
				showMonthAfterYear: true,
				yearSuffix: '년'};
			$.datepicker.setDefaults($.datepicker.regional['ko']);
		
			$("#start").datepicker({
				dateFormat: 'yy-mm-dd',
				changeMonth:true,
				changeYear:true,
				onClose: function(selectDate){
						$("#end").datepicker("option","minDate",selectDate);
						$(this).trigger("change");
				}
		});
		$("#end").datepicker({
				dateFormat: 'yy-mm-dd',
				changeMonth:true,
				changeYear:true,
				onClose: function(selectDate){
						$("#start").datepicker("option","maxDate",selectDate);
						$(this).trigger("change");
				}
		});
 
	    
	    
  });
 
	function setGoaltype() {
		if($("#goaltype").val()<=1) // 목표기간 완료, 목표 없음	
		{
			$("#goalText").text("");				
			$("#goal_total").val("0");
			$("#goal_total").prop( "disabled", true );				
		} else {
			if($("#goaltype").val()==2){ // 목표 노출 완료
				$("#goalText").text("노출 ");					
			} else if($("#goaltype").val()==3)  {	// 목표 클릭 완료
				$("#goalText").text("클릭 ");
			} else if($("#goaltype").val()==4) { // 목표 Hit 완료
				$("#goalText").text("Hit ");
			}
			$("#goal_total").prop( "disabled", false );				
			$("#goal_total").attr("placeholder",$("#goalText").text()+"목표량");
		}
	}

	function defaultDate() {
		
		<%if(StringUtil.isNull(ads.getAdsid()).equals("")) {%>
		
		$("#start").val("<%=DateUtil.getYMD(cp.getStartdate())%>");
		$("#end").val("<%=DateUtil.getYMD(cp.getEnddate())%>");
		$("#start_hour").val("0"); 
		$("#start_min").val("0");
		$("#end_hour").val("24"); 
		$("#end_min").val("0");
		<% }else{ %>
		
		$("#start").val("<%=DateUtil.getYMD(ads.getStartdate())%>");
		$("#start_hour").val("<%=ads.getStart_hour()%>");
		$("#start_min").val("<%=ads.getStart_min()%>");
		$("#end").val("<%=DateUtil.getYMD(ads.getEnddate())%>");
		$("#end_hour").val("<%=ads.getEnd_hour()%>");
		$("#end_min").val("<%=ads.getEnd_min()%>");
		<%}%>
	}
 
	function resetData() {
		$("#adsname").val("<%=ads.getAdsname()%>");
		$("#salestype").val("<%=ads.getSalestype()%>");
		
		$("input:radio[name='period']:radio[value='<%=ads.getPeriod()%>']").prop('checked',true);

		

		
		
		$("#goaltype").val("<%=ads.getGoaltype()%>");
		$("#goal_total").val("<%=StringUtil.addComma(ads.getGoal_total())%>");
		$("#book_total").val("<%=StringUtil.addComma(ads.getBook_total())%>");
		$("#goal_daily").val("<%=StringUtil.addComma(ads.getGoal_daily())%>");
		$("#prtype").val("<%=ads.getPrtype()%>");
		$("#budget").val("<%=StringUtil.addComma(ads.getBudget())%>");
		$("#ads_state").val("<%=ads.getAds_state()%>");
		defaultDate();
	}
  
  
  </script>

</head>

<body>
    <div class="container-fluid containerBg">
        <div class="containerBox">
        <%@ include file="../common/header.jsp"  %>
            <section class="sectionBox">
                <div class="boxTitle">
                    <!-- title Start -->
                    <div class="title">캠페인 정보</div>
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
                <!-- ads add title Start -->
                <div class="boxtitle2">
                    <!-- title Start -->
                    <div class="title3">애즈</div>
                    <!-- title End -->
                    <div class="tapBox">
                        <nav class="tapMenu">
                            <ul>
                                <li><a href="cpmgr.do?a=adsInfo&adsid=<%=ads.getAdsid()%>" class="active">애즈 정보 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="cpmgr.do?a=adsTarget&adsid=<%=ads.getAdsid()%>">타겟팅 <span class="glyphicon glyphicon-menu-right"></span></a>
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
                <form id="frmRegAds" method="post" role="form" action="cpmgr.do?a=adsRegist">
                <input type="hidden" name="cpid" value="<%=cp.getCpid() %>"/>
                <input type="hidden" id="adsid"  name="adsid" value=""/>
                    <table class="addTable">
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
                            <td class="form-inline" colspan="3">
                                <input type="text" name="adsname" id="adsname" class="form-control input-sm" style="width:400px">
                            </td>
                            <th>판매방식</th>
                            <td class="form-inline">
                                <select id="salestype" name="salestype" class="form-control input-sm"  style="width:160px;">
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th>기간</th>
                            <td class="form-inline">
                                <label class="radio-inline"><input type="radio" name="period" value="1"> Period</label>
                                <label class="radio-inline"><input type="radio" name="period" value="0"> No Period</label>
                            </td>
                            <th>시작일</th>
                            <td class="form-inline">
                                <input type="text" class="form-control input-sm datepicker" style="cursor:pointer;width:100px" id="start" name="startdate" placeholder="시작일" readonly>                                
                                	<select id="start_hour" name="start_hour" class="form-control input-sm period">
                                     <%for(int i=0;i<=23;i++){ %>
                                    <option value="<%=String.valueOf(i)%>"><%=DateUtil.getMMStr(String.valueOf(i))%>시</option>
                                    <%} %>
                                </select>
                                <select id="start_min" name="start_min" class="form-control input-sm period">
                                       <%for(int i=0;i<6;i++){ %>
                                    <option value="<%=String.valueOf(i*10)%>"><%=DateUtil.getMMStr(String.valueOf(i*10))%>분</option>
                                    <%} %>                                    
                                </select>
                            </td>
                            
                            
                            <th>종료일</th>
                            <td class="form-inline">
                                 <input type="text" class="form-control input-sm datepicker" style="cursor:pointer;width:100px" id="end" name="enddate" placeholder="종료일" readonly>                                
                                	<select id="end_hour" name="end_hour" class="form-control input-sm period">
                                     <%for(int i=0;i<=24;i++){ %>
                                    <option value="<%=String.valueOf(i)%>" <%=i==24?"selected":"" %>><%=DateUtil.getMMStr(String.valueOf(i))%>시</option>
                                    <%} %>
                                </select>
                                <select id="end_min" name="end_min" class="form-control input-sm period">
                                      <%for(int i=0;i<6;i++){ %>
                                    <option value="<%=String.valueOf(i*10)%>" ><%=DateUtil.getMMStr(String.valueOf(i*10))%>분</option>
                                    <%} %>                                    
                                </select>
                         </td>
                        </tr>
                       <tr>
                            
                            <th>목표타입</th>
                            <td class="form-inline">
                                <select id="goaltype" name="goaltype" class="form-control input-sm">
                                </select>
                            </td>	
                            <th><label id="goalText">노출</label> 목표량</th>
                            <td class="form-inline">
                                <input type="text" name="goal_total" id="goal_total" class="form-control input-sm numinput goal" style="width:200px; text-align:right" placeholder="목표 노출량">                             
							</td>
                        
                            
                            <th>일 목표 노출량</th>
                            <td class="form-inline">
                                <input type="text" id="goal_daily" name="goal_daily" class="form-control input-sm numinput" style="width:200px; text-align:right" placeholder="일간 목표 노출량">
                            </td>
   						</tr>
                         
   <tr>
                             
                           <th>광고상품</th>
                            <td class="form-inline">
                                <select id="prtype" name="prtype" class="form-control input-sm" style="width:160px;">
                                 </select>
                            </td>
                              <th>집행금액</th>
                            <td class="form-inline">
                                <input type="text" name="budget" id="budget" class="form-control input-sm numinput" style="width:160px; text-align:right">
                            </td>
                            <th><label id="goalText">보장량</label></th>
                            <td class="form-inline">
                                <input type="text" name="book_total" id="book_total" class="form-control input-sm numinput goal" style="width:200px; text-align:right" placeholder="보장량">                             
							</td>
                        </tr>  
                        <tr>
                        <th>상태</th>
                            <td class="form-inline">
                                <select id="ads_state" name="ads_state" class="form-control input-sm" <%if(StringUtil.isNull(ads.getAdsid()).equals("")) {%>disabled="disabled"<%} %>>
                                 </select>
                            </td>
                                          
                        <th>등록일</th>
                            <td class="form-inline">
                                <%=DateUtil.getYMD(DateUtil.curDate()) %>
                            </td>
                                              
                        <th>등록자</th>
                            <td class="form-inline">
                                <%=userName %>
                            </td>
                        </tr>                      
                    </table>
                </form>
                <!-- add Table End -->
                <!-- button group Start -->
                <div class="buttonGroup">
                <span id="warningMsg" style="color:#a00"></span>
                    <button type="button" class="btn btn-danger btn-sm" id="btnRegist">수정</button>
                    <a role="button" class="btn btn-default btn-sm" href="javascript:resetData()">Reset</a>
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