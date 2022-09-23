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
	<h5>공지 날짜</h5>
	<h5 id="date-container">${subscriptionWeekVegs.weekCriterion}</h5>
</div>

<form:form 
	name="noticeVegsUpdateFrm"
	action="${pageContext.request.contextPath}/admin/noticeWeekVegsUpdate.do"
	method="post">
<div id="admin-notice-week-vegs-container">
	<div class="s-form-part-container">
        <span>공지할 채소 5가지를 선택해주세요</span>
		<br />
        <button class="btn btn-danger mt-3 mb-3" type="button" id="weekCriterionCheckReset">다시 선택하기</button>
        <div class="notice-vegs-cnt-info">
	        <span class="notice-vegs-cnt">5</span>
	        <span>/&nbsp5개</span>
        </div>
        <br />
        
     </div>
<input type="hidden" name="weekCriterion" id="weekCriterion" value="${subscriptionWeekVegs.weekCriterion}" readonly/>
<c:if test="${not empty vegetables}">
			<div class="s-vegs-category-wrapper">
	            <h5 class="s-vegs-category-title">과일류</h5>
	            <div class="s-vegs-category d-flex justify-content-start flex-wrap">
					<c:forEach items="${vegetables}" var="veg" varStatus="vs">
						<c:if test="${veg.vegCategory eq '과일류'}">
			         		<div class="form-check form-check-inline">
			                    <input class="form-check-input" name="vegComposition" type="checkbox" id="veg${vs.count}" value="${veg.vegName}" ${subscriptionWeekVegs.vegComposition.contains(veg.vegName) ? 'checked' : ''}>
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
			                    <input class="form-check-input" name="vegComposition" type="checkbox" id="veg${vs.count}" value="${veg.vegName}" ${subscriptionWeekVegs.vegComposition.contains(veg.vegName) ? 'checked' : ''}>
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
			                    <input class="form-check-input" name="vegComposition" type="checkbox" id="veg${vs.count}" value="${veg.vegName}" ${subscriptionWeekVegs.vegComposition.contains(veg.vegName) ? 'checked' : ''} >
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
			                    <input class="form-check-input" name="vegComposition" type="checkbox" id="veg${vs.count}" value="${veg.vegName}" ${subscriptionWeekVegs.vegComposition.contains(veg.vegName) ? 'checked' : ''}>
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
			                    <input class="form-check-input" name="vegComposition" type="checkbox" id="veg${vs.count}" value="${veg.vegName}" ${subscriptionWeekVegs.vegComposition.contains(veg.vegName) ? 'checked' : ''}>
			                    <label class="form-check-label" for="veg${vs.count}">${veg.vegName}</label>
			                </div>
						</c:if>
					</c:forEach>
				</div>
			</div>
		</c:if>
		<br /><br />
		<button type="submit" class="btn btn-EA5C2B" id="notice-week-vegs-btn" onclick="return confirm('정기구독박스 채소목록을 수정하시겠습니까?')">수정하기</button>
	</div>
</form:form>

  
<script>

const vegs = document.querySelectorAll(".s-vegs-category [name=vegComposition]")
const noticeVegCntInfo = document.querySelector(".notice-vegs-cnt-info");
const checkReset = document.querySelector("#weekCriterionCheckReset");
const noticeVegNum = document.querySelector(".notice-vegs-cnt");
let noticeVegsCnt = 0;

window.onload = vegs.forEach((veg)=>{
    	
        if(veg.checked === true){
      
        	noticeVegsCnt++;
        	noticeVegCntInfo.style.color = "black";
          $(".notice-vegs-cnt").text(noticeVegsCnt);
        }
        
});


checkReset.addEventListener('click', (e) => {
	noticeVegsCnt = 0;
	vegs.forEach((veg)=>{
        veg.checked = false; // 선택한 제외채소 체크 제거
    });
	
	$(".notice-vegs-cnt").text(noticeVegsCnt);
			
              
});

vegs.forEach((veg)=>{
    veg.addEventListener('change', (e) => {
    	
        if(e.target.checked === true){
      
            if(noticeVegsCnt < 5){
            	noticeVegsCnt++;
            	noticeVegCntInfo.style.color = "black";
            	 $(".notice-vegs-cnt").text(noticeVegsCnt);
            }
            else{
            	noticeVegCntInfo.style.color = "red";
                alert('최대 5개까지만 선택 가능합니다.');
                e.target.checked = false;
            }
        }
        else{
        	noticeVegsCnt--;
        	noticeVegCntInfo.style.color = "black";
        	 $(".notice-vegs-cnt").text(noticeVegsCnt);
        }
        
    });
});


noticeVegsUpdateFrm.addEventListener('submit', (e)=>{
	if(noticeVegsCnt < 5){
		e.preventDefault();
		alert('공지 할 채소 5개를 선택해주세요');
	}

});
  
  
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>