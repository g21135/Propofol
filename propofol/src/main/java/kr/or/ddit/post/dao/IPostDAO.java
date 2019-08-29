package kr.or.ddit.post.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.PostVO;
import kr.or.ddit.vo.TypeVO;

@Repository
public interface IPostDAO {
	/**
	 * 게시판 목록 수 조회
	 * @param pagingVO(paging num, type_num)
	 * @return
	 */
	public int selectPostListCount(PagingVO<PostVO> pagingVO);
	
	/**
	 * 게시판 목록 조회
	 * @param pagingVO(paging num, type_num)
	 * @return
	 */
	public List<PostVO> selectPostList(PagingVO<PostVO> pagingVO);
	
	/**
	 * 게시판 단일 조회
	 * @param post_num
	 * @return
	 */
	public PostVO selectPost(int post_num);
	
	/**
	 * 카테고리 목록 조회
	 * @return
	 */
	public List<TypeVO> typeList();
	
	/**
	 * 조회수 증가
	 * @param post_num
	 * @return
	 */
	public int incrementHit(int post_num);
	
	/**
	 * 게시글 작성
	 * @param post
	 * @return
	 */
	public int insertPost(PostVO post);
	
	/**
	 * 게시글 수정
	 * @param post
	 * @return
	 */
	public int updatePost(PostVO post);
	
	/**
	 * 신고 게시글 수정
	 * @param post
	 * @return
	 */
	public int updateReportPost(int post_num);
	
	/**
	 * 게시글 & 첨부파일 삭제
	 * @param post
	 * @return
	 */
	public int deletePost(PostVO post);
	
	/**
	 * 게시글 & 첨부파일 & 댓글 삭제
	 * @param post
	 * @return
	 */
	public int deleteAllPost(PostVO post);
	
	/**
	 * 게시글 & 첨부파일 & 댓글 삭제 & 신고 글 삭제
	 * @param post
	 * @return
	 */
	public int deleteReportPost(PostVO post);
}
