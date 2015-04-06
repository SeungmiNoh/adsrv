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
	public Integer addUser(User user){
	   	return usermgrDaoMaster.addUser(user);
	}
	public Integer modUser(User user){
	   	return usermgrDaoMaster.modUser(user);
	}
	
	public List<Map<String,String>> getUserPerList(Map<String, String> map){
	   	return usermgrDaoMaster.getUserPerList(map);
	}
	public Integer getUserPerCnt(Map<String, String> map){
	   	return usermgrDaoMaster.getUserPerCnt(map);
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
	public List<Map<String, String>> getUserPerSchema(Map<String, String> map){
	   	return usermgrDaoMaster.getUserPerSchema(map);
	}
	public List<Map<String,String>> getPerSchemaList(Map<String, String> map){
	   	return usermgrDaoMaster.getPerSchemaList(map);
	}
	public List<Map<String,String>> getMenuList(Map<String, String> map){
	   	return usermgrDaoMaster.getMenuList(map);
	}
	public Integer addPermission(Map<String, String> map){
	   	return usermgrDaoMaster.addPermission(map);
	}
	public void addPermissionMenu(List<Map<String, String>> list){
	   	usermgrDaoMaster.addPermissionMenu(list);
	}
	public void modPermission(Map<String, String> map){
	   	usermgrDaoMaster.modPermission(map);
	}
	public void modPermissionMenu(Map<String, String> map){
	   	usermgrDaoMaster.modPermissionMenu(map);
	}
	public void delPermissionMenu(Map<String, String> map){
	   	usermgrDaoMaster.delPermissionMenu(map);
	}
}
