<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="모농모농-상품등록"></jsp:param>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/direct/direct.css" />

<div id="enroll-container" class="mx-auto text-center">
	<form name="productEnrollFrm" action="${pageContext.request.contextPath}/direct/directProductEnroll.do" method="POST" accept-charset="UTF-8" enctype="multipart/form-data">
        <div class="mx-auto">
        	<div class="enroll-info-container">
        		<span class="enroll-info-label">상품명</span>
        			<span class="enroll-info">
        				<span id="DProductName-container">
                        	<input type="text" class="form-control" name="DProductName" id="DProductName" required>
                        </span>
        			</span>
        	</div>
        	<div class="enroll-info-container">
                <label for="formFile" class="form-label">상품 사진</label>
           			<small>* 마지막 등록 사진이 대표사진으로 등록됩니다. *</small>
           				<div class="insert">
				        	<input class="form-control" name="upFile1" type="file" id="formFile">
				        	<input class="form-control" name="upFile2" type="file" id="formFile">
				        	<input class="form-control" name="upFile3" type="file" id="formFile">
				        	<input class="form-control" name="upFile4" type="file" id="formFile">
				        	<input class="form-control" name="upFile5" type="file" id="formFile">
           </div>
        	<div class="enroll-info-container">
        		<span class="enroll-info-label">옵션1</span>
        			<span class="enroll-info">
        				<span id="DOptionName-container">
                        	<input type="text" class="form-control" name="DOptionName" id="DOptionName">
                        </span>
        			</span>
        	</div>
        	<div class="enroll-info-container">
        		<span class="enroll-info-label">옵션1 가격</span>
        			<span class="enroll-info">
        				<span id="DPrice-container">
                        	<input type="text" class="form-control" name="DPrice" id="DPrice">
                        </span>
        			</span>
        	</div>
        	<div class="enroll-info-container">
        		<span class="enroll-info-label">옵션2</span>
        			<span class="enroll-info">
        				<span id="DOptionName-container">
                        	<input type="text" class="form-control" name="DOptionName" id="DOptionName">
                        </span>
        			</span>
        	</div>
        	<div class="enroll-info-container">
        		<span class="enroll-info-label">옵션2 가격</span>
        			<span class="enroll-info">
        				<span id="DPrice-container">
                        	<input type="text" class="form-control" name="DPrice" id="DPrice">
                        </span>
        			</span>
        	</div>
        	<div class="enroll-info-container">
        		<span class="enroll-info-label">옵션3</span>
        			<span class="enroll-info">
        				<span id="DOptionName-container">
                        	<input type="text" class="form-control" name="DOptionName" id="DOptionName">
                        </span>
        			</span>
        	</div>
        	<div class="enroll-info-container">
        		<span class="enroll-info-label">옵션3 가격</span>
        			<span class="enroll-info">
        				<span id="DPrice-container">
                        	<input type="text" class="form-control" name="DPrice" id="DPrice">
                        </span>
        			</span>
        	</div>
        	<div class="enroll-info-container">
        		<span class="enroll-info-label">옵션4</span>
        			<span class="enroll-info">
        				<span id="DOptionName-container">
                        	<input type="text" class="form-control" name="DOptionName" id="DOptionName">
                        </span>
        			</span>
        	</div>
        	<div class="enroll-info-container">
        		<span class="enroll-info-label">옵션4 가격</span>
        			<span class="enroll-info">
        				<span id="DPrice-container">
                        	<input type="text" class="form-control" name="DPrice" id="DPrice">
                        </span>
        			</span>
        	</div>
		</div>
		</div>
	</form>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>