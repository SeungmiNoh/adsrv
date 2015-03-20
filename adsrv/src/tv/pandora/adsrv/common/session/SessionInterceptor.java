package tv.pandora.adsrv.common.session;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import tv.pandora.adsrv.common.util.StringUtil;


public class SessionInterceptor extends HandlerInterceptorAdapter
{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception  
	{
 
		System.out.println("This is Session Interceptor Area!!!!!");
 
		String stGetConfig = StringUtil.isNull( request.getParameter("configLogin"));
 
		Object oSession  = request.getSession().getAttribute("USER_INFO");

		if( !stGetConfig.equals("Y"))
		{ 
			if(oSession == null)
			{ 
		       throw new ModelAndViewDefiningException(new ModelAndView("endSession"));
			}
 
			else 
			{ 
				return true;
			}
		}
		else 
		{ 
			return true;
 
		} 
	}
 
}
 
