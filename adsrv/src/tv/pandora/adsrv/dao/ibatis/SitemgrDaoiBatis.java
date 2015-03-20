package tv.pandora.adsrv.dao.ibatis;

import java.util.List;
import java.util.Map;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.orm.ibatis.SqlMapClientTemplate;

import tv.pandora.adsrv.dao.SitemgrDao;

public class SitemgrDaoiBatis implements SitemgrDao {
	private SqlMapClientTemplate sqlMapClientTemplateMaster;
	public void setSqlMapClientTemplateMaster(
			SqlMapClientTemplate sqlMapClientTemplateMaster) {
		this.sqlMapClientTemplateMaster = sqlMapClientTemplateMaster;
	}

	
	public List<Map<String,String>> getSiteList(Map<String, String> map){
		try {
			return (List<Map<String,String>>) sqlMapClientTemplateMaster.queryForList("getSiteList", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public List<Map<String,String>> getSectionList(Map<String, String> map){
		try {
			return (List<Map<String,String>>) sqlMapClientTemplateMaster.queryForList("getSectionList", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public List<Map<String,String>> getSlotList(Map<String, String> map){
		try {
			return (List<Map<String,String>>) sqlMapClientTemplateMaster.queryForList("getSlotList", map);
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
	
	public List<Map<String,String>> getSlotGroupList(Map<String, String> map){
		try {
			return (List<Map<String,String>>) sqlMapClientTemplateMaster.queryForList("getSlotGroupList", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public Integer getSlotGroupCnt(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.queryForObject("getSlotGroupCnt", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public Integer addSlotGroup(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.insert("addSlotGroup", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public Integer modSlotGroup(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.update("modSlotGroup", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public Integer addSlotGroupHasSlot(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.insert("addSlotGroupHasSlot", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

}
