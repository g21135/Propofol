package kr.or.ddit.member.service;

import java.security.NoSuchAlgorithmException;

import kr.or.ddit.vo.MemberVO;

public interface IAuthenticateService { //인증을 할 수 있는 로직만 넣어 줄것

	/**
	 * 아이디 패스워드 기반의 인증처리 
	 * @param member
	 * @return 존재하지 않는 경우(UserNotFound예외), 비번 오류(INVALIDPASSWORD), 탈퇴를 했는데 데이터베이스에 남아있는 경우(NOTAVAILABLE), 인증성공(OK)
	 * @throws NoSuchAlgorithmException 
	 */
	Object authenticate(MemberVO member) throws NoSuchAlgorithmException;
}
