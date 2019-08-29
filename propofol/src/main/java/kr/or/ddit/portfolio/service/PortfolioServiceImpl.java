package kr.or.ddit.portfolio.service;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.inject.Inject;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.portfolio.dao.IPortfolioDAO;
import kr.or.ddit.portfolio.dao.ITempDAO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.PortfolioVO;
import kr.or.ddit.vo.TempVO;

@Service
public class PortfolioServiceImpl implements IPortfolioService {
	@Inject
	IPortfolioDAO dao;

	@Inject
	ITempDAO tempDao;
	
	@Value("#{appInfo.portImages}")
	String saveFolder;
	
	@Inject
	WebApplicationContext container;
	
	private void processFiles(PortfolioVO pv) {
		String fileSystemPath = container.getServletContext().getRealPath(saveFolder);
		if (pv.getPort_image() == null) {
			
			FileUtils.deleteQuietly(new File(fileSystemPath, pv.getPort_img()));
		}else if(pv.getPort_image().getOriginalFilename() != null) {
			File saveFile = new File(saveFolder, pv.getPort_img());
			try (InputStream in = pv.getPort_image().getInputStream();) {
				FileUtils.copyInputStreamToFile(in, saveFile);
			} catch (IOException e) {
				throw new RuntimeException(e);
			}
		}
	}
	@Override
	public int retrievePortCount(PagingVO<PortfolioVO> pagingVO) {
		return dao.selectPortfolioListCount(pagingVO);
	}

	@Override
	public List<PortfolioVO> retrievePortList(PagingVO<PortfolioVO> pagingVO) {
		return dao.selectPortfolioList(pagingVO);
	}
	
	@Override
	public int retrieveSucPortCount(PagingVO<PortfolioVO> pagingVO) {
		return dao.selectSuccessPortfolioListCount(pagingVO);
	}
	
	@Override
	public List<PortfolioVO> retrieveSucPortList(PagingVO<PortfolioVO> pagingVO) {
		return dao.selectSuccessPortfolioList(pagingVO);
	}

	@Override
	public PortfolioVO retrievePort(int port_num) {
		PortfolioVO port = dao.selectPortfolio(port_num);
		return port;
	}

	@Override
	public ServiceResult createPort(PortfolioVO port) {
		return null;
	}

	@Override
	public ServiceResult modifyPort(PortfolioVO port) {
		return null;
	}


	@Override
	public ServiceResult banPort(int port_num) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt = dao.blackPortfolio(port_num);
		if(cnt > 0) {
			result = ServiceResult.OK;
		}
		return result;
	}

	@Override
	public ServiceResult readPort(int port_num) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt = dao.readPortfolio(port_num);
		if(cnt > 0) {
			result = ServiceResult.OK;
		}
		return result;
	}

	@Override
	public ServiceResult unbanPort(int port_num) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt = dao.unblackPortfolio(port_num);
		if(cnt > 0) {
			result = ServiceResult.OK;
		}
		return result;
	}

	@Override
	public ServiceResult deletePort(int port_num) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt = dao.deletePortfolio(port_num);
		if(cnt > 0) {
			result = ServiceResult.OK;
		}
		return result;
	}
	@Transactional
	@Override
	public ServiceResult updateTempPort(PortfolioVO port) {
		ServiceResult result = ServiceResult.FAILED;
		
		int cnt=0;
		int cnt2=0;
		
		TempVO[] list = port.getTempArray();
		int length =list.length;
		
		if(port.getPort_num() == null) {
			processFiles(port);
			cnt = dao.insertPort(port);
			cnt2 = tempDao.insert(port);
		}else {
			processFiles(port);
			cnt = dao.updatePort(port);
			
			TempVO temp = new TempVO();
			temp.setPort_num(port.getPort_num());

			int[] TempList =  tempDao.select(port.getPort_num());
			for (int i = 0; i < TempList.length; i++) {
				temp.setTemp_menu(list[i].getTemp_menu());
				temp.setTemp_page(list[i].getTemp_page());
				temp.setPage_img(list[i].getPage_img());
				temp.setTemp_num(TempList[i]);
				cnt2 += tempDao.update(temp);
			}
		}
		if(cnt>0&&cnt2==length) {
			result = ServiceResult.OK;
		}
		return result;
	}

	@Override
	public int checkPort(String mem_id) {
		return dao.checkPort(mem_id);
	}

	@Override
	public ServiceResult portPublicSetting(PortfolioVO portVO) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt = dao.publicSettingPortfolio(portVO);
		if(cnt > 0) {
			result = ServiceResult.OK;
		}
		return result;
	}
}
