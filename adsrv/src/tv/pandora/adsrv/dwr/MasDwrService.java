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

import tv.pandora.adsrv.model.SitemgrModel;
import tv.pandora.adsrv.model.UsermgrModel;



public class MasDwrService {
	
	private static Logger log = Logger.getLogger(MasDwrService.class);
	
	private UsermgrModel usermgrModel;
	private SitemgrModel sitemgrModel;

	public void setUsermgrModel(UsermgrModel usermgrModel) {
		this.usermgrModel = usermgrModel;
	}
	public void setSitemgrModel(SitemgrModel sitemgrModel) {
		this.sitemgrModel = sitemgrModel;
	}

	public Integer getCorpCnt(String corpname){
		Map<String, String> map = new HashMap<String, String>();	
		map.put("corpname", corpname.trim());
		return usermgrModel.getCorpCnt(map);
	}
	public Integer getSiteCnt(String sitetag){
		Map<String, String> map = new HashMap<String, String>();	
		map.put("sitetag", sitetag.trim());
		return sitemgrModel.getSiteCnt(map);
	}
	public Integer getSecCnt(String sectag, String siteid){
		Map<String, String> map = new HashMap<String, String>();	
		map.put("siteid", siteid);
		map.put("sectag", sectag.trim());
		return sitemgrModel.getSectionCnt(map);
	}
	public Integer getSlotCnt(String slottag, String siteid){
		Map<String, String> map = new HashMap<String, String>();	
		map.put("siteid", siteid);
		map.put("slottag", slottag.trim());
		return sitemgrModel.getSlotCnt(map);
	}
	public Integer getSlotGroupCnt(String groupname){
		Map<String, String> map = new HashMap<String, String>();	
		map.put("groupname", groupname);
		
		return sitemgrModel.getSlotGroupCnt(map);
	}
	public List<Map<String,String>> getSlotList(String width, String height,  String siteid){
		Map<String, String> map = new HashMap<String, String>();	
		map.put("siteid", siteid);
		map.put("width", width);
		map.put("height", height);
		List<Map<String,String>> resultmap = sitemgrModel.getSlotList(map);
		return resultmap;
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