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
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="모농모농-회원정보수정"></jsp:param>
</jsp:include>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/member.css" />
<div id="member-update-container" class="mx-auto mt-10">
	<div class="mb-3 text-center">
		<h1>회원정보수정</h1>
		<h1>판매자!!!</h1>
	</div>	
	<nav class="nav justify-content-end">
		<a class="nav-link" href="${pageContext.request.contextPath}/member/memberPwUpdate.do"><h5>비밀번호 변경</h5></a>
	</nav>
	<form:form name="memberUpdateFrm" 
			   action="${pageContext.request.contextPath}/member/memberUpdate.do" 
			   method="post"
			   id="memberUpdateFrm">

		<div class="row mb-2 col-md-13 justify-content-center">
			<div class="col-sm-9">
				<label for="memberId">아이디</label>
				<input type="text" class="form-control" placeholder="아이디 (4글자이상)" name="memberId" id="memberId" value='<sec:authentication property="principal.username"/>'readonly required/>
				<br />
			</div>
		</div>

		<div class="row mb-2 col-md-13 justify-content-center">
			<div class="col-sm-9">
				<label for="name">업체명</label>
				<input type="text" class="form-control" placeholder="업체명" name="memberName" id="name" value='<sec:authentication property="principal.memberName"/>'required/>
				<br />
			</div>
		</div>
		
		<div class="row mb-2 col-md-13 justify-content-center">
			<div class="col-sm-9">
				<label for="email">이메일</label>
				<input type="email" class="form-control" placeholder="이메일" name="memberEmail" id="email" value='<sec:authentication property="principal.memberEmail"/>'/>
				<br />
			</div>
		</div>
		
		<div class="row mb-2 col-md-13 justify-content-center">
			<div class="col-sm-9">
				<label for="phone">연락처</label>
				<input type="tel" class="form-control" placeholder="전화번호 (예:01012345678)" name="memberPhone" id="phone" maxlength="11" value='<sec:authentication property="principal.memberPhone"/>'required/>
				<br />
			</div>
		</div>
		
		<div class="row mb-2 col-md-13 justify-content-center">
			<div class="col-sm-9">
				<label for="address">주소</label>
				<input type="text" class="form-control" placeholder="주소" name="memberAddress" id="address" value='<sec:authentication property="principal.memberAddress"/>'/>
				<br />
			</div>
		</div>
		
		<div class="row mb-2 col-md-13 justify-content-center">
			<div class="col-sm-9">	
				<label for="birthday">사업개시일</label>
				<input type="date" class="form-control" placeholder="사업개시일" name="memberBirthday" id="birthday" value='<sec:authentication property="principal.memberBirthday"/>'/>
				<br />
			</div>
		</div>
		
		<br />
		<div class="mb-3 text-center">
			<input type="submit" class="btn btn-EA5C2B-reverse" value="수정" >&nbsp;
			<input type="reset" class="btn btn-outline-success" value="취소">
		</div>
	</form:form>
	
