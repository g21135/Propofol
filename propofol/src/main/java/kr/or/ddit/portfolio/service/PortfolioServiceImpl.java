package kr.or.ddit.portfolio.service;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.order.dao.IOrderDAO;
import kr.or.ddit.portfolio.dao.IPortfolioDAO;
import kr.or.ddit.portfolio.dao.ITempDAO;
import kr.or.ddit.vo.OrderTbVO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.PortfolioVO;
import kr.or.ddit.vo.TempVO;

@Service
public class PortfolioServiceImpl implements IPortfolioService {
	@Inject
	IPortfolioDAO dao;
	
	@Inject
	IOrderDAO orderDao;
	
	@Inject
	ITempDAO tempDao;
	
	@Value("#{appInfo.portImages}")
	String saveFolderURL;
	
	@Inject
	WebApplicationContext container;
	
	File saveFolder =null;
	
	@PostConstruct //생성한 이후에 실행해라. init-method
	public void init() {
		//이미지 저장 위치 : 웹 리소스의 형태
		String fileSystemPath = container.getServletContext().getRealPath(saveFolderURL);
		saveFolder = new File(fileSystemPath);
		if(!saveFolder.exists()) saveFolder.mkdirs();
	}
	
	private void processFiles(PortfolioVO pv) {
		if (pv.getPort_image() == null) {
			return;
//			FileUtils.deleteQuietly(new File(saveFolder, pv.getPort_img()));
			
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
	public List<PortfolioVO> retrieveMyPortList(PagingVO<PortfolioVO> pagingVO) {
		return dao.selectMyPortfolioList(pagingVO);
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
	@Transactional
	@Override
	public ServiceResult createPort(PortfolioVO port) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt=0;
		processFiles(port);
		cnt = dao.insertPort(port);

		if(cnt>0) {
			result = ServiceResult.OK;
		}
		return result;
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

	@Transactional
	@Override
	public ServiceResult deletePort(int port_num) {
		ServiceResult result = ServiceResult.FAILED;
		PortfolioVO pv = new PortfolioVO();
		pv.setPort_num(port_num);
		dao.deletePortfolio(pv);
		if(pv.getRowcount() == 4) {
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
		
		if(port.getPort_num() == null) {
			processFiles(port);
			cnt = dao.insertPort(port);
			cnt2 = tempDao.insert(port);
		}else {
			processFiles(port);
			cnt = dao.updatePort(port);
			tempDao.delete(port);
			cnt2 = tempDao.insert(port);
		}
		if(cnt>0&&cnt2>0) {
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

	@Override
	public int checkMemberShip(String mem_id) {
		return dao.checkMemberShip(mem_id);
	}

	@Transactional
	@Override
	public ServiceResult updatePort(PortfolioVO port) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt = dao.updatePort(port);
		processFiles(port);
		if(cnt > 0) {
			result = ServiceResult.OK;
		}
		return result;
	}

	@Override
	public ServiceResult createPortAndOrder(PortfolioVO pv) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt=0;
		int cnt2=0;
		processFiles(pv);
		cnt = orderDao.insertOrder(pv.getOv());
		cnt2 = dao.insertPort(pv);
		if(cnt>0&&cnt2>0) { 
			result = ServiceResult.OK;
		}
		return result;
	}

}
