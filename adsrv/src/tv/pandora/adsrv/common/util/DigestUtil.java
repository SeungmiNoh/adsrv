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

import java.security.MessageDigest;
import sun.misc.BASE64Encoder;
/**
 * kr.mapps.common.util.DigestUtil.java - Creation date: 2010. 4. 1. <br>
 *
 * @author MezzoMedia Solution Dev kim jae-hwan 
 * @version 1.0
 */
public class DigestUtil {
	public static String sha1(String src) throws Exception{
		MessageDigest md = MessageDigest.getInstance("SHA1"); //java.security.MessageDigest 
		byte[] hashBytes = md.digest(src.getBytes()); 
		BASE64Encoder b64e = new BASE64Encoder(); //sun.misc.BASE64Encoder 
		String hash = b64e.encode(hashBytes);
		return hash;
	}
	public static String md5(String src) throws Exception{		
		String MD5="";
		MessageDigest md = MessageDigest.getInstance("MD5"); 

		md.update(src.getBytes()); 

		byte byteData[] = md.digest();

		StringBuffer sb = new StringBuffer(); 
		for(int i = 0 ; i < byteData.length ; i++){
			sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
		}
		MD5 = sb.toString();

		return MD5;
	}
}
