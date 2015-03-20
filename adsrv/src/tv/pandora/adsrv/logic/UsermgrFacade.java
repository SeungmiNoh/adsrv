package tv.pandora.adsrv.logic;

import java.util.List;
import java.util.Map;

import tv.pandora.adsrv.domain.User;


public interface UsermgrFacade {

	public User getUserLogin(Map<String, String> map);
	
	public List<User> getUserList(Map<String, String> map);
	public Integer getUserCnt(Map<String, String> map);
	public Integer addUser(Map<String, String> map);
	public Integer modUser(Map<String, String> map);
	
	public List<Map<String,String>> getCorpList(Map<String, String> map);
	public Integer getCorpCnt(Map<String, String> map);
	public Integer addCorporation(Map<String, String> map);
	public Integer modCorporation(Map<String, String> map);
	public Map<String,String> getCorporation(Map<String, String> map);
	
}
