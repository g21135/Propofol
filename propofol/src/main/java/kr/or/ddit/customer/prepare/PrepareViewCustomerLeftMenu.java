package kr.or.ddit.customer.prepare;

import java.util.Arrays;

import org.apache.tiles.AttributeContext;
import org.apache.tiles.preparer.ViewPreparer;
import org.apache.tiles.request.Request;

import kr.or.ddit.common.annotation.Preparer;
import kr.or.ddit.vo.prepare.PrepareMenuVO;

@Preparer
public class PrepareViewCustomerLeftMenu implements ViewPreparer {

	@Override
	public void execute(Request arg0, AttributeContext arg1) {
		PrepareMenuVO faq = new PrepareMenuVO("FAQ", "/faq");
		PrepareMenuVO qna = new PrepareMenuVO("Q&A", "/qna");
		PrepareMenuVO suggest = new PrepareMenuVO("건의게시판", "/suggest");

		arg0.getContext(Request.REQUEST_SCOPE).put("customerList", Arrays.asList(faq, qna, suggest));
	}
}
