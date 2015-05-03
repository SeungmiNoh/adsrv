<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
                 <div class="boxtitle2">
                     <!-- title Start -->
                    <div class="taptitle">애즈
                    <a class="btn btn-danger btn-xs" href="cpmgr.do?a=adsAddForm&cpid=<%=cp.getCpid() %>" role="button" style="float:right;margin-left:300px;">애즈등록</a>
                    </div>
                    <!-- title End -->
                   <div class="tapBox" >
                        <nav class="tapMenu">
                        <ul>
                                <li><a href="cpmgr.do?a=cpAdsList&cpid=<%=ads.getCpid()%>">애즈 목록 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="cpmgr.do?a=adsInfo&adsid=<%=ads.getAdsid()%>">애즈 상세 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a name="menuLink" href="#none" a="adsEditTarget" class="<%=a.equals("adsEditTarget")?"active":""%>">타겟팅<span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a name="menuLink" href="#none" a="adsEditCreative" class="<%=a.equals("adsEditCreative")?"active":""%>" class="active">광고물 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>                               
                                <li><a name="menuLink" href="#none" a="adsEditSlot" class="<%=a.equals("adsEditSlot")?"active":""%>">광고 위치<span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                             </ul>
                       </nav>
                    </div>
                    <div class="tapBox_ads">                   	
	 					<form id="frmAds" method="get" action="cpmgr.do">
		                <input type="hidden" name="a" value="<%=a %>"/>
		                <input type="hidden" name="adsid" value="<%=ads.getAdsid()%>"/>
		                <input type="hidden" name="cp_startdate" value="<%=cp.getStartdate() %>"/>
		                <input type="hidden" name="cp_enddate" value="<%=cp.getEnddate() %>"/>		                
	                    <select id="moveid" class="form-control input-sm" style="width:300px;">
<%

