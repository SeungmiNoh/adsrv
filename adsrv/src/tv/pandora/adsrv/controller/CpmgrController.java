package tv.pandora.adsrv.controller;

import java.io.File;
import java.io.IOException;
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
import tv.pandora.adsrv.domain.Slot;
import tv.pandora.adsrv.domain.Target;
import tv.pandora.adsrv.domain.User;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

public class CpmgrController extends AdsrvMultiActionController
{
	
	public ModelAndView cpAddForm(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		Map<String, String> map = new HashMap<String, String>();	
		map.put("ismgr", "1");
		List<User> tclist = usermgrFacade.getUserList(map);
	
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("tclist", tclist);
		
		return new ModelAndView("campaign/cp_info", "response", resultMap);
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
		resultMap.put("mode", "E");
		
		return new ModelAndView("campaign/cp_info", "response", resultMap);
	}
	
	public ModelAndView cpRegist(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String cpid = StringUtil.isNull(request.getParameter("cpid"));
		
		String userID = (String)SessionUtil.getAttribute("userID");
		Campaign cp = new Campaign();
		bind(request, cp);
		cp.setUpdatedate(DateUtil.simpleDate2());
		cp.setUpdateuser(userID);
		cp.setInsertdate(DateUtil.simpleDate2());
		cp.setInsertuser(userID);
		cp.setStartdate(StringUtil.DateStr(cp.getStartdate()));
		cp.setEnddate(StringUtil.DateStr(cp.getEnddate()));
		cp.setMemo(StringUtil.htmlEncode(cp.getMemo()));
		cp.setBudget(StringUtil.delcomma(cp.getBudget()));
		
		cp.setMemo(StringUtil.htmlEncode(cp.getMemo()));
		cpid = StringUtil.isNull(cp.getCpid());
		
		String url = "cpmgr.do?a=adsAddForm";
		if(cpid.equals("")){
			Integer icpid = cpmgrFacade.addCampaign(cp);	
			cpid = String.valueOf(icpid);
		} else {
			cpmgrFacade.modCampaign(cp);
			url = "cpmgr.do?a=cpEditForm";
		}
			
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("cpid", cpid);
		
		return new ModelAndView("redirect:"+url+"&cpid="+cpid, resultMap);
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
		List<Map<String, String>> codelist = cpmgrFacade.getCodeList(map);	
		
		
	
		// 타겟구분(메뉴) 목록
		map.put("tbname", "target");
		List<Map<String, String>> tgcodelist = cpmgrFacade.getCodeList(map);

		
		// 타겟팅 정보
		map.put("mode", "New");
		List<Map<String, String>> tglist = cpmgrFacade.getTargetList(map);		
		
		
		
		
		
		
		
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("cp", cp);	
		resultMap.put("codelist", codelist);		
		resultMap.put("tgcodelist", tgcodelist);		
		resultMap.put("tglist", tglist);		

		return new ModelAndView("campaign/ads_addform", "response", resultMap);
	}
	
	public ModelAndView adsInsert(HttpServletRequest request, HttpServletResponse response) throws Exception {			
		
		String adsid = StringUtil.isNull(request.getParameter("adsid"));
		String goal_total = StringUtil.isNullZero(request.getParameter("goal_total"));

		String userID = (String)SessionUtil.getAttribute("userID");
		Ads ads = new Ads();
		bind(request, ads);
		ads.setUpdatedate(DateUtil.simpleDate2());
		ads.setUpdateuser(userID);
		ads.setInsertdate(DateUtil.simpleDate2());
		ads.setInsertuser(userID);
		ads.setGoal_total(goal_total);
		
		
		//24:00 종료는 다음날 00:00 분으로 실제 종료일 변경
		String realenddate = ads.getEnddate();
		if(DateUtil.getCutHH(ads.getEnddate()).equals("24")){
			realenddate = "";
			realenddate = DateUtil.nextDayOfDate(DateUtil.getCutYMD(ads.getEnddate()), 1);
			realenddate += DateUtil.getCutMM(ads.getEnddate());
			realenddate += "00";
		}
		ads.setRealenddate(realenddate);
		
		// UNIX-TIME 값 가져옴
		long stime = DateUtil.getUnixTime(ads.getStartdate());
		long etime = DateUtil.getUnixTime(realenddate);
		System.out.println("realenddate="+realenddate);
		System.out.println("stime="+DateUtil.getUnixTime(ads.getStartdate())+"==>"+stime);
		System.out.println("etime="+DateUtil.getUnixTime(realenddate)+"==>"+etime);			
		ads.setStime(stime);
		ads.setEtime(etime);		
		
		
		
		
		String url = "";
		
		Integer iadsid = cpmgrFacade.addAds(ads);	
		adsid = String.valueOf(iadsid);
		
		
		
		
		
		/************** 타겟정보 인서트 **************/
		if(request.getParameterValues("tid")!=null)
		{
			String[] tid = request.getParameterValues("tid");
			String[] targettype = request.getParameterValues("targettype");
	
			
			ArrayList<Map<String,String>> list = new ArrayList<Map<String,String>>();
			
			for(int i=0; i<tid.length;i++){
				if(!StringUtil.isNullZero(tid[i].trim()).equals("0")) {
					
			         Map<String, String> ipmap = new HashMap<String, String>();
	
			         ipmap.put("adsid", adsid);
			         ipmap.put("tid", tid[i]);
			         ipmap.put("targettype", targettype[i]);
			         ipmap.put("updatedate", DateUtil.simpleDate2());
			         ipmap.put("updateuser", userID);

					System.out.println(i+") Map : " + ipmap);
					list.add(ipmap);					
				}
			}
			System.out.println(" List : " + list);
			if(list.size()>0) {
				cpmgrFacade.addAdsTargeting(list);
			}			
		}

		return new ModelAndView("redirect:cpmgr.do?a=adsEditCreative&mode=N&adsid="+adsid, null);
	}
	
	
	public ModelAndView adsRegist(HttpServletRequest request, HttpServletResponse response) throws Exception {			
		
		String adsid = StringUtil.isNull(request.getParameter("adsid"));
		//저장후 되돌아갈 링크
		String backuri = StringUtil.isNull(request.getParameter("backuri"));

		if(backuri.equals("")) backuri = "adsEditCreative";
		
		String userID = (String)SessionUtil.getAttribute("userID");
		Ads ads = new Ads();
		bind(request, ads);
		ads.setUpdatedate(DateUtil.simpleDate2());
		ads.setUpdateuser(userID);
		ads.setInsertdate(DateUtil.simpleDate2());
		ads.setInsertuser(userID);
		
		
		ads.setGoal_total(StringUtil.isNullZero(ads.getGoal_total()));
		ads.setBook_total(StringUtil.isNullZero(ads.getBook_total()));
		ads.setGoal_daily(StringUtil.isNullZero(ads.getGoal_daily()));
		
		
		//24:00 종료는 다음날 00:00 분으로 실제 종료일 변경
		String realenddate = ads.getEnddate();
		if(DateUtil.getCutHH(ads.getEnddate()).equals("24")){
			realenddate = "";
			realenddate = DateUtil.nextDayOfDate(DateUtil.getCutYMD(ads.getEnddate()), 1);
			realenddate += DateUtil.getCutMM(ads.getEnddate());
			realenddate += "00";
		}
		ads.setRealenddate(realenddate);
		
		// UNIX-TIME 값 가져옴
		long stime = DateUtil.getUnixTime(ads.getStartdate());
		long etime = DateUtil.getUnixTime(realenddate);
		System.out.println("realenddate="+realenddate);
		System.out.println("stime="+DateUtil.getUnixTime(ads.getStartdate())+"==>"+stime);
		System.out.println("etime="+DateUtil.getUnixTime(realenddate)+"==>"+etime);			
		ads.setStime(stime);
		ads.setEtime(etime);

		System.out.println("ads============"+ads);
		cpmgrFacade.modAds(ads);		
		
		return new ModelAndView("redirect:cpmgr.do?a="+backuri+"&adsid="+adsid, null);
	}	
	
