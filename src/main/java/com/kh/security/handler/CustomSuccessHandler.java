package com.kh.security.handler;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.SavedRequest;

import lombok.extern.slf4j.Slf4j;

/**
 * 
 * @see <a href="https://www.baeldung.com/spring_redirect_after_login">Redirect to Different Pages after Login with Spring Security</a>
 *
 */
@Slf4j
public class CustomSuccessHandler implements AuthenticationSuccessHandler {
 
    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
      throws IOException {
 
    	/**
         * (우선순위3) 인덱스페이지 
         */
    	String targetUrl = "/";
        

    	HttpSession session = request.getSession();
        Enumeration<?> names = session.getAttributeNames();
        while(names.hasMoreElements()) {
        	String name = (String) names.nextElement();
        	log.debug("{} = {}", name, session.getAttribute(name));
        }
        
        /**
         * (우선순위2) 로그인폼페이지 요청전 페이지 
         */
        String next = (String) session.getAttribute("next");
        if(next != null && !next.isEmpty()) {
        	targetUrl = next;
        	session.removeAttribute("next");
        }

        /**
         * (우선순위1) 인증하지않고 접근하려던 페이지 
         */
        SavedRequest savedRequest = (SavedRequest) session.getAttribute("SPRING_SECURITY_SAVED_REQUEST");
        if(savedRequest != null) {
        	targetUrl = savedRequest.getRedirectUrl();
        }
        
        log.debug("targetUrl = {}", targetUrl);
        
        redirectStrategy.sendRedirect(request, response, targetUrl);
    }
    
}
