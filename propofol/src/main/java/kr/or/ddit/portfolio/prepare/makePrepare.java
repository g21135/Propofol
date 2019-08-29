package kr.or.ddit.portfolio.prepare;

import java.util.Arrays;

import org.apache.tiles.AttributeContext;
import org.apache.tiles.preparer.ViewPreparer;
import org.apache.tiles.request.Request;

import kr.or.ddit.common.annotation.Preparer;
import kr.or.ddit.vo.prepare.PrepareMenuVO;

@Preparer
public class makePrepare implements ViewPreparer{
	
	@Override
	public void execute(Request tilesContext, AttributeContext attributeContext) {
		PrepareMenuVO memModify = new PrepareMenuVO("마이페이지", "/member/members");
		PrepareMenuVO memDelete = new PrepareMenuVO("회원탈퇴", "/member/members/leave");
		PrepareMenuVO memList = new PrepareMenuVO("회원관리", "/member/manager");
		PrepareMenuVO payment = new PrepareMenuVO("매출현황관리", "/member/manager/payment");

		tilesContext.getContext(Request.REQUEST_SCOPE).put("menuList", Arrays.asList(memModify, memDelete));
		tilesContext.getContext(Request.REQUEST_SCOPE).put("adminList", Arrays.asList(memList, payment));

	}

}