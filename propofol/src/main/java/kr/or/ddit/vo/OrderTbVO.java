package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data
public class OrderTbVO {
	private Integer order_num;
	private String mem_id;
	private String order_type;
	private String order_start_date;
	private String order_end_date;
	private String order_date;
	private Integer order_cost;
	private String order_way;
	private String order_means;
	private String order_pay;
	private String admin_id;
	private String port_name;
	private Integer port_num;
	
	private List<OrderFormVO> orderFormList;
}
