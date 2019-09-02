package kr.or.ddit.alarm.service;

import java.util.List;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.vo.NoticeVO;
import kr.or.ddit.vo.PagingVO;

public interface IAlarmService {
	
	/**
	 * 알림 조회
	 * @param pv
	 * @return
	 */
	public List<NoticeVO> retreieveAlarm(String mem_id);
	
	/**
	 * 알림 발송
	 * @param nv
	 * @return
	 */
	public ServiceResult createAlarm(NoticeVO nv);
	
	/**
	 * 읽음 여부
	 * @param notice_num
	 * @return
	 */
	public ServiceResult modyfyNoticeRead(int notice_num);
	
	/**
	 * 알림 삭제
	 * @param notice_num
	 * @return
	 */
	public ServiceResult removeAlarm(int notice_num);
	
}
