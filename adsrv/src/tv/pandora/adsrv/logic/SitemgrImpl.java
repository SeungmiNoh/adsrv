package tv.pandora.adsrv.logic;

import java.util.List;
import java.util.Map;

import tv.pandora.adsrv.model.SitemgrModel;

public class SitemgrImpl implements SitemgrFacade{
	private SitemgrModel sitemgrModel;
	public void setSitemgrModel(SitemgrModel sitemgrModel) {
		this.sitemgrModel = sitemgrModel;
	}
	
	@Override
	public List<Map<String, String>> getSiteList(Map<String, String> map) {
		return sitemgrModel.getSiteList(map);
	}

	@Override
	public List<Map<String, String>> getSectionList(Map<String, String> map) {
		return sitemgrModel.getSectionList(map);
	}

	@Override
	public List<Map<String, String>> getSlotList(Map<String, String> map) {
		return sitemgrModel.getSlotList(map);
	}

	@Override
	public Integer getSiteCnt(Map<String, String> map) {
		return sitemgrModel.getSiteCnt(map);
	}

	@Override
	public Integer addSite(Map<String, String> map) {
		return sitemgrModel.addSite(map);
	}

	@Override
	public Integer modSite(Map<String, String> map) {
		return sitemgrModel.modSite(map);
	}

	@Override
	public Integer getSectionCnt(Map<String, String> map) {
		return sitemgrModel.getSectionCnt(map);
	}

	@Override
	public Integer addSection(Map<String, String> map) {
		return sitemgrModel.addSection(map);
	}

	@Override
	public Integer modSection(Map<String, String> map) {
		return sitemgrModel.modSection(map);
	}

	@Override
	public Integer getSlotCnt(Map<String, String> map) {
		return sitemgrModel.getSlotCnt(map);
	}

	@Override
	public Integer addSlot(Map<String, String> map) {
		return sitemgrModel.addSlot(map);
	}

	@Override
	public Integer modSlot(Map<String, String> map) {
		return sitemgrModel.modSlot(map);
	}
	public List<Map<String,String>> getSlgroupList(Map<String, String> map){
		return sitemgrModel.getSlgroupList(map);
	}
	public Integer getSlgroupCnt(Map<String, String> map){
		return sitemgrModel.getSlgroupCnt(map);
	}
	public Integer addSlgroup(Map<String, String> map){
		return sitemgrModel.addSlgroup(map);
	}
	public Integer modSlgroup(Map<String, String> map){
		return sitemgrModel.modSlgroup(map);
	}
	public void addSlgroupSlot(List<Map<String, String>> list){
		sitemgrModel.addSlgroupSlot(list);
	}
	public void modSlgroupSlot(Map<String, String> map){
		sitemgrModel.modSlgroupSlot(map);
	}
	public void delSlgroupSlot(Map<String, String> map){
		sitemgrModel.delSlgroupSlot(map);
	}
	public Map<String,String> getSite(Map<String, String> map){
		return sitemgrModel.getSite(map);
	}
	public Map<String,String> getSection(Map<String, String> map){
		return sitemgrModel.getSection(map);
	}
	public Map<String,String> getSlot(Map<String, String> map){
		return sitemgrModel.getSlot(map);
	}
	public Map<String,String> getSlgroup(Map<String, String> map){
		return sitemgrModel.getSlgroup(map);
	}

}
