package com.dolbommon.dbmon.register;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class RegisterController {

	
	// 로그인 폼으로
	@RequestMapping("/regForm")
	public String regForm() {
		
		return "register/regForm";
	}
	
	// 우편코드 선택창
	@RequestMapping("/zipcodeSearch")
	public String zipcodeSearch() {
		
		return "register/zipcodeSearch";
	}
}
