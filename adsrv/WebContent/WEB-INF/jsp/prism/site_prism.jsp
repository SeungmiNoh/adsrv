 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>				
           <table class="viewTable" style="width:500px">
                    <colgroup>
                        <col width="20%">
                            <col width="">
                                <col width="20%">
                                    <col width="">
                    </colgroup>
                    <tr>
                        <th>사이트명</th>
                        <td><%=site.get("sitename") %></td>
                        <th>업체</th>
                        <td><%=site.get("corpname") %></td>
                    </tr>
                    <tr>
                        <th>사이트구분</th>
                        <td><%=site.get("sitetypename") %></td>
                        <th>이름</th>
                        <td></td>
                    </tr>
                </table>
                <br>
                <br>
                <!-- view Table End -->
                <!-- tap menu Start -->
                <div class="tapBox3">
                    <nav class="tapMenu">
                        <ul>
                            <li><a href="#none" a="sitePrismDaily" class="menuLink <%=a.equals("sitePrismDaily")?"active":""%>">일자별 리포트</a>
                            </li>
                            <li><a href="#none" a="sitePrismTime" class="menuLink <%=a.equals("sitePrismTime")?"active":""%>">시간 리포트</a>
                            </li>
                            <li><a href="#none" a="sitePrismCampaign" class="menuLink <%=a.equals("sitePrismCampaign")?"active":""%>">캠페인 리포트</a>
                            </li>
                        </ul>
                    </nav>
                    <!-- ads list Start -->
                    <div class="saveBtn5">
                        <!-- saveBtn Start -->
           	<form id="frmRpt" action="rptmgr.do" method="get">
                <input type="hidden" name="a" value="<%=a %>">
                <input type="hidden" id="siteid" name="siteid" value="">
                     <div class="form-inline">
                    	<div class="form-group">
                        <div class="form-group formGroupPadd">
                            <label>기간</label>
                            <input type="text" class="form-control input-sm" name="sday" id="sday" value="" style="width:90px">
                            <a class="btn btn-success btn-sm" href="#none" role="button" id="btnSday"><span class="glyphicon glyphicon-calendar"></span></a>
                        </div>
                        <div class="form-group formGroupPadd">
                            <input type="text" class="form-control input-sm"  name="eday" id="eday" value="" style="width:90px">
                            <a class="btn btn-success btn-sm" href="#none" role="button" id="btnEday"><span class="glyphicon glyphicon-calendar"></span></a>
                        </div>                                 <a class="btn btn-warning" href="javascript:$('#frmRpt').submit()" role="button">조회</a>
                                <a class="btn btn-default" href=""><img src="<%=web %>/img/page_excel.png" alt="excel Icon"></a>
                            		                                                      	                            
                          </div>
                        
                    </div>
                </form>
                        <!-- saveBtn End -->
                    </div>
                </div>
 <script type="text/javascript">
$(function(){
	var weekday =  <%=weekday_data%>;
	
	
	var ads_code = "<%--code_data--%>";
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
	/*********************** 파라미터 선택옵션 *****************************/
	var obj = <%=param_data%>;
	
	jQuery.each(obj, function(i, val) {
		  //$("#" + i).append(document.createTextNode(" - " + val));
		  if(i=="sday" || i=="eday") {
			  $("#"+i).val(getYMD(val,"-"));
		  } else {
			  $("#"+i).val(val);
		  }
	});
	
	$(document).on("click", ".menuLink", function(e){
	  
	  	$("#frmRpt input[name=a]").val($(this).attr("a"));
	  	$("#frmRpt").submit();
	});
});
</script>               