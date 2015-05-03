package com.exam;

import java.util.List;
import java.util.Map;

import org.apache.commons.fileupload.FileItem;

public class RequestModel2 {
		
	private String crid;
	private String crname;
	private String clientid;
	private String clientname;
	private String client;
	private String prtype;
	private String width;
	private String height;	
	private String tmpid;	
	private String richmedia;	
	
	private FileInfoModel file;
	private List<Map<String,String>> click;
	
	
	
	
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
	public String getClient() {
		return client;
	}
	public void setClient(String client) {
		this.client = client;
	}
	public String getPrtype() {
		return prtype;
	}
	public void setPrtype(String prtype) {
		this.prtype = prtype;
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
	public String getTmpid() {
		return tmpid;
	}
	public void setTmpid(String tmpid) {
		this.tmpid = tmpid;
	}
	public String getRichmedia() {
		return richmedia;
	}
	public void setRichmedia(String richmedia) {
		this.richmedia = richmedia;
	}
	public FileInfoModel getFile() {
		return file;
	}
	public void setFile(FileInfoModel file) {
		this.file = file;
	}
	public List<Map<String,String>> getClick() {
		return click;
	}
	public void setClick(List<Map<String,String>> click) {
		this.click = click;
	}
	
	@Override
	public String toString() {
		return "RequestModel [crid=" + crid 
				+ ", crname=" + crname 
				+ ", client=" + client 
				+ ", clientid=" + clientid 
				+ ", clientname=" + clientname 
				+ ", prtype=" + prtype 
				+ ", width=" + width 
				+ ", height=" + height 
				+ ", tmpid=" + tmpid 
				+ ", richmedia=" + richmedia 
				+ ", file=" + file 
				+ ", click=" + click + "]";
	}
	
	
}
