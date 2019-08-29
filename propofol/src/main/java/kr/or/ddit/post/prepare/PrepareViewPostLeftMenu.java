package kr.or.ddit.post.prepare;

import java.util.Arrays;
import java.util.List;

import javax.inject.Inject;

import org.apache.tiles.AttributeContext;
import org.apache.tiles.preparer.ViewPreparer;
import org.apache.tiles.request.Request;

import kr.or.ddit.common.annotation.Preparer;
import kr.or.ddit.post.dao.IPostDAO;
import kr.or.ddit.vo.TypeVO;
import kr.or.ddit.vo.prepare.PrepareMenuVO;

@Preparer
public class PrepareViewPostLeftMenu implements ViewPreparer {
//	@Inject 
//	IPostDAO dao;
//	List<TypeVO> list = dao.typeList();

	@Override
	public void execute(Request arg0, AttributeContext arg1) {
		PrepareMenuVO jobnews = new PrepareMenuVO("취업뉴스", "/jobnews");
		PrepareMenuVO recruit = new PrepareMenuVO("채용공고", "/recruit");
		PrepareMenuVO freeBoards = new PrepareMenuVO("자유게시판", "/freeBoards");

		arg0.getContext(Request.REQUEST_SCOPE).put("communityList", Arrays.asList(jobnews, recruit, freeBoards));
		
//		PrepareMenuVO[] prepare = null;
//		for(int i = 0; i <= list.size(); i++) {
//			prepare[i] = new PrepareMenuVO(list.get(i).getTpye_num(), list.get(i).getType_name());
//			arg0.getContext(Request.REQUEST_SCOPE).put("postTypeList", Arrays.asList(prepare[i]));
//		}

		PrepareMenuVO notice = new PrepareMenuVO("공지", "1");
		PrepareMenuVO error = new PrepareMenuVO("오류", "2");
		PrepareMenuVO improvement = new PrepareMenuVO("개선", "3");

		arg0.getContext(Request.REQUEST_SCOPE).put("postTypeList", Arrays.asList(notice, error, improvement));
		
		PrepareMenuVO unsound = new PrepareMenuVO("불건전 게시글", "1");
		PrepareMenuVO swearing = new PrepareMenuVO("욕설", "2");
		PrepareMenuVO belittle = new PrepareMenuVO("비하 발언", "3");
		
		arg0.getContext(Request.REQUEST_SCOPE).put("reportTypeList", Arrays.asList(unsound, swearing, belittle));
	}
}