	public ModelAndView modDelCampaign(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		String cpid = StringUtil.isNull(request.getParameter("cpid"));
		String userID = (String)SessionUtil.getAttribute("userID");
			
		 Map<String, String> map = new HashMap<String, String>();
		 map.put("cpid", cpid);    
		 
		 List<Ads> adslist = cpmgrFacade.getAvailableAdsList(map);
	 	 Map<String, String> dmap = new HashMap<String, String>();
	 	 
	 	 for(int i=0; i<adslist.size();i++){
	    	 Ads ads = adslist.get(i);
	    	 dmap.clear();
	    	 dmap.put("del_adsid", ads.getAdsid());
	         dmap.put("updatedate", DateUtil.simpleDate2());
	         dmap.put("updateuser", userID);
	         cpmgrFacade.modDelAdsCreative(dmap);
	         cpmgrFacade.modDelAdsSlot(dmap);
	         cpmgrFacade.modDelAdsTargeting(dmap);
			 cpmgrFacade.modDelAds(dmap);
	     
		}	 			 
		map.clear();			
	    map.put("allAdsDelete", "Y");
		map.put("cpid", cpid);
        map.put("updatedate", DateUtil.simpleDate2());
        map.put("updateuser", userID);
        cpmgrFacade.modDelCampaign(map);
       
        return new ModelAndView("redirect:cpmgr.do?a=cpList", null);
	}

	public ModelAndView modDelAds(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		String cpid = StringUtil.isNull(request.getParameter("cpid"));
		String adsid = StringUtil.isNull(request.getParameter("adsid"));
		String userID = (String)SessionUtil.getAttribute("userID");
			
		 Map<String, String> map = new HashMap<String, String>();
			
         map.put("del_adsid", adsid);
         map.put("updatedate", DateUtil.simpleDate2());
         map.put("updateuser", userID);
         cpmgrFacade.modDelAdsCreative(map);
         cpmgrFacade.modDelAdsSlot(map);
         cpmgrFacade.modDelAdsTargeting(map);
		 cpmgrFacade.modDelAds(map);

		return new ModelAndView("redirect:cpmgr.do?a=cpAdsList&cpid="+cpid, null);
	}
	public ModelAndView adsCopy(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		String adsid = StringUtil.isNull(request.getParameter("adsid"));
		String cpstartdate = StringUtil.isNull(request.getParameter("cpstartdate"));
		String cpenddate = StringUtil.isNull(request.getParameter("cpenddate"));
		String userID = (String)SessionUtil.getAttribute("userID");
			
		
		String startdate = DateUtil.curDate()+"0000";
		String enddate = cpenddate+"2400";
		String realenddate = DateUtil.nextDayOfDate(cpenddate, 1)+ "00";
 
		
		
		
		
		
		
		
		
		
		
		
		
		
		Map<String, String> map = new HashMap<String, String>();
			
         map.put("adsid", adsid);
         map.put("startdate", startdate);
         map.put("enddate", enddate);
         map.put("realenddate", realenddate);
         map.put("insertdate", DateUtil.simpleDate2());
         map.put("insertuser", userID);
          
		Integer icopyid = cpmgrFacade.copyAds(map);
		
		if(icopyid != null) {
			map.clear();
			map.put("adsid", adsid);
			map.put("copyid", String.valueOf(icopyid));
			map.put("insertdate", DateUtil.simpleDate2());
			map.put("insertuser", userID);
			cpmgrFacade.copyAdsTargeting(map);
			cpmgrFacade.copyAdsCreative(map);
			cpmgrFacade.copyAdsSlot(map);
		}
		return new ModelAndView("redirect:cpmgr.do?a=adsEditTarget&adsid="+String.valueOf(icopyid), null);
	}
	
