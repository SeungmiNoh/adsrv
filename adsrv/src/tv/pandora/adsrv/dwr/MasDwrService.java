package tv.pandora.adsrv.dwr;

import java.io.InputStreamReader;
import java.io.Writer;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.web.servlet.ModelAndView;

import tv.pandora.adsrv.common.util.DateUtil;
import tv.pandora.adsrv.common.util.StringUtil;
import tv.pandora.adsrv.domain.Campaign;
import tv.pandora.adsrv.domain.Creative;
import tv.pandora.adsrv.domain.Slot;
import tv.pandora.adsrv.domain.User;
import tv.pandora.adsrv.model.SitemgrModel;
import tv.pandora.adsrv.model.UsermgrModel;
import tv.pandora.adsrv.model.CpmgrModel;


public class MasDwrService {
	
	private static Logger log = Logger.getLogger(MasDwrService.class);
	
	private UsermgrModel usermgrModel;
	private SitemgrModel sitemgrModel;
	private CpmgrModel cpmgrModel;

	public void setUsermgrModel(UsermgrModel usermgrModel) {
		this.usermgrModel = usermgrModel;
	}
	public void setSitemgrModel(SitemgrModel sitemgrModel) {
		this.sitemgrModel = sitemgrModel;
	}
	public void setCpmgrModel(CpmgrModel cpmgrModel) {
		this.cpmgrModel = cpmgrModel;
	}
	public Campaign getCampaign(String cpid){
		
		Map<String, String> map = new HashMap<String, String>();	
		map.put("cpid", cpid);				
		return cpmgrModel.getCampaign(map);
	}
	public Integer getCreativeCnt(String crname, String not_crid){
		Map<String, String> map = new HashMap<String, String>();	
		map.put("crname", crname.trim());
		if(!not_crid.equals("0")) map.put("not_crid", not_crid);
		return cpmgrModel.getCreativeCnt(map);
	}
	public Integer delClick(String crid, String ckid){
		try
		{
			Map<String, String> map = new HashMap<String, String>();	
			map.put("crid", crid);
			map.put("ckid", ckid);
			cpmgrModel.delClick(map);
			return 1;
		} catch(Exception e) {
			return -1;
		}
	}	
	public Integer delFile(String crid, String fileidx){
		try
		{
			Map<String, String> map = new HashMap<String, String>();	
			map.put("crid", crid);
			map.put("fileidx", fileidx);
			cpmgrModel.delFile(map);
			return 1;
		} catch(Exception e) {
			return -1;
		}
	}
	public Integer getCorpCnt(String corpname){
		Map<String, String> map = new HashMap<String, String>();	
		map.put("corpname", corpname.trim());
		return usermgrModel.getCorpCnt(map);
	}
	public Integer getCorpCnt(String corpname, String corpid){
		Map<String, String> map = new HashMap<String, String>();	
		map.put("corpname", corpname.trim());
		map.put("not_corpid", corpid);
		return usermgrModel.getCorpCnt(map);
	}	
	public Map<String,String> getCorporation(String corpid){
		
		Map<String, String> map = new HashMap<String, String>();	
		map.put("corpid", corpid);				
		return usermgrModel.getCorporation(map);
	}
	
