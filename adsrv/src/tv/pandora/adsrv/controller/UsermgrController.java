package tv.pandora.adsrv.controller;

import java.io.Writer;
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
		
		String corpid = StringUtil.isNull(request.getParameter("corpid"));
		String change = StringUtil.isNull(request.getParameter("change"));
		String corpname = StringUtil.isNull(request.getParameter("corpname"));
		String corptype = StringUtil.isNull(request.getParameter("corptype"));
		
		String userID = (String)SessionUtil.getAttribute("userID");
		
		Map<String, String> map = new HashMap<String, String>();
	    
		map.put("corptype", corptype);
		map.put("corpname", corpname);
		map.put("updatedate", DateUtil.simpleDate2());
		
		if(corpid.equals("")) {
			map.put("insertdate", DateUtil.simpleDate2());
			map.put("insertuser", userID);
			usermgrFacade.addCorporation(map);
		} else {
			map.put("updatedate", DateUtil.simpleDate2());
			map.put("updateuser", userID);
			map.put("corpid", corpid);
			usermgrFacade.modCorporation(map);
		}
		
		return new ModelAndView("redirect:usermgr.do?a=corpList", null);
	}
	public ModelAndView corpView(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String corpid = StringUtil.isNull(request.getParameter("corpid"));

		if(corpid.equals("")){
			
			String referer = request.getHeader("referer");
			System.out.println("referer="+referer);
			
			String whatMethod = request.getMethod();
			System.out.println("whatMethod="+whatMethod);
			
			/*response.setCharacterEncoding("EUC-KR"); 
			Writer w = response.getWriter();
			w.write("<script>"); 
			w.write("alert('개인경비 시트 저장 중 오류가 발생했습니다.');"); 
			w.write("</script>"); 
			return null;*/
			Map<String, String> msgmap = new HashMap<String, String>();
			msgmap.put("referer", StringUtil.isNullReplace(referer,"/"));
			msgmap.put("msg", "잘못된 경로로 접근하셨습니다.");
			msgmap.put("backflag", "1");
			return new ModelAndView("common/block", "response", msgmap);
		}
		

		
		
		Map<String, String> map = new HashMap<String, String>();
	    
		map.put("corpid", corpid);
		Map<String, String> corp = usermgrFacade.getCorporation(map);
		
		System.out.println("-------------------map = "+map);
		List<User> userlist = usermgrFacade.getUserList(map);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("corp", corp);
		resultMap.put("userlist", userlist);
		
		return new ModelAndView("user/corp_view", "response", resultMap);
	}
	public ModelAndView permission(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		Map<String, String> map = new HashMap<String, String>();
				
		List<Map<String, String>> menulist = usermgrFacade.getMenuList(map);
		List<Map<String, String>> schemlist = usermgrFacade.getPerSchemaList(map);
		map.put("perid", "0");
		List<Map<String, String>> userscemlist = usermgrFacade.getUserPerSchema(map);
				
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("menulist", menulist);
		resultMap.put("schemlist", schemlist);
		resultMap.put("userscemlist", userscemlist);
		return new ModelAndView("user/user_permission", "response", resultMap);
	}

	public ModelAndView userList(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String s_type = StringUtil.isNull(request.getParameter("s_type"));
		String s_per = StringUtil.isNull(request.getParameter("s_per"));
		String page = StringUtil.isNull(request.getParameter("p"));
		String sch_text = StringUtil.isNull(request.getParameter("sch_text"));
		String userid = StringUtil.isNull(request.getParameter("userid"));
		if (page.equals("")) {
			page = "1";
		}
		Integer max = Constant.PAGE_LIST_L;
		Integer skip = (Integer.parseInt(page)-1)*max;
		
		Map<String, String> map = new HashMap<String, String>();
	    
		map.put("corptype", s_type)	;
		map.put("perid", s_per)	;
		map.put("userid", userid)	;
		map.put("skip", String.valueOf(skip))	;
		map.put("max", String.valueOf(max))	;
		map.put("sch_text", sch_text);
		map.put("sch_column", "corpname");
		Integer totalCount = usermgrFacade.getUserCnt(map);
		List<User> userlist = usermgrFacade.getUserList(map);
		
		// 선택 옵션 목록
		map.clear();
		map.put("code", "corptype");
		List<Map<String, String>> codelist = cpmgrFacade.getCodeList(map);
		
		// 권한 목록
		map.clear();		
		List<Map<String, String>> perlist = usermgrFacade.getUserPerList(map);


		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("codelist", codelist);
		resultMap.put("userlist", userlist);
		resultMap.put("perlist", perlist);
		resultMap.put("skip", skip);
		resultMap.put("max", max);
		resultMap.put("totalCount", totalCount);
		resultMap.put("nowPage", page);		
		return new ModelAndView("user/user_list", "response", resultMap);
	}
	public ModelAndView userEdit(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String userid = StringUtil.isNull(request.getParameter("userid"));

		Map<String, String> map = new HashMap<String, String>();
	    
		map.put("userid", userid)	;
		User user = usermgrFacade.getUserList(map).get(0);
		
		// 선택 옵션 목록
		map.clear();		
		List<Map<String, String>> perlist = usermgrFacade.getUserPerList(map);
		
		

		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("user", user);
		resultMap.put("perlist", perlist);		
		return new ModelAndView("user/user_edit", "response", resultMap);
	}
	public ModelAndView userRegist(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		String userid = StringUtil.isNull(request.getParameter("userid"));
	
		
		String userID = (String)SessionUtil.getAttribute("userID");
	
		User user = new User();
		bind(request, user);
	
		user.setUpdatedate(DateUtil.simpleDate2());
		user.setUpdateuser(userID);
		
		String url = "";
		
		if(userid.equals("")) {
			user.setInsertdate(DateUtil.simpleDate2());
			user.setInsertuser(userID);
			usermgrFacade.addUser(user);
			
			url = "usermgr.do?a=corpView&corpid="+user.getCorpid();
		} else {
			usermgrFacade.modUser(user);
			url = "usermgr.do?a=userList&userid="+user.getUserid();
		}
		
		
		return new ModelAndView("redirect:"+url, null);
	}
}
