package tv.pandora.adsrv.dao;

import java.util.List;
import java.util.Map;

import tv.pandora.adsrv.domain.AdsReport;
import tv.pandora.adsrv.domain.Campaign;
import tv.pandora.adsrv.domain.ClickTime;
import tv.pandora.adsrv.domain.DayReport;
import tv.pandora.adsrv.domain.PrismReport;
import tv.pandora.adsrv.domain.Report;
import tv.pandora.adsrv.domain.SiteReport;

public interface RptmgrDao {
	
	public List<Report> getAdsRpt(Map<String, String> map);
	public List<Report> getCrRpt(Map<String, String> map);
	public List<Report> getAdsDayRpt(Map<String, String> map);
	public List<Report> getCrDayRpt(Map<String, String> map);

	public Report getAdsRptTotal(Map<String, String> map);
	public Report getAdsDayTotal(Map<String, String> map);
	public Report getCrRptTotal(Map<String, String> map);
	public Report getCrDayTotal(Map<String, String> map);
	
	
	public List<Report> getCrClickRpt(Map<String, String> map);
	public List<Report> getCrClickDaily(Map<String, String> map);
	
	
	
	
	public List<Report> getAdsCrDayRpt(Map<String, String> map);
	public List<Report> getAdsTimeRpt(Map<String, String> map);
	public List<Report> getAdsCountryRpt(Map<String, String> map);
	public List<Report> getAdsCountryDaily(Map<String, String> map);
	public Report getAdsCountryTotal(Map<String, String> map);
	public List<Report> getCountrySummary(Map<String, String> map);
	
	
	public List<SiteReport> getSlotMonitoring(Map<String, String> map);
	public SiteReport getSlotMonitoringTotal(Map<String, String> map);
	
	public List<AdsReport> getAdsMonitoring(Map<String, String> map);
	public List<AdsReport> getCkSlotAdsMonitoring(Map<String, String> map);
	public Map<String, String> getLiveInfo(Map<String, String> map);
	public void createLiveInfo(Map<String, String> map);
	
	public List<DayReport> getSiteRpt(Map<String, String> map);
	public List<DayReport> getSiteRptDaily(Map<String, String> map);
	public List<DayReport> getSiteRptTimely(Map<String, String> map);
	public List<DayReport> getSiteRptCountry(Map<String, String> map);
	public List<DayReport> getSiteRptCountryDaily(Map<String, String> map);
	public List<DayReport> getSlotRpt(Map<String, String> map);
	public List<DayReport> getSlgroupRpt(Map<String, String> map);
	
	
	public List<AdsReport> getPrismMasterCp(Map<String, String> map);
	public List<SiteReport> getPrismMasterMed(Map<String, String> map);
	public AdsReport getPrismMasterCpTotal(Map<String, String> map);
	public SiteReport getPrismMasterMedTotal(Map<String, String> map);
	
	public List<PrismReport> getPrismCpList(Map<String, String> map);
	public List<PrismReport> getPrismMedList(Map<String, String> map);
	
	public List<PrismReport> getPrismAdsRpt(Map<String, String> map);
	public PrismReport getPrismAdsTotal(Map<String, String> map);
	public List<PrismReport> getPrismCrRpt(Map<String, String> map);
	public PrismReport getPrismCrTotal(Map<String, String> map);
	public List<PrismReport> getPrismDayRpt(Map<String, String> map);
	public PrismReport getPrismDayTotal(Map<String, String> map);
	public List<PrismReport> getPrismMedRpt(Map<String, String> map);
	public PrismReport getPrismMedTotal(Map<String, String> map);
	public List<PrismReport> getPrismTimeRpt(Map<String, String> map);
	public List<PrismReport> getPrismMedDayRpt(Map<String, String> map);
	public PrismReport getPrismMedDayTotal(Map<String, String> map);
	public List<PrismReport> getSitePrismDaily(Map<String, String> map);
	public PrismReport getSitePrismDailyTotal(Map<String, String> map);
	public List<PrismReport> getSitePrismTimely(Map<String, String> map);
	public List<PrismReport> getSitePrismCampaign(Map<String, String> map);
	
	public List<ClickTime> getAdsClickTime(Map<String, String> map);
	public List<ClickTime> getAdsSkipTime(Map<String, String> map);
	public ClickTime getAdsClickTimeTotal(Map<String, String> map);
	public ClickTime getAdsSkipTimeTotal(Map<String, String> map);
	
	
}
