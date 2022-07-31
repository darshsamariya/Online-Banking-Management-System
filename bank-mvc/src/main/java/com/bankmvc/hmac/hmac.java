package com.bankmvc.hmac;
import javax.security.*;

import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import org.apache.commons.*;
import org.apache.tomcat.util.codec.binary.Base64;

import javax.crypto.*;
import javax.crypto.spec.SecretKeySpec;
public class hmac {
public String change(String secret,String message) throws NoSuchAlgorithmException, InvalidKeyException
{
	Mac sha256=Mac.getInstance("HmacSHA256");
	SecretKeySpec s_key=new SecretKeySpec(secret.getBytes(),"HmacSHA256");
	sha256.init(s_key);
	String hash=Base64.encodeBase64String(sha256.doFinal(message.getBytes()));
	return hash;
}

public hmac() {
	super();
	// TODO Auto-generated constructor stub
}
}
//OGRWK4l7kaftd6Z2Ka4hpyOxLSZO7Cq6/qk7XEHya8Q=