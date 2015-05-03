/**
 * 
 */
package tv.pandora.adsrv.dao.ibatis;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.orm.ibatis.SqlMapClientTemplate;














import tv.pandora.adsrv.dao.UsermgrDao;
import tv.pandora.adsrv.domain.Menu;
import tv.pandora.adsrv.domain.User;

/**
 * @author nsm
 *
 */
public class UsermgrDaoiBatis implements UsermgrDao {
	private SqlMapClientTemplate sqlMapClientTemplateMaster;
	public void setSqlMapClientTemplateMaster(
			SqlMapClientTemplate sqlMapClientTemplateMaster) {
		this.sqlMapClientTemplateMaster = sqlMapClientTemplateMaster;
	}
	
	
	@Override
	public User getUserLogin(Map<String, String> map) throws DataAccessException {
		try {
			return (User) sqlMapClientTemplateMaster.queryForObject("getUserLogin", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}


	@Override
	public List<User> getUserList(Map<String, String> map) {
		try {
			return (List<User>) sqlMapClientTemplateMaster.queryForList("getUserList", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public Integer getUserCnt(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.queryForObject("getUserCnt", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public List<Menu> getUserMenuList(Map<String, String> map){
		try {
			return (List<Menu>) sqlMapClientTemplateMaster.queryForList("getUserMenuList", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public Integer addUser(User user){
		try {
			return (Integer) sqlMapClientTemplateMaster.insert("addUser", user);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public Integer modUser(User user){
		try {
			return (Integer) sqlMapClientTemplateMaster.insert("modUser", user);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public List<Map<String,String>> getUserPerList(Map<String, String> map){
		try {
			return (List<Map<String,String>>) sqlMapClientTemplateMaster.queryForList("getUserPerList", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public Integer getUserPerCnt(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.queryForObject("getUserPerCnt", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

	
	public List<Map<String,String>> getCorpList(Map<String, String> map){
		try {
			return (List<Map<String,String>>) sqlMapClientTemplateMaster.queryForList("getCorpList", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	public Integer getCorpCnt(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.queryForObject("getCorpCnt", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public Integer addCorporation(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.insert("addCorporation", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public Integer modCorporation(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.update("modCorporation", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public Map<String,String> getCorporation(Map<String, String> map){
		try {
			return (Map<String,String>) sqlMapClientTemplateMaster.queryForObject("getCorporation", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public List<Map<String, String>> getUserPerSchema(Map<String, String> map){
		try {
			return (List<Map<String, String>>) sqlMapClientTemplateMaster.queryForList("getUserPerSchema", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

	public List<Map<String,String>> getPerSchemaList(Map<String, String> map){
		try {
			return (List<Map<String,String>>) sqlMapClientTemplateMaster.queryForList("getPerSchemaList", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public List<Map<String,String>> getMenuList(Map<String, String> map){
		try {
			return (List<Map<String,String>>) sqlMapClientTemplateMaster.queryForList("getMenuList", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public Integer addPermission(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.insert("addPermission", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public void addPermissionMenu(List<Map<String, String>> list){
		
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("List", list);
		sqlMapClientTemplateMaster.insert("addPermissionMenu", param);
	}
	public void modPermission(Map<String, String> map){
		try {
			sqlMapClientTemplateMaster.update("modPermission", map);
		} catch (EmptyResultDataAccessException e) {
			
		}
	}
	public void modPermissionMenu(Map<String, String> map){
		try {
			sqlMapClientTemplateMaster.update("modPermissionMenu", map);
		} catch (EmptyResultDataAccessException e) {
			
		}
	}
	public void delPermissionMenu(Map<String, String> map){
		try {
			sqlMapClientTemplateMaster.delete("delPermissionMenu", map);
		} catch (EmptyResultDataAccessException e) {
			
		}
	}
}
