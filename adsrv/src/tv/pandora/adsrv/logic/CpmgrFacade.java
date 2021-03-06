package tv.pandora.adsrv.logic;

import java.util.List;
import java.util.Map;

import tv.pandora.adsrv.domain.Ads;
import tv.pandora.adsrv.domain.Campaign;
import tv.pandora.adsrv.domain.Creative;
import tv.pandora.adsrv.domain.Target;



public interface CpmgrFacade {
	public List<Campaign> getCpList(Map<String, String> map);
	public Integer getCpCnt(Map<String, String> map);
	
	public Integer addCampaign(Campaign cp);
	public Integer modCampaign(Campaign cp);
	public Campaign getCampaign(Map<String, String> map);
	public List<Map<String,String>> getAutoCorpList(Map<String, String> map);
	public List<Map<String,String>> getCodeList(Map<String, String> map);
	
	public List<Ads> getAdsList(Map<String, String> map);
	public Integer getAdsCnt(Map<String, String> map);
	public Integer addAds(Ads ads);
	public Integer modAds(Ads ads);
	public Ads getAds(Map<String, String> map);
	public List<Map<String,String>> getTargetCodeList(Map<String, String> map);
	public List<Map<String,String>> getTargetList(Map<String, String> map);
	public Integer getTargetCnt(Map<String, String> map);
	
	public Integer addTarget(Map<String, String> map);
	public Integer addTargetSystem(Map<String, String> map);
	
	public void addAdsCrNew(Map<String, String> map);
	public void addTargetIP(List<Map<String, String>> ipList);
	public Integer addTargetCategory(Map<String, String> map);
	public Integer addTargetCountry(Map<String, String> map);
	public Integer addTargetChannel(Map<String, String> map);
	public void addTargetChannelID(List<Map<String, String>> list);
	public List<Target> getTargetValList(Map<String, String> map);
	public Target getTargetValue(Map<String, String> map);
	public Target getTarget(Map<String, String> map);
	public List<Ads> getAvailableAdsList(Map<String, String> map);
	public Integer modTarget(Map<String, String> map);
	public Integer modTargetSystem(Map<String, String> map);
	public Integer modTargetIP(Map<String, String> map);
	public void delTargetIP(Map<String, String> map);
	public Integer modTargetCategory(Map<String, String> map);
	public Integer modTargetCountry(Map<String, String> map);
	public Integer modTargetChannel(Map<String, String> map);
	public Integer modTargetChannelID(Map<String, String> map);
	public void delTargetChannelID(Map<String, String> map);
	public List<Map<String,String>> getTemplateList(Map<String, String> map);
	public Integer getTemplateCnt(Map<String, String> map);
	public Map<String,String> getTemplate(Map<String, String> map);
	public void addTemplate(Map<String,String> map);
	public void modTemplate(Map<String,String> map);
	public void modDelAdsSlot(Map<String,String> map);
	public void modDelCampaign(Map<String,String> map);
	
	
	public List<Creative> getCreativeList(Map<String, String> map);
	public List<Map<String,String>> getCrClickList(Map<String, String> map);
	public List<Map<String,String>> getCrFileList(Map<String, String> map);

	public Integer getCreativeCnt(Map<String, String> map);
	public Creative getCreative(Map<String, String> map);
	public Integer addCreative(Creative cr);
	public Integer modDelCreative(Map<String, String> map);
	
	public void addCreativeClick(List<Map<String, String>> list);
	public void addCreativeFile(List<Map<String, String>> list);
	public Integer modCreative(Creative cr);
	public void addAdsTargeting(List<Map<String, String>> list);
	public void modDelAdsTargeting(Map<String, String> map);
	public void addAdsCreative(List<Map<String, String>> list);
	public void modDelAdsCreative(Map<String, String> map);
	public void modDelAds(Map<String, String> map);
	public void addAdsSlot(List<Map<String, String>> list);
	public void modAdsSlot(Map<String, String> map);
	
	public Integer copyCreative(Map<String, String> map);
	public void copyCreativeClick(Map<String, String> map);
	
	public Integer copyCampaign(Map<String, String> map);
	public Integer copyAds(Map<String, String> map);
	public void copyAdsTargeting(Map<String, String> map);
	public void copyAdsCreative(Map<String, String> map);
	public void copyAdsSlot(Map<String, String> map);

}
