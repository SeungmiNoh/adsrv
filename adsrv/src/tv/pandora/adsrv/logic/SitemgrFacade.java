package tv.pandora.adsrv.logic;

import java.util.List;
import java.util.Map;

import tv.pandora.adsrv.domain.Slot;

public interface SitemgrFacade {
	public List<Map<String,String>> getSiteList(Map<String, String> map);
	public List<Map<String,String>> getSectionList(Map<String, String> map);
	public List<Slot> getSlotList(Map<String, String> map);
	
	public Integer getSiteCnt(Map<String, String> map);
	public Integer addSite(Map<String, String> map);
	public Integer modSite(Map<String, String> map);
	
	public Integer getSectionCnt(Map<String, String> map);
	public Integer addSection(Map<String, String> map);
	public Integer modSection(Map<String, String> map);

	public Integer getSlotCnt(Map<String, String> map);
	public Integer addSlot(Map<String, String> map);
	public Integer modSlot(Map<String, String> map);
	
	public List<Map<String,String>> getSlgroupList(Map<String, String> map);
	public List<Map<String,String>> getSlgroupInSlotList(Map<String, String> map);
	
	public Integer getSlgroupCnt(Map<String, String> map);
	public Integer addSlgroup(Map<String, String> map);
	public Integer modSlgroup(Map<String, String> map);

	public void addSlgroupSlot(List<Map<String, String>> list);
	public void modSlgroupSlot(Map<String, String> map);
	public void delSlgroupSlot(Map<String, String> map);
	public void delSlgroup(Map<String, String> map);
	public Map<String,String> getSite(Map<String, String> map);
	public Map<String,String> getSection(Map<String, String> map);
	public Slot getSlot(Map<String, String> map);
	public Map<String,String> getSlgroup(Map<String, String> map);

	

}
