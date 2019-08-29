package kr.or.ddit.community.prepare;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.tiles.AttributeContext;
import org.apache.tiles.preparer.ViewPreparer;
import org.apache.tiles.request.Request;
import org.springframework.web.bind.annotation.ModelAttribute;

import kr.or.ddit.common.annotation.Preparer;
import kr.or.ddit.community.dao.ICommunitysDAO;
import kr.or.ddit.vo.AcademicVO;
import kr.or.ddit.vo.DayVO;
import kr.or.ddit.vo.FirstAreaVO;
import kr.or.ddit.vo.IndustryVO;
import kr.or.ddit.vo.OccupationVO;
import kr.or.ddit.vo.SecondAreaVO;
import kr.or.ddit.vo.ServiceTypeVO;

//advice
@Preparer
public class PrepareCommunity implements ViewPreparer{

	@Inject
	ICommunitysDAO communityDAO;
	
	@Override
	public void execute(Request tilesContext, AttributeContext attributeContext) {
		
		List<OccupationVO> occupationList = communityDAO.selectOccupationList();
		List<IndustryVO> industryList = communityDAO.selectIndustryList();
		List<FirstAreaVO> firstAreaList = communityDAO.selectFirstAreaList();
		List<SecondAreaVO> secondAreaList = communityDAO.selectSecondAreaList();
		List<AcademicVO> academicList = communityDAO.selectAcademicList();
		List<ServiceTypeVO> servicetypeList = communityDAO.selectServiceTypeList();
		List<DayVO> dayList = communityDAO.selectdayList();
		
		Map<String, Object> requestScope = tilesContext.getContext(Request.REQUEST_SCOPE);
		requestScope.put("occupationList", occupationList);
		requestScope.put("industryList", industryList);
		requestScope.put("firstAreaList", firstAreaList);
		requestScope.put("secondAreaList", secondAreaList);
		requestScope.put("academicList", academicList);
		requestScope.put("servicetypeList", servicetypeList);
		requestScope.put("dayList", dayList);
		
	}
}
