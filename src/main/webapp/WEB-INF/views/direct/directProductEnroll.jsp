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
</style>
<div id="enroll-container" class="mx-auto text-center">
<sec:authentication property="principal" var="loginMember"/>
<c:if test="${loginMember.memberId eq prod.memberId}">
	<form name="productEnrollFrm" action="${pageContext.request.contextPath}/direct/directProductEnroll.do" method="POST" accept-charset="UTF-8" enctype="multipart/form-data">
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
                    	<input type="text" class="form-control" name="DProductName" id="DProductName" required>
                    </span>
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
                    	<input type="text" class="form-control" name="DDefaultPrice" id="DDefaultPrice" placeholder="목록에 표시될 가격을 입력해주세요"required>
                    </span>
        		</span>
        	</div>
        	<div class="enroll-info-container">
        		<span class="enroll-info-label">배송비<span class="enroll-form-required">*</span></span>
        		<span class="enroll-info">
        			<span id="DDeliveryFee-container">
                    	<input type="text" class="form-control" name="DDeliveryFee" id="DDeliveryFee" value="3000" readonly/>
                    </span>
        		</span>
        	</div>
		</div>
		<div class="enroll-info-container">
	   		<span class="enroll-info-label">상품 옵션</span>
    	 		<div class="opntion-list-container">
     				<div class="option-one">
	     				<div class="option-row">
		      				<label for="DOptionName1" class="optName-label">옵션1 이름</label>
		    	   			<input type="text" name="directProductOptions[0].dOptionName" id="dOptionName1"/> 
	     				</div>
	     				<div class="option-row">
							<span>가격 </span>
							<input type="text" name="directProductOptions[0].dPrice" maxlength="10" class="price"/>
	     				</div>
	     				<div class="option-row">
							<label for="dStock1">수량</label>
							<input type="number" min="0" name="directProductOptions[0].dStock" id="dStock1" class="insert-dStock1" />
	     				</div>
	     				<div class="option-row">
	     					<span>판매상태</span>
	     					<select name="directProductOptions[0].dSaleStatus" id="direct-saleStatus1">
								<option value="판매중">판매중</option>
								<option value="판매중단">판매중단</option>
								<option value="판매마감">판매마감</option>
							</select>
							<input type="hidden" name="directProductOptions[0].dOptionNo"/>
	     				</div>
	    				<span class="vStatus" style="display: none">${vStatus.count}</span>
     				</div>
     		</div>
        </div>
        <div class = "option-add">
        	<button type="button" onclick="addOption(this.form)">옵션추가</button>
   			<button type="button" onclick="delOption(this.form)">옵션삭제</button>
   		</div>
        <br/>
		<sec:csrfInput />
		<div class = "direct-add">
	        <input type="submit" class="btn btn-EA5C2B" value="상품 등록">
	        <input type="reset" class="btn btn-116530" value="취소">
        </div>
	</form>
</c:if>
<c:if test="${not(loginMember.memberId eq prod.memberId)}">
	<h2>올바른 접근이 아닙니다.</h2><!-- 판매글 작성자가 아닌 다른 계정이 url로 접속할 경우 대비 -->
</c:if>
</div>
<script>
let newOptCnt = 1;
/**
 * 옵션 삭제 메소드
 */
function delOption(optList){
	const lastOne = document.querySelector(".option-one:last-child");
			lastOne.remove();
			newOptCnt--;
}

/**
 * 옵션 추가 메소드
 */
function addOption (optList)  {
	console.log(optList);
	const lastOne = document.querySelector(".option-one:last-child");
	let cnt = newOptCnt;
	newOptCnt++;
	
	html= ` <div class="option-one">
			<div class="option-row">
				<label for="dOptionName\${cnt+1}" class="optName-label">옵션\${cnt+1}이름</label>
				<input type="text" name="directProductOptions[\${cnt}].dOptionName" id="dOptionName\${cnt+1}" value=""/> 
			</div>
			<div class="option-row">
				<span>가격 </span>
				<input type="text" name="directProductOptions[\${cnt}].dPrice" maxlength="10" class="price" value=""/>
			</div>
			<div class="option-row">
				<label for="dStock1">수량</label>
				<input type="number" min="0" name="directProductOptions[0].dStock" id="dStock1" class="insert-dStock1" />
			</div>
			<div class="option-row">
				<span>판매상태</span>
					<select name="directProductOptions[0].dSaleStatus" id="direct-saleStatus1">
						<option value="판매중">판매중</option>
						<option value="판매중단">판매중단</option>
						<option value="판매마감">판매마감</option>
					</select>
			</div>
			<br />
			<span class="vStatus" style="display: none">\${cnt+1}</span>
			</div>`;
	$(lastOne).after(html);
}

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

// 서머노트 세팅
$(document).ready(function() {
	  $('#summernote').summernote({
 	    	placeholder: 'content',
	        minHeight: 370,
	        maxHeight: null,
	        focus: true, 
	        lang : 'ko-KR'
	  });
	});
	

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>