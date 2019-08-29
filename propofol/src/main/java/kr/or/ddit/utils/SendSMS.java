package kr.or.ddit.utils;

import java.io.*;

public class SendSMS {
	   public static String SendMsg(String phoneNumber)
	    {
	        SMS sms = new SMS();
	        sms.appversion("TEST/1.0");
	        sms.charset("utf8");
	        sms.setuser("mm9812", "ghfhemf12");// coolsms 계정 입력해주시면되요

	        String number = null;// 받을 사람 폰번호
	        number= phoneNumber;		
	        
	        int ran = (int) (Math.random()*100000 + 100000);
	        String random = String.valueOf(ran);
	        SmsMessagePdu pdu = new SmsMessagePdu();
	        pdu.type = "SMS";
	        pdu.destinationAddress = number;
	        pdu.scAddress = "01063679669"; // 발신자 번호          
	        pdu.text = "[Propofol]입니다. 인증 번호 \n[" + random + "]" + " 를 화면에 입력해주세요"; // 보낼 메세지 내용
	        sms.add(pdu);
	        
	        try {
	            sms.connect();
	            sms.send();
	            sms.disconnect();
	        } catch (IOException e) {
	            System.out.println(e.toString());
	        }
	        sms.printr();
	        sms.emptyall();
	        
	        return random;
	    }
}
