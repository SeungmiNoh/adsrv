package tv.pandora.adsrv.controller;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.web.servlet.ModelAndView;

import tv.pandora.adsrv.common.Constant;
import tv.pandora.adsrv.common.session.SessionUtil;
import tv.pandora.adsrv.common.util.DateUtil;
import tv.pandora.adsrv.common.util.StringUtil;
import tv.pandora.adsrv.domain.Ads;
import tv.pandora.adsrv.domain.AdsReport;
import tv.pandora.adsrv.domain.Campaign;
import tv.pandora.adsrv.domain.ClickTime;
import tv.pandora.adsrv.domain.DayReport;
import tv.pandora.adsrv.domain.PrismReport;
import tv.pandora.adsrv.domain.Report;
import tv.pandora.adsrv.domain.SiteReport;
import tv.pandora.adsrv.domain.Slot;
import tv.pandora.adsrv.domain.User;

public class RptmgrController extends AdsrvMultiActionController {
	
	
	/******************************** 캠페인 리포트 ************************************/
	public ModelAndView cpRpt(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		String clientid = StringUtil.isNull(request.getParameter("clientid"));
		String sday = StringUtil.isNull(request.getParameter("sday"));
		String eday = StringUtil.isNull(request.getParameter("eday"));
		String state = StringUtil.isNull(request.getParameter("state"));
		String page = StringUtil.isNull(request.getParameter("p"));
		String sch_column = StringUtil.isNull(request.getParameter("sch_column"));
		String sch_text = StringUtil.isNull(request.getParameter("sch_text"));
		sch_text = new String (sch_text.getBytes("8859_1"),"UTF-8");
		
		System.out.println("clientid="+clientid);
		

			
		String yymm = "";
		
		String userType = (String)SessionUtil.getAttribute("userType");
		String userID = (String)SessionUtil.getAttribute("userID");
		
		if (page.equals("")) {
			page = "1";
		}
		Integer max = Constant.PAGE_LIST_L;
		Integer skip = (Integer.parseInt(page)-1)*max;

		
	
		Map<String, String> map = new HashMap<String, String>();
		map.put("cp_state", state)	;
		map.put("clientid", clientid)	;
		
		map.put("sday", sday);
		map.put("eday", eday);
		map.put("skip", String.valueOf(skip));
		map.put("max", String.valueOf(max))	;
		map.put("sch_text", sch_text);
		map.put("sch_column", sch_column);		
		
		map = userPerSet(map);
		
System.out.println("-------------------"+map);		
		List<Campaign> cplist  = cpmgrFacade.getCpList(map);
		Integer totalCount = cpmgrFacade.getCpCnt(map);
		map.clear();
		map.put("ismgr", "1");
		List<User> tclist = usermgrFacade.getUserList(map);
	
		//상태 목록
		map.put("code", "ads_state");
		List<Map<String, String>> stlist = cpmgrFacade.getCodeList(map);	

	
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("cplist", cplist);
		resultMap.put("stlist", stlist);
		resultMap.put("tclist", tclist);
		resultMap.put("skip", skip);
		resultMap.put("max", max);
		resultMap.put("totalCount", totalCount);
		resultMap.put("nowPage", page);		
		
		return new ModelAndView("report/cp_rptlist", "response", resultMap);
	}
	
	public ModelAndView summary(HttpServletRequest request, HttpServletResponse response) throws Exception {	
	
		Map<String, String[]> requestParams = request.getParameterMap();
		Map<String, String> map = setParamap(requestParams);	
		
		
		/************************** 공통 *****************************/
		// 캠페인 정보
		Campaign cp = cpmgrFacade.getCampaign(map);		
		if(StringUtil.isNull(map.get("sday")).equals("")) {
			map.put("sday", StringUtil.DateStr(cp.getStartdate()));
			map.put("eday", StringUtil.DateStr(cp.getEnddate()));
		}
		// 애즈리스트
		List<Ads> adslist = cpmgrFacade.getAdsList(map);	
		// 애즈리포트
		List<Report> adsrpt = rptmgrFacade.getAdsRpt(map);		
		Report adstotal = rptmgrFacade.getAdsRptTotal(map); //토탈
		// 광고물리포트
		List<Report> crrpt = rptmgrFacade.getCrRpt(map);		
		Report crtotal = rptmgrFacade.getCrRptTotal(map); //토탈		
	
		// 국가리포트
		List<Report> country = rptmgrFacade.getCountrySummary(map);		
		
		
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("cp", cp);
		/*********************************/
		resultMap.put("adslist", adslist);
		resultMap.put("adsrpt", adsrpt);
		resultMap.put("adstotal", adstotal);
		resultMap.put("crrpt", crrpt);
		resultMap.put("crtotal", crtotal);
		resultMap.put("country", country);
		resultMap.put("paramap", map);
				
		return new ModelAndView("report/cp_rpt_summary", "response", resultMap);
	}
	
	public ModelAndView adsRpt(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		Map<String, String[]> requestParams = request.getParameterMap();
		Map<String, String> map = setParamap(requestParams);	
		
		
		/************************** 공통 *****************************/
		// 캠페인 정보
		Campaign cp = cpmgrFacade.getCampaign(map);		
		if(StringUtil.isNull(map.get("sday")).equals("")) {
			map.put("sday", StringUtil.DateStr(cp.getStartdate()));
			map.put("eday", StringUtil.DateStr(cp.getEnddate()));
		}
		// 애즈리스트
		List<Ads> adslist = cpmgrFacade.getAdsList(map);	
		
		// 애즈리포트
		List<Report> adsrpt = rptmgrFacade.getAdsRpt(map);				
		Report adstotal = rptmgrFacade.getAdsRptTotal(map); //토탈		
		
		// 애즈 일자별 리포트
		List<Report> dayrpt = rptmgrFacade.getAdsDayRpt(map);	
		Report daytotal = rptmgrFacade.getAdsDayTotal(map); //토탈
		
		// 요일 목록
		map.put("code", "weekday");
		List<Map<String, String>> weekday = cpmgrFacade.getCodeList(map);		// 애즈 목록
		
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("cp", cp);
		/*********************************/
		resultMap.put("adslist", adslist);
		resultMap.put("adsrpt", adsrpt);
		resultMap.put("dayrpt", dayrpt);
		resultMap.put("weekday", weekday);
		resultMap.put("adstotal", adstotal);
		resultMap.put("daytotal", daytotal);
		resultMap.put("paramap", map);
		
		return new ModelAndView("report/cp_rpt_adsrpt", "response", resultMap);
	}	
	public ModelAndView crRpt(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		Map<String, String[]> requestParams = request.getParameterMap();
		Map<String, String> map = setParamap(requestParams);	
		
		
		/************************** 공통 *****************************/
		// 캠페인 정보
		Campaign cp = cpmgrFacade.getCampaign(map);		
		if(map.get("sday").equals("")) {
			map.put("sday", DateUtil.getYMD(cp.getStartdate()));
			map.put("eday", DateUtil.getYMD(cp.getEnddate()));
		}
		// 애즈리스트
		List<Ads> adslist = cpmgrFacade.getAdsList(map);	
		// 광고물리포트
		List<Report> crrpt = rptmgrFacade.getCrRpt(map);		
		Report crtotal = rptmgrFacade.getCrRptTotal(map); //토탈		
		// 광고물 일자별 리포트
		List<Report> dayrpt = rptmgrFacade.getAdsDayRpt(map);	
		Report daytotal = rptmgrFacade.getCrDayTotal(map); //토탈
		// 광고물 클릭별 리포트
		//List<Report> clickrpt = rptmgrFacade.getCrClickRpt(map);		
				
		
		// 요일 목록
		Map<String, String> map2 = new HashMap<String, String>();			
		map2.put("code", "weekday");
		List<Map<String, String>> weekday = cpmgrFacade.getCodeList(map2);		

		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("cp", cp);
		resultMap.put("adslist", adslist);
		/*********************************/
		resultMap.put("crrpt", crrpt);
		//resultMap.put("clickrpt", clickrpt);
		resultMap.put("crtotal", crtotal);
		resultMap.put("daytotal", daytotal);
		resultMap.put("dayrpt", dayrpt);
		resultMap.put("weekday", weekday);
		resultMap.put("paramap", map);
		
		return new ModelAndView("report/cp_rpt_creative", "response", resultMap);
	}
	
