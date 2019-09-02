package kr.or.ddit.order.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.order.dao.IOrderDAO;
import kr.or.ddit.vo.OrderTbVO;
import kr.or.ddit.vo.PagingVO;

@Service
public class OrderServiceImpl implements IOrderService {
	@Inject
	IOrderDAO dao;

	@Override
	public int retrieveOrderCount(PagingVO<OrderTbVO> pagingVO) {
		return dao.selectOrderListCount(pagingVO);
	}

	@Override
	public List<OrderTbVO> retrieveTypeOrderList(OrderTbVO orderTbVO) {
		return dao.selectTypeOrderList(orderTbVO);
	}
	
	@Override
	public List<OrderTbVO> retrieveMonthOrderList(OrderTbVO orderTbVO) {
		return dao.selectMonthOrderList(orderTbVO);
	}
	
	@Override
	public List<OrderTbVO> retrieveManagerOrderList(OrderTbVO orderTbVO) {
		return dao.selectManagerOrderList(orderTbVO);
	}
	
	@Override
	public List<OrderTbVO> retrieveOrderList(PagingVO<OrderTbVO> pagingVO) {
		return dao.selectOrderList(pagingVO);
	}

	@Override
	public OrderTbVO retrieveOrder(int Order_num) {
		OrderTbVO order = dao.selectOrder(Order_num);
		return order;
	}

	@Override
	public ServiceResult creatPOrder(OrderTbVO Order) {
		return null;
	}

	@Override
	public ServiceResult modifyOrder(OrderTbVO Order) {
		return null;
	}

	@Override
	public ServiceResult removeOrder(int Order_num) {
		return null;
	}

	@Override
	public ServiceResult choiceOrder(OrderTbVO Order) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt = dao.choiceOrder(Order);
		if(cnt > 0) {
			result = ServiceResult.OK;
		}
		return result;
	}

	@Override
	public ServiceResult completionOrder(int completion_num) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt = dao.completionOrder(completion_num);
		if(cnt > 0) {
			result = ServiceResult.OK;
		}
		return result;
	}
}
