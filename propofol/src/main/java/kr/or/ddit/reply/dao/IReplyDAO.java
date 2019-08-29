package kr.or.ddit.reply.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.ReplyVO;

@Repository
public interface IReplyDAO {
	/**
	 * 댓글 추가
	 * @param reply
	 * @return
	 */
	public int insertReply(ReplyVO reply);
	
	/**
	 * 댓글 수 조회
	 * @param pagingVO
	 * @return
	 */
	public int selectReplyCount(PagingVO<ReplyVO> pagingVO);
	
	/**
	 * 댓글 목록 조회
	 * @param pagingVO
	 * @return
	 */
	public List<ReplyVO> selectReplyList(PagingVO<ReplyVO> pagingVO);
	
	/**
	 * 댓글 단일 조회
	 * @param rep_no
	 * @return
	 */
	public ReplyVO selectReply(long rep_no);
	
	/**
	 * 댓글 수정
	 * @param reply
	 * @return
	 */
	public int updateReply(ReplyVO reply);
	
	/**
	 * 댓글 삭제
	 * @param reply
	 * @return
	 */
	public int deleteReply(ReplyVO reply);
}
