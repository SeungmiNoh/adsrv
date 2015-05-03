package tv.pandora.adsrv.controller;

import java.io.Writer;
import java.lang.reflect.UndeclaredThrowableException;
import java.net.InetAddress;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
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
import tv.pandora.adsrv.domain.Menu;
import tv.pandora.adsrv.domain.User;
import tv.pandora.adsrv.common.exception.AppException;

import org.apache.commons.dbcp.SQLNestedException;
import org.springframework.web.servlet.ModelAndView;

public class LoginController  extends AdsrvMultiActionController {
	
	private static final HttpSession HttpSessionEvent = null;

	public ModelAndView login(HttpServletRequest request, HttpServletResponse response) throws Exception {
			
		try
		{
				//InetAddress inetaddr = InetAddress.getLocalHost();		
				//String hostaddr = inetaddr.getHostAddress();
				String loginid = request.getParameter("loginid");
				String passwd = request.getParameter("passwd");		
				
				String ipAddress = request.getHeader("X-FORWARDED-FOR");
				System.out.println("ipAddress 11============"+ipAddress);
				if(ipAddress == null) {
					ipAddress = request.getRemoteAddr();
				}		
		
				if (loginid==null || passwd == null) {
					return new ModelAndView("common/login", "", "");
				}		
				if (StringUtil.isEmptyOrWhitespace(loginid) || StringUtil.isEmptyOrWhitespace(passwd)) {
					return this.makeSimpleMAV("common/loginfail", messageHandler.getErrMessage("error.required.user.email"),"message");
				}		
				/************************* 쿠키 저장 & 삭제 ****************************/
				if((String)request.getParameter("chksaveid") != null){		
					setingCookie("member_id", loginid, response);
				} else {
					eraseCookie("member_id", request,response);
				}
				if((String)request.getParameter("chksavepwd") != null){
					setingCookie("member_password", passwd, response);
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
					try{
						user = usermgrFacade.getUserLogin(map);			
					
					} catch (UndeclaredThrowableException ex) {
						System.out.println(ex.getMessage());
						response.setCharacterEncoding("EUC-KR"); 
						Writer w = response.getWriter();
						w.write("<script>"); 
						w.write("alert('서버 접속에 문제가 있습니다\r\n관리자에게 문의해 주시기 바랍니다.');"); 
						w.write("</script>"); 
						return new ModelAndView("redirect:/");//return new ModelAndView("common/login", "response", null);												
					}
					//System.out.println("------------user = "+user);
					
					boolean allow = true;
					String mainLink = "cpmgr.do?a=cpList";
					if (user != null) 
					{
						/************************* 허용아이피 체크 ****************************/	
						System.out.println("StringUtil.isNull(user.getAllowip())--------------"+StringUtil.isNull(user.getAllowip()));
						if(!StringUtil.isNull(user.getAllowip()).equals("")){
							allow = StringUtil.like(ipAddress,user.getAllowip());
							System.out.println("allow-------------"+allow);
						}
						if(!allow){
							return new ModelAndView("redirect:/");//return new ModelAndView("common/login", "response", null);						
						} else {
							/************************ 유저 권한 별 메뉴리스트 **************************/
							map.put("perid", user.getPerid());
							map.put("corpid", user.getCorpid());
							map.put("ismain", user.getIsmain());
							List<Menu> menulist = usermgrFacade.getUserMenuList(map);
							mainLink = menulist.get(0).getMainlink();
							/*************************************************************************/
								
							SessionUtil.setAttribute("userID", user.getUserid());
							SessionUtil.setAttribute("userName", user.getUsername());
							SessionUtil.setAttribute("userType", user.getUsertype());			
							SessionUtil.setAttribute("userCorpid", user.getCorpid());			
							SessionUtil.setAttribute("userPername", user.getPername());			
							SessionUtil.setAttribute("isMain", user.getIsmain());
							SessionUtil.setAttributeList("menuList", menulist);
							
			
						}
					} 
					else 
					{
						return new ModelAndView("redirect:/");//return new ModelAndView("common/login", "response", null);						
					}		
					
					
					return new ModelAndView("redirect:"+mainLink);
				} catch(AppException e) {
					return new ModelAndView("redirect:" + Constant.LOGIN_URL + request.getParameter("preurl"));
				}
		} catch(SQLNestedException e) {
			System.out.println(e.getMessage());
			return new ModelAndView("redirect:/");//return new ModelAndView("common/login", "response", null);						
		}			
	}
	public ModelAndView logout(HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		
		Cookie[] cookies = request.getCookies();
		
		request.getSession().invalidate();
		/*
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals("auth") || cookie.getName().equals("autol")) {
				Cookie ncookie = new Cookie(cookie.getName(), null);
				ncookie.setMaxAge(0);
				ncookie.setDomain(Constant.COOKIEDOMAIN);
				ncookie.setPath("/");
				//System.out.println(ncookie.getName() + " delete");
				response.addCookie(ncookie);				
			}
		}*/
		
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
	
	private void setingCookie(String name, String value, HttpServletResponse resp) {
		
			Cookie cookie = new Cookie(name, value);
			cookie.setMaxAge(60 * 60 * 24 * 15); // 15일의 수명을 지정
			cookie.setPath("/"); // '/' 이하 모든 디렉터리에서 유효
			resp.addCookie(cookie); // response 객체에 쿠키 추가
		
	}
}