for(int k=0; k<adslist.size(); k++){
                                        
    Ads mads = adslist.get(k);
    
	 
 %>                     
                        <option value="<%=mads.getAdsid()%>" <%=adsid.equals(mads.getAdsid())?"selected":"" %>><%=mads.getAdsname() %></option>
 <%} %>                 </select>
                		</form>         
                		
                    	</div>  
                </div>				
    			<form id="frmAdsDel" method="post" role="form" action="cpmgr.do?a=modDelAds">
				<input type="hidden" name="backuri" value="<%=a%>"/>
				<input type="hidden" id="adsid"  name="adsid" value="<%=ads.getAdsid() %>"/>
				<input type="hidden" id="cpid"  name="cpid" value="<%=ads.getCpid() %>"/>
				</form>
 				<form id="frmAdsCopy" method="post" role="form" action="cpmgr.do?a=adsCopy">
				<input type="hidden" name="backuri" value="<%=a%>"/>
				<input type="hidden" id="adsid"  name="adsid" value="<%=ads.getAdsid() %>"/>
				<input type="hidden" name="cpstartdate" value="<%=cp.getStartdate() %>"/>
				<input type="hidden" name="cpenddate" value="<%=cp.getEnddate() %>"/>
				</form>
                <form id="frmAdsInfo" method="post" role="form" action="cpmgr.do?a=adsRegist">
                <input type="hidden" name="cpid" value="<%=ads.getCpid() %>"/>
 				<input type="hidden" name="backuri" value="<%=a%>"/>
                <input type="hidden" id="change" size="4"/>
                <input type="hidden" id="adsid"  name="adsid" value="<%=ads.getAdsid() %>"/>
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
                            <th>애즈명<span style="color:red"> * </span></th>
                            <td class="form-inline" colspan="3">
                                <input type="text" name="adsname" id="adsname" class="form-control input-sm" value="<%=ads.getAdsname()%>" style="width:280px">
                            </td>
                            <th>광고상품<span style="color:red"> * </span></th>
                            <td class="form-inline">
                                <select id="prtype" name="prtype" class="form-control input-sm" style="width:100px;">
                                 </select>
                            </td>
                        </tr>
  						<tr>
                             <th>세일즈 구분<span style="color:red"> * </span></th>
                            <td class="form-inline">
                                <select id="salestype" name="salestype" class="form-control input-sm"  style="width:100px;">
                                </select>
                            </td>
                             <th>집행금액<span style="color:red"> * </span></th>
                            <td class="form-inline">
                                <input type="text" name="budget" id="budget" class="form-control input-sm numinput" style="width:160px; text-align:right">
                            </td>
                       		<th>상태</th>
                            <td class="form-inline">
                                <select id="ads_state" name="ads_state" style="width:100px" class="form-control input-sm" <%if(StringUtil.isNull(ads.getAdsid()).equals("")) {%>disabled="disabled"<%} %>>
                                 </select>
                            </td>
                        </tr>  
                        <tr>
                            <th>기간<span style="color:red"> * </span></th>
                            <td class="form-inline">
                                <label class="radio-inline"><input type="radio" name="period" value="1"> Period</label>
                                <label class="radio-inline"><input type="radio" name="period" value="0"> No Period</label>
                            </td>
                            <th>시작일<span style="color:red"> * </span></th>
                            <td class="form-inline">
                                <input type="text" id="start" class="start form-control nopad datepicker period" style="width:90px">                                
                                	<select id="start_hour" name="start_hour" class="form-control nopad input-sm period">
                                     <%for(int i=0;i<=23;i++){ %>
                                    <option value="<%=DateUtil.getMMStr(String.valueOf(i))%>" <%=ads.getStart_hour().equals(DateUtil.getMMStr(String.valueOf(i)))?"selected":""%>><%=DateUtil.getMMStr(String.valueOf(i))%>시</option>
                                    <%} %>
                                </select>
                                <select id="start_min" name="start_min" class="form-control nopad input-sm period">
                                       <%for(int i=0;i<6;i++){ %>
                                    <option value="<%=DateUtil.getMMStr(String.valueOf(i*10))%>" <%=ads.getStart_min().equals(DateUtil.getMMStr(String.valueOf(i*10)))?"selected":""%>><%=DateUtil.getMMStr(String.valueOf(i*10))%>분</option>
                                    <%} %>                                    
                                </select>
                                <input type="hidden" id="startdate" name="startdate" size=10/>
                            </td>
                             <th>종료일<span style="color:red"> * </span></th>
                            <td class="form-inline">
                                 <input type="text" id="end" class="end form-control nopad input-xs datepicker period" style="width:90px">                                
                                	<select id="end_hour" name="end_hour" class="form-control nopad input-sm period">
                                     <%for(int i=0;i<=24;i++){ %>
                                    <option value="<%=DateUtil.getMMStr(String.valueOf(i))%>"  <%=ads.getEnd_hour().equals(DateUtil.getMMStr(String.valueOf(i)))?"selected":""%>><%=DateUtil.getMMStr(String.valueOf(i))%>시</option>
                                    <%} %>
                                </select>
                                <select id="end_min" name="end_min" class="form-control nopad input-sm period">
                                      <%for(int i=0;i<6;i++){ %>
                                    <option value="<%=DateUtil.getMMStr(String.valueOf(i*10))%>"  <%=ads.getEnd_min().equals(DateUtil.getMMStr(String.valueOf(i*10)))?"selected":""%>><%=DateUtil.getMMStr(String.valueOf(i*10))%>분</option>
                                    <%} %>                                    
                                </select>
                                <input type="hidden" id="enddate" name="enddate" size=10/>
                         </td>	
                        </tr>
                       <tr>
                            <th>목표타입<span style="color:red"> * </span></th>
                            <td class="form-inline">
                                <select id="goaltype" name="goaltype" class="form-control input-sm" style="width:100px">
                                </select>
                            </td>
                            <th><label class="goalText" id="goalText">노출</label> 보장량<span style="color:red"> * </span></th>
                            <td class="form-inline">
                                <input type="text" name="book_total" id="book_total" class="form-control input-sm numinput goal" style="width:160px; text-align:right" placeholder="보장량">                             
							</td>                            	
                            <th><label class="goalText">노출</label> 목표량<span style="color:red"> * </span></th>
                            <td class="form-inline">
                                <input type="text" name="goal_total" id="goal_total" class="form-control input-sm numinput goal" style="width:160px; text-align:right" placeholder="목표 노출량">                             
							</td>
   						</tr>
                         <tr>
  							<th>일 목표 노출량</th>
                            <td class="form-inline">
                                <input type="text" id="goal_daily" name="goal_daily" class="form-control input-sm numinput" style="width:160px; text-align:right" placeholder="일간 목표 노출량">
                            </td>                       
  							<th>광고 단가</th>
                            <td class="form-inline">
                                <input type="text" id="cost" name="cost" class="form-control input-sm numinput" style="width:160px; text-align:right" placeholder="프리즘 Hit 단가">
                            </td>   
                            <th>최종수정</th>
                            <td class="form-inline"><span id="updateusername"></span> (<span id="updatedate">)</span></td>                       	
                        </tr>  
                        <tr>
                        <th colspan="6" style="background-color:#f3f3f3">
                        <div class="buttonGroup">
                 	<span id="warningMsg" style="color:#a00"></span>
                    <button type="button" class="btn btn-success btn-sm" id="btnAdsSave">수정</button> 
                    <%if(!mode.equals("N")){ %>                  
                    <button type="button" class="btn btn-warning btn-sm" id="btnAdsCopy">복사</button>
                     <a class="btn btn-default btn-sm" href="#none" name="btnAdsDel">삭제</a>
                    <a role="button" class="btn btn-default btn-sm" href="rptmgr.do?a=adsRpt&cpid=<%=cp.getCpid()%>">리포트</a>
                    <%} %>
                    
                	</div>
                	</th>
                        </tr>                    
                    </table>
                	
                </form>
                <script>
        	$(document).on("click", "[name=menuLink]", function(e){
      		  
        	  	$("#frmAds input[name=a]").val($(this).attr("a"));
        	  	$("#frmAds").submit();
        	});
            	
            	
