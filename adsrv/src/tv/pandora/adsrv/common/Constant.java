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
	public static final String COOKIEDOMAIN = ".pandora.tv";
	public static final String WEB_SERVER_URL = "/";
	public static final String WEB_ROOT = "/adsrv";	
	public static final String WEB_SERVER_INDEX = WEB_SERVER_URL + "/";
		
	/*************************  판도라 서버 *************************/
	public static final String REMOTE_HOST_NAME = "img.pandora.tv";
	public static final String FTP_REMOTE_PATH = "/home/prismadv/prism_ad/";	// 이어서 /201503
	public static final String IMG_WEB_URL = "http://cdn.pandora.tv/_adv_img/prism_ad"; // 이어서 /201503
	public static final String ADTAG_SERVER = "http://prism.pandora.tv";
	
	/*************************  테스트용 로컬 PC ************************
	public static final String REMOTE_HOST_NAME = "127.0.0.1";
	public static final String FTP_REMOTE_PATH = "/htdocs/_adv_img/prism_ad";
	public static final String IMG_WEB_URL = "http://localhost/_adv_img/prism_ad";
	/*******************************************************************/
	
	
	
	public static final String LOCAL_PATH = "/";
	
	public static final String FTP_USER_NAME = "prismadv";	
	public static final String FTP_PASSWORD = "vmflwmarhkdrh&7&";	// 프리즘광고&7&
	
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
