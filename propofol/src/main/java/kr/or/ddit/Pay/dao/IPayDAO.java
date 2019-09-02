package kr.or.ddit.Pay.dao;

import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.OrderTbVO;

@Repository
public interface IPayDAO {

	/**
	 * 맴버쉽 구매
	 * @param mem_id
	 * @param months
	 * @return
	 */
	public int UpdateMemberShip(MemberVO mv);
	
	/**
	 * 마지막날 = 오늘날짜  업뎃
	 * @param mv
	 * @return
	 */
	public int updateEndDay(MemberVO mv);
	
	/**
	 * 구매시 구매이력에 삽입
	 * @param ot
	 * @return
	 */
	public int insertOrderList(OrderTbVO ot);
}
