package tv.pandora.adsrv.domain;

import java.io.Serializable;

public class SiteReport implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String siteid        ;
	private String sitename      ;
	private String slotid        ;
	private String slotname      ;
	private String width        ;
	private String height      ;
	private String inv;
	private String imp   ;
	private String views;
	private String click;
	private String hit;
	private String skip;
	private String voids;
	private String remain     ;
	private String fillrate;
	private String avg_ctr;
	private String ctr      ;
	private String htr      ;
	private String vtr      ;
	private String weight;
	private String livecnt;
	private String prtypename;
	
	
	public String getPrtypename() {
		return prtypename;
	}
	public void setPrtypename(String prtypename) {
		this.prtypename = prtypename;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
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
	public String getWidth() {
		return width;
	}
	public void setWidth(String width) {
		this.width = width;
	}
	public String getHeight() {
		return height;
	}
	public void setHeight(String height) {
		this.height = height;
	}
	public String getInv() {
		return inv;
	}
	public void setInv(String inventory) {
		this.inv = inventory;
	}
	public String getImp() {
		return imp;
	}
	public void setImp(String imp) {
		this.imp = imp;
	}
	public String getRemain() {
		return remain;
	}
	public void setRemain(String remain) {
		this.remain = remain;
	}
	public String getFillrate() {
		return fillrate;
	}
	public void setFillrate(String userate) {
		this.fillrate = userate;
	}
	public String getAvg_ctr() {
		return avg_ctr;
	}
	public void setAvg_ctr(String avg_ctr) {
		this.avg_ctr = avg_ctr;
	}
	public String getCtr() {
		return ctr;
	}
	public void setCtr(String ctr) {
		this.ctr = ctr;
	}
	public String getLivecnt() {
		return livecnt;
	}
	public void setLivecnt(String livecnt) {
		this.livecnt = livecnt;
	}
	public String getViews() {
		return views;
	}
	public void setViews(String views) {
		this.views = views;
	}
	public String getClick() {
		return click;
	}
	public void setClick(String click) {
		this.click = click;
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
	public String getHit() {
		return hit;
	}
	public void setHit(String hit) {
		this.hit = hit;
	}
	
}