	public ModelAndView timeRpt(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		Map<String, String[]> requestParams = request.getParameterMap();
		Map<String, String> map = setParamap(requestParams);	
		
		
		/************************** 공통 *****************************/
		// 캠페인 정보
		Campaign cp = cpmgrFacade.getCampaign(map);		
		if(map.get("sday").equals("")) {
			map.put("sday", DateUtil.getYMD(cp.getStartdate()));
			map.put("eday", DateUtil.getYMD(cp.getEnddate()));
		}
		// 애즈리스트
		List<Ads> adslist = cpmgrFacade.getAdsList(map);	
		// 시간리포트
		List<Report> dayrpt = rptmgrFacade.getAdsTimeRpt(map);		
		Report daytotal = rptmgrFacade.getCrDayTotal(map); //토탈
		
		
		// 요일 목록
		Map<String, String> map2 = new HashMap<String, String>();			
		map2.put("code", "weekday");
		List<Map<String, String>> weekday = cpmgrFacade.getCodeList(map2);		

		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("cp", cp);
		resultMap.put("adslist", adslist);
		/*********************************/
		
		resultMap.put("daytotal", daytotal);
		resultMap.put("dayrpt", dayrpt);
		resultMap.put("weekday", weekday);
		resultMap.put("paramap", map);
		
		return new ModelAndView("report/cp_rpt_time", "response", resultMap);
	}	
	public ModelAndView countryRpt(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		Map<String, String[]> requestParams = request.getParameterMap();
		Map<String, String> map = setParamap(requestParams);	
		
		
		/************************** 공통 *****************************/
		// 캠페인 정보
		Campaign cp = cpmgrFacade.getCampaign(map);		
		if(map.get("sday").equals("")) {
			map.put("sday", DateUtil.getYMD(cp.getStartdate()));
			map.put("eday", DateUtil.getYMD(cp.getEnddate()));
		}
		// 애즈리스트
		List<Ads> adslist = cpmgrFacade.getAdsList(map);	
		// 시간리포트
		List<Report> rptlist = rptmgrFacade.getAdsCountryRpt(map);		
		List<Report> dayrpt = rptmgrFacade.getAdsCountryDaily(map);		
		Report daytotal = rptmgrFacade.getAdsCountryTotal(map); //토탈
		
		
		// 요일 목록
		Map<String, String> map2 = new HashMap<String, String>();			
		map2.put("code", "weekday");
		List<Map<String, String>> weekday = cpmgrFacade.getCodeList(map2);		

		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("cp", cp);
		resultMap.put("adslist", adslist);
		/*********************************/
		
		resultMap.put("daytotal", daytotal);
		resultMap.put("rptlist", rptlist);
		resultMap.put("dayrpt", dayrpt);
		resultMap.put("weekday", weekday);
		resultMap.put("paramap", map);
		
		return new ModelAndView("report/cp_rpt_country", "response", resultMap);
	}	
	public void crClickRpt(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		String cpid = StringUtil.isNull(request.getParameter("cpid"));
		String adsid = StringUtil.isNull(request.getParameter("adsid"));
		String crid = StringUtil.isNull(request.getParameter("crid"));
		String sday = StringUtil.isNull(request.getParameter("sday"));
		String eday = StringUtil.isNull(request.getParameter("eday"));
		System.out.println("adsDaily="+adsid);
		Map<String, String> map = new HashMap<String, String>();			
		
		/************************** 공통 *****************************/
		// 애즈 일자별 리포트
		map.put("cpid", cpid);
		map.put("adsid", adsid);
		map.put("crid", crid);
		map.put("sday", StringUtil.DateStr(sday));
		map.put("eday", StringUtil.DateStr(eday));
		List<Report> dayrpt = rptmgrFacade.getCrClickRpt(map);	
		
		JSONArray data = JSONArray.fromObject(dayrpt);

		response.setContentType("text/html;charset=utf-8");
		PrintWriter out=response.getWriter();
		out.print(JSONArray.fromObject(data).toString());  
		
		System.out.println(JSONArray.fromObject(data).toString());
	}	

	public void adsCountryDaily(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		String cpid = StringUtil.isNull(request.getParameter("cpid"));
		String adsid = StringUtil.isNull(request.getParameter("adsid"));
		String cno = StringUtil.isNull(request.getParameter("cno"));
		String sday = StringUtil.isNull(request.getParameter("sday"));
		String eday = StringUtil.isNull(request.getParameter("eday"));
		System.out.println("adsDaily="+adsid);
		Map<String, String> map = new HashMap<String, String>();			
		
		/************************** 공통 *****************************/
		// 애즈 일자별 리포트
		map.put("cpid", cpid);
		map.put("adsid", adsid);
		map.put("country", cno);
		map.put("sday", StringUtil.DateStr(sday));
		map.put("eday", StringUtil.DateStr(eday));
		List<Report> dayrpt = rptmgrFacade.getAdsCountryDaily(map);			
		
		JSONArray data = JSONArray.fromObject(dayrpt);

		response.setContentType("text/html;charset=utf-8");
		PrintWriter out=response.getWriter();
		out.print(JSONArray.fromObject(data).toString());  
		
		System.out.println(JSONArray.fromObject(data).toString());
	}
	public void getAdsCountryTotal(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		String cpid = StringUtil.isNull(request.getParameter("cpid"));
		String adsid = StringUtil.isNull(request.getParameter("adsid"));
		String cno = StringUtil.isNull(request.getParameter("cno"));
		String sday = StringUtil.isNull(request.getParameter("sday"));
		String eday = StringUtil.isNull(request.getParameter("eday"));
		System.out.println("adsDaily="+adsid);
		Map<String, String> map = new HashMap<String, String>();			
		
		/************************** 공통 *****************************/
		// 애즈 일자별 리포트
		map.put("cpid", cpid);
		map.put("adsid", adsid);
		map.put("country", cno);
		map.put("sday", StringUtil.DateStr(sday));
		map.put("eday", StringUtil.DateStr(eday));
		Report dayrpt = rptmgrFacade.getAdsCountryTotal(map);			
		
		JSONArray data = JSONArray.fromObject(dayrpt);

		response.setContentType("text/html;charset=utf-8");
		PrintWriter out=response.getWriter();
		out.print(JSONArray.fromObject(data).toString());  
		
		System.out.println(JSONArray.fromObject(data).toString());
	}	
	public void adsDaily(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		String cpid = StringUtil.isNull(request.getParameter("cpid"));
		String adsid = StringUtil.isNull(request.getParameter("adsid"));
		String crid = StringUtil.isNull(request.getParameter("crid"));
		String sday = StringUtil.isNull(request.getParameter("sday"));
		String eday = StringUtil.isNull(request.getParameter("eday"));
		System.out.println("adsDaily="+adsid);
		Map<String, String> map = new HashMap<String, String>();			
		
		/************************** 공통 *****************************/
		// 애즈 일자별 리포트
		map.put("cpid", cpid);
		map.put("adsid", adsid);
		map.put("crid", crid);
		map.put("sday", StringUtil.DateStr(sday));
		map.put("eday", StringUtil.DateStr(eday));
		List<Report> dayrpt = rptmgrFacade.getAdsDayRpt(map);			
		
		JSONArray data = JSONArray.fromObject(dayrpt);

		response.setContentType("text/html;charset=utf-8");
		PrintWriter out=response.getWriter();
		out.print(JSONArray.fromObject(data).toString());  
		
		System.out.println(JSONArray.fromObject(data).toString());
	}
	
	public void adsDailyTotal(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		String cpid = StringUtil.isNull(request.getParameter("cpid"));
		String adsid = StringUtil.isNull(request.getParameter("adsid"));
		String crid = StringUtil.isNull(request.getParameter("crid"));
		String sday = StringUtil.isNull(request.getParameter("sday"));
		String eday = StringUtil.isNull(request.getParameter("eday"));
		
		Map<String, String> map = new HashMap<String, String>();			
		
		/************************** 공통 *****************************/
		// 애즈 일자별 리포트
		map.put("cpid", cpid);
		map.put("adsid", adsid);
		map.put("crid", crid);
		map.put("sday", StringUtil.DateStr(sday));
		map.put("eday", StringUtil.DateStr(eday));
		Report dayrpt = rptmgrFacade.getAdsDayTotal(map);	
		
		JSONObject data = JSONObject.fromObject(dayrpt);	
		
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out=response.getWriter();
		out.print(JSONArray.fromObject(data).toString());  
	}
	public ModelAndView adsRptTimely(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		
		Map<String, String[]> requestParams = request.getParameterMap();
		Map<String, String> map = setParamap(requestParams);	
		//필수 조건
		
		/******** 날짜셋팅 *******/
		
		if(StringUtil.isNull(map.get("sday")).equals("")){
			String eday = DateUtil.curDate();
			String sday = DateUtil.nextMon(eday, -1);
			map.put("sday", sday);
			map.put("eday", eday);
		} 
		map.put("sday", StringUtil.DateStr(map.get("sday")));
		map.put("eday", StringUtil.DateStr(map.get("eday")));
		
		
		
		/************************** 공통 *****************************/
		// 캠페인 정보
		
		Campaign cp = cpmgrFacade.getCampaign(map);	
		List<Ads> adslist = cpmgrFacade.getAdsList(map);	
		//	
		List<Report> rptlist = rptmgrFacade.getAdsTimeRpt(map);
		
		System.out.println("-----------------------------"+map);
		
		//AdsReport rpttotal = rptmgrFacade.getAdsMonitoringTotal(map);	
		
		/*
		Map<String, String> map2 = new HashMap<String, String>();		
		
		String code_str = "";
		code_str += "'prtype',";
		code_str += "'weekday',";
		
		//선택옵션 리스트
		map2.clear();
		map2.put("code_str", code_str.substring(0,code_str.length()-1));
		List<Map<String, String>> codelist = cpmgrFacade.getCodeList(map2);		
		
		//세일즈구분 리스트
		map2.clear();
		map2.put("code", "salestype");
		List<Map<String, String>> salestypelist = cpmgrFacade.getCodeList(map2);		
		//요일
		map2.clear();
		map2.put("code", "weekday");
		List<Map<String, String>> weekday = cpmgrFacade.getCodeList(map2);		// 애즈 목록
	*/
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("rptlist", rptlist);
		resultMap.put("adslist", adslist);
		
		resultMap.put("paramap", map);
		
		return new ModelAndView("report/ads_rpt_timely", "response", resultMap);		
	}
	
