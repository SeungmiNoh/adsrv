/* ----------------------------------------------------------------------------
 * 특정 날짜에 대해 지정한 값만큼 가감(+-)한 날짜를 반환

 * 

 * 입력 파라미터 -----
 * pInterval : "yyyy" 는 연도 가감, "m" 은 월 가감, "d" 는 일 가감
 * pAddVal  : 가감 하고자 하는 값 (정수형)
 * pYyyymmdd : 가감의 기준이 되는 날짜
 * pDelimiter : pYyyymmdd 값에 사용된 구분자를 설정 (없으면 "" 입력)

 * 

 * 반환값 ----

 * yyyymmdd 또는 함수 입력시 지정된 구분자를 가지는 yyyy?mm?dd 값
 *

 * 사용예 ---

 * 2008-01-01 에 3 일 더하기 ==> addDate("d", 3, "2008-08-01", "-");

 * 20080301 에 8 개월 더하기 ==> addDate("m", 8, "20080301", "");
 --------------------------------------------------------------------------- */
function newTab(link){
	if(link.length>0) {
		var tab=window.open(link,'_blank'); 
		   //tab.focus(); 
	}
}



function addDate(pInterval, pAddVal, pYyyymmdd, pDelimiter)
{
	var yyyy;
	var mm;
	var dd;
	var cDate;
	var oDate;
	var cYear, cMonth, cDay;
	var result = '';

	if (pDelimiter != "") {
		pYyyymmdd = pYyyymmdd.replace(eval("/\\" + pDelimiter + "/g"), "");
	}

 	 yyyy = pYyyymmdd.substring(0, 4);
	 mm  = pYyyymmdd.substring(4, 6);
	 dd  = pYyyymmdd.substring(6, 8);

 	if (pInterval == "yyyy") {
  		yyyy = (yyyy * 1) + (pAddVal * 1); 
 	} else if (pInterval == "m") {
  		mm  = (mm * 1) + (pAddVal * 1);
 	} else if (pInterval == "d") {
  		dd  = (dd * 1) + (pAddVal * 1);
 	}
	cDate = new Date(yyyy, mm - 1, dd) // 12월, 31일을 초과하는 입력값에 대해 자동으로 계산된 날짜가 만들어짐.
	cYear = cDate.getFullYear();	
	cMonth = cDate.getMonth() + 1;	
	cDay = cDate.getDate();

 	cMonth = cMonth < 10 ? "0" + cMonth : cMonth;
 	cDay = cDay < 10 ? "0" + cDay : cDay;

 	result = cYear + pDelimiter + cMonth + pDelimiter + cDay;
  
 	return result;
} 
   

function betweenDays(sdateString, edateString)
{
//var today = new Date();  
//var edateString = "2012-04-25";  
  
var sdateArray = sdateString.split("-");  
var edateArray = edateString.split("-");  
  
var sdateObj = new Date(sdateArray[0], Number(sdateArray[1])-1, sdateArray[2]);  
var edateObj = new Date(edateArray[0], Number(edateArray[1])-1, edateArray[2]);  
  
return betweenDay = (edateObj.getTime() - sdateObj.getTime())/1000/60/60/24;  


}


function iconsh(obj){
	var lefts = document.getElementById('n_nav');
	if(lefts.style.display == ''){
		lefts.style.display = 'none';
		obj.src = "/img/btn_menu_open.gif";
		obj.alt = '메뉴열기'
	}else{
		lefts.style.display = '';
		obj.src = "/img/btn_menu_close.gif";
		obj.alt = '메뉴닫기'
	}
}

// IP 유효성 체크
function checkIp(ip_addr)
{
	console.log("ip_addr=="+ip_addr);
	var filter = /^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$/;	
	console.log("filter.test(ip_addr)="+filter.test(ip_addr));
	return filter.test(ip_addr);

}

// 암호 체크
function checkPwd(str)
{
	/* 조건1. 6~20 영문 대소문자
	 * 조건2. 최소 1개의 숫자 혹은 특수 문자를 포함해야 함	
	 */
	var filter = /^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{6,20}$/;	
	console.log("filter.test("+str+")="+filter.test(str));
	return filter.test(str);
}
//URL 체크
function checkURL(str)
{
	var filter = /^(file|gopher|news|nntp|telnet|https?|ftps?|sftp):\/\/([a-z0-9-]+\.)+[a-z0-9]{2,4}.*$/;	
	console.log("checkURL filter.test("+str+")="+filter.test(str));
	return filter.test(str);
}

//


