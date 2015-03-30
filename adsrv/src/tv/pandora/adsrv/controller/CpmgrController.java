package tv.pandora.adsrv.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
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
import tv.pandora.adsrv.domain.Creative;
import tv.pandora.adsrv.domain.Target;
import tv.pandora.adsrv.domain.User;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

public class CpmgrController extends AdsrvMultiActionController
{
	
	public ModelAndView cpAddForm(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		Map<String, String> map = new HashMap<String, String>();	
		map.put("ismgr", "1");
		List<User> tclist = usermgrFacade.getUserList(map);
		/*
		
		map.put("corptype", "M");
		map.put("stat", "1");
		List<Map<String, String>> clientlist = cpmgrFacade.getAutoCorpList(map);	
		map.clear();
		map.put("corptype", "A");
		map.put("stat", "1");
		List<Map<String, String>> agencylist = cpmgrFacade.getAutoCorpList(map);	
		map.clear();
		map.put("corptype", "R");
		map.put("stat", "1");
		List<Map<String, String>> medreplist = cpmgrFacade.getAutoCorpList(map);
		*/	
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		//resultMap.put("clientlist", clientlist);
		//resultMap.put("agencylist", agencylist);
		//resultMap.put("medreplist", medreplist);
		resultMap.put("tclist", tclist);
		return new ModelAndView("campaign/cp_addform", "response", resultMap);
	}
	public ModelAndView cpEditForm(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String cpid = StringUtil.isNull(request.getParameter("cpid"));

		Map<String, String> map = new HashMap<String, String>();	
		
		List<User> tclist = usermgrFacade.getUserList(map);
		
		map.put("cpid", cpid);
		
		Campaign cpinfo = cpmgrFacade.getCampaign(map);	
			
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("cpinfo", cpinfo);
		resultMap.put("tclist", tclist);
		
		return new ModelAndView("campaign/cp_editform", "response", resultMap);
	}
	
