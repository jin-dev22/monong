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
<div id="member-direct-review-update-container">
	<form:form
		action="${pageContext.request.contextPath}/member/memberDirectReviewUpdateForm.do"
		name="directReviewUpdateFrm"
		method="post"
		accept-charset="UTF-8"
		enctype="multipart/form-data">
		<input type="hidden" name="dOrderNo" value="${dReview.dOrderNo}" />
		<input type="hidden" name="dOptionNo" value="${dReview.directOpt.DOptionNo}" />
		<input type="hidden" name="dReviewNo" value="${dReview.dReviewNo}" />
		<input type="hidden" name="dReviewRecommend" value="${dReview.dReviewRecommend}" />
		<input type="hidden" name="memberId" value="${dReview.memberId}" />
		<div class="direct-review-enroll text-center">
		<div id="review-enroll-header-container" class="mx-auto">
			<h2>리뷰 수정</h2><br />
			<h5>상품명 : ${dReview.reviewProd.DProductName} - ${dReview.reviewOpt.DOptionName}</h5>
		</div>   
		    <br /><br />
		    <!-- 별점 -->
		    <h6>이 상품에 어느만큼 만족하셨나요? :)</h6>
            <div class="star-rating text-center">
			  <input type="radio" id="5-stars" name="reviewRating" value="5" ${dReview.reviewRating eq "5" ? 'checked' : ''}/>
			  <label for="5-stars" class="star">&#9733;</label>
			  <input type="radio" id="4-stars" name="reviewRating" value="4" ${dReview.reviewRating eq "4" ? 'checked' : ''}/>
			  <label for="4-stars" class="star">&#9733;</label>
			  <input type="radio" id="3-stars" name="reviewRating" value="3" ${dReview.reviewRating eq "3" ? 'checked' : ''}/>
			  <label for="3-stars" class="star">&#9733;</label>
			  <input type="radio" id="2-stars" name="reviewRating" value="2" ${dReview.reviewRating eq "2" ? 'checked' : ''}/>
			  <label for="2-stars" class="star">&#9733;</label>
			  <input type="radio" id="1-star" name="reviewRating" value= "1" ${dReview.reviewRating eq "1" ? 'checked' : ''}/>
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
				    	<input type="text" name="dReviewTitle" id="dReviewTitle" value="${dReview.dReviewTitle}" placeholder="제목을 입력해주세요" required/>
				    	<span class="title-invalid-error">최소 4자 이상 ~ 최대 70자 이하까지 입력하실 수 있어요</span>
				    </td>
				  </tr>
				  <tr>
				    <th>후기작성</th>
				    <td>
				    	<div>
					   		 <textarea id="dReviewContent" name="dReviewContent" cols="100" rows="10" placeholder="리뷰 내용을 입력해주세요" style="height:202px; resize: none;"required>${dReview.dReviewContent}</textarea>
					   		 <br /><span class="content-invalid-error">최소 10자 이상 입력해주세요</span>
					   		 <p class="txt-count">
					   		 	<span class="txt-num">${fn:length(dReview.dReviewContent)}</span>
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
			            	<br />
			            	<span class="text-primary">파일을 새로 업로드하실 경우, 기존 파일이 삭제됩니다</span>
	            		</div>
	            		<br />
	            		
	            		<c:if test="${dReview.reviewAttach.DReviewOriginalFilename != null}">
		            		<label for="reviewUpdate-btn-download">기존파일</label>
							<div id="reviewUpdate-attachUpdate-container">
								<input type="button" class="btn btn-outline-success" id="reviewUpdate-btn-download"
									onclick="location.href='${pageContext.request.contextPath}/member/directReviewfileDownload.do?dReviewAttachNo=${dReview.reviewAttach.DReviewAttachNo}'"
									value="${dReview.reviewAttach.DReviewOriginalFilename}" />
								&nbsp;&nbsp; 
								<label class="btn btn-outline-danger" title="삭제"> 
									<input type="checkbox" name="deleteFileNo" class="btn btn-outline-danger" id="deleteFileNo"
										value="${dReview.reviewAttach.DReviewAttachNo}" />
									삭제
								</label>
							</div>
						</c:if>
				    </td>
				  </tr>
				</tbody>
			</table>
			
			<br /><br /><br />
           </div>
           <br /><br />
			<button type="submit" class="btn btn-116530" id="direct-review-enroll-btn" onclick="return confirm('리뷰를 수정하시겠어요?')">리뷰 수정</button>
	
	</form:form>
</div>


<script>

//파일 업로드 & 삭제 체크 안한 경우 자동 체크처리 후 submit
document.directReviewUpdateFrm.addEventListener('submit', (e)=>{
	
	const newFile = document.querySelector("#directReviewRegFile");
	const recentFile = "<c:out value='${dReview.reviewAttach.DReviewOriginalFilename}'/>"
	console.log("newFile="+newFile, "recent="+recentFile);
	
	if(recentFile){
		if(newFile.value != null){
			const delFileNo = document.querySelector("#deleteFileNo");
			e.preventDefault();
			delFileNo.checked = true;
			console.log('checked!!');
		}
		e.target.submit();
	}
	
	
	e.target.submit();
});

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


const titleFeedback = document.querySelector(".title-invalid-error");
const contentFeedback = document.querySelector(".content-invalid-error");
titleFeedback.style.display = "none";
contentFeedback.style.display = "none";

//유효성 검사
const isActiveEnroll = () => {
	let titleVal = titleInput.value;
	let contentVal = contentInput.value;
	const titleMax = 70;
	const contentMax = 500;
	const titleMin = 4;
	const contentMin = 10;
	console.log(typeof "<c:out value='${dReview.reviewAttach.DReviewAttachNo}'/>");
	


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


</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>