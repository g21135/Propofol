package kr.or.ddit.utils;

import java.util.List;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.vo.MemberVO;

public class SendMail {
	
	/**
	 * naver 메일(단일)보내기
	 * @param mem_mail - 받는 사람 메일 주소
	 * @param title - 제목
	 * @param content - 내용
	 * @return 성공하면 OK, 실패면 FAILED
	 */
	public static ServiceResult naverMailSend(String mem_mail, String title, String content) {
		ServiceResult result = null;
		String host = "smtp.naver.com";
		String user = "mm9812@naver.com";
		String password = "ghfhemf12!()";
		
		Properties props = new Properties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", 587);
		props.put("mail.smtp.auth", "true");
		
		Session session = Session.getDefaultInstance(props, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, password);
			}
		});
		
		try {
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(user));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(mem_mail));
			
			//제목
			message.setSubject(title);
			//내용
			message.setText(content);
			//전송
			Transport.send(message);
			result = ServiceResult.OK;
		} catch (MessagingException  e) {
			result = ServiceResult.FAILED;
			e.printStackTrace();
		}
		
		return result;
	}//naverMailSend end
	
	/**
	 * naver 메일 (다중)보내기
	 * @param list
	 * @param text
	 * @param content
	 * @return
	 */
	public static ServiceResult MultiSendNaverMail(List<MemberVO> list, String title, String content) {
		ServiceResult result = null;
		String host = "smtp.naver.com";
		String user = "mm9812@naver.com";
		String password = "ghfhemf12!()";
		
		Properties props = new Properties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", 587);
		props.put("mail.smtp.auth", "true");
		
		Session session = Session.getDefaultInstance(props, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, password);
			}
		});
		
		try {
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(user));
			InternetAddress[] userList = new InternetAddress[list.size()];
			for(MemberVO mv : list) {
				String mailList = mv.getMem_mail();
				for(int i = 0; i < list.size(); i++) {
					userList[i] = new InternetAddress(mailList);
				}
			}
			message.addRecipients(Message.RecipientType.TO, userList);
			//제목
			message.setSubject(title);
			//내용
			message.setText(content);
			//전송
			Transport.send(message);
			result = ServiceResult.OK;
		} catch (MessagingException e) {
			result = ServiceResult.FAILED;
			e.printStackTrace();
		}
		return result;
	}//MultiSendNaverMail end
}//class end
