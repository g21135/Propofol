package kr.or.ddit.member.service;

import java.security.NoSuchAlgorithmException;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.utils.SecurityUtils;
import kr.or.ddit.vo.MemberVO;

@Service
public class AuthenticateServiceImpl implements IAuthenticateService {
	
	@Inject
	IMemberService service;
	
	@Override
	public Object authenticate(MemberVO member) throws NoSuchAlgorithmException {

		Object result = ServiceResult.INVALIDPASSWORD;//비밀번호 틀림
		MemberVO savedmember = service.retrieveMember(member.getMem_id());
		
		if("Y".equals(savedmember.getMem_del())) {
			result = ServiceResult.NOTAVAILABLE;	//탈퇴신청한 회원
		}else if(4 == savedmember.getGr_num()) {
			result = ServiceResult.BLACKLIST;	//블랙리스트
		}else if(savedmember.getMem_pass().trim().equals(SecurityUtils.sha512(member.getMem_pass()).trim())){
			result = savedmember;
		}
		
		return result;
	}

}
