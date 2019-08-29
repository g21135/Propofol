package kr.or.ddit.member.service;

import java.security.NoSuchAlgorithmException;
import java.util.List;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.PagingVO;

/**
 * 회원관리를 위한 business Logic Layer를 위한 추상화
 * 
 * @author 권준수
 */
public interface IMemberService {
	
	public long retrieveMemberCount(PagingVO<MemberVO> paging);
	public List<MemberVO> retrieveMemberList(PagingVO<MemberVO> pagingVO);
	/**
	 * 상세 조회
	 * @param mem_id 조회할 아이디를 받는다.
	 * @return 존재하지 않는 경우, UserNotFoundException 발생
	 */
	public MemberVO retrieveMember(String mem_id);
	
	/**
	 * 회원의 정보를 찾기 위한 상세 조회
	 * @param mv
	 * @return
	 */
	public MemberVO retrieveMemberForFindUserInfo(MemberVO mv);
	
	/**
	 * 각 layer마다 다르기 때문에 비즈니스 로직 레이어의 내안에서 돌아가는 로직이 뭐냐에 따라 다르다 dao를 따라가지 않는다.
	 * 
	 * 신규회원 등록
	 * @param member
	 * @return ID 중복(PKDUPLICATED), 성공(OK), 실패(FAILED)
	 * @throws NoSuchAlgorithmException 
	 */
	public ServiceResult createMember(MemberVO member) throws NoSuchAlgorithmException;
	
	/**
	 * 정보 수정을 할 경우 인증이 필요하다. why? 다른 사람이 수정할 수 있게 하면 안되기 때문에
	 * 
	 * 회원 수정 
	 * @param member
	 * @return 존재하지 않는 경우(UserNotFoundException), 비번오류(INVALIDPASSWORD), 성공(OK), 실패(FAILD)
	 * @throws NoSuchAlgorithmException 
	 */
	public ServiceResult modifyMember(MemberVO member) throws NoSuchAlgorithmException;
	
	/**
	 * 
	 * 회원 삭제
	 * @param member
	 * @return 존재하지 않는 경우(UserNotFoundException, 비번오류(INVALIDPASSWORD), 성공(OK), 실패(FAILD)
	 */
	public ServiceResult removeMember(MemberVO member); 
	
	/**
	 * 회원의 등급을 수정
	 * @param member
	 * @return
	 */
	public ServiceResult modifyGrade(MemberVO member);
	
	/**
	 * 비밀번호를 잊은 회원의 비민번호 수정
	 * @param member
	 * @return
	 * @throws NoSuchAlgorithmException 
	 */
	public ServiceResult modifyPass(MemberVO member) throws NoSuchAlgorithmException;
	
	/**
	 * 회원의 세션을 등록
	 * @param member
	 * @return
	 */
	public ServiceResult addSession(MemberVO member);
	
	/**
	 * 세션의 유효기간이 남아 있으면서 해당 세션 아이디를 가진 회원 조회 
	 * @param member
	 * @return
	 */
	public MemberVO retrieveSessionMember(String session_id);
}
