<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<!-- include summernote css/js-->
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.js"></script>
<!-- include summernote-ko-KR -->
<script src="/resources/js/summernote-ko-KR.js"></script>​
<style>
div#enroll-container{
    margin: 50px auto;
    width: fit-content;
 }

 #enroll-container .enroll-info-btn{
    margin-left: 15px;
 } 
 .enroll-info-container{
    width: 600px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 15px 0;
 }
 
 .enroll-info-label{
    display: inline-block;
    text-align: left;
    width: 150px;
    font-weight: bold;
 }

 .enroll-info{
    display: flex;
    align-items: center;
    width: 300px;
 }
 
 .enroll-info-file{
    display: flex;
    align-items: center;
    width: 300px;
 }

 .enroll-info input{
    width: 300px;
 }
 
 .enroll-form-required{
	color: red;
}

#DProductContent-container{
	width: 600px;
}
.delFiles-container{
	overflow-x: auto;
	width: 300px;
}
</style>
<div id="enroll-container" class="mx-auto text-center">
<sec:authentication property="principal" var="loginMember"/>
<c:if test="${loginMember.memberId eq prod.memberId}">
	<form name="productEnrollFrm" action="${pageContext.request.contextPath}/direct/directProductUpdate.do" method="POST" accept-charset="UTF-8" enctype="multipart/form-data">
        <div class="mx-auto">
        	<div class="enroll-info-container">
        		<span class="enroll-info-label">판매자</span>
        		<span class="enroll-info">
        			<span id="memberId-container">
                    	<input type="text" class="form-control" name="memberId" value="${loginMember.memberId}" readonly required>
                    </span>
        		</span>
        	</div>
        	<div class="enroll-info-container">
        		<span class="enroll-info-label">상품명<span class="enroll-form-required">*</span></span>
        		<span class="enroll-info">
        			<span id="DProductName-container">
                    	<input type="text" class="form-control" name="DProductName" id="DProductName" value="${prod.DProductName}" required>
                    </span>
        		</span>
        	</div>
        	<div class="enroll-info-container">
        		<span class="enroll-info-label"><label for="upFile">기존파일</label></span>
        		<span class="delFiles-container">
	        		<c:forEach items="${prod.directProductAttachments}" var="attach" varStatus="vs">
						<label class="btn btn-outline-danger" title="삭제"> 
							<img src="${pageContext.request.contextPath}/resources/upload/product/${attach.DProductRenamedFilename}" style="width:50px;" alt="" />
							<input type="checkbox" name="delFileNo" class="btn btn-outline-danger" id="delFileNo"
								value="${attach.DProductNo}">
						</label>
	        		</c:forEach>
           		</span>
           </div>
        	<div class="enroll-info-container">
        		<span class="enroll-info-label"><label for="upFile">상품 사진</label></span>
        		<span class="enroll-info">
        			<span id="file-container">
           			<input class="form-control" name="upFile" type="file" id="upFile1" multiple>
           			<input class="form-control" name="upFile" type="file" id="upFile2" multiple>
           			<input class="form-control" name="upFile" type="file" id="upFile3" multiple>
           			<input class="form-control" name="upFile" type="file" id="upFile4" multiple>
           			</span>
           		</span>
           </div>
           <div class="enroll-info-container">
        		<span class="enroll-info-label"><label for="upFile">상품 옵션</label></span>
        		<fieldset name="directProductOptions">
        			<c:forEach items="${prod.directProductOptions}" var="opt" varStatus="vStatus">
        				<label for="dOptionName${vSataus.count}">옵션${vStatus.count}</label>
	        			<input type="text" name="dOptionName" id="dOptionName${vSataus.count}" value="${opt.DOptionName}"/> 
	        			<select name="dSaleStatus" id="direct-saleStatus" onchange="this.form.submit()">
							<option value="판매중" ${opt.DSaleStatus eq '판매중' ? 'selected' : ''}>판매중</option>
							<option value="판매중단" ${opt.DSaleStatus eq '판매중단' ? 'selected' : ''}>판매중단</option>
							<option value="판매마감" ${opt.DSaleStatus eq '판매마감' ? 'selected' : ''}>판매마감</option>
						</select>
        			</c:forEach>
        		</fieldset>
           </div>
           <div class="enroll-info-container">
        		<span class="enroll-info-label">상품 상세 설명<span class="enroll-form-required">*</span></span>
        			<span class="enroll-info">
        				<span id="DProductContent-container">
                        	<textarea name="DProductContent" id="summernote"></textarea>
                        </span>
        			</span>
        	</div>
        	<div class="enroll-info-container">
        		<span class="enroll-info-label">상품 가격<span class="enroll-form-required">*</span></span>
        		<span class="enroll-info">
        			<span id="DDefaultPrice-container">
                    	<input type="text" class="form-control" name="DDefaultPrice" id="DDefaultPrice" required>
                    </span>
        		</span>
        	</div>
        	<div class="enroll-info-container">
        		<span class="enroll-info-label">배송비<span class="enroll-form-required">*</span></span>
        		<span class="enroll-info">
        			<span id="DDeliveryFee-container">
                    	<input type="text" class="form-control" name="DDeliveryFee" id="DDeliveryFee" required>
                    </span>
        		</span>
        	</div>
		</div>
		<sec:csrfInput />
        <input type="submit" class="btn btn-EA5C2B" value="상품 수정">
        <input type="reset" class="btn btn-116530" value="취소">
	</form>
</c:if>
<c:if test="${not(loginMember.memberId eq prod.memberId)}">
	<h2>올바른 접근이 아닙니다.</h2><!-- 판매글 작성자가 아닌 다른 계정이 url로 접속할 경우 대비 -->
</c:if>
</div>
<script>
document.querySelectorAll("[name=upFile]").forEach((input) => {
	input.addEventListener("change", (e) => {
		const {files} = e.target;
		const label = e.target.nextElementSibling;
		if(files[0]){
			label.textContent = files[0].name;	
		}
		else {
			label.textContent = "파일을 선택하세요";
		}
	});
});
$(document).ready(function() {
	  $('#summernote').summernote({
	        minHeight: 370,
	        maxHeight: null,
	        focus: true, 
	        disableResizeEditor: true,
	        lang : 'ko-KR'
	  });

	  $("#summernote").summernote('code',  '${prod.DProductContent}');
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>