	/******************************** 사이트 리포트 ************************************/
	public ModelAndView siteRpt(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		
		Map<String, String[]> requestParams = request.getParameterMap();
		Map<String, String> map = setParamap(requestParams);	
		//필수 조건
		
		/******** 날짜셋팅 *******/
		
		if(StringUtil.isNull(map.get("sday")).equals("")){
			String eday = DateUtil.curDate();
			String sday = DateUtil.nextMon(eday, -1);
			map.put("sday", sday);
			map.put("eday", eday);
		} 
		map.put("sday", StringUtil.DateStr(map.get("sday")));
		map.put("eday", StringUtil.DateStr(map.get("eday")));
		map.put("today", DateUtil.curDate());
		
		//애즈 모니터링 	
		List<DayReport> rptlist = rptmgrFacade.getSiteRpt(map);
		
		System.out.println("-----------------------------"+map);
		
		//AdsReport rpttotal = rptmgrFacade.getAdsMonitoringTotal(map);	
		
		
		Map<String, String> map2 = new HashMap<String, String>();		
		
		//위치그룹리스트
		/*
		map2.put("prtype", StringUtil.isNull(map.get("prtype")));		
		List<Map<String, String>> grouplist = sitemgrFacade.getSlgroupList(map2);
	*/
		//세일즈구분 리스트
		map2.clear();
		map2.put("code", "salestype");
		List<Map<String, String>> salestypelist = cpmgrFacade.getCodeList(map2);		
		//사이트타입 리스트
		map2.clear();
		map2.put("code", "sitetype");
		List<Map<String, String>> sitetypelist = cpmgrFacade.getCodeList(map2);		
		
		//광고상품 리스트
		map2.clear();
		map2.put("code", "prtype");
		List<Map<String, String>> prtypelist = cpmgrFacade.getCodeList(map2);		

		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("rptlist", rptlist);
		//resultMap.put("rpttotal", rpttotal);
		//resultMap.put("totalLiveAdsCnt", String.valueOf(liveinfo.get("livecnt")));
		resultMap.put("salestypelist", salestypelist);
		resultMap.put("sitetypelist", sitetypelist);
		resultMap.put("prtypelist", prtypelist);
		
		resultMap.put("paramap", map);
		
		return new ModelAndView("report/site_report", "response", resultMap);		
	}
	/******************************** 위치그룹 리포트 ************************************/
	public ModelAndView slgroupRpt(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		
		Map<String, String[]> requestParams = request.getParameterMap();
		Map<String, String> map = setParamap(requestParams);	
		//필수 조건
		
		/******** 날짜셋팅 *******/
		
		if(StringUtil.isNull(map.get("sday")).equals("")){
			String eday = DateUtil.curDate();
			String sday = DateUtil.nextMon(eday, -1);
			map.put("sday", sday);
			map.put("eday", eday);
		} 
		map.put("sday", StringUtil.DateStr(map.get("sday")));
		map.put("eday", StringUtil.DateStr(map.get("eday")));
		map.put("today", DateUtil.curDate());
		
		//애즈 모니터링 	
		List<DayReport> rptlist = rptmgrFacade.getSlgroupRpt(map);
		
		Map<String, String> map2 = new HashMap<String, String>();		
		
		//위치그룹리스트
		/*
		map2.put("prtype", StringUtil.isNull(map.get("prtype")));		
		List<Map<String, String>> grouplist = sitemgrFacade.getSlgroupList(map2);
	*/
		//세일즈구분 리스트
		map2.clear();
		map2.put("code", "salestype");
		List<Map<String, String>> salestypelist = cpmgrFacade.getCodeList(map2);		
		//사이트타입 리스트
		map2.clear();
		map2.put("code", "sitetype");
		List<Map<String, String>> sitetypelist = cpmgrFacade.getCodeList(map2);		
		
		//광고상품 리스트
		map2.clear();
		map2.put("code", "prtype");
		List<Map<String, String>> prtypelist = cpmgrFacade.getCodeList(map2);		

		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("rptlist", rptlist);
		//resultMap.put("rpttotal", rpttotal);
		//resultMap.put("totalLiveAdsCnt", String.valueOf(liveinfo.get("livecnt")));
		resultMap.put("salestypelist", salestypelist);
		resultMap.put("sitetypelist", sitetypelist);
		resultMap.put("prtypelist", prtypelist);
		
		resultMap.put("paramap", map);
		
		return new ModelAndView("report/slgroup_report", "response", resultMap);		
	}
	/******************************** 위치 리포트 ************************************/
	public ModelAndView slotRpt(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		
		Map<String, String[]> requestParams = request.getParameterMap();
		Map<String, String> map = setParamap(requestParams);	
		//필수 조건
		
		/******** 날짜셋팅 *******/
		
		if(StringUtil.isNull(map.get("sday")).equals("")){
			String eday = DateUtil.curDate();
			String sday = DateUtil.nextMon(eday, -1);
			map.put("sday", sday);
			map.put("eday", eday);
		} 
		map.put("sday", StringUtil.DateStr(map.get("sday")));
		map.put("eday", StringUtil.DateStr(map.get("eday")));
		
		
		map.put("today", DateUtil.curDate());
		
		//애즈 모니터링 	
		List<DayReport> rptlist = rptmgrFacade.getSlotRpt(map);
		
		System.out.println("-----------------------------"+map);
		
		//AdsReport rpttotal = rptmgrFacade.getAdsMonitoringTotal(map);	
		
		
		Map<String, String> map2 = new HashMap<String, String>();		
		
		//위치그룹리스트
		/*
		map2.put("prtype", StringUtil.isNull(map.get("prtype")));		
		List<Map<String, String>> grouplist = sitemgrFacade.getSlgroupList(map2);
	*/
		//세일즈구분 리스트
		map2.clear();
		map2.put("code", "salestype");
		List<Map<String, String>> salestypelist = cpmgrFacade.getCodeList(map2);		
		//사이트타입 리스트
		map2.clear();
		map2.put("code", "sitetype");
		List<Map<String, String>> sitetypelist = cpmgrFacade.getCodeList(map2);		
		
		//광고상품 리스트
		map2.clear();
		map2.put("code", "prtype");
		List<Map<String, String>> prtypelist = cpmgrFacade.getCodeList(map2);		

		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("rptlist", rptlist);
		//resultMap.put("rpttotal", rpttotal);
		//resultMap.put("totalLiveAdsCnt", String.valueOf(liveinfo.get("livecnt")));
		resultMap.put("salestypelist", salestypelist);
		resultMap.put("sitetypelist", sitetypelist);
		resultMap.put("prtypelist", prtypelist);
		
		resultMap.put("paramap", map);
		
		return new ModelAndView("report/slot_report", "response", resultMap);		
	}	
	/******************************** 사이트 리포트 ************************************/
	public ModelAndView siteRptDaily(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		
		Map<String, String[]> requestParams = request.getParameterMap();
		Map<String, String> map = setParamap(requestParams);	
		//필수 조건
		
		/******** 날짜셋팅 *******/
		
		if(StringUtil.isNull(map.get("sday")).equals("")){
			String eday = DateUtil.curDate();
			String sday = DateUtil.nextMon(eday, -1);
			map.put("sday", sday);
			map.put("eday", eday);
		} 
		map.put("sday", StringUtil.DateStr(map.get("sday")));
		map.put("eday", StringUtil.DateStr(map.get("eday")));
		
		
		//애즈 모니터링 	
		List<DayReport> rptlist = rptmgrFacade.getSiteRptDaily(map);
		
		System.out.println("-----------------------------"+map);
		
		//AdsReport rpttotal = rptmgrFacade.getAdsMonitoringTotal(map);	
		
		
		Map<String,String> site = sitemgrFacade.getSite(map);
		
		Map<String, String> map2 = new HashMap<String, String>();		
		
		String code_str = "";
		code_str += "'salestype',";
		code_str += "'sitetype',";
		code_str += "'prtype',";
		
		
		//세일즈구분 리스트
		map2.clear();
		map2.put("code_str", code_str.substring(0,code_str.length()-1));
		List<Map<String, String>> codelist = cpmgrFacade.getCodeList(map2);		
		
		//세일즈구분 리스트
				map2.clear();
				map2.put("code", "salestype");
				List<Map<String, String>> salestypelist = cpmgrFacade.getCodeList(map2);		
						//요일
		map2.clear();
		map2.put("code", "weekday");
		List<Map<String, String>> weekday = cpmgrFacade.getCodeList(map2);		// 애즈 목록
	
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("rptlist", rptlist);
		resultMap.put("salestypelist", salestypelist);
		//resultMap.put("totalLiveAdsCnt", String.valueOf(liveinfo.get("livecnt")));
		resultMap.put("codelist", codelist);
		resultMap.put("site", site);
		resultMap.put("weekday", weekday);
		
		resultMap.put("paramap", map);
		
		return new ModelAndView("report/site_rpt_daily", "response", resultMap);		
	}
	public ModelAndView slgroupRptDaily(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		
		Map<String, String[]> requestParams = request.getParameterMap();
		Map<String, String> map = setParamap(requestParams);	
		//필수 조건
		
		/******** 날짜셋팅 *******/
		
		if(StringUtil.isNull(map.get("sday")).equals("")){
			String eday = DateUtil.curDate();
			String sday = DateUtil.nextMon(eday, -1);
			map.put("sday", sday);
			map.put("eday", eday);
		} 
		map.put("sday", StringUtil.DateStr(map.get("sday")));
		map.put("eday", StringUtil.DateStr(map.get("eday")));
		
		
		//애즈 모니터링 	
		List<DayReport> rptlist = rptmgrFacade.getSiteRptDaily(map);			
		Map<String,String> slgroup = sitemgrFacade.getSlgroup(map);		
		List<Map<String, String>> slotlist = sitemgrFacade.getSlgroupInSlotList(map);
		
		Map<String, String> map2 = new HashMap<String, String>();		
		
		String code_str = "";
		code_str += "'salestype',";
		code_str += "'sitetype',";
		code_str += "'prtype',";
		
		
		//세일즈구분 리스트
		map2.clear();
		map2.put("code_str", code_str.substring(0,code_str.length()-1));
		List<Map<String, String>> codelist = cpmgrFacade.getCodeList(map2);		
		
		//세일즈구분 리스트
				map2.clear();
				map2.put("code", "salestype");
				List<Map<String, String>> salestypelist = cpmgrFacade.getCodeList(map2);		
						//요일
		map2.clear();
		map2.put("code", "weekday");
		List<Map<String, String>> weekday = cpmgrFacade.getCodeList(map2);		// 애즈 목록
	
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("rptlist", rptlist);
		resultMap.put("salestypelist", salestypelist);
		resultMap.put("codelist", codelist);
		resultMap.put("slotlist", slotlist);
		resultMap.put("slgroup", slgroup);
		resultMap.put("weekday", weekday);
		
		resultMap.put("paramap", map);
		
		return new ModelAndView("report/slgroup_rpt_daily", "response", resultMap);		
	}
	public ModelAndView slgroupRptTime(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		
		Map<String, String[]> requestParams = request.getParameterMap();
		Map<String, String> map = setParamap(requestParams);	
		//필수 조건
		
		/******** 날짜셋팅 *******/
		
		if(StringUtil.isNull(map.get("sday")).equals("")){
			String eday = DateUtil.curDate();
			String sday = DateUtil.nextMon(eday, -1);
			map.put("sday", sday);
			map.put("eday", eday);
		} 
		map.put("sday", StringUtil.DateStr(map.get("sday")));
		map.put("eday", StringUtil.DateStr(map.get("eday")));
		
		
		//애즈 모니터링 	
		List<DayReport> rptlist = rptmgrFacade.getSiteRptTimely(map);			
		Map<String,String> slgroup = sitemgrFacade.getSlgroup(map);		
		List<Map<String, String>> slotlist = sitemgrFacade.getSlgroupInSlotList(map);
		
		Map<String, String> map2 = new HashMap<String, String>();		
		
		String code_str = "";
		code_str += "'salestype',";
		code_str += "'sitetype',";
		code_str += "'prtype',";
		
		
		//세일즈구분 리스트
		map2.clear();
		map2.put("code_str", code_str.substring(0,code_str.length()-1));
		List<Map<String, String>> codelist = cpmgrFacade.getCodeList(map2);		
		
		//세일즈구분 리스트
				map2.clear();
				map2.put("code", "salestype");
				List<Map<String, String>> salestypelist = cpmgrFacade.getCodeList(map2);		
						//요일
		map2.clear();
		map2.put("code", "weekday");
		List<Map<String, String>> weekday = cpmgrFacade.getCodeList(map2);		// 애즈 목록
	
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("rptlist", rptlist);
		resultMap.put("salestypelist", salestypelist);
		resultMap.put("codelist", codelist);
		resultMap.put("slotlist", slotlist);
		resultMap.put("slgroup", slgroup);
		resultMap.put("weekday", weekday);
		
		resultMap.put("paramap", map);
		
		return new ModelAndView("report/slgroup_rpt_time", "response", resultMap);		
	}
	public ModelAndView slgroupRptCountry(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		
		Map<String, String[]> requestParams = request.getParameterMap();
		Map<String, String> map = setParamap(requestParams);	
		//필수 조건
		
		/******** 날짜셋팅 *******/
		
		if(StringUtil.isNull(map.get("sday")).equals("")){
			String eday = DateUtil.curDate();
			String sday = DateUtil.nextMon(eday, -1);
			map.put("sday", sday);
			map.put("eday", eday);
		} 
		map.put("sday", StringUtil.DateStr(map.get("sday")));
		map.put("eday", StringUtil.DateStr(map.get("eday")));
		
			
		List<DayReport> rptlist = rptmgrFacade.getSiteRptCountry(map);			
		List<DayReport> dayrpt = rptmgrFacade.getSiteRptCountryDaily(map);			
		
		
		Map<String,String> slgroup = sitemgrFacade.getSlgroup(map);		
		List<Map<String, String>> slotlist = sitemgrFacade.getSlgroupInSlotList(map);
		
		Map<String, String> map2 = new HashMap<String, String>();		
		
		String code_str = "";
		code_str += "'salestype',";
		code_str += "'sitetype',";
		code_str += "'prtype',";
		
		
		//세일즈구분 리스트
		map2.clear();
		map2.put("code_str", code_str.substring(0,code_str.length()-1));
		List<Map<String, String>> codelist = cpmgrFacade.getCodeList(map2);		
		
		//세일즈구분 리스트
				map2.clear();
				map2.put("code", "salestype");
				List<Map<String, String>> salestypelist = cpmgrFacade.getCodeList(map2);		
						//요일
		map2.clear();
		map2.put("code", "weekday");
		List<Map<String, String>> weekday = cpmgrFacade.getCodeList(map2);		// 애즈 목록
	
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("rptlist", rptlist);
		resultMap.put("salestypelist", salestypelist);
		resultMap.put("codelist", codelist);
		resultMap.put("slotlist", slotlist);
		resultMap.put("slgroup", slgroup);
		resultMap.put("weekday", weekday);
		resultMap.put("dayrpt", dayrpt);
		
		resultMap.put("paramap", map);
		
		return new ModelAndView("report/slgroup_rpt_country", "response", resultMap);		
	}
	public ModelAndView slotRptDaily(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		
		Map<String, String[]> requestParams = request.getParameterMap();
		Map<String, String> map = setParamap(requestParams);	
		//필수 조건
		
		/******** 날짜셋팅 *******/
		
		if(StringUtil.isNull(map.get("sday")).equals("")){
			String eday = DateUtil.curDate();
			String sday = DateUtil.nextMon(eday, -1);
			map.put("sday", sday);
			map.put("eday", eday);
		} 
		map.put("sday", StringUtil.DateStr(map.get("sday")));
		map.put("eday", StringUtil.DateStr(map.get("eday")));
		
		
		//애즈 모니터링 	
		List<DayReport> rptlist = rptmgrFacade.getSiteRptDaily(map);
			
		Slot slot = sitemgrFacade.getSlot(map);
		map.put("siteid", slot.getSiteid());
		Map<String,String> site = sitemgrFacade.getSite(map);
		
		Map<String, String> map2 = new HashMap<String, String>();		
		
		String code_str = "";
		code_str += "'salestype',";
		code_str += "'sitetype',";
		code_str += "'prtype',";
		
		
		//세일즈구분 리스트
		map2.clear();
		map2.put("code_str", code_str.substring(0,code_str.length()-1));
		List<Map<String, String>> codelist = cpmgrFacade.getCodeList(map2);		
		
		//세일즈구분 리스트
				map2.clear();
				map2.put("code", "salestype");
				List<Map<String, String>> salestypelist = cpmgrFacade.getCodeList(map2);		
						//요일
		map2.clear();
		map2.put("code", "weekday");
		List<Map<String, String>> weekday = cpmgrFacade.getCodeList(map2);		// 애즈 목록
	
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("rptlist", rptlist);
		resultMap.put("salestypelist", salestypelist);
		resultMap.put("codelist", codelist);
		resultMap.put("site", site);
		resultMap.put("slot", slot);
		resultMap.put("weekday", weekday);
		
		resultMap.put("paramap", map);
		
		return new ModelAndView("report/slot_rpt_daily", "response", resultMap);		
	}
	public ModelAndView slotRptTime(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		
		Map<String, String[]> requestParams = request.getParameterMap();
		Map<String, String> map = setParamap(requestParams);	
		//필수 조건
		
		/******** 날짜셋팅 *******/
		
		if(StringUtil.isNull(map.get("sday")).equals("")){
			String eday = DateUtil.curDate();
			String sday = DateUtil.nextMon(eday, -1);
			map.put("sday", sday);
			map.put("eday", eday);
		} 
		map.put("sday", StringUtil.DateStr(map.get("sday")));
		map.put("eday", StringUtil.DateStr(map.get("eday")));
				
		//애즈 모니터링 	
		List<DayReport> rptlist = rptmgrFacade.getSiteRptTimely(map);
		
		Slot slot = sitemgrFacade.getSlot(map);
		map.put("siteid", slot.getSiteid());
		Map<String,String> site = sitemgrFacade.getSite(map);
		
		Map<String, String> map2 = new HashMap<String, String>();		
		
		String code_str = "";
		code_str += "'prtype',";
		code_str += "'weekday',";
		
		//선택옵션 리스트
		map2.clear();
		map2.put("code_str", code_str.substring(0,code_str.length()-1));
		List<Map<String, String>> codelist = cpmgrFacade.getCodeList(map2);		
		
		//세일즈구분 리스트
		map2.clear();
		map2.put("code", "salestype");
		List<Map<String, String>> salestypelist = cpmgrFacade.getCodeList(map2);		
		//요일
		map2.clear();
		map2.put("code", "weekday");
		List<Map<String, String>> weekday = cpmgrFacade.getCodeList(map2);		// 애즈 목록
	
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("rptlist", rptlist);
		resultMap.put("salestypelist", salestypelist);
		//resultMap.put("totalLiveAdsCnt", String.valueOf(liveinfo.get("livecnt")));
		resultMap.put("codelist", codelist);
		resultMap.put("slot", slot);
		resultMap.put("site", site);
		resultMap.put("weekday", weekday);
		
		resultMap.put("paramap", map);
		
		return new ModelAndView("report/slot_rpt_time", "response", resultMap);		
	}	
public ModelAndView slotRptCountry(HttpServletRequest request, HttpServletResponse response) throws Exception {	
	
	
	Map<String, String[]> requestParams = request.getParameterMap();
	Map<String, String> map = setParamap(requestParams);	
	//필수 조건
	
	/******** 날짜셋팅 *******/
	
	if(StringUtil.isNull(map.get("sday")).equals("")){
		String eday = DateUtil.curDate();
		String sday = DateUtil.nextMon(eday, -1);
		map.put("sday", sday);
		map.put("eday", eday);
	} 
	map.put("sday", StringUtil.DateStr(map.get("sday")));
	map.put("eday", StringUtil.DateStr(map.get("eday")));
			
	//애즈 모니터링 	
	List<DayReport> rptlist = rptmgrFacade.getSiteRptCountry(map);
	List<DayReport> dayrpt = rptmgrFacade.getSiteRptCountryDaily(map);			
		
	Slot slot = sitemgrFacade.getSlot(map);
	map.put("siteid", slot.getSiteid());
	Map<String,String> site = sitemgrFacade.getSite(map);
	
	Map<String, String> map2 = new HashMap<String, String>();		
	
	String code_str = "";
	code_str += "'prtype',";
	code_str += "'weekday',";
	
	//선택옵션 리스트
	map2.clear();
	map2.put("code_str", code_str.substring(0,code_str.length()-1));
	List<Map<String, String>> codelist = cpmgrFacade.getCodeList(map2);		
	
	//세일즈구분 리스트
	map2.clear();
	map2.put("code", "salestype");
	List<Map<String, String>> salestypelist = cpmgrFacade.getCodeList(map2);		
	//요일
	map2.clear();
	map2.put("code", "weekday");
	List<Map<String, String>> weekday = cpmgrFacade.getCodeList(map2);		// 애즈 목록

	Map<String, Object> resultMap = new HashMap<String, Object>();
	resultMap.put("rptlist", rptlist);
	resultMap.put("salestypelist", salestypelist);
	//resultMap.put("totalLiveAdsCnt", String.valueOf(liveinfo.get("livecnt")));
	resultMap.put("codelist", codelist);
	resultMap.put("site", site);
	resultMap.put("slot", slot);
	resultMap.put("weekday", weekday);
	resultMap.put("dayrpt", dayrpt);
	
	resultMap.put("paramap", map);
	
	return new ModelAndView("report/slot_rpt_country", "response", resultMap);		
}
	public ModelAndView siteRptTimely(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		
		Map<String, String[]> requestParams = request.getParameterMap();
		Map<String, String> map = setParamap(requestParams);	
		//필수 조건
		
		/******** 날짜셋팅 *******/
		
		if(StringUtil.isNull(map.get("sday")).equals("")){
			String eday = DateUtil.curDate();
			String sday = DateUtil.nextMon(eday, -1);
			map.put("sday", sday);
			map.put("eday", eday);
		} 
		map.put("sday", StringUtil.DateStr(map.get("sday")));
		map.put("eday", StringUtil.DateStr(map.get("eday")));
				
		//애즈 모니터링 	
		List<DayReport> rptlist = rptmgrFacade.getSiteRptTimely(map);
		
		System.out.println("-----------------------------"+map);
		
		//AdsReport rpttotal = rptmgrFacade.getAdsMonitoringTotal(map);	
		
		
		Map<String,String> site = sitemgrFacade.getSite(map);
		
		Map<String, String> map2 = new HashMap<String, String>();		
		
		String code_str = "";
		code_str += "'prtype',";
		code_str += "'weekday',";
		
		//선택옵션 리스트
		map2.clear();
		map2.put("code_str", code_str.substring(0,code_str.length()-1));
		List<Map<String, String>> codelist = cpmgrFacade.getCodeList(map2);		
		
		//세일즈구분 리스트
		map2.clear();
		map2.put("code", "salestype");
		List<Map<String, String>> salestypelist = cpmgrFacade.getCodeList(map2);		
		//요일
		map2.clear();
		map2.put("code", "weekday");
		List<Map<String, String>> weekday = cpmgrFacade.getCodeList(map2);		// 애즈 목록
	
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("rptlist", rptlist);
		resultMap.put("salestypelist", salestypelist);
		//resultMap.put("totalLiveAdsCnt", String.valueOf(liveinfo.get("livecnt")));
		resultMap.put("codelist", codelist);
		resultMap.put("site", site);
		resultMap.put("weekday", weekday);
		
		resultMap.put("paramap", map);
		
		return new ModelAndView("report/site_rpt_timely", "response", resultMap);		
	}	
	public ModelAndView siteRptCountry(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		
		Map<String, String[]> requestParams = request.getParameterMap();
		Map<String, String> map = setParamap(requestParams);	
		//필수 조건
		
		/******** 날짜셋팅 *******/
		
		if(StringUtil.isNull(map.get("sday")).equals("")){
			String eday = DateUtil.curDate();
			String sday = DateUtil.nextMon(eday, -1);
			map.put("sday", sday);
			map.put("eday", eday);
		} 
		map.put("sday", StringUtil.DateStr(map.get("sday")));
		map.put("eday", StringUtil.DateStr(map.get("eday")));
				
		//애즈 모니터링 	
		List<DayReport> rptlist = rptmgrFacade.getSiteRptCountry(map);
		List<DayReport> dayrpt = rptmgrFacade.getSiteRptCountryDaily(map);			
		
		System.out.println("-----------------------------"+map);
		
		//AdsReport rpttotal = rptmgrFacade.getAdsMonitoringTotal(map);	
		
		
		Map<String,String> site = sitemgrFacade.getSite(map);
		
		Map<String, String> map2 = new HashMap<String, String>();		
		
		String code_str = "";
		code_str += "'prtype',";
		code_str += "'weekday',";
		
		//선택옵션 리스트
		map2.clear();
		map2.put("code_str", code_str.substring(0,code_str.length()-1));
		List<Map<String, String>> codelist = cpmgrFacade.getCodeList(map2);		
		
		//세일즈구분 리스트
		map2.clear();
		map2.put("code", "salestype");
		List<Map<String, String>> salestypelist = cpmgrFacade.getCodeList(map2);		
		//요일
		map2.clear();
		map2.put("code", "weekday");
		List<Map<String, String>> weekday = cpmgrFacade.getCodeList(map2);		// 애즈 목록
	
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("rptlist", rptlist);
		resultMap.put("salestypelist", salestypelist);
		//resultMap.put("totalLiveAdsCnt", String.valueOf(liveinfo.get("livecnt")));
		resultMap.put("codelist", codelist);
		resultMap.put("site", site);
		resultMap.put("weekday", weekday);
		resultMap.put("dayrpt", dayrpt);
		
		resultMap.put("paramap", map);
		
		return new ModelAndView("report/site_rpt_country", "response", resultMap);		
	}		/******************************** 모니터링 ***********************************/
	
