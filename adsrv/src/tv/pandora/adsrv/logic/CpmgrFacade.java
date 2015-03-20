package tv.pandora.adsrv.logic;

import java.util.List;
import java.util.Map;

import tv.pandora.adsrv.domain.Ads;
import tv.pandora.adsrv.domain.Campaign;



public interface CpmgrFacade {
	public List<Campaign> getCpList(Map<String, String> map);
	public Integer getCpCnt(Map<String, String> map);
	
	public Integer addCampaign(Map<String, String> map);
	public Integer modCampaign(Map<String, String> map);
	public Campaign getCampaign(Map<String, String> map);
	public List<Map<String,String>> getAutoCorpList(Map<String, String> map);
	public List<Map<String,String>> getCodeList(Map<String, String> map);
	
	public List<Ads> getAdsList(Map<String, String> map);
	public Integer addAds(Map<String, String> map);
	public Integer modAds(Map<String, String> map);
	public Ads getAds(Map<String, String> map);
	public List<Map<String,String>> getTargetCodeList(Map<String, String> map);
	public List<Map<String,String>> getTargetList(Map<String, String> map);
	public Integer getTargetCnt(Map<String, String> map);
	
	public Integer addTarget(Map<String, String> map);
	public Integer addTargetSystem(Map<String, String> map);
	public void addTargetIP(List<Map<String, String>> ipList);
	public Integer addTargetCategory(Map<String, String> map);
	public Integer addTargetCountry(Map<String, String> map);
	public Integer addTargetChannel(Map<String, String> map);
	public void addTargetChannelID(List<Map<String, String>> list);

}