function rcomma(obj) {
	
	obj.value = delComma(obj);
	obj.select();
}
//comma를 제거한 값만 submit되도록 하는 함수.
function delComma(num)
{
	var s = num.value;
	var len = s.length;
	var x="";

	for (var i=0; i<len; i++) {
			if (s.charAt(i) != ',') {
					x = x + s.charAt(i);
			}
	}
	return x;
}
function delDash(str)
{
	return str.replace(/-/gi, '');
}


function comma( form ) {
	
    var mod;
    var number = '' + form.value;
    var minus = "";
    
    if(number.charAt(0)=="-") {
    	number = number.replace("-","");
    	minus = "-";
    }
   
    var tmp = number.split(',');
    var leng = tmp.length;
    var conc = '';
	
    if ( leng > 1 ) {
            for ( var j=0 ; j < leng ; j++ ) {
                    conc = conc + '' + tmp[j];
            }
    } else {
            conc = number;
    }
    mod = conc.length % 3;
    var output =  mod > 0 ? (conc.substring(0,mod)) : '';
    for ( i=0 ; i < Math.floor(conc.length / 3) ; i++ ) {
            if ((mod == 0) && (i == 0)) {
                    output += conc.substring(mod+3*i, mod+3*i+3);
            } else {
                    output += ',' + conc.substring(mod+3*i, mod+3*i+3);
            }
    }
    form.value =  minus+output;
}
function addComma( number ) {
	
    //var mod;
    //var number = '' + form.value;
    var tmp = number.split(',');
    var leng = tmp.length;
    var conc = '';
	
    if ( leng > 1 ) {
            for ( var j=0 ; j < leng ; j++ ) {
                    conc = conc + '' + tmp[j];
            }
    } else {
            conc = number;
    }
    mod = conc.length % 3;
    var output =  mod > 0 ? (conc.substring(0,mod)) : '';
    for ( i=0 ; i < Math.floor(conc.length / 3) ; i++ ) {
            if ((mod == 0) && (i == 0)) {
                    output += conc.substring(mod+3*i, mod+3*i+3);
            } else {
                    output += ',' + conc.substring(mod+3*i, mod+3*i+3);
            }
    }
    return output;
}

function r_delcomma(num)
{
	var s = num;
	var len = num.length;
	var x="";

	for (var i=0; i<len; i++) {
			if (s.charAt(i) != ',') {
					x = x + s.charAt(i);
			}
	}
	return x;
}
function is_numeric(str) {
	if(str != null)
	{
		var strb = str.toString();
   		var minus = "";
   		if(strb.charAt(0)=='-') {
			minus=strb.charAt(0);
		    strb = strb.replace(/[^0-9]/g,'').substring(0,10);  
		} else {
			strb = strb.replace(/[^0-9]/g,'').substring(0,11);  
		}
    	return minus+strb;
	
	} else {
		return '';
	}
	
	/*
	if(str != null)
	{
		return str.replace(/[^0-9]/g,'');
	} else {
		return '';
	}*/
}

function delComma( number ) {
	
    //var mod;
    //var number = '' + form.value;
    var tmp = number.split(',');
    var leng = tmp.length;
    var conc = '';
	
    if ( leng > 1 ) {
            for ( var j=0 ; j < leng ; j++ ) {
                    conc = conc + '' + tmp[j];
            }
    } else {
            conc = number;
    }
    mod = conc.length % 3;
    var output =  mod > 0 ? (conc.substring(0,mod)) : '';
    for ( i=0 ; i < Math.floor(conc.length / 3) ; i++ ) {
            if ((mod == 0) && (i == 0)) {
                    output += conc.substring(mod+3*i, mod+3*i+3);
            } else {
                    output += ',' + conc.substring(mod+3*i, mod+3*i+3);
            }
    }
    return output;
}

function set_comma(n) {
    var reg = /(^[+-]?\d+)(\d{3})/;
    n += '';
    while (reg.test(n))
     n = n.replace(reg, '$1' + ',' + '$2');

    return n;
}


