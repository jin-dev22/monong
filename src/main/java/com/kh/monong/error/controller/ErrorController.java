package com.kh.monong.error.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ErrorController {

	@GetMapping("/error/accessDenied.do")
	public void accessDenied() {
		
	}
}
