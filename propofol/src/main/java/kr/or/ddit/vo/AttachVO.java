package kr.or.ddit.vo;

import java.util.UUID;

import org.apache.commons.io.FileUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@EqualsAndHashCode(of = {"attach_num"})
public class AttachVO {
	public AttachVO(MultipartFile item){
		this.item = item;
		att_name = item.getOriginalFilename();
		att_mime = item.getContentType();
		att_size = item.getSize();
		att_savename = UUID.randomUUID().toString();
		att_fancysize = FileUtils.byteCountToDisplaySize(att_size);	
	}
	
	private MultipartFile item;
	private Integer attach_num;
	private String mem_id;
	private String att_name;
	private String att_savename;
	private String att_mime;
	private long att_size;
	private String att_fancysize;
	private Integer att_download;
	private String att_detail;
	private Integer customer_num;
	private Integer post_num;
	
}
