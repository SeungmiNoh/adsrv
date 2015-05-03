package tv.pandora.adsrv.controller;

import java.io.Writer;
import java.util.ArrayList;
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













import tv.pandora.adsrv.domain.Slot;

import org.springframework.web.servlet.ModelAndView;

public class SitemgrController extends AdsrvMultiActionController
{
	public ModelAndView siteList(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String s_type = StringUtil.isNull(request.getParameter("s_type"));
		String page = StringUtil.isNull(request.getParameter("p"));
		String sch_text = StringUtil.isNull(request.getParameter("sch_text"));
		sch_text = new String (sch_text.getBytes("8859_1"),"UTF-8");

		if (page.equals("")) {
			page = "1";
		}
		Integer max = Constant.PAGE_LIST_L;
		Integer skip = (Integer.parseInt(page)-1)*max;
		
		Map<String, String> map = new HashMap<String, String>();
	    
		map.put("sitetype", s_type)	;
		map.put("skip", String.valueOf(skip))	;
		map.put("max", String.valueOf(max))	;
		map.put("sch_text", sch_text);
		map.put("sch_column", "sitename");
		map.put("page","Y");
		Integer totalCount = sitemgrFacade.getSiteCnt(map);
		List<Map<String, String>> sitelist = sitemgrFacade.getSiteList(map);
		
		
		//선택 옵션 목록
		map.put("tbname", "site");
		List<Map<String, String>> codelist = cpmgrFacade.getCodeList(map);	

		
		

		Map<String, Object> resultMap = new HashMap<String, Object>();		
		resultMap.put("sitelist", sitelist);
		resultMap.put("codelist", codelist);
		resultMap.put("skip", skip);
		resultMap.put("max", max);
		resultMap.put("totalCount", totalCount);
		resultMap.put("countPerPage", Constant.PAGE_LIST_L);
		resultMap.put("nowPage", page);		
		return new ModelAndView("site/site_list", "response", resultMap);
	}	
	public ModelAndView siteRegist(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String siteid = StringUtil.isNull(request.getParameter("siteid"));

		String corpid = StringUtil.isNull(request.getParameter("corpid"));
		String sitetype = StringUtil.isNull(request.getParameter("sitetype"));
		String sitename = StringUtil.isNull(request.getParameter("sitename"));
		String sitetag = StringUtil.isNull(request.getParameter("sitetag"));
		String siteurl= StringUtil.isNull(request.getParameter("siteurl"));
		String memo= StringUtil.isNull(request.getParameter("memo"));
		System.out.println("memo="+memo);
		String userID = (String)SessionUtil.getAttribute("userID");
		System.out.println("StringUtil.htmlEncode(memo)="+StringUtil.htmlEncode(memo));
	
		Map<String, String> map = new HashMap<String, String>();
	    
		map.put("corpid", corpid);
		map.put("sitetype", sitetype);
		map.put("sitename", sitename);
		map.put("sitetag", sitetag);
		map.put("siteurl", siteurl);
		map.put("memo", StringUtil.htmlEncode(memo));
		
		if(siteid.equals("")) {
			map.put("insertdate", DateUtil.simpleDate2());
			map.put("insertuser", userID);
			siteid = String.valueOf(sitemgrFacade.addSite(map));
			return new ModelAndView("redirect:sitemgr.do?a=secList&s_siteid="+siteid, null);
		} else {
			map.put("siteid", siteid);
			map.put("updatedate", DateUtil.simpleDate2());
			map.put("updateuser", userID);
			sitemgrFacade.modSite(map);
			return new ModelAndView("redirect:sitemgr.do?a=siteList&s_siteid="+siteid, null);
		}
		
	}
	public ModelAndView secList(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String s_type = StringUtil.isNull(request.getParameter("s_type"));
		String s_siteid = StringUtil.isNull(request.getParameter("s_siteid"));
		String page = StringUtil.isNull(request.getParameter("p"));
		String sch_text = StringUtil.isNull(request.getParameter("sch_text"));
		sch_text = new String (sch_text.getBytes("8859_1"),"UTF-8");

		if (page.equals("")) {
			page = "1";
		}
		Integer max = Constant.PAGE_LIST_L;
		Integer skip = (Integer.parseInt(page)-1)*max;
		
		Map<String, String> map = new HashMap<String, String>();
	    
		map.put("siteid", s_siteid)	;
		map.put("sitetype", s_type)	;
		map.put("skip", String.valueOf(skip))	;
		map.put("max", String.valueOf(max))	;
		map.put("sch_text", sch_text);
		map.put("sch_column", "secname");
		map.put("page","Y");

		Integer totalCount = sitemgrFacade.getSectionCnt(map);
		List<Map<String, String>> seclist = sitemgrFacade.getSectionList(map);

		map.clear();
		map.put("order_str", "sitename");
		List<Map<String, String>> sitelist = sitemgrFacade.getSiteList(map);
	
		

		Map<String, Object> resultMap = new HashMap<String, Object>();		
		resultMap.put("sitelist", sitelist);
		resultMap.put("seclist", seclist);
		
		resultMap.put("skip", skip);
		resultMap.put("max", max);
		resultMap.put("totalCount", totalCount);
		resultMap.put("countPerPage", Constant.PAGE_LIST_L);
		resultMap.put("nowPage", page);		
		return new ModelAndView("site/section_list", "response", resultMap);
	}
	public ModelAndView secRegist(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String secid = StringUtil.isNull(request.getParameter("secid"));

		String siteid = StringUtil.isNull(request.getParameter("siteid"));
		String secname = StringUtil.isNull(request.getParameter("secname"));
		String sectag = StringUtil.isNull(request.getParameter("sectag"));
		String memo= StringUtil.isNull(request.getParameter("memo"));
		
		String userID = (String)SessionUtil.getAttribute("userID");
		
		Map<String, String> map = new HashMap<String, String>();
	    
		map.put("siteid", siteid);
		map.put("secname", secname.trim());
		map.put("sectag", sectag);
		map.put("memo", StringUtil.htmlEncode(memo));
		
		if(secid.equals("")) {
			map.put("insertdate", DateUtil.simpleDate2());
			map.put("insertuser", userID);
			secid = String.valueOf(sitemgrFacade.addSection(map));
			return new ModelAndView("redirect:sitemgr.do?a=slotList&s_siteid="+siteid+"&s_secid="+secid, null);
		} else {
			map.put("secid", secid);
			map.put("updatedate", DateUtil.simpleDate2());
			map.put("updateuser", userID);
			sitemgrFacade.modSection(map);
			return new ModelAndView("redirect:sitemgr.do?a=secList&s_siteid="+siteid+"&s_secid="+secid, null);
		}
	}
	public ModelAndView slotList(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String s_type = StringUtil.isNull(request.getParameter("s_type"));
		String s_secid = StringUtil.isNull(request.getParameter("s_secid"));
		String s_siteid = StringUtil.isNull(request.getParameter("s_siteid"));
		String page = StringUtil.isNull(request.getParameter("p"));
		String sch_text = StringUtil.isNull(request.getParameter("sch_text"));
		sch_text = new String (sch_text.getBytes("8859_1"),"UTF-8");

		if (page.equals("")) {
			page = "1";
		}
		Integer max = Constant.PAGE_LIST_L;
		Integer skip = (Integer.parseInt(page)-1)*max;
		
		Map<String, String> map = new HashMap<String, String>();
	    
		map.put("siteid", s_siteid)	;
		map.put("secid", s_secid)	;
		map.put("prtype", s_type)	;
		map.put("skip", String.valueOf(skip))	;
		map.put("max", String.valueOf(max))	;
		map.put("sch_text", sch_text);
		map.put("sch_column", "slotname");
		map.put("page","Y");

		Integer totalCount = sitemgrFacade.getSlotCnt(map);
		List<Slot> slotlist = sitemgrFacade.getSlotList(map);

		map.clear();
		map.put("order_str", "sitename");
		List<Map<String, String>> sitelist = sitemgrFacade.getSiteList(map);
		
		map.clear();
		map.put("order_str", "secname");
		List<Map<String, String>> seclist = sitemgrFacade.getSectionList(map);
		
		//광고상품 목록
		map.clear();
		map.put("code", "prtype");
		List<Map<String, String>> codelist = cpmgrFacade.getCodeList(map);	
		

		Map<String, Object> resultMap = new HashMap<String, Object>();		
		resultMap.put("sitelist", sitelist);
		resultMap.put("seclist", seclist);
		resultMap.put("slotlist", slotlist);
		resultMap.put("codelist", codelist);
		
		resultMap.put("skip", skip);
		resultMap.put("max", max);
		resultMap.put("totalCount", totalCount);
		resultMap.put("countPerPage", Constant.PAGE_LIST_L);
		resultMap.put("nowPage", page);		
		return new ModelAndView("site/slot_list", "response", resultMap);
	}
	public ModelAndView siteView(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String siteid = StringUtil.isNull(request.getParameter("siteid"));
		
		
		Map<String, String> map = new HashMap<String, String>();
	    
		map.put("siteid", siteid)	;
		Map<String,String> site = sitemgrFacade.getSite(map);
		map.put("siteid", siteid)	;
		map.put("page","Y");
		List<Slot> slotlist = sitemgrFacade.getSlotList(map);

		map.clear();
		map.put("order_str", "sitename");
		List<Map<String, String>> sitelist = sitemgrFacade.getSiteList(map);
		map.clear();
		map.put("siteid", siteid)	;
		map.put("order_str", "secname");
		List<Map<String, String>> seclist = sitemgrFacade.getSectionList(map);
		
		//광고상품 목록
		map.clear();
		map.put("code", "prtype");
		List<Map<String, String>> codelist = cpmgrFacade.getCodeList(map);	
			
	
		

		Map<String, Object> resultMap = new HashMap<String, Object>();		
		resultMap.put("site", site);
		resultMap.put("slotlist", slotlist);
		resultMap.put("codelist", codelist);
		resultMap.put("seclist", seclist);
		
		return new ModelAndView("site/site_view", "response", resultMap);
	}
	public ModelAndView slotRegist(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String slotid = StringUtil.isNull(request.getParameter("slotid"));
		String siteid = StringUtil.isNull(request.getParameter("siteid"));
		String secid = StringUtil.isNull(request.getParameter("secid"));
		String slotname = StringUtil.isNull(request.getParameter("slotname"));
		String slottag = StringUtil.isNull(request.getParameter("slottag"));
		String width = StringUtil.isNull(request.getParameter("width"));
		String height = StringUtil.isNull(request.getParameter("height"));
		String prtype = StringUtil.isNull(request.getParameter("prtype"));
		String memo= StringUtil.isNull(request.getParameter("memo"));
		System.out.println("memo="+memo);
		System.out.println("StringUtil.htmlEncode(memo)="+StringUtil.htmlEncode(memo));
	
		String userID = (String)SessionUtil.getAttribute("userID");
		
		Map<String, String> map = new HashMap<String, String>();
	    
		map.put("siteid", siteid);
		map.put("secid", secid);
		map.put("slotname", slotname.trim());
		map.put("prtype", prtype);
		map.put("slottag", slottag.trim());
		map.put("width", width.trim());
		map.put("height", height.trim());
		map.put("memo", StringUtil.htmlEncode(memo));
		if(slotid.equals("")) {
			map.put("insertdate", DateUtil.simpleDate2());
			map.put("insertuser", userID);
			slotid = String.valueOf(sitemgrFacade.addSlot(map));
		} else {
			map.put("slotid", slotid);
			map.put("updatedate", DateUtil.simpleDate2());
			map.put("updateuser", userID);
			sitemgrFacade.modSlot(map);
		}		
		return new ModelAndView("redirect:sitemgr.do?a=slotList&s_siteid="+siteid+"&s_secid="+secid, null);
	}
	
