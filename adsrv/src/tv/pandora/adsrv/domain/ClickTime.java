package tv.pandora.adsrv.domain;

import java.io.Serializable;

public class ClickTime implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	public String adsid;
	public String adsname;
	
	
	public String getAdsid() {
		return adsid;
	}
	public void setAdsid(String adsid) {
		this.adsid = adsid;
	}
	public String getAdsname() {
		return adsname;
	}
	public void setAdsname(String adsname) {
		this.adsname = adsname;
	}
	public String getClick1() {
		return click1;
	}
	public void setClick1(String click1) {
		this.click1 = click1;
	}
	public String getClick2() {
		return click2;
	}
	public void setClick2(String click2) {
		this.click2 = click2;
	}
	public String getClick3() {
		return click3;
	}
	public void setClick3(String click3) {
		this.click3 = click3;
	}
	public String getClick4() {
		return click4;
	}
	public void setClick4(String click4) {
		this.click4 = click4;
	}
	public String getClick5() {
		return click5;
	}
	public void setClick5(String click5) {
		this.click5 = click5;
	}
	public String getClick6() {
		return click6;
	}
	public void setClick6(String click6) {
		this.click6 = click6;
	}
	public String getClick7() {
		return click7;
	}
	public void setClick7(String click7) {
		this.click7 = click7;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	private String click1;   
	private String click2;   
	private String click3;   
	private String click4;   
	private String click5;   
	private String click6;   
	private String click7; 
}
