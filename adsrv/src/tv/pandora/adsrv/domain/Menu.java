package tv.pandora.adsrv.domain;

import java.io.Serializable;

public class Menu implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String perid;
	private String pername;
	private String menu_id;
	private String menu_name;
	private String menu_sid;
	private String menu_sname;
	
	private String webdir;
	private String link;
	private String mainlink;
	private String stat;
	
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
	public String getMenu_id() {
		return menu_id;
	}
	public void setMenu_id(String menu_id) {
		this.menu_id = menu_id;
	}
	public String getMenu_name() {
		return menu_name;
	}
	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}
	public String getMenu_sid() {
		return menu_sid;
	}
	public void setMenu_sid(String menu_sid) {
		this.menu_sid = menu_sid;
	}
	public String getMenu_sname() {
		return menu_sname;
	}
	public void setMenu_sname(String menu_sname) {
		this.menu_sname = menu_sname;
	}
	public String getWebdir() {
		return webdir;
	}
	public void setWebdir(String webdir) {
		this.webdir = webdir;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public String getMainlink() {
		return mainlink;
	}
	public void setMainlink(String mainlink) {
		this.mainlink = mainlink;
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
