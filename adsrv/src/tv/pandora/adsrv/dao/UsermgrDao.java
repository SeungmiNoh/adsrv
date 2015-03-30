/**
 * 
 */
package tv.pandora.adsrv.dao;

import java.util.List;
import java.util.Map;

import tv.pandora.adsrv.domain.User;

public interface UsermgrDao {
	public User getUserLogin(Map<String, String> map);
	public List<User> getUserList(Map<String, String> map);
	public Integer getUserCnt(Map<String, String> map);
	public Integer addUser(User user);
	public Integer modUser(User user);
	
	public List<Map<String,String>> getUserPerList(Map<String, String> map);
	
	
	public List<Map<String,String>> getCorpList(Map<String, String> map);
	public Integer getCorpCnt(Map<String, String> map);
	public Integer addCorporation(Map<String, String> map);
	public Integer modCorporation(Map<String, String> map);
	public Map<String,String> getCorporation(Map<String, String> map);
	
	public List<Map<String, String>> getUserPerSchema(Map<String, String> map);
	public List<Map<String,String>> getPerSchemaList(Map<String, String> map);
	public List<Map<String,String>> getMenuList(Map<String, String> map);
	public Integer addPermission(Map<String, String> map);
	public void addPermissionMenu(List<Map<String, String>> list);
	public void modPermission(Map<String, String> map);
	public void modPermissionMenu(Map<String, String> map);
	public void delPermissionMenu(Map<String, String> map);
}
