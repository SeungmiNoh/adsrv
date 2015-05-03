package tv.pandora.adsrv.logic;

import java.util.List;
import java.util.Map;

import tv.pandora.adsrv.domain.AdsReport;
import tv.pandora.adsrv.domain.ClickTime;
import tv.pandora.adsrv.domain.DayReport;
import tv.pandora.adsrv.domain.PrismReport;
import tv.pandora.adsrv.domain.Report;
import tv.pandora.adsrv.domain.SiteReport;
import tv.pandora.adsrv.model.RptmgrModel;

public class RptmgrImpl implements RptmgrFacade{
	private RptmgrModel rptmgrModel;
	public void setRptmgrModel(RptmgrModel rptmgrModel) {
		this.rptmgrModel = rptmgrModel;
	}
	@Override
	public List<Report> getAdsRpt(Map<String, String> map) {
		return rptmgrModel.getAdsRpt(map);
	}
	@Override
	public List<Report> getCrRpt(Map<String, String> map) {
		return rptmgrModel.getCrRpt(map);
	}
	public List<Report> getCrClickRpt(Map<String, String> map){
		return rptmgrModel.getCrClickRpt(map);
	}
	public List<Report> getCrClickDaily(Map<String, String> map){
		return rptmgrModel.getCrClickDaily(map);
	}

	
	@Override
	public List<Report> getAdsDayRpt(Map<String, String> map) {
		return rptmgrModel.getAdsDayRpt(map);
	}
	public List<Report> getCrDayRpt(Map<String, String> map) {
		return rptmgrModel.getCrDayRpt(map);
	}
	public Report getCrRptTotal(Map<String, String> map){
		return rptmgrModel.getCrRptTotal(map);
	}
	public Report getCrDayTotal(Map<String, String> map){
		return rptmgrModel.getCrDayTotal(map);
	}

	@Override
	public List<Report> getAdsCrDayRpt(Map<String, String> map) {
		return rptmgrModel.getAdsCrDayRpt(map);
	}
	@Override
	public List<Report> getAdsTimeRpt(Map<String, String> map) {
		return rptmgrModel.getAdsTimeRpt(map);
	}
	@Override
	public List<Report> getAdsCountryRpt(Map<String, String> map) {
		return rptmgrModel.getAdsCountryRpt(map);
	}
	public Report getAdsCountryTotal(Map<String, String> map){
		return rptmgrModel.getAdsCountryTotal(map);
	}
	public List<Report> getAdsCountryDaily(Map<String, String> map){
		return rptmgrModel.getAdsCountryDaily(map);
	}

	public List<Report> getCountrySummary(Map<String, String> map) {
		return rptmgrModel.getCountrySummary(map);
	}
	
	public Report getAdsRptTotal(Map<String, String> map){
		return rptmgrModel.getAdsRptTotal(map);
	}
	public Report getAdsDayTotal(Map<String, String> map){
		return rptmgrModel.getAdsDayTotal(map);
	}
	
	public List<SiteReport> getSlotMonitoring(Map<String, String> map){
		return rptmgrModel.getSlotMonitoring(map);
	}
	public SiteReport getSlotMonitoringTotal(Map<String, String> map){
		return rptmgrModel.getSlotMonitoringTotal(map);
	}

