package kr.or.ddit.order.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.vo.OrderTbVO;
import kr.or.ddit.vo.PagingVO;

@Repository
public interface IOrderDAO {
	/**
	 * 주문 목록 수 조회
	 * @param pagingVO(paging num, theme_num)
	 * @return
	 */
	public int selectOrderListCount(PagingVO<OrderTbVO> pagingVO);
	
	/**
	 * 주문 목록 조회
	 * @param pagingVO(paging num, theme_num)
	 * @return
	 */
	public List<OrderTbVO> selectOrderList(PagingVO<OrderTbVO> pagingVO);
	
	/**
	 * 주문 단일 조회
	 * @param Order_num
	 * @return
	 */
	public OrderTbVO selectOrder(int order_num);
	
//	/**
//	 * 조회수 증가
//	 * @param Order_num
//	 * @return
//	 */
//	public int incrementHit(int Order_num);
	
	/**
	 * 주문 신청
	 * @param Order
	 * @return
	 */
	public int insertOrder(OrderTbVO Order);
	
	/**
	 * 주문 수정
	 * @param Order
	 * @return
	 */
	public int updateOrder(OrderTbVO Order);
	
	/**
	 * 주문 삭제
	 * @param Order_num
	 * @return
	 */
	public int deleteOrder(int Order_num);

	
	/**
	 * 주문 선택
	 * @param order_num
	 * @return
	 */
	public int choiceOrder(OrderTbVO Order);

	
	/**
	 * 주문작업완료 업데이트
	 * @param completion_num
	 * @return
	 */
	public int completionOrder(int completion_num);

}
