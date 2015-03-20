package tv.pandora.adsrv.model;

import java.util.List;
import java.util.Map;

import tv.pandora.adsrv.common.handler.MessageHandler;
import tv.pandora.adsrv.dao.CpmgrDao;
import tv.pandora.adsrv.domain.Ads;
import tv.pandora.adsrv.domain.Campaign;
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
}
