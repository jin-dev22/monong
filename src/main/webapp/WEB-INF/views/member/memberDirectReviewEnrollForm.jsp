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
<jsp:include page="/WEB-INF/views/member/memberMyPage.jsp">
	<jsp:param name="title" value="모농모농-마이페이지"></jsp:param>
</jsp:include>
<div id="member-direct-review-enroll-container">
	<form:form
		action="${pageContext.request.contextPath}/member/memberDirectReviewEnrollForm.do"
		name="directReviewEnrollFrm"
		method="post"
		accept-charset="UTF-8"
		enctype="multipart/form-data">
		<input type="hidden" name="dOrderNo" value="${reviewProd.dOrderNo}" />
		<input type="hidden" name="dOptionNo" value="${reviewProd.directOpt.DOptionNo}" />
		<input type="hidden" name="memberId" value="<sec:authentication property='principal.username'/>" />
		<div class="direct-review-enroll text-center">
		<div id="review-enroll-header-container" class="mx-auto">
			<h2>리뷰 작성</h2><br />
			<h5>상품명 : ${reviewProd.directProd.DProductName} - ${reviewProd.directOpt.DOptionName}</h5>
		</div>   
		    <br /><br />
		    <!-- 별점 -->
		    <h6>이 상품에 어느만큼 만족하셨나요? :)</h6>
            <div class="star-rating text-center">
			  <input type="radio" id="5-stars" name="reviewRating" value="5" checked/>
			  <label for="5-stars" class="star">&#9733;</label>
			  <input type="radio" id="4-stars" name="reviewRating" value="4" />
			  <label for="4-stars" class="star">&#9733;</label>
			  <input type="radio" id="3-stars" name="reviewRating" value="3" />
			  <label for="3-stars" class="star">&#9733;</label>
			  <input type="radio" id="2-stars" name="reviewRating" value="2" />
			  <label for="2-stars" class="star">&#9733;</label>
			  <input type="radio" id="1-star" name="reviewRating" value= "1" />
			  <label for="1-star" class="star">&#9733;</label>
			  <input type="radio" id="0-star" name="reviewRating" value= "0" />
			</div> 
			
			<!-- 작성내용 -->
			<table class="table">
			<colgroup>
				<col style="width:110px;" />
				<col style="width:auto"/>
			</colgroup>
				<tbody>
				 <tr>
				    <th>제목</th>
				    <td>
				    	<input type="text" name="dReviewTitle" id="dReviewTitle" placeholder="제목을 입력해주세요" required/>
				    	<span class="title-invalid-error">최소 4자 이상 ~ 최대 70자 이하까지 입력하실 수 있어요</span>
				    </td>
				  </tr>
				  <tr>
				    <th>후기작성</th>
				    <td>
				    	<div>
					   		 <textarea id="dReviewContent" name="dReviewContent" cols="100" rows="10" placeholder="리뷰 내용을 입력해주세요" style="height:202px; resize: none;"required></textarea>
					   		 <br /><span class="content-invalid-error">최소 10자 이상 입력해주세요</span>
					   		 <p class="txt-count">
					   		 	<span class="txt-num">0</span>
					   		 	자 / 최대 500자
					   		 </p>
				   		</div>
				    </td>
				  </tr>
				  <tr>
				    <th>사진등록</th>
				    <td>
					    <div class="custom-file">
			           		<input type="file" class="custom-file-input" name="directReviewRegFile" id="directReviewRegFile" />
			            	<label class="custom-file-label" for="directReviewRegFile">파일을 선택하세요</label>
	            		</div>
				    </td>
				  </tr>
				</tbody>
			</table>
			
			<br /><br /><br />
           </div>
           <br /><br />
			<button type="submit" class="btn btn-116530" id="direct-review-enroll-btn" onclick="return confirm('리뷰를 등록하시겠어요?')">리뷰 등록</button>
	
	</form:form>
</div>


<script>
const inputFile = document.querySelector("[name=directReviewRegFile]");
inputFile.addEventListener("input", (e) => {
		const inputFile = e.target;
		const label = e.target.nextElementSibling;
		if(inputFile){
			label.textContent = "";	
		}
		else {
			label.textContent = "파일을 선택하세요";
		}
	});
const targetBtn = document.querySelector("#direct-review-enroll-btn");
const titleInput = document.querySelector("#dReviewTitle");
const contentInput = document.querySelector("#dReviewContent");

targetBtn.disabled = true;

//글자수 세기
$('#dReviewContent').keyup(function(e){
	let content = $(this).val();
	if(content.length == 0 || content == ''){
		$('.txt-num').text('0');
	}
	else{
		$('.txt-num').text(content.length);
	}
	
	if(content.length > 500){
			$(this).val($(this).val().substring(0,500));
	};
});

//유효성 검사
const isActiveEnroll = () => {
	let titleVal = titleInput.value;
	let contentVal = contentInput.value;
	const titleMax = 70;
	const contentMax = 500;
	const titleMin = 4;
	const contentMin = 10;
	const titleFeedback = document.querySelector(".title-invalid-error");
	const contentFeedback = document.querySelector(".content-invalid-error");
	titleFeedback.style.display = "none";
	contentFeedback.style.display = "none";


	if(
			(titleVal.length === 0 || contentVal.length === 0) ||
			(titleVal.length > titleMax || titleVal.length < titleMin) ||
			(contentVal.length > contentMax || contentVal.length < contentMin)
		){
			if(titleVal.length > titleMax || titleVal.length < titleMin){
				titleFeedback.style.display = "inline";
			}
			if(contentVal.length < contentMin){
				contentFeedback.style.display = "inline";	
			}
		
		targetBtn.disabled = true;
		targetBtn.style.opacity = .3;	
		
	}
	else{
		 targetBtn.disabled = false;
		 targetBtn.style.opacity = 1;
		 targetBtn.style.cursor = 'pointer';
		 titleFeedback.style.display = "none";
		 contentFeedback.style.display = "none";
	}
	
}

//입력하고있을때나, 복사 붙여넣기 했을 때도 모두 적용되도록
const init = () => {
	  titleInput.addEventListener('input', isActiveEnroll);
	  contentInput.addEventListener('input', isActiveEnroll);
	  titleInput.addEventListener('keyup', isActiveEnroll);
	  contentInput.addEventListener('keyup', isActiveEnroll);
	}

init();
$("#navbarDropdown").css("color","EA5C2B");
$("#lnik-dReviewEnrollList").css("color","EA5C2B");

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>