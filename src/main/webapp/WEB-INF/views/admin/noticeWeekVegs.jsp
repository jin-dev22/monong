<%@page import="com.kh.monong.member.model.dto.Member"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/admin/adminMyPage.jsp">
	<jsp:param name="title" value="모농모농-관리자페이지"></jsp:param>
</jsp:include>
<div id="admin-notice-week-vegs-info-container"class="mx-auto mt-5 mb-5 text-center">
	
	<img src="${pageContext.request.contextPath}/resources/images/logo.PNG" alt="로고"/>
	<br /><br /><br />
	<h3>모농모농 주간채소 공지</h3>
	<br />
	<h5 id="date-container"></h5>
</div>
<div id="admin-notice-week-vegs-container">
<c:if test="${not empty vegetables}">
			<div class="s-vegs-category-wrapper">
	            <h5 class="s-vegs-category-title">과일류</h5>
	            <div class="s-vegs-category d-flex justify-content-start flex-wrap">
					<c:forEach items="${vegetables}" var="veg" varStatus="vs">
						<c:if test="${veg.vegCategory eq '과일류'}">
			         		<div class="form-check form-check-inline">
			                    <input class="form-check-input" name="sExcludeVegs" type="checkbox" id="veg${vs.count}" value="${veg.vegName}" >
			                    <label class="form-check-label" for="veg${vs.count}">${veg.vegName}</label>
			                </div>
						</c:if>
					</c:forEach>
				</div>
			</div>
			
			<div class="s-vegs-category-wrapper">
	            <h5 class="s-vegs-category-title">과채류</h5>
	            <div class="s-vegs-category d-flex justify-content-start flex-wrap">
					<c:forEach items="${vegetables}" var="veg" varStatus="vs">
						<c:if test="${veg.vegCategory eq '과채류'}">
			         		<div class="form-check form-check-inline">
			                    <input class="form-check-input" name="sExcludeVegs" type="checkbox" id="veg${vs.count}" value="${veg.vegName}" >
			                    <label class="form-check-label" for="veg${vs.count}">${veg.vegName}</label>
			                </div>
						</c:if>
					</c:forEach>
				</div>
			</div>
			
			<div class="s-vegs-category-wrapper">
	            <h5 class="s-vegs-category-title">채소류</h5>
	            <div class="s-vegs-category d-flex justify-content-start flex-wrap">
					<c:forEach items="${vegetables}" var="veg" varStatus="vs">
						<c:if test="${veg.vegCategory eq '채소류'}">
			         		<div class="form-check form-check-inline">
			                    <input class="form-check-input" name="sExcludeVegs" type="checkbox" id="veg${vs.count}" value="${veg.vegName}" >
			                    <label class="form-check-label" for="veg${vs.count}">${veg.vegName}</label>
			                </div>
						</c:if>
					</c:forEach>
				</div>
			</div>
			
			<div class="s-vegs-category-wrapper">
            	<h5 class="s-vegs-category-title">엽/양채류</h5>
            	<div class="s-vegs-category d-flex justify-content-start flex-wrap">
					<c:forEach items="${vegetables}" var="veg" varStatus="vs">
						<c:if test="${veg.vegCategory eq '엽/양채류'}">
			         		<div class="form-check form-check-inline">
			                    <input class="form-check-input" name="sExcludeVegs" type="checkbox" id="veg${vs.count}" value="${veg.vegName}">
			                    <label class="form-check-label" for="veg${vs.count}">${veg.vegName}</label>
			                </div>
						</c:if>
					</c:forEach>
				</div>
			</div>
			
			<div class="s-vegs-category-wrapper">
	            <h5 class="s-vegs-category-title">근채류</h5>
           		<div class="s-vegs-category d-flex justify-content-start flex-wrap">
					<c:forEach items="${vegetables}" var="veg" varStatus="vs">
						<c:if test="${veg.vegCategory eq '근채류'}">
			         		<div class="form-check form-check-inline">
			                    <input class="form-check-input" name="sExcludeVegs" type="checkbox" id="veg${vs.count}" value="${veg.vegName}" >
			                    <label class="form-check-label" for="veg${vs.count}">${veg.vegName}</label>
			                </div>
						</c:if>
					</c:forEach>
				</div>
			</div>
			
		</c:if>
  </div>
  
  <script>
  
  window.onload = function(){
	  const date = new Date();
	  date.setDate(date.getDate() + date.getDay());
	  console.log(date);
	  let dateFormat = date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate()+"&nbsp&nbsp"+"월요일";
	  const container = document.querySelector("#date-container");
	  container.innerHTML = dateFormat; 
  }
  
  </script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>