package kr.or.ddit.vo.prepare;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PrepareMenuVO {
	public PrepareMenuVO(String menu, String menuURL) {
		super();
		this.menu = menu;
		this.menuURL = menuURL;
	}
	
	public PrepareMenuVO(int num, String name) {
		super();
		this.num = num;
		this.name = name;
	}
		
	private String menu;
	private String menuURL;
	private int num;
	private String name;
}