</div>
<div id="enroll-container" class="mx-auto text-center">
     <form name="memberEnrollFrm" action="${pageContext.request.contextPath}/member/sellerEnroll.do" method="POST" accept-charset="UTF-8" enctype="multipart/form-data">
        <div class="mx-auto">
            <div class="enroll-info-container">
                <span class="enroll-info-label">아이디<span class="enroll-form-required">*</span></span>
                <span class="enroll-info">
                    <span id="memberId-container">
                        <input type="text" class="form-control" placeholder="영문/숫자 4~12자" name="memberId" id="memberId" required>
                        <span class="valid-feedback feedback-id">사용가능한 아이디입니다.</span>
                        <span class="invalid-feedback feedback-id">이미 사용중이거나 유효하지 않은 아이디입니다.</span>
                        <input type="hidden" id="idValid" value="0"/><!-- 사용불가한 아이디 0, 사용가능한 아이디 1 -->
                    </span>
                </span>
            </div>
            <div class="enroll-info-container">
                <span class="enroll-info-label">패스워드<span class="enroll-form-required">*</span></span>
                <span class="enroll-info">
                	<span id="memberPassword-container">
                     <input type="password" class="form-control" name="memberPassword" id="password" value="1234" required>
                     <span class="invalid-feedback feedback-password">6자리 이상 작성해주시기 바랍니다.</span>
                	</span>
                </span>
            </div>
            <div class="enroll-info-container">
                <span class="enroll-info-label">패스워드확인<span class="enroll-form-required">*</span></span>
                <span class="enroll-info">	
                	<span id="passwordCheck-container">
                     <input type="password" class="form-control" id="passwordCheck" value="1234" required>
                     <span class="invalid-feedback feedback-password">비밀번호가 일치하지 않습니다.</span>
                	</span>
                </span>
            </div>  
            <div class="enroll-info-container">
                <span class="enroll-info-label">업체명<span class="enroll-form-required">*</span></span>
                <span class="enroll-info">	
                    <input type="text" class="form-control" name="memberName" id="memberName" value="사과농장" required>
                </span>
            </div>
            <div class="enroll-info-container">
                <span class="enroll-info-label">대표자명<span class="enroll-form-required">*</span></span>
                <span class="enroll-info">	
                    <input type="text" class="form-control" name="sellerName" id="sellerName" value="홍길동" required>
                </span>
            </div>
            <div class="enroll-info-container">
                <span class="enroll-info-label">전화번호<span class="enroll-form-required">*</span></span>
                <span class="enroll-info">	
                	<span class="phone-container">
                     <input type="tel" class="form-control" placeholder="(-없이)01012345678" name="memberPhone" id="memberPhone" maxlength="11" value="01098989898" required>
                     <span class="invalid-feedback feedback-phone">띄어쓰기없이 번호만 입력해주세요.</span>
                	</span>
                    
                </span>
            </div>
            <div class="enroll-info-container">
                <span class="enroll-info-label">이메일<span class="enroll-form-required">*</span></span>
                <span class="enroll-info">
                    <span id="memberEmail-container">
                        <input type="email" class="form-control" placeholder="abc@xyz.com" name="memberEmail" id="memberEmail" value="" required>
                        <span class="valid-feedback feedback-email">사용가능한 이메일입니다.</span>
                        <span class="invalid-feedback feedback-email">이미 사용중이거나 유효하지 않은 이메일형식입니다.</span>
                        <input type="hidden" id="emailValid" value="0"/><!-- 사용불가 0, 사용가능 1 -->
                    </span>
                    <input type="button" class="enroll-info-btn" id="btn-email-sendKey" value="이메일 인증"
                            disabled/><!-- 완성후 기능 살려놓기 -->
                </span>
            </div>
            <div class="enroll-info-container">
                <span class="enroll-info enroll-eamilKey-container">
                    <input type="text" id="emailKey" placeholder="인증코드를 입력하세요." required 
                            readonly/>
                    <input type="hidden" id="emailKeyValid" value="1"/><!-- 불일치 0, 일치 1 -->
                    <input type="button" class="enroll-info-btn" id="btn-email-enterKey" value="확인"
                        disabled/>
                </span>
            </div>
            <div class="enroll-info-container">
                <span class="enroll-info-label">주소<span class="enroll-form-required">*</span></span>
                <span class="enroll-info">	
                    <input type="text" class="form-control" placeholder="" name="memberAddress" id="address" value="서울시 강남구 역삼동 123" readonly required>
                </span>
            </div>
            <div class="enroll-info-container">
                <span class="enroll-info-label">상세주소</span>
                <span class="enroll-info">	
                    <input type="text" class="form-control" placeholder="" name="memberAddressEx" id="address-ex" value="">
                </span>
            </div>
            <div class="enroll-info-container">
                <span class="enroll-info-label">개업일<span class="enroll-form-required">*</span></span>
                <span class="enroll-info">	
                    <input type="date" class="form-control" name="memberBirthday" id="birthday" value="1999-09-09" required/>
                </span>
            </div> 
            <div class="enroll-info-container">
                <span class="enroll-info-label">사업자등록번호<span class="enroll-form-required">*</span></span>
                <span class="enroll-info">
                	<span class="sellerRegNo-container">
	                    <input type="text" name="sellerRegNo" id="sellerRegNo" placeholder="000-00-00000" required/>
	                    <span class="invalid-feedback feedback-regNo">-를 포함하여 작성해주세요.</span>
                	</span>
                </span>
            </div>
            <div class="enroll-info-container">
                <span class="enroll-info-label"><label for="sellerRegFile">사업자등록증<span class="enroll-form-required">*</span></label></span>
                <span class="enroll-info">
                    <input type="file" name="sellerRegFile" id="sellerRegFile" required/>
                </span>
            </div>   
        </div>
        <sec:csrfInput />
        <input type="submit" value="가입" >
        <input type="reset" value="취소">
    </form>
</div>  
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>