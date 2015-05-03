package com.exam;

public class FileInfoModel {
	
	private Integer fileIdx;
	private String name;
	
	private String fileName;
	private String uploadedFileName;
	private long fileSize;
	private String contentType;
	private String imgUrl;
	
	
	public FileInfoModel(Integer fileIdx, String name, String fileName, String uploadedFileName,
			long fileSize, String contentType, String imgUrl) {
		super();
		this.fileIdx = fileIdx;
		this.name = name;
		this.fileName = fileName;
		this.uploadedFileName = uploadedFileName;
		this.fileSize = fileSize;
		this.contentType = contentType;
		this.imgUrl = imgUrl;
	}
	
	public Integer getFileIdx() {
		return fileIdx;
	}

	public void setFileIdx(Integer fileIdx) {
		this.fileIdx = fileIdx;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getUploadedFileName() {
		return uploadedFileName;
	}
	public void setUploadedFileName(String uploadedFileName) {
		this.uploadedFileName = uploadedFileName;
	}
	public long getFileSize() {
		return fileSize;
	}
	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}
	public String getContentType() {
		return contentType;
	}
	public void setContentType(String contentType) {
		this.contentType = contentType;
	}
	
	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	@Override
	public String toString() {
		return "FileInfoModel [name=" + name + ", fileName=" + fileName
				+ ", uploadedFileName=" + uploadedFileName + ", fileSize="
				+ fileSize + ", contentType=" + contentType + ", imgUrl=" + imgUrl + "]";
	}
	
	
}
