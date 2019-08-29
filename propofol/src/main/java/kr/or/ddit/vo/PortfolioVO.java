package kr.or.ddit.vo;

import java.io.Serializable;
import java.util.List;
import java.util.UUID;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;

@Data
public class PortfolioVO implements Serializable{
	private Integer port_num;
	private String mem_id;
	
	@NotBlank
	private String port_name;
	private String port_make;
	private String port_ban;
	
	@NotBlank
	private String port_public;
	private String port_read;
	private String port_scrap;
	private String port_share;
	
	@NotBlank
	private String port_addr;
	private Integer theme_num;
	private String port_date;
	private String port_img;
	private String port_suc;
	private String port_sns_name;
	private String port_sns_addr;
	private String port_explain;
	private String port_user_addr;
	private String port_tell_number; 

	private String question_tel;
	private String question_sns;
	private String question_map;
	private Integer port_like;
	
	private TempVO[] tempArray;
	private List<TempVO> tempList;
	
	@JsonIgnore
	private MultipartFile port_image;
	
	private List<ThemeVO> themeList;
	
	public void setPort_image(MultipartFile port_image) {
		this.port_image = port_image;
		this.port_img = UUID.randomUUID().toString();
	}
}
