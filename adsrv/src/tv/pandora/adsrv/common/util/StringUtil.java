
package tv.pandora.adsrv.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.nio.charset.CharacterCodingException;
import java.nio.charset.Charset;
import java.nio.charset.CharsetDecoder;
import java.nio.charset.CharsetEncoder;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import java.util.StringTokenizer;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.util.StringUtils;

/**
 * @author Administrator
 *
 */
public class StringUtil {

	public static String join(List<String> strings, String token )
	{
		StringBuffer sb = new StringBuffer();
      
      int len = strings.size() - 1;
      
      for( int x = 0; x < len; x++ ) {
          sb.append( strings.get(x) );
          sb.append( token );
      }
      
      sb.append( strings.get(len) );
      
      return( sb.toString() );
  }

  public static boolean isEmptyOrWhitespace(String value) {
  	if (value == null || !StringUtils.hasText(value.toString())) {
  		return true;
  	} else {
  		return false;
  	}
  }

  public static boolean isEmptyOrZeroOrWhitespace(String value) {
  	if (value == null || "0".equals(value) || !StringUtils.hasText(value.toString())) {
  		return true;
  	} else {
  		return false;
  	}
  }

  public static boolean isEmptyOrZeroOrWhitespace(Object obj) {
  	if (obj == null)
  		return true;
  	
  	String value = obj.toString();
  	
  	if (value == null || "0".equals(value) || !StringUtils.hasText(value.toString())) {
  		return true;
  	} else {
  		return false;
  	}
  }	
  
  public static String implode(List<String> ary, String delim) {
  	StringBuffer out = new StringBuffer();
  
  	for (Iterator<String> iter = ary.iterator(); iter.hasNext();) {
  		String var = iter.next();
  		out.append(var);
  
  		if (iter.hasNext()) {
  			out.append(delim);
  		}
  	}
  
  	return out.toString();
  }
  
  public static String convertCharSet(String src, String targetCharSet) {
  	if (src == null) return null;
  	
  	Charset charset = Charset.forName(targetCharSet);
  	CharsetDecoder decoder = charset.newDecoder();
  	CharsetEncoder encoder = charset.newEncoder();
  	ByteBuffer bbuf;
  	CharBuffer cbuf;
  	
  	try {
  		bbuf = encoder.encode(CharBuffer.wrap(src));
  		cbuf = decoder.decode(bbuf);
  	} catch (CharacterCodingException e) {
  		return null;			
  	}
  	
  	return cbuf.toString();
  }
  
  public static String removeHtmlTag(String src) {		
  	if (StringUtil.isEmptyOrWhitespace(src))
  		return src;
  			
  	String regex = "<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>";
  	//String specialChar = "var specialChars='~`!@#$%%^&*-=+\|[{]};:\',<.>/?';"
  	String specialChar = "[-♨★\\*=]";
  	src = src.replaceAll(regex, "").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
  	
  	return getSTRFilter(src);
  }
  
  public static String getSTRFilter(String str){ 
	  String[] filter_word = {"","\\.","-","=","\\/","\\~","\\!","\\@","\\#","\\$","\\%","\\^","\\&","\\*","\\(","\\)","\\_","\\+","\\=","\\|","\\\\","\\}","\\]","\\{","\\[","\\\"","\\'","\\:","\\;","\\<","\\,","\\>","\\.","\\?","\\/"}; 
	  for(int i=0;i<filter_word.length;i++){ 
	   //while(str.indexOf(filter_word[i]) >= 0){ 
		  str = str.replaceAll(filter_word[i],""); 
	   //} 
	  } 
	  return str; 
	 
	 } 
  
  public static String removeHtmlTag_iframe(String src) {		
  	if (StringUtil.isEmptyOrWhitespace(src))
  		return src;
  	
  	return src.replaceAll("(?i)<(\\s)*(/)?(\\s)*iframe([^>])*>", "");   		
  }
  
