package kr.or.ddit.member.batchJob;

import java.util.LinkedHashMap;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.member.dao.IMemberDAO;

@Component
public class ScheduledMemberDeleteJob {
	private Logger logger = LoggerFactory.getLogger(ScheduledMemberDeleteJob.class);

	@Inject
	IMemberDAO memberDao;

	@Transactional
//	@Scheduled(fixedRate=5000)
	@Scheduled(cron="0 23 14 30 * *") // 매월 30일 오후 2시 정각에 탈퇴 처리하도록
	public void deleteMemberProcess() {
		Map<String, Object> paramMap = new LinkedHashMap<String, Object>();
		memberDao.deleteMemberReal(paramMap);
		logger.info("{}명이 탈퇴 성공", paramMap.get("rowcount"));
	}
}