	public ModelAndView slotGroupList(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String s_width = StringUtil.isNull(request.getParameter("s_width"));
		String s_height = StringUtil.isNull(request.getParameter("s_height"));
		String s_type = StringUtil.isNull(request.getParameter("s_type"));
		String s_siteid = StringUtil.isNull(request.getParameter("s_siteid"));
		String page = StringUtil.isNull(request.getParameter("p"));
		String sch_column = StringUtil.isNull(request.getParameter("sch_column"));
		String sch_text = StringUtil.isNull(request.getParameter("sch_text"));
		sch_text = new String (sch_text.getBytes("8859_1"),"UTF-8");

		if (page.equals("")) {
			page = "1";
		}
		Integer max = Constant.PAGE_LIST_L;
		Integer skip = (Integer.parseInt(page)-1)*max;
		
		Map<String, String> map = new HashMap<String, String>();
	    
		map.put("siteid", s_siteid)	;
		map.put("width", s_width)	;
		map.put("height", s_height)	;
		map.put("prtype", s_type)	;
		map.put("skip", String.valueOf(skip))	;
		map.put("max", String.valueOf(max))	;
		map.put("sch_text", sch_text);
		map.put("sch_column", sch_column);
		map.put("page","Y");
		Integer totalCount = sitemgrFacade.getSlgroupCnt(map);
		List<Map<String, String>> grouplist = sitemgrFacade.getSlgroupList(map);

		map.clear();
		map.put("order_str", "sitename");
		List<Map<String, String>> sitelist = sitemgrFacade.getSiteList(map);
		
		map.clear();
		map.put("order_str", "secname");
		List<Map<String, String>> seclist = sitemgrFacade.getSectionList(map);
		
		//광고상품 목록
		map.clear();
		map.put("code", "prtype");
		List<Map<String, String>> codelist = cpmgrFacade.getCodeList(map);	

		Map<String, Object> resultMap = new HashMap<String, Object>();		
		resultMap.put("sitelist", sitelist);
		resultMap.put("seclist", seclist);
		resultMap.put("grouplist", grouplist);
		resultMap.put("codelist", codelist);
		
		resultMap.put("skip", skip);
		resultMap.put("max", max);
		resultMap.put("totalCount", totalCount);
		resultMap.put("countPerPage", Constant.PAGE_LIST_L);
		resultMap.put("nowPage", page);		
		return new ModelAndView("site/slotgroup_list", "response", resultMap);
	}
	
