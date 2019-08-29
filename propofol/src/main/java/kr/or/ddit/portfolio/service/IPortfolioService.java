package kr.or.ddit.portfolio.service;

import java.util.List;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.PortfolioVO;

public interface IPortfolioService {
	/**
	 * 임시 저장
	 * 
	 * @param port
	 * @return
	 */
	public ServiceResult updateTempPort(PortfolioVO port);
	
	
	/**
	 * 포트폴리오 목록 수 조회
	 * @param pagingVO
	 * @return
	 */
	public int retrievePortCount(PagingVO<PortfolioVO> pagingVO);
	
	/**
	 * 포트폴리오 목록 조회
	 * @param pagingVO
	 * @return
	 */
	public List<PortfolioVO> retrievePortList(PagingVO<PortfolioVO> pagingVO);
	
	/**
	 * 성공한 포트폴리오 목록 수 조회
	 * @param pagingVO
	 * @return
	 */
	public int retrieveSucPortCount(PagingVO<PortfolioVO> pagingVO);
	
	/**
	 * 성공한 포트폴리오 목록 조회
	 * @param pagingVO
	 * @return
	 */
	public List<PortfolioVO> retrieveSucPortList(PagingVO<PortfolioVO> pagingVO);

	/**
	 * 포트폴리오 단일 조회
	 * @param port_num
	 * @return
	 */
	public PortfolioVO retrievePort(int port_num);
	
	/**
	 * 포트폴리오 추가
	 * @param port
	 * @return
	 */
	public ServiceResult createPort(PortfolioVO port);


	/**
	 * 포트폴리오 수정
	 * @param port
	 * @return
	 */
	public ServiceResult modifyPort(PortfolioVO port);
	
	/**
	 * 부적절한 포트폴리오
	 * @param port_num
	 * @return
	 */
	public ServiceResult banPort(int port_num);

	/**
	 * 포트폴리오 확인
	 * @param port_num
	 * @return
	 */
	public ServiceResult readPort(int port_num);

	/**
	 * 부적절한 포트폴리오 해제
	 * @param port_num
	 * @return
	 */
	public ServiceResult unbanPort(int port_num);

	/**
	 * 포트폴리오 삭제
	 * @param port_num
	 * @return
	 */
	public ServiceResult deletePort(int port_num);
	
	/**
	 * 포트폴리오 공개 설정
	 * @param port_num
	 * @return
	 */
	public ServiceResult portPublicSetting(PortfolioVO portVO);

	public int checkPort(String mem_id);
}
