package tv.pandora.adsrv.controller;

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
		
		String loginid = request.getParameter("loginid");
		System.out.println("------------loginid = "+loginid);
		String passwd = request.getParameter("passwd");
		System.out.println("------------passwd = "+passwd);
		String ipAddress = request.getHeader("X-FORWARDED-FOR");
		System.out.println("------------ipAddress = "+ipAddress);
		if(ipAddress == null) {
			ipAddress = request.getRemoteAddr();
		}
		

		if (loginid==null || passwd == null) {
			return new ModelAndView("common/login", "", "");
		}		
		if (StringUtil.isEmptyOrWhitespace(loginid) || StringUtil.isEmptyOrWhitespace(passwd)) {
			return this.makeSimpleMAV("common/loginfail", messageHandler.getErrMessage("error.required.user.email"),"message");
		}		
		
		User user = null;
		try {
			
			System.out.println("------------getUserLogin = ");
					
			
			Map<String, String> map = new HashMap<String, String>();
			map.put("loginid", loginid);
			map.put("passwd", passwd);
			map.put("stat", "1");
System.out.println("------------map"+map);
			user = usermgrFacade.getUserLogin(map);
			
			System.out.println("------------user = "+user);
	
			if (user != null) 
			{
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
}
