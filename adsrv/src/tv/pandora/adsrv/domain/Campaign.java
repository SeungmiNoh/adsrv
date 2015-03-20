package tv.pandora.adsrv.domain;

import java.io.Serializable;

public class Campaign implements Serializable{
		
	private static final long serialVersionUID = 5876285072771523122L;
	
		private String cpid        ;
		private String cpname      ;
		private String startdate   ;
		private String enddate     ;
		private String clientid    ;
		private String clientname  ;
		private String agencyid    ;
		private String agencyname  ;
		private String medrepid    ;
		private String medrepname  ;
		private String aeid        ;
		private String aename      ;
		private String tcid        ;
		private String tcname      ;
		private String budget      ;
		private String insertdate  ;
		private String updatedate  ;
		private String insertuser  ;
		private String updateuser  ;
		private String stat        ;
		
		
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
		public String getClientid() {
			return clientid;
		}
		public void setClientid(String clientid) {
			this.clientid = clientid;
		}
		public String getClientname() {
			return clientname;
		}
		public void setClientname(String clientname) {
			this.clientname = clientname;
		}
		public String getAgencyid() {
			return agencyid;
		}
		public void setAgencyid(String agencyid) {
			this.agencyid = agencyid;
		}
		public String getAgencyname() {
			return agencyname;
		}
		public void setAgencyname(String agencyname) {
			this.agencyname = agencyname;
		}
		public String getMedrepid() {
			return medrepid;
		}
		public void setMedrepid(String medrepid) {
			this.medrepid = medrepid;
		}
		public String getMedrepname() {
			return medrepname;
		}
		public void setMedrepname(String medrepname) {
			this.medrepname = medrepname;
		}
		public String getAeid() {
			return aeid;
		}
		public void setAeid(String aeid) {
			this.aeid = aeid;
		}
		public String getAename() {
			return aename;
		}
		public void setAename(String aename) {
			this.aename = aename;
		}
		public String getBudget() {
			return budget;
		}
		public void setBudget(String budget) {
			this.budget = budget;
		}
		public String getTcid() {
			return tcid;
		}
		public void setTcid(String tcid) {
			this.tcid = tcid;
		}
		public String getTcname() {
			return tcname;
		}
		public void setTcname(String tcname) {
			this.tcname = tcname;
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
		
		
}
