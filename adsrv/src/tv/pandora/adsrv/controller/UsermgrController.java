package tv.pandora.adsrv.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import tv.pandora.adsrv.common.Constant;
import tv.pandora.adsrv.common.util.DateUtil;
import tv.pandora.adsrv.common.session.SessionUtil;
import tv.pandora.adsrv.common.util.StringUtil;
import tv.pandora.adsrv.domain.Ads;
import tv.pandora.adsrv.domain.Campaign;
import tv.pandora.adsrv.domain.User;

import org.springframework.web.servlet.ModelAndView;

public class UsermgrController extends AdsrvMultiActionController
{
	public ModelAndView corpList(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String s_type = StringUtil.isNull(request.getParameter("s_type"));
		String page = StringUtil.isNull(request.getParameter("p"));
		String sch_text = StringUtil.isNull(request.getParameter("sch_text"));
		
		System.out.println("1  sch_text=="+sch_text);
		
		
		sch_text = new String (sch_text.getBytes("8859_1"),"UTF-8");
		
		System.out.println("2  sch_text=="+sch_text);

		
		if (page.equals("")) {
			page = "1";
		}
		Integer max = Constant.PAGE_LIST_L;
		Integer skip = (Integer.parseInt(page)-1)*max;
		
		Map<String, String> map = new HashMap<String, String>();
	    
		map.put("corptype", s_type)	;
		map.put("skip", String.valueOf(skip))	;
		map.put("max", String.valueOf(max))	;
		map.put("sch_text", sch_text);
		map.put("sch_column", "corpname");
		Integer totalCount = usermgrFacade.getCorpCnt(map);
		List<Map<String, String>> corplist = usermgrFacade.getCorpList(map);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("corplist", corplist);
		resultMap.put("skip", skip);
		resultMap.put("max", max);
		resultMap.put("totalCount", totalCount);
		resultMap.put("countPerPage", Constant.PAGE_LIST_L);
		resultMap.put("nowPage", page);		
		return new ModelAndView("user/corp_list", "response", resultMap);
	}
	public ModelAndView corpRegist(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String corpname = StringUtil.isNull(request.getParameter("corpname"));
		String corptype = StringUtil.isNull(request.getParameter("corptype"));
		
		String userID = (String)SessionUtil.getAttribute("userID");
		
		Map<String, String> map = new HashMap<String, String>();
	    
		map.put("corptype", corptype);
		map.put("corpname", corpname);
		map.put("insertdate", DateUtil.simpleDate2());
		map.put("insertuser", userID);
		
		Integer corpid = usermgrFacade.addCorporation(map);
		
		return new ModelAndView("redirect:usermgr.do?a=corpList", null);
	}
	public ModelAndView corpView(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String corpid = StringUtil.isNull(request.getParameter("corpid"));

		Map<String, String> map = new HashMap<String, String>();
	    
		map.put("corpid", corpid);
		Map<String, String> corp = usermgrFacade.getCorpList(map).get(0);
		
		System.out.println("-------------------map = "+map);
		List<User> userlist = usermgrFacade.getUserList(map);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("corp", corp);
		resultMap.put("userlist", userlist);
		
		return new ModelAndView("user/corp_view", "response", resultMap);
	}
	public ModelAndView userList(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String s_type = StringUtil.isNull(request.getParameter("s_type"));
		String s_per = StringUtil.isNull(request.getParameter("s_per"));
		String page = StringUtil.isNull(request.getParameter("p"));
		String sch_text = StringUtil.isNull(request.getParameter("sch_text"));

		if (page.equals("")) {
			page = "1";
		}
		Integer max = Constant.PAGE_LIST_L;
		Integer skip = (Integer.parseInt(page)-1)*max;
		
		Map<String, String> map = new HashMap<String, String>();
	    
		map.put("corptype", s_type)	;
		map.put("perid", s_per)	;
		map.put("skip", String.valueOf(skip))	;
		map.put("max", String.valueOf(max))	;
		map.put("sch_text", sch_text);
		map.put("sch_column", "corpname");
		Integer totalCount = usermgrFacade.getUserCnt(map);
		List<User> userlist = usermgrFacade.getUserList(map);
		
		// 선택 옵션 목록
		map.clear();
		map.put("tbname", "corporation");
		List<Map<String, String>> codelist = cpmgrFacade.getCodeList(map);
		
		

		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("codelist", codelist);
		resultMap.put("userlist", userlist);
		resultMap.put("skip", skip);
		resultMap.put("max", max);
		resultMap.put("totalCount", totalCount);
		resultMap.put("nowPage", page);		
		return new ModelAndView("user/user_list", "response", resultMap);
	}
}
