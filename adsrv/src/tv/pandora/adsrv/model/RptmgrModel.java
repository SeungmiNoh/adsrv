package tv.pandora.adsrv.model;

import java.util.List;
import java.util.Map;

import tv.pandora.adsrv.common.handler.MessageHandler;
import tv.pandora.adsrv.dao.RptmgrDao;
import tv.pandora.adsrv.domain.AdsReport;
import tv.pandora.adsrv.domain.ClickTime;
import tv.pandora.adsrv.domain.DayReport;
import tv.pandora.adsrv.domain.PrismReport;
import tv.pandora.adsrv.domain.Report;
import tv.pandora.adsrv.domain.SiteReport;

public class RptmgrModel {
	private MessageHandler messageHandler;
	private RptmgrDao rptmgrDaoMaster;
	
	public void setMessageHandler(MessageHandler messageHandler) {
		this.messageHandler = messageHandler;
	}
	public void setRptmgrDaoMaster(RptmgrDao rptmgrDaoMaster) {
		this.rptmgrDaoMaster = rptmgrDaoMaster;
	}
	
	public List<Report> getAdsRpt(Map<String, String> map){
		return rptmgrDaoMaster.getAdsRpt(map);
	}
	public List<Report> getCrRpt(Map<String, String> map){
		return rptmgrDaoMaster.getCrRpt(map);
	}
	
	public List<Report> getAdsDayRpt(Map<String, String> map){
		return rptmgrDaoMaster.getAdsDayRpt(map);
	}
	public List<Report> getCrDayRpt(Map<String, String> map){
		return rptmgrDaoMaster.getCrDayRpt(map);
	}
	public List<Report> getCrClickRpt(Map<String, String> map){
		return rptmgrDaoMaster.getCrClickRpt(map);
	}
	public List<Report> getCrClickDaily(Map<String, String> map){
		return rptmgrDaoMaster.getCrClickDaily(map);
	}

	
	public List<Report> getAdsCrDayRpt(Map<String, String> map){
		return rptmgrDaoMaster.getAdsCrDayRpt(map);
	}
	public List<Report> getAdsTimeRpt(Map<String, String> map){
		return rptmgrDaoMaster.getAdsTimeRpt(map);
	}
	public List<Report> getAdsCountryRpt(Map<String, String> map){
		return rptmgrDaoMaster.getAdsCountryRpt(map);
	}
	public Report getAdsCountryTotal(Map<String, String> map){
		return rptmgrDaoMaster.getAdsCountryTotal(map);
	}
	
	public List<Report> getAdsCountryDaily(Map<String, String> map){
		return rptmgrDaoMaster.getAdsCountryDaily(map);
	}
	public List<Report> getCountrySummary(Map<String, String> map){
		return rptmgrDaoMaster.getCountrySummary(map);
	}
	
	public Report getAdsRptTotal(Map<String, String> map){
		return rptmgrDaoMaster.getAdsRptTotal(map);
	}
	public Report getAdsDayTotal(Map<String, String> map){
		return rptmgrDaoMaster.getAdsDayTotal(map);
	}
	public Report getCrRptTotal(Map<String, String> map){
		return rptmgrDaoMaster.getCrRptTotal(map);
	}
	public Report getCrDayTotal(Map<String, String> map){
		return rptmgrDaoMaster.getCrDayTotal(map);
	}
	public List<SiteReport> getSlotMonitoring(Map<String, String> map){
		return rptmgrDaoMaster.getSlotMonitoring(map);
	}
	public SiteReport getSlotMonitoringTotal(Map<String, String> map){
		return rptmgrDaoMaster.getSlotMonitoringTotal(map);
	}
	
	public List<AdsReport> getAdsMonitoring(Map<String, String> map){
		return rptmgrDaoMaster.getAdsMonitoring(map);
	}
	public List<AdsReport> getCkSlotAdsMonitoring(Map<String, String> map){
		return rptmgrDaoMaster.getCkSlotAdsMonitoring(map);
	}
	public Map<String, String> getLiveInfo(Map<String, String> map){
		return rptmgrDaoMaster.getLiveInfo(map);
	}
	public void createLiveInfo(Map<String, String> map){
		rptmgrDaoMaster.createLiveInfo(map);
	}
	public List<DayReport> getSiteRpt(Map<String, String> map){
		return rptmgrDaoMaster.getSiteRpt(map);
	}
	public List<DayReport> getSiteRptDaily(Map<String, String> map){
		return rptmgrDaoMaster.getSiteRptDaily(map);
	}
	public List<DayReport> getSiteRptTimely(Map<String, String> map){
		return rptmgrDaoMaster.getSiteRptTimely(map);
	}
	public List<DayReport> getSiteRptCountry(Map<String, String> map){
		return rptmgrDaoMaster.getSiteRptCountry(map);
	}
	public List<DayReport> getSiteRptCountryDaily(Map<String, String> map){
		return rptmgrDaoMaster.getSiteRptCountryDaily(map);
	}
	
