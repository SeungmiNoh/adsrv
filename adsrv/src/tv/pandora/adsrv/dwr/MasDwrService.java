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
	public Map<String,String> getSlot(String slotid){
		
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
	
	public List<Map<String,String>> getSlgroupInSlotList(String groupid){
System.out.println("---------------getSlgroupInSlotList");		
		Map<String, String> map = new HashMap<String, String>();	
		map.put("groupid", groupid);		
		System.out.println("---------------map"+map);		
		List<Map<String,String>> resultmap = sitemgrModel.getSlgroupInSlotList(map);
		return resultmap;
	}
	public List<Map<String,String>> getSlotList(String width, String height,  String siteid){
		Map<String, String> map = new HashMap<String, String>();	
		map.put("siteid", siteid);
		map.put("width", width);
		map.put("height", height);
		List<Map<String,String>> resultmap = sitemgrModel.getSlotList(map);
		return resultmap;
	}
	public List<Creative> getCrList(String start, String end,  String clientid){
		Map<String, String> map = new HashMap<String, String>();	
		map.put("start", StringUtil.DateStr(start));
		map.put("end", StringUtil.DateStr(end));
		map.put("clientid", clientid);
		List<Creative> resultmap = cpmgrModel.getCreativeList(map);
		return resultmap;
	}
	 
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