
package tv.pandora.adsrv.common.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

/**
 * kr.mapps.common.util.DateUtil.java - Creation date: 2010. 3. 16. <br>
 *
 * @author MezzoMedia Solution Dev kim jae-hwan 
 * @version 1.0
 */
public class DateUtil {

	public static String simpleDate() {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmm");
		return formatter.format(new Date());
	}
	public static String simpleDate2() {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
		return formatter.format(new Date());
	}
	public static String simpleDate(Date date) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmm");
		return formatter.format(date);
	}
	
	public static String simpleDateYMD() {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		return formatter.format(new Date());
	}
	
	public static String simpleDateMD() {
		SimpleDateFormat formatter = new SimpleDateFormat("MMdd");
		return formatter.format(new Date());
	}
	public static String getYMD(String str) {
		if((str == null) || str.equals("")) {
    		return "";
    	} else {
			String newdate = "";
			
			if(str.length()<8){
				newdate = str;
			} else {
				try{
					newdate = str.substring(0, 4) + "-"+ str.substring(4, 6) + "-" + str.substring(6, 8);
				
				}catch(Exception e){
					 e.printStackTrace();
				}
			}
			return newdate;
    	}
	}
	public static String getYMD(String str, String delimeter) {
		if((str == null) || str.equals("")) {
    		return "";
    	} else {
			String newdate = "";
			
			if(str.length()<8){
				newdate = str;
			} else {
				try{
					newdate = str.substring(0, 4) + delimeter+ str.substring(4, 6) + delimeter + str.substring(6, 8);
				
				}catch(Exception e){
					 e.printStackTrace();
				}
			}
			return newdate;
    	}
	}
	public static String getMD(String str, String delimeter) {
		if(str.equals("")) return "";
		String newdate = "";
		try{
			newdate = str.substring(4, 6) + delimeter + str.substring(6, 8);
		
		}catch(Exception e){
			 e.printStackTrace();
		}
		return newdate;
	}
	public static String getAcYear(Integer year, Integer month, Integer acmonth) {
		
		Integer pre_year = 0;
		
		   if(month+acmonth>12){
			   pre_year = year+1; 
		   } else {
			   pre_year = year;
		   }
		   
		   return pre_year+"";

	}
	public static String getAcMonth(Integer year, Integer month, Integer acmonth) {
		
		   Integer pre_month = 0;				   
		   if(month+acmonth>12){
			   pre_month = month+acmonth-12; 
		   } else {
			   pre_month = month+acmonth;
		   }
		   return pre_month+"";

	}
	   
	public static String getMMStr(String month) {
		
		   String str = "";				   
		   if(Integer.parseInt(month)<10){
			   str = "0"+month; 
		   } else {
			   str = month; 
		   }
		   return str;
	}
	   
	public static String getCutYMD(String str) {
		String newdate = "";
		if(str.length()<8){
			newdate = str;
		} else {
			try{
				newdate = str.substring(0, 8);
			}catch(Exception e){
				 e.printStackTrace();
			}	
		}
		return newdate;
	}
	public static String getCutHH(String str) {
		String newdate = "";
		if(str.length()<8){
			newdate = str;
		} else {
			try{
				newdate = str.substring(8, 10);
			}catch(Exception e){
				 e.printStackTrace();
			}	
		}
		return newdate;
	}	
	public static String getCutMM(String str) {
		String newdate = "";
		if(str.length()<10){
			newdate = str;
		} else {
			try{
				newdate =  str.substring(10, 12);
			}catch(Exception e){
				 e.printStackTrace();
			}	
		}
		return newdate;
	}	  
	
	public static String getYMDHM(String str, String delimeter) {
		String newdate = "";
		if(str.length()<12){
			newdate = str;
		} else {
			try{
				newdate = str.substring(0, 4) + delimeter+ str.substring(4, 6) + delimeter + str.substring(6, 8)+ "&nbsp;" + str.substring(8, 10) + ":" + str.substring(10, 12);
			}catch(Exception e){
				 e.printStackTrace();
			}	
		}
		return newdate;
	}
	public static String getTimeStr(String str) {
		String newdate = "";
		if(str.length()<21){
			newdate = str;
		} else {
			try{
				newdate = str.substring(0, 16);
			}catch(Exception e){
				 e.printStackTrace();
			}	
		}
		return newdate;
	}
	//입력 날짜의 요일
		public static Integer getWeekday(String Sday){
			
			int y,m,d = 0;
			
			Calendar c = Calendar.getInstance();
			if(null!=Sday ){
				if(Sday.indexOf("-")>0)
				{
					String date[] = Sday.split("-");
					y = Integer.parseInt(date[0]);
					m = Integer.parseInt(date[1])-1;
					d = Integer.parseInt(date[2]);
				} else {
					y = Integer.parseInt(Sday.substring(0, 4));
					m = Integer.parseInt(Sday.substring(4, 6))-1;
					d = Integer.parseInt(Sday.substring(6, 8));				
				}
				c.set(y, m, d);
			} 
			
			//일요일~토욜일 => 1~7
			int weekDay = c.get(Calendar.DAY_OF_WEEK); 
			
			//Calendar cal = new GregorianCalendar(y,)
			System.out.println("weekDay"+weekDay);
			
			return weekDay;
		}
		public static Map<String,String> getCalendarDay(String Sday){		
			
			//일요일~토욜일 => 1~7
			int predays = 0;
			int nxtdays = 0;		
			
			String lastday = getEnddayOfMonth(Sday);
			
			int s_wk = getWeekday(Sday); 
			int e_wk = getWeekday(lastday); 						
			if(s_wk==1) {
				predays = 6;
			} else {
				predays = s_wk - 2;
			}
			nxtdays = (8 - e_wk)%7;

	

			String startday = nextDayOfDate(Sday,-1*predays);		
			String endday = nextDayOfDate(lastday,nxtdays);
			
			Map<String,String> map = new HashMap<String, String>();
			map.put("startday", startday);
			map.put("endday", endday);
			return map;		
			
		}	
	//입력 날짜의 일주일후
	public static Map getNextWeek(String Sday){
		Calendar c = Calendar.getInstance();
		if(null!=Sday){
			String date[] = Sday.split("-");
			int y = Integer.parseInt(date[0]);
			int m = Integer.parseInt(date[1])-1;
			int d = Integer.parseInt(date[2]);
			c.set(y, m, d);
		}
		//일요일~토욜일 => 1~7
		int weekDay = c.get(c.DAY_OF_WEEK); 
		
		int startWeek = 8-weekDay;    
		c.add(c.DATE, startWeek);
		String startday = getYMD(toDateString(c),".");
		
		c.add(c.DATE, +6);
		String endday = getYMD(toDateString(c),".");	
		
		Map map = new HashMap();
		map.put("startday", startday);
		map.put("endday", endday);
		
		return map;
	}
	
	//입력 날짜의 일주일전
	public static Map getPreWeek(String Sday){
		Map map = new HashMap();
		Calendar c = Calendar.getInstance();
		if(null!=Sday){
			String date[] = Sday.split("-");
			int y = Integer.parseInt(date[0]);
			int m = Integer.parseInt(date[1])-1;
			int d = Integer.parseInt(date[2]);
			c.set(y, m, d);
		}
		
		//일요일~토욜일 => 1~7
		int weekDay = c.get(c.DAY_OF_WEEK); 
		
		int startWeek = (-weekDay)-6;   
		c.add(c.DATE, startWeek);
		String startday = getYMD(toDateString(c),".");
		
		c.add(c.DATE, +6);
		String endday = getYMD(toDateString(c),".");	
		
		
		map.put("startday", startday);
		map.put("endday", endday);
		
		return map;
	}
	
	
	public static String toDateString(Calendar date)
	{
        int y = date.get(Calendar .YEAR);
        int m = date.get(Calendar .MONTH)+1;
        int d = date.get(Calendar .DATE);
        
		String month = String.valueOf(m);
		String day = String.valueOf(d);
	
		if( m < 10 ) month = "0" + month;
		if( d < 10 ) day = "0" + day;
		
		return y+ "" + month + "" + day;

	}
	
	public static String newDateimg(String created){
		Date startDay = new Date(System.currentTimeMillis() - 1000*60*60*24);
		Long newday = Long.parseLong(DateUtil.simpleDate(startDay));
		String newimg = "";
		if(created.length()==8) created = created+"0000";
 		Long newcreated = Long.parseLong(created); 
		if(newcreated > newday) newimg="<img src=\"/images/common/ico/ico_n.gif\" title=\"new\" />";
		
		return newimg;
	}
	
	public static String newDateimg1(String created){
		Date startDay = new Date(System.currentTimeMillis() - 1000*60*60*24);
		Long newday = Long.parseLong(DateUtil.simpleDate(startDay));
		String newimg = "";
		if(created.length()==8) created = created+"0000";
 		Long newcreated = Long.parseLong(created); 
		if(newcreated > newday){
			newimg="&nbsp;<img src=\"/images/common/ico/ico_n.gif\" title=\"new\" widht=\"13px\" height=\"13px\" style=\"vertical-align:middle;margin-top:-1px;\"/>";
		}
		return newimg;
	}
	
	//String -> date 형변환
	public static Date dateParse(String strDate, String fmt) {
		SimpleDateFormat sdfmt = new SimpleDateFormat( fmt );
		Date date = null;
		try{
			date = sdfmt.parse( strDate );
		}catch(Exception e){
			e.printStackTrace();
		}
		return date;	
	}
	
	public static int getDayDiff(String fromDate, String toDate) { 
	       
		//  fromDate = Formatter.removeDot(fromDate);
		//  toDate   = Formatter.removeDot(toDate);
		        
		        if(fromDate.length() < 8) return -1;
		        if(toDate.length() < 8) return -1;
		        
		        int year1  = Integer.parseInt(fromDate.substring(0,4));
		        int month1 = Integer.parseInt(fromDate.substring(4,6)) - 1;
		        int day1   = Integer.parseInt(fromDate.substring(6,8));
		        
		        int year2  = Integer.parseInt(toDate.substring(0,4));
		        int month2 = Integer.parseInt(toDate.substring(4,6)) - 1;
		        int day2   = Integer.parseInt(toDate.substring(6,8));
		        
		        Calendar c1 = Calendar.getInstance(); 
		        Calendar c2 = Calendar.getInstance(); 

		        c1.set(year1, month1, day1); 
		        c2.set(year2, month2, day2); 
		        
		        long d1 = c1.getTime().getTime();
		        long d2 = c2.getTime().getTime();
		        int days =(int)((d2-d1)/(1000*60*60*24)); 
		        
		        return days; 
		  }



	
	//두 날짜사이의 일수구하기
	public static Integer getTimeDiffer(String date1, String date2, String delimeter){
		if(date1.length()>8){
			date1 = date1.substring(0,8);
		}
		if(date2.length()>8){
			date2 = date2.substring(0,8);
		}
		Date parseDate1 = dateParse(date1, delimeter);
		Date parseDate2 = dateParse(date2, delimeter);
		Calendar date1Cal = Calendar.getInstance();
		date1Cal.setTime(parseDate1);
		Calendar date2Cal = Calendar.getInstance();
		date2Cal.setTime(parseDate2);
		long num = (date1Cal.getTimeInMillis() - date2Cal.getTimeInMillis());
		long diff = (((num/1000)/60)/60)/24;
		
		
		return Integer.parseInt(String.valueOf(diff));
	} 
	
	//전달 구하기
	public static String getMonthAgoDate(int when){
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.MONTH, when);//한달전 날짜 가져오기:-1, 한달후 날짜가져오기:+1
		Date monthago = cal.getTime();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM", Locale.getDefault());
		return formatter.format(monthago);
	}
	
	//전달 구하기
	public static String getMonthAgoDate(int when, String date){
		Calendar cal = Calendar.getInstance();
		
		if(null!=date){
			String str_date[] = date.split("-");
			int y = Integer.parseInt(str_date[0]);
			int m = Integer.parseInt(str_date[1])-1;
			int d = Integer.parseInt(str_date[2]);
			cal.set(y, m, d);
		}
		
		cal.add(cal.MONTH, when);//한달전 날짜 가져오기:-1, 한달후 날짜가져오기:+1
		Date monthago = cal.getTime();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-DD", Locale.getDefault());
		return formatter.format(monthago);
	}
	
	public static String curDate(){
		Calendar cal = Calendar.getInstance( );//TimeZone.getTimeZone("JST") );
		int y = cal.get(Calendar.YEAR) ;
		int m = cal.get(Calendar.MONTH) +1;
		int d = cal.get(Calendar.DAY_OF_MONTH);
	
		String month = String.valueOf(m);
		String day = String.valueOf(d);
	
		if( m < 10 ) month = "0" + month;
		if( d < 10 ) day = "0" + day;
	
		return y + month + day;
	}

	/**
	 * 월의 마지막일을 가져온다.
	 *	@param	String		년도
	 *	@return	int 			
	 */

	public static String getEnddayOfMonth(String str) {
		int year = Integer.parseInt(str.substring(0,4));
		int month = Integer.parseInt(str.substring(4,6));
		int day = Integer.parseInt(str.substring(6));
		Calendar cal = Calendar.getInstance();
		cal.set(year, month - 1, day);
		return str.substring(0,6)+ cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	}
	/**
	* 입력받은 날의 다음날을 읽어온다. 
	* @param String	년도
	* @return String
	*/
	public static String nextDay(String date){
		return getDateString(getTime(date) + 60*60*24);
	}
	public static String nextMon(String date){
		return getDateString(getTime(date) + 30*60*60*24);
	}
	public static String nextMon(String date, int months){
		return getDateString(getTime(date) + months*30*60*60*24);
	}
	public static String nextWeek(String date, int weeks){
		return getDateString(getTime(date) + weeks*7*60*60*24);
	}
	public static String nextDayOfDate(String date, int days){
		return getDateString(getTime(date) + days*60*60*24);
	}


	/**
	* 입력받은 날의 다음날을 읽어온다. 
	* @param String	년도
	* @return String
	*/
	public static String getPreDay(String date){
		return getDateString(getTime(date) - 60*60*24);
	}
	public static String getPreMon(String date){
		return getDateString(getTime(date) - 30*60*60*24);
	}
	public static String getPreMon(String date, int months){
		return getDateString(getTime(date) - months*30*60*60*24);
	}
	public static String nextHour(String date, int hh){
		return getDateHM(getTime(date) + 60*60*hh);
	}
	public static String nextMin(String date, int mm){
		return getDateHMS(getTime(date) + 60*mm);
	}
	/**
	* 1970/01/01 GMT 이후의 총 second를 'yyyymmdd'형식으로 리턴
	* @param time long
	* @return String
	*/
	public static String getDateString( long time){
		Calendar cal = Calendar.getInstance( );//TimeZone.getTimeZone("JST") );
		cal.setTime( new Date( time * 1000 ) );

		int y = cal.get(Calendar.YEAR) ;
		int m = cal.get(Calendar.MONTH) +1;
		int d = cal.get(Calendar.DAY_OF_MONTH);
	
		String month = String.valueOf(m);
		String day = String.valueOf(d);
	
		if( m < 10 ) month = "0" + month;
		if( d < 10 ) day = "0" + day;

		return y+ "" + month + "" + day;
	}
	
	public static String getDateHM( long time){
		Calendar cal = Calendar.getInstance( );//TimeZone.getTimeZone("JST") );
		cal.setTime( new Date( time * 1000 ) );

		int y = cal.get(Calendar.YEAR) ;
		int m = cal.get(Calendar.MONTH) +1;
		int d = cal.get(Calendar.DAY_OF_MONTH);
		int hh = cal.get(Calendar.HOUR_OF_DAY);
		int mm = cal.get(Calendar.MINUTE);
		
		String month = String.valueOf(m);
		String day = String.valueOf(d);
		String hour = String.valueOf(hh);
		String min = String.valueOf(mm);
	
		if( m < 10 ) month = "0" + month;
		if( d < 10 ) day = "0" + day;
		if( hh < 10 ) hour = "0" + hour;
		if( mm < 10 ) min = "0" + min;

		return y+ "" + month + "" + day + "" + hour + "" + min;
	}
	public static String getDateHMS( long time){
		Calendar cal = Calendar.getInstance( );//TimeZone.getTimeZone("JST") );
		cal.setTime( new Date( time * 1000 ) );

		int y = cal.get(Calendar.YEAR) ;
		int m = cal.get(Calendar.MONTH) +1;
		int d = cal.get(Calendar.DAY_OF_MONTH);
		int hh = cal.get(Calendar.HOUR_OF_DAY);
		int mm = cal.get(Calendar.MINUTE);
		int ss = cal.get(Calendar.SECOND);
		
		String month = String.valueOf(m);
		String day = String.valueOf(d);
		String hour = String.valueOf(hh);
		String min = String.valueOf(mm);
		String sec = String.valueOf(ss);
			
		if( m < 10 ) month = "0" + month;
		if( d < 10 ) day = "0" + day;
		if( hh < 10 ) hour = "0" + hour;
		if( mm < 10 ) min = "0" + min;
		if( ss < 10 ) sec = "0" + sec;

		return y+ "" + month + "" + day + "" + hour + "" + min+ "" + sec;
	}
	/**
	* 입력받은 년도를 숫자형식 long 으로 변환한다. 
	* @param String	년도
	* @return long
	*/
	public static long getTime(String date){
		Calendar cal = Calendar.getInstance( );//TimeZone.getTimeZone("JST") );
		return getTime(cal, date);
	}
	/**
	* 현재의 시간을 가져온다. 
	* @param Callendar	
	* @param String	년도
	* @return long
	*/
	public static long getTime( Calendar cal, String date){

		int yy =0;
		int mm = 0;
		int dd = 0;
		int hh = 0;
		int mi = 0;
		int ss = 0;

		if( date.length() == 4 ){
			yy = Integer.parseInt( date);
		}
		else if( date.length() == 6 ){
			yy = Integer.parseInt( date.substring(0,4) );
			mm = Integer.parseInt( date.substring(4) ) -1;
		}
		else if( date.length() == 8 ){
			yy = Integer.parseInt( date.substring(0,4) );
			mm = Integer.parseInt( date.substring(4,6) ) -1;
			dd = Integer.parseInt( date.substring(6) );
		}
		else if( date.length() == 10 ){
			yy = Integer.parseInt( date.substring(0,4) );
			mm = Integer.parseInt( date.substring(4,6) ) -1;
			dd = Integer.parseInt( date.substring(6,8) );
			hh = Integer.parseInt( date.substring(8) );
		}
		else if( date.length() == 12 ){
			yy = Integer.parseInt( date.substring(0,4) );
			mm = Integer.parseInt( date.substring(4,6) ) -1;
			dd = Integer.parseInt( date.substring(6,8) );
			hh = Integer.parseInt( date.substring(8,10) );
			mi = Integer.parseInt( date.substring(10) );
		}
		else if( date.length() == 14 ){
			yy = Integer.parseInt( date.substring(0,4) );
			mm = Integer.parseInt( date.substring(4,6) ) -1;
			dd = Integer.parseInt( date.substring(6,8) );
			hh = Integer.parseInt( date.substring(8,10) );
			mi = Integer.parseInt( date.substring(10,12) );
			ss = Integer.parseInt( date.substring(12) );
		}

		cal.set( yy, mm, dd, hh, mi, ss);
		return cal.getTime().getTime() / 1000;
	}
	
	public static void main(String[] arg){
		//System.out.println(simpleDateD());
	
	}

}
