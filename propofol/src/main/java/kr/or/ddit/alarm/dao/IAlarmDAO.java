package kr.or.ddit.alarm.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.NoticeVO;
import kr.or.ddit.vo.PagingVO;

@Repository
public interface IAlarmDAO {

	/**
	 * 전체 리스트 count
	 * @param pv
	 * @return
	 */
	public long allCount(String mem_id);
	
	/**
	 * 회원이 받은 알람 내역을 조회
	 * @param pv
	 * @return
	 */
	public List<NoticeVO> selectAlarmList(PagingVO<NoticeVO> pv);
	
	/**
	 * 읽음 여부
	 * @param mem_id
	 * @return NOTICE_READ = 'Y' 인 것들을 count
	 */
	public int countRead(String mem_id);
	
	/**
	 * 알림함 작성
	 * @param nv
	 * @return
	 */
	public int insertNotice(NoticeVO nv);
	
	/**
	 * 읽음 여부 수정
	 * @param notice_num
	 * @return
	 */
	public int updateNotice(int notice_num);
	
	/**
	 * 알림함 삭제
	 * @param notice_num
	 * @return
	 */
	public int deleteNotice(int notice_num);
}
