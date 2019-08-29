package kr.or.ddit.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class NoticeVO {
	private Integer notice_num;
	private String mem_id;
	private String notice_content;
	private String notice_read;
	private Date notice_date;
	private String notice_url;
	
	public NoticeVO(String mem_id, String notice_content, String notice_url) {
		super();
		this.mem_id = mem_id;
		this.notice_content = notice_content;
		this.notice_url = notice_content;
	}
}
