package tv.pandora.adsrv.logic;

import java.util.List;
import java.util.Map;




















import tv.pandora.adsrv.domain.Ads;
import tv.pandora.adsrv.domain.Campaign;
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
	
	public Integer addCampaign(Map<String, String> map){
		return cpmgrModel.addCampaign(map);
	}
	public Integer modCampaign(Map<String, String> map){
		return cpmgrModel.modCampaign(map);
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
	public Integer addAds(Map<String, String> map){
		return cpmgrModel.addAds(map);
	}
	public Integer modAds(Map<String, String> map){
		return cpmgrModel.modAds(map);
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
}
