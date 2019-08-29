package kr.or.ddit.portLike.service;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.vo.PortLikeVO;

public interface IPortLikeService {
	/**
	 * 좋아요 추가
	 * @param portLike
	 * @return
	 */
	public ServiceResult createLike(PortLikeVO portLike);
	
	/**
	 * 좋아요 삭제
	 * @param portLike
	 * @return
	 */
	public ServiceResult deleteLike(PortLikeVO portLike);
}
