package tv.pandora.adsrv.domain;

import java.io.Serializable;

public class PrismReport implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 6064477950516070300L;
	private String id;
	private String name;
	private String startdate;
	private String enddate;		
	private String cost;
	private String avg_cost;
	private String state;
	private String totaldays;
	private String remaindays;
	private String go_rate;
	private String book_total;
	private String bookrate;
	private String goal_total;
	private String goal_daily;
	private String ads_state;
	private String inv;
	private String imp   ;
	private String views;
	private String click;
	private String hit;
	private String skip;
	private String voids;
	private String vtr;
	private String htr;
	private String ctr;
	private String requests;
	private String fillrate;
	private String text;
	private String weekday;
	private String guarantee;
	private String total_imp;
	
	public String getTotal_imp() {
		return total_imp;
	}
	public void setTotal_imp(String total_imp) {
		this.total_imp = total_imp;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getRequests() {
		return requests;
	}
	public void setRequests(String requests) {
		this.requests = requests;
	}
	public String getFillrate() {
		return fillrate;
	}
	public void setFillrate(String fillrate) {
		this.fillrate = fillrate;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
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
	public String getCost() {
		return cost;
	}
	public void setCost(String cost) {
		this.cost = cost;
	}
	public String getAvg_cost() {
		return avg_cost;
	}
	public void setAvg_cost(String avg_cost) {
		this.avg_cost = avg_cost;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
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
	public String getGoal_daily() {
		return goal_daily;
	}
	public void setGoal_daily(String goal_daily) {
		this.goal_daily = goal_daily;
	}
	public String getAds_state() {
		return ads_state;
	}
	public void setAds_state(String ads_state) {
		this.ads_state = ads_state;
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
	public String getInv() {
		return inv;
	}
	public void setInv(String inv) {
		this.inv = inv;
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
	public String getHit() {
		return hit;
	}
	public void setHit(String hit) {
		this.hit = hit;
	}
	public String getSkip() {
		return skip;
	}
	public void setSkip(String skip) {
		this.skip = skip;
	}
	public String getVoids() {
		return voids;
	}
	public void setVoids(String voids) {
		this.voids = voids;
	}
	public String getHtr() {
		return htr;
	}
	public void setHtr(String htr) {
		this.htr = htr;
	}
	public String getCtr() {
		return ctr;
	}
	public void setCtr(String ctr) {
		this.ctr = ctr;
	}
	public String getWeekday() {
		return weekday;
	}
	public void setWeekday(String weekday) {
		this.weekday = weekday;
	}
	public String getGuarantee() {
		return guarantee;
	}
	public void setGuarantee(String guarantee) {
		this.guarantee = guarantee;
	}

	
	
	
}
