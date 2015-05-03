package tv.pandora.adsrv.domain;

import java.io.Serializable;

public class AdsReport implements Serializable{
	private String adsid        ;
	private String adsname      ;
	private String startdate;
	private String enddate;
	private String siteid        ;
	private String sitename      ;
	private String slotid        ;
	private String slotname      ;
	private String totaldays;
	private String remaindays;
	private String goalrate;
	private String go_rate;
	private String book_total;
	private String bookrate;
	private String goal_total;
	private String total_imp;
	private String total_ctr;
	private String total_htr;
	private String total_hit;
	private String slot_total_imp;
	private String slot_total_ctr;
	private String slot_total_htr;
	private String goal_daily;
	private String today_imp;
	private String today_ctr;
	private String today_htr;
	private String slot_today_imp;
	private String slot_today_ctr;
	private String slot_today_htr;
	private String goaltype;
	private String goaltypename;
	private String ads_state;
	private String views;
	private String vtr;
	private String weight;
	private String cpid;
	private String cpname;
	private String today_goal;
	private String today_hit;
	private String today_rate;
	private String remain;
	private String livecnt;
	
	public String getCpid() {
		return cpid;
	}
	public void setCpid(String cpid) {
		this.cpid = cpid;
	}
	
	public String getRemain() {
		return remain;
	}
	public void setRemain(String remain) {
		this.remain = remain;
	}
	public String getCpname() {
		return cpname;
	}
	public void setCpname(String cpname) {
		this.cpname = cpname;
	}
	public String getTotal_htr() {
		return total_htr;
	}
	public void setTotal_htr(String total_htr) {
		this.total_htr = total_htr;
	}
	
	public String getTotal_hit() {
		return total_hit;
	}
	public void setTotal_hit(String total_hit) {
		this.total_hit = total_hit;
	}
	public String getSlot_total_htr() {
		return slot_total_htr;
	}
	public void setSlot_total_htr(String slot_total_htr) {
		this.slot_total_htr = slot_total_htr;
	}
	public String getToday_htr() {
		return today_htr;
	}
	public void setToday_htr(String today_htr) {
		this.today_htr = today_htr;
	}
	public String getSlot_today_htr() {
		return slot_today_htr;
	}
	public void setSlot_today_htr(String slot_today_htr) {
		this.slot_today_htr = slot_today_htr;
	}
	public String getViews() {
		return views;
	}
	public void setViews(String views) {
		this.views = views;
	}
	public String getVtr() {
		return vtr;
	}
	public void setVtr(String vtr) {
		this.vtr = vtr;
	}
	public String getWeight() {
		return weight;
	}
	public void setWeight(String weight) {
		this.weight = weight;
	}
	public String getGoaltype() {
		return goaltype;
	}
	public void setGoaltype(String goaltype) {
		this.goaltype = goaltype;
	}
	
	public String getGoaltypename() {
		return goaltypename;
	}
	public void setGoaltypename(String goaltypename) {
		this.goaltypename = goaltypename;
	}
	public String getAds_state() {
		return ads_state;
	}
	public void setAds_state(String ads_state) {
		this.ads_state = ads_state;
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
	public String getSiteid() {
		return siteid;
	}
	public void setSiteid(String siteid) {
		this.siteid = siteid;
	}
	public String getSitename() {
		return sitename;
	}
	public void setSitename(String sitename) {
		this.sitename = sitename;
	}
	public String getSlotid() {
		return slotid;
	}
	public void setSlotid(String slotid) {
		this.slotid = slotid;
	}
	public String getSlotname() {
		return slotname;
	}
	public void setSlotname(String slotname) {
		this.slotname = slotname;
	}
	public String getTotaldays() {
		return totaldays;
	}
	public void setTotaldays(String totaldays) {
		this.totaldays = totaldays;
	}
	public String getRemaindays() {
		return remaindays;
	}
	public void setRemaindays(String remaindays) {
		this.remaindays = remaindays;
	}
	public String getGoalrate() {
		return goalrate;
	}
	public void setGoalrate(String goalrate) {
		this.goalrate = goalrate;
	}
	public String getGo_rate() {
		return go_rate;
	}
	public void setGo_rate(String go_rate) {
		this.go_rate = go_rate;
	}
	public String getBook_total() {
		return book_total;
	}
	public void setBook_total(String book_total) {
		this.book_total = book_total;
	}
	public String getBookrate() {
		return bookrate;
	}
	public void setBookrate(String bookrate) {
		this.bookrate = bookrate;
	}
	public String getGoal_total() {
		return goal_total;
	}
	public void setGoal_total(String goal_total) {
		this.goal_total = goal_total;
	}
	public String getTotal_imp() {
		return total_imp;
	}
	public void setTotal_imp(String total_imp) {
		this.total_imp = total_imp;
	}
	public String getTotal_ctr() {
		return total_ctr;
	}
	public void setTotal_ctr(String total_ctr) {
		this.total_ctr = total_ctr;
	}
	public String getSlot_total_imp() {
		return slot_total_imp;
	}
	public void setSlot_total_imp(String slot_total_imp) {
		this.slot_total_imp = slot_total_imp;
	}
	public String getSlot_total_ctr() {
		return slot_total_ctr;
	}
	public void setSlot_total_ctr(String slot_total_ctr) {
		this.slot_total_ctr = slot_total_ctr;
	}
	public String getGoal_daily() {
		return goal_daily;
	}
	public void setGoal_daily(String goal_daily) {
		this.goal_daily = goal_daily;
	}
	public String getToday_imp() {
		return today_imp;
	}
	public void setToday_imp(String today_imp) {
		this.today_imp = today_imp;
	}
	public String getToday_ctr() {
		return today_ctr;
	}
	public void setToday_ctr(String today_ctr) {
		this.today_ctr = today_ctr;
	}
	public String getSlot_today_imp() {
		return slot_today_imp;
	}
	public void setSlot_today_imp(String slot_today_imp) {
		this.slot_today_imp = slot_today_imp;
	}
	public String getSlot_today_ctr() {
		return slot_today_ctr;
	}
	public void setSlot_today_ctr(String slot_today_ctr) {
		this.slot_today_ctr = slot_today_ctr;
	}
	public String getToday_hit() {
		return today_hit;
	}
	public void setToday_hit(String today_hit) {
		this.today_hit = today_hit;
	}
	public String getToday_rate() {
		return today_rate;
	}
	public void setToday_rate(String today_rate) {
		this.today_rate = today_rate;
	}
	public String getToday_goal() {
		return today_goal;
	}
	public void setToday_goal(String today_goal) {
		this.today_goal = today_goal;
	}
	public String getLivecnt() {
		return livecnt;
	}
	public void setLivecnt(String livecnt) {
		this.livecnt = livecnt;
	}
	
	
	
}
