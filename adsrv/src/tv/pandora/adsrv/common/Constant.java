/**
 * 
 */
package tv.pandora.adsrv.common;

/**
 * @author Administrator
 *
 */
public class Constant {

	public static final String DEFAUALT_VIEW = "jsonView";
	public static final String XML_VIEW = "xmlView";
	
	/**
	 * 서버 URL
	 */
	public static final String COOKIEDOMAIN = ".mable-inc.com";
	public static final String WEB_SERVER_URL = "http://mobile.mable-inc.com/";
	public static final String WEB_ROOT = "/adsrv";	
	public static final String WEB_SERVER_INDEX = WEB_SERVER_URL + "/";
		
	public static final String LEAVE_DIR = "/adekorea/files/leave/";	
	public static final String LEAVE_URL = "http://img.adecorp.co.kr/board/leave/";
	
	public static final String TEMP_DIR = "/leave/";
	
	
	
	
	
	
	public static final String CREATIVE_DIR = "C:/Java/DE/Apache2.2/htdocs/mobile/img";	
	public static final String CREATIVE_URL = "http://localhost";

	
	
	/**
	 * 페이징관련
	 */
	public static final int PAGE_LIST_S = 8;
	public static final int PAGE_LIST_M = 10;
	public static final int PAGE_LIST_L = 20;
	/**
	 * 로그인 및 기본 URL - / -> foward로 이동
	 */
	public static final String LOGIN_URL = WEB_SERVER_URL + "/login.html?a=login";
	
	/**
	 * AES 암호화 키
	 */
	public static final String AES_KEY = "oauth!@#$%^";
	public static final String AES_IV = "usn!@#$%^";
	
	
	/**
	 * Device 썸네일 이미지 저장 위치
	 * 
	 */
	
	public static final String DEVICE_THUMB_PATH = "";
	
	
	
	/*
	 * 외부 인터페이스 view
	 */
	public static final String INTER_VIEW_PAGE = "interface";
	
}
