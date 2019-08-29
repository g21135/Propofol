package kr.or.ddit.attach;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.servlet.view.AbstractView;

import kr.or.ddit.vo.AttachVO;

public class DownloadView extends AbstractView {

	@Value("#{appInfo['attachPath']}")
	private File saveFolder;
	
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse resp) throws Exception {
		AttachVO attach = (AttachVO) model.get("attach");
		
		String originalFilename = attach.getAtt_name();
		File inputFile = new File(saveFolder, attach.getAtt_savename());
		
		resp.setContentType("application/octet-stream");
		originalFilename = new String(originalFilename.getBytes(), "ISO-8859-1");
		resp.setHeader("Content-Disposition", "attachment;filename=\""+originalFilename+"\"");
		resp.setHeader("Content-Length", attach.getAtt_size()+"");
		try(
			FileInputStream is = new FileInputStream(inputFile);
			OutputStream os = resp.getOutputStream();	
		){
			FileUtils.copyFile(inputFile, os);
			}

	}
}