	public List<AdsReport> getAdsMonitoring(Map<String, String> map){
		return rptmgrModel.getAdsMonitoring(map);
	}
	public List<AdsReport> getCkSlotAdsMonitoring(Map<String, String> map){
		return rptmgrModel.getCkSlotAdsMonitoring(map);
	}
	public Map<String, String> getLiveInfo(Map<String, String> map){
		return rptmgrModel.getLiveInfo(map);
	}
	public void createLiveInfo(Map<String, String> map){
		rptmgrModel.createLiveInfo(map);
	}
	public List<DayReport> getSiteRpt(Map<String, String> map){
		return rptmgrModel.getSiteRpt(map);
	}
	public List<DayReport> getSiteRptDaily(Map<String, String> map){
		return rptmgrModel.getSiteRptDaily(map);
	}
	public List<DayReport> getSiteRptTimely(Map<String, String> map){
		return rptmgrModel.getSiteRptTimely(map);
	}
	public List<DayReport> getSiteRptCountry(Map<String, String> map){
		return rptmgrModel.getSiteRptCountry(map);
	}
	public List<DayReport> getSiteRptCountryDaily(Map<String, String> map){
		return rptmgrModel.getSiteRptCountryDaily(map);
	}
	public List<DayReport> getSlotRpt(Map<String, String> map){
		return rptmgrModel.getSlotRpt(map);
	}
	public List<DayReport> getSlgroupRpt(Map<String, String> map){
		return rptmgrModel.getSlgroupRpt(map);
	}
	public List<AdsReport> getPrismMasterCp(Map<String, String> map){
		return rptmgrModel.getPrismMasterCp(map);
	}
	public List<SiteReport> getPrismMasterMed(Map<String, String> map){
		return rptmgrModel.getPrismMasterMed(map);
	}
	public AdsReport getPrismMasterCpTotal(Map<String, String> map){
		return rptmgrModel.getPrismMasterCpTotal(map);
	}
	public SiteReport getPrismMasterMedTotal(Map<String, String> map){
		return rptmgrModel.getPrismMasterMedTotal(map);
	}
	public List<PrismReport> getPrismCpList(Map<String, String> map){
		return rptmgrModel.getPrismCpList(map);
	}
	public List<PrismReport> getPrismMedList(Map<String, String> map){
		return rptmgrModel.getPrismMedList(map);
	}
	
	public PrismReport getPrismAdsTotal(Map<String, String> map){
		return rptmgrModel.getPrismAdsTotal(map);
	}
	public List<PrismReport> getPrismAdsRpt(Map<String, String> map){
		return rptmgrModel.getPrismAdsRpt(map);
	}
	public List<PrismReport> getPrismDayRpt(Map<String, String> map){
		return rptmgrModel.getPrismDayRpt(map);
	}
	public PrismReport getPrismDayTotal(Map<String, String> map){
		return rptmgrModel.getPrismDayTotal(map);
	}
	public PrismReport getPrismCrTotal(Map<String, String> map){
		return rptmgrModel.getPrismCrTotal(map);
	}
	public List<PrismReport> getPrismCrRpt(Map<String, String> map){
		return rptmgrModel.getPrismCrRpt(map);
	}
	public List<PrismReport> getPrismMedRpt(Map<String, String> map){
		return rptmgrModel.getPrismMedRpt(map);
	}
	public PrismReport getPrismMedTotal(Map<String, String> map){
		return rptmgrModel.getPrismMedTotal(map);
	}
	public List<PrismReport> getPrismTimeRpt(Map<String, String> map){
		return rptmgrModel.getPrismTimeRpt(map);
	}
	public List<PrismReport> getPrismMedDayRpt(Map<String, String> map){
		return rptmgrModel.getPrismMedDayRpt(map);
	}
	public PrismReport getPrismMedDayTotal(Map<String, String> map){
		return rptmgrModel.getPrismMedDayTotal(map);
	}
	public List<PrismReport> getSitePrismDaily(Map<String, String> map){
		return rptmgrModel.getSitePrismDaily(map);
	}
	public PrismReport getSitePrismDailyTotal(Map<String, String> map){
		return rptmgrModel.getSitePrismDailyTotal(map);
	}

	public List<PrismReport> getSitePrismTimely(Map<String, String> map){
		return rptmgrModel.getSitePrismTimely(map);
	}

	public List<PrismReport> getSitePrismCampaign(Map<String, String> map){
		return rptmgrModel.getSitePrismCampaign(map);
	}
	public List<ClickTime> getAdsClickTime(Map<String, String> map){
		return rptmgrModel.getAdsClickTime(map);
	}
	public List<ClickTime> getAdsSkipTime(Map<String, String> map){
		return rptmgrModel.getAdsSkipTime(map);
	}

	public ClickTime getAdsClickTimeTotal(Map<String, String> map){
		return rptmgrModel.getAdsClickTimeTotal(map);
	}

	public ClickTime getAdsSkipTimeTotal(Map<String, String> map){
		return rptmgrModel.getAdsSkipTimeTotal(map);
	}


}