	public List<Map<String,String>> getUserPerList(){
		Map<String, String> map = new HashMap<String, String>();	
		return usermgrModel.getUserPerList(map);
	}
	public Integer getUserCnt(String loginid, String not_userid){
		Map<String, String> map = new HashMap<String, String>();	
		map.put("loginid", loginid.trim());
		if(!not_userid.equals("0")) map.put("not_userid", not_userid);
		return usermgrModel.getUserCnt(map);
	}
	public Integer getUserPerCnt(String psername, String not_perid){
		Map<String, String> map = new HashMap<String, String>();	
		map.put("psername", psername.trim());
		if(!not_perid.equals("0")) map.put("not_perid", not_perid);
		return usermgrModel.getUserPerCnt(map);
	}   
	public User getUser(String userid){
		Map<String, String> map = new HashMap<String, String>();	
		map.put("userid", userid.trim());
		return usermgrModel.getUserList(map).get(0);
	}
	public void delPermission(String perid, String userid){
		Map<String, String> map = new HashMap<String, String>();	
		map.put("perid", perid);
		map.put("stat", "0");
		map.put("updatedate", DateUtil.simpleDate2())	;
		map.put("updateuser", userid)	;
		usermgrModel.modPermission(map);
	}
	public Map<String,String> getSite(String siteid){
		
		Map<String, String> map = new HashMap<String, String>();	
		map.put("siteid", siteid);				
		return sitemgrModel.getSite(map);
	}
	public Map<String,String> getSection(String secid){
		
		Map<String, String> map = new HashMap<String, String>();	
		map.put("secid", secid);				
		return sitemgrModel.getSection(map);
	}
	public Slot getSlot(String slotid){
		
		Map<String, String> map = new HashMap<String, String>();	
		map.put("slotid", slotid);				
		return sitemgrModel.getSlot(map);
	}
	public Integer getSiteCnt(String sitetag, String not_siteid){
		Map<String, String> map = new HashMap<String, String>();	
		map.put("sitetag", sitetag.trim());
		if(!not_siteid.equals("0")) map.put("not_siteid", not_siteid);
		return sitemgrModel.getSiteCnt(map);
	}
	public Integer getSecCnt(String sectag, String siteid, String not_secid){
		Map<String, String> map = new HashMap<String, String>();	
		map.put("siteid", siteid);
		map.put("sectag", sectag.trim());
		if(!not_secid.equals("0")) {
			map.put("not_secid", not_secid);
		}
		Integer cnt = sitemgrModel.getSectionCnt(map);
		System.out.println("cnt=="+cnt);
		return cnt;
	}
	public Integer getSlotCnt(String slottag, String siteid, String not_slotid){
		Map<String, String> map = new HashMap<String, String>();	
		map.put("siteid", siteid);
		map.put("slottag", slottag.trim());
		if(!not_slotid.equals("0")) map.put("not_slotid", not_slotid);
		return sitemgrModel.getSlotCnt(map);
	}
	public Integer getSlgroupCnt(String groupname, String not_groupid){
		Map<String, String> map = new HashMap<String, String>();	
		map.put("groupname", groupname);
		if(!not_groupid.equals("0"))  map.put("not_groupid", not_groupid);
		
		return sitemgrModel.getSlgroupCnt(map);
	}
	public Map<String,String> getSlgroup(String groupid){
		Map<String, String> map = new HashMap<String, String>();	
		map.put("groupid", groupid);		
		Map<String,String> resultmap = sitemgrModel.getSlgroup(map);
		return resultmap;
	}
	
