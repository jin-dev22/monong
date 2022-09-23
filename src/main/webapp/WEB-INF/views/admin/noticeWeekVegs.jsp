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
	<h5 id="date-container"></h5>
</div>

<form:form 
	name="noticeVegsFrm"
	action="${pageContext.request.contextPath}/admin/noticeWeekVegs.do"
	method="post">
<div id="admin-notice-week-vegs-container">
	<div class="s-form-part-container">
        <h2 class="s-form-part-title">제외 채소 선택</h2>
        <span>공지할 채소 5가지를 선택해주세요</span>
        <div class="notice-vegs-cnt-info">
	        <span class="notice-vegs-cnt"></span>
	        <span>/&nbsp5개</span>
        </div>
     </div>
<input type="hidden" name="weekCriterion" id="weekCriterion" value=""/>
<c:if test="${not empty vegetables}">
			<div class="s-vegs-category-wrapper">
	            <h5 class="s-vegs-category-title">과일류</h5>
	            <div class="s-vegs-category d-flex justify-content-start flex-wrap">
					<c:forEach items="${vegetables}" var="veg" varStatus="vs">
						<c:if test="${veg.vegCategory eq '과일류'}">
			         		<div class="form-check form-check-inline">
			                    <input class="form-check-input" name="vegComposition" type="checkbox" id="veg${vs.count}" value="${veg.vegName}" >
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
			                    <input class="form-check-input" name="vegComposition" type="checkbox" id="veg${vs.count}" value="${veg.vegName}" >
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
			                    <input class="form-check-input" name="vegComposition" type="checkbox" id="veg${vs.count}" value="${veg.vegName}" >
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
			                    <input class="form-check-input" name="vegComposition" type="checkbox" id="veg${vs.count}" value="${veg.vegName}">
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
			                    <input class="form-check-input" name="vegComposition" type="checkbox" id="veg${vs.count}" value="${veg.vegName}" >
			                    <label class="form-check-label" for="veg${vs.count}">${veg.vegName}</label>
			                </div>
						</c:if>
					</c:forEach>
				</div>
			</div>
		</c:if>
		<br /><br />
		<button type="submit" class="btn btn-EA5C2B" id="notice-week-vegs-btn" onclick="return confirm('이번주 정기구독박스 채소목록을 업데이트하시겠습니까?')">공지하기</button>
	</div>
</form:form>

  
<script>
const todaydate = new Date();
todaydate.setDate(todaydate.getDate() + todaydate.getDay());
console.log(todaydate);

let newYear = todaydate.toISOString().substr(2,2);
let newMonth = todaydate.toISOString().substr(5,2);
let newDate = todaydate.toISOString().substr(8,2);

const noticeDay = newYear+newMonth+newDate;

window.onload = function(){
	 
	  
	  const container = document.querySelector("#date-container");
	  container.innerHTML = noticeDay; 
	  const criterion = document.querySelector("#weekCriterion");
	  criterion.value = noticeDay;
}

const vegs = document.querySelectorAll(".s-vegs-category [name=vegComposition]")
const noticeVegCntInfo = document.querySelector(".notice-vegs-cnt-info");
const noticeVegNum = document.querySelector(".notice-vegs-cnt");
let noticeVegsCnt = 0;

vegs.forEach((veg)=>{
    veg.addEventListener('change', (e) => {
        if(e.target.checked === true){
      
            if(noticeVegsCnt < 5){
            	noticeVegsCnt++;
            	noticeVegCntInfo.style.color = "black";
                noticeVegNum.innerHTML = noticeVegsCnt;
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
            noticeVegNum.innerHTML = noticeVegsCnt;
        }
        
    });
});


noticeVegsFrm.addEventListener('submit', (e)=>{
	if(noticeVegsCnt < 5){
		e.preventDefault();
		alert('공지 할 채소 5개를 선택해주세요');
	}

});
  
  
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>