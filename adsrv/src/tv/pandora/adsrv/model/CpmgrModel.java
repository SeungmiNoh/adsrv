package tv.pandora.adsrv.model;

import java.util.List;
import java.util.Map;

import tv.pandora.adsrv.common.handler.MessageHandler;
import tv.pandora.adsrv.dao.CpmgrDao;
import tv.pandora.adsrv.domain.Ads;
import tv.pandora.adsrv.domain.Campaign;
import tv.pandora.adsrv.domain.Creative;
import tv.pandora.adsrv.domain.Target;

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
	public Integer addCampaign(Campaign cp){
    	return cpmgrDaoMaster.addCampaign(cp);
    }
	public Integer modCampaign(Campaign cp){
    	return cpmgrDaoMaster.modCampaign(cp);
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
	public Integer getAdsCnt(Map<String, String> map){
		return cpmgrDaoMaster.getAdsCnt(map);
    }
	public Integer addAds(Ads ads){
    	return cpmgrDaoMaster.addAds(ads);
    }
	public Integer modAds(Ads ads){
    	return cpmgrDaoMaster.modAds(ads);
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
	public List<Target> getTargetValList(Map<String, String> map){
		return cpmgrDaoMaster.getTargetValList(map);
    }
	public Target getTargetValue(Map<String, String> map){
		return cpmgrDaoMaster.getTargetValue(map);
    }
	public Target getTarget(Map<String, String> map){
		return cpmgrDaoMaster.getTarget(map);
    }
	public Integer modTarget(Map<String, String> map){
		return cpmgrDaoMaster.modTarget(map);
	}
	public Integer modTargetSystem(Map<String, String> map){
		return cpmgrDaoMaster.modTargetSystem(map);
	}
	public Integer modTargetIP(Map<String, String> map){
		return cpmgrDaoMaster.modTargetIP(map);
	}
	public void delTargetIP(Map<String, String> map){
		cpmgrDaoMaster.delTargetIP(map);
	}
	public Integer modTargetCategory(Map<String, String> map){
		return cpmgrDaoMaster.modTargetCategory(map);
	}
	public Integer modTargetCountry(Map<String, String> map){
		return cpmgrDaoMaster.modTargetCountry(map);
	}
	public Integer modTargetChannel(Map<String, String> map){
		return cpmgrDaoMaster.modTargetChannel(map);
	}
	public Integer modTargetChannelID(Map<String, String> map){
		return cpmgrDaoMaster.modTargetChannelID(map);
	}
	public void delTargetChannelID(Map<String, String> map){
		cpmgrDaoMaster.delTargetChannelID(map);
	}
	public List<Map<String,String>> getTemplateList(Map<String, String> map){
		return cpmgrDaoMaster.getTemplateList(map);
	}
	public Integer getTemplateCnt(Map<String, String> map){
		return cpmgrDaoMaster.getTemplateCnt(map);
	}
	public Map<String,String> getTemplate(Map<String, String> map){
		return cpmgrDaoMaster.getTemplate(map);
	}
	public void addTemplate(Map<String, String> map){
		cpmgrDaoMaster.addTemplate(map);
	}
	public void modTemplate(Map<String, String> map){
		cpmgrDaoMaster.modTemplate(map);
	}
	public List<Creative> getCreativeList(Map<String, String> map){
		return cpmgrDaoMaster.getCreativeList(map);
	}
	public Integer getCreativeCnt(Map<String, String> map){
		return cpmgrDaoMaster.getCreativeCnt(map);
	}
	public Creative getCreative(Map<String, String> map){
		return cpmgrDaoMaster.getCreative(map);
	}
	public Integer addCreative(Creative cr){
		return cpmgrDaoMaster.addCreative(cr);
	}
	public void addCreativeClick(List<Map<String, String>> list){
		cpmgrDaoMaster.addCreativeClick(list);
	}
	public Integer modCreative(Creative cr){
		return cpmgrDaoMaster.modCreative(cr);
	}
	public void addAdsTargeting(List<Map<String, String>> list){
		cpmgrDaoMaster.addAdsTargeting(list);
	}
	public void addAdsCreative(List<Map<String, String>> list){
		cpmgrDaoMaster.addAdsCreative(list);
	}
	public void addAdsSlot(Map<String, String> map){
		cpmgrDaoMaster.addAdsSlot(map);
	}
	public void addAdsSlotByGroup(Map<String, String> map){
		cpmgrDaoMaster.addAdsSlotByGroup(map);
	}
	public void modAdsSlot(Map<String, String> map){
		cpmgrDaoMaster.modAdsSlot(map);
	}
}
