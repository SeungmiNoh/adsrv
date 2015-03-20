package tv.pandora.adsrv.model;

import java.util.List;
import java.util.Map;

import tv.pandora.adsrv.common.handler.MessageHandler;
import tv.pandora.adsrv.dao.CpmgrDao;
import tv.pandora.adsrv.domain.Ads;
import tv.pandora.adsrv.domain.Campaign;

public class CpmgrModel {
	private MessageHandler messageHandler;
	private CpmgrDao cpmgrDaoMaster;
	
	public void setMessageHandler(MessageHandler messageHandler) {
		this.messageHandler = messageHandler;
  	}
	public void setCpmgrDaoMaster(CpmgrDao cpmgrDaoMaster) {
		this.cpmgrDaoMaster = cpmgrDaoMaster;
	}
	
	public List<Campaign> getCpList(Map<String, String> map){
    	return cpmgrDaoMaster.getCpList(map);
    }
	public Campaign getCampaign(Map<String, String> map){
    	return cpmgrDaoMaster.getCampaign(map);
    }
	
	public List<Map<String,String>> getAutoCorpList(Map<String, String> map){
	  	return cpmgrDaoMaster.getAutoCorpList(map);	  	 
	}
	public List<Map<String,String>> getCodeList(Map<String, String> map){
	  	return cpmgrDaoMaster.getCodeList(map);	  	 
	}
	public Integer addCampaign(Map<String, String> map){
    	return cpmgrDaoMaster.addCampaign(map);
    }
	public Integer modCampaign(Map<String, String> map){
    	return cpmgrDaoMaster.modCampaign(map);
    }	
	public Integer getCpCnt(Map<String, String> map){
    	return cpmgrDaoMaster.getCpCnt(map);
    }
	public Ads getAds(Map<String, String> map){
    	return cpmgrDaoMaster.getAds(map);
    }
	public List<Ads> getAdsList(Map<String, String> map){
    	return cpmgrDaoMaster.getAdsList(map);
    }
	public Integer addAds(Map<String, String> map){
    	return cpmgrDaoMaster.addAds(map);
    }
	public Integer modAds(Map<String, String> map){
    	return cpmgrDaoMaster.modAds(map);
    }
	public List<Map<String,String>> getTargetCodeList(Map<String, String> map){
    	return cpmgrDaoMaster.getTargetCodeList(map);
    }
	public List<Map<String,String>> getTargetList(Map<String, String> map){
    	return cpmgrDaoMaster.getTargetList(map);
    }
	public Integer getTargetCnt(Map<String, String> map){
    	return cpmgrDaoMaster.getTargetCnt(map);
    }
	public Integer addTarget(Map<String, String> map){
    	return cpmgrDaoMaster.addTarget(map);
    }
	public Integer addTargetSystem(Map<String, String> map){
    	return cpmgrDaoMaster.addTargetSystem(map);
    }
	public void addTargetIP(List<Map<String, String>> ipList){
    	cpmgrDaoMaster.addTargetIP(ipList);
    }
	public Integer addTargetCategory(Map<String, String> map){
    	return cpmgrDaoMaster.addTargetCategory(map);
    }
	public Integer addTargetCountry(Map<String, String> map){
    	return cpmgrDaoMaster.addTargetCountry(map);
    }
	public Integer addTargetChannel(Map<String, String> map){
    	return cpmgrDaoMaster.addTargetChannel(map);
    }
	public void addTargetChannelID(List<Map<String, String>> list){
    	cpmgrDaoMaster.addTargetChannelID(list);
    }

}
