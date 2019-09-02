package kr.or.ddit.portLike.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.PortLikeVO;

@Repository
public interface IPortLikeDAO {
	/**
	 * 좋아요 목록 조회
	 * @return
	 */
	public List<PortLikeVO> selectLikeList();
	
	/**
	 * 좋아요 추가
	 * @param portLike
	 * @return
	 */
	public int insertLike(PortLikeVO portLike);
	
	/**
	 * 좋아요 삭제
	 * @param portLike
	 * @return
	 */
	public int deleteLike(PortLikeVO portLike);
}
