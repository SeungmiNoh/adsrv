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

/*
jQuery(function($) {
	 $.datepicker.regional['ko']= {
	     closeText:'닫기',
	     prevText:'이전달',	
	     nextText:'다음달',
	     currentText:'오늘',
	     monthNames:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	     monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	     dayNames:['일','월','화','수','목','금','토'],
	     dayNamesShort:['일','월','화','수','목','금','토'],
	     dayNamesMin:['일','월','화','수','목','금','토'],
	     weekHeader:'Wk',
	     dateFormat:'yy-mm-dd',
	     firstDay:0,
	     isRTL:false,
	     showMonthAfterYear:true,
	     yearSuffix:''
	 };
	 
	 $.datepicker.setDefaults($.datepicker.regional['ko']);
	 
	 $(".s_date").datepicker({
	     buttonText:"달력",
	     //showOn: "button",
	    // buttonImage: "images/calendar.gif", //버튼이미지에 사용할 이미지 경로
	     buttonImageOnly: false, //버튼이미지를 나오게 한다.
	     dateFormat: 'yy-mm-dd', //데이터 포멧형식
	     minDate: '-3M',   //오늘 부터 3달전까지만 선택 할 수 있다.
	     maxDate: '+36M',   //오늘 부터 36개월후까지만 선택 할 수 있다.
	     yearRange: '2009:2040', // 년도 제한하기
	     //changeMonth: true, //달별로 선택 할 수 있다.
	     //changeYear: true,   //년별로 선택 할 수 있다.
	     showOtherMonths: true, //이번달 달력안에 상/하 빈칸이 있을경우 전달/다음달 일로 채워준다.
	     selectOtherMonths: false, 
	     numberOfMonths: 1, //오늘부터 3달치의 달력을 보여준다.
	     showButtonPanel: false, //오늘 날짜로 돌아가는 버튼 및 닫기 버튼을 생성한다.
	  	 beforeShow: customRange //함수호출
	 });
	 $(".e_date").datepicker({
	     buttonText:"달력",
	    // showOn: "button",
	     //buttonImage: "images/calendar.gif", //버튼이미지에 사용할 이미지 경로
	     buttonImageOnly: false, //버튼이미지를 나오게 한다.
	     dateFormat: 'yy-mm-dd', //데이터 포멧형식
	     minDate: '-3M',   //오늘 부터 3달전까지만 선택 할 수 있다.
	     maxDate: '+36M',   //오늘 부터 36개월후까지만 선택 할 수 있다.
	     yearRange: '2009:2040', // 년도 제한하기
	     changeMonth: false, //달별로 선택 할 수 있다.
	     changeYear: false,   //년별로 선택 할 수 있다.
	     showOtherMonths: true, //이번달 달력안에 상/하 빈칸이 있을경우 전달/다음달 일로 채워준다.
	     selectOtherMonths: true, 
	     numberOfMonths: 1, //오늘부터 3달치의 달력을 보여준다.
	     showButtonPanel: false, //오늘 날짜로 돌아가는 버튼 및 닫기 버튼을 생성한다.
	  beforeShow: customRange //함수호출
	 });
	});
	 
	function customRange(input) {
	    return {
	        minDate: (input.id == 'e_date' ? $('.s_date').datepicker('getDate') : null),
	        maxDate: (input.id == 's_date' ? $('.e_date').datepicker('getDate') : null)
	    };
	}

	$(function() {	
		
		//날짜
		$('.cal').datepicker({
			dateFormat: 'yy-mm-dd'
		});
		
	}); */