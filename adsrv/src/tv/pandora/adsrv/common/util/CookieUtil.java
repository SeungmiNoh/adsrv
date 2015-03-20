/**
 * MezzoMedia Developed by Java <br>
 *
 * @Copyright 2010 by Solution Development Team, MezzoMedia, Inc. All rights reserved.
 *
 * This software is the confidential and proprietary information of MezzoMedia, Inc. <br>
 * You shall not disclose such Confidential Information and shall use it only <br>
 * in accordance with the terms of the license agreement you entered into with MezzoMedia.
 */
 
package tv.pandora.adsrv.common.util;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import javax.servlet.http.Cookie;

import tv.pandora.adsrv.common.Constant;

/**
 * kr.mapps.common.util.CookieUtil.java - Creation date: 2010. 4. 1. <br>
 *
 * @author MezzoMedia Solution Dev kim jae-hwan 
 * @version 1.0
 */
public class CookieUtil {
	
	public static Cookie setCookie(String key, Map<String, String> map,
			String domain, Integer maxage) throws Exception {
		StringBuffer sb = new StringBuffer(map.size()+1);
		
		sb.append("c=").append(key);
		
		Iterator<String> iter = map.keySet().iterator();
		String tmpKey = "";
		while (iter.hasNext()) {
			tmpKey = (String)iter.next();
			sb.append("&").append(tmpKey).append("=").append(map.get(tmpKey));
		}
		
		AESUtil aes = new AESUtil(Constant.AES_KEY, Constant.AES_IV);
		Cookie cookie = new Cookie(key, aes.encrypt(sb.toString()));
		if (domain != null) {
			cookie.setDomain(domain);
		}
		
		if (maxage != null) {
			cookie.setMaxAge(maxage);
		}
		
		cookie.setPath("/");
		
		return cookie;
	}
	
	public static Map<String, String> getDecodeInfo(Cookie cookie) throws Exception {
		AESUtil aes = new AESUtil(Constant.AES_KEY, Constant.AES_IV);
		String strVal = aes.decrypt(cookie.getValue());
		
		String[] vals = strVal.split("&");
		
		Map<String, String> resultmap = new HashMap<String, String>();
		
		for (int i=0, n=vals.length; i<n; i++) {
			//String[] val = vals[i].split("=");
			int pos1 = vals[i].indexOf('=');
			String name = vals[i].substring(0, pos1);
			String val = vals[i].substring(pos1+1);
			resultmap.put(name, val);
		}
		
		return resultmap;
	}
	
	public static Map<String, String> getDecodeCookie(Cookie[] cookies, String name)
		throws Exception {
		
		Map<String, String> resultmap = new HashMap<String, String>();
		
		if (cookies == null) return resultmap;
		
		for (Cookie cookie : cookies) {
			if(cookie.getName().equals(name)) {
				resultmap = CookieUtil.getDecodeInfo(cookie);
			}
		}
		
		return resultmap;
		
	}

}
