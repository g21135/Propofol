package kr.or.ddit.Pay.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.Pay.dao.IPayDAO;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.OrderTbVO;

@Service
public class PayServiceImpl implements IPayService {

	@Inject  
	IPayDAO dao;
	
	@Override
	public ServiceResult ModifyMemberShip(MemberVO mv) {
		ServiceResult result = null;
		int cnt = dao.UpdateMemberShip(mv);
		if(cnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public ServiceResult ModifyEndDay(MemberVO mv) {
		ServiceResult result = null;
		int cnt = dao.updateEndDay(mv);
		if(cnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public ServiceResult createOrderList(OrderTbVO ot) {
		ServiceResult result = null;
		int cnt = dao.insertOrderList(ot);
		if(cnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}
	
}