  public static String removeHtmlTag_script(String src) {		
  	if (StringUtil.isEmptyOrWhitespace(src))
  		return src;
  	
  	return src.replaceAll("(?i)<(\\s)*(/)?(\\s)*script([^>])*>", "");   		
  }
  public static String cutStrLength (String str, Integer leng)
  {	    
	  if(str.length()>leng)
	  {
		  str = str.substring(0, leng)+"..";
	  }
	  return str;
  }
  public static String cutByteLength (String str, Integer leng)
  {	    
	  StringBuffer rtstr = new StringBuffer();
	  
	  if(str.length()>0)
	  {
		  rtstr.append(str.substring(0, getLengthInString(str,leng)));
		  if(rtstr.length()!=str.length())
			  rtstr.append("..");
		  return rtstr.toString();
	  }
	  else
	  {
		  return str;
	  }
  } 
  public static String replaceChar (String str, Integer leng)
  {	    
	  String result = "";
	  
	  for(int i=0; i<leng;i++){
		  result += str;
	  }
	  return result;
  }
  public static int getLengthInString(String str, int byteLength)
  {
	  int length = str.length();
	  int retLength = 0;
	  int tempSize = 0;
	  int asc;
	  for(int i=1; i<=length;i++)
	  {
		  asc = (int)str.charAt(i-1);
		  if(asc>127)
		  {
			  if(byteLength > tempSize)
			  {
				  tempSize +=2;
				  retLength++;
			  }
		  }
		  else
		  {
			  if(byteLength > tempSize)
			  {
				  tempSize++;
				  retLength++;
			  }
		  }
	  }
	  return retLength;
  }
  public static String stringToHex(String str) {
	  char[] chars = str.toCharArray();
	  
	  StringBuffer hex = new StringBuffer();
	  for(int i = 0; i < chars.length; i++){
	    hex.append(Integer.toHexString((int)chars[i]));
	  }
 
	  return hex.toString();
  }
  
  public static String hexToString(String hex){
	  
	  StringBuilder sb = new StringBuilder();
	  StringBuilder temp = new StringBuilder();
 
	  //49204c6f7665204a617661 split into two characters 49, 20, 4c...
	  for( int i=0; i<hex.length()-1; i+=2 ){
 
	      //grab the hex in pairs
	      String output = hex.substring(i, (i + 2));
	      //convert hex to decimal
	      int decimal = Integer.parseInt(output, 16);
	      //convert the decimal to character
	      sb.append((char)decimal);
 
	      temp.append(decimal);
	  }
	  //System.out.println("Decimal : " + temp.toString());
 
	  return sb.toString();
  	} 
  public static String ifNull(String str, String str2){
		if ( str == null )	return str2;
		else if ( str == "null" )	return str2;
		else if ( str == "" )	return str2;
		else	return str;
	}	
	public static String isNull(String str){
		if ( str == null )	return "";
		else if ( str == "null" )	return "";
		else	return str;
  	}	
  	public static String isNullZero(String str){
		if ( str == null || str.equals("") || str.equals("null"))	return "0";
		else	return str;
  	}	
  	public static String isNullReplace(String str, String rep){
		if ( str == null || str.equals("") || str.equals("null"))	return rep;
		else	return str;
  	}
  	public static String isNullMax(String str){
		if ( str == null || str.equals(""))	return "9999";
		else	return str;
  	}	
	public static String[] strToken(String str, String sep)
	{
		StringTokenizer stk = new StringTokenizer(str, sep);
		String[] arr = new String[stk.countTokens()];
		
		int row = 0;
		
		while(stk.hasMoreTokens())
		{
			arr[row] = stk.nextToken();
			row++;
		}
		return arr; 
	}
    public static String toDate(String dateString){
		
		if((dateString==null) || dateString.equals("") || dateString.length() != 8) return dateString;
		return(dateString.substring(0, 4) + "-" + dateString.substring(4, 6) + "-" + dateString.substring(6, 8) );

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
	
		return y+ "-" + month + "-" + day;
	}
	
	/**
     * 3자리 마다 콤마 추가
     *
     * @param str   대상문자열
     * @param limit 자를 자릿수   
     * @return      잘라진 문자열
     */
	
	//String type인 경우 
    public static String addComma(String str) {
    	if((str == null) || str.equals("")) {
    		return "";
    	} else {    		
    		String minus = "";
       		if(str.substring(0,1).equals("-")) {
    			minus=str.substring(0,1);
    			str = str.substring(1, str.length());
    		}
 	        StringBuffer sb = new StringBuffer(str);
	        StringBuffer rsb = new StringBuffer();
	        sb = sb.reverse();
	        int p = 0;
	
	        for (int i = 0; i < str.length(); i++) {
	            p = i % 3;
	
	            if (i > 0)
	                if (p == 0)
	                    rsb.append(",");
	
	            rsb.append(sb.substring(i, (i + 1)));
	        }
	
	        return minus+(rsb.reverse()).toString();
    	}
    }
    
