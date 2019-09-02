package kr.or.ddit.portfolio.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.PortfolioVO;
import kr.or.ddit.vo.ThemeVO;

@Repository
public interface IPortfolioDAO {
	/**
	 * 포트폴리오 목록 수 조회
	 * @param pagingVO(paging num, theme_num)
	 * @return
	 */
	public int selectPortfolioListCount(PagingVO<PortfolioVO> pagingVO);
	
	/**
	 * 포트폴리오 목록 조회
	 * @param pagingVO(paging num, theme_num)
	 * @return
	 */
	public List<PortfolioVO> selectPortfolioList(PagingVO<PortfolioVO> pagingVO);
	
	/**
	 * 포트폴리오 목록 조회
	 * @param pagingVO(paging num, theme_num)
	 * @return
	 */
	public List<PortfolioVO> selectMyPortfolioList(PagingVO<PortfolioVO> pagingVO);
	
	/**
	 * 성공포트폴리오 목록 수 조회
	 * @param pagingVO(paging num, theme_num)
	 * @return
	 */
	public int selectSuccessPortfolioListCount(PagingVO<PortfolioVO> pagingVO);
	
	/**
	 * 성공포트폴리오 목록 조회
	 * @param pagingVO(paging num, theme_num)
	 * @return
	 */
	public List<PortfolioVO> selectSuccessPortfolioList(PagingVO<PortfolioVO> pagingVO);
	
	/**
	 * 포트폴리오 단일 조회
	 * @param port_num
	 * @return
	 */
	public PortfolioVO selectPortfolio(int port_num);
	
	/**
	 * 테마 목록 조회
	 * @return
	 */
	public List<ThemeVO> themeList();
	
//	/**
//	 * 조회수 증가
//	 * @param port_num
//	 * @return
//	 */
//	public int incrementHit(int port_num);
	
	/**
	 * 포트폴리오 작성
	 * @param port
	 * @return
	 */
	public int insertPort(PortfolioVO port);
	
	/**
	 * 포트폴리오 수정
	 * @param port
	 * @return
	 */
	public int updatePort(PortfolioVO port);
	
	/**
	 * 부적절한 포트폴리오 등록
	 * @param port_num
	 * @return
	 */
	public int blackPortfolio(int port_num);

	/**
	 * 포트폴리오 확인
	 * @param port_num
	 * @return
	 */
	public int readPortfolio(int port_num);

	/**
	 * 부적절한 포트폴리오 해제
	 * @param port_num
	 * @return
	 */
	public int unblackPortfolio(int port_num);

	/**
	 * 포트폴리오 삭제
	 * @param pv
	 * @return
	 */
	public int deletePortfolio(PortfolioVO pv);

	/**
	 * 포트폴리오 공개설정 변경
	 * @param port_num
	 * @return
	 */
	public int publicSettingPortfolio(PortfolioVO portVO);

	public int checkPort(String mem_id);
	
	public int checkMemberShip(String mem_id);
}