	public ModelAndView cpRegist(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String preurl = request.getHeader("referer");
		
		System.out.print("-----------preurl="+preurl);
		
		String userID = (String)SessionUtil.getAttribute("userID");
		
		String cpname = StringUtil.isNull(request.getParameter("cpname"));
		String startdate = StringUtil.isNull(request.getParameter("startdate"));
		String enddate = StringUtil.isNull(request.getParameter("enddate"));
		String clientid = StringUtil.isNull(request.getParameter("clientid"));
		String agencyid = StringUtil.isNull(request.getParameter("agencyid"));
		String medrepid = StringUtil.isNull(request.getParameter("medrepid"));
		String tcid = StringUtil.isNull(request.getParameter("tcid"));
		String budget = StringUtil.isNull(request.getParameter("budget"));
		String memo = StringUtil.isNull(request.getParameter("memo"));
		
		
		Map<String, String> map = new HashMap<String, String>();	
		map.put("cpname", cpname);
		map.put("startdate", StringUtil.DateStr(startdate));
		map.put("enddate", StringUtil.DateStr(enddate));
		map.put("clientid", clientid);
		map.put("agencyid", agencyid);
		map.put("medrepid", medrepid);
		map.put("tcid", tcid);
		map.put("memo", StringUtil.htmlEncode(memo));
		map.put("budget", StringUtil.delcomma(budget));		
		map.put("insertdate", DateUtil.simpleDate2());
		map.put("insertuser", userID);
		
		
		Integer cpid = cpmgrFacade.addCampaign(map);	
			
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("cpid", cpid);
		
		return new ModelAndView("redirect:cpmgr.do?a=adsAddform&cpid="+cpid, resultMap);
	}	
	public ModelAndView cpView(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String cpid = StringUtil.isNull(request.getParameter("cpid"));
		
		
		
		Map<String, String> map = new HashMap<String, String>();	
		map.put("cpid", cpid);
		
		Campaign cpinfo = cpmgrFacade.getCampaign(map);	
			
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("cpinfo", cpinfo);
		
		return new ModelAndView("campaign/cp_view", "response", resultMap);
	}		
	public ModelAndView adsAddForm(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String cpid = StringUtil.isNull(request.getParameter("cpid"));
		
		Map<String, String> map = new HashMap<String, String>();	
		
		//캠페인 기본 정보
		map.put("cpid", cpid.toString());		
		Campaign cp = cpmgrFacade.getCampaign(map);	
		
		//애즈 선택 옵션 목록
		map.put("tbname", "ads");
		List<Map<String, String>> codelist = cpmgrFacade.getCodeList(map);	
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("cp", cp);
		resultMap.put("codelist", codelist);
		//resultMap.put("medreplist", medreplist);

		return new ModelAndView("campaign/ads_addform", "response", resultMap);
	}
	public ModelAndView adsRegist(HttpServletRequest request, HttpServletResponse response) throws Exception {			
		
		String adsname    = StringUtil.isNull(request.getParameter("adsname"   ));
		String cpid       = StringUtil.isNull(request.getParameter("cpid"      ));
		String startdate  = StringUtil.isNull(request.getParameter("startdate" ));
		String start_hour  = StringUtil.isNullZero(request.getParameter("start_hour" ));
		String start_min  = StringUtil.isNullZero(request.getParameter("start_min" ));
		String enddate    = StringUtil.isNull(request.getParameter("enddate"   ));
		String end_hour  = StringUtil.isNullZero(request.getParameter("end_hour" ));
		String end_min  = StringUtil.isNullZero(request.getParameter("end_min" ));
		String goaltype   = StringUtil.isNull(request.getParameter("goaltype"  ));
		String period     = StringUtil.isNull(request.getParameter("period"    ));
		String salestype  = StringUtil.isNull(request.getParameter("salestype" ));
		String prtype     = StringUtil.isNull(request.getParameter("prtype"    ));
		String budget     = StringUtil.isNullZero(request.getParameter("budget"    ));
		String book_total = StringUtil.isNullZero(request.getParameter("book_total"));
		String goal_total = StringUtil.isNullZero(request.getParameter("goal_total"));
		String goal_daily = StringUtil.isNullZero(request.getParameter("goal_daily"));

		String userID = (String)SessionUtil.getAttribute("userID");

		
		Map<String, String> map = new HashMap<String, String>();	
		map.put("adsname", adsname);
		map.put("cpid", cpid);

		map.put("startdate", StringUtil.DateStr(startdate));
		map.put("start_hour", start_hour);
		map.put("start_min", start_min);
		map.put("enddate", StringUtil.DateStr(enddate));
		map.put("end_hour", end_hour);
		map.put("end_min", end_min);
		
		map.put("goaltype", goaltype);
		map.put("period", period);
		map.put("salestype", salestype);
		map.put("prtype", prtype);
		
		map.put("budget", StringUtil.delcomma(budget));	
		map.put("book_total", StringUtil.delcomma(book_total));	
		map.put("goal_total", StringUtil.delcomma(goal_total));	
		map.put("goal_daily", StringUtil.delcomma(goal_daily));	
		
		map.put("insertdate", DateUtil.simpleDate2());
		map.put("insertuser", userID);
		
		
		Integer adsid = cpmgrFacade.addAds(map);	
			
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("cpid", cpid);
		
		return new ModelAndView("redirect:cpmgr.do?a=adsInfo&adsid="+adsid, resultMap);
	}	
	public ModelAndView cpAdsList(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String cpid = StringUtil.isNull(request.getParameter("cpid"));
		
		Map<String, String> map = new HashMap<String, String>();	
		
		//캠페인 기본 정보
		map.put("cpid", cpid.toString());		
		Campaign cp = cpmgrFacade.getCampaign(map);	
		
		map.put("stat", "1");				
		List<Ads> adslist = cpmgrFacade.getAdsList(map);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("cp", cp);
		resultMap.put("adslist", adslist);

		return new ModelAndView("campaign/cp_ads_list", "response", resultMap);
	}
	public ModelAndView adsEditForm(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		
		String adsid = StringUtil.isNull(request.getParameter("adsid"));
		Map<String, String> map = new HashMap<String, String>();
		
		//애즈정보
		map.put("adsid", adsid);		
		Ads ads = cpmgrFacade.getAds(map);	
		
		//캠페인 기본 정보
		map.put("cpid", ads.getAdsid());		
		Campaign cp = cpmgrFacade.getCampaign(map);	
		
		//애즈 선택 옵션 목록
		map.put("tbname", "ads");
		List<Map<String, String>> codelist = cpmgrFacade.getCodeList(map);	
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("cp", cp);
		resultMap.put("ads", ads);
		resultMap.put("codelist", codelist);

		return new ModelAndView("campaign/ads_editform", "response", resultMap);
	}
	public ModelAndView adsInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String adsid = StringUtil.isNull(request.getParameter("adsid"));
		