	public ModelAndView campaignCopy(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		String cpid = StringUtil.isNull(request.getParameter("cpid"));
		String userID = (String)SessionUtil.getAttribute("userID");
		
		
		
		String cpstartdate = DateUtil.curDate();
		String cpenddate = DateUtil.nextMon(DateUtil.curDate(), 1).substring(1,8);
   	
        String ads_startdate = cpstartdate+"0000";
		String ads_enddate = cpenddate+"2400";
		String ads_realenddate = DateUtil.nextDayOfDate(cpenddate, 1)+ "00";
         		
		 Map<String, String> map = new HashMap<String, String>();
		 map.put("cpid", cpid);
    	 map.put("startdate", cpstartdate);
    	 map.put("enddate", cpenddate);
         map.put("insertdate", DateUtil.simpleDate2());
         map.put("insertuser", userID);        
         System.out.println("map=="+map);
         Integer icopyCpid = cpmgrFacade.copyCampaign(map);
         
         System.out.println("copyCampaign");
		
	     map.put("cpid", cpid);
	     List<Ads> adslist = cpmgrFacade.getAvailableAdsList(map);

	     System.out.println("adslist.size()="+adslist.size());

		
	 	 Map<String, String> cmap = new HashMap<String, String>();
	 	 
	 	 for(int i=0; i<adslist.size();i++){
	    	 Ads ads = adslist.get(i);
	    	 cmap.clear();	    	
	    	 cmap.put("adsid", ads.getAdsid());
	    	 cmap.put("copyCpid", String.valueOf(icopyCpid));
	    	 cmap.put("startdate", ads_startdate);
	    	 cmap.put("enddate", ads_enddate);
	    	 cmap.put("realenddate", ads_realenddate);
	    	 cmap.put("insertdate", DateUtil.simpleDate2());
	    	 cmap.put("insertuser", userID);
	         
		     System.out.println("cmap)="+cmap);

	         
	         
			Integer icopyid = cpmgrFacade.copyAds(cmap);
			
			if(icopyid != null) {
				cmap.clear();
				cmap.put("adsid", ads.getAdsid());
				cmap.put("copyid", String.valueOf(icopyid));
				cmap.put("insertdate", DateUtil.simpleDate2());
				cmap.put("insertuser", userID);
				cpmgrFacade.copyAdsTargeting(cmap);
				cpmgrFacade.copyAdsCreative(cmap);
				cpmgrFacade.copyAdsSlot(cmap);
			}	     
		}
		return new ModelAndView("redirect:cpmgr.do?a=cpAdsList&cpid="+String.valueOf(icopyCpid), null);
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	public ModelAndView crInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		String crid = StringUtil.isNull(request.getParameter("crid"));

		Map<String, String> map = new HashMap<String, String>();	
		map.put("crid", crid);
		Creative cr = cpmgrFacade.getCreative(map);
		List<Map<String,String>> clicklist = cpmgrFacade.getCrClickList(map);
		List<Map<String,String>> filelist = cpmgrFacade.getCrFileList(map);
		
		
		//광고상품 목록
		map.clear();
		map.put("code", "prtype");
		List<Map<String, String>> codelist = cpmgrFacade.getCodeList(map);	

		map.clear();
		map.put("order_str", "tmpname")	;
		List<Map<String, String>> tmplist = cpmgrFacade.getTemplateList(map);
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("cr", cr);
		resultMap.put("clicklist", clicklist);
		resultMap.put("filelist", filelist);
		resultMap.put("codelist", codelist);
		resultMap.put("tmplist", tmplist);
		resultMap.put("mode", "E");

		return new ModelAndView("campaign/cr_edit", "response", resultMap);
	}	
	public ModelAndView crDel(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String crid = StringUtil.isNull(request.getParameter("crid"));
	
		String userID = (String)SessionUtil.getAttribute("userID");
			
		 Map<String, String> map = new HashMap<String, String>();
			
         map.put("crid", crid);
         map.put("updatedate", DateUtil.simpleDate2());
         map.put("updateuser", userID);
		Integer result = cpmgrFacade.modDelCreative(map);
		
		
		//
		map.clear();		
		map.put("del_crid", crid);
        map.put("updatedate", DateUtil.simpleDate2());
        map.put("updateuser", userID);
        cpmgrFacade.modDelAdsCreative(map);
		
		return new ModelAndView("redirect:cpmgr.do?a=crList", null);
	}
	public ModelAndView crCopy(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		String crid = StringUtil.isNull(request.getParameter("crid"));
		String userID = (String)SessionUtil.getAttribute("userID");
			
		 Map<String, String> map = new HashMap<String, String>();
			
         map.put("crid", crid);
         map.put("insertdate", DateUtil.simpleDate2());
         map.put("insertuser", userID);
		Integer icopyid = cpmgrFacade.copyCreative(map);
		
		if(icopyid != null) {
			map.clear();
			map.put("crid", crid);
			map.put("copyid", String.valueOf(icopyid));
			map.put("insertdate", DateUtil.simpleDate2());
			map.put("insertuser", userID);
			cpmgrFacade.copyCreativeClick(map);
		}
		
		return new ModelAndView("redirect:cpmgr.do?a=crInfo&crid="+String.valueOf(icopyid), null);
	}
	public ModelAndView crRegist(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String adsid = StringUtil.isNullZero(request.getParameter("adsid"));
		String crid = StringUtil.isNullZero(request.getParameter("crid"));
		String mode = StringUtil.isNull(request.getParameter("cpid"));
		String userID = (String)SessionUtil.getAttribute("userID");
		
		Creative cr = new Creative();
		bind(request, cr);
		cr.setUpdatedate(DateUtil.simpleDate2());
		cr.setUpdateuser(userID);
		cr.setInsertdate(DateUtil.simpleDate2());
		cr.setInsertuser(userID);
		cr.setRealcode(cr.getRichmedia());
		cr.setRichmedia(StringUtil.encodeURIComponent(cr.getRichmedia()));
		
			
		
		if(crid.equals("0")){
			Integer icrid = cpmgrFacade.addCreative(cr);	
			crid = String.valueOf(icrid);
		} else {
			cpmgrFacade.modCreative(cr);		
		}
			
	
		if(request.getParameterValues("filename") != null)
		{
			String[] filename = request.getParameterValues("filename");
			String[] imgurl = request.getParameterValues("imgurl");
			String[] filesize = request.getParameterValues("filesize");
			String[] contenttype = request.getParameterValues("contenttype");
	

			ArrayList<Map<String,String>> list = new ArrayList<Map<String,String>>();
		
			for(int i=0; i<filename.length;i++){
				if(!StringUtil.isNullZero(filename[i].trim()).equals("0")) {
					
			         Map<String, String> ipmap = new HashMap<String, String>();
	
			         ipmap.put("crid", crid);
			         ipmap.put("filename", filename[i]);
			         ipmap.put("imgurl", imgurl[i]);
			         ipmap.put("filesize", filesize[i]);
			         ipmap.put("contenttype", contenttype[i]);
			         ipmap.put("updatedate", DateUtil.simpleDate2());
			         ipmap.put("updateuser", userID);
					
					System.out.println(i+") Map : " + ipmap);
					list.add(ipmap);					
				}
			}
			System.out.println(" List : " + list);
			if(list.size()>0){
				cpmgrFacade.addCreativeFile(list);
			}
		}
		
		if(request.getParameterValues("ckid") != null)
		{
		
			String[] ckid = request.getParameterValues("ckid");
			String[] clickname = request.getParameterValues("clickname");
			System.out.println("clickname.legnth="+clickname.length);
			String[] clickurl = request.getParameterValues("clickurl");
			
        
        
			ArrayList<Map<String,String>> list2 = new ArrayList<Map<String,String>>();			
			for(int i=0; i<ckid.length;i++){
				if(StringUtil.isNullZero(ckid[i].trim()).equals("0")) {
					
			         Map<String, String> ipmap = new HashMap<String, String>();
	
			         ipmap.put("crid", crid);
			         ipmap.put("clickname", clickname[i]);
			         ipmap.put("clickurl", clickurl[i]);
			         ipmap.put("updatedate", DateUtil.simpleDate2());
			         ipmap.put("updateuser", userID);
					
					System.out.println(i+") Map : " + ipmap);
					list2.add(ipmap);					
				}
			}
			System.out.println(" List : " + list2);
			if(list2.size()>0){
				cpmgrFacade.addCreativeClick(list2);
			}
		}
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("crid", crid);
		resultMap.put("crid", crid);
		resultMap.put("mode", mode);
		if(!adsid.equals("")) {
			return new ModelAndView("redirect:cpmgr.do?a=addAdsCrNew&adsid="+adsid+"&crid="+crid, resultMap);
		} else {
			return new ModelAndView("redirect:cpmgr.do?a=crInfo&crid="+crid, resultMap);
		}
	}
	
	
	
	public ModelAndView addAdsCrNew(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		String adsid = StringUtil.isNullZero(request.getParameter("adsid"));
		String crid = StringUtil.isNullZero(request.getParameter("crid"));
		String userID = (String)SessionUtil.getAttribute("userID");
		Map<String, String> map = new HashMap<String, String>();		
		map.put("adsid", adsid);
		map.put("crid", crid);
		map.put("insertdate", DateUtil.simpleDate2());
        map.put("insertuser", userID);
		cpmgrFacade.addAdsCrNew(map);
		return new ModelAndView("redirect:cpmgr.do?a=adsEditCreative&adsid="+adsid, null);
	}
	
	
	
