package tv.pandora.adsrv.domain;

import java.io.Serializable;

public class Report implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 3175878129875371631L;
	private String cpid        ;
	private String cpname      ;
	private String adsid        ;
	private String adsname      ;
	private String crid        ;
	private String crname      ;
	private String crurl;
	private String startdate   ;
	private String enddate     ;
	private String rptday;
	private String weekday;
	private String budget      ;
	private String book_total;
	private String goal_total;
	private String salestype;
	private String goaltype;
	private String prtype;
	private String salestypename;
	private String goaltypename;
	private String prtypename;
	private String imp;
	private String click;
	private String uv;
	private String uc;
	private String views;
	private String avg_imp;
	private String ctr;
	private String cpr;
	private String days;
	private String goalrate;
	private String ads_statename;
	private String ads_state;
	private String text;
	private String icon;
	private String istarget;
	private String isprism;
	private String ckid;
	private String clickname;
	private String clickurl;
	private String clickcnt;
	
	
	public String getCpid() {
		return cpid;
	}
	public void setCpid(String cpid) {
		this.cpid = cpid;
	}
	public String getCpname() {
		return cpname;
	}
	public void setCpname(String cpname) {
		this.cpname = cpname;
	}
	public String getAdsid() {
		return adsid;
	}
	public void setAdsid(String adsid) {
		this.adsid = adsid;
	}
	public String getAdsname() {
		return adsname;
	}
	
	public String getCrid() {
		return crid;
	}
	public void setCrid(String crid) {
		this.crid = crid;
	}
	public String getCrname() {
		return crname;
	}
	public void setCrname(String crname) {
		this.crname = crname;
	}
	
	public String getCrurl() {
		return crurl;
	}
	public void setCrurl(String crurl) {
		this.crurl = crurl;
	}
	public void setAdsname(String adsname) {
		this.adsname = adsname;
	}
	public String getStartdate() {
		return startdate;
	}
	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}
	public String getEnddate() {
		return enddate;
	}
	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}
	public String getBudget() {
		return budget;
	}
	public void setBudget(String budget) {
		this.budget = budget;
	}
	public String getBook_total() {
		return book_total;
	}
	public void setBook_total(String book_total) {
		this.book_total = book_total;
	}
	public String getGoal_total() {
		return goal_total;
	}
	public void setGoal_total(String goal_total) {
		this.goal_total = goal_total;
	}
	public String getSalestype() {
		return salestype;
	}
	public void setSalestype(String salestype) {
		this.salestype = salestype;
	}
	public String getGoaltype() {
		return goaltype;
	}
	public void setGoaltype(String goaltype) {
		this.goaltype = goaltype;
	}
	public String getPrtype() {
		return prtype;
	}
	public void setPrtype(String prtype) {
		this.prtype = prtype;
	}
	public String getSalestypename() {
		return salestypename;
	}
	public void setSalestypename(String salestypename) {
		this.salestypename = salestypename;
	}
	public String getGoaltypename() {
		return goaltypename;
	}
	public void setGoaltypename(String goaltypename) {
		this.goaltypename = goaltypename;
	}
	public String getPrtypename() {
		return prtypename;
	}
	public void setPrtypename(String prtypename) {
		this.prtypename = prtypename;
	}
	public String getImp() {
		return imp;
	}
	public void setImp(String imp) {
		this.imp = imp;
	}
	public String getClick() {
		return click;
	}
	public void setClick(String click) {
		this.click = click;
	}
	public String getUv() {
		return uv;
	}
	public void setUv(String uv) {
		this.uv = uv;
	}
	public String getUc() {
		return uc;
	}
	public void setUc(String uc) {
		this.uc = uc;
	}
	public String getViews() {
		return views;
	}
	public void setViews(String views) {
		this.views = views;
	}
	public String getAvg_imp() {
		return avg_imp;
	}
	public void setAvg_imp(String avg_imp) {
		this.avg_imp = avg_imp;
	}
	public String getDays() {
		return days;
	}
	public void setDays(String days) {
		this.days = days;
	}
	public String getGoalrate() {
		return goalrate;
	}
	public void setGoalrate(String goalrate) {
		this.goalrate = goalrate;
	}
	public String getAds_state() {
		return ads_state;
	}
	public void setAds_state(String ads_state) {
		this.ads_state = ads_state;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	
	
	public String getCtr() {
		return ctr;
	}
	public void setCtr(String ctr) {
		this.ctr = ctr;
	}
	public String getCpr() {
		return cpr;
	}
	public void setCpr(String cpr) {
		this.cpr = cpr;
	}
	
	
	public String getIstarget() {
		return istarget;
	}
	public void setIstarget(String istarget) {
		this.istarget = istarget;
	}
	public String getIsprism() {
		return isprism;
	}
	public void setIsprism(String isprism) {
		this.isprism = isprism;
	}
	public String getRptday() {
		return rptday;
	}
	public void setRptday(String rptday) {
		this.rptday = rptday;
	}
	public String getWeekday() {
		return weekday;
	}
	public void setWeekday(String weekday) {
		this.weekday = weekday;
	}
	public String getAds_statename() {
		return ads_statename;
	}
	public void setAds_statename(String ads_statename) {
		this.ads_statename = ads_statename;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getCkid() {
		return ckid;
	}
	public void setCkid(String ckid) {
		this.ckid = ckid;
	}
	public String getClickname() {
		return clickname;
	}
	public void setClickname(String clickname) {
		this.clickname = clickname;
	}
	public String getClickurl() {
		return clickurl;
	}
	public void setClickurl(String clickurl) {
		this.clickurl = clickurl;
	}
	public String getClickcnt() {
		return clickcnt;
	}
	public void setClickcnt(String clickcnt) {
		this.clickcnt = clickcnt;
	}
	
	
}
