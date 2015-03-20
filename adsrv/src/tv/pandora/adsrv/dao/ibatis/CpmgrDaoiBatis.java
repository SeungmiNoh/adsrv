package tv.pandora.adsrv.dao.ibatis;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.orm.ibatis.SqlMapClientTemplate;

import tv.pandora.adsrv.common.util.StringUtil;
import tv.pandora.adsrv.dao.CpmgrDao;
import tv.pandora.adsrv.domain.Ads;
import tv.pandora.adsrv.domain.Campaign;
import tv.pandora.adsrv.domain.Target;
import tv.pandora.adsrv.domain.User;

public class CpmgrDaoiBatis implements CpmgrDao {
	private SqlMapClientTemplate sqlMapClientTemplateMaster;
	public void setSqlMapClientTemplateMaster(
			SqlMapClientTemplate sqlMapClientTemplateMaster) {
		this.sqlMapClientTemplateMaster = sqlMapClientTemplateMaster;
	}
	public List<Campaign> getCpList(Map<String, String> map){
		try {
			return (List<Campaign>) sqlMapClientTemplateMaster.queryForList("getCpList", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}		
	}	
	public List<Map<String,String>> getAutoCorpList(Map<String, String> map){
		try {
			return (List<Map<String,String>>) sqlMapClientTemplateMaster.queryForList("getAutoCorpList", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}		
	}	
	public List<Map<String,String>> getCodeList(Map<String, String> map){
		try {
			return (List<Map<String,String>>) sqlMapClientTemplateMaster.queryForList("getCodeList", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}		
	}
	public Integer addCampaign(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.insert("addCampaign", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}	
	}
	@Override
	public Integer modCampaign(Map<String, String> map) {
		try {
			return (Integer) sqlMapClientTemplateMaster.update("modCampaign", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}	
	}
	public Campaign getCampaign(Map<String, String> map){
		try {
			return (Campaign) sqlMapClientTemplateMaster.queryForObject("getCampaign", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}	
	}
	@Override
	public Integer getCpCnt(Map<String, String> map) {
		try {
			return (Integer) sqlMapClientTemplateMaster.queryForObject("getCpCnt", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}		
	}	

	@Override
	public List<Ads> getAdsList(Map<String, String> map) {
		try {
			return (List<Ads>) sqlMapClientTemplateMaster.queryForList("getAdsList", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public Ads getAds(Map<String, String> map){
		try {
			return (Ads) sqlMapClientTemplateMaster.queryForObject("getAds", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}	
	}
	@Override
	public Integer addAds(Map<String, String> map) {
		try {
			return (Integer) sqlMapClientTemplateMaster.update("addAds", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}	
	}
	@Override
	public Integer modAds(Map<String, String> map) {
		try {
			return (Integer) sqlMapClientTemplateMaster.update("addAds", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}	
	}

	public List<Map<String,String>> getTargetCodeList(Map<String, String> map){
		try {
			return (List<Map<String,String>>) sqlMapClientTemplateMaster.queryForList("getTargetCodeList", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}		
	}
	public List<Map<String,String>> getTargetList(Map<String, String> map){
		try {
			return (List<Map<String,String>>) sqlMapClientTemplateMaster.queryForList("getTargetList", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}		
	}
	public Integer getTargetCnt(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.queryForObject("getTargetCnt", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}		
	}	

	public Integer addTarget(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.insert("addTarget", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}	
	}
	public Integer addTargetSystem(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.insert("addTargetSystem", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}	
	}/*
	public Integer addTargetIP(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.insert("addTargetIP", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}	
	}
	*/
	
	
	public void addTargetIP(List<Map<String, String>> ipList) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("List", ipList);
		sqlMapClientTemplateMaster.insert("addTargetIP", param);
	}
	
	public Integer addTargetCategory(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.insert("addTargetCategory", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}	
	}
	public Integer addTargetCountry(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.insert("addTargetCountry", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}	
	}
	public Integer addTargetChannel(Map<String, String> map) {
		try {
			return (Integer) sqlMapClientTemplateMaster.insert("addTargetChannel", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}	
	}
	public void addTargetChannelID(List<Map<String, String>> list) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("List", list);
		sqlMapClientTemplateMaster.insert("addTargetChannelID", param);
	}
	
	
	
	public Integer modTarget(Map<String, String> map){
		return sqlMapClientTemplateMaster.update("modTarget", map);
	}
	public Integer modTargetSystem(Map<String, String> map){
		return sqlMapClientTemplateMaster.update("modTargetSystem", map);
	}
	public Integer modTargetIP(Map<String, String> map){
		return sqlMapClientTemplateMaster.update("modTargetIP", map);
	}
	public void delTargetIP(Map<String, String> map){
		sqlMapClientTemplateMaster.delete("delTargetIP", map);
	}
	public Integer modTargetCategory(Map<String, String> map){
		return sqlMapClientTemplateMaster.update("modTargetCategory", map);
	}
	public Integer modTargetCountry(Map<String, String> map){
		return sqlMapClientTemplateMaster.update("modTargetCountry", map);
	}
	public Integer modTargetChannel(Map<String, String> map){
		return sqlMapClientTemplateMaster.update("modTargetChannel", map);
	}
	public Integer modTargetChannelID(Map<String, String> map){
		return sqlMapClientTemplateMaster.update("modTargetChannelID", map);
	}
	public void delTargetChannelID(Map<String, String> map){
		sqlMapClientTemplateMaster.delete("modTarget", map);
	}
	
	
	
	
	
	
	
	
	
	
	
	@Override
	public List<Target> getTargetValList(Map<String, String> map) {
		String tgmenu = map.get("tgmenu");
		tgmenu = tgmenu.substring(0,1).toUpperCase()+tgmenu.substring(1);
		try {
			return (List<Target>) sqlMapClientTemplateMaster.queryForList("get"+tgmenu+"TargetValList", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}		
	}
	@Override
	public Target getTargetValue(Map<String, String> map) {
		String tgmenu = map.get("tgmenu");
		tgmenu = tgmenu.substring(0,1).toUpperCase()+tgmenu.substring(1);
		try {
			return (Target) sqlMapClientTemplateMaster.queryForObject("get"+tgmenu+"TargetValue", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}		
	}
	public Target getTarget(Map<String, String> map) {
		try {
			return (Target) sqlMapClientTemplateMaster.queryForObject("getTarget", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}		
	}
	
}