$(document).ready(function() 
{
	
	
	

	
	
	
	
	
	
	
	
	
	
	defaultDate = function() {
		$("#startdate").val("<%=ads.getStartdate()%>");
		$("#enddate").val("<%=ads.getEnddate()%>");
		$("#start").val("<%=DateUtil.getYMD(ads.getStartdate())%>");
		$("#start_hour").val("<%=ads.getStart_hour()%>");
		$("#start_min").val("<%=ads.getStart_min()%>");
		$("#end").val("<%=DateUtil.getYMD(ads.getEnddate())%>");
		$("#end_hour").val("<%=ads.getEnd_hour()%>");
		$("#end_min").val("<%=ads.getEnd_min()%>");
		$("#updatedate").html("<%=DateUtil.getYMDHM(ads.getUpdatedate(),"-")%>");
		$("#updateusername").html("<%=ads.getUpdateusername()%>");
	}
 	resetData = function() {
		$("#adsname").val("<%=ads.getAdsname()%>");
		$("#salestype").val("<%=ads.getSalestype()%>");
		
		$("input:radio[name='period']:radio[value='<%=ads.getPeriod()%>']").prop('checked',true);
		
		$("#goaltype").val("<%=ads.getGoaltype()%>");
		$("#goal_total").val("<%=StringUtil.addComma(ads.getGoal_total())%>");
		$("#book_total").val("<%=StringUtil.addComma(ads.getBook_total())%>");
		$("#goal_daily").val("<%=StringUtil.addComma(ads.getGoal_daily())%>");
		$("#prtype").val("<%=ads.getPrtype()%>");
		$("#budget").val("<%=StringUtil.addComma(ads.getBudget())%>");
		$("#cost").val("<%=StringUtil.addComma(StringUtil.isNullZero(ads.getCost()))%>");
		$("#ads_state").val("<%=ads.getAds_state()%>");
		defaultDate();
	}
	//datepicker
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
			buttonImageOnly: true,
			showAnim:'show',
			showMonthAfterYear: true,
			yearSuffix: '년'};
		$.datepicker.setDefaults($.datepicker.regional['ko']);
		$(".start").datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth:true,
			changeYear:true,
			onClose: function(selectDate){
					$(".end").datepicker("option","minDate",selectDate);	
			}
		});
		$(".end").datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth:true,
			changeYear:true,
			onClose: function(selectDate){
					$(".start").datepicker("option","maxDate",selectDate);					
			}
		});
	/*********************** 애즈 선택옵션 *****************************/
	var ads_code = <%=ads_code_data%>;
	var cur_code = "";
	var htmlstr = "";
	for(var k=0; k<ads_code.length; k++) {
		if(cur_code != ads_code[k].code) {
			cur_code = ads_code[k].code;
		}
		htmlstr = '<option value="'+ads_code[k].isid+'"';
		if(ads_code[k].isdefault=="1"){  
			htmlstr += ' selected';				
		}
		htmlstr += '>'+ads_code[k].isname+'</option>';
		$("#"+ads_code[k].code).append(htmlstr);
		
	}
	setGoaltype = function() {
		
		if($("#goaltype").val()<=1) // 목표기간 완료, 목표 없음	
		{
			$(".goalText").text("");				
			$("#goal_total").val("0");
			$("#goal_total").prop( "disabled", true );	
			$("#book_total").val("0");
			$("#book_total").prop( "disabled", true );	
		} else {		
			if($("#goaltype").val()==2){ // 목표 노출 완료
				$(".goalText").text("노출 ");					
			} else if($("#goaltype").val()==3)  {	// 목표 클릭 완료
				$(".goalText").text("클릭 ");
			} else if($("#goaltype").val()==4) { // 목표 Hit 완료
				$(".goalText").text("Hit ");
			}
			
			$("#goal_total").prop( "disabled", false );				
			$("#goal_total").attr("placeholder",$("#goalText").text()+"목표량");
			$("#book_total").prop( "disabled", false );				
			$("#book_total").attr("placeholder",$("#goalText").text()+"보장량");
			}
		if($("#goaltype").val()!=4) { // 목표 Hit 완료
			$("#cost").prop( "disabled", true);
		} else {
			$("#cost").prop( "disabled", false );
		}
	}
	
	// 광고상품 변경
	$("#prtype").on("change", function(e){
		if($("#prtype").val()==2) // 프리즘 경우 
		{
			$("#goaltype").val("4");
		} else {
			$("#goaltype").val("2");
		}
		setGoaltype();
	});
    setDate = function () {
		var startdate = delDash($("#start").val())+$("#start_hour").val()+$("#start_min").val();				
		var enddate = delDash($("#end").val())+$("#end_hour").val()+$("#end_min").val();
		$("#startdate").val(startdate);
		$("#enddate").val(enddate);
		
	}
	
	// 로딩시
	resetData();
	setGoaltype();		
	
		
	
	
	
	
	
	
	
	
	
	
	
