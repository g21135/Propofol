package kr.or.ddit.utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

/**
 * 
 * 비밀번호 암호화유틸
 * @author pc10
 *
 */
public class SecurityUtils {
	public static String sha512(String plain) throws NoSuchAlgorithmException {
		MessageDigest md = MessageDigest.getInstance("SHA-512");
		byte[] input = plain.getBytes();
		byte[] hashvalue = md.digest(input); // 단방향 암호문
		String encoded = Base64.getEncoder().encodeToString(hashvalue);
		return encoded;
	}

}
