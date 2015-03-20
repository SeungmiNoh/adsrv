/**
 * 
 */
package tv.pandora.adsrv.dao.ibatis;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.orm.ibatis.SqlMapClientTemplate;







import tv.pandora.adsrv.dao.UsermgrDao;
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
	public Integer addUser(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.insert("addUser", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public Integer modUser(Map<String, String> map){
		try {
			return (Integer) sqlMapClientTemplateMaster.insert("modUser", map);
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
}
