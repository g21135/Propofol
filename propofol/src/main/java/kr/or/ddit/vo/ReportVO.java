package kr.or.ddit.vo;

import lombok.Data;

@Data
public class ReportVO {
	private Integer report_num;
	private Integer reason_num;
	private String mem_id_from;
	private String mem_id_to;
	private String report_content;
	private String report_date;
	private Integer post_num;
	private String post_name;
	private String post_content;
	private String reason_content;
}
