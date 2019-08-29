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
@EqualsAndHashCode(of = {"post_num"})
@ToString(exclude = {"attachList"})
public class PostVO {
	public PostVO(Integer board_num) {
		super();
		this.board_num = board_num;
	}
	private Integer rnum;
	@NotNull(groups=UpdateGroup.class)
	private Integer post_num;
	private Integer post_parent;
	@NotNull
	private Integer board_num;
	@NotBlank
	private String mem_id;
	private Integer post_type;
	@NotBlank
	private String post_name;
	@NotBlank
	private String post_content;
	private String post_date;
	private Integer post_hit;
	private String post_pass;
	private String type_name;
	private Integer post_depth;
	private String post_report;
	
	private int rowcnt;
	
	private int[] delFiles;
	
	public void setPost_files(MultipartFile[] post_files) {
		if (post_files == null) return;
		attachList = new ArrayList<>();
		for(MultipartFile tmp : post_files) {
			if(StringUtils.isBlank(tmp.getOriginalFilename())) continue;
			attachList.add(new AttachVO(tmp));
		}
	}
	
	private transient List<AttachVO> attachList;
	
	private int reply_cnt;
}
