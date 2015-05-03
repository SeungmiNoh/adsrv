package tv.pandora.adsrv.logic;

import java.util.List;
import java.util.Map;

import tv.pandora.adsrv.logic.UsermgrFacade;
import tv.pandora.adsrv.domain.Menu;
import tv.pandora.adsrv.domain.User;
import tv.pandora.adsrv.model.UsermgrModel;








public class UsermgrImpl implements UsermgrFacade{
	private UsermgrModel usermgrModel;
	public void setUsermgrModel(UsermgrModel usermgrModel) {
		this.usermgrModel = usermgrModel;
	}	

	
	/* 유저관리 */
	public User getUserLogin(Map<String, String> map) {
		return usermgrModel.getUserLogin(map);
	}
	public List<User> getUserList(Map<String, String> map) {
		return usermgrModel.getUserList(map);
	}
	public List<Menu> getUserMenuList(Map<String, String> map){
		return usermgrModel.getUserMenuList(map);
	}
	public List<Map<String,String>> getUserPerList(Map<String, String> map){
		return usermgrModel.getUserPerList(map);
	}
	public Integer getUserPerCnt(Map<String, String> map){
		return usermgrModel.getUserPerCnt(map);
	}
	public List<Map<String,String>> getCorpList(Map<String, String> map){
		return usermgrModel.getCorpList(map);
	}
	
	public Integer getCorpCnt(Map<String, String> map){
		return usermgrModel.getCorpCnt(map);
	}
	public Integer addCorporation(Map<String, String> map){
		return usermgrModel.addCorporation(map);
	}
	public Integer modCorporation(Map<String, String> map){
		return usermgrModel.modCorporation(map);
	}
	public Map<String,String> getCorporation(Map<String, String> map){
		return usermgrModel.getCorporation(map);
	}
	public Integer getUserCnt(Map<String, String> map){
		return usermgrModel.getUserCnt(map);
	}
	public Integer addUser(User user){
		return usermgrModel.addUser(user);
	}
	public Integer modUser(User user){
		return usermgrModel.modUser(user);
	}
	public List<Map<String,String>> getUserPerSchema(Map<String, String> map){
		return usermgrModel.getUserPerSchema(map);
	}
	public List<Map<String,String>> getPerSchemaList(Map<String, String> map){
		return usermgrModel.getPerSchemaList(map);
	}
	public List<Map<String,String>> getMenuList(Map<String, String> map){
		return usermgrModel.getMenuList(map);
	}
	public Integer addPermission(Map<String, String> map){
		return usermgrModel.addPermission(map);
	}
	public void addPermissionMenu(List<Map<String, String>> list){
		usermgrModel.addPermissionMenu(list);
	}
	public void modPermission(Map<String, String> map){
		usermgrModel.modPermission(map);
	}
	public void modPermissionMenu(Map<String, String> map){
		usermgrModel.modPermissionMenu(map);
	}
	public void delPermissionMenu(Map<String, String> map){
		usermgrModel.delPermissionMenu(map);
	}
}
