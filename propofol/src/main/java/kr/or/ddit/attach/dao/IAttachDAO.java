package kr.or.ddit.attach.dao;

import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.AttachVO;

@Repository
public interface IAttachDAO {
	/**
	 * Spring 프레임워크에서 사용
	 * @param attach
	 * @return
	 */
	public int insertAttach(AttachVO attach);
	
	/**
	 * 첨부파일 조회
	 * @param att_no
	 * @return
	 */
	public AttachVO selectAttach(int attach_num);
	
	/**
	 * 첨부파일 삭제
	 * @param att_no
	 * @return
	 */
	public int deleteAttach(int attach_num);
	
	/**
	 * 다움로드 수 증가
	 * @param bo_no
	 * @return
	 */
	public int incrementDownload(int attach_num);
}