	public ModelAndView adsTargetSave(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		String adsid = request.getParameter("adsid");
		//String backuri = StringUtil.isNull(request.getParameter("backuri"));

		//if(backuri.equals("")) backuri = "adsEditTarget";
		
		String userID = (String)SessionUtil.getAttribute("userID");
		
		Map<String, String> amap = new HashMap<String, String>();		
			
		String[] tid = request.getParameterValues("tid");
		String[] targettype = request.getParameterValues("targettype");

		
		ArrayList<Map<String,String>> list = new ArrayList<Map<String,String>>();
		
		String tgstr = "";
		for(int i=0; i<tid.length;i++){
			if(!StringUtil.isNullZero(tid[i].trim()).equals("0")) {
				
		         Map<String, String> ipmap = new HashMap<String, String>();

		         ipmap.put("adsid", adsid);
		         ipmap.put("tid", tid[i]);
		         ipmap.put("targettype", targettype[i]);
		         ipmap.put("updatedate", DateUtil.simpleDate2());
		         ipmap.put("updateuser", userID);
		         tgstr += targettype[i]+",";
				System.out.println(i+") Map : " + ipmap);
				list.add(ipmap);					
			}
		}
		System.out.println(" List : " + list);
		if(list.size()>0) {
			cpmgrFacade.addAdsTargeting(list);
			tgstr = tgstr.substring(0,tgstr.length()-1);
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("adsid", adsid);
		map.put("tgstr", tgstr);
        map.put("updatedate", DateUtil.simpleDate2());
        map.put("updateuser", userID);
		cpmgrFacade.modDelAdsTargeting(map);
		return new ModelAndView("redirect:cpmgr.do?a=adsEditTarget&adsid="+adsid, null);
	}
	public ModelAndView adsCreativeSave(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		String mode = StringUtil.isNull(request.getParameter("mode"));
		String backuri = StringUtil.isNull(request.getParameter("backuri"));
		//신규 저장시는 광고물 추가
		//if(mode.equals("N")) backuri = "adsEditCreative";
		//else if(backuri.equals("")) backuri = "adsEdit";
		
		String adsid = request.getParameter("adsid");
		String ads_state = request.getParameter("ads_state");
		String ads_startdate = request.getParameter("ads_startdate");
		String ads_enddate = request.getParameter("ads_enddate");
		String ads_realenddate = request.getParameter("ads_realenddate");
		//if(ads_state.equals("1")) ads_state = "2";
		ads_state = "3";
		String userID = (String)SessionUtil.getAttribute("userID");
		
		Map<String, String> amap = new HashMap<String, String>();		
		if(request.getParameterValues("crid")!= null)
		{
			String[] crid = request.getParameterValues("crid");
			
			ArrayList<Map<String,String>> list = new ArrayList<Map<String,String>>();
			String newstr = "";
			for(int i=0; i<crid.length;i++){
				if(!StringUtil.isNullZero(crid[i].trim()).equals("0")) {
					
			         Map<String, String> ipmap = new HashMap<String, String>();
			         
			         ipmap.put("adsid", adsid);
				     ipmap.put("crid", crid[i]);
			         ipmap.put("startdate", ads_startdate);
			         ipmap.put("enddate", ads_enddate);
			         ipmap.put("realenddate", ads_realenddate);
				     ipmap.put("weight", "100");
				     ipmap.put("cr_state", ads_state);			     
			         ipmap.put("insertdate", DateUtil.simpleDate2());
			         ipmap.put("insertuser", userID);
			         ipmap.put("updatedate", DateUtil.simpleDate2());
			         ipmap.put("updateuser", userID);
					
					System.out.println(i+") Map : " + ipmap);
					list.add(ipmap);					
				}
			}
			System.out.println(" List : " + list);
			cpmgrFacade.addAdsCreative(list);
			
		}
		
		
		
		/*
		if(mode.equals("N")) {
			return new ModelAndView("redirect:cpmgr.do?a=adsEditSlot&mode=N&adsid="+adsid, null);
		} else {
			return new ModelAndView("redirect:cpmgr.do?a=adsEdit&adsid="+adsid, null);
		}*/
		return new ModelAndView("redirect:cpmgr.do?a=adsEditCreative&mode=N&adsid="+adsid, null);
	}
	public ModelAndView adsCreativeUpdate(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		String adsid = request.getParameter("adsid");
		String userID = (String)SessionUtil.getAttribute("userID");
		//String backuri = StringUtil.isNull(request.getParameter("backuri"));

		//if(backuri.equals("")) backuri = "adsEdit";
		
		Map<String, String> amap = new HashMap<String, String>();		
			
		String[] crid = request.getParameterValues("crid");
		String[] cr_state = request.getParameterValues("cr_state");
		String[] weight = request.getParameterValues("weight");
		String[] startdate = request.getParameterValues("startdate");
		String[] enddate = request.getParameterValues("enddate");
		
		ArrayList<Map<String,String>> list = new ArrayList<Map<String,String>>();
		
		for(int i=0; i<crid.length;i++){
			if(!StringUtil.isNullZero(crid[i].trim()).equals("0")) {
				
		         Map<String, String> ipmap = new HashMap<String, String>();
		         
		         String realenddate = enddate[i];
		         if(DateUtil.getCutHH(enddate[i]).equals("24")){
		 			realenddate = DateUtil.nextDayOfDate(DateUtil.getCutYMD(enddate[i]), 1)+ "00";
		 			realenddate += DateUtil.getCutMM(enddate[i]);
		 		}	         
		         ipmap.put("adsid", adsid);
			     ipmap.put("crid", crid[i]);
		         ipmap.put("startdate", startdate[i]);
		         ipmap.put("enddate", enddate[i]);
		         ipmap.put("realenddate", realenddate);
		         ipmap.put("weight", weight[i]);
		         ipmap.put("cr_state", cr_state[i]);
		         ipmap.put("updatedate", DateUtil.simpleDate2());
		         ipmap.put("updateuser", userID);
				
				System.out.println(i+") Map : " + ipmap);
				list.add(ipmap);					
			}
		}
		System.out.println(" List : " + list);
		cpmgrFacade.addAdsCreative(list);
		
		return new ModelAndView("redirect:cpmgr.do?a=adsEditCreative&adsid="+adsid, null);
	}
	public ModelAndView adsCreativeDelete(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		String adsid = request.getParameter("adsid");
		String crstr = request.getParameter("crstr");
		//String backuri = StringUtil.isNull(request.getParameter("backuri"));

		//if(backuri.equals("")) backuri = "adsEdit";
		String userID = (String)SessionUtil.getAttribute("userID");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("adsid", adsid);
		map.put("crstr", crstr);
        map.put("updatedate", DateUtil.simpleDate2());
        map.put("updateuser", userID);
        cpmgrFacade.modDelAdsCreative(map);
		
		return new ModelAndView("redirect:cpmgr.do?a=adsEditCreative&adsid="+adsid, null);
	}
	public ModelAndView adsSlotSave(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		String adsid = request.getParameter("adsid");
		//String backuri = StringUtil.isNull(request.getParameter("backuri"));

		//if(backuri.equals("")) backuri = "adsEdit";
		String userID = (String)SessionUtil.getAttribute("userID");
		
		Map<String, String> amap = new HashMap<String, String>();		
			
		String[] slotid = request.getParameterValues("slotid");
		
		ArrayList<Map<String,String>> list = new ArrayList<Map<String,String>>();
		
		for(int i=0; i<slotid.length;i++){
			if(!StringUtil.isNullZero(slotid[i].trim()).equals("0")) {
				
		         Map<String, String> ipmap = new HashMap<String, String>();

		         ipmap.put("adsid", adsid);
			     ipmap.put("slotid", slotid[i]);
		         ipmap.put("insertdate", DateUtil.simpleDate2());
		         ipmap.put("insertuser", userID);
		         ipmap.put("updatedate", DateUtil.simpleDate2());
		         ipmap.put("updateuser", userID);
				
				System.out.println(i+") Map : " + ipmap);
				list.add(ipmap);					
			}
		}
		System.out.println(" List : " + list);
		cpmgrFacade.addAdsSlot(list);
		
		return new ModelAndView("redirect:cpmgr.do?a=adsEditSlot&adsid="+adsid, null);
	}
	public ModelAndView adsSlotUpdate(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		String adsid = request.getParameter("adsid");
		//String backuri = StringUtil.isNull(request.getParameter("backuri"));

		//if(backuri.equals("")) backuri = "adsEdit";
		String slot_state = request.getParameter("slot_state");
		String slotstr = request.getParameter("slotstr");
		String userID = (String)SessionUtil.getAttribute("userID");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("adsid", adsid);
		map.put("slotstr", slotstr);
		map.put("slot_state", slot_state);
        map.put("updatedate", DateUtil.simpleDate2());
        map.put("updateuser", userID);
        cpmgrFacade.modAdsSlot(map);
		return new ModelAndView("redirect:cpmgr.do?a=adsEditSlot&adsid="+adsid, null);
	}
	public ModelAndView adsSlotDelete(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		String adsid = request.getParameter("adsid");
		String slotstr = request.getParameter("slotstr");
		//String backuri = StringUtil.isNull(request.getParameter("backuri"));

		//if(backuri.equals("")) backuri = "adsEdit";
		String userID = (String)SessionUtil.getAttribute("userID");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("adsid", adsid);
		map.put("slotstr", slotstr);
		map.put("stat", "0");
		map.put("slot_state", "-1");
        map.put("updatedate", DateUtil.simpleDate2());
        map.put("updateuser", userID);
        cpmgrFacade.modAdsSlot(map);
		
		return new ModelAndView("redirect:cpmgr.do?a=adsEditSlot&adsid="+adsid, null);
	}
	public ModelAndView cpAdsList(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String cpid = StringUtil.isNull(request.getParameter("cpid"));
		
		Map<String, String> map = new HashMap<String, String>();	
		
		//캠페인 기본 정보
		map.put("cpid", cpid.toString());		
		Campaign cp = cpmgrFacade.getCampaign(map);	
		
		map.put("stat", "1");				
		List<Ads> adslist = cpmgrFacade.getAdsList(map);
		
		List<Creative> crlist = cpmgrFacade.getCreativeList(map);
		List<Map<String, String>> targetlist = cpmgrFacade.getTargetList(map);
		
		// 위치목록
		List<Slot> adsslotlist = sitemgrFacade.getSlotList(map);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("cp", cp);
		resultMap.put("adslist", adslist);
		resultMap.put("crlist", crlist);
		resultMap.put("targetlist", targetlist);
		resultMap.put("adsslotlist", adsslotlist);

		return new ModelAndView("campaign/cp_ads_list", "response", resultMap);
	}
	/*
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
	}*/
	public ModelAndView adsInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String adsid = StringUtil.isNull(request.getParameter("adsid"));
		
		Map<String, String> map = new HashMap<String, String>();	
		
		

		// 애즈 정보
		map.put("adsid", adsid);		
		Ads ads = cpmgrFacade.getAds(map);	
		// 캠페인 정보
		map.put("cpid", ads.getCpid());		
		Campaign cp = cpmgrFacade.getCampaign(map);	
		// 타겟팅 정보
		List<Map<String,String>> tglist = cpmgrFacade.getTargetList(map);
		// 타겟구분(메뉴) 목록
		map.put("tbname", "target");
		List<Map<String, String>> codelist = cpmgrFacade.getCodeList(map);		// 애즈 목록
		map.put("stat", "1");				
		List<Ads> adslist = cpmgrFacade.getAdsList(map);
		// 광고물 목록
		map.put("cpid", ads.getCpid());		
		map.put("adsid", adsid);		
		List<Creative> crlist = cpmgrFacade.getCreativeList(map);
		// 위치목록
		List<Slot> adsslotlist = sitemgrFacade.getSlotList(map);
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("cp", cp);
		resultMap.put("ads", ads);
		resultMap.put("adslist", adslist);
		resultMap.put("codelist", codelist);
		resultMap.put("tglist", tglist);
		resultMap.put("crlist", crlist);
		resultMap.put("adsslotlist", adsslotlist);

		return new ModelAndView("campaign/ads_info", "response", resultMap);
	}
	public ModelAndView adsEdit(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		String adsid = StringUtil.isNull(request.getParameter("adsid"));
		return new ModelAndView("redirect:cpmgr.do?a=adsEditTarget&adsid="+adsid, null);

		/*
		
		Map<String, String> map = new HashMap<String, String>();	
		
		

		// 애즈 정보
		map.put("adsid", adsid);		
		Ads ads = cpmgrFacade.getAds(map);	
		// 캠페인 정보
		map.put("cpid", ads.getCpid());		
		Campaign cp = cpmgrFacade.getCampaign(map);	
		// 타겟팅 정보
		map.clear();
		map.put("adsid", adsid);		
		map.put("mode", "E");
		List<Map<String, String>> tglist = cpmgrFacade.getTargetList(map);		
		// 타겟구분(메뉴) 목록
		map.put("tbname", "target");
		List<Map<String, String>> codelist = cpmgrFacade.getCodeList(map);

		// 광고물 목록
		map.put("cpid", ads.getCpid());		
		map.put("adsid", adsid);		
		List<Creative> crlist = cpmgrFacade.getCreativeList(map);
		// 위치목록
		List<Slot> adsslotlist = sitemgrFacade.getSlotList(map);
		// 애즈 목록
		map.clear();
		map.put("stat", "1");				
		map.put("cpid", ads.getCpid());		
		List<Ads> adslist = cpmgrFacade.getAdsList(map);
	
		
		
		//위치목록 추가리스트
		map.clear();
		map.put("prtype", ads.getPrtype());		
		List<Map<String, String>> grouplist = sitemgrFacade.getSlgroupList(map);

		map.clear();
		map.put("prtype", ads.getPrtype());		
		map.put("order_str", "sitename");
		List<Map<String, String>> sitelist = sitemgrFacade.getSiteList(map);
		
		map.clear();
		map.put("prtype", ads.getPrtype());		
		map.put("order_str", "secname");
		List<Map<String, String>> seclist = sitemgrFacade.getSectionList(map);
		map.clear();
		map.put("prtype", ads.getPrtype());		
		map.put("order_str", "slotname");
		List<Slot> slotlist = sitemgrFacade.getSlotList(map);
		
		// 광고물 상태 목록
		map.clear();
		map.put("code", "cr_state");
		List<Map<String, String>> crstat_code = cpmgrFacade.getCodeList(map);		
	
		
		//애즈 선택 옵션 목록
		map.clear();
		map.put("tbname", "ads");
		map.put("not_code", "ads_state");
		List<Map<String, String>> ads_code = cpmgrFacade.getCodeList(map);	
		
		//애즈 상태 변경 가능한 상태만
		map.clear();
		map.put("curid", ads.getAds_state());
		List<Map<String, String>> nxtcodelist = cpmgrFacade.getCodeList(map);	
		ads_code.addAll(nxtcodelist);
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("cp", cp);
		resultMap.put("ads", ads);
		resultMap.put("adslist", adslist);
		resultMap.put("codelist", codelist);
		resultMap.put("tglist", tglist);
		resultMap.put("crlist", crlist);
		resultMap.put("adsslotlist", adsslotlist);
		resultMap.put("grouplist", grouplist);
		resultMap.put("sitelist", sitelist);
		resultMap.put("seclist", seclist);
		resultMap.put("slotlist", slotlist);
		resultMap.put("ads_code", ads_code);
		resultMap.put("crstat_code", crstat_code);

		return new ModelAndView("campaign/ads_edit", "response", resultMap);
		*/
	}
	public ModelAndView adsTarget(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String adsid = StringUtil.isNull(request.getParameter("adsid"));
		
		Map<String, String> map = new HashMap<String, String>();	
		
		

		// 애즈 정보
		map.put("adsid", adsid);		
		Ads ads = cpmgrFacade.getAds(map);	
		// 캠페인 정보
		map.put("cpid", ads.getCpid());		
		Campaign cp = cpmgrFacade.getCampaign(map);	
		// 타겟팅 정보
		map.clear();
		map.put("adsid", adsid);		
		map.put("mode", "E");
		List<Map<String, String>> targetlist = cpmgrFacade.getTargetList(map);		
		// 타겟구분(메뉴) 목록
		map.put("tbname", "target");
		List<Map<String, String>> codelist = cpmgrFacade.getCodeList(map);
		
		// 애즈 목록
		map.clear();
		map.put("stat", "1");				
		map.put("cpid", ads.getCpid());		
		List<Ads> adslist = cpmgrFacade.getAdsList(map);

		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("cp", cp);
		resultMap.put("ads", ads);
		resultMap.put("adslist", adslist);
		resultMap.put("targetlist", targetlist);
		resultMap.put("codelist", codelist);

		return new ModelAndView("campaign/ads_targeting", "response", resultMap);
	}
	