	public ModelAndView slotGroupRegist(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String groupid = StringUtil.isNull(request.getParameter("groupid"));	
		String groupname = StringUtil.isNull(request.getParameter("groupname"));	
		String width = StringUtil.isNull(request.getParameter("width"));
		String height = StringUtil.isNull(request.getParameter("height"));
		String memo= StringUtil.isNull(request.getParameter("memo"));
		String prtype = StringUtil.isNull(request.getParameter("prtype"));
		
		
		
		String userID = (String)SessionUtil.getAttribute("userID");
		
		Map<String, String> map = new HashMap<String, String>();
	    
		map.put("groupname", groupname);
		map.put("width", width.trim());
		map.put("height", height.trim());
		map.put("prtype", prtype);
		map.put("memo", StringUtil.htmlEncode(memo));
		if(groupid.equals("")) {
			map.put("insertdate", DateUtil.simpleDate2());
			map.put("insertuser", userID);
			groupid = String.valueOf(sitemgrFacade.addSlgroup(map));
		} else {
			map.put("groupid", groupid);
			map.put("updatedate", DateUtil.simpleDate2());
			map.put("updateuser", userID);
			sitemgrFacade.modSlgroup(map);
			sitemgrFacade.modSlgroupSlot(map); // 상태 0으로 변경
		}				
		
		/********************** 그룹내 슬롯 저장 ***************************/
		try{
			String slotid[] = request.getParameterValues("slotid");
System.out.println("slotid.length----------------------------"+slotid.length);
			ArrayList<Map<String,String>> list = new ArrayList<Map<String,String>>();
			
			for(int i=0; i<slotid.length;i++)
			{
				Map<String, String> ipmap = new HashMap<String, String>();
				
				ipmap.put("groupid", groupid.toString());
				ipmap.put("slotid", slotid[i].trim());
				ipmap.put("insertdate", DateUtil.simpleDate2());
				ipmap.put("insertuser", userID);		
				 					
				System.out.println(i+") Map : " + ipmap);
				list.add(ipmap);									
			}			
			sitemgrFacade.addSlgroupSlot(list);

		} catch(Exception e) {		
			Map<String, String> dmap = new HashMap<String, String>();
			dmap.put("groupid", groupid.toString());
			sitemgrFacade.delSlgroup(dmap);

			System.out.println(e.getMessage());			
			response.setCharacterEncoding("EUC-KR"); 
			Writer w = response.getWriter();
			w.write("<script>"); 
			w.write("alert('저장 중 오류가 발생했습니다.');"); 
			w.write("history.back();"); 
			w.write("</script>"); 
			return null; 
		}
		if(!groupid.equals("")) {		
			sitemgrFacade.delSlgroupSlot(map); // 상태 0 슬롯 삭제
		}
		
		
		return new ModelAndView("redirect:sitemgr.do?a=slotGroupList", null);
	}
}
