package kr.or.ddit.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@EqualsAndHashCode(of= {"reply_num", "post_num"})
public class ReplyVO {
	public ReplyVO(int post_num) {
		super();
		this.post_num = post_num;
	}
	private Integer rnum;
	private Integer reply_num;
	private Integer post_num;
	private String reply_content;
	private String reply_date;
	private String mem_id;
}