function setcomma( str ) {
	
    var number = ''+str;
	var temp   = number.split("-");
	if(temp.length>1){
		number = temp[1];
	}
    var tmp    = number.split(',');
    var leng   = tmp.length;
    var mod;
    var output;
    var conc = '';

    if ( leng > 1 ) {
            for ( var j=0 ; j < leng ; j++ ) {
                    conc = conc + '' + tmp[j];
            }
    } else {
            conc = number;
    }
    mod = conc.length % 3;

    output =  mod > 0 ? (conc.substring(0,mod)) : '';
    
    for (var i=0 ; i < Math.floor(conc.length / 3); i++ ) 
    {
        if ((mod == 0) && (i == 0)){ 
             output += conc.substring(mod+3*i, mod+3*i+3);
		}
        else {
            output += ',' + conc.substring(mod+3*i, mod+3*i+3);
		}
    }
	if(temp.length>1){
			output = "-"+output;
	}
    return output;
}
function getYMDStr(str) {
	
	var newdate = str.substring(0, 4) + str.substring(5, 7) + str.substring(8, 10);
	
	
	return newdate;
}
function getYMD(str, delimeter) {
	
	var newdate = str.substring(0, 4) + delimeter + str.substring(4, 6) + delimeter + str.substring(6, 8);
	
	
	return newdate;
}
function getMD(str, delimeter) {
	
	var newdate = str.substring(4, 6) + delimeter + str.substring(6, 8);
	
	
	return newdate;
}
function getYMDHM(str, delimeter) {
	
	var newdate = str.substring(0, 4) + delimeter + str.substring(4, 6) + delimeter + str.substring(6, 8)+ "&nbsp;" + str.substring(8, 10) + ":" + str.substring(10, 12);
	
	
	return newdate;
}

/// str = 변경할 문자가 있는 문자열, before = 변경대상 char,  after = 변경할 char 
function alterString(str,before,after)   
{
    var returnStr = "";
	var idx = str.search(before);
	var idx2 = idx+before.length;
			
	if(idx>0)
	{
		returnStr = str.substring(0, idx)+after+str.substring(idx2);
	} else {
		returnStr = str;
	}	    
	return returnStr;
}
function isNullZero(str)   
{
			
	if(str==null || str == "null" || str=="")
	{
		returnStr = "0";
	} else {
		returnStr = str;
	}	    
	return returnStr;
}
function isNull(str)   
{
			
	if(str==null || str == "null")
	{
		returnStr = "";
	} else {
		returnStr = str;
	}	    
	return returnStr;
}
function roundXL(n, digits) {	
	  if (digits >= 0) return parseFloat(n.toFixed(digits)); // 소수부 반올림

	  digits = Math.pow(10, digits); // 정수부 반올림
	  var t = Math.round(n * digits) / digits;

	  return parseFloat(t.toFixed(0));
	}
/********************************************************
 * 숫자만 입력
 * ******************************************************/
(function ($) {
    // 숫자 제외하고 모든 문자 삭제.
    $.fn.removeText = function(_v){
       //console.log("removeText: 숫자 제거 합니다.");
        if (typeof(_v)==="undefined")
        {
            $(this).each(function(){            	
               this.value = this.value.replace(/[^0-9]/g,'');
            });
        }
        else
        {
       		var strb = _v.toString();
       		var minus = "";
       		if(strb.charAt(0)=='-') {
    			minus=strb.charAt(0);
    		    strb = strb.replace(/[^0-9]/g,'').substring(0,10);  
    		} else {
    			strb = strb.replace(/[^0-9]/g,'').substring(0,11);  
    		}
        	return minus+strb;
         }
    };
     
     
    // 위 두개의 합성.
    // 콤마 불필요시 numberFormat 부분을 주석처리.
    $.fn.onlyNumber = function (p) {
        $(this).each(function(i) {
            //$(this).attr({'style':'text-align:right'});
             
            this.value = $(this).removeText(this.value);
            comma(this);
          //  this.value = $(this).numberFormat(this.value);
             
            $(this).bind('keypress keyup',function(e){
                this.value = $(this).removeText(this.value);
                comma(this);
            //   this.value = $(this).numberFormat(this.value);
            });
        });
    };
    
    //폼리셋
	formReset = function(){
		$("form").each(function() {  
            if(this.id == "frmRegist") this.reset();  
         }); 
	}

     
})(jQuery);

/********************************************************
 * 숫자만 입력 + 마이너스
 * ******************************************************/
(function($) {
	$.fn.toPrice = function(cipher) {
		var strb, len, revslice,minus;
		minus='';
		strb = $(this).val().toString();
		if(strb.charAt(0)=='-') {
			minus=strb.charAt(0);
		}
		strb = strb.replace(/-,/g, '');
		strb = $(this).getOnlyNumeric();
		strb = parseInt(strb, 10);
		if(isNaN(strb)){
			return $(this).val(minus+'');
		}
		strb = strb.toString();
		len = strb.length;

		if(len < 4){
			return $(this).val(minus+strb);
		}
		if(cipher == undefined || !isNumeric(cipher)) {
			cipher = 3;
		}

		count = len/cipher;
		slice = new Array();

		for(var i=0; i<count; ++i) {
			if(i*cipher >= len)
				break;
			slice[i] = strb.slice((i+1) * -cipher, len - (i*cipher));
		}

		revslice = slice.reverse();
		return $(this).val(minus+revslice.join(','));
	}

	$.fn.getOnlyNumeric = function(data) {
		var chrTmp, strTmp;
		var len, str;

		if(data == undefined) {
			str = $(this).val();
		}
		else {
			str = data;
		}

		len = str.length;
		strTmp = '';

		for(var i=0; i<len; ++i) {
			chrTmp = str.charCodeAt(i);
			if((chrTmp > 47 || chrTmp <= 31) && chrTmp < 58) {
				strTmp = strTmp + String.fromCharCode(chrTmp);
			}
		}

		if(data == undefined)
			return strTmp;
		else
			return $(this).val(strTmp);
	}

	var isNumeric = function(data) {

		var len, chrTmp;
		len = data.length;

		for(var i=0; i<len; ++i) {
			chrTmp = str.charCodeAt(i);
			if((chrTmp <= 47 && chrTmp > 31) || chrTmp >= 58) {
				return false;
			}
		}
		return true;
	}
})(jQuery);





