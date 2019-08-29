package kr.or.ddit.community.prepare;

import java.util.Arrays;

import org.apache.tiles.AttributeContext;
import org.apache.tiles.preparer.ViewPreparer;
import org.apache.tiles.request.Request;

import kr.or.ddit.common.annotation.Preparer;
import kr.or.ddit.vo.prepare.PrepareMenuVO;

@Preparer
public class PrepareViewCommunityLeftMenu implements ViewPreparer {

	@Override
	public void execute(Request arg0, AttributeContext arg1) {
		PrepareMenuVO homeintroduction = new PrepareMenuVO("홈페이지 소개", "/homeintroduction");
		PrepareMenuVO directions = new PrepareMenuVO("오시는 길", "/directions");
		PrepareMenuVO instructions = new PrepareMenuVO("사용법", "/instructions");
		PrepareMenuVO operationPolicy = new PrepareMenuVO("이용 약관", "/operationPolicy");

		arg0.getContext(Request.REQUEST_SCOPE).put("introList", Arrays.asList(homeintroduction, directions,instructions, operationPolicy));
	}
}