	public List<DayReport> getSlotRpt(Map<String, String> map){
		return rptmgrDaoMaster.getSlotRpt(map);
	}
	public List<DayReport> getSlgroupRpt(Map<String, String> map){
		return rptmgrDaoMaster.getSlgroupRpt(map);
	}
	public List<AdsReport> getPrismMasterCp(Map<String, String> map){
		return rptmgrDaoMaster.getPrismMasterCp(map);
	}
	public List<SiteReport> getPrismMasterMed(Map<String, String> map){
		return rptmgrDaoMaster.getPrismMasterMed(map);
	}
	public AdsReport getPrismMasterCpTotal(Map<String, String> map){
		return rptmgrDaoMaster.getPrismMasterCpTotal(map);
	}
	public SiteReport getPrismMasterMedTotal(Map<String, String> map){
		return rptmgrDaoMaster.getPrismMasterMedTotal(map);
	}
	public List<PrismReport> getPrismCpList(Map<String, String> map){
		return rptmgrDaoMaster.getPrismCpList(map);
	}
	public List<PrismReport> getPrismMedList(Map<String, String> map){
		return rptmgrDaoMaster.getPrismMedList(map);
	}
	public PrismReport getPrismAdsTotal(Map<String, String> map){
		return rptmgrDaoMaster.getPrismAdsTotal(map);
	}
	public List<PrismReport> getPrismAdsRpt(Map<String, String> map){
		return rptmgrDaoMaster.getPrismAdsRpt(map);
	}
	public List<PrismReport> getPrismDayRpt(Map<String, String> map){
		return rptmgrDaoMaster.getPrismDayRpt(map);
	}
	public PrismReport getPrismDayTotal(Map<String, String> map){
		return rptmgrDaoMaster.getPrismDayTotal(map);
	}
	public PrismReport getPrismCrTotal(Map<String, String> map){
		return rptmgrDaoMaster.getPrismCrTotal(map);
	}
	public List<PrismReport> getPrismCrRpt(Map<String, String> map){
		return rptmgrDaoMaster.getPrismCrRpt(map);
	}
	public List<PrismReport> getPrismMedRpt(Map<String, String> map){
		return rptmgrDaoMaster.getPrismMedRpt(map);
	}
	public PrismReport getPrismMedTotal(Map<String, String> map){
		return rptmgrDaoMaster.getPrismMedTotal(map);
	}
	
	public List<PrismReport> getPrismTimeRpt(Map<String, String> map){
		return rptmgrDaoMaster.getPrismTimeRpt(map);
	}
	public List<PrismReport> getPrismMedDayRpt(Map<String, String> map){
		return rptmgrDaoMaster.getPrismMedDayRpt(map);
	}
	public PrismReport getPrismMedDayTotal(Map<String, String> map){
		return rptmgrDaoMaster.getPrismMedDayTotal(map);
	}

	public List<PrismReport> getSitePrismDaily(Map<String, String> map){
		return rptmgrDaoMaster.getSitePrismDaily(map);
	}

	public PrismReport getSitePrismDailyTotal(Map<String, String> map){
		return rptmgrDaoMaster.getSitePrismDailyTotal(map);
	}
	public List<PrismReport> getSitePrismTimely(Map<String, String> map){
		return rptmgrDaoMaster.getSitePrismTimely(map);
	}
	public List<PrismReport> getSitePrismCampaign(Map<String, String> map){
		return rptmgrDaoMaster.getSitePrismCampaign(map);
	}
	
	public List<ClickTime> getAdsClickTime(Map<String, String> map){
		return rptmgrDaoMaster.getAdsClickTime(map);
	}
	public List<ClickTime> getAdsSkipTime(Map<String, String> map){
		return rptmgrDaoMaster.getAdsSkipTime(map);
	}
	public ClickTime getAdsClickTimeTotal(Map<String, String> map){
		return rptmgrDaoMaster.getAdsClickTimeTotal(map);
	}
	public ClickTime getAdsSkipTimeTotal(Map<String, String> map){
		return rptmgrDaoMaster.getAdsSkipTimeTotal(map);
	}

}
