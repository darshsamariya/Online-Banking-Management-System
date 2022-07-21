package com.bankmvc.hmac;
import javax.security.*;

import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import org.apache.commons.*;
import org.apache.tomcat.util.codec.binary.Base64;

import javax.crypto.*;
import javax.crypto.spec.SecretKeySpec;
public class hmac {
public static void main(String args[]) throws NoSuchAlgorithmException, InvalidKeyException
{
	String secret="admin";
	String message="message";
	Mac sha256=Mac.getInstance("HmacSHA256");
	
	SecretKeySpec s_key=new SecretKeySpec(secret.getBytes(),"HmacSHA256");
	sha256.init(s_key);
	String hash=Base64.encodeBase64String(sha256.doFinal(message.getBytes()));
	System.out.println(hash);
}
}
//OGRWK4l7kaftd6Z2Ka4hpyOxLSZO7Cq6/qk7XEHya8Q=