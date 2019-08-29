package kr.or.ddit.reply.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Repository;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.reply.dao.IReplyDAO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.ReplyVO;

@Repository
public class ReplyServiceImpl implements IReplyService {
	private ReplyServiceImpl() {}
	private static ReplyServiceImpl service;
	public static ReplyServiceImpl getInstance() {
		if(service == null)
			service = new ReplyServiceImpl();
		return service;
	}
	
	@Inject
	IReplyDAO replyDAO;
	
	@Override
	public ServiceResult createReply(ReplyVO reply) {
		int cnt = replyDAO.insertReply(reply);
		ServiceResult result = ServiceResult.FAILED;
		if(cnt > 0) 
			result = ServiceResult.OK;
		return result;
	}

	@Override
	public int retrieveReplyCount(PagingVO<ReplyVO> pagingVO) {
		return replyDAO.selectReplyCount(pagingVO);
	}

	@Override
	public List<ReplyVO> retrieveReplyList(PagingVO<ReplyVO> pagingVO) {
		return replyDAO.selectReplyList(pagingVO);
	}

	@Override
	public ServiceResult modifyReply(ReplyVO reply) {
		int cnt = replyDAO.updateReply(reply);
		ServiceResult result = ServiceResult.FAILED;
		if(cnt > 0) 
			result = ServiceResult.OK;
		return result;
	}

	@Override
	public ServiceResult removeReply(ReplyVO reply) {
		int cnt = replyDAO.deleteReply(reply);
		ServiceResult result = ServiceResult.FAILED;
		if (cnt > 0) result = ServiceResult.OK;
		return result;
	}
}
