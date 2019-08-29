package kr.or.ddit.vo;

import java.sql.Date;
import java.util.List;
import java.util.UUID;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.common.UpdateGroup;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MemberVO {
	
	private Integer rnum;
	@NotBlank(groups=UpdateGroup.class)
	private String mem_id;
	@NotBlank
	private String mem_name;
	@NotBlank
	private String mem_gen;
	@NotBlank
	private String mem_pass;
	@NotBlank
	private String mem_tel;
	@NotBlank
	private String mem_mail;
	private String mem_image;
	private String mem_del_date;
	private String mem_del;
	private Integer gr_num;
	private Integer login_type;
	private String session_id;
	private Date session_limite;
	//등급 명 받기 위한 임시 프로퍼티
	private String gr_name;
	
	private String mem_role;
	private MultipartFile mem_img;
	
	private List<NoticeVO> noticeList;
	
	//회원의 포트폴리오 
	private List<PortfolioVO> portfolio;
	
	public MemberVO(String mem_id, String mem_pass) {
		super();
		this.mem_id = mem_id;
		this.mem_pass = mem_pass;
	}
	
	public MemberVO(String mem_id, Integer gr_num) {
		super();
		this.mem_id = mem_id;
		this.gr_num = gr_num;
	}
	
	//아이디 찾기용 생성자
	public MemberVO(Object mem_name, Object mem_mail) {
		super();
		this.mem_name = (String) mem_name;
		this.mem_mail = (String) mem_mail;
	}
	
	//혁준
	public MemberVO(String mem_id) {
		super();
		this.mem_id = mem_id;
	}
	
	//로그인 상태 유지 추가를 위한 생성자
	public MemberVO(String mem_id, String session_id, Date session_limite) {
		super();
		this.mem_id = mem_id;
		this.session_id = session_id;
		this.session_limite = session_limite;
	}
	
	//이미지 저장용
	public void setMem_img(MultipartFile mem_image) {
		if(mem_image == null || org.apache.commons.lang3.StringUtils.isBlank(mem_image.getOriginalFilename())) {
			return;
		}
		this.mem_img = mem_image;
		this.mem_image = UUID.randomUUID().toString();
	}
}
