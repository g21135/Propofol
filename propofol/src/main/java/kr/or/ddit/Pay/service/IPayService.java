package kr.or.ddit.Pay.service;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.OrderTbVO;

public interface IPayService {

	public ServiceResult ModifyMemberShip(MemberVO mv);
	
	public ServiceResult ModifyEndDay(MemberVO mv);
	
	public ServiceResult createOrderList(OrderTbVO ot);
	
}
