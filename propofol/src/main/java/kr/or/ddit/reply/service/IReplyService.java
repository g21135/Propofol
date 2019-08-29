package kr.or.ddit.reply.service;

import java.util.List;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.ReplyVO;

public interface IReplyService {
	/**
	 * @param reply
	 * @return
	 */
	public ServiceResult createReply(ReplyVO reply);
	
	/**
	 * @param pagingVO
	 * @return
	 */
	public int retrieveReplyCount(PagingVO<ReplyVO> pagingVO);
	
	/**
	 * @param pagingVO
	 * @return
	 */
	public List<ReplyVO> retrieveReplyList(PagingVO<ReplyVO> pagingVO);
	
	/**
	 * @param reply
	 * @return
	 */
	public ServiceResult modifyReply(ReplyVO reply);
	
	/**
	 * 비밀번호 오류, 없음, 실패, 성공
	 * @param reply
	 * @return
	 */
	public ServiceResult removeReply(ReplyVO reply);
}
