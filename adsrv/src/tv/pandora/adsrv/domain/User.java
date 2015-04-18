package tv.pandora.adsrv.domain;

import java.io.Serializable;

public class User implements Serializable {
	
	private static final long serialVersionUID = -2223907670961345921L;
	
	
	
	// <user table>
	private String userid;
	private String username;
	private String usertype;
	private String loginid;
	private String passwd;
	private String corpid;
	private String corpname;
	private String perid;
	private String pername;
	private String corptype;
	private String corptypename;
	private String updatedate;
	private String updateusername;
	private String updateuser;
	private String insertdate;
	private String insertuser;
	private String insertusername;
	private String ismain;
	private String ismgr;
	private String allowIp;
	private String text;
	private String stat;
	
	public String getAllowIp() {
		return allowIp;
	}
	public void setAllowIp(String ipstr) {
		this.allowIp = ipstr;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getUsertype() {
		return usertype;
	}
	public void setUsertype(String usertype) {
		this.usertype = usertype;
	}
	public String getLoginid() {
		return loginid;
	}
	public void setLoginid(String loginid) {
		this.loginid = loginid;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getCorpid() {
		return corpid;
	}
	public void setCorpid(String corpid) {
		this.corpid = corpid;
	}
	public String getCorpname() {
		return corpname;
	}
	public void setCorpname(String corpname) {
		this.corpname = corpname;
	}
	public String getPerid() {
		return perid;
	}
	public void setPerid(String perid) {
		this.perid = perid;
	}
	public String getPername() {
		return pername;
	}
	public void setPername(String pername) {
		this.pername = pername;
	}
	public String getCorptype() {
		return corptype;
	}
	public void setCorptype(String corptype) {
		this.corptype = corptype;
	}
	public String getCorptypename() {
		return corptypename;
	}
	public void setCorptypename(String corptypename) {
		this.corptypename = corptypename;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	public String getUpdateusername() {
		return updateusername;
	}
	public void setUpdateusername(String updateusername) {
		this.updateusername = updateusername;
	}
	public String getUpdateuser() {
		return updateuser;
	}
	public void setUpdateuser(String updateuser) {
		this.updateuser = updateuser;
	}
	public String getInsertdate() {
		return insertdate;
	}
	public void setInsertdate(String insertdate) {
		this.insertdate = insertdate;
	}
	public String getInsertuser() {
		return insertuser;
	}
	public void setInsertuser(String insertuser) {
		this.insertuser = insertuser;
	}
	public String getInsertusername() {
		return insertusername;
	}
	public void setInsertusername(String insertusername) {
		this.insertusername = insertusername;
	}
	public String getIsmain() {
		return ismain;
	}
	public void setIsmain(String ismain) {
		this.ismain = ismain;
	}
	public String getIsmgr() {
		return ismgr;
	}
	public void setIsmgr(String ismgr) {
		this.ismgr = ismgr;
	}
	
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	
	public String getStat() {
		return stat;
	}
	public void setStat(String stat) {
		this.stat = stat;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	
	
		
		
}
