package tv.pandora.adsrv.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tv.pandora.adsrv.common.Constant;
import tv.pandora.adsrv.common.util.StringUtil;
import tv.pandora.adsrv.common.exception.AppException;
import tv.pandora.adsrv.common.handler.MessageHandler;
import tv.pandora.adsrv.logic.SitemgrFacade;
import tv.pandora.adsrv.logic.UsermgrFacade;
import tv.pandora.adsrv.logic.CpmgrFacade;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

public class AdsrvMultiActionController extends MultiActionController{
	protected UsermgrFacade usermgrFacade;
	protected SitemgrFacade sitemgrFacade;
	protected CpmgrFacade cpmgrFacade;
	protected MessageHandler messageHandler;
	
	public void setUsermgrFacade(UsermgrFacade usermgrFacade) {
		this.usermgrFacade = usermgrFacade;
	}
	public void setSitemgrFacade(SitemgrFacade sitemgrFacade) {
		this.sitemgrFacade = sitemgrFacade;
	}
	public void setCpmgrFacade(CpmgrFacade cpmgrFacade) {
		this.cpmgrFacade = cpmgrFacade;
	}	
	public void setMessageHandler(MessageHandler messageHandler) {
		this.messageHandler = messageHandler;
	}
	//get() 호출 시
		// 무한 루프에 빠지지 않으려면 이 메소드를 오버라이드 해야 한다.
		// -1을 리턴하면, 무조건 업데이트가 필요하다는 의미이다.
		@Override
		public long getLastModified(HttpServletRequest req) {
			return -1;
		}
		
		//-------------------------------------------------------------------------
		// MAV helper
		//-------------------------------------------------------------------------
		protected <T> ModelAndView makeSimpleMAV(String viewname, T object, String name) {
			Map<String, Object> map = new HashMap<String, Object>  ();
			
			if (object != null) {
				map.put(name, object);
			}
			System.out.println("------------------ 멀티액션 map = " + map);

			return new ModelAndView(viewname, map);
		}
		
		protected ModelAndView makeSimpleMAV(HttpServletRequest request, Map map) {
			
			return new ModelAndView(getViewType(request), map);		
		}
		
		protected <T> ModelAndView makeObjectMAV(HttpServletRequest request, T object, String name) {
			Map<String, Object> map = new HashMap<String, Object>  ();
			
			if (object != null) {
				map.put(name, object);
			}
			
			map.put("code", 100);
			
			Map<String, Object>  responseMap = new HashMap<String, Object>  ();
			responseMap.put("response", map);
					
			return new ModelAndView(getViewType(request), responseMap);		
		}
		
		protected <T> ModelAndView makeListMAV(HttpServletRequest request, Map<String, Object> map) {		
			if (map == null) {
				return new ModelAndView("jsonView", null);
			}
			
			map.put("code", 100);
			
			Map<String, Object>  responseMap = new HashMap<String, Object>  ();
			responseMap.put("response", map);
					
			return new ModelAndView(getViewType(request), responseMap);		
		}

		private String getViewType(HttpServletRequest request) {
			
			String viewName = request.getParameter("view");
			
			if ("xml".equals(viewName))
				return Constant.XML_VIEW;
			else if ("json".equals(viewName))
				return Constant.DEFAUALT_VIEW;
			else
				return Constant.DEFAUALT_VIEW;
		}
		
		public ModelAndView notSetting(HttpServletRequest request, HttpServletResponse reponse) throws Exception {	
			return new ModelAndView("redirect:" + Constant.LOGIN_URL, null);
		}

		//-------------------------------------------------------------------------
		// request Helper
		//-------------------------------------------------------------------------
		/**
		 * 무결정 체크 없이 그냥 가져옴
		 * @param request request
		 * @param paramName
		 * @return
		 */
		protected String get_request(HttpServletRequest request, String paramName) {
			return request.getParameter(paramName);		
		}

		/**
		 * 값이 있는지 체크
		 * @param request request
		 * @param paramName
		 * @return
		 */
		protected String get_check(HttpServletRequest request, String paramName) {
			String paramValue = request.getParameter(paramName);
			

			System.out.println("------------------ 멀티액션 paramValue = " + paramValue);
			

			if(StringUtil.isEmptyOrWhitespace(paramValue)) {
				throw new AppException (messageHandler.getErrMessage("pptree.err.ERR_PARAM_LACK", new String[] {paramName}));					
			}
			
			return paramValue;
//				$this -> throw_error("ERR_PARAM_LACK", $name);
	//
//			if(!$this -> check_type($str, $type) && !$this -> check_type($str, $type2))
//				$this -> throw_error("ERR_PARAM_WRONG", $name);
	//
//			return $str;
		}
		
		/**
		 * 무결성 체크를 하나 없으면 그냥 NULL 반환
		 * request.getParameter <- 그냥 이거 사용
		 * @param request
		 * @param paramName
		 * @return
		 * @deprecated
		 */
		protected String get_pass(HttpServletRequest request, String paramName) {
			String paramValue = request.getParameter(paramName);
			
//			if(!$this -> check_type($str, $type) && !$this -> check_type($str, $type2) && $str !== NULL)
//				$this -> throw_error("ERR_PARAM_WRONG", "type of " . $name);
				
			return paramValue;
		}
}
