package tv.pandora.adsrv.dao.ibatis;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.orm.ibatis.SqlMapClientTemplate;

import tv.pandora.adsrv.common.util.StringUtil;
import tv.pandora.adsrv.dao.SitemgrDao;
import tv.pandora.adsrv.domain.Slot;

public class SitemgrDaoiBatis implements SitemgrDao {
	private SqlMapClientTemplate sqlMapClientTemplateMaster;
	public void setSqlMapClientTemplateMaster(
			SqlMapClientTemplate sqlMapClientTemplateMaster) {
		this.sqlMapClientTemplateMaster = sqlMapClientTemplateMaster;
	}

	
	public List<Map<String,String>> getSiteList(Map<String, String> map){	
		String sql = "getSiteList";
		if(StringUtil.isNull(map.get("page")).equals("Y")){
			sql = "getSitePageList";
		}
		try {
			return (List<Map<String,String>>) sqlMapClientTemplateMaster.queryForList(sql, map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public List<Map<String,String>> getSectionList(Map<String, String> map){
		String sql = "getSectionList";
		if(StringUtil.isNull(map.get("page")).equals("Y")){
			sql = "getSectionPageList";
		}
		try {
			return (List<Map<String,String>>) sqlMapClientTemplateMaster.queryForList(sql, map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public List<Slot> getSlotList(Map<String, String> map){
		String sql = "getSlotList";
		if(StringUtil.isNull(map.get("search")).equals("Y")){
			sql = "getSlotSearchList";
		} else if(StringUtil.isNull(map.get("page")).equals("Y")){
			sql = "getSlotPageList";
		} else if(!StringUtil.isNull(map.get("adsid")).equals("") || !StringUtil.isNull(map.get("cpid")).equals("")) {
			sql = "getAdsSlotList";
		}  
		try {
			return (List<Slot>) sqlMapClientTemplateMaster.queryForList(sql, map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	public Integer getSiteCnt(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.queryForObject("getSiteCnt", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public Integer addSite(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.insert("addSite", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public Integer modSite(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.update("modSite", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	public Integer getSectionCnt(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.queryForObject("getSectionCnt", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public Integer addSection(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.insert("addSection", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public Integer modSection(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.update("modSection", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

	public Integer getSlotCnt(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.queryForObject("getSlotCnt", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public Integer addSlot(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.insert("addSlot", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public Integer modSlot(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.update("modSlot", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	public List<Map<String,String>> getSlgroupList(Map<String, String> map){
		String sql = "getSlgroupList";
		if(StringUtil.isNull(map.get("page")).equals("Y")){
			sql = "getSlgroupPageList";
		}
		try {
			return (List<Map<String,String>>) sqlMapClientTemplateMaster.queryForList(sql, map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public List<Map<String,String>> getSlgroupInSlotList(Map<String, String> map){
		try {
			return (List<Map<String,String>>) sqlMapClientTemplateMaster.queryForList("getSlgroupInSlotList", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public Integer getSlgroupCnt(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.queryForObject("getSlgroupCnt", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public Integer addSlgroup(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.insert("addSlgroup", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public Integer modSlgroup(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.update("modSlgroup", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

	
	public void addSlgroupSlot(List<Map<String, String>> list) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("List", list);
		sqlMapClientTemplateMaster.insert("addSlgroupSlot", param);
	}
	
	
	public void modSlgroupSlot(Map<String, String> map){
		try {
			sqlMapClientTemplateMaster.update("modSlgroupSlot", map);
		} catch (EmptyResultDataAccessException e) {
			
		}
	}
	public void delSlgroupSlot(Map<String, String> map){
		try {
			sqlMapClientTemplateMaster.delete("delSlgroupSlot", map);
		} catch (EmptyResultDataAccessException e) {
			
		}
	}
	public void delSlgroup(Map<String, String> map){
		try {
			sqlMapClientTemplateMaster.delete("delSlgroup", map);
		} catch (EmptyResultDataAccessException e) {
			
		}
	}
	public Map<String,String> getSite(Map<String, String> map){
		try {
			return (Map<String,String>) sqlMapClientTemplateMaster.queryForObject("getSite", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public Map<String,String> getSection(Map<String, String> map){
		try {
			return (Map<String,String>) sqlMapClientTemplateMaster.queryForObject("getSection", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public Slot getSlot(Map<String, String> map){
		try {
			return (Slot) sqlMapClientTemplateMaster.queryForObject("getSlot", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public Map<String,String> getSlgroup(Map<String, String> map){
		try {
			return (Map<String,String>) sqlMapClientTemplateMaster.queryForObject("getSlgroup", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public List<Map<String,String>> getSlotRunAdsList(Map<String, String> map){
		try {
			return (List<Map<String,String>>) sqlMapClientTemplateMaster.queryForList("getSlotRunAdsList", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

}
