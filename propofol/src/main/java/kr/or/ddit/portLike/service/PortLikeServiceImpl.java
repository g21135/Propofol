package kr.or.ddit.portLike.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.portLike.dao.IPortLikeDAO;
import kr.or.ddit.vo.PortLikeVO;

@Service
public class PortLikeServiceImpl implements IPortLikeService {
	@Inject
	IPortLikeDAO dao;
	
	@Override
	public ServiceResult createLike(PortLikeVO portLike) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt = dao.insertLike(portLike);
		if(cnt > 0) {
			result = ServiceResult.OK;
		}
		return result;
	}

	@Override
	public ServiceResult deleteLike(PortLikeVO portLike) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt = dao.deleteLike(portLike);
		if(cnt > 0) {
			result = ServiceResult.OK;
		}
		return result;
	}
}