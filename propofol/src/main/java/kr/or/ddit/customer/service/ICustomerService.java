package kr.or.ddit.customer.service;

import java.util.List;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.CustomerVO;
import kr.or.ddit.vo.PagingVO;

public interface ICustomerService {
	/**
	 * 게시판 수 조회
	 * @param pagingVO
	 * @return
	 */
	public int retrieveCustomerCount(PagingVO<CustomerVO> pagingVO);
	
	/**
	 * 자신이 작성한 게시판 수 조회
	 * @param pagingVO
	 * @return
	 */
	public int retrieveMyCustomerCount(PagingVO<CustomerVO> pagingVO);
	
	/**
	 * 전체 조회
	 * @param pagingVO
	 * @return
	 */
	public List<CustomerVO> retrieveCustomerList(PagingVO<CustomerVO> pagingVO);
	
	/**
	 * 자신이 작성한 전체 조회
	 * @param pagingVO
	 * @return
	 */
	public List<CustomerVO> retrieveMyCustomerList(PagingVO<CustomerVO> pagingVO);

	/**
	 * 상세조회
	 * @param customer_num
	 * @return
	 */
	public CustomerVO retrieveCustomer(int customer_num);
	
	/**
	 * 자주 묻는 질문 추가
	 * @param Customer
	 * @return
	 */
	public ServiceResult createFaq(CustomerVO customer);
	
	/**
	 * 자주 묻는 질문 수정
	 * @param Customer
	 * @return
	 */
	public ServiceResult modifyFaq(CustomerVO customer);
	
	/**
	 * 질문 추가
	 * @param customer
	 * @return
	 */
	public ServiceResult createQuestion(CustomerVO customer);
	
	/**
	 * 질문 수정
	 * @param customer
	 * @return
	 */
	public ServiceResult modifyQuestion(CustomerVO customer);
	
	/**
	 * 답변 추가
	 * @param customer
	 * @return
	 */
	public ServiceResult modifyAnswer(CustomerVO customer);
	
	/**
	 * 건의사항 추가
	 * @param customer
	 * @return
	 */
	public ServiceResult createSuggest(CustomerVO customer);
	
	/**
	 * 건의 수정
	 * @param customer
	 * @return
	 */
	public ServiceResult modifySuggest(CustomerVO customer);
	
	/**
	 * 진행상황 전달
	 * @param customer
	 * @return
	 */
	public ServiceResult modifyIng(CustomerVO customer);

	/**
	 * 자주 묻는 질문 삭제
	 * @param customer_num
	 * @return
	 */
	public ServiceResult removeCustomer(CustomerVO customer);
	
	/**
	 * @param att_no
	 * @return
	 */
	public AttachVO download(int attach_num);
}
