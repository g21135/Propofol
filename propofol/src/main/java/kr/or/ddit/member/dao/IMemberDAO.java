package kr.or.ddit.member.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.FavoriteListVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.PagingVO;

/**
 * 회원관리를 위한 Persistence Layer 추상화
 * 	
 * @author 권준수
 *
 */
@Repository
public interface IMemberDAO {

	/**
	 * 신규 등록 
	 * @param mv 등록할 회원의 정보
	 * @return (rowCount > 0 : 성공) 
	 */
	public int insertMember(MemberVO member);
	
	/**
	 * 회원수 조회
	 * @param pagingVO
	 * @return
	 */
	public long selectMemberCount(PagingVO<MemberVO> pagingVO);
	
	/**
	 * 전체 회원 목록 조회
	 * @param pagingVO 
	 * @return 
	 */
	public List<MemberVO> selectMemberList(PagingVO<MemberVO> pagingVO);
	
	/** 
	 * 회원 정보 상세 조회
	 * @param mem_id : 조회할 회원 아이디
	 * @return 존재하지 않는다면 null 반환
	 */
	public MemberVO selectMember(String mem_id);
	
	/**
	 * 아이디 찾기 위한 회원정보 조회
	 * @param mv
	 * @return
	 */
	public MemberVO findMember(MemberVO mv);
	
	/**
	 * 회원 정보 수정
	 * @param mv : 수정할 아이디(필수)와 기타 값들...
	 * @return (rowCount > 0 : 성공) 
	 */
	public int updateMember(MemberVO mv);
	
	/** 
	 * 회원 정보 삭제
	 * @param mem_id 삭제할 아이디
	 * @return (rowCount > 0 : 성공) 
	 */
	public int deleteMember(String mem_id);
	
	/**
	 * 실제로 삭제 할 때 
	 * 
	 * @param paramMap
	 * @return
	 */
	public int deleteMemberReal(Map<String, Object> paramMap);
	
	/**
	 * 관심사 테이블 컬럼들 가져오는 리스트
	 * @return
	 */
	public List<FavoriteListVO> favoriteList();
	
	/**
	 * 회원의 등급 수정
	 * @param mv
	 * @return
	 */
	public int updateGrade(MemberVO mv);
	
	/**
	 * 비밀번호를 잊어 버린 회원의 비밀번호 수정
	 * @param mv
	 * @return
	 */
	public int updatePass(MemberVO mv);
	
	/**
	 * 회원의 세션아이디와 유지기간을 저장
	 * @param mv
	 * @return
	 */
	public int updateSession(MemberVO mv);
	
	/**
	 * 유효시간이 넘지 않은 세션을 가지고 있는지 체크
	 * @param sessoin_id
	 * @return
	 */
	public MemberVO chkSession(String sessoin_id);
	
}
