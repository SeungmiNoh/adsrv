package tv.pandora.adsrv.domain;

import java.io.Serializable;

public class Ads implements Serializable{
		

	private static final long serialVersionUID = 3725152976544710353L;
	
		private String cpid        ;
		private String cpname      ;
		private String clientname      ;
		private String adsid        ;
		private String adsname      ;
		private String startdate   ;
		private String enddate     ;
		private String budget      ;
		private String book_total;
		private String goal_total;
		private String goal_daily;
		private String salestype;
		private String goaltype;
		private String prtype;
		private String salestypename;
		private String goaltypename;
		private String prtypename;
		private String ads_state;		
		private String ads_statename;
		private String period;
		private String insertdate  ;
		private String updatedate  ;
		private String insertuser  ;
		private String insertusername  ;
		private String updateuser  ;
		private String updateusername  ;
		private String stat        ;
		private String start_hour;
		private String start_min;
		private String end_hour;
		private String end_min;
		private String realenddate;
		private String memo;
		private String text;
		private String target;
		private String istarget;
		private String isprism;
		
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
		
		
		public String getStart_hour() {
			return start_hour;
		}
		public void setStart_hour(String start_hour) {
			this.start_hour = start_hour;
		}
		public String getStart_min() {
			return start_min;
		}
		public void setStart_min(String start_min) {
			this.start_min = start_min;
		}
		public String getEnd_hour() {
			return end_hour;
		}
		public void setEnd_hour(String end_hour) {
			this.end_hour = end_hour;
		}
		public String getEnd_min() {
			return end_min;
		}
		public void setEnd_min(String end_min) {
			this.end_min = end_min;
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
		public String getGoal_daily() {
			return goal_daily;
		}
		public void setGoal_daily(String goal_daily) {
			this.goal_daily = goal_daily;
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
		public String getAds_state() {
			return ads_state;
		}
		public void setAds_state(String ads_state) {
			this.ads_state = ads_state;
		}
		public String getAds_statename() {
			return ads_statename;
		}
		public void setAds_statename(String ads_statename) {
			this.ads_statename = ads_statename;
		}
		public String getPeriod() {
			return period;
		}
		public void setPeriod(String period) {
			this.period = period;
		}
		public String getInsertdate() {
			return insertdate;
		}
		public void setInsertdate(String insertdate) {
			this.insertdate = insertdate;
		}
		public String getUpdatedate() {
			return updatedate;
		}
		public void setUpdatedate(String updatedate) {
			this.updatedate = updatedate;
		}
		public String getInsertuser() {
			return insertuser;
		}
		public void setInsertuser(String insertuser) {
			this.insertuser = insertuser;
		}
		public String getUpdateuser() {
			return updateuser;
		}
		public void setUpdateuser(String updateuser) {
			this.updateuser = updateuser;
		}
		public String getStat() {
			return stat;
		}
		public void setStat(String stat) {
			this.stat = stat;
		}
		public String getInsertusername() {
			return insertusername;
		}
		public void setInsertusername(String insertusername) {
			this.insertusername = insertusername;
		}
		public String getUpdateusername() {
			return updateusername;
		}
		public void setUpdateusername(String updateusername) {
			this.updateusername = updateusername;
		}
		
		public String getRealenddate() {
			return realenddate;
		}
		public void setRealenddate(String realenddate) {
			this.realenddate = realenddate;
		}
		public String getMemo() {
			return memo;
		}
		public void setMemo(String memo) {
			this.memo = memo;
		}
		
		public String getClientname() {
			return clientname;
		}
		public void setClientname(String clientname) {
			this.clientname = clientname;
		}
		
		public String getText() {
			return text;
		}
		public void setText(String text) {
			this.text = text;
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
		public String getTarget() {
			return target;
		}
		public void setTarget(String target) {
			this.target = target;
		}
		public static long getSerialversionuid() {
			return serialVersionUID;
		}
		
		
		
		
}