	public ModelAndView adsEditCreative(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String adsid = StringUtil.isNull(request.getParameter("adsid"));
		String mode = StringUtil.isNull(request.getParameter("mode"));
		
		Map<String, String> map = new HashMap<String, String>();	
		
		
		/************************** 공통 *****************************/
		// 애즈 정보
		map.put("adsid", adsid);		
		Ads ads = cpmgrFacade.getAds(map);	

		// 캠페인 정보
		map.put("cpid", ads.getCpid());		
		Campaign cp = cpmgrFacade.getCampaign(map);	
	
		// 애즈 목록
		map.clear();
		map.put("stat", "1");				
		map.put("cpid", ads.getCpid());		
		List<Ads> adslist = cpmgrFacade.getAdsList(map);	
		
		//애즈 선택 옵션 목록
		map.clear();
		map.put("tbname", "ads");
		map.put("not_code", "ads_state");
		List<Map<String, String>> ads_code = cpmgrFacade.getCodeList(map);	
		
		//애즈 상태 변경 가능한 상태만
		map.clear();
		map.put("curid", ads.getAds_state());
		List<Map<String, String>> nxtcodelist = cpmgrFacade.getCodeList(map);	
		ads_code.addAll(nxtcodelist);
		/*******************************************************/
		
		// 광고물
		map.put("cpid", ads.getCpid());		
		map.put("adsid", adsid);		
		List<Creative> crlist = cpmgrFacade.getCreativeList(map);
		// 광고물 상태 목록
		map.clear();
		map.put("code", "cr_state");
		List<Map<String, String>> crstat_code = cpmgrFacade.getCodeList(map);		
		
		System.out.println("crstat_code="+crstat_code);

		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("cp", cp);
		resultMap.put("ads", ads);
		resultMap.put("adslist", adslist);
		resultMap.put("ads_code", ads_code);
		/*******************************************************/
		resultMap.put("crlist", crlist);
		resultMap.put("crstat_code", crstat_code);
		resultMap.put("mode", mode);


		return new ModelAndView("campaign/ads_edit_creative", "response", resultMap);
	}
	public ModelAndView adsEditTarget(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String adsid = StringUtil.isNull(request.getParameter("adsid"));
		
		Map<String, String> map = new HashMap<String, String>();	
		
		
		/************************** 공통 *****************************/
		// 애즈 정보
		map.put("adsid", adsid);		
		Ads ads = cpmgrFacade.getAds(map);	

		// 캠페인 정보
		map.put("cpid", ads.getCpid());		
		Campaign cp = cpmgrFacade.getCampaign(map);	
	
		// 애즈 목록
		map.clear();
		map.put("stat", "1");				
		map.put("cpid", ads.getCpid());		
		List<Ads> adslist = cpmgrFacade.getAdsList(map);	
		
		//애즈 선택 옵션 목록
		map.clear();
		map.put("tbname", "ads");
		map.put("not_code", "ads_state");
		List<Map<String, String>> ads_code = cpmgrFacade.getCodeList(map);	
		
		//애즈 상태 변경 가능한 상태만
		map.clear();
		map.put("curid", ads.getAds_state());	
		List<Map<String, String>> nxtcodelist = cpmgrFacade.getCodeList(map);	
		ads_code.addAll(nxtcodelist);
		/*******************************************************/
		
		// 타겟팅 정보
		map.clear();
		map.put("adsid", adsid);		
		map.put("mode", "E");
		List<Map<String, String>> tglist = cpmgrFacade.getTargetList(map);		
		// 타겟구분(메뉴) 목록
		map.put("tbname", "target");
		List<Map<String, String>> tgcodelist = cpmgrFacade.getCodeList(map);

		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("cp", cp);
		resultMap.put("ads", ads);
		resultMap.put("adslist", adslist);
		resultMap.put("ads_code", ads_code);
		/*******************************************************/
		resultMap.put("tglist", tglist);
		resultMap.put("tgcodelist", tgcodelist);

		return new ModelAndView("campaign/ads_edit_target", "response", resultMap);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public ModelAndView adsEditSlot(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String adsid = StringUtil.isNull(request.getParameter("adsid"));
		
		Map<String, String> map = new HashMap<String, String>();	
		
		
		/************************** 공통 *****************************/
		// 애즈 정보
		map.put("adsid", adsid);		
		Ads ads = cpmgrFacade.getAds(map);	

		// 캠페인 정보
		map.put("cpid", ads.getCpid());		
		Campaign cp = cpmgrFacade.getCampaign(map);	
	
		// 애즈 목록
		map.clear();
		map.put("stat", "1");				
		map.put("cpid", ads.getCpid());		
		List<Ads> adslist = cpmgrFacade.getAdsList(map);	
		
		//애즈 선택 옵션 목록
		map.clear();
		map.put("tbname", "ads");
		map.put("not_code", "ads_state");
		List<Map<String, String>> ads_code = cpmgrFacade.getCodeList(map);	
		
		//애즈 상태 변경 가능한 상태만
		map.clear();
		map.put("curid", ads.getAds_state());
		List<Map<String, String>> nxtcodelist = cpmgrFacade.getCodeList(map);	
		ads_code.addAll(nxtcodelist);
		
		
		/*******************************************************/
	
		// 위치목록
		map.clear();
		map.put("cpid", ads.getCpid());		
		map.put("adsid", adsid);		
				
		List<Slot> adsslotlist = sitemgrFacade.getSlotList(map);	
		
		
		
		
		
		
		//위치목록 추가리스트
		map.clear();
		map.put("prtype", ads.getPrtype());		
		List<Map<String, String>> grouplist = sitemgrFacade.getSlgroupList(map);

		map.clear();
		map.put("prtype", ads.getPrtype());		
		map.put("order_str", "sitename");
		List<Map<String, String>> sitelist = sitemgrFacade.getSiteList(map);
		
		map.clear();
		map.put("prtype", ads.getPrtype());		
		map.put("order_str", "secname");
		List<Map<String, String>> seclist = sitemgrFacade.getSectionList(map);
		map.clear();
		map.put("prtype", ads.getPrtype());		
		map.put("order_str", "slotname");
		List<Slot> slotlist = sitemgrFacade.getSlotList(map);
		
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("cp", cp);
		resultMap.put("ads", ads);
		resultMap.put("adslist", adslist);
		resultMap.put("ads_code", ads_code);
		/*******************************************************/
		resultMap.put("grouplist", grouplist);
		resultMap.put("sitelist", sitelist);
		resultMap.put("seclist", seclist);
		resultMap.put("slotlist", slotlist);
		resultMap.put("adsslotlist", adsslotlist);

		return new ModelAndView("campaign/ads_edit_slot", "response", resultMap);
	}
	
	public ModelAndView adsCreative(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String adsid = StringUtil.isNull(request.getParameter("adsid"));
		
		Map<String, String> map = new HashMap<String, String>();	
		
		

		// 애즈 정보
		map.put("adsid", adsid);		
		Ads ads = cpmgrFacade.getAds(map);	
		// 캠페인 정보
		map.put("cpid", ads.getCpid());		
		Campaign cp = cpmgrFacade.getCampaign(map);	
		// 광고물
		List<Creative> crlist = cpmgrFacade.getCreativeList(map);
		// 광고물 상태 목록
		map.put("code", "cr_state");
		List<Map<String, String>> codelist = cpmgrFacade.getCodeList(map);		
		
		// 애즈 목록
		map.clear();
		map.put("stat", "1");				
		map.put("cpid", ads.getCpid());		
		List<Ads> adslist = cpmgrFacade.getAdsList(map);

		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("cp", cp);
		resultMap.put("ads", ads);
		resultMap.put("adslist", adslist);
		resultMap.put("crlist", crlist);
		resultMap.put("codelist", codelist);


		return new ModelAndView("campaign/ads_creative", "response", resultMap);
	}
	
	public ModelAndView adsSlot(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String adsid = StringUtil.isNull(request.getParameter("adsid"));
		
		Map<String, String> map = new HashMap<String, String>();	
		
		

		// 애즈 정보
		map.put("adsid", adsid);		
		Ads ads = cpmgrFacade.getAds(map);	
		// 캠페인 정보
		map.put("cpid", ads.getCpid());		
		Campaign cp = cpmgrFacade.getCampaign(map);	
		// 위치목록
		List<Slot> adsslotlist = sitemgrFacade.getSlotList(map);
		
		// 애즈 목록
		map.clear();
		map.put("stat", "1");				
		map.put("cpid", ads.getCpid());		
		List<Ads> adslist = cpmgrFacade.getAdsList(map);

		
		//
		List<Map<String, String>> grouplist = sitemgrFacade.getSlgroupList(map);

		map.clear();
		map.put("order_str", "sitename");
		List<Map<String, String>> sitelist = sitemgrFacade.getSiteList(map);
		
		map.clear();
		map.put("order_str", "secname");
		List<Map<String, String>> seclist = sitemgrFacade.getSectionList(map);
		map.clear();
		map.put("order_str", "slotname");
		List<Slot> slotlist = sitemgrFacade.getSlotList(map);
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("cp", cp);
		resultMap.put("ads", ads);
		resultMap.put("adslist", adslist);
		resultMap.put("grouplist", grouplist);
		resultMap.put("sitelist", sitelist);
		resultMap.put("seclist", seclist);
		resultMap.put("slotlist", slotlist);
		resultMap.put("adsslotlist", adsslotlist);
		return new ModelAndView("campaign/ads_slot", "response", resultMap);
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
		String sday = StringUtil.isNull(request.getParameter("sday"));
		String eday = StringUtil.isNull(request.getParameter("eday"));
		String state = StringUtil.isNull(request.getParameter("state"));
		String page = StringUtil.isNull(request.getParameter("p"));
		String sch_column = StringUtil.isNull(request.getParameter("sch_column"));
		String sch_text = StringUtil.isNull(request.getParameter("sch_text"));
		sch_text = new String (sch_text.getBytes("8859_1"),"UTF-8");
		
			
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
		map.put("sday", StringUtil.DateStr(sday));
		map.put("eday", StringUtil.DateStr(eday));
		map.put("skip", String.valueOf(skip));
		map.put("max", String.valueOf(max))	;
		map.put("sch_text", sch_text);
		map.put("sch_column", sch_column);		
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

		
		return new ModelAndView("campaign/cp_list", "response", resultMap);
	}	
	
	public ModelAndView adsList(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String state = StringUtil.isNull(request.getParameter("state"));
		String page = StringUtil.isNull(request.getParameter("p"));
		String sday = StringUtil.DateStr(StringUtil.isNull(request.getParameter("sday")));
		String eday = StringUtil.DateStr(StringUtil.isNull(request.getParameter("eday")));
		String sch_column = StringUtil.isNull(request.getParameter("sch_column"));
		String sch_text = StringUtil.isNull(request.getParameter("sch_text"));
		sch_text = new String (sch_text.getBytes("8859_1"),"UTF-8");
		
		
		Map<String, String> map = new HashMap<String, String>();	
		
		map.put("stat", "1");				
		if (page.equals("")) {
			page = "1";
		}
		Integer max = Constant.PAGE_LIST_L;
		Integer skip = (Integer.parseInt(page)-1)*max;
		
		map.put("ads_state", state)	;
		map.put("sday", StringUtil.DateStr(sday));
		map.put("eday", StringUtil.DateStr(eday));
		map.put("skip", String.valueOf(skip))	;
		map.put("max", String.valueOf(max))	;
		map.put("sch_text", sch_text);
		map.put("sch_column", sch_column);		
		List<Ads> adslist = cpmgrFacade.getAdsList(map);
		Integer totalCount = cpmgrFacade.getAdsCnt(map);
		//상태 목록
		map.put("code", "ads_state");
		List<Map<String, String>> stlist = cpmgrFacade.getCodeList(map);	

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("adslist", adslist);
		resultMap.put("stlist", stlist);
		resultMap.put("skip", skip);
		resultMap.put("max", max);
		resultMap.put("totalCount", totalCount);
		resultMap.put("nowPage", page);	
		resultMap.put("sday", sday);	
		resultMap.put("eday", eday);	
		return new ModelAndView("campaign/ads_list", "response", resultMap);
	}	
	
	public ModelAndView targetList(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String s_type = StringUtil.isNull(request.getParameter("s_type"));
		String page = StringUtil.isNullReplace(request.getParameter("p"),"1");
		String sch_column = StringUtil.isNull(request.getParameter("sch_column"));
		String sch_text = StringUtil.isNull(request.getParameter("sch_text"));
		sch_text = new String (sch_text.getBytes("8859_1"),"UTF-8");

		Integer max = Constant.PAGE_LIST_L;
		Integer skip = (Integer.parseInt(page)-1)*max;
		
		Map<String, String> map = new HashMap<String, String>();
	    
		map.put("targettype", s_type)	;
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
			List<Slot> slotlist = sitemgrFacade.getSlotList(map);	
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
		
		// 타겟구분 목록
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
			List<Slot> slotlist = sitemgrFacade.getSlotList(map);	
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
		System.out.println("tgtype=============="+tgtype);	
		String userID = (String)SessionUtil.getAttribute("userID");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("tid", tid);
		map.put("targetname", targetname);
		map.put("updatedate", DateUtil.simpleDate2());
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
			amap.put("updateuser", userID);
			amap.put("updatedate", DateUtil.simpleDate2());
			cpmgrFacade.modTargetSystem(amap);
		} 
		// IP 타겟팅
		else if(tgtype.equals("2")){
			
			String[] ip_from = request.getParameterValues("ip_from");
			String[] ip_to = request.getParameterValues("ip_to");
			String[] ip_alias = request.getParameterValues("ip_alias");
			
			
			
			ArrayList<Map<String,String>> list = new ArrayList<Map<String,String>>();
			System.out.println("ip_from.length="+ip_from.length);
			for(int i=0; i<ip_from.length;i++){
				if(!StringUtil.isNull(ip_from[i].trim()).equals("")) {
					
			         Map<String, String> ipmap = new HashMap<String, String>();

			         ipmap.put("tid", tid);
			         ipmap.put("ip_from", ip_from[i].trim());
			         ipmap.put("ip_to", ip_to[i].trim());
			         ipmap.put("ip_alias", StringUtil.isNull(ip_alias[i].trim()));
			         ipmap.put("updateuser", userID);
			         ipmap.put("updatedate", DateUtil.simpleDate2());

					System.out.println(i+") Map : " + ipmap);
					list.add(ipmap);					
				}
			}
			System.out.println("map=============="+map);
					cpmgrFacade.modTargetIP(map);			
					System.out.println("list=============="+list);
			cpmgrFacade.addTargetIP(list);
			cpmgrFacade.delTargetIP(map);			
		} 
		// 카테고리 타겟팅
		else if(tgtype.equals("3")){
			String category = StringUtil.isNullZero(request.getParameter("category"));
			amap.put("tid", tid.toString());
			amap.put("category", category);
			amap.put("updateuser", userID);
			amap.put("updatedate", DateUtil.simpleDate2());
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
			amap.put("updateuser", userID);
			amap.put("updatedate", DateUtil.simpleDate2());
				
			cpmgrFacade.modTargetCountry(amap);
			
		}
		//채널 타겟팅
		else if(tgtype.equals("5")){
			String excflag = StringUtil.isNullZero(request.getParameter("excflag"));
			String slotid = StringUtil.isNullZero(request.getParameter("slotid"));
			amap.put("tid", tid.toString());
			amap.put("excflag", excflag);
			amap.put("slotid", slotid);
		
			cpmgrFacade.modTargetChannel(amap);
			
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
			         ipmap.put("updateuser", userID);
			         ipmap.put("updatedate", DateUtil.simpleDate2());
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
		map.put("updatedate", DateUtil.simpleDate2());
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
			cpmgrFacade.addTargetIP(list);
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
		sch_text = new String (sch_text.getBytes("8859_1"),"UTF-8");

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
		map.put("updatedate", DateUtil.simpleDate2());
		if(!tmpid.equals("") && mode.equals("E")) {
			map.put("tmpid", tmpid);				
			cpmgrFacade.modTemplate(map);
		} else {
			cpmgrFacade.addTemplate(map);
		}
		
		
		return new ModelAndView("redirect:cpmgr.do?a=tmpList", null);
	}
	public ModelAndView crList(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String state = StringUtil.isNull(request.getParameter("state"));
		String prtype = StringUtil.isNull(request.getParameter("prtype"));
		String width = StringUtil.isNull(request.getParameter("width"));
		String height = StringUtil.isNull(request.getParameter("height"));
		String page = StringUtil.isNullReplace(request.getParameter("p"),"1");
		String sch_column = StringUtil.isNull(request.getParameter("sch_column"));
		String sch_text = StringUtil.isNull(request.getParameter("sch_text"));
		sch_text = new String (sch_text.getBytes("8859_1"),"UTF-8");

		String sday = StringUtil.DateStr(StringUtil.isNull(request.getParameter("sday")));
		String eday = StringUtil.DateStr(StringUtil.isNull(request.getParameter("eday")));
		if(sday.equals("")) {
			  sday = DateUtil.getPreMon(DateUtil.curDate(), 3);
			  eday = DateUtil.curDate();
		}
		Integer max = Constant.PAGE_LIST_L;
		Integer skip = (Integer.parseInt(page)-1)*max;
		
		Map<String, String> map = new HashMap<String, String>();
	    
		map.put("cr_state", state);
		map.put("sday", StringUtil.DateStr(sday));
		map.put("eday", StringUtil.DateStr(eday));
		map.put("prtype", prtype);
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
		resultMap.put("sday", sday);		
		resultMap.put("eday", eday);		
		return new ModelAndView("campaign/creative_list", "response", resultMap);
	}
	public ModelAndView crAddForm(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String mode = StringUtil.isNull(request.getParameter("mode"));
		String newClientid = StringUtil.isNull(request.getParameter("newClientid"));
		String newClientname = StringUtil.isNull(request.getParameter("newClientname"));
		
		Map<String, String> map = new HashMap<String, String>();	
		
		//광고상품 목록
		map.put("code", "prtype");
		List<Map<String, String>> codelist = cpmgrFacade.getCodeList(map);	

		map.clear();
		map.put("order_str", "tmpname");
		List<Map<String, String>> tmplist = cpmgrFacade.getTemplateList(map);
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("codelist", codelist);
		resultMap.put("tmplist", tmplist);
		resultMap.put("newClientid", newClientid);
		resultMap.put("newClientname", newClientname);
		resultMap.put("mode", mode);

		return new ModelAndView("campaign/cr_edit", "response", resultMap);
	}
	
	public ModelAndView adsCrAdd(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String adsid = StringUtil.isNull(request.getParameter("adsid"));
		String newClientid = StringUtil.isNull(request.getParameter("newClientid"));
		String newClientname = StringUtil.isNull(request.getParameter("newClientname"));
		newClientname = new String (newClientname.getBytes("8859_1"),"UTF-8");

		Map<String, String> map = new HashMap<String, String>();	
		
		//광고상품 목록
		map.put("code", "prtype");
		List<Map<String, String>> codelist = cpmgrFacade.getCodeList(map);	

		map.clear();
		map.put("order_str", "tmpname");
		List<Map<String, String>> tmplist = cpmgrFacade.getTemplateList(map);
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("codelist", codelist);
		resultMap.put("tmplist", tmplist);
		resultMap.put("newClientid", newClientid);
		resultMap.put("newClientname", newClientname);
		resultMap.put("adsid", adsid);

		return new ModelAndView("campaign/ads_new_creative", "response", resultMap);
	}	
	public ModelAndView upload(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
}
