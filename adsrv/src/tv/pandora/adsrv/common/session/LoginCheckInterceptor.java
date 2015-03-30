package tv.pandora.adsrv.common.session;

import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import tv.pandora.adsrv.common.Constant;
import tv.pandora.adsrv.common.util.CookieUtil;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter {
	@Override
	 public boolean preHandle(HttpServletRequest request,
	   HttpServletResponse response, Object handler) throws Exception {
	  // TODO Auto-generated method stub	  
	  // session검사
	  HttpSession session = request.getSession(false);
	  
	  //System.out.println("request.getRequestURI() = "+request.getRequestURI());
	  //System.out.println("request.getParameterMap() = "+request.getParameterMap());
	  
	  setLogHistory(request);
	  
	  
	  if(request.getRequestURI().indexOf("login.do")>0) 
	  {
		  //System.out.println("==== 로그인컨트롤러는 그냥 통과 ========");
		  return true;
	  }	
	  else if (session == null) 
	  {		  
				 
			 throw new ModelAndViewDefiningException(new ModelAndView("common/session_end"));
		
		 // 처리를 끝냄 - 컨트롤로 요청이 가지 않음.
 	  } 
	  else 
 	  {
 		  String userName = (String)session.getAttribute("userName");
			 System.out.println("userName : "+userName);
			 	  
 		  if (userName == null) 
 		  { 
  			  throw new ModelAndViewDefiningException(new ModelAndView("redirect:" + Constant.WEB_SERVER_INDEX +Constant.WEB_ROOT+ "?preurl=" + URLEncoder.encode(request.getRequestURI() + "?" +request.getQueryString())));
 		  } /*
 		  else 
 		  {
 			 System.out.println("컨트롤러 이동해도 됨 : "+userName);

 			 Map<String, String> usermap = (HashMap<String, String>)CookieUtil.getDecodeCookie(request.getCookies(), "auth"); 
 			 
 			 if (usermap.get("usertype") == null || usermap.get("usertype").equals("")) 
 			 {
 				 System.out.println("URL : "+Constant.WEB_SERVER_INDEX +Constant.WEB_ROOT);
 				//throw new ModelAndViewDefiningException(new ModelAndView("redirect:" + Constant.WEB_SERVER_INDEX +Constant.WEB_ROOT)); 
 				 
 			 }
  		  }*/
 	  }
	  return true;
	}
	
	private void setLogHistory(HttpServletRequest request) {
		
		// get request parameter map
		Map<String, String[]> requestParams = request.getParameterMap();
 
		// retrieve parameter name - values pair from parameter map
		StringBuilder sb = new StringBuilder();
		for (Map.Entry<String, String[]> entry : requestParams.entrySet()) {
			String key = entry.getKey();         // parameter name
			String[] value = entry.getValue();   // parameter values as array of String
			String valueString = "";
			
			// in case of checkbox input, value may be array of length greater than one
			if (value.length > 1) {
				for (int i = 0; i < value.length; i++) {
					valueString += value[i] + " ";
				}
			} else {
				valueString = value[0];
			}
			System.out.println("***** " + key + " - " + valueString);
			sb.append(key).append(" - ").append(valueString).append("; ");
		}
		
	}


}
