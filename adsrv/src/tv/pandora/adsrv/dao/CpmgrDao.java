package tv.pandora.adsrv.dao;

import java.util.List;
import java.util.Map;

import tv.pandora.adsrv.domain.Ads;
import tv.pandora.adsrv.domain.Campaign;
import tv.pandora.adsrv.domain.Target;



public interface CpmgrDao {
	public List<Campaign> getCpList(Map<String, String> map);
	public Integer addCampaign(Map<String, String> map);
	public Integer modCampaign(Map<String, String> map);
	public Campaign getCampaign(Map<String, String> map);
	
	public List<Ads> getAdsList(Map<String, String> map);
	public Integer addAds(Map<String, String> map);
	public Integer modAds(Map<String, String> map);
	public Ads getAds(Map<String, String> map);
	
	public Integer getCpCnt(Map<String, String> map);
	
	
	
	
	public List<Map<String,String>> getAutoCorpList(Map<String, String> map);
	public List<Map<String,String>> getCodeList(Map<String, String> map);
	
	public List<Map<String,String>> getTargetCodeList(Map<String, String> map);
	public List<Map<String,String>> getTargetList(Map<String, String> map);
	public Integer getTargetCnt(Map<String, String> map);
	
	public List<Target> getTargetValList(Map<String, String> map);
	public Target getTargetValue(Map<String, String> map);
	public Target getTarget(Map<String, String> map);
	
	public Integer addTarget(Map<String, String> map);
	public Integer addTargetSystem(Map<String, String> map);
	public void addTargetIP(List<Map<String, String>> ipList);
	public Integer addTargetCategory(Map<String, String> map);
	public Integer addTargetCountry(Map<String, String> map);
	public Integer addTargetChannel(Map<String, String> map);
	public void addTargetChannelID(List<Map<String, String>> list);
	
	public Integer modTarget(Map<String, String> map);
	public Integer modTargetSystem(Map<String, String> map);
	public Integer modTargetIP(Map<String, String> map);
	public void delTargetIP(Map<String, String> map);
	public Integer modTargetCategory(Map<String, String> map);
	public Integer modTargetCountry(Map<String, String> map);
	public Integer modTargetChannel(Map<String, String> map);
	public Integer modTargetChannelID(Map<String, String> map);
	public void delTargetChannelID(Map<String, String> map);
	

}
  