	public List<Map<String,String>> getSlgroupInSlotList(String adsid, String groupid){
		Map<String, String> map = new HashMap<String, String>();	
		map.put("adsid", adsid);		
		map.put("groupid", groupid);		
		List<Map<String,String>> resultmap = sitemgrModel.getSlgroupInSlotList(map);
		return resultmap;
	}
	public List<Slot> getSlotSearchList(String adsid, String prtype, String siteid, String secid, String slotid){
		Map<String, String> map = new HashMap<String, String>();	
		map.put("adsid", adsid);		
		map.put("prtype", "");
		if(!siteid.equals("0")) map.put("siteid", siteid);
		if(!secid.equals("0")) map.put("secid", secid);
		if(!slotid.equals("0")) map.put("slotid", slotid);
		map.put("search", "Y");
		List<Slot> resultmap = sitemgrModel.getSlotList(map);
		return resultmap;
	}
	public List<Map<String,String>> getSlotRunAdsList(String slotid, String ads_startdate, String ads_enddate){
		Map<String, String> map = new HashMap<String, String>();	
		map.put("slotid", slotid);
		map.put("ads_startdate", ads_startdate);
		map.put("ads_enddate", ads_enddate);		
		return sitemgrModel.getSlotRunAdsList(map);
		
	}
	public List<Slot> getSlotList(String prtype, String width, String height,  String siteid){
		Map<String, String> map = new HashMap<String, String>();	
		map.put("prtype", prtype);
		map.put("siteid", siteid);
		map.put("width", width);
		map.put("height", height);
				
		List<Slot> resultmap = sitemgrModel.getSlotList(map);
		return resultmap;
	}
	public Integer addAdsNewCreative(String adsid, String new_crstr){
		try
		{
			Map<String, String> map = new HashMap<String, String>();	
			map.put("adsid", adsid);
			map.put("new_crstr", new_crstr);
			cpmgrModel.addAdsNewCreative(map);
			return 1;
		} catch(Exception e) {
			return 0;
		}
	}
	public List<Creative> getCrList(String start, String end,  String clientid,  String adsid){
		Map<String, String> map = new HashMap<String, String>();	
		map.put("start", StringUtil.DateStr(start));
		map.put("end", StringUtil.DateStr(end));
		map.put("clientid", clientid);
		map.put("adsid", adsid);
		map.put("pop", "pop");
		List<Creative> resultmap = cpmgrModel.getCreativeList(map);
		return resultmap;
	}
	 /*
	public Integer addAdsSlot(String adsid, String slotid, String userid){
		try
		{
			Map<String, String> map = new HashMap<String, String>();	
			map.put("adsid", adsid);
			map.put("slotid", slotid);
			map.put("insertdate", DateUtil.simpleDate2());
			map.put("insertuser", userid);
			cpmgrModel.addAdsSlot(map);
			return 1;
		} catch(Exception e) {
			return 0;
		}
	}*/
	public Integer modAdsSlot(String adsid, String slotid, String slot_state, String userid){
		try
		{
			Map<String, String> map = new HashMap<String, String>();	
			map.put("adsid", adsid);
			map.put("slotid", slotid);
			map.put("slot_state", slot_state);
			map.put("updatedate", DateUtil.simpleDate2());
			map.put("updateuser", userid);
			cpmgrModel.modAdsSlot(map);
			return 1;
		} catch(Exception e) {
			return 0;
		}
	}
	public Integer modAdsSlotStr(String adsid, String slot_str, String slot_state, String userid){
		try
		{
			Map<String, String> map = new HashMap<String, String>();	
			map.put("adsid", adsid);
			map.put("slot_str", slot_str);
			map.put("slot_state", slot_state);
			map.put("updatedate", DateUtil.simpleDate2());
			map.put("updateuser", userid);
			cpmgrModel.modAdsSlot(map);
			return 1;
		} catch(Exception e) {
			return 0;
		}
	}
	
	
	public Integer delAdsSlot(String adsid, String slotid, String userid){
		try
		{
			Map<String, String> map = new HashMap<String, String>();	
			map.put("adsid", adsid);
			map.put("slotid", slotid);
			map.put("stat", "0");
			map.put("updatedate", DateUtil.simpleDate2());
			map.put("updateuser", userid);
			cpmgrModel.modAdsSlot(map);
			return 1;
		} catch(Exception e) {
			return 0;
		}
	}
	
	public Slot getAdsSlot(String adsid, String slotid){
		try
		{
			Map<String, String> map = new HashMap<String, String>();	
			map.put("adsid", adsid);
			map.put("slotid", slotid);			
			Slot slot = sitemgrModel.getSlotList(map).get(0);
			return slot;
		} catch(Exception e) {
			return null;
		}
	}
	public Integer addAdsSlotByGroup(String adsid, String groupid, String userid){
		try
		{
			Map<String, String> map = new HashMap<String, String>();	
			map.put("adsid", adsid);
			map.put("groupid", groupid);
			map.put("insertdate", DateUtil.simpleDate2());
			map.put("insertuser", userid);
			cpmgrModel.addAdsSlotByGroup(map);
			return 1;
		} catch(Exception e) {
			return 0;
		}
	}
	
	
	public Map<String,String> getTemplate(String tmpid){
		
		Map<String, String> map = new HashMap<String, String>();	
		map.put("tmpid", tmpid);				
		return cpmgrModel.getTemplate(map);
	}
	/*
	public Integer getSlotList(String width, String height,  String siteid){
		
		
		System.out.println("MasDwrService================"+width);
		Map<String, String> map = new HashMap<String, String>();	
		map.put("width", width);
		map.put("height", height);
		map.put("siteid", siteid);
		//return sitemgrModel.getSlotList(map);
		return sitemgrModel.getSlotCnt(map);
	}*/
}