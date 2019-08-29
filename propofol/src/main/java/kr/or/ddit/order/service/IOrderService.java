package kr.or.ddit.order.service;

import java.util.List;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.vo.OrderTbVO;
import kr.or.ddit.vo.PagingVO;

public interface IOrderService {
	/**
	 * 주문 목록 수 조회
	 * @param pagingVO
	 * @return
	 */
	public int retrieveOrderCount(PagingVO<OrderTbVO> pagingVO);
	
	/**
	 * 주문 목록 조회
	 * @param pagingVO
	 * @return
	 */
	public List<OrderTbVO> retrieveOrderList(PagingVO<OrderTbVO> pagingVO);
	
	/**
	 * 주문 단일 조회
	 * @param order_num
	 * @return
	 */
	public OrderTbVO retrieveOrder(int order_num);
	
	/**
	 * 주문 신청
	 * @param order
	 * @return
	 */
	public ServiceResult creatPOrder(OrderTbVO order);
	
	/**
	 * 주문 수정
	 * @param order
	 * @return
	 */
	public ServiceResult modifyOrder(OrderTbVO order);
	
	/**
	 * 주문 삭제
	 * @param order_num
	 * @return
	 */
	public ServiceResult removeOrder(int order_num);
	
	/**
	 * 주문 삭제
	 * @param order_num
	 * @return
	 */
	public ServiceResult choiceOrder(OrderTbVO Order);

	
	/**
	 * 주문작업 완료
	 * @param completion_num
	 * @return
	 */
	public ServiceResult completionOrder(int completion_num);
}
