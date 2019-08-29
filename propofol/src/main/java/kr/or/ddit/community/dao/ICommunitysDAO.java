package kr.or.ddit.community.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.AcademicVO;
import kr.or.ddit.vo.DayVO;
import kr.or.ddit.vo.FirstAreaVO;
import kr.or.ddit.vo.IndustryVO;
import kr.or.ddit.vo.OccupationVO;
import kr.or.ddit.vo.SecondAreaVO;
import kr.or.ddit.vo.ServiceTypeVO;

@Repository
public interface ICommunitysDAO {

	
	/**
	 * 직업 분류
	 * @return
	 */
	public List<IndustryVO> selectIndustryList();
	
	
	/**
	 * 산업 분류
	 * @return
	 */
	public List<OccupationVO> selectOccupationList();
	
	
	/**
	 * 지역 대분류
	 * @return
	 */
	public List<FirstAreaVO> selectFirstAreaList();
	
	
	/**
	 * 지역 소분류
	 * @return
	 */
	public List<SecondAreaVO> selectSecondAreaList();
	
	
	/**
	 * 학력
	 * @return
	 */
	public List<AcademicVO> selectAcademicList();
	
	
	/**
	 * 고용형태
	 * @return
	 */
	public List<ServiceTypeVO> selectServiceTypeList();
	
	
	/**
	 * 스케줄러 삽입
	 * @return
	 */
	public List<DayVO> selectdayList();
	
}
