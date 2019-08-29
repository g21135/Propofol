package kr.or.ddit.member.service;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.security.NoSuchAlgorithmException;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.exception.UserNotFoundException;
import kr.or.ddit.member.dao.IMemberDAO;
import kr.or.ddit.utils.SecurityUtils;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.PagingVO;

@Service
public class MemberServiceImpl implements IMemberService {

	@Inject
	WebApplicationContext container;
	
	@Inject
	IMemberDAO memberDAO;
	
	@Inject
	IAuthenticateService service;
	
	
	private static Logger logger =LoggerFactory.getLogger(MemberServiceImpl.class);
	
	
	@Value("#{appInfo.memImages}")
	String saveFolderUrl;
	
	File saveFolder =null;
	
	@PostConstruct //생성한 이후에 실행해라. init-method
	public void init() {
		//이미지 저장 위치 : 웹 리소스의 형태
		String fileSystemPath = container.getServletContext().getRealPath(saveFolderUrl);
		saveFolder = new File(fileSystemPath);
		if(!saveFolder.exists()) saveFolder.mkdirs();
	}
	
	private void processImage(MemberVO mv) {
		MultipartFile image = mv.getMem_img();
		if(image == null) {
			return;
		}
		
		MemberVO memberVO = memberDAO.selectMember(mv.getMem_id());
		String img = memberVO.getMem_image();
		FileUtils.deleteQuietly(new File(saveFolder, img));
		
		File saveFile = new File(saveFolder,mv.getMem_image());
		try(
			InputStream is = image.getInputStream();	
				) {
			FileUtils.copyInputStreamToFile(is, saveFile);
		}catch (IOException e) {
			throw new RuntimeException(e);
		}
	}
	
	@Override
	public long retrieveMemberCount(PagingVO<MemberVO> paging) {
		return memberDAO.selectMemberCount(paging);
	}
	
	@Override
	public List<MemberVO> retrieveMemberList(PagingVO<MemberVO> pagingVO) {
		List<MemberVO> memberList = memberDAO.selectMemberList(pagingVO);
		return memberList;
	}

	@Override
	public MemberVO retrieveMember(String mem_id) {
		MemberVO member = memberDAO.selectMember(mem_id);
		if (member == null)
			throw new UserNotFoundException(mem_id + " 회원 없음"); //최종적으로 서버에 넘어가게 한것
		return member;
	}

	@Transactional
	@Override
	public ServiceResult createMember(MemberVO member) throws NoSuchAlgorithmException {
		ServiceResult result = ServiceResult.FAILED;
		try {
			retrieveMember(member.getMem_id());
			result = ServiceResult.PKDUPLICATED;
		} catch (UserNotFoundException e) {
			member.setMem_pass(SecurityUtils.sha512(member.getMem_pass()));
			int cnt = memberDAO.insertMember(member);
			processImage(member);
			if (cnt > 0) {
				result = ServiceResult.OK;
			} 
		}
		return result;
	}

	@Transactional
	@Override
	public ServiceResult modifyMember(MemberVO member) throws NoSuchAlgorithmException {
		ServiceResult result = null;
		member.setMem_pass(SecurityUtils.sha512(member.getMem_pass()));
		processImage(member);
		int cnt = memberDAO.updateMember(member);
		if(cnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public ServiceResult removeMember(MemberVO member) {
		ServiceResult result = null;
		int cnt = memberDAO.deleteMember(member.getMem_id());
		if(cnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public ServiceResult modifyGrade(MemberVO member) {
		ServiceResult result = null;
		int cnt = memberDAO.updateGrade(member);
		if(cnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public MemberVO retrieveMemberForFindUserInfo(MemberVO mv) {
		MemberVO member = memberDAO.findMember(mv);
		if (member == null)
			throw new UserNotFoundException(mv.getMem_name() + " 회원 없음"); //최종적으로 서버에 넘어가게 한것
		return member;
	}
	
	@Override
	public ServiceResult modifyPass(MemberVO member) throws NoSuchAlgorithmException {
		ServiceResult result = null;
		member.setMem_pass(SecurityUtils.sha512(member.getMem_pass()));
		int cnt = memberDAO.updatePass(member);
		if(cnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public ServiceResult addSession(MemberVO member) {
		ServiceResult result = null;
		int cnt = memberDAO.updateSession(member);
		if(cnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public MemberVO retrieveSessionMember(String sessoin_id) {
		//만료되었을 때 처리 해야함
		MemberVO mv = memberDAO.chkSession(sessoin_id);
		if(mv == null) {
			throw new UserNotFoundException("로그인 유지기간이 만료되었습니다.");
		}else {
			return mv;
		}
	}
	
}
