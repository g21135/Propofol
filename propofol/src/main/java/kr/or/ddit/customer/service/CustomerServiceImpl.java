package kr.or.ddit.customer.service;

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
import kr.or.ddit.customer.dao.ICustomerDAO;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.exception.CommonException;
import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.CustomerVO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.PostVO;

@Service
public class CustomerServiceImpl implements ICustomerService {
	@Inject
	ICustomerDAO dao;
	@Inject
	IAttachDAO attachDAO;
	
	@Value("#{appInfo.attachPath}")
	private File saveFolder;
	
	/**
	 * 파일 처리
	 * @param customer
	 */
	private void processFiles(CustomerVO customer) {
		int[] delFiles = customer.getDelFiles();
		if(delFiles!=null && delFiles.length>0) {
			for(int delFileNo : delFiles) {
				AttachVO saved = attachDAO.selectAttach(delFileNo);
				attachDAO.deleteAttach(delFileNo);
				FileUtils.deleteQuietly(new File(saveFolder, saved.getAtt_savename()));
			}
		}
		
		// 업로드된 파일 처리
		List<AttachVO> attachList= customer.getAttachList();
		if(attachList==null || attachList.size()==0) return;
		
		for(AttachVO attach : attachList) {
			attach.setCustomer_num(customer.getCustomer_num());
			attach.setMem_id(customer.getMem_id());
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
	public int retrieveCustomerCount(PagingVO<CustomerVO> pagingVO) {
		return dao.selectCustomerListCount(pagingVO);
	}

	/**
	 * 자신이 작성한 게시글 수 조회
	 */
	@Override
	public int retrieveMyCustomerCount(PagingVO<CustomerVO> pagingVO) {
		return dao.selectMyCustomerListCount(pagingVO);
	}

	/**
	 * 게시글 전체 조회
	 */
	@Override
	public List<CustomerVO> retrieveCustomerList(PagingVO<CustomerVO> pagingVO) {
		return dao.selectCustomerList(pagingVO);
	}

	/**
	 * 자신이 작성한 게시글 조회
	 */
	@Override
	public List<CustomerVO> retrieveMyCustomerList(PagingVO<CustomerVO> pagingVO) {
		return dao.selectMyCustomerList(pagingVO);
	}

	/**
	 * 게시판 상세 조회
	 */
	@Override
	public CustomerVO retrieveCustomer(int customer_num) {
		CustomerVO customer = dao.selectCustomer(customer_num);
		return customer;
	}

	/**
	 * 자주 묻는 질문 작성
	 */
	@Override
	public ServiceResult createFaq(CustomerVO customer) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt = dao.insertFaq(customer);
		if (cnt > 0) {
			result = ServiceResult.OK;
		} 
		return result;
	}

	/**
	 * 자주 묻는 질문 수정
	 */
	@Override
	public ServiceResult modifyFaq(CustomerVO customer) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt = dao.updateFaq(customer);
		if (cnt > 0) {
			result = ServiceResult.OK;
		} 
		return result;
	}

	/**
	 * 질문 작성
	 */
	@Transactional
	@Override
	public ServiceResult createQuestion(CustomerVO customer) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt = dao.insertQuestion(customer);
		if (cnt > 0) {
			processFiles(customer);
			result = ServiceResult.OK;
		} 
		return result;
	}

	@Transactional
	@Override
	public ServiceResult modifyQuestion(CustomerVO customer) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt = dao.updateQuestion(customer);
		if (cnt > 0) {
			processFiles(customer);
			result = ServiceResult.OK;
		} 
		return result;
	}

	/**
	 * 건의사항 작성
	 */
	@Transactional
	@Override
	public ServiceResult createSuggest(CustomerVO customer) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt = dao.insertSuggest(customer);
		if (cnt > 0) {
			processFiles(customer);
			result = ServiceResult.OK;
		} 
		return result;
	}

	/**
	 * 답변 수정
	 */
	@Override
	public ServiceResult modifyAnswer(CustomerVO customer) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt = dao.updateAnswer(customer);
		if (cnt > 0) {
			result = ServiceResult.OK;
		} 
		return result;
	}

	/**
	 * 건의 사항 수정
	 */
	@Transactional
	@Override
	public ServiceResult modifySuggest(CustomerVO customer) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt = dao.updateSuggest(customer);
		if (cnt > 0) {
			processFiles(customer);
			result = ServiceResult.OK;
		} 
		return result;
	}

	/**
	 * 진행상황 변경
	 */
	@Override
	public ServiceResult modifyIng(CustomerVO customer) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt = dao.updateIng(customer);
		if (cnt > 0) {
			result = ServiceResult.OK;
		} 
		return result;
	}
	
	/**
	 * 고객센터 게시판 삭제
	 */
	@Override
	public ServiceResult removeCustomer (CustomerVO customer) {
		ServiceResult result = ServiceResult.FAILED;
		dao.deleteCustomer(customer);
		if (customer.getRowcnt() == 2) {
			List<AttachVO> attachList = customer.getAttachList();
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
}
