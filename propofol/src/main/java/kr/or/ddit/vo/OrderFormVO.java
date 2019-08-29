package kr.or.ddit.vo;

import lombok.Data;

@Data
public class OrderFormVO {
	private Integer form_num;
	private Integer order_num;
	private String form_name;
	private String form_tel;
	private String form_mail;
	private String form_ask;
	private String form_addr;
	private String form_facebook;
	private String form_insta;
}
