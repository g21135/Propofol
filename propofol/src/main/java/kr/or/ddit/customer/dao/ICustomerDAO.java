package kr.or.ddit.customer.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.CustomerVO;
import kr.or.ddit.vo.PagingVO;

@Repository
public interface ICustomerDAO {
	/**
	 * 수 조회
	 * @param pagingVO
	 * @return
	 */
	public int selectCustomerListCount(PagingVO<CustomerVO> pagingVO);
	
	/**
	 * 자신이 작성한 수 조회
	 * @param pagingVO
	 * @return
	 */
	public int selectMyCustomerListCount(PagingVO<CustomerVO> pagingVO);
	
	/**
	 * 전체 조회
	 * @param pagingVO
	 * @return
	 */
	public List<CustomerVO> selectCustomerList(PagingVO<CustomerVO> pagingVO);
	
	/**
	 * 자신이 작성한  전체 조회
	 * @param pagingVO
	 * @return
	 */
	public List<CustomerVO> selectMyCustomerList(PagingVO<CustomerVO> pagingVO);
	
	/**
	 * 단일 조회
	 * @param customer_num
	 * @return
	 */
	public CustomerVO selectCustomer(int customer_num);
	
	/**
	 * 자주 묻는 질문 추가
	 * @param customerVO
	 * @return
	 */
	public int insertFaq(CustomerVO customer);
	
	/**
	 * 자주 묻는 질문 수정
	 * @param customer
	 * @return
	 */
	public int updateFaq(CustomerVO customer);
	
	/**
	 * 질문 추가
	 * @param customer
	 * @return
	 */
	public int insertQuestion(CustomerVO customer);
	
	/**
	 * 질문 수정
	 * @param customer
	 * @return
	 */
	public int updateQuestion(CustomerVO customer);

	/**
	 * 건의 수정
	 * @param customer
	 * @return
	 */
	public int updateSuggest(CustomerVO customer);
	
	/**
	 * 답변 추가
	 * @param customer
	 * @return
	 */
	public int updateAnswer(CustomerVO customer);
	
	/**
	 * 진행상황 추가
	 * @param customer
	 * @return
	 */
	public int updateIng(CustomerVO customer);
	
	/**
	 * 삭제
	 * @param customer_num
	 * @return
	 */
	public int deleteCustomer(CustomerVO customer);
	
	/**
	 * 건의게시판 추가
	 * @param customer
	 * @return
	 */
	public int insertSuggest(CustomerVO customer);
}
