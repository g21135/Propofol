package kr.or.ddit.post.service;

import java.util.List;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.PostVO;

public interface IPostService {
	/**
	 * 게시판 목록 수 조회
	 * @param pagingVO
	 * @return
	 */
	public int retrievePostCount(PagingVO<PostVO> pagingVO);
	
	/**
	 * 게시판 목록 조회
	 * @param pagingVO
	 * @return
	 */
	public List<PostVO> retrievePostList(PagingVO<PostVO> pagingVO);

	/**
	 * 게시글 단일 조회
	 * @param post_num
	 * @return
	 */
	public PostVO retrievePost(int post_num);
	
	/**
	 * 게시판 추가
	 * @param post
	 * @return
	 */
	public ServiceResult createPost(PostVO post);
	
	/**
	 * 게시판 수정
	 * @param post
	 * @return
	 */
	public ServiceResult modifyPost(PostVO post);
	
	/**
	 * 신고 게시판 수정
	 * @param post
	 * @return
	 */
	public ServiceResult modifyReportPost(int post_num);
	
	/**
	 * 게시판 삭제
	 * @param post_num
	 * @return
	 */
	public ServiceResult removePost(PostVO post);
	
	/**
	 * 게시판 & 댓글 삭제
	 * @param post_num
	 * @return
	 */
	public ServiceResult removeAllPost(PostVO post);
	
	/**
	 * 게시판 & 댓글 삭제 & 신고
	 * @param post_num
	 * @return
	 */
	public ServiceResult removeReportPost(PostVO post);
	
	/**
	 * @param att_no
	 * @return
	 */
	public AttachVO download(int attach_num);
}
