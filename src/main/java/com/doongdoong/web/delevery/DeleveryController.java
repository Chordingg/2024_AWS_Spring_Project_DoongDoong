package com.doongdoong.web.delevery;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class DeleveryController {

	@GetMapping("/delevery")
	public String Delevery() {
		return "delevery/deleveryGuide";
	}

}
