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
import tv.pandora.adsrv.domain.Creative;
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
		String sql = "getCodeList";
		if(!StringUtil.isNull(String.valueOf(map.get("curid"))).equals("")){
			sql = "getCodeChangeList";
		}
		
		try {
			return (List<Map<String,String>>) sqlMapClientTemplateMaster.queryForList(sql, map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}		
	}
	public Integer addCampaign(Campaign cp){
		try {
			return (Integer) sqlMapClientTemplateMaster.insert("addCampaign", cp);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}	
	}
	
	@Override
	public Integer modCampaign(Campaign cp) {
		try {
			return (Integer) sqlMapClientTemplateMaster.update("modCampaign", cp);
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
			String sql = "getAdsList";
			if(!StringUtil.isNull(String.valueOf(map.get("cpid"))).equals("")){
				sql = "getCpAdsList";
			}
			return (List<Ads>) sqlMapClientTemplateMaster.queryForList(sql, map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	
	public List<Ads> getAvailableAdsList(Map<String, String> map){
		try {
			return (List<Ads>) sqlMapClientTemplateMaster.queryForList("getAvailableAdsList", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}		
	}

	
	
	
	public Integer getAdsCnt(Map<String, String> map) {
		try {
			return (Integer) sqlMapClientTemplateMaster.queryForObject("getAdsCnt", map);
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
	public Integer addAds(Ads ads) {
		try {
			return (Integer) sqlMapClientTemplateMaster.insert("addAds", ads);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}	
	}	
	public Integer copyCreative(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.insert("copyCreative", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}	
	}	
	public void copyCreativeClick(Map<String, String> map){
		try {
			 sqlMapClientTemplateMaster.insert("copyCreativeClick", map);
		} catch (EmptyResultDataAccessException e) {
			 ;
		}	
	}	
	public void addAdsCrNew(Map<String, String> map){
		try {
			 sqlMapClientTemplateMaster.insert("addAdsCrNew", map);
		} catch (EmptyResultDataAccessException e) {
			 ;
		}	
	}	

	@Override
	public Integer modAds(Ads ads) {
		try {
			return (Integer) sqlMapClientTemplateMaster.update("modAds", ads);
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
			String sql = "getTargetList";
			if(StringUtil.isNull(String.valueOf(map.get("mode"))).equals("New")){
				sql = "getNewAdsTargetList";
			}else if(StringUtil.isNull(String.valueOf(map.get("mode"))).equals("E")){
				sql = "getAdsTargetSelectList";
			}else if(!StringUtil.isNull(String.valueOf(map.get("adsid"))).equals("") || !StringUtil.isNull(String.valueOf(map.get("cpid"))).equals("")){
				sql = "getAdsTargetList";
			}
			return (List<Map<String,String>>) sqlMapClientTemplateMaster.queryForList(sql, map);
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
		sqlMapClientTemplateMaster.delete("delTargetChannelID", map);
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
	public List<Map<String,String>> getTemplateList(Map<String, String> map){
		try {
			return (List<Map<String,String>>) sqlMapClientTemplateMaster.queryForList("getTemplateList", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}		
	}
	public Integer getTemplateCnt(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.queryForObject("getTemplateCnt", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}		
	}
	public Map<String,String> getTemplate(Map<String, String> map){
		try {
			return (Map<String,String>) sqlMapClientTemplateMaster.queryForObject("getTemplate", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}		
	}
	
	public void addTemplate(Map<String, String> map){
		try {
			sqlMapClientTemplateMaster.insert("addTemplate", map);
		} catch (EmptyResultDataAccessException e) {			
		}	
	}
	public void modTemplate(Map<String, String> map){
		try {
			sqlMapClientTemplateMaster.update("modTemplate", map);
		} catch (EmptyResultDataAccessException e) {			
		}	
	}

	public List<Creative> getCreativeList(Map<String, String> map){
		try {
			String sql = "getCreativeList";
			if(!StringUtil.isNull(String.valueOf(map.get("pop"))).equals("")){
				sql = "getCreativeList";
			}else if(!StringUtil.isNull(String.valueOf(map.get("cpid"))).equals("") || !StringUtil.isNull(String.valueOf(map.get("adsid"))).equals("")){
				sql = "getCpCreativeList";
			}
			return (List<Creative>) sqlMapClientTemplateMaster.queryForList(sql, map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}		
	}
	public Integer getCreativeCnt(Map<String, String> map){
		String sql = "getCreativeCnt";
		if(!StringUtil.isNull(map.get("crname")).equals("")){
			sql = "getCrnameCnt";
		}
		try {
			return (Integer) sqlMapClientTemplateMaster.queryForObject(sql, map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}		
	}
	public Creative getCreative(Map<String, String> map){
		try {
			return (Creative) sqlMapClientTemplateMaster.queryForObject("getCreative", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}		
	}
	public List<Map<String,String>> getCrClickList(Map<String, String> map){
		try {
			return (List<Map<String,String>>) sqlMapClientTemplateMaster.queryForList("getCrClickList", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}		
	}
	public List<Map<String,String>> getCrFileList(Map<String, String> map){
		try {
			return (List<Map<String,String>>) sqlMapClientTemplateMaster.queryForList("getCrFileList", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}		
	}

	public Integer addCreative(Creative cr){
		try {
			return (Integer) sqlMapClientTemplateMaster.insert("addCreative", cr);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}	
	}
	public Integer modDelCreative(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.update("modDelCreative", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}	
	}
	
	public void addCreativeClick(List<Map<String, String>> list){
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("List", list);
		sqlMapClientTemplateMaster.insert("addCreativeClick", param);
	}
	public void addCreativeFile(List<Map<String, String>> list){
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("List", list);
		sqlMapClientTemplateMaster.insert("addCreativeFile", param);
	}
	public Integer modCreative(Creative cr){
		try {
			return (Integer) sqlMapClientTemplateMaster.update("modCreative", cr);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}	
	}
	public void addAdsTargeting(List<Map<String, String>> list){
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("List", list);
		sqlMapClientTemplateMaster.insert("addAdsTargeting", param);
	}

	public void modDelCampaign(Map<String, String> map){
		try {
			sqlMapClientTemplateMaster.update("modDelCampaign", map);
		} catch (EmptyResultDataAccessException e) {
			;
		}	
	}
	public void modDelAdsTargeting(Map<String, String> map){
		try {
			sqlMapClientTemplateMaster.update("modDelAdsTargeting", map);
		} catch (EmptyResultDataAccessException e) {
			;
		}	
	}
	public void modDelAdsSlot(Map<String, String> map){
		try {
			sqlMapClientTemplateMaster.update("modDelAdsSlot", map);
		} catch (EmptyResultDataAccessException e) {
			;
		}	
	}

	public void addAdsCreative(List<Map<String, String>> list){
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("List", list);
		sqlMapClientTemplateMaster.insert("addAdsCreative", param);
	}
	public void addAdsNewCreative(Map<String, String> map){
		try {
			sqlMapClientTemplateMaster.insert("addAdsNewCreative", map);
		} catch (EmptyResultDataAccessException e) {
			;
		}	
	}
	
	
	
	public void modDelAds(Map<String, String> map) {
		try {
			sqlMapClientTemplateMaster.update("modDelAds", map);
		} catch (EmptyResultDataAccessException e) {
			;
		}	
	}	
	public void modDelAdsCreative(Map<String, String> map) {
		try {
			sqlMapClientTemplateMaster.update("modDelAdsCreative", map);
		} catch (EmptyResultDataAccessException e) {
			;
		}	
	}
	public void addAdsSlot(List<Map<String, String>> list){
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("List", list);
		sqlMapClientTemplateMaster.insert("addAdsSlot", param);
	}
	public void addAdsSlotByGroup(Map<String, String> map){
		try {
			sqlMapClientTemplateMaster.insert("addAdsSlotByGroup", map);
		} catch (EmptyResultDataAccessException e) {
			;
		}	
	}
	public void modAdsSlot(Map<String, String> map){
		try {
			sqlMapClientTemplateMaster.update("modAdsSlot", map);
		} catch (EmptyResultDataAccessException e) {
			;
		}	
	}
	public Integer delFile(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.update("delFile", map);
		} catch (EmptyResultDataAccessException e) {
			return 0;
		}	
	}
	public Integer delClick(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.update("delClick", map);
		} catch (EmptyResultDataAccessException e) {
			return 0;
		}	
	}
	
	public Integer copyCampaign(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.insert("copyCampaign", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}	
	}
	public Integer copyAds(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.insert("copyAds", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}	
	}	
	public void copyAdsTargeting(Map<String, String> map){
		try {
			sqlMapClientTemplateMaster.insert("copyAdsTargeting", map);
		} catch (EmptyResultDataAccessException e) {
			;
		}	
	}
	public void copyAdsCreative(Map<String, String> map){
		try {
			sqlMapClientTemplateMaster.insert("copyAdsCreative", map);
		} catch (EmptyResultDataAccessException e) {
			;
		}	
	}
	public void copyAdsSlot(Map<String, String> map){
		try {
			sqlMapClientTemplateMaster.insert("copyAdsSlot", map);
		} catch (EmptyResultDataAccessException e) {
			;
		}	
	}
}
