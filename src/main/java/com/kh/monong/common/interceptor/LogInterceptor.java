package com.kh.monong.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class LogInterceptor extends HandlerInterceptorAdapter {
	
	/**
	 * handler메소드 호출전
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		log.debug("========================================================");
		log.debug("{} {}", request.getMethod(), request.getRequestURI());
		log.debug("--------------------------------------------------------");
		
		return super.preHandle(request, response, handler); // 늘 true를 반환
	}
	
	/**
	 * handler메소드 리턴직후
	 */
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);
		
		log.debug("++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
		log.debug("mav = {}", modelAndView);
		
	}
	
	/**
	 * jsp 처리 완료후
	 */
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		super.afterCompletion(request, response, handler, ex);
		log.debug("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
		log.debug("{}\n", response.getStatus());
	}
}