	public ModelAndView slotMonitor(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		
		Map<String, String[]> requestParams = request.getParameterMap();
		Map<String, String> map = setParamap(requestParams);	
		//필수 조건
		if(StringUtil.isNull(map.get("dperiod")).equals("")){
			map.put("dperiod", "1");		
		} 
		if(StringUtil.isNull(map.get("live")).equals("")){
			map.put("live", "Y");		
		} 		
		
		//파라미터로 이용 조건 셋팅
		String sday = "";
		String eday = DateUtil.curDate();
		if(map.get("dperiod").equals("2")){
			sday = DateUtil.nextMon(eday, -1);		
		} else {
			sday = DateUtil.nextWeek(eday, -1);		
		}
		map.put("today", DateUtil.curDate());
		map.put("sday", sday);
		map.put("eday", eday);
		
		//rptmgrFacade.createLiveInfo(map);
		//Map<String,String> liveinfo = rptmgrFacade.getLiveInfo(map);
		
		//map.put("adsid_str", StringUtil.isNull(liveinfo.get("adsid_str"))); // None 라이브는 Null
		//map.put("slotid_str", liveinfo.get("slotid_str"));
		//String totalLiveAdsCnt = "0";
		//String totalSlotCnt = "0";
		//if(StringUtil.isNull(map.get("live")).equals("")){
		//	totalLiveAdsCnt = String.valueOf(liveinfo.get("adscnt"));
		//}
		//totalSlotCnt = String.valueOf(liveinfo.get("slotcnt"));
		//위치 모니터링 	
		List<SiteReport> rptlist = rptmgrFacade.getSlotMonitoring(map);		
		//SiteReport rpttotal = rptmgrFacade.getSlotMonitoringTotal(map);	
		
		
		
		//위치그룹리스트
		Map<String, String> map2 = new HashMap<String, String>();		
		map2.put("prtype", StringUtil.isNull(map.get("prtype")));		
		List<Map<String, String>> grouplist = sitemgrFacade.getSlgroupList(map2);
	
		//사이트타입 리스트
		map2.clear();
		map2.put("code", "sitetype");
		List<Map<String, String>> sitetypelist = cpmgrFacade.getCodeList(map2);		
		
		//광고상품 리스트
		map2.clear();
		map2.put("code", "prtype");
		List<Map<String, String>> prtypelist = cpmgrFacade.getCodeList(map2);		

		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("rptlist", rptlist);
		//resultMap.put("rpttotal", rpttotal);
		//resultMap.put("totalLiveAdsCnt", totalLiveAdsCnt);
		//resultMap.put("totalSlotCnt", totalSlotCnt);
		
		
		resultMap.put("grouplist", grouplist);
		resultMap.put("sitetypelist", sitetypelist);
		resultMap.put("prtypelist", prtypelist);
		
		resultMap.put("paramap", map);
		
		return new ModelAndView("monitor/slot_monitoring", "response", resultMap);		
	}
	public ModelAndView adsMonitor(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		
		Map<String, String[]> requestParams = request.getParameterMap();
		Map<String, String> map = setParamap(requestParams);	
		//필수 조건
		if(StringUtil.isNull(map.get("live")).equals("")){
			map.put("live", "Y");		
		} /*
		if(!StringUtil.isNull(map.get("sch_text")).equals("")){
			String sch_text = StringUtil.isNull(map.get("sch_text"));
			sch_text = new String (sch_text.getBytes("8859_1"),"UTF-8");
			map.put("sch_text", sch_text);		
		} 
		*/
		//파라미터로 이용 조건 셋팅
		/*
		String sday = "";
		String eday = DateUtil.curDate();
		if(map.get("dperiod").equals("2")){
			sday = DateUtil.nextMon(eday, -1);		
		} else {
			sday = DateUtil.nextWeek(eday, -1);		
		}
		map.put("sday", sday);
		map.put("eday", eday);
		*/
		map.put("today", DateUtil.curDate());
		
		//rptmgrFacade.createLiveInfo(map);
		Map<String,String> liveinfo = rptmgrFacade.getLiveInfo(map);
		
		map.put("adsid_str", liveinfo.get("adsid_str"));
		//map.put("slotid_str", liveinfo.get("slotid_str"));
		
		//애즈 모니터링 	
		List<AdsReport> rptlist = rptmgrFacade.getAdsMonitoring(map);
		
		System.out.println("-----------------------------"+map);
		
		//AdsReport rpttotal = rptmgrFacade.getAdsMonitoringTotal(map);	
		
		
		Map<String, String> map2 = new HashMap<String, String>();		
		
		//위치그룹리스트
		/*
		map2.put("prtype", StringUtil.isNull(map.get("prtype")));		
		List<Map<String, String>> grouplist = sitemgrFacade.getSlgroupList(map2);
	
		//사이트타입 리스트
		map2.clear();
		map2.put("code", "sitetype");
		List<Map<String, String>> sitetypelist = cpmgrFacade.getCodeList(map2);		
		*/
		//광고상품 리스트
		map2.clear();
		map2.put("code", "prtype");
		List<Map<String, String>> prtypelist = cpmgrFacade.getCodeList(map2);		

		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("rptlist", rptlist);
		//resultMap.put("rpttotal", rpttotal);
		//resultMap.put("totalLiveAdsCnt", String.valueOf(liveinfo.get("livecnt")));
		//resultMap.put("grouplist", grouplist);
		//resultMap.put("sitetypelist", sitetypelist);
		resultMap.put("prtypelist", prtypelist);
		
		resultMap.put("paramap", map);
		
		return new ModelAndView("monitor/ads_monitoring", "response", resultMap);		
	}	
	public void ckSlotAdsMonitoring(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		String slotid = StringUtil.isNull(request.getParameter("slotid"));
		Map<String, String> map = new HashMap<String, String>();			
		
		/************************** 공통 *****************************/
		// 애즈 일자별 리포트
		map.put("slotid", slotid);
		map.put("today", DateUtil.curDate());
		List<AdsReport> adsrpt = rptmgrFacade.getCkSlotAdsMonitoring(map);			
		
		JSONArray data = JSONArray.fromObject(adsrpt);

		response.setContentType("text/html;charset=utf-8");
		PrintWriter out=response.getWriter();
		out.print(JSONArray.fromObject(data).toString());  
		
		System.out.println(JSONArray.fromObject(data).toString());
	}
	