    //int type인 경우
    public static String addComma(int num) {

        String str = num + "";
        StringBuffer sb = new StringBuffer(str);
        StringBuffer rsb = new StringBuffer();
        sb = sb.reverse();
        int p = 0;

        for (int i = 0; i < str.length(); i++) {
            p = i % 3;

            if (i > 0)
                if (p == 0)
                    rsb.append(",");

            rsb.append(sb.substring(i, (i + 1)));
        }

        return (rsb.reverse()).toString();
    }
    
	
    /**
	 *	컴마를 없애준다.
	 *	@param	String		
	 *	@return	String 			
	 */
   	public static String delcomma(String str){
		try{
			if((str == null) || str.equals("")) return "0";

            while(str.indexOf(",") != -1) {
                str = str.substring(0,str.indexOf(",")) + str.substring(str.indexOf(",")+1);
            }

			return str;

		}catch(Exception e){
			return "";
		}
	}
	public static String DateStr (String str){
		try{
			if((str == null) || str.equals("")) return "";
			return str.replaceAll("-","");
		}catch(Exception e){
			return "";
		}
	}
   	
  // 특수기호 변환
    public static String htmlEncode(String txt) {
    	if(txt==null)
    	{
    		txt = "";
    	}
    	else
    	{
	    	txt = txt.replaceAll("&", "&amp;");
	    	txt = txt.replaceAll("<", "&lt;");
	    	txt = txt.replaceAll(">", "&gt;");
	    	txt = txt.replaceAll("\"", "&quot;");
	    	txt = txt.replaceAll("'", "&#39;");
	    }
    	return txt;
    }
    
	// 인코딩관련 함수 추가 2011.08.29
	public static String EnCode(String param)
	{
	    // sjisbmoc
	    StringBuffer    sb  = new StringBuffer();


	    if(param == null)
	    {
	        sb.append("");
	    }
	    else
	    {
	        if(param.length()>0)
	        {
	            for(int i=0; i<param.length(); i++)
	            {
	                String  len = ""+((int)param.charAt(i));
	                sb.append(len.length());
	                sb.append(((int)param.charAt(i)));
	            }
	        }
	    }


	    return sb.toString();
	}
  //public static String makeStackTrace(Throwable t) {
  //	if (t == null)
  //		return "";
  //	try {
  //		ByteArrayOutputStream bout = new ByteArrayOutputStream();
  //		t.printStackTrace(new PrintStream(bout));
  //		bout.flush();
  //		String error = new String(bout.toByteArray());
  //
  //		return error;
  //	} catch (Exception ex) {
  //		return "";
  //	}
  //}
	
	
	
	
	//랜덤 문자열 조합 
	public static String randomStr(int length) 
	{
		Random r = new Random();
		String str = "";

		for(int i=0 ; i<length ; i++)
		{
			char c = (char)(r.nextInt(26) + 65);
			str += c;
		}  
		return str;
	}

	//랜덤 문자열 조합 
	public static String getRandomString(int length)
	{
		  StringBuffer buffer = new StringBuffer();
		  Random random = new Random();
		 
		  String chars[] = 
		    "a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,1,2,3,4,5,6,7,8,9".split(",");
		 
		  for (int i=0 ; i<length ; i++)
		  {
			  buffer.append(chars[random.nextInt(chars.length)]);
		  }
		  return buffer.toString();
		}
	
	
	
	
	
	
	
	

	public static String toString(Object object) {
		// TODO Auto-generated method stub
		
		return String.valueOf(object);
	}
	
	
	public String getJsonString(String root_name, List<Object> listObj)
	{
	  String result = "";
	  JSONArray jArray = new JSONArray();
	  
	  try
	  {
	    if (root_name == null || root_name.length() == 0)
	      root_name = "result";
	    
	    for (int j = 0; j < listObj.size(); j++)
	    {
	      JSONObject jObject = new JSONObject();
	      
	      Object obj = listObj.get(j);
	      Field[] fields = obj.getClass().getDeclaredFields();
	      
	      for (int i = 0; i < fields.length; i++)
	      {
	        String field_name = fields[i].getName();
	        String method_prefix = field_name.substring(0, 1).toUpperCase(); //필드명 첫 글자를 대문자로 변경
	        String method_gtname = field_name.substring(1, field_name.length()); //나머지 글자 저장
	        Method method = null;
	        
	        try
	        {  //getter 메서드 설정.
	          method = obj.getClass().getDeclaredMethod("get" + method_prefix + method_gtname);
	        } catch (Exception ex)
	        {
	        }
	        if (method == null)
	          continue;
	        
	        //리턴값이 void 가 아니며, 인자값이 없는 값을 읽어서 jObject 에 등록
	        if ("void".equals(method.getReturnType().getName()) == false && method.getParameterTypes().length == 0)
	        {
	          method.setAccessible(true);
	          
	          jObject.put(field_name, method.invoke(obj, null));
	        }
	      }
	      
	      if (jObject.size() > 0)
	        jArray.add(jObject);
	    }
	    
	    //JSON 문자열로 변환
	    result = (new JSONObject()).put(root_name, jArray).toString();
	  } catch (Exception ex)
	  {
	  }
	  
	  return result;
	}

	

}
