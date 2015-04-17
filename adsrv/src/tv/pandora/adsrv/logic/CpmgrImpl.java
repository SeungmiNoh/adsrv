package tv.pandora.adsrv.logic;

import java.util.List;
import java.util.Map;






























import tv.pandora.adsrv.domain.Ads;
import tv.pandora.adsrv.domain.Campaign;
import tv.pandora.adsrv.domain.Creative;
import tv.pandora.adsrv.domain.Target;
import tv.pandora.adsrv.model.CpmgrModel;









public class CpmgrImpl implements CpmgrFacade{
	private CpmgrModel cpmgrModel;
	public void setCpmgrModel(CpmgrModel cpmgrModel) {
		this.cpmgrModel = cpmgrModel;
	}
	
	
	
	
	
	@Override
	public List<Campaign> getCpList(Map<String, String> map) {
		return cpmgrModel.getCpList(map);
	}
	public List<Map<String,String>> getAutoCorpList(Map<String, String> map){
		return cpmgrModel.getAutoCorpList(map);
	
	}
	public List<Map<String,String>> getCodeList(Map<String, String> map){
		return cpmgrModel.getCodeList(map);
	}
	@Override
	public Integer getCpCnt(Map<String, String> map) {
		return cpmgrModel.getCpCnt(map);
	}
	
	public Integer addCampaign(Campaign cp){
		return cpmgrModel.addCampaign(cp);
	}
	public Integer modCampaign(Campaign cp){
		return cpmgrModel.modCampaign(cp);
	}
	public Campaign getCampaign(Map<String, String> map){
		return cpmgrModel.getCampaign(map);
	}
	public Ads getAds(Map<String, String> map){
		return cpmgrModel.getAds(map);
	}

	public List<Ads> getAdsList(Map<String, String> map){
		return cpmgrModel.getAdsList(map);
	}
	public Integer getAdsCnt(Map<String, String> map){
		return cpmgrModel.getAdsCnt(map);
	}
	public Integer addAds(Ads ads){
		return cpmgrModel.addAds(ads);
	}
	public Integer modAds(Ads ads){
		return cpmgrModel.modAds(ads);
	}
	public List<Map<String,String>> getTargetCodeList(Map<String, String> map){
		return cpmgrModel.getTargetCodeList(map);
	}
	public List<Map<String,String>> getTargetList(Map<String, String> map){
		return cpmgrModel.getTargetList(map);
	}
	public Integer getTargetCnt(Map<String, String> map){
		return cpmgrModel.getTargetCnt(map);
	}
	public Integer addTarget(Map<String, String> map){
		return cpmgrModel.addTarget(map);
	}
	public Integer addTargetSystem(Map<String, String> map){
		return cpmgrModel.addTargetSystem(map);
	}
	public void addTargetIP(List<Map<String, String>> ipList){
		cpmgrModel.addTargetIP(ipList);
	}
	public Integer addTargetCategory(Map<String, String> map){
		return cpmgrModel.addTargetCategory(map);
	}
	public Integer addTargetCountry(Map<String, String> map){
		return cpmgrModel.addTargetCountry(map);
	}
	public Integer addTargetChannel(Map<String, String> map){
		return cpmgrModel.addTargetChannel(map);
	}
	public void addTargetChannelID(List<Map<String, String>> list){
		cpmgrModel.addTargetChannelID(list);
	}
	public List<Target> getTargetValList(Map<String, String> map){
		return cpmgrModel.getTargetValList(map);
	}
	public Target getTargetValue(Map<String, String> map){
		return cpmgrModel.getTargetValue(map);
	}
	public Target getTarget(Map<String, String> map){
		return cpmgrModel.getTarget(map);
	}
	public Integer modTarget(Map<String, String> map){
		return cpmgrModel.modTarget(map);
	}
	public Integer modTargetSystem(Map<String, String> map){
		return cpmgrModel.modTargetSystem(map);
	}
	public Integer modTargetIP(Map<String, String> map){
		return cpmgrModel.modTargetIP(map);
	}
	public void delTargetIP(Map<String, String> map){
		cpmgrModel.delTargetIP(map);
	}
	public Integer modTargetCategory(Map<String, String> map){
		return cpmgrModel.modTargetCategory(map);
	}
	public Integer modTargetCountry(Map<String, String> map){
		return cpmgrModel.modTargetCountry(map);
	}
	public Integer modTargetChannel(Map<String, String> map){
		return cpmgrModel.modTargetChannel(map);
	}
	public Integer modTargetChannelID(Map<String, String> map){
		return cpmgrModel.modTargetChannelID(map);
	}
	public void delTargetChannelID(Map<String, String> map){
		cpmgrModel.delTargetChannelID(map);
	}
	public List<Map<String,String>> getTemplateList(Map<String, String> map){
		return cpmgrModel.getTemplateList(map);
	}
	public Integer getTemplateCnt(Map<String, String> map){
		return cpmgrModel.getTemplateCnt(map);
	}
	public Map<String,String> getTemplate(Map<String, String> map){
		return cpmgrModel.getTemplate(map);
	}
	public void addTemplate(Map<String,String> map){
		cpmgrModel.addTemplate(map);
	}
	public void modTemplate(Map<String,String> map){
		cpmgrModel.modTemplate(map);
	}
	
	public List<Creative> getCreativeList(Map<String, String> map){
		return cpmgrModel.getCreativeList(map);
	}
	public Integer getCreativeCnt(Map<String, String> map){
		return cpmgrModel.getCreativeCnt(map);
	}
	public List<Map<String,String>> getCrClickList(Map<String, String> map){
		return cpmgrModel.getCrClickList(map);
	}
	public List<Map<String,String>> getCrFileList(Map<String, String> map){
		return cpmgrModel.getCrFileList(map);
	}

	public Creative getCreative(Map<String, String> map){
		return cpmgrModel.getCreative(map);
	}
	public Integer addCreative(Creative cr){
		return cpmgrModel.addCreative(cr);
	}
	public void addCreativeClick(List<Map<String, String>> list){
		cpmgrModel.addCreativeClick(list);
	}
	public void addCreativeFile(List<Map<String, String>> list){
		cpmgrModel.addCreativeFile(list);
	}
	public Integer modCreative(Creative cr){
		return cpmgrModel.modCreative(cr);
	}
	@Override
	public void addAdsTargeting(List<Map<String, String>> list) {
		cpmgrModel.addAdsTargeting(list);
	}
	public void modDelAdsTargeting(Map<String, String> map){
		cpmgrModel.modDelAdsTargeting(map);
	}
	@Override
	public void addAdsCreative(List<Map<String, String>> list) {
		cpmgrModel.addAdsCreative(list);
	}
	public void modDelAdsCreative(Map<String, String> map){
		cpmgrModel.modDelAdsCreative(map);
	}
	public void modAdsSlot(Map<String, String> map){
		cpmgrModel.modAdsSlot(map);
	}
	public Integer copyCreative(Map<String, String> map){
		return cpmgrModel.copyCreative(map);
	}
	public void copyCreativeClick(Map<String, String> map){
		cpmgrModel.copyCreativeClick(map);
	}
	public Integer copyAds(Map<String, String> map){
		return cpmgrModel.copyAds(map);
	}
	public void copyAdsTargeting(Map<String, String> map){
		cpmgrModel.copyAdsTargeting(map);
	}
	public void copyAdsCreative(Map<String, String> map){
		cpmgrModel.copyAdsCreative(map);
	}
	public void copyAdsSlot(Map<String, String> map){
		cpmgrModel.copyAdsSlot(map);
	}
}
