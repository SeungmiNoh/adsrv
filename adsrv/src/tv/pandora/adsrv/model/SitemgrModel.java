package tv.pandora.adsrv.model;

import java.util.List;
import java.util.Map;

import tv.pandora.adsrv.common.handler.MessageHandler;
import tv.pandora.adsrv.dao.SitemgrDao;


public class SitemgrModel {
	private MessageHandler messageHandler;
	private SitemgrDao sitemgrDaoMaster;
	
	public void setMessageHandler(MessageHandler messageHandler) {
		this.messageHandler = messageHandler;
  	}
	public void setSitemgrDaoMaster(SitemgrDao sitemgrDaoMaster) {
		this.sitemgrDaoMaster = sitemgrDaoMaster;
	}

	public List<Map<String,String>> getSiteList(Map<String, String> map) {
	   	return sitemgrDaoMaster.getSiteList(map);
	}
	public List<Map<String,String>> getSectionList(Map<String, String> map) {
	   	return sitemgrDaoMaster.getSectionList(map);
	}
	public List<Map<String,String>> getSlotList(Map<String, String> map) {
	   	return sitemgrDaoMaster.getSlotList(map);
	}
	
	public Integer getSiteCnt(Map<String, String> map) {
	   	return sitemgrDaoMaster.getSiteCnt(map);
	}
	public Integer addSite(Map<String, String> map) {	   
		   	return sitemgrDaoMaster.addSite(map);
	}
	public Integer modSite(Map<String, String> map) {
	   	return sitemgrDaoMaster.modSite(map);
	}
	
	public Integer getSectionCnt(Map<String, String> map){
	   	return sitemgrDaoMaster.getSectionCnt(map);
	}
	public Integer addSection(Map<String, String> map){
	   	return sitemgrDaoMaster.addSection(map);
	}
	public Integer modSection(Map<String, String> map){
	   	return sitemgrDaoMaster.modSection(map);
	}

	public Integer getSlotCnt(Map<String, String> map){
	   	return sitemgrDaoMaster.getSlotCnt(map);
	}
	public Integer addSlot(Map<String, String> map){
	   	return sitemgrDaoMaster.addSlot(map);
	}
	public Integer modSlot(Map<String, String> map){
	   	return sitemgrDaoMaster.modSlot(map);
	}
	
	public List<Map<String,String>> getSlgroupList(Map<String, String> map){
	   	return sitemgrDaoMaster.getSlgroupList(map);
	}
	public Integer getSlgroupCnt(Map<String, String> map){
	   	return sitemgrDaoMaster.getSlgroupCnt(map);
	}
	public Integer addSlgroup(Map<String, String> map){
	   	return sitemgrDaoMaster.addSlgroup(map);
	}
	public Integer modSlgroup(Map<String, String> map){
	   	return sitemgrDaoMaster.modSlgroup(map);
	}
	public void addSlgroupSlot(List<Map<String, String>> list){
	   	sitemgrDaoMaster.addSlgroupSlot(list);
	}
	public void modSlgroupSlot(Map<String, String> map){
	   	sitemgrDaoMaster.modSlgroupSlot(map);
	}
	public void delSlgroupSlot(Map<String, String> map){
	   	sitemgrDaoMaster.delSlgroupSlot(map);
	}
	public Map<String,String> getSite(Map<String, String> map){
		return sitemgrDaoMaster.getSite(map);
	}
	public Map<String,String> getSection(Map<String, String> map){
		return sitemgrDaoMaster.getSection(map);
	}
	public Map<String,String> getSlot(Map<String, String> map){
		return sitemgrDaoMaster.getSlot(map);
	}
	public Map<String,String> getSlgroup(Map<String, String> map){
		return sitemgrDaoMaster.getSlgroup(map);
	}
}
