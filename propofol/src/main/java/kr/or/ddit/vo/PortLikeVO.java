package kr.or.ddit.vo;

import lombok.Data;

@Data
public class PortLikeVO {
	private Integer like_num;
	public PortLikeVO(Integer port_num, String mem_id) {
		super();
		this.port_num = port_num;
		this.mem_id = mem_id;
	}
	private Integer port_num;
	private String mem_id;
}
