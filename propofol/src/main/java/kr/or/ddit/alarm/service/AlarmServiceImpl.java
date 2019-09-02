package kr.or.ddit.alarm.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.alarm.dao.IAlarmDAO;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.exception.UserNotFoundException;
import kr.or.ddit.vo.NoticeVO;
import kr.or.ddit.vo.PagingVO;

@Service
public class AlarmServiceImpl implements IAlarmService {
	
	@Inject
	IAlarmDAO dao;
	
	@Override
	public List<NoticeVO> retreieveAlarm(String mem_id) {
		List<NoticeVO> alarmList = dao.selectAlarmList(mem_id);
		if(alarmList != null) {
			return alarmList;
		}else {
			throw new UserNotFoundException("알림이 없습니다.");
		}
	}

	@Override
	public ServiceResult createAlarm(NoticeVO nv) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt = dao.insertNotice(nv);
		if(cnt > 0) {
			result = ServiceResult.OK;
		}
		return result;
	}

	@Override
	public ServiceResult modyfyNoticeRead(int notice_num) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt = dao.updateNotice(notice_num);
		if(cnt > 0) {
			result = ServiceResult.OK;
		}
		return result;
	}

	@Override
	public ServiceResult removeAlarm(int notice_num) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt = dao.deleteNotice(notice_num);
		if(cnt > 0) {
			result = ServiceResult.OK;
		}
		return result;
	}

}
