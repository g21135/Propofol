package kr.or.ddit.post.service;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.inject.Inject;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.attach.dao.IAttachDAO;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.exception.CommonException;
import kr.or.ddit.post.dao.IPostDAO;
import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.PostVO;

@Service
public class PostServiceImpl implements IPostService {
	@Inject
	IPostDAO dao;
	@Inject
	IAttachDAO attachDAO;
	
	@Value("#{appInfo.attachPath}")
	private File saveFolder;
	
	/**
	 * 파일 처리
	 * @param customer
	 */
	private void processFiles(PostVO post) {
		int[] delFiles = post.getDelFiles();
		if(delFiles!=null && delFiles.length>0) {
			for(int delFileNo : delFiles) {
				AttachVO saved = attachDAO.selectAttach(delFileNo);
				attachDAO.deleteAttach(delFileNo);
				FileUtils.deleteQuietly(new File(saveFolder, saved.getAtt_savename()));
			}
		}
		
		// 업로드된 파일 처리
		List<AttachVO> attachList= post.getAttachList();
		if(attachList==null || attachList.size()==0) return;
		
		for(AttachVO attach : attachList) {
			attach.setPost_num(post.getPost_num());
			attach.setMem_id(post.getMem_id());
			attachDAO.insertAttach(attach);
			File saveFile = new File(saveFolder, attach.getAtt_savename());
			try(InputStream is = attach.getItem().getInputStream();){
				FileUtils.copyInputStreamToFile(is, saveFile);
			}catch (IOException e) {
				throw new RuntimeException(e);
			}
		}
	}
	
	/**
	 * 게시글 전체 수 조회
	 */
	@Override
	public int retrievePostCount(PagingVO<PostVO> pagingVO) {
		return dao.selectPostListCount(pagingVO);
	}

	/**
	 * 게시글 전체 조회
	 */
	@Override
	public List<PostVO> retrievePostList(PagingVO<PostVO> pagingVO) {
		return dao.selectPostList(pagingVO);
	}

	/**
	 * 게시판 상세 조회
	 */
	@Override
	public PostVO retrievePost(int post_num) {
		PostVO post = dao.selectPost(post_num);
		dao.incrementHit(post_num);
		return post;
	}

	/**
	 * 공지사항 작성
	 */
	@Transactional
	@Override
	public ServiceResult createPost(PostVO post) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt = dao.insertPost(post);
		if (cnt > 0) {
			processFiles(post);
			result = ServiceResult.OK;
		} 
		return result;
	}

	/**
	 * 공지사항 수정
	 */
	@Transactional
	@Override
	public ServiceResult modifyPost(PostVO post) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt = dao.updatePost(post);
		if (cnt > 0) {
			processFiles(post);
			result = ServiceResult.OK;
		} 
		return result;
	}

	/**
	 * 공지사항 삭제
	 */
	@Transactional
	@Override
	public ServiceResult removePost(PostVO post) {
		ServiceResult result = ServiceResult.FAILED;
		dao.deletePost(post);
		if (post.getRowcnt() == 2) {
			List<AttachVO> attachList = post.getAttachList();
			if (attachList != null) {
				for (AttachVO attach : attachList) {
					FileUtils.deleteQuietly(new File(saveFolder, attach.getAtt_savename()));
				}
			}
			result = ServiceResult.OK;
		}
		return result;
	}
	
	/**
	 * 게시글 & 댓글 삭제
	 */
	@Transactional
	@Override
	public ServiceResult removeAllPost(PostVO post) {
		ServiceResult result = ServiceResult.FAILED;
		dao.deleteAllPost(post);
		if (post.getRowcnt() == 3) {
			List<AttachVO> attachList = post.getAttachList();
			if (attachList != null) {
				for (AttachVO attach : attachList) {
					FileUtils.deleteQuietly(new File(saveFolder, attach.getAtt_savename()));
				}
			}
			result = ServiceResult.OK;
		}
		return result;
	}

	/**
	 * 파일 다운로드
	 */
	@Override
	public AttachVO download(int attach_num) {
		AttachVO attach = attachDAO.selectAttach(attach_num);
		if (attach == null) throw new CommonException(attach_num + "파일 없음");
		attachDAO.incrementDownload(attach_num);
		return attach;
	}

	@Override
	public ServiceResult modifyReportPost(int post_num) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt = dao.updateReportPost(post_num);
		if (cnt > 0) {
//			processFiles(post);
			result = ServiceResult.OK;
		} 
		return result;
	}

	@Override
	public ServiceResult removeReportPost(PostVO post) {
		ServiceResult result = ServiceResult.FAILED;
		dao.deleteReportPost(post);
		if (post.getRowcnt() == 4) {
			List<AttachVO> attachList = post.getAttachList();
			if (attachList != null) {
				for (AttachVO attach : attachList) {
					FileUtils.deleteQuietly(new File(saveFolder, attach.getAtt_savename()));
				}
			}
			result = ServiceResult.OK;
		}
		return result;
	}
}
