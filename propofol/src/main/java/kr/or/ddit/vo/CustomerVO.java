package kr.or.ddit.vo;

import java.util.ArrayList;
import java.util.List;

import javax.validation.constraints.NotNull;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.validator.constraints.NotBlank;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.common.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@EqualsAndHashCode(of = {"customer_num"})
@ToString(exclude = {"attachList"})
public class CustomerVO {
	public CustomerVO(Integer board_num) {
		super();
		this.board_num = board_num;
	}
	
	public CustomerVO(Integer board_num, String mem_id) {
		super();
		this.board_num = board_num;
		this.mem_id = mem_id;
	}
	
	private Integer rnum;
	@NotNull(groups=UpdateGroup.class)
	private Integer customer_num;
	@NotBlank
	private String mem_id;
	private Integer board_num;
	@NotBlank
	private String customer_question;
	private String customer_content;
	private String customer_date;
	private String customer_answer;
	private String customer_answer_date;
	private String customer_pass;
	private String customer_read;
	private String customer_check;
		
	private int rowcnt;
	
	private int[] delFiles;
	
	public void setCus_files(MultipartFile[] cus_files) {
		if (cus_files == null) return;
		attachList = new ArrayList<>();
		for(MultipartFile tmp : cus_files) {
			if(StringUtils.isBlank(tmp.getOriginalFilename())) continue;
			attachList.add(new AttachVO(tmp));
		}
	}
	
	private transient List<AttachVO> attachList;
}
