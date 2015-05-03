package tv.pandora.adsrv.dao.ibatis;

import java.util.List;
import java.util.Map;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.orm.ibatis.SqlMapClientTemplate;

import tv.pandora.adsrv.common.util.StringUtil;
import tv.pandora.adsrv.dao.RptmgrDao;
import tv.pandora.adsrv.domain.AdsReport;
import tv.pandora.adsrv.domain.ClickTime;
import tv.pandora.adsrv.domain.DayReport;
import tv.pandora.adsrv.domain.PrismReport;
import tv.pandora.adsrv.domain.Report;
import tv.pandora.adsrv.domain.SiteReport;

public class RptmgrDaoiBatis implements RptmgrDao{
	private SqlMapClientTemplate sqlMapClientTemplateMaster;
	public void setSqlMapClientTemplateMaster(
			SqlMapClientTemplate sqlMapClientTemplateMaster) {
		this.sqlMapClientTemplateMaster = sqlMapClientTemplateMaster;
	}
	@Override
	public List<Report> getAdsRpt(Map<String, String> map) {
		try {
			return (List<Report>) sqlMapClientTemplateMaster.queryForList("getAdsRpt", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	@Override
	public List<Report> getCrRpt(Map<String, String> map) {
		try {
			return (List<Report>) sqlMapClientTemplateMaster.queryForList("getCrRpt", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public List<Report> getCrClickRpt(Map<String, String> map){
		try {
			return (List<Report>) sqlMapClientTemplateMaster.queryForList("getCrClickRpt", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public List<Report> getCrClickDaily(Map<String, String> map){
		try {
			return (List<Report>) sqlMapClientTemplateMaster.queryForList("getCrClickDaily", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

	@Override
	public List<Report> getAdsCountryRpt(Map<String, String> map) {
		try {
			return (List<Report>) sqlMapClientTemplateMaster.queryForList("getAdsCountryRpt", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	public List<Report> getAdsCountryDaily(Map<String, String> map){
		try {
			return (List<Report>) sqlMapClientTemplateMaster.queryForList("getAdsCountryDaily", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public Report getAdsCountryTotal(Map<String, String> map){
		try {
			return (Report) sqlMapClientTemplateMaster.queryForObject("getAdsCountryTotal", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public List<Report> getCountrySummary(Map<String, String> map){
		try {
			return (List<Report>) sqlMapClientTemplateMaster.queryForList("getCountrySummary", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	@Override
	public List<Report> getAdsDayRpt(Map<String, String> map) {
		try {
			return (List<Report>) sqlMapClientTemplateMaster.queryForList("getAdsDayRpt", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public List<Report> getCrDayRpt(Map<String, String> map) {
		try {
			return (List<Report>) sqlMapClientTemplateMaster.queryForList("getCrDayRpt", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	@Override
	public List<Report> getAdsCrDayRpt(Map<String, String> map) {
		try {
			return (List<Report>) sqlMapClientTemplateMaster.queryForList("getAdsCrDayRpt", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	@Override
	public List<Report> getAdsTimeRpt(Map<String, String> map) {
		try {
			return (List<Report>) sqlMapClientTemplateMaster.queryForList("getAdsTimeRpt", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	
	
	public Report getAdsRptTotal(Map<String, String> map){
		try {
			return (Report) sqlMapClientTemplateMaster.queryForObject("getAdsRptTotal", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public Report getAdsDayTotal(Map<String, String> map){
		try {
			return (Report) sqlMapClientTemplateMaster.queryForObject("getAdsDayTotal", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public Report getCrRptTotal(Map<String, String> map){
		try {
			return (Report) sqlMapClientTemplateMaster.queryForObject("getCrRptTotal", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public Report getCrDayTotal(Map<String, String> map){
		try {
			return (Report) sqlMapClientTemplateMaster.queryForObject("getCrDayTotal", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public List<SiteReport> getSlotMonitoring(Map<String, String> map){
		try {
			return (List<SiteReport>) sqlMapClientTemplateMaster.queryForList("getSlotMonitoring", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public SiteReport getSlotMonitoringTotal(Map<String, String> map){
		try {
			return (SiteReport) sqlMapClientTemplateMaster.queryForObject("getSlotMonitoringTotal", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

	public List<AdsReport> getAdsMonitoring(Map<String, String> map){
		try {
			return (List<AdsReport>) sqlMapClientTemplateMaster.queryForList("getAdsMonitoring", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public List<AdsReport> getCkSlotAdsMonitoring(Map<String, String> map){
		try {
			return (List<AdsReport>) sqlMapClientTemplateMaster.queryForList("getCkSlotAdsMonitoring", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public Map<String, String> getLiveInfo(Map<String, String> map){
		try {
			String sql = "getLiveInfo";
			if(StringUtil.isNull(map.get("live")).equals("N")){
				sql = "getNoneLiveInfo";
			}
			return (Map<String, String>) sqlMapClientTemplateMaster.queryForObject(sql, map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public void createLiveInfo(Map<String, String> map){
		try {
			sqlMapClientTemplateMaster.update("createLiveInfo", map);
		} catch (EmptyResultDataAccessException e) {
			;
		}
	}

	public List<DayReport> getSiteRpt(Map<String, String> map){
		try {
			return (List<DayReport>) sqlMapClientTemplateMaster.queryForList("getSiteRpt", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public List<DayReport> getSiteRptDaily(Map<String, String> map){
		try {
			return (List<DayReport>) sqlMapClientTemplateMaster.queryForList("getSiteRptDaily", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public List<DayReport> getSiteRptTimely(Map<String, String> map){
		try {
			return (List<DayReport>) sqlMapClientTemplateMaster.queryForList("getSiteRptTimely", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public List<DayReport> getSiteRptCountry(Map<String, String> map){
		try {
			return (List<DayReport>) sqlMapClientTemplateMaster.queryForList("getSiteRptCountry", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public List<DayReport> getSiteRptCountryDaily(Map<String, String> map){
		try {
			return (List<DayReport>) sqlMapClientTemplateMaster.queryForList("getSiteRptCountryDaily", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public List<DayReport> getSlotRpt(Map<String, String> map){
		try {
			return (List<DayReport>) sqlMapClientTemplateMaster.queryForList("getSlotRpt", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public List<DayReport> getSlgroupRpt(Map<String, String> map){
		try {
			return (List<DayReport>) sqlMapClientTemplateMaster.queryForList("getSlgroupRpt", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	public List<AdsReport> getPrismMasterCp(Map<String, String> map){
		try {
			return (List<AdsReport>) sqlMapClientTemplateMaster.queryForList("getPrismMasterCp", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public List<SiteReport> getPrismMasterMed(Map<String, String> map){
		try {
			return (List<SiteReport>) sqlMapClientTemplateMaster.queryForList("getPrismMasterMed", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public AdsReport getPrismMasterCpTotal(Map<String, String> map){
		try {
			return (AdsReport) sqlMapClientTemplateMaster.queryForObject("getPrismMasterCpTotal", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

	public SiteReport getPrismMasterMedTotal(Map<String, String> map){
		try {
			return (SiteReport) sqlMapClientTemplateMaster.queryForObject("getPrismMasterMedTotal", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

	public List<PrismReport> getPrismCpList(Map<String, String> map){
		try {
			return (List<PrismReport>) sqlMapClientTemplateMaster.queryForList("getPrismCpList", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public List<PrismReport> getPrismMedList(Map<String, String> map){
		try {
			return (List<PrismReport>) sqlMapClientTemplateMaster.queryForList("getPrismMedList", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

	public PrismReport getPrismAdsTotal(Map<String, String> map){
		try {
			return (PrismReport) sqlMapClientTemplateMaster.queryForObject("getPrismAdsTotal", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	
	public List<PrismReport> getPrismAdsRpt(Map<String, String> map){
		try {
			return (List<PrismReport>) sqlMapClientTemplateMaster.queryForList("getPrismAdsRpt", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public PrismReport getPrismCrTotal(Map<String, String> map){
		try {
			return (PrismReport) sqlMapClientTemplateMaster.queryForObject("getPrismCrTotal", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public List<PrismReport> getPrismCrRpt(Map<String, String> map){
		try {
			return (List<PrismReport>) sqlMapClientTemplateMaster.queryForList("getPrismCrRpt", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public List<PrismReport> getPrismDayRpt(Map<String, String> map){
		try {
			return (List<PrismReport>) sqlMapClientTemplateMaster.queryForList("getPrismDayRpt", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public PrismReport getPrismDayTotal(Map<String, String> map){
		try {
			return (PrismReport) sqlMapClientTemplateMaster.queryForObject("getPrismDayTotal", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public List<PrismReport> getPrismMedRpt(Map<String, String> map){
		try {
			return (List<PrismReport>) sqlMapClientTemplateMaster.queryForList("getPrismMedRpt", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public PrismReport getPrismMedTotal(Map<String, String> map){
		try {
			return (PrismReport) sqlMapClientTemplateMaster.queryForObject("getPrismMedTotal", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public List<PrismReport> getPrismTimeRpt(Map<String, String> map){
		try {
			return (List<PrismReport>) sqlMapClientTemplateMaster.queryForList("getPrismTimeRpt", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public List<PrismReport> getPrismMedDayRpt(Map<String, String> map){
		try {
			return (List<PrismReport>) sqlMapClientTemplateMaster.queryForList("getPrismMedDayRpt", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public PrismReport getPrismMedDayTotal(Map<String, String> map){
		try {
			return (PrismReport) sqlMapClientTemplateMaster.queryForObject("getPrismMedDayTotal", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public List<PrismReport> getSitePrismDaily(Map<String, String> map){
		try {
			return (List<PrismReport>) sqlMapClientTemplateMaster.queryForList("getSitePrismDaily", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public PrismReport getSitePrismDailyTotal(Map<String, String> map){
		try {
			return (PrismReport) sqlMapClientTemplateMaster.queryForObject("getSitePrismDailyTotal", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public List<PrismReport> getSitePrismTimely(Map<String, String> map){
		try {
			return (List<PrismReport>) sqlMapClientTemplateMaster.queryForList("getSitePrismTimely", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public List<PrismReport> getSitePrismCampaign(Map<String, String> map){
		try {
			return (List<PrismReport>) sqlMapClientTemplateMaster.queryForList("getSitePrismCampaign", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public List<ClickTime> getAdsClickTime(Map<String, String> map){
		try {
			return (List<ClickTime>) sqlMapClientTemplateMaster.queryForList("getAdsClickTime", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public List<ClickTime> getAdsSkipTime(Map<String, String> map){
		try {
			return (List<ClickTime>) sqlMapClientTemplateMaster.queryForList("getAdsSkipTime", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public ClickTime getAdsClickTimeTotal(Map<String, String> map){
		try {
			return (ClickTime) sqlMapClientTemplateMaster.queryForObject("getAdsClickTimeTotal", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public ClickTime getAdsSkipTimeTotal(Map<String, String> map){
		try {
			return (ClickTime) sqlMapClientTemplateMaster.queryForObject("getAdsSkipTimeTotal", map);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
}