	public ModelAndView master(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		
		Map<String, String[]> requestParams = request.getParameterMap();
		Map<String, String> map = setParamap(requestParams);	
		//필수 조건
		if(StringUtil.isNull(map.get("dperiod")).equals("")){
			map.put("dperiod", "1");		
		} 
		
		
		//파라미터로 이용 조건 셋팅
		String sday = "";
		String eday = DateUtil.curDate();
		if(map.get("dperiod").equals("2")){
			sday = DateUtil.nextMon(eday, -1);		
		} else {
			sday = DateUtil.nextWeek(eday, -1);		
		}
		map.put("today", DateUtil.curDate());
		map.put("sday", sday);
		map.put("eday", eday);
		map.put("prtype", "2");
		
		//위치 모니터링 	
		SiteReport medtotal = rptmgrFacade.getPrismMasterMedTotal(map);	
		map.put("TotalIMP", medtotal.getImp());
		List<SiteReport> medrptlist = rptmgrFacade.getPrismMasterMed(map);		
		//캠페인 모니터링 	
		List<AdsReport> cprptlist = rptmgrFacade.getPrismMasterCp(map);		
		AdsReport cptotal = rptmgrFacade.getPrismMasterCpTotal(map);	
		
		
		
		Map<String, String> map2 = new HashMap<String, String>();		
		map2.clear();
		map2.put("code", "sitetype");
		List<Map<String, String>> sitetypelist = cpmgrFacade.getCodeList(map2);		
		
	

		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("medrptlist", medrptlist);
		resultMap.put("cprptlist", cprptlist);
		resultMap.put("medtotal", medtotal);
		resultMap.put("cptotal", cptotal);
		resultMap.put("sitetypelist", sitetypelist);
		
		resultMap.put("paramap", map);
		
		return new ModelAndView("prism/master_main", "response", resultMap);		
	}
	public ModelAndView prismCpList(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		
		Map<String, String[]> requestParams = request.getParameterMap();
		Map<String, String> map = setParamap(requestParams);	
		//필수 조건		
		if(StringUtil.isNull(map.get("eday")).equals("")){
			String eday = DateUtil.curDate();
			String sday = DateUtil.nextWeek(eday, -1);
			map.put("sday", sday);
			map.put("eday", eday);
		} 
		List<PrismReport> rptlist = rptmgrFacade.getPrismCpList(map);		
		
		
		
		//선택옵션 리스트
		Map<String, String> map2 = new HashMap<String, String>();		
		String code_str = "";
		code_str += "'sitetype',";
		code_str += "'ads_state',";
		map2.clear();
		map2.put("code_str", code_str.substring(0,code_str.length()-1));
		List<Map<String, String>> codelist = cpmgrFacade.getCodeList(map2);		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("rptlist", rptlist);		
		resultMap.put("codelist", codelist);		
		resultMap.put("paramap", map);
		
		return new ModelAndView("prism/prism_cplist", "response", resultMap);		
	}
	public ModelAndView prismMedList(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		
		Map<String, String[]> requestParams = request.getParameterMap();
		Map<String, String> map = setParamap(requestParams);	
		//필수 조건		
		if(StringUtil.isNull(map.get("eday")).equals("")){
			String eday = DateUtil.curDate();
			String sday = DateUtil.nextWeek(eday, -1);
			map.put("sday", sday);
			map.put("eday", eday);
		} 
		List<PrismReport> rptlist = rptmgrFacade.getPrismMedRpt(map);
		
		//선택옵션 리스트
		Map<String, String> map2 = new HashMap<String, String>();		
		String code_str = "";
		code_str += "'sitetype',";
		code_str += "'ads_state',";
		map2.clear();
		map2.put("code_str", code_str.substring(0,code_str.length()-1));
		List<Map<String, String>> codelist = cpmgrFacade.getCodeList(map2);		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("rptlist", rptlist);		
		resultMap.put("codelist", codelist);		
		resultMap.put("paramap", map);
		
		return new ModelAndView("prism/prism_medlist", "response", resultMap);		
	}
	public ModelAndView summaryPrism(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		
		Map<String, String[]> requestParams = request.getParameterMap();
		Map<String, String> map = setParamap(requestParams);	
		//필수 조건		
		Campaign cp = cpmgrFacade.getCampaign(map);	
		if(StringUtil.isNull(map.get("sday")).equals("")) {
			map.put("sday", StringUtil.DateStr(cp.getStartdate()));
			map.put("eday", StringUtil.DateStr(cp.getEnddate()));
		}	
		map.put("prtype", "2");
		
		/************* 공통 ************/

		//애즈리포트
		List<PrismReport> rptlist = rptmgrFacade.getPrismAdsRpt(map);		
		PrismReport rpttotal = rptmgrFacade.getPrismAdsTotal(map);		
		
		//광고물리포트
		List<PrismReport> cr_rptlist = rptmgrFacade.getPrismCrRpt(map);		
		PrismReport cr_rpttotal = rptmgrFacade.getPrismCrTotal(map);		
		
		//매체 리포트
		map.put("cp_book_total", StringUtil.isNullZero(rpttotal.getBook_total()));
		List<PrismReport> med_rptlist = rptmgrFacade.getPrismMedRpt(map);		
		PrismReport med_rpttotal = rptmgrFacade.getPrismMedTotal(map);		
				
		
		//클릭타임
System.out.println("------------------ClickTime");
		
		List<ClickTime> clickrpt = rptmgrFacade.getAdsClickTime(map);	
		ClickTime clicktot = rptmgrFacade.getAdsClickTimeTotal(map);
		
System.out.println("------------------SkipTime");		
		
		List<ClickTime> skiprpt = rptmgrFacade.getAdsSkipTime(map);	
		ClickTime skiptot = rptmgrFacade.getAdsSkipTimeTotal(map);	
		
		
		
		
		
		//일자별리포트
		PrismReport day_rpttotal = rptmgrFacade.getPrismDayTotal(map);
		map.put("guarantee", StringUtil.isNullZero(day_rpttotal.getGuarantee()));
		List<PrismReport> day_rptlist = rptmgrFacade.getPrismDayRpt(map);		
		// 요일 목록
		map.put("code", "weekday");
		List<Map<String, String>> weekday = cpmgrFacade.getCodeList(map);		// 애즈 목록
	
		
		
		
		
		
		
		
		
		
		
		
		
		
		//선택옵션 리스트
		Map<String, String> map2 = new HashMap<String, String>();		
		String code_str = "";
		code_str += "'sitetype',";
		map2.clear();
		map2.put("code_str", code_str.substring(0,code_str.length()-1));
		List<Map<String, String>> codelist = cpmgrFacade.getCodeList(map2);		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("cp", cp);		
		resultMap.put("rptlist", rptlist);		
		resultMap.put("rpttotal", rpttotal);		
		resultMap.put("med_rptlist", med_rptlist);		
		resultMap.put("med_rpttotal", med_rpttotal);		
		resultMap.put("cr_rptlist", cr_rptlist);		
		resultMap.put("cr_rpttotal", cr_rpttotal);		
		resultMap.put("day_rptlist", day_rptlist);		
		resultMap.put("day_rpttotal", day_rpttotal);		
		resultMap.put("clickrpt", clickrpt);		
		resultMap.put("skiprpt", skiprpt);		
		resultMap.put("clicktot", clicktot);		
		resultMap.put("skiptot", skiptot);		
		resultMap.put("weekday", weekday);		
		resultMap.put("codelist", codelist);		
		resultMap.put("paramap", map);
			
		return new ModelAndView("prism/cp_summary", "response", resultMap);		
	}
	public void adsPrismDaily(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		String cpid = StringUtil.isNull(request.getParameter("cpid"));
		String adsid = StringUtil.isNull(request.getParameter("adsid"));
		String crid = StringUtil.isNull(request.getParameter("crid"));
		String sday = StringUtil.isNull(request.getParameter("sday"));
		String eday = StringUtil.isNull(request.getParameter("eday"));
		Map<String, String> map = new HashMap<String, String>();			
		
		/************************** 공통 *****************************/
		// 애즈 일자별 리포트
		map.put("cpid", cpid);
		map.put("adsid", adsid);
		map.put("crid", crid);
		map.put("sday", StringUtil.DateStr(sday));
		map.put("eday", StringUtil.DateStr(eday));
		List<PrismReport> dayrpt = rptmgrFacade.getPrismDayRpt(map);		
		
		JSONArray data = JSONArray.fromObject(dayrpt);

		response.setContentType("text/html;charset=utf-8");
		PrintWriter out=response.getWriter();
		out.print(JSONArray.fromObject(data).toString());  
		
		System.out.println(JSONArray.fromObject(data).toString());
	}
	public void adsPrismDailyTotal(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		String cpid = StringUtil.isNull(request.getParameter("cpid"));
		String adsid = StringUtil.isNull(request.getParameter("adsid"));
		String crid = StringUtil.isNull(request.getParameter("crid"));
		String sday = StringUtil.isNull(request.getParameter("sday"));
		String eday = StringUtil.isNull(request.getParameter("eday"));
		Map<String, String> map = new HashMap<String, String>();			
		
		/************************** 공통 *****************************/
		// 애즈 일자별 리포트
		map.put("cpid", cpid);
		map.put("adsid", adsid);
		map.put("crid", crid);
		map.put("sday", StringUtil.DateStr(sday));
		map.put("eday", StringUtil.DateStr(eday));
		PrismReport dayrpt = rptmgrFacade.getPrismDayTotal(map);		
		
		JSONArray data = JSONArray.fromObject(dayrpt);

		response.setContentType("text/html;charset=utf-8");
		PrintWriter out=response.getWriter();
		out.print(JSONArray.fromObject(data).toString());  
		
		System.out.println(JSONArray.fromObject(data).toString());
	}	
	public ModelAndView timePrismRpt(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		Map<String, String[]> requestParams = request.getParameterMap();
		Map<String, String> map = setParamap(requestParams);	
		
		
		/************************** 공통 *****************************/
		// 캠페인 정보
		Campaign cp = cpmgrFacade.getCampaign(map);		
		if(StringUtil.isNull(map.get("sday")).equals("")) {
			map.put("sday", StringUtil.DateStr(cp.getStartdate()));
			map.put("eday", StringUtil.DateStr(cp.getEnddate()));
		}	
		map.put("prtype", "2");
		// 애즈리스트
		List<Ads> adslist = cpmgrFacade.getAdsList(map);	
		// 시간리포트
		List<PrismReport> dayrpt = rptmgrFacade.getPrismTimeRpt(map);		
		PrismReport daytotal = rptmgrFacade.getPrismDayTotal(map);	
		
		
		// 요일 목록
		Map<String, String> map2 = new HashMap<String, String>();			
		map2.put("code", "weekday");
		List<Map<String, String>> weekday = cpmgrFacade.getCodeList(map2);		

		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("cp", cp);
		resultMap.put("adslist", adslist);
		/*********************************/
		
		resultMap.put("daytotal", daytotal);
		resultMap.put("dayrpt", dayrpt);
		resultMap.put("weekday", weekday);
		resultMap.put("paramap", map);
		
		return new ModelAndView("prism/cp_prism_time", "response", resultMap);
	}	
	public ModelAndView adsPrismRpt(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		Map<String, String[]> requestParams = request.getParameterMap();
		Map<String, String> map = setParamap(requestParams);	
		
		
		/************************** 공통 *****************************/
		// 캠페인 정보
		Campaign cp = cpmgrFacade.getCampaign(map);		
		if(StringUtil.isNull(map.get("sday")).equals("")) {
			map.put("sday", StringUtil.DateStr(cp.getStartdate()));
			map.put("eday", StringUtil.DateStr(cp.getEnddate()));
		}
		// 애즈리스트
		List<Ads> adslist = cpmgrFacade.getAdsList(map);	
		
		// 애즈리포트
		List<PrismReport> rptlist = rptmgrFacade.getPrismAdsRpt(map);		
		PrismReport rpttotal = rptmgrFacade.getPrismAdsTotal(map);		
		
		
		//일자별리포트
		PrismReport day_rpttotal = rptmgrFacade.getPrismDayTotal(map);
		map.put("guarantee", StringUtil.isNullZero(day_rpttotal.getGuarantee()));
		List<PrismReport> day_rptlist = rptmgrFacade.getPrismDayRpt(map);		
		
		// 요일 목록
		map.put("code", "weekday");
		List<Map<String, String>> weekday = cpmgrFacade.getCodeList(map);		// 애즈 목록
		
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("cp", cp);
		/*********************************/
		resultMap.put("adslist", adslist);
		resultMap.put("rptlist", rptlist);
		resultMap.put("rpttotal", rpttotal);
		resultMap.put("weekday", weekday);
		resultMap.put("day_rptlist", day_rptlist);
		resultMap.put("day_rpttotal", day_rpttotal);
		resultMap.put("paramap", map);
		
		return new ModelAndView("prism/cp_prism_adsrpt", "response", resultMap);
	}
	public ModelAndView crPrismRpt(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		Map<String, String[]> requestParams = request.getParameterMap();
		Map<String, String> map = setParamap(requestParams);	
		
		
		/************************** 공통 *****************************/
		// 캠페인 정보
		Campaign cp = cpmgrFacade.getCampaign(map);		
		if(map.get("sday").equals("")) {
			map.put("sday", DateUtil.getYMD(cp.getStartdate()));
			map.put("eday", DateUtil.getYMD(cp.getEnddate()));
		}
		// 애즈리스트
		List<Ads> adslist = cpmgrFacade.getAdsList(map);	
		// 광고물리포트
		List<PrismReport> cr_rptlist = rptmgrFacade.getPrismCrRpt(map);		
		PrismReport cr_rpttotal = rptmgrFacade.getPrismCrTotal(map);		

		//일자별리포트
		PrismReport day_rpttotal = rptmgrFacade.getPrismDayTotal(map);
		map.put("guarantee", StringUtil.isNullZero(day_rpttotal.getGuarantee()));
		List<PrismReport> day_rptlist = rptmgrFacade.getPrismDayRpt(map);		
		
		
		// 요일 목록
		Map<String, String> map2 = new HashMap<String, String>();			
		map2.put("code", "weekday");
		List<Map<String, String>> weekday = cpmgrFacade.getCodeList(map2);		

		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("cp", cp);
		resultMap.put("adslist", adslist);
		/*********************************/
		resultMap.put("cr_rptlist", cr_rptlist);
		resultMap.put("cr_rpttotal", cr_rpttotal);
		resultMap.put("day_rptlist", day_rptlist);
		resultMap.put("day_rpttotal", day_rpttotal);

		resultMap.put("weekday", weekday);
		resultMap.put("paramap", map);
		
		return new ModelAndView("prism/cp_prism_creative", "response", resultMap);
	}
	public ModelAndView cpMedPrismRpt(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		Map<String, String[]> requestParams = request.getParameterMap();
		Map<String, String> map = setParamap(requestParams);	
		
		
		/************************** 공통 *****************************/
		// 캠페인 정보
		Campaign cp = cpmgrFacade.getCampaign(map);		
		if(map.get("sday").equals("")) {
			map.put("sday", DateUtil.getYMD(cp.getStartdate()));
			map.put("eday", DateUtil.getYMD(cp.getEnddate()));
		}
		// 애즈리스트
		List<Ads> adslist = cpmgrFacade.getAdsList(map);	

		
		
		
		//애즈리포트
		PrismReport rpttotal = rptmgrFacade.getPrismAdsTotal(map);		
		
		
		//매체 리포트
		map.put("cp_book_total", StringUtil.isNullZero(rpttotal.getBook_total()));
		List<PrismReport> med_rptlist = rptmgrFacade.getPrismMedRpt(map);		
		PrismReport med_rpttotal = rptmgrFacade.getPrismMedTotal(map);		
		
	
	
		//매체 일자별리포트
		PrismReport day_rpttotal = rptmgrFacade.getPrismMedDayTotal(map);
		List<PrismReport> day_rptlist = rptmgrFacade.getPrismMedDayRpt(map);		
		
		
		// 요일 목록
		Map<String, String> map2 = new HashMap<String, String>();			
		map2.put("code", "weekday");
		List<Map<String, String>> weekday = cpmgrFacade.getCodeList(map2);		

		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("cp", cp);
		resultMap.put("adslist", adslist);
		/*********************************/
		resultMap.put("med_rptlist", med_rptlist);
		resultMap.put("med_rpttotal", med_rpttotal);
		resultMap.put("day_rptlist", day_rptlist);
		resultMap.put("day_rpttotal", day_rpttotal);
		resultMap.put("rpttotal", rpttotal);

		resultMap.put("weekday", weekday);
		resultMap.put("paramap", map);
		
		return new ModelAndView("prism/cp_prism_media", "response", resultMap);
	}
	public ModelAndView sitePrismDaily(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		
		Map<String, String[]> requestParams = request.getParameterMap();
		Map<String, String> map = setParamap(requestParams);	
		//필수 조건
		
		/******** 날짜셋팅 *******/
		//파라미터로 이용 조건 셋팅
			if(StringUtil.isNull(map.get("sday")).equals("")){
			String eday = DateUtil.curDate();
			String sday = DateUtil.nextWeek(eday, -1);		
			map.put("sday", sday);
			map.put("eday", eday);
		} 
		map.put("sday", StringUtil.DateStr(map.get("sday")));
		map.put("eday", StringUtil.DateStr(map.get("eday")));
				
		//매체 일자별리포트
		List<PrismReport> day_rptlist = rptmgrFacade.getSitePrismDaily(map);		
		PrismReport day_rpttotal = rptmgrFacade.getSitePrismDailyTotal(map);
		
		Map<String,String> site = sitemgrFacade.getSite(map);
		
		Map<String, String> map2 = new HashMap<String, String>();		
			
		//요일
		map2.clear();
		map2.put("code", "weekday");
		List<Map<String, String>> weekday = cpmgrFacade.getCodeList(map2);		// 애즈 목록
	
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("day_rpttotal", day_rpttotal);
		resultMap.put("day_rptlist", day_rptlist);
	
		resultMap.put("site", site);
		resultMap.put("weekday", weekday);
		
		resultMap.put("paramap", map);
		
		return new ModelAndView("prism/site_prism_daily", "response", resultMap);		
	}
	public ModelAndView sitePrismTime(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		
		Map<String, String[]> requestParams = request.getParameterMap();
		Map<String, String> map = setParamap(requestParams);	
		//필수 조건
		
		/******** 날짜셋팅 *******/
		
		if(StringUtil.isNull(map.get("sday")).equals("")){
			String eday = DateUtil.curDate();
			String sday = DateUtil.nextMon(eday, -1);
			map.put("sday", sday);
			map.put("eday", eday);
		} 
		map.put("sday", StringUtil.DateStr(map.get("sday")));
		map.put("eday", StringUtil.DateStr(map.get("eday")));
				
		//매체 일자별리포트
		List<PrismReport> day_rptlist = rptmgrFacade.getSitePrismTimely(map);		
		PrismReport day_rpttotal = rptmgrFacade.getSitePrismDailyTotal(map);
		
		Map<String,String> site = sitemgrFacade.getSite(map);
		
		Map<String, String> map2 = new HashMap<String, String>();		
			
		//요일
		map2.clear();
		map2.put("code", "weekday");
		List<Map<String, String>> weekday = cpmgrFacade.getCodeList(map2);		// 애즈 목록
	
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("day_rpttotal", day_rpttotal);
		resultMap.put("day_rptlist", day_rptlist);
	
		resultMap.put("site", site);
		resultMap.put("weekday", weekday);
		
		resultMap.put("paramap", map);
		
		return new ModelAndView("prism/site_prism_time", "response", resultMap);		
	}
	
	
	public ModelAndView sitePrismCampaign(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		
		Map<String, String[]> requestParams = request.getParameterMap();
		Map<String, String> map = setParamap(requestParams);	
		//필수 조건
		
		/******** 날짜셋팅 *******/
		
		if(StringUtil.isNull(map.get("sday")).equals("")){
			String eday = DateUtil.curDate();
			String sday = DateUtil.nextMon(eday, -1);
			map.put("sday", sday);
			map.put("eday", eday);
		} 
		map.put("sday", StringUtil.DateStr(map.get("sday")));
		map.put("eday", StringUtil.DateStr(map.get("eday")));
				
		//캠페인 일자별리포트
		List<PrismReport> rptlist = rptmgrFacade.getSitePrismCampaign(map);		
		PrismReport day_rpttotal = rptmgrFacade.getSitePrismDailyTotal(map);
		
		Map<String,String> site = sitemgrFacade.getSite(map);
		
		Map<String, String> map2 = new HashMap<String, String>();		
			
		//요일
		map2.clear();
		map2.put("code", "weekday");
		List<Map<String, String>> weekday = cpmgrFacade.getCodeList(map2);		// 애즈 목록
	
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("day_rpttotal", day_rpttotal);
		resultMap.put("rptlist", rptlist);
	
		resultMap.put("site", site);
		resultMap.put("weekday", weekday);
		
		resultMap.put("paramap", map);
		
		return new ModelAndView("prism/site_prism_campaign", "response", resultMap);		
	}
	
	
	public void adsPrismMedDaily(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		String cpid = StringUtil.isNull(request.getParameter("cpid"));
		String adsid = StringUtil.isNull(request.getParameter("adsid"));
		String siteid = StringUtil.isNull(request.getParameter("siteid"));
		String sday = StringUtil.isNull(request.getParameter("sday"));
		String eday = StringUtil.isNull(request.getParameter("eday"));
		Map<String, String> map = new HashMap<String, String>();			
		
		/************************** 공통 *****************************/
		// 애즈 일자별 리포트
		map.put("cpid", cpid);
		map.put("adsid", adsid);
		map.put("siteid", siteid);
		map.put("sday", StringUtil.DateStr(sday));
		map.put("eday", StringUtil.DateStr(eday));
		List<PrismReport> dayrpt = rptmgrFacade.getPrismMedDayRpt(map);		
		
		JSONArray data = JSONArray.fromObject(dayrpt);

		response.setContentType("text/html;charset=utf-8");
		PrintWriter out=response.getWriter();
		out.print(JSONArray.fromObject(data).toString());  
		
		System.out.println(JSONArray.fromObject(data).toString());
	}
	public void adsPrismMedDailyTotal(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		String cpid = StringUtil.isNull(request.getParameter("cpid"));
		String adsid = StringUtil.isNull(request.getParameter("adsid"));
		String siteid = StringUtil.isNull(request.getParameter("siteid"));
		String sday = StringUtil.isNull(request.getParameter("sday"));
		String eday = StringUtil.isNull(request.getParameter("eday"));
		Map<String, String> map = new HashMap<String, String>();			
		
		/************************** 공통 *****************************/
		// 애즈 일자별 리포트
		map.put("cpid", cpid);
		map.put("adsid", adsid);
		map.put("siteid", siteid);
		map.put("sday", StringUtil.DateStr(sday));
		map.put("eday", StringUtil.DateStr(eday));
		PrismReport dayrpt = rptmgrFacade.getPrismMedDayTotal(map);		
		
		JSONArray data = JSONArray.fromObject(dayrpt);

		response.setContentType("text/html;charset=utf-8");
		PrintWriter out=response.getWriter();
		out.print(JSONArray.fromObject(data).toString());  
		
		System.out.println(JSONArray.fromObject(data).toString());
	}	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public Map<String, String> setParamap(Map<String, String[]> requestParams) throws Exception{
			Map<String, String> map = new HashMap<String, String>();		
			StringBuilder sb = new StringBuilder();
			for (Map.Entry<String, String[]> entry : requestParams.entrySet()) {
				String key = entry.getKey();         // parameter name
				String[] value = entry.getValue();   // parameter values as array of String
				String valueString = "";

				if (value.length > 1) {
					for (int i = 0; i < value.length; i++) {
						valueString += value[i] + " ";
					}
				} else {
					valueString = value[0];
				}
				
				if(key.equals("sch_text")){
					valueString = new String (valueString.getBytes("8859_1"),"UTF-8");
				} else if(key.equals("sday")){
					valueString = StringUtil.DateStr(valueString);
				} else if(key.equals("eday")){
					valueString = StringUtil.DateStr(valueString);
					if(Integer.parseInt(DateUtil.curDate()) < Integer.parseInt(valueString)) {
						valueString = DateUtil.curDate();
					}
				} 

				map.put(key, valueString);
				map = userPerSet(map);
				
				System.out.println("***** " + key + " - " + valueString);
				sb.append(key).append(" - ").append(valueString).append("; ");
			}
			return map;
	}
	
	public Map<String, String> userPerSet(Map<String, String> map) throws Exception{
		String userCorpid = (String)SessionUtil.getAttribute("userCorpid");
		String userType = (String)SessionUtil.getAttribute("userType");
		String isMain = (String)SessionUtil.getAttribute("isMain");
System.out.println("-----------userType = "+userType);		
System.out.println("-----------userCorpid = "+userCorpid);
System.out.println("-----------isMain = "+isMain);	

		if(!StringUtil.isNull(isMain).equals("1")) {
			if(userType.equals("1")){
				map.put("clientid", userCorpid)	;			
			} else if(userType.equals("2")){
				map.put("agencyid", userCorpid)	;			
			} else if(userType.equals("3")){
				map.put("medrepid", userCorpid)	;			
			} else if(userType.equals("4")){
				map.put("mediaid", userCorpid)	;			
			}			
		}
		
		return map;
		
		
	}
}
