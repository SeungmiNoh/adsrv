 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>				
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
                        <td colspan="3">                       
                        <%if(StringUtil.isNull(cp.getIsprism()).equals("Y")){ %>
                        <a href="rptmgr.do?a=summaryPrism&cpid=<%=cp.getCpid() %>"><span class="label label-warning" style="margin-right:6px">P</span></a>
                        <%}%>
                        <%=cp.getCpname() %>

                        <a class="btn btn-primary btn-xs" href="cpmgr.do?a=cpAdsList&cpid=<%=cp.getCpid() %>" role="button" style="float:right;margin-left:5px;">정보</a>
                        
                        </td>
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
                        <td><%=StringUtil.addComma(cp.getBook_total()) %></td>
                        <th>목표량</th>
                        <td><%=StringUtil.addComma(cp.getGoal_total()) %></td>
                        <th>집행금액</th>
                        <td><%=StringUtil.addComma(cp.getBudget()) %></td>
                    </tr>
                    <tr>
                        <th>시작일</th>
                        <td><%=DateUtil.getYMD(cp.getStartdate(), "-") %></td>
                        <th>종료일</th>
                        <td><%=DateUtil.getYMD(cp.getEnddate(), "-") %></td>
                        <th>상태</th>
                        <td><span class="<%=cp.getText()%>"><%=StringUtil.isNull(cp.getCp_statename()) %></span></td>
                    </tr>
                </table>
                <div class="buttonGroup" style="width:900px">
                                         
                </div>              
               <form id="frmRpt" action="rptmgr.do" method="get">
                <input type="hidden" name="a" value="<%=a %>">
                <input type="hidden" name="cpid" value="<%= cp.getCpid()%>">
                <!-- tap menu Start -->
                <div class="tapBox3">
                		<nav class="tapMenu">
                            <ul>  
                                <li><a href="#none" a="summaryPrism" name="menuLink" class="<%=a.equals("summaryPrism")?"active":""%>">요약리포트<span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="#none" a="adsPrismRpt" name="menuLink" class="<%=a.equals("adsPrismRpt")?"active":""%>">애즈 리포트<span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="#none" a="crPrismRpt" name="menuLink" class="<%=a.equals("crPrismRpt")?"active":""%>">광고물 리포트<span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>                               
                                <li><a href="#none" a="timePrismRpt" name="menuLink" class="<%=a.equals("timePrismRpt")?"active":""%>">시간 리포트<span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <%if(isMain.equals("1")){ %>
                                <li><a href="#none" a="cpMedPrismRpt" name="menuLink" class="<%=a.equals("cpMedPrismRpt")?"active":""%>">매체 리포트<span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <%} %>
                            </ul>
                        </nav>
                 </div>
                 <!-- tap menu End -->
                <!-- campaign view End -->
                <!-- ads list Start -->
                <div class="boxtitle3">
                    <!-- saveBtn Start -->
                    <div class="saveBtn4">
                        <div class="form-inline">
                            <div class="form-group">
<%if(adslist!=null){ %>
							<select id="adsid" name="adsid" class="form-control input-sm" style="width:300px;">
							<option value="">애즈 선택</option>
<%

for(int k=0; k<adslist.size(); k++){
                                        
    Ads mads = adslist.get(k);
    
	 
 %>                     
                        <option value="<%=mads.getAdsid()%>"><%=mads.getAdsname() %></option>
 <%} %>                 </select>     
 <%} %>                       
                                <input type="text" class="form-control input-sm" name="sday" id="sday" value="" style="width:90px">
                                <a class="btn btn-success btn-sm" href="#none" role="button" id="btnSday"><span class="glyphicon glyphicon-calendar"></span></a>
                                <input type="text" class="form-control input-sm" name="eday" id="eday" value="" style="width:90px">
                                <a class="btn btn-success btn-sm" href="#none" role="button" id="btnEday"><span class="glyphicon glyphicon-calendar"></span></a>
                                <a class="btn btn-warning" href="javascript:$('#frmRpt').submit()" role="button">조회</a>
                                 <a class="btn btn-default" href=""><img src="<%=web %>/img/page_excel.png" alt="excel Icon"></a>
                            </div>
                        </div>
                    </div>
                    <!-- saveBtn End -->
                    <div class="boxtitle3" style="width:900px;">                   
                    	<h1 class="title4"><span class="glyphicon glyphicon-align-justify"></span> <span id="rptTitle">애즈 리포트</span></h1>
                	</div>
                    </div>
                    </form>
 <script type="text/javascript">
$(function(){
	
	

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
	
		$("#sday").datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth:true,
			changeYear:true,
			onClose: function(selectDate){
					$("#eday").datepicker("option","minDate",selectDate);					
			}
	});
	$("#eday").datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth:true,
			changeYear:true,
			onClose: function(selectDate){
					$("#sday").datepicker("option","maxDate",selectDate);
			}
	});
	

});

	$(document).ready(function() {
	
		/*********************** 제목 셋팅 *****************************/
		var rpttitle = ($("[name=menuLink].active").text());
		$("#rptTitle").html(rpttitle);
		
		
		
	/*********************** 파라미터 선택옵션 *****************************/
	var obj = <%=param_data%>;
	
	jQuery.each(obj, function(i, val) {
		  $("#" + i).append(document.createTextNode(" - " + val));
		  $("#"+i).val(val);
		  if(i=="sday" || i=="eday") {
			  $("#"+i).val(getYMD(val,"-"));
		  }
	});
	
	$(document).on("click", "[name=menuLink]", function(e){
	  
	  	$("#frmRpt input[name=a]").val($(this).attr("a"));
	  	$("#frmRpt").submit();
	});
	
	//애즈 선택시 선택 애즈정보로 변경
	$("#adsid").on("change", function(e){
		//if($("#adsid").val()!= $("#moveid").val()) 
		//{
			//$("#frmRpt input[name=adsid]").val($("#moveid").val());
			$("#frmRpt").submit();
		//}		
	});
});
</script>               