package tv.pandora.adsrv.dao;

import java.util.List;
import java.util.Map;

public interface SitemgrDao {
	public List<Map<String,String>> getSiteList(Map<String, String> map);
	public List<Map<String,String>> getSectionList(Map<String, String> map);
	public List<Map<String,String>> getSlotList(Map<String, String> map);
	
	public Integer getSiteCnt(Map<String, String> map);
	public Integer addSite(Map<String, String> map);
	public Integer modSite(Map<String, String> map);
	
	public Integer getSectionCnt(Map<String, String> map);
	public Integer addSection(Map<String, String> map);
	public Integer modSection(Map<String, String> map);

	public Integer getSlotCnt(Map<String, String> map);
	public Integer addSlot(Map<String, String> map);
	public Integer modSlot(Map<String, String> map);
	
	public List<Map<String,String>> getSlotGroupList(Map<String, String> map);
	public Integer getSlotGroupCnt(Map<String, String> map);
	public Integer addSlotGroup(Map<String, String> map);
	public Integer modSlotGroup(Map<String, String> map);
	
	public Integer addSlotGroupHasSlot(Map<String, String> map);
	

}