//애즈 선택시 선택 애즈정보로 변경
	$("#moveid").on("change", function(e){
		if($("#adsid").val()!= $("#moveid").val()) 
		{
			$("#frmAds input[name=adsid]").val($("#moveid").val());
			$("#frmAds").submit();
		}		
	});
	
	$('#frmAdsInfo').on("change", function(e){	
		$("#frmAdsInfo #change").val("change");
	});
	
	$("[name=period]").on("click", function(e){
		
		if($('input:radio[name="period"]:checked').val()==0){
			
			$("#start").val("");
			$("#end").val("2037-12-31");
			$("#start_hour").val("00");
			$("#start_min").val("00");
			$("#end").val("2037-12-31");
			$("#end_hour").val("24");
			$("#end_min").val("00");
	
			$(".period").prop( "disabled", true );
			setDate();
			$(".datepicker").prop( "disabled", true );
			$(".datepicker").datepicker( "option", "disabled", true );
		} else {
			$(".period").prop( "disabled", false );
			defaultDate();
			$(".datepicker").datepicker( "option", "disabled", false );
		}
	});	
	$("#goaltype").on("change", function(e){				
		setGoaltype();
	});		
	
	// 세일즈 변경
	$("#salestype").on("change", function(e){
		if($("#salestype").val()==3) // 하우스경우 
		{
			//$("#goal_daily").prop( "disabled", true );			
			//$("#goal_daily").val("0");
			$("#goaltype").val("1");
			
		} else {
			$("#goaltype").val("2");
			//$("#goal_daily").prop( "disabled", false );			
		}
		setGoaltype();
	
	});
	
	$("#btnAdsCopy").on("click", function(e){	
		if(confirm("애즈를 복사하시겠습니까?")) {								
			$("#frmAdsCopy").submit();
		}					
	});	
	$(document).on("click", "a[name=btnAdsDel]", function(e){
		if(confirm("애즈를 삭제하시겠습니까?")) {								
			$("#frmAdsDel").submit();
		}					
	});	
	$("#btnAdsSave").on("click", function(e){
		e.preventDefault();
		$("#frmAdsInfo input, #frmAdsInfo select").css("border-color", "#ccc");
		if($("#frmAdsInfo #change").val() != "change"){
			alert("변경된 내용이 없습니다.");
			return;
		}else if( ($("#prtype").val() =="1" && $("#goaltype").val()=="4") ||($("#prtype").val() =="2" && $("#goaltype").val()!="4") ){
			$("#prtype").css("border-color","red").focus();
			$("#goaltype").css("border-color","red").focus();
			$("#warningMsg").text("광고상품과 목표타입을 확인해주세요.");
			return;
		}else if($.trim($("#adsname").val()).length==0){
			$("#adsname").css("border-color","red").focus();
			$("#warningMsg").text("애즈명을 입력해주세요.");
			return;
		}else if($.trim($("#start").val()).length!=10){
			$("#start").css("border-color","red").focus();
			$("#warningMsg").text("시작일을 선택해주세요.");
			return;
		}else if (delDash($("#start").val()) < $("[name=cp_startdate]").val()) {
			$("#start").css("border-color","red").focus();				
	      	$("#warningMsg").text("애즈 기간은 캠페인 기간을 벗어날 수 없습니다.");
			return;
	    }else if($.trim($("#end").val()).length!=10){
			$("#end").css("border-color","red").focus();
			$("#warningMsg").text("종료일을 선택해주세요.");
			return;
		}else if($.trim($("#budget").val()).length==0){
			$("#budget").css("border-color","red").focus();
			$("#warningMsg").text("집행 금액을 입력해주세요.");
			return;
		}else if($("#period").val()!=0 && delDash($("#end").val()) > $("[name=cp_enddate]").val()) {
			$("#end").css("border-color","red").focus();				
	      	$("#warningMsg").text("애즈 기간은 캠페인 기간을 벗어날 수 없습니다.");
			return;
	    }else if($.trim($("#goal_total").val()).length==0){
			$("#goal_total").css("border-color","red").focus();
			$("#warningMsg").text($("#goalText")+"목표량을 입력해주세요.");
			return;
		}else{
			setDate();
		}
		
		if(confirm("애즈 정보를 수정하시겠습니까?")){
			$('.numinput').onlyNumberDelComma();
			$("#frmAdsInfo").submit();					
		}
	});	
});	
</script>