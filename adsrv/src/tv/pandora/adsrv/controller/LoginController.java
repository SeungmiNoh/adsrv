package tv.pandora.adsrv.controller;

import java.net.InetAddress;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import tv.pandora.adsrv.common.Constant;
import tv.pandora.adsrv.common.util.CookieUtil;
import tv.pandora.adsrv.common.session.SessionUtil;
import tv.pandora.adsrv.common.util.StringUtil;
import tv.pandora.adsrv.controller.AdsrvMultiActionController;
import tv.pandora.adsrv.domain.User;
import tv.pandora.adsrv.common.exception.AppException;

import org.springframework.web.servlet.ModelAndView;

public class LoginController  extends AdsrvMultiActionController {
	
	private static final HttpSession HttpSessionEvent = null;

	public ModelAndView login(HttpServletRequest request, HttpServletResponse response) throws Exception {
			
		InetAddress inetaddr = InetAddress.getLocalHost();
		
		String hostaddr = inetaddr.getHostAddress();
		String loginid = request.getParameter("loginid");
		String passwd = request.getParameter("passwd");		
		/*
		String ipAddress = request.getHeader("X-FORWARDED-FOR");
		System.out.println("ipAddress 11============"+ipAddress);
		if(ipAddress == null) {
			ipAddress = request.getRemoteAddr();
		}*/
		

		if (loginid==null || passwd == null) {
			return new ModelAndView("common/login", "", "");
		}		
		if (StringUtil.isEmptyOrWhitespace(loginid) || StringUtil.isEmptyOrWhitespace(passwd)) {
			return this.makeSimpleMAV("common/loginfail", messageHandler.getErrMessage("error.required.user.email"),"message");
		}		
		
		if((String)request.getParameter("chksaveid") != null)
		{
			Cookie cookie = new Cookie("member_id", loginid);
			cookie.setMaxAge(60 * 60); // 3600 sec의 수명을 지정
			cookie.setPath("/"); // '/' 이하 모든 디렉터리에서 유효
			response.addCookie(cookie); // response 객체에 쿠키 추가
		} else {
			eraseCookie("member_id", request,response);
		}

		if((String)request.getParameter("chksavepwd") != null)
		{
			Cookie cookie =  new Cookie("member_password", passwd);
			cookie.setMaxAge(60 * 60);
			cookie.setPath("/");
			response.addCookie(cookie);
		} else {
			eraseCookie("member_password", request,response);
		}			
		
		User user = null;
		try {
			
			System.out.println("------------getUserLogin = ");
					
			
			Map<String, String> map = new HashMap<String, String>();
			map.put("loginid", loginid);
			map.put("passwd", passwd);
			map.put("stat", "1");

			user = usermgrFacade.getUserLogin(map);
			
			System.out.println("------------user = "+user);
			boolean allow = true;
			if (user != null) 
			{
				System.out.println("user.getAllowIp()============"+user.getAllowIp());
				
				if(!StringUtil.isNull(user.getAllowIp()).equals("")){
					allow = StringUtil.like(hostaddr,user.getAllowIp());
				}
				if(!allow){
					return new ModelAndView("redirect:/");//return new ModelAndView("common/login", "response", null);						

				} else {
				
					Map<String, String> usermap = new HashMap<String, String>();
					usermap.put("userid", user.getUserid());
					usermap.put("username", user.getUsername());				
					usermap.put("perid", user.getUsertype());
					
					response.addCookie(CookieUtil.setCookie("auth", usermap, Constant.COOKIEDOMAIN, null));
					
						
					SessionUtil.setAttribute("userID", user.getUserid());
					SessionUtil.setAttribute("userName", user.getUsername());
					SessionUtil.setAttribute("userType", user.getUsertype());			
					SessionUtil.setAttribute("isMain", user.getIsmain());	
					
	
				}
			} 
			else 
			{
				return new ModelAndView("redirect:/");//return new ModelAndView("common/login", "response", null);						
			}		
			
			/*
			String preurl = request.getParameter("preurl");
			String url = "redirect:cpmgr.do?a=cplist";
			
			if (preurl==null) {
				preurl = request.getHeader("referer");
			}
			if (preurl != "") {
				url = "redirect:"+URLDecoder.decode(preurl);
				if(url.indexOf(Constant.WEB_ROOT)>0){
					String  url1 = url.substring(0, url.indexOf(Constant.WEB_ROOT));
					String url2 = url.substring(url.indexOf(Constant.WEB_ROOT)+Constant.WEB_ROOT.length());
					
					url = url1+url2;
				}
			}	*/	
			return new ModelAndView("redirect:cpmgr.do?a=cpList");
		} catch(AppException e) {
			return new ModelAndView("redirect:" + Constant.LOGIN_URL + request.getParameter("preurl"));
		}
		
	}
	public ModelAndView logout(HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		
		Cookie[] cookies = request.getCookies();
		
		request.getSession().invalidate();
		
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals("auth") || cookie.getName().equals("autol")) {
				Cookie ncookie = new Cookie(cookie.getName(), null);
				ncookie.setMaxAge(0);
				ncookie.setDomain(Constant.COOKIEDOMAIN);
				ncookie.setPath("/");
				//System.out.println(ncookie.getName() + " delete");
				response.addCookie(ncookie);				
			}
		}
		
	    return new ModelAndView("redirect:/");
	}
	private void eraseCookie(String name, HttpServletRequest req, HttpServletResponse resp) {
	    Cookie[] cookies = req.getCookies();
	    if (cookies != null)
	        for (int i = 0; i < cookies.length; i++) {
	        	if(cookies[i].getName().equals(name)) 
	        	{
		            cookies[i].setValue("");
		            cookies[i].setPath("/");
		            cookies[i].setMaxAge(0);
		            resp.addCookie(cookies[i]);
	        	}
	        }
	}
}
