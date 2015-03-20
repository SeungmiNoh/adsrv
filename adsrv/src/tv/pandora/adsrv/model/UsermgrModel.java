package tv.pandora.adsrv.model;

import java.util.List;
import java.util.Map;

import tv.pandora.adsrv.common.handler.MessageHandler;
import tv.pandora.adsrv.dao.UsermgrDao;
import tv.pandora.adsrv.domain.User;

public class UsermgrModel {
	private MessageHandler messageHandler;
	private UsermgrDao usermgrDaoMaster;
	
	public void setMessageHandler(MessageHandler messageHandler) {
		this.messageHandler = messageHandler;
  	}
	public void setUsermgrDaoMaster(UsermgrDao usermgrDaoMaster) {
		this.usermgrDaoMaster = usermgrDaoMaster;
	}

	public User getUserLogin(Map<String, String> map) {

    	return usermgrDaoMaster.getUserLogin(map);
    }
	public List<User> getUserList(Map<String, String> map) {
	   	return usermgrDaoMaster.getUserList(map);
	}
	public Integer getUserCnt(Map<String, String> map){
	   	return usermgrDaoMaster.getUserCnt(map);
	}
	public Integer addUser(Map<String, String> map){
	   	return usermgrDaoMaster.addUser(map);
	}
	public Integer modUser(Map<String, String> map){
	   	return usermgrDaoMaster.modUser(map);
	}
	
	public List<Map<String,String>> getCorpList(Map<String, String> map){
	   	return usermgrDaoMaster.getCorpList(map);
	}
	public Integer getCorpCnt(Map<String, String> map){
	   	return usermgrDaoMaster.getCorpCnt(map);
	}
	public Integer addCorporation(Map<String, String> map){
	   	return usermgrDaoMaster.addCorporation(map);
	}
	public Integer modCorporation(Map<String, String> map){
	   	return usermgrDaoMaster.modCorporation(map);
	}
	public Map<String,String> getCorporation(Map<String, String> map){
	   	return usermgrDaoMaster.getCorporation(map);
	}
}
