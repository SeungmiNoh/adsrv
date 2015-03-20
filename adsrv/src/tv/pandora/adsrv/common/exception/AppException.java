/**
 * MezzoMedia Developed by Java <br>
 *
 * @Copyright 2010 by Solution Development Team, MezzoMedia, Inc. All rights reserved.
 *
 * This software is the confidential and proprietary information of MezzoMedia, Inc. <br>
 * You shall not disclose such Confidential Information and shall use it only <br>
 * in accordance with the terms of the license agreement you entered into with MezzoMedia.
 */
 
package tv.pandora.adsrv.common.exception;

public class AppException extends RuntimeException {
  
  private static final long serialVersionUID = 6372812896326860291L;
  
	private String errorCode;
	
	public AppException() {
		super();
	}

	public AppException(String message) {
		super(message);
	}
	
	public AppException(String code, String message) {
		super(message);
		this.errorCode = code;
	}

	public AppException(String[] messages) {
		super(messages[1]);
		this.errorCode = messages[0];
	}
	
	public String getErrorCode() {
		return errorCode;
	}
}