		Map<String, String> map = new HashMap<String, String>();	
		
		

		
		map.put("adsid", adsid);		
		Ads ads = cpmgrFacade.getAds(map);	
		
		map.put("cpid", ads.getCpid());		
		Campaign cp = cpmgrFacade.getCampaign(map);	

		
		map.put("stat", "1");				
		List<Ads> adslist = cpmgrFacade.getAdsList(map);

		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("cp", cp);
		resultMap.put("ads", ads);
		resultMap.put("adslist", adslist);

		return new ModelAndView("campaign/ads_info", "response", resultMap);
	}
	public ModelAndView auto_corp(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("----------------------------------auto_corp---------------------------");
		String corptype = StringUtil.isNull(request.getParameter("corptype"));
		System.out.println("corptype="+corptype);
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("corptype", corptype);
		map.put("stat", "1");
		 List<Map<String, String>> corplist = cpmgrFacade.getAutoCorpList(map);	
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("corplist", corplist);
		
		return new ModelAndView("common/auto_corp", "response", resultMap);		
	}
	
	
	public ModelAndView cpList(HttpServletRequest request, HttpServletResponse response) throws Exception {		
		String startday = StringUtil.isNull(request.getParameter("startday"));
		String endday = StringUtil.isNull(request.getParameter("endday"));
		String agent = StringUtil.isNull(request.getParameter("agent"));
		String agency = StringUtil.isNull(request.getParameter("agency"));
		String status = StringUtil.isNull(request.getParameter("status"));
		String page = StringUtil.isNull(request.getParameter("p"));
		String sch_column = StringUtil.isNull(request.getParameter("sch_column"));
		String sch_text = StringUtil.isNull(request.getParameter("sch_text"));
		
			
		String yymm = "";
		
		String userType = (String)SessionUtil.getAttribute("userType");
		String userID = (String)SessionUtil.getAttribute("userID");
		
		if (page.equals("")) {
			page = "1";
		}
		Integer max = Constant.PAGE_LIST_L;
		Integer skip = (Integer.parseInt(page)-1)*max;

		
	
		Map<String, String> map = new HashMap<String, String>();

		map.put("skip", String.valueOf(skip))	;
		map.put("max", String.valueOf(max))	;
		map.put("sch_text", sch_text);
		map.put("sch_column", sch_column);		
		List<Campaign> cplist  = cpmgrFacade.getCpList(map);
		Integer totalCount = cpmgrFacade.getCpCnt(map);
		
		

	
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("cplist", cplist);
		resultMap.put("skip", skip);
		resultMap.put("max", max);
		resultMap.put("totalCount", totalCount);
		//resultMap.put("countPerPage", Constant.PAGE_LIST_L);
		resultMap.put("nowPage", page);		

		
		return new ModelAndView("campaign/cp_list", "response", resultMap);
	}	
	public ModelAndView targetList(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String targettype = StringUtil.isNull(request.getParameter("targettype"));
		String page = StringUtil.isNullReplace(request.getParameter("p"),"1");
		String sch_column = StringUtil.isNull(request.getParameter("sch_column"));
		String sch_text = StringUtil.isNull(request.getParameter("sch_text"));

		Integer max = Constant.PAGE_LIST_L;
		Integer skip = (Integer.parseInt(page)-1)*max;
		
		Map<String, String> map = new HashMap<String, String>();
	    
		map.put("targettype", targettype)	;
		map.put("skip", String.valueOf(skip))	;
		map.put("max", String.valueOf(max))	;
		map.put("sch_text", sch_text);
		map.put("sch_column", sch_column);
		Integer totalCount = cpmgrFacade.getTargetCnt(map);
		List<Map<String, String>> targetlist = cpmgrFacade.getTargetList(map);
		
		// 선택 옵션 목록
		map.clear();
		map.put("tbname", "target");
		List<Map<String, String>> codelist = cpmgrFacade.getCodeList(map);
		
		

		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("codelist", codelist);
		resultMap.put("targetlist", targetlist);
		resultMap.put("skip", skip);
		resultMap.put("max", max);
		resultMap.put("totalCount", totalCount);
		resultMap.put("nowPage", page);		
		return new ModelAndView("campaign/target_list", "response", resultMap);
	}
	
	public ModelAndView targetForm(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		String tgtype = StringUtil.isNullReplace(request.getParameter("tgtype"), "1");
		
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("tbname", "target");
		List<Map<String, String>> codelist = cpmgrFacade.getCodeList(map);
		
		map.clear();
		map.put("targettype", tgtype);
		List<Map<String, String>> tgcodelist = cpmgrFacade.getTargetCodeList(map);
		
		String jsp = tgcodelist.get(0).get("text")+"_view";
		String menu = tgcodelist.get(0).get("isname");
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		//채널타겟팅 사이트/섹션/위치 목록
		if(tgtype.equals("5"))
		{
		
			map.clear();
			map.put("order_str", "slotname");
			List<Map<String, String>> slotlist = sitemgrFacade.getSlotList(map);	
			map.clear();
			map.put("order_str", "sitename");
			List<Map<String, String>> sitelist = sitemgrFacade.getSiteList(map);			
			map.clear();
			map.put("order_str", "secname");
			List<Map<String, String>> seclist = sitemgrFacade.getSectionList(map);		
			
			resultMap.put("slotlist", slotlist);
			resultMap.put("sitelist", sitelist);
			resultMap.put("seclist", seclist);
		}
		
		resultMap.put("codelist", codelist);
		resultMap.put("tgcodelist", tgcodelist);
		resultMap.put("menu", menu);
		resultMap.put("jsp", jsp);
		resultMap.put("mode", "R");
		
		return new ModelAndView("campaign/target_"+jsp, "response", resultMap);
	}
	
	public ModelAndView targetView(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		String tid = StringUtil.isNullZero(request.getParameter("tid"));
				
		Map<String, String> map = new HashMap<String, String>();
		map.put("tid", tid);
		Target tginfo = cpmgrFacade.getTarget(map);
		
		Integer tgtype = tginfo.getTargettype();
		String tgmenu = tginfo.getTargetmenu();
		
		
		map.put("tbname", "target");
		List<Map<String, String>> codelist = cpmgrFacade.getCodeList(map);
		
		map.clear();
		map.put("targettype", tgtype.toString());
		List<Map<String, String>> tgcodelist = cpmgrFacade.getTargetCodeList(map);		
		
		
		String menu = tgcodelist.get(0).get("isname");	
				
		Map<String, String> amap = new HashMap<String, String>();		
		amap.put("tid", tid);
		amap.put("tgtype", tgtype.toString());
		amap.put("tgmenu", tgmenu);
		
		Target valueinfo = null;
		List<Target> valuelist = null;
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		// 시스템, 카테고리, 국가 타겟팅
		if(tgtype==1 || tgtype==3 || tgtype==4){					
			valueinfo = cpmgrFacade.getTargetValue(amap);
		} 
		// 채널 타겟팅
		else if(tgtype==5){			
			valueinfo = cpmgrFacade.getTargetValue(amap);
			valuelist = cpmgrFacade.getTargetValList(amap);
			
			map.clear();
			map.put("order_str", "slotname");
			List<Map<String, String>> slotlist = sitemgrFacade.getSlotList(map);	
			map.clear();
			map.put("order_str", "sitename");
			List<Map<String, String>> sitelist = sitemgrFacade.getSiteList(map);			
			map.clear();
			map.put("order_str", "secname");
			List<Map<String, String>> seclist = sitemgrFacade.getSectionList(map);		
			
			resultMap.put("slotlist", slotlist);
			resultMap.put("sitelist", sitelist);
			resultMap.put("seclist", seclist);

			
		} // IP 타겟팅 
		else if(tgtype==2 ){			
			valuelist = cpmgrFacade.getTargetValList(amap);
		} 		
		resultMap.put("tginfo", tginfo);
		resultMap.put("valueinfo", valueinfo);
		resultMap.put("valuelist", valuelist);
		resultMap.put("codelist", codelist);
		resultMap.put("tgcodelist", tgcodelist);
		resultMap.put("menu", menu);
		resultMap.put("mode", "E");
		resultMap.put("tid", tid);
		
		
		return new ModelAndView("campaign/target_"+tgmenu+"_view", "response", resultMap);
	}
	public ModelAndView targetUpdate(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		String tid = StringUtil.isNull(request.getParameter("tid"));
		String tgtype = StringUtil.isNullReplace(request.getParameter("tgtype"), "1");
		String targetname = StringUtil.isNull(request.getParameter("targetname"));
		
		String userID = (String)SessionUtil.getAttribute("userID");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("tid", tid);
		map.put("targetname", targetname);
		map.put("updateuser", userID);
		cpmgrFacade.modTarget(map);
		
		
		Map<String, String> amap = new HashMap<String, String>();		
		
		// 시스템 타겟팅
		if(tgtype.equals("1")){		
			String freqday = StringUtil.isNullZero(request.getParameter("freqday"));
			String freqcap = StringUtil.isNullZero(request.getParameter("freqcap"));
			String day = StringUtil.isNullZero(request.getParameter("day"));
			String browser = StringUtil.isNullZero(request.getParameter("browser"));
			String time = StringUtil.isNullZero(request.getParameter("time"));		
			amap.put("tid", tid);
			amap.put("freqday", freqday);
			amap.put("freqcap", freqcap);
			amap.put("day", day);
			amap.put("browser", browser);
			amap.put("time", time);
			cpmgrFacade.modTargetSystem(amap);
		} 
		// IP 타겟팅
		else if(tgtype.equals("2")){
			
			String[] ip_from = request.getParameterValues("ip_from");
			String[] ip_to = request.getParameterValues("ip_to");
			String[] ip_alias = request.getParameterValues("ip_alias");
			
			
			
			ArrayList<Map<String,String>> list = new ArrayList<Map<String,String>>();
			
			for(int i=0; i<ip_from.length;i++){
				if(!StringUtil.isNull(ip_from[i].trim()).equals("")) {
					
			         Map<String, String> ipmap = new HashMap<String, String>();

			         ipmap.put("tid", tid);
			         ipmap.put("ip_from", ip_from[i].trim());
			         ipmap.put("ip_to", ip_to[i].trim());
			         ipmap.put("ip_alias", StringUtil.isNull(ip_alias[i].trim()));
					
					System.out.println(i+") Map : " + ipmap);
					list.add(ipmap);					
				}
			}
			cpmgrFacade.modTargetIP(map);			
			cpmgrFacade.addTargetIP(list);
			cpmgrFacade.delTargetIP(map);			
		} 
		// 카테고리 타겟팅
		else if(tgtype.equals("3")){
			String category = StringUtil.isNullZero(request.getParameter("category"));
			amap.put("tid", tid.toString());
			amap.put("category", category);
			cpmgrFacade.modTargetCategory(amap);
		} 
		// 국가 타겟팅
		else if(tgtype.equals("4")){
			String excflag = StringUtil.isNullZero(request.getParameter("excflag"));
			String country1 = StringUtil.isNullZero(request.getParameter("country1"));
			String country2 = StringUtil.isNullZero(request.getParameter("country2"));
			String country3 = StringUtil.isNullZero(request.getParameter("country3"));
			String country4 = StringUtil.isNullZero(request.getParameter("country4"));
			String country5 = StringUtil.isNullZero(request.getParameter("country5"));
			String country6 = StringUtil.isNullZero(request.getParameter("country6"));
			String country7 = StringUtil.isNullZero(request.getParameter("country7"));
			String country8 = StringUtil.isNullZero(request.getParameter("country8"));
			
			amap.put("tid", tid.toString());
			amap.put("excflag", excflag);
			amap.put("country1", country1);
			amap.put("country2", country2);
			amap.put("country3", country3);
			amap.put("country4", country4);
			amap.put("country5", country5);
			amap.put("country6", country6);
			amap.put("country7", country7);
			amap.put("country8", country8);
			
			cpmgrFacade.modTargetCountry(amap);
			
		}
		//채널 타겟팅
		else if(tgtype.equals("5")){
			String excflag = StringUtil.isNullZero(request.getParameter("excflag"));
			String slotid = StringUtil.isNullZero(request.getParameter("slotid"));
			amap.put("tid", tid.toString());
			amap.put("excflag", excflag);
			amap.put("slotid", slotid);
		
			//Integer cid = cpmgrFacade.addTargetChannel(amap);
			
			String[] channelid = request.getParameterValues("channelid");
			String[] channelname = request.getParameterValues("channelname");
			
			ArrayList<Map<String,String>> list = new ArrayList<Map<String,String>>();
			
			for(int i=0; i<channelid.length;i++){
				if(!StringUtil.isNull(channelid[i].trim()).equals("")) {
					
			         Map<String, String> ipmap = new HashMap<String, String>();

			         ipmap.put("tid", tid.toString());
			         //ipmap.put("cid", cid.toString());
			         ipmap.put("channelid", channelid[i].trim());
			         ipmap.put("channelname", StringUtil.isNull(channelname[i].trim()));
					 list.add(ipmap);					
				}
			}
			cpmgrFacade.modTargetChannelID(map);			
			cpmgrFacade.addTargetChannelID(list);
			cpmgrFacade.delTargetChannelID(map);			
		}		
		return new ModelAndView("redirect:cpmgr.do?a=targetView&tid="+tid, null);
	}	
	public ModelAndView targetRegist(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		String tgtype = StringUtil.isNullReplace(request.getParameter("tgtype"), "1");
		String targetname = StringUtil.isNull(request.getParameter("targetname"));
		
		String userID = (String)SessionUtil.getAttribute("userID");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("targettype", tgtype);
		map.put("targetname", targetname);
		map.put("updateuser", userID);
		Integer tid = cpmgrFacade.addTarget(map);
		
		
		Map<String, String> amap = new HashMap<String, String>();		
		
		// 시스템 타겟팅
		if(tgtype.equals("1")){		
			String freqday = StringUtil.isNullZero(request.getParameter("freqday"));
			String freqcap = StringUtil.isNullZero(request.getParameter("freqcap"));
			String day = StringUtil.isNullZero(request.getParameter("day"));
			String browser = StringUtil.isNullZero(request.getParameter("browser"));
			String time = StringUtil.isNullZero(request.getParameter("time"));		
			amap.put("tid", tid.toString());
			amap.put("freqday", freqday);
			amap.put("freqcap", freqcap);
			amap.put("day", day);
			amap.put("browser", browser);
			amap.put("time", time);
			cpmgrFacade.addTargetSystem(amap);
		} 
		// IP 타겟팅
		else if(tgtype.equals("2")){
			
			String[] ip_from = request.getParameterValues("ip_from");
			String[] ip_to = request.getParameterValues("ip_to");
			String[] ip_alias = request.getParameterValues("ip_alias");
			
			ArrayList<Map<String,String>> list = new ArrayList<Map<String,String>>();
			
			for(int i=0; i<ip_from.length;i++){
				if(!StringUtil.isNull(ip_from[i].trim()).equals("")) {
					
			         Map<String, String> ipmap = new HashMap<String, String>();

			         ipmap.put("tid", tid.toString());
			         ipmap.put("ip_from", ip_from[i].trim());
			         ipmap.put("ip_to", ip_to[i].trim());
			         ipmap.put("ip_alias", StringUtil.isNull(ip_alias[i].trim()));
					
					System.out.println(i+") Map : " + ipmap);
					list.add(ipmap);					
				}
			}
		} 
		// 카테고리 타겟팅
		else if(tgtype.equals("3")){
			String category = StringUtil.isNullZero(request.getParameter("category"));
			amap.put("tid", tid.toString());
			amap.put("category", category);
			cpmgrFacade.addTargetCategory(amap);
		} 
		// 국가 타겟팅
		else if(tgtype.equals("4")){
			String excflag = StringUtil.isNullZero(request.getParameter("excflag"));
			String country1 = StringUtil.isNullZero(request.getParameter("country1"));
			String country2 = StringUtil.isNullZero(request.getParameter("country2"));
			String country3 = StringUtil.isNullZero(request.getParameter("country3"));
			String country4 = StringUtil.isNullZero(request.getParameter("country4"));
			String country5 = StringUtil.isNullZero(request.getParameter("country5"));
			String country6 = StringUtil.isNullZero(request.getParameter("country6"));
			String country7 = StringUtil.isNullZero(request.getParameter("country7"));
			String country8 = StringUtil.isNullZero(request.getParameter("country8"));
			
			amap.put("tid", tid.toString());
			amap.put("excflag", excflag);
			amap.put("country1", country1);
			amap.put("country2", country2);
			amap.put("country3", country3);
			amap.put("country4", country4);
			amap.put("country5", country5);
			amap.put("country6", country6);
			amap.put("country7", country7);
			amap.put("country8", country8);
			
			cpmgrFacade.addTargetCountry(amap);
			
		}
		//채널 타겟팅
		else if(tgtype.equals("5")){
			String excflag = StringUtil.isNullZero(request.getParameter("excflag"));
			String slotid = StringUtil.isNullZero(request.getParameter("slotid"));
			amap.put("tid", tid.toString());
			amap.put("excflag", excflag);
			amap.put("slotid", slotid);
		
			cpmgrFacade.addTargetChannel(amap);
			
			String[] channelid = request.getParameterValues("channelid");
			String[] channelname = request.getParameterValues("channelname");
			
			ArrayList<Map<String,String>> list = new ArrayList<Map<String,String>>();
			
			for(int i=0; i<channelid.length;i++){
				if(!StringUtil.isNull(channelid[i].trim()).equals("")) {
					
			         Map<String, String> ipmap = new HashMap<String, String>();

			         ipmap.put("tid", tid.toString());
			         ipmap.put("channelid", channelid[i].trim());
			         ipmap.put("channelname", StringUtil.isNull(channelname[i].trim()));
					 list.add(ipmap);					
				}
			}
			cpmgrFacade.addTargetChannelID(list);
		}		
		return new ModelAndView("redirect:cpmgr.do?a=targetList", null);
	}	
	public ModelAndView tmpList(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String page = StringUtil.isNullReplace(request.getParameter("p"),"1");
		String sch_column = StringUtil.isNull(request.getParameter("sch_column"));
		String sch_text = StringUtil.isNull(request.getParameter("sch_text"));

		Integer max = Constant.PAGE_LIST_L;
		Integer skip = (Integer.parseInt(page)-1)*max;
		
		Map<String, String> map = new HashMap<String, String>();
	    
		map.put("skip", String.valueOf(skip))	;
		map.put("max", String.valueOf(max))	;
		map.put("sch_text", sch_text);
		map.put("sch_column", sch_column);
		Integer totalCount = cpmgrFacade.getTemplateCnt(map);
		List<Map<String, String>> tmplist = cpmgrFacade.getTemplateList(map);
		

		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("tmplist", tmplist);
		resultMap.put("skip", skip);
		resultMap.put("max", max);
		resultMap.put("totalCount", totalCount);
		resultMap.put("nowPage", page);		
		return new ModelAndView("campaign/template_list", "response", resultMap);
	}
	public ModelAndView tmpForm(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		Map<String, Object> resultMap = new HashMap<String, Object>();		
		resultMap.put("mode", "R");
		return new ModelAndView("campaign/template_form", "response", resultMap);
	}
	public ModelAndView tmpView(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		String tmpid = StringUtil.isNull(request.getParameter("tmpid"));
		
		Map<String, String> map = new HashMap<String, String>();
	    
		map.put("tmpid", tmpid);
		
		Map<String, String> tmp = cpmgrFacade.getTemplate(map);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();		
		resultMap.put("tmp", tmp);
		resultMap.put("tmpid", tmpid);
		resultMap.put("mode", "E");

		return new ModelAndView("campaign/template_form", "response", resultMap);
	}
	public ModelAndView tmpSave(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String mode = StringUtil.isNull(request.getParameter("mode"));
		String tmpid = StringUtil.isNull(request.getParameter("tmpid"));
		String tmpname = StringUtil.isNull(request.getParameter("tmpname"));
		String tmpcode = StringUtil.isNull(request.getParameter("tmpcode"));
		String memo = StringUtil.isNull(request.getParameter("memo"));
		
		String userID = (String)SessionUtil.getAttribute("userID");
		
		Map<String, String> map = new HashMap<String, String>();
	    
		map.put("tmpname", tmpname);
		map.put("memo", memo);
		map.put("tmpcode", StringUtil.encodeURIComponent(tmpcode));
		map.put("userid", userID);
		if(!tmpid.equals("") && mode.equals("E")) {
			map.put("tmpid", tmpid);				
			cpmgrFacade.modTemplate(map);
		} else {
			cpmgrFacade.addTemplate(map);
		}
		
		
		return new ModelAndView("redirect:cpmgr.do?a=tmpList", null);
	}
	public ModelAndView crList(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String stat = StringUtil.isNull(request.getParameter("stat"));
		String sday = StringUtil.isNull(request.getParameter("sday"));
		String eday = StringUtil.isNull(request.getParameter("eday"));
		String width = StringUtil.isNull(request.getParameter("width"));
		String height = StringUtil.isNull(request.getParameter("height"));
		String page = StringUtil.isNullReplace(request.getParameter("p"),"1");
		String sch_column = StringUtil.isNull(request.getParameter("sch_column"));
		String sch_text = StringUtil.isNull(request.getParameter("sch_text"));

		Integer max = Constant.PAGE_LIST_L;
		Integer skip = (Integer.parseInt(page)-1)*max;
		
		Map<String, String> map = new HashMap<String, String>();
	    
		map.put("cr_state", stat);
		map.put("sday", sday);
		map.put("eday", eday);
		map.put("width", width);
		map.put("height", height);
		map.put("skip", String.valueOf(skip))	;
		map.put("max", String.valueOf(max))	;
		map.put("sch_text", sch_text);
		map.put("sch_column", sch_column);
		Integer totalCount = cpmgrFacade.getCreativeCnt(map);
		List<Creative> crlist = cpmgrFacade.getCreativeList(map);
		
		//광고상품 목록
		map.put("code", "prtype");
		List<Map<String, String>> codelist = cpmgrFacade.getCodeList(map);	
		
		//상태 목록
		map.put("code", "cr_state");
		List<Map<String, String>> stlist = cpmgrFacade.getCodeList(map);	
		

		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("crlist", crlist);
		resultMap.put("codelist", codelist);
		resultMap.put("stlist", stlist);
		resultMap.put("skip", skip);
		resultMap.put("max", max);
		resultMap.put("totalCount", totalCount);
		resultMap.put("nowPage", page);		
		return new ModelAndView("campaign/creative_list", "response", resultMap);
	}
	public ModelAndView crAddForm(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String clientid = StringUtil.isNull(request.getParameter("clientid"));
		
		Map<String, String> map = new HashMap<String, String>();	
		
		//광고상품 목록
		map.put("code", "prtype");
		List<Map<String, String>> codelist = cpmgrFacade.getCodeList(map);	

		map.clear();
		map.put("order_str", "tmpname")	;
		List<Map<String, String>> tmplist = cpmgrFacade.getTemplateList(map);
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("codelist", codelist);
		resultMap.put("tmplist", tmplist);

		return new ModelAndView("campaign/creative_addform", "response", resultMap);
	}/*
	public ModelAndView fileUpload(HttpServletRequest request, HttpServletResponse response) throws Exception {			
	{
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Iterator<String> iterator =  multipartRequest.getFileNames();
		Map fileMap = null;

			
		
		String sep = System.getProperty("file.separator");		
		String orign_filename = "";	
		String filename = "";
		
		String realpath = request.getRealPath("/files");
		String levpath = "leave"+"/"+yymm;
				
				
		boolean transresult = false;	
		boolean isReject = false;	

		String comment = "";
		
		int fno = 1;
		
		while(iterator.hasNext()) 
		{
			fileMap = (Map)multipartRequest.getFileMap();
			fno++;
			   
		    String fileParameterName = iterator.next();
		   
		    MultipartFile multipartFile =  (MultipartFile) fileMap.get(fileParameterName);
				
				orign_filename = multipartFile.getOriginalFilename();
				
				if (multipartFile != null && !multipartFile.isEmpty() && multipartFile.getSize()>0)
				{
					try
					{				
						File serverDir = new File(realpath+sep+levpath+sep);
					
			System.out.println("=  serverDir ==="+serverDir);	
						
						String extension = orign_filename.substring(orign_filename.lastIndexOf(".")+1,orign_filename.length());							
						filename = startday[0]+levtype+levid+userID+"_"+fno+"."+extension;		
								
			 System.out.println("=  filename ==="+filename);	
			 
			 String serverpath = realpath+sep+yymm+sep+filename;
					
				boolean chkext = new FileRepository().chkExtension1(extension);
				boolean chksize = new FileRepository().chkFileSize(multipartFile.getSize());
				
				if(!chkext)
				{
					comment = "파일 : "+orign_filename+"\n업로드 가능한 파일이 아닙니다.";	
					isReject = true;
					break;
				}
				else if(!chksize)
				{
					comment = "파일 : "+orign_filename+"\n파일 사이즈는 3M를 넘을 수 없습니다.";					
					isReject = true;
					break;
				}
				else
				{				
					transresult = new FileRepository().saveFile(multipartFile, serverDir, serverDir.getPath() + sep + filename);																						
				}
			System.out.println("=  transresult1 ==="+transresult);	
											
					if(transresult) 
					{
						//이미지 서버 싱크 프로그램 실행
						///*********** 로컬에서는 주석 처리 ******************
						//executeSyncCommand();
						
						map.put("levid", String.valueOf(levid));
						map.put("filepath", levpath+"/"+filename);
						map.put("filename", orign_filename);
						map.put("serverpath", levpath+sep+filename);
						map.put("updateuser",  userID);
						map.put("regdate",     DateUtil.simpleDate());
						map.put("updatedate",  DateUtil.simpleDate());
						adeFacade.addLeaveFile(map);						
					}
				} catch(Exception e) {
					transresult = false;
				}
			}	
		}
	}
	}*/
}
