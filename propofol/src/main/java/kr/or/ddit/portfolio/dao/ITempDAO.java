package kr.or.ddit.portfolio.dao;

import org.springframework.stereotype.Repository;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.vo.PortfolioVO;
import kr.or.ddit.vo.TempVO;

@Repository
public interface ITempDAO {

	/**
	 * 임시 저장
	 * 
	 * @param port
	 * @return
	 */
	public int insert(PortfolioVO port);
	
	/**
	 * @param tmep
	 * @return
	 */
	public int update(TempVO tmep);
	
	/**
	 * 포트폴리오 가져오기
	 * @param port
	 * @return
	 */
	public int[] select(int port_num);

		
}