jQuery.fn.extend({
	/**
	 * 숫자만 입력 가능하도록 처리
	 */
	numberOnly : function() {
		return this.each(function() {
			try {
				var $this = $(this);

				// FF patch : 한글입력 상태에서 keydown 입력 제한이 안걸리는 문제가 있어 한글 입력 불가능하도록 설정
				$this.css('ime-mode', 'disabled');

				// 숫자,콤마,backspace,enter key만 입력 가능하도록 제한
				$this.keydown(function(p_event) {
					var l_before_length = $this.val().length;
					var l_keycode = p_event.keyCode;
					var l_str = l_keycode > 57 ? String.fromCharCode(l_keycode-48) : String.fromCharCode(l_keycode);
					var l_pattern = /^[0-9]+$/;
					// back-space, tab-key enter-key, delete-key, ←, ↑, →, ↓는 입력 가능하도록 함
					if(l_keycode == 8 || l_keycode == 9 || l_keycode == 13 || l_keycode == 46 || l_keycode == 37 || l_keycode == 38 || l_keycode == 39 || l_keycode == 40) {
						return true;
					}

					// 숫자만 입력 가능하도록 함
					var l_after_length = $this.val().length;
					if(!l_pattern.test(l_str)) {
						if(l_before_length != l_after_length) {
							$this.val($this.val().substring(0, l_after_length - 1));
						}
						return false;
					} else {
						return true;
					}
				});

				// 포커스를 얻어을 때 처리 - number format을 위한 콤마를 모두 제거한다.
				$this.focus(function() {
					$this.val($this.val().replace(/,/g, ''));
					// 포커스일때 값이 0이면 삭제
					if($.trim($this.val()).length==1){
						if($this.val()=="0")
							$this.val("");
					}
				});
				$this.focusout(function(){
					// 포커스 아웃 시 빈칸이면 0을 넣어줌
					var len = $.trim($this.val()).length;
					if(Number($this.val())>100000000){
						;
					}
					if(len==0){
						$this.val("0");
					} else{
					// 3자리 콤마
						var cut = len%3;
						var str = $this.val().substring(0,cut);
						while(cut < len) {
							if(str != "") str +=",";
							str += $this.val().substring(cut, cut+3);
							cut += 3;
						}
					
						$this.val(str);
					}
				});
			} catch(e) {
				alert("[jsutil.js's numberFormat] " + e.description);
			}
		});
	},

	onlyNumberDelComma : function() {
	return this.each(function() {
		try {
			var $this = $(this);
			console.log("val="+$this.val());
			str = String($this.val()).replace(/[^\d]+/g, '');
			if(str=='') str = 0;
			
			console.log("str="+str);
			$this.val(str);
		    //return str;
			
		} catch(e) {
			alert("[jsutil.js's numberFormat] " + e.description);
		}
	});
}

});










jQuery(function($) {
	
/*
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
		}
});
$("#end").datepicker({
		dateFormat: 'yy-mm-dd',
		changeMonth:true,
		changeYear:true,
		onClose: function(selectDate){
				$("#start").datepicker("option","maxDate",selectDate);
		}
});*/
$('#btnSday').click(function(){
    $(document).ready(function(){
        $("#start").datepicker().focus();
    });
});
$('#btnEday').click(function(){
    $(document).ready(function(){
        $("#end").datepicker().focus();
    });
});


});
$(document).on("click", "a[name=rptMenu]", function(e){
	var alink = $(this).attr("alink");

	$("#frmRpt input[name=a]").val(alink);
	$("#frmRpt").submit();
		
});

$(document).ready( function(){
	$('input').focus(function(e) {
	var readonly = $(this).attr("readonly");
	if (readonly) {
	$(this).next('input:not([readonly])').focus();
	e.preventDefault();
	}
	});
	});