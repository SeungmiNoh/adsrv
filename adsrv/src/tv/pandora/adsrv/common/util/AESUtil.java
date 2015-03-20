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

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;

/**
 * kr.mapps.common.util.AESUtil.java - Creation date: 2010. 4. 1. <br>
 *
 * @author MezzoMedia Solution Dev kim jae-hwan 
 * @version 1.0
 */
public class AESUtil {
	private Cipher rijndael;
	private SecretKeySpec key;
	private IvParameterSpec initalVector;
	
	/**
	 * Creates a AESEncrypter instance.
	 * 
	 * @param key A key string which is converted into UTF-8 and hashed by MD5.
	 *            Null or an empty string is not allowed.
	 * @param initialVector An initial vector string which is converted into UTF-8
	 *                      and hashed by MD5. Null or an empty string is not allowed.
	 * @throws Exception
	 */
	public AESUtil(String key, String initialVector) throws Exception 
	{
		if (key == null || key.equals(""))
			throw new Exception("The key can not be null or an empty string.");

		if (initialVector == null || initialVector.equals(""))
			throw new Exception("The initial vector can not be null or an empty string.");

		// Create a AES algorithm.
		this.rijndael = Cipher.getInstance("AES/CBC/PKCS5Padding");

		// Initialize an encryption key and an initial vector.
		MessageDigest md5 = MessageDigest.getInstance("MD5");
		this.key = new SecretKeySpec(md5.digest(key.getBytes("UTF8")), "AES");
		this.initalVector = new IvParameterSpec(md5.digest(initialVector.getBytes("UTF8")));
	}
	
	/**
	 * Encrypts a string.
	 * 
	 * @param value A string to encrypt. It is converted into UTF-8 before being encrypted.
	 *              Null is regarded as an empty string.
	 * @return An encrypted string.
	 * @throws Exception
	 */
	public String encrypt(String value) throws Exception 
	{
		if (value == null)
			value = "";

		// Initialize the cryptography algorithm.
		this.rijndael.init(Cipher.ENCRYPT_MODE, this.key, this.initalVector);

		// Get a UTF-8 byte array from a unicode string.
		byte[] utf8Value = value.getBytes("UTF8");

		// Encrypt the UTF-8 byte array.
		byte[] encryptedValue = this.rijndael.doFinal(utf8Value);

		// Return a base64 encoded string of the encrypted byte array.
		return new String(Base64.encodeBase64(encryptedValue));
	}

	/**
	 * Decrypts a string which is encrypted with the same key and initial vector. 
	 * 
	 * @param value A string to decrypt. It must be a string encrypted with the same key and initial vector.
	 *              Null or an empty string is not allowed.
	 * @return A decrypted string
	 * @throws Exception
	 */
	public String decrypt(String value) throws Exception {
		if (value == null || value.equals(""))
			throw new Exception("The cipher string can not be null or an empty string.");

		// Initialize the cryptography algorithm.
		this.rijndael.init(Cipher.DECRYPT_MODE, this.key, this.initalVector);

		// Get an encrypted byte array from a base64 encoded string.
		byte[] encryptedValue = Base64.decodeBase64(value.getBytes());

		// Decrypt the byte array.
		byte[] decryptedValue = this.rijndael.doFinal(encryptedValue);

		// Return a string converted from the UTF-8 byte array.
		return new String(decryptedValue, "UTF8");
	}
}
