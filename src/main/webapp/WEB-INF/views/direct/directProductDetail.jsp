﻿﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/direct/direct.css" />
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="loginMember" scope="page" />
	<c:set var="loginMemberId" value="${loginMember.memberId}"/>
	<input type="hidden" id="memberId" value="<sec:authentication property='principal.username'/>" />
</sec:authorize>
<main class="main-container">
  <input type="hidden" id="dProductNo" name="dProductNo" value="${directProduct.DProductNo}" />
  <div class="slider-container">
    <div class="slider-1">
        <div class="slides">
        <c:if test="${not empty directProduct.directProductAttachments[0].DProductRenamedFilename}">
          	<div class="active" style="background-image:url(${pageContext.request.contextPath}/resources/upload/product/${directProduct.directProductAttachments[0].DProductRenamedFilename});background-size: 100%;"></div>
        </c:if>
        <c:if test="${not empty directProduct.directProductAttachments[1].DProductRenamedFilename}">
          	<div style="background-image:url(${pageContext.request.contextPath}/resources/upload/product/${directProduct.directProductAttachments[1].DProductRenamedFilename});background-size: 100%;"></div>
        </c:if>
        <c:if test="${not empty directProduct.directProductAttachments[2].DProductRenamedFilename}">
          	<div style="background-image:url(${pageContext.request.contextPath}/resources/upload/product/${directProduct.directProductAttachments[2].DProductRenamedFilename});background-size: 100%;"></div>
        </c:if>
        <c:if test="${not empty directProduct.directProductAttachments[3].DProductRenamedFilename}">
          	<div style="background-image:url(${pageContext.request.contextPath}/resources/upload/product/${directProduct.directProductAttachments[3].DProductRenamedFilename});background-size: 100%;"></div>
        </c:if>
        </div>
        <div class="page-btns">
        <c:if test="${not empty directProduct.directProductAttachments[0].DProductRenamedFilename}">
            <div class="active" style="background-image:url(${pageContext.request.contextPath}/resources/upload/product/${directProduct.directProductAttachments[0].DProductRenamedFilename});background-size: cover;background-position: center;"> </div>
        </c:if>
        <c:if test="${not empty directProduct.directProductAttachments[1].DProductRenamedFilename}">
            <div style="background-image:url(${pageContext.request.contextPath}/resources/upload/product/${directProduct.directProductAttachments[1].DProductRenamedFilename});background-size: cover;background-position: center;"> </div>
        </c:if>
        <c:if test="${not empty directProduct.directProductAttachments[2].DProductRenamedFilename}">
            <div style="background-image:url(${pageContext.request.contextPath}/resources/upload/product/${directProduct.directProductAttachments[2].DProductRenamedFilename});background-size: cover;background-position: center;"> </div>
        </c:if>
        <c:if test="${not empty directProduct.directProductAttachments[3].DProductRenamedFilename}">
            <div style="background-image:url(${pageContext.request.contextPath}/resources/upload/product/${directProduct.directProductAttachments[3].DProductRenamedFilename});background-size: cover;background-position: center;"> </div>
        </c:if>
        </div>
        <div class="side-btns">
            <div>
                <span><i class="fas fa-angle-left"></i></span>
            </div>
            <div>
                <span><i class="fas fa-angle-right"></i></span>
            </div>
        </div>
    </div>
  </div>
  <div class="pInfo-container">
  	<div class="dProductName-container">
    	<span class="dProductName">${directProduct.DProductName}</span><br>
  	</div>
  	<div class="dPrice-review-container">
    	<span class="dDefaultPrice"><fmt:formatNumber value="${directProduct.DDefaultPrice}" pattern="#,###" />원</span><div class="review-wrap"><span class="reviewStar"></span><span class="reviewAvgScore"></span></div>
  	</div>
    <div style="border-top: 1px solid #e5e7eb; background-color: #e5e7eb;"></div>
    <div class="dDeliveryFee-container">
    	<span class="dDeliveryFee-title">배송비 <span style="font-size: 10px; color:#afb0b3;">(판매자별)</span></span><span class="dDeliveryFee"><fmt:formatNumber value="${directProduct.DDeliveryFee}" pattern="#,###" />원</span><br>
    </div>
    <div class="seller-container">
    	<span class="seller-title">판매자</span><span class="seller">${directProduct.member.memberName}</span>
    </div>
    <div class="soldout">
    	<div class="soldout-content">품절이에요</div>
    </div>
    <div class="dropdown">
	    <button class="dropbtn">
	      <span class="dropbtn_content">옵션 선택</span>
	      <span class="dropbtn_click">▼</span>
	    </button>
	    <div class="dropdown-content">
		    <table class="tbl-dropdown">
		      <c:forEach items="${directProduct.directProductOptions}" var="option">
		      	<c:if test="${option.DSaleStatus ne '판매중단'}">
			    <tr class="select_option" data-option-no="${option.DOptionNo}" onclick="showMenu(this.innerText)">
			      	<td class="dPOName">${option.DOptionName}</td>
			      	<td class="dPrice"><fmt:formatNumber value="${option.DPrice}" pattern="#,###" />원</td>
			    </tr>
			    <input type="hidden" class="dStock" name="dStock" value="${option.DStock}" />
			    <input type="hidden" name="dSaleStatus" value="${option.DSaleStatus}" />
		      	</c:if>
		      </c:forEach>
		    </table>
	    </div>
	</div>
	<form:form action="" method="POST" name="totalProductFrm">
		<div class="pOption-container">
		</div>
	</form:form>
    <div style="border-top: 1px solid #e5e7eb; background-color: #e5e7eb;"></div>
	<div class="pPrice-container">
		<span class="total-price">총 상품 금액</span>
		<div class="total-price-container">
			<span class="total-price-num">0</span><span>원</span>
		</div>
	</div>
	<div class="btn-container">
		<sec:authorize access="isAnonymous()">
	    	<button type="button" class="btn-add-cart btn-116530" id="cart" onclick="checkLogin();">장바구니</button>
	    </sec:authorize>
	    <sec:authorize access="isAuthenticated()">
	    	<sec:authorize access="!hasRole('ROLE_MEMBER')">
	    	<button type="button" class="btn-add-cart btn-116530" onclick="alert('일반회원만 이용 가능합니다.'); return false;">장바구니</button>
	    	</sec:authorize>
	    	<sec:authorize access="hasRole('ROLE_MEMBER')">
	    	<button type="button" class="btn-add-cart btn-116530" id="cart">장바구니</button>
	    	</sec:authorize>
	    </sec:authorize>
	    <sec:authorize access="isAnonymous()">
	    	<button type="button" class="btn-add-order btn-EA5C2B" id="order" onclick="checkLogin();">주문하기</button>
	    </sec:authorize>
	    <sec:authorize access="isAuthenticated()">
	    	<sec:authorize access="!hasRole('ROLE_MEMBER')">
	    	<button type="button" class="btn-add-order btn-EA5C2B" onclick="alert('일반회원만 이용 가능합니다.'); return false;">주문하기</button>
		    </sec:authorize>
	    	<sec:authorize access="hasRole('ROLE_MEMBER')">
	    	<button type="button" class="btn-add-order btn-EA5C2B" id="order">주문하기</button>
		    </sec:authorize>
	    </sec:authorize>
	</div>
	<div class="modal-container"></div>
  </div>
  <div class="direct-footer-container">
  	  <div style="border-top: 1px solid #e5e7eb; background-color: #e5e7eb;"></div>
  	  <nav class="direct-detail-nav">
		  <a href="#contentLink" id="info" class="direct-detail-nav-item is-active">상품 정보</a>
		  <a href="#inquireLink" id="inquire" class="direct-detail-nav-item">상품 문의</a>
		  <a href="#reviewLink" id="review" class="direct-detail-nav-item">이용 후기</a>
	  </nav>
	  <div id="contentLink" style="border-top: 1px solid #EA5C2B; background-color: #EA5C2B;"></div>
	  <div class="dProductContent">
	  	<div style="max-width: 830px;">
	  		${directProduct.DProductContent}
	  	</div>
	  </div>
	  <div id="inquireLink" style="border-top: 1px solid #e5e7eb; background-color: #e5e7eb; margin: 65px 0;"></div>
	  <div id="dProductInquire" class="dProductInquire">
	  	<span style="font-size: 20px; display: block; position: relative; padding: 20px 0;">Q & A</span>
	  	<sec:authorize access="isAuthenticated()">
		  	<div class="btn-dProductInquire">
			  	<button type="button" id="enrollInquire" class="btn enrollInquire btn-116530">상품 문의하기</button>
			  	<button type="button" id="findMyInquire" class="btn findInquire btn-116530-reverse" onclick="location.href = '${pageContext.request.contextPath}/member/memberDirectInquireList.do'">내 문의내역 조회</button>
		  	</div>
	  	</sec:authorize>
	  	<div class="tbl-inquire-container">
	  	  <table class="tbl-inquire">
	  	  	  <thead>
	  	  		<tr>
	  	  			<th class="inquire-title">제목</th>
	  	  			<th class="inquire-author">작성자</th>
	  	  			<th class="inquire-created-date">작성일</th>
	  	  			<th class="inquire-status">답변상태</th>
	  	  		</tr>
	  	  	  </thead>
  	  	  	  <tbody>
  	  	  	  	<c:if test="${empty dInquireList}">
  	  	  	  	<tr>
  	  	  	  		<td colspan="4">
  	  	  	  			<div style="height: 100px; display: flex; align-items: center; justify-content: center;">상품 문의내역이 존재하지 않습니다.</div>
  	  	  	  		</td>
  	  	  	  	</tr>
  	  	  	  	</c:if>
  	  	  	  	<c:if test="${not empty dInquireList}">
  	  	  	  	<c:forEach items="${dInquireList}" var="inquireList">
  	  	  	  	<c:if test="${inquireList.checkSecret eq 'Y' && inquireList.memberId ne loginMemberId}">
  	  	  	  	<tr>
  	  	  	  		<td colspan="4" style="text-align: left; padding: 0 14px; height: 58px;">
  	  	  	  			<img style="display: inline-block; position: relative; bottom: 3px; padding-right: 5px;" src="${pageContext.request.contextPath}/resources/images/secret.png" alt="" />비밀글입니다.
  	  	  	  		</td>
  	  	  	  	</tr>
  	  	  	  	</c:if>
  	  	  	  	<c:if test="${inquireList.checkSecret eq 'Y' && inquireList.memberId eq loginMemberId}">
  	  	  		<input type="hidden" name="dInquireNo" value="${inquireList.DInquireNo}" />
  	  	  	  	<tr class="tbl-click-toggle">
	  	  	  		<td style="text-align: left; padding: 0 14px; height: 58px;">${inquireList.inquireTitle}</td>
	  	  	  		<td>${inquireList.memberName}</td>
	  	  	  		<fmt:parseDate value="${inquireList.createdAt}" var="createdAt" pattern="yyyy-MM-dd" />
	  	  	  		<td><fmt:formatDate value="${createdAt}" pattern="yy.MM.dd" /></td>
	  	  	  		<c:if test="${inquireList.hasAnswer eq 'Y'}">
	  	  	  		<td>답변완료</td>
	  	  	  		</c:if>
	  	  	  		<c:if test="${inquireList.hasAnswer ne 'Y'}">
	  	  	  		<td>답변대기</td>
	  	  	  		</c:if>
	  	  	  	</tr>
	  	  	  	<tr class="tbl-toggle" style="display: none;">
	  	  	  		<td colspan="4" style="background-color: rgb(250, 250, 250);">
		  	  	  		<div class="inquire-content-container">
		  	  	  			<div class="inquire-content">
		  	  	  				<div class="Q">Q</div>
		  	  	  				<span class="inquire-q">${inquireList.content}</span>
		  	  	  				<c:if test='${inquireList.memberId eq loginMemberId}'>
		  	  	  				<button class="deleteInquire" type="button">삭제</button>
		  	  	  				</c:if>
		  	  	  			</div>
		  	  	  			<c:if test="${inquireList.directInquireAnswer.DInquireAContent ne null}">
		  	  	  			<fmt:parseDate value="${inquireList.directInquireAnswer.DInquireAnsweredAt}" var="answerCreatedAt" pattern="yyyy-MM-dd" />
		  	  	  			<div class="inquire-answer"><div class="A">A</div><span class="inquire-a">${inquireList.directInquireAnswer.DInquireAContent}</span><span class="inquire-a-answer"><fmt:formatDate value="${answerCreatedAt}" pattern="yy.MM.dd" /></span></div>
		  	  	  			</c:if>
		  	  	  		</div>
	  	  	  		</td>
	  	  	  	</tr>
  	  	  	  	</c:if>
  	  	  	  	<c:if test="${inquireList.checkSecret eq 'N'}">
	  	  	  	<input type="hidden" name="dInquireNo" value="${inquireList.DInquireNo}" />
  	  	  	  	<tr class="tbl-click-toggle">
	  	  	  		<td style="text-align: left; padding: 0 14px; height: 58px;">${inquireList.inquireTitle}</td>
	  	  	  		<td>${inquireList.memberName}</td>
	  	  	  		<fmt:parseDate value="${inquireList.createdAt}" var="createdAt" pattern="yyyy-MM-dd" />
	  	  	  		<td><fmt:formatDate value="${createdAt}" pattern="yy.MM.dd" /></td>
	  	  	  		<c:if test="${inquireList.hasAnswer eq 'Y'}">
	  	  	  		<td>답변완료</td>
	  	  	  		</c:if>
	  	  	  		<c:if test="${inquireList.hasAnswer ne 'Y'}">
	  	  	  		<td>답변대기</td>
	  	  	  		</c:if>
	  	  	  	</tr>
	  	  	  	</c:if>
	  	  	  	<tr class="tbl-toggle" style="display: none;">
	  	  	  		<td colspan="4" style="background-color: rgb(250, 250, 250);">
		  	  	  		<div class="inquire-content-container">
		  	  	  			<div class="inquire-content">
		  	  	  				<div class="Q">Q</div>
		  	  	  				<span class="inquire-q">${inquireList.content}</span>
		  	  	  				<c:if test='${inquireList.memberId eq loginMemberId}'>
		  	  	  				<button class="deleteInquire" type="button">삭제</button>
		  	  	  				</c:if>
		  	  	  			</div>
		  	  	  			<c:if test="${inquireList.directInquireAnswer.DInquireAContent ne null}">
		  	  	  			<fmt:parseDate value="${inquireList.directInquireAnswer.DInquireAnsweredAt}" var="answerCreatedAt" pattern="yyyy-MM-dd" />
		  	  	  			<div class="inquire-answer"><div class="A">A</div><span class="inquire-a">${inquireList.directInquireAnswer.DInquireAContent}</span><span class="inquire-a-answer"><fmt:formatDate value="${answerCreatedAt}" pattern="yy.MM.dd" /></span></div>
		  	  	  			</c:if>
		  	  	  		</div>
	  	  	  		</td>
	  	  	  	</tr>
  	  	  	  	</c:forEach>
	  	  	  	</c:if>
	  	  	  </tbody>
	  	  </table>
	  	</div>
	  	<nav class="inquirePageBar">
	  	${pagebar}
	  	</nav>
	  </div>
	  <div id="reviewLink" style="border-top: 1px solid #e5e7eb; background-color: #e5e7eb; margin: 65px 0;"></div>
	 <!-- 재경 시작 -->
	  <div id="dProductReview" class="dProductReview">
	  <sec:authentication property="principal" var="loginMember" scope="page"/>

	  <sec:authorize access="isAuthenticated()">
		<input type="hidden" class="d-review-login-member" data-member-id="${loginMember.memberId}"/>
	  </sec:authorize>
	  <c:if test="${empty dReviewList}">
	  	<div class="mx-auto mt-5 text-center">
	  		<span style="font-size: 20px; display: block; position: relative; padding: 20px 0 40px;">Review</span>
	  		<table id="direct-reviewList-tbl" class="table" style="text-align: center;">
		      	<colgroup>
					<col style="width: 270px">
					<col style="width: 200px">
					<col style="width: 100px">
					<col style="width: 160px">
					<col style="width: 80px">
				</colgroup>
				<thead>
					<tr>
						<th>제목</th>
						<th>옵션</th>
						<th>별점</th>
						<th>작성일</th>
						<th>추천수</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td colspan="5">
							<h3 style="margin: 60px 0;">작성한 후기가 없습니다.</h3>
						</td>
					</tr>
				</tbody>
			  </table>
		</div>
	  </c:if>
	  <c:if test="${not empty dReviewList}">	
	  <span style="font-size: 20px; display: block; position: relative; padding: 20px 0 70px;">Review</span>
      <table id="direct-reviewList-tbl" class="table" style="text-align: center;">
      	<colgroup>
			<col style="width: 270px">
			<col style="width: 200px">
			<col style="width: 100px">
			<col style="width: 160px">
			<col style="width: 80px">
		</colgroup>
		<thead>
			<tr>
				<th>제목</th>
				<th>옵션</th>
				<th>별점</th>
				<th>작성일</th>
				<th>추천수</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${dReviewList}" var="dReviewList">
				<tr class="table-active">
					<td style="text-align:left;">${dReviewList.dReviewTitle}</td>
					<td style="text-align:center;">${dReviewList.reviewOpt.DOptionName}</td>
					<td style="text-align:center;">⭐ ${dReviewList.reviewRating}</td>
					<td style="text-align:center;">
						<fmt:parseDate value="${dReviewList.dReviewCreatedAt}" pattern="yyyy-MM-dd HH:mm:ss" var="reviewDate"/>
						<fmt:formatDate value="${reviewDate}" pattern="yyyy-MM-dd"/>
					</td>
					<td style="text-align:center;">${dReviewList.dReviewRecommend}</td>
				</tr>
				<tr>
				    <td>
				    	<c:if test="${dReviewList.reviewAttach.DReviewRenamedFilename eq null}">
				    	
	    				</c:if>
				    	<c:if test="${dReviewList.reviewAttach.DReviewRenamedFilename ne null}">
				    		<img style="display: inline-block; float: left; height: 120px; margin: 0 30px; width: 120px; object-fit: contain;" src="${pageContext.request.contextPath}/resources/upload/directReviewAttach/${dReviewList.reviewAttach.DReviewRenamedFilename}" alt="" />
				    	</c:if>
				    </td>
				    <td colspan="4" style="text-align:left; vertical-align: middle;">${dReviewList.dReviewContent}</td>
				    <!-- <td><button type="button" class="btn-d-review-recommend" onclick="dReviewRecommend(); data-recommended="false">👍&nbsp추천하기<span class="d-review-recommend"></span></button></td> -->
				</tr>
			 </c:forEach>
		</tbody>
	  </table>
		<nav>
		${rPagebar}
		</nav>
	  </c:if>
	  </div>	
	  <!-- 재경 끝 -->
  </div>
</main>
<div class="enroll-inquire-modal-container"></div>
<div class="enroll-inquire-complete-container"></div>
<div class="inquire-delete-container"></div>
<div class="modal fade" id="inquire-delete-modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-dialog-centered" role="document" style="width: 330px;">
    <div class="modal-content">
      <div class="modal-body" style="display: flex; justify-content: center;">
        <p style="margin: 34px 0 12px;">상품 문의를 삭제하시겠습니까?</p>
      </div>
      <div class="modal-footer" style="justify-content: center; border-top: none;">
      	<button type="button" class="btn" data-bs-dismiss="modal" style="font-size: 16px; border: 1px solid #dee2e6;">취소</button>
        <button type="button" id="deleteInquireBtn" class="btn btn-116530" data-bs-dismiss="modal" style="font-size: font-size: 13px; background-color: #F6D860; color: #fff; border: 1px solid #F6D860;">확인</button>
      </div>
    </div>
  </div>
</div>
<div class="inquire-delete-complete-container"></div>
<script>
// 후기 추천
const dReviewRecommend = () => {	
	const loginMember = document.querySelector(".d-review-login-member");
	console.log('loginMember', loginMember);
		
	if(loginMember === null){
		alert('로그인 후 이용가능합니다.');
	}
	else{
		console.log('loginMember', loginMember.dataset.memberId);
		const memberId = loginMember.dataset.memberId;
		  
		const recommend = document.querySelector(".d-review-recommend");		
		const dReviewNo = recommend.dataset.dReviewNo;
			
		const btnRecommend = document.querySelector(".btn-d-review-recommend");
		const recommended = btnRecommend.dataset.recommended;	
			
		// 추천이 되어있는 경우 -> 추천 취소하기
		if(recommended === "true"){
			$.ajax({
				url : "${pageContext.request.contextPath}/direct/directReviewRecommendCancel.do",
				data: {memberId, dReviewNo},
				method : "POST",
				beforeSend : function(xhr){  
								xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
					       	},
				success(result){
					recommend.innerHTML = Number(recommend.innerHTML) - 1;
					btnRecommend.dataset.recommended = "false";
				},
				error : console.log
			});
		}
			
		// 추천이 안되어있는 경우 -> 추천하기
		else{
			$.ajax({
				url : "${pageContext.request.contextPath}/subscribe/subscribeReviewRecommendAdd.do",
				data: {memberId, sReviewNo},
				method : "POST",
				beforeSend : function(xhr){  
					            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				       		 },
				success(result){
					recommend.innerHTML = Number(recommend.innerHTML) + 1;
					btnRecommend.dataset.recommended = "true";
				},
				error : console.log
			});
		}
	
	}
};

//기존 버튼형 슬라이더
$('.slider-1 > .page-btns > div').click(function(){
    var $this = $(this);
    var index = $this.index();
    
    $this.addClass('active');
    $this.siblings('.active').removeClass('active');
    
    var $slider = $this.parent().parent();
    
    var $current = $slider.find(' > .slides > div.active');
    
    var $post = $slider.find(' > .slides > div').eq(index);
    
    $current.removeClass('active');
    $post.addClass('active');
});

// 좌/우 버튼 추가 슬라이더
$('.slider-1 > .side-btns > div').click(function(){
    var $this = $(this);
    var $slider = $this.closest('.slider-1');
    
    var index = $this.index();
    var isLeft = index == 0;
    
    var $current = $slider.find(' > .page-btns > div.active');
    var $post;
    
    if ( isLeft ){
        $post = $current.prev();
    }
    else {
        $post = $current.next();
    };
    
    if ( $post.length == 0 ){
        if ( isLeft ){
            $post = $slider.find(' > .page-btns > div:last-child');
        }
        else {
            $post = $slider.find(' > .page-btns > div:first-child');
        }
    };
    
    $post.click();
});

//setInterval(function(){
//    $('.slider-1 > .side-btns > div').eq(1).click();
//}, 3000);

// 로그인 확인
function checkLogin() {
	alert('로그인 후 이용해 주세요.');
	location.href = "${pageContext.request.contextPath}/member/memberLogin.do";
	return;
}

// 드롭다운
document.querySelector('.dropbtn').addEventListener('click', (e) => {
	// console.log(e.target);
    dropdown();
    
	
  });
  
  document.getElementsByClassName('select_option').onclick = (value)=>{
    showMenu();
  };
  
  dropdown = () => {
	  
    var v = document.querySelector('.dropdown-content');
    var dropbtn = document.querySelector('.dropbtn');
    v.classList.toggle('show');
    dropbtn.style.borderColor = 'rgb(94, 94, 94)';
    
  }

  showMenu=(value)=>{
    // console.log(value);
    var dropbtn_icon = document.querySelector('.dropbtn_icon');
    var dropbtn_content = document.querySelector('.dropbtn_content');
    var dropbtn_click = document.querySelector('.dropbtn_click');
    var dropbtn = document.querySelector('.dropbtn');

    dropbtn_content.style.color = 'rgba(107,114,128)';
    dropbtn.style.borderColor = 'rgb(94, 94, 94)';
    
    var dropdowns = document.getElementsByClassName("dropdown-content");

    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
    
  }

  window.onclick = (e) => {
	  if(!e.target.matches('.dropbtn') && !e.target.matches('.dropbtn_click') && !e.target.matches('.dropbtn_content')){
	      // console.log(e.target);
	      var dropdowns = document.getElementsByClassName("dropdown-content");

	      var i;
	      for (i = 0; i < dropdowns.length; i++) {
	        var openDropdown = dropdowns[i];
	        if (openDropdown.classList.contains('show')) {
	          openDropdown.classList.remove('show');
	        }
	      }
	    }
  };
  
// 판매상태 확인
const dSaleStatus = document.querySelectorAll('[name="dSaleStatus"]');
const soldout = document.querySelector('.soldout');
let soldoutAll = [];

dSaleStatus.forEach((status) => {
	soldoutAll.push(status.value);
	const target = status.previousElementSibling.previousElementSibling;
	// console.log(status.value);
	
	if(status.value !== "판매중") {
		target.children[0].style.color = 'rgb(153, 153, 153)';
		target.children[0].style.textDecorationLine = 'line-through';
		target.children[0].style.textDecorationColor = 'rgb(153, 153, 153)';
		target.children[1].innerText = '품절';
		return;
	}
});

// 전 옵션 판매마감/판매중단인 경우 옵션 선택 불가

console.log(soldoutAll);
if(soldoutAll.indexOf('판매중') == -1) {
	soldout.style.display = "inline-flex";
}
 
// 재고 확인
const dStock = document.querySelectorAll('[name="dStock"]');
dStock.forEach((stock) => {
	// console.dir(stock);
	const target = stock.previousElementSibling;
	// console.log(stock.value);
	if(Number(stock.value) === 0) {
		target.children[0].style.color = 'rgb(153, 153, 153)';
		target.children[0].style.textDecorationLine = 'line-through';
		target.children[0].style.textDecorationColor = 'rgb(153, 153, 153)';
		target.children[1].innerText = '품절';
		return;
	}
});



// 사용자가 선택한 옵션 박스 생성
document.querySelectorAll(".select_option").forEach((select) => {
	select.addEventListener('click', (e) => {
		// console.dir(select);
		const parent = e.target.parentElement;
		const optionNo = parent.dataset.optionNo;
		// console.log(optionNo);
		// console.log(select.children[0].innerHTML);
		const place = document.querySelector(".pOption-container");
		const dPOName = select.children[0].innerHTML;
		const dPrice = select.children[1].innerHTML;
		const dStock = select.nextElementSibling.value;
		// console.log(dPOName);
		const box = `
		<div id="option-box" class="option-box" data-option-no="\${optionNo}">
			<div class="option-info-wrap">
				<span class="selected-option">\${dPOName}</span>
			</div>
			<div class="option-count-wrap">
				<span class="selected-price">\${dPrice}</span>
				<input type="hidden" name="dPrice" value="\${dPrice}" />
				<input type="hidden" name="stock" value="\${dStock}" />
				<div class="option-count-box">
					<button type="button" class="option-count-minus" onclick="minusBtn(event)">-</button>
					<div class="dOptionCount" id="dOptionCount">1</div>
					<button type="button" class="option-count-plus" onclick="plusBtn(event)">+</button>
				</div>
				<button type="button" id="option-count-delete" onclick="deleteBtn(event)">x</button>
			</div>
			<sec:authorize access="isAuthenticated()">
	    		<input type="hidden" name="memberId" value='<sec:authentication property="principal.memberId"/>' />
	    	</sec:authorize>
			<input type="hidden" name="dOptionNo" value="\${optionNo}" />
			<input type="hidden" name="productCount" value="1" />
		</div>`;
		
		const optionBox = document.querySelector(`div[data-option-no="\${optionNo}"]`);
		const targetStock = Number(e.target.parentElement.nextElementSibling.value);
		const targetStatus = e.target.parentElement.nextElementSibling.nextElementSibling.value;
		
		if(!optionBox && targetStock > 0 && targetStatus === "판매중"){				
			place.insertAdjacentHTML('beforeend', box);	
		}
		else if(!optionBox && targetStatus !== "판매중"){
			alert('해당 상품은 품절되었습니다.');
		}
		else if(optionBox){
			alert('이미 추가된 옵션입니다.');
		}
		
		// 총 합계 금액
		const totalPrice = [...document.querySelectorAll('.selected-price')].map((price) => {
			return Number(price.innerHTML.replace(",","").replace("원", ""));
		}).reduce((total, price) => {
			return total + price;
		}, 0);
		document.querySelector(".total-price-num").innerHTML = totalPrice.toLocaleString('ko-KR');
	});
	
});

// 삭제 핸들러
const deleteBtn = (e) => {
	const deleteTarget = e.target.parentElement.parentElement;
	deleteTarget.remove();

	let totalPrice = totalCalc();
	totalCalc();
	// console.log(totalPrice);
	document.querySelector('.total-price-num').innerText = totalPrice.toLocaleString('ko-KR');
	
};

// 감량 핸들러
const minusBtn = (e) => {
	// console.dir(e.target);
	let countVal = Number(e.target.nextElementSibling.innerHTML);
	const count = e.target.nextElementSibling;
	const member = document.querySelectorAll("[name=memberId]");
	const inputCount = e.target.parentElement.parentElement.nextElementSibling.nextElementSibling.nextElementSibling;
	countVal--;
	if(countVal > 0) {
		count.innerHTML = countVal;
		if(member.length == 0) {
		}
		else {
			inputCount.value = countVal;
		}
	}
	else if(countVal = 1) {
		count.innerHTML = countVal;
		if(member.length == 0) {
		}
		else {
			inputCount.value = countVal;
		}
	}
	const defaultPriceVal = parseInt(e.target.parentElement.previousElementSibling.previousElementSibling.value.replace(",",""));
	// console.log(defaultPriceVal);
	const sumVal = countVal * defaultPriceVal;
	// console.log(sumVal);	
	e.target.parentElement.previousElementSibling.previousElementSibling.previousElementSibling.innerText = sumVal.toLocaleString('ko-KR') + '원';
	
	let totalPrice = totalCalc();
	totalCalc();
	// console.log(totalPrice);
	document.querySelector('.total-price-num').innerText = totalPrice.toLocaleString('ko-KR');
};

// 증량 핸들러
const plusBtn = (e) => {
	console.dir(e.target.parentElement.parentElement.previousElementSibling);
	let countVal = Number(e.target.previousElementSibling.innerHTML);
	const count = e.target.previousElementSibling;
	const member = document.querySelectorAll("[name=memberId]");
	const inputCount = e.target.parentElement.parentElement.nextElementSibling.nextElementSibling.nextElementSibling;
	const checkStock = Number(e.target.parentElement.previousElementSibling.value);
	// console.log(checkStock, typeof checkStock);
	countVal++;
	// console.log(countVal);
	if(countVal < 5) {
		if(countVal < checkStock) {
			count.innerHTML = countVal;	
			if(member.length == 0) {
			}
			else {
				inputCount.value = countVal;
			}
		}	
		else if(countVal = checkStock) {
			console.log(countVal);
			count.innerHTML = countVal;	
			if(member.length == 0) {
			}
			else {
				inputCount.value = countVal;
			}
			setTimeout(() => {
				alert('현재 주문 가능한 최대 수량입니다.');
			}, 250);
		}
	}
	else if(countVal = 5) {
		if(countVal < checkStock) {
			count.innerHTML = countVal;	
			if(member.length == 0) {
			}
			else {
				inputCount.value = countVal;
			}
		}	
		else if(countVal = checkStock) {
			console.log(countVal);
			count.innerHTML = countVal;	
			if(member.length == 0) {
			}
			else {
				inputCount.value = countVal;
			}
			setTimeout(() => {
				alert('현재 주문 가능한 최대 수량입니다.');
			}, 250);
		}
		setTimeout(() => {
		alert('최대 주문 가능 수량은 5개입니다.');
		}, 250);
	}
	const defaultPriceVal = parseInt(e.target.parentElement.previousElementSibling.previousElementSibling.value.replace(",",""));
	// console.log(defaultPriceVal);
	const sumVal = countVal * defaultPriceVal;
	// console.log(sumVal);	
	e.target.parentElement.previousElementSibling.previousElementSibling.previousElementSibling.innerText = sumVal.toLocaleString('ko-KR') + '원';
	
	let totalPrice = totalCalc();
	totalCalc();
	// console.log(totalPrice);
	document.querySelector('.total-price-num').innerText = totalPrice.toLocaleString('ko-KR');
};

// 총금액 다시 계산하기
const totalCalc = () => {
	let totalCount = 0;
	let totalPrice = 0;
	document.querySelectorAll('#dOptionCount').forEach((e) => {
		// console.dir(e);
		const count = parseInt(e.innerText);
		// console.log(count);
		totalCount += count;
		// console.log(totalCount, typeof totalCount);
		// console.log(e.parentElement.previousElementSibling);
		const price = parseInt(e.parentElement.previousElementSibling.previousElementSibling.value.replace(",",""));
		// console.log(price, typeof price);
		totalPrice += count * price;
	});
		return totalPrice;
};

// 장바구니 추가 및 주문하기
const cart = document.querySelector('#cart');
const order = document.querySelector('#order');

if(cart) {
	cart.addEventListener('click', (e) => {
		const frm = document.totalProductFrm;
		const container = document.querySelector(".pOption-container");
		const optionNo = document.querySelectorAll("[name=dOptionNo]");
		
		let optionNoList = [];
		let cartList = [];
		[...optionNo].forEach((no) => {
			console.dir(no);
			const productCount = no.nextElementSibling.value;
			const memberId = no.previousElementSibling.value;
			optionNoList.push(no.value);
			cartList.push({"dOptionNo" : no.value, "productCount" : productCount, "memberId" : memberId});
		});
		
		console.log(optionNoList);
		console.log(cartList);
		
		if(memberId && container.children.length === 0) {
			alert("옵션을 선택해 주세요.");
			return;
		}
		
		// 장바구니
		$.ajax({
			url : "${pageContext.request.contextPath}/direct/checkCartDuplicate.do",
			method : "GET",
			data : {optionNoList : optionNoList,
					memberId},
			success(response) {
				console.log(response.cartList);
				
				// 장바구니 중복 체크
				if(Array.isArray(response.cartList) && response.cartList.length === 0) {
					addCart(cartList);
				} else {
					if(confirm(`장바구니에 동일한 상품이 있습니다.
장바구니에 추가하시겠습니까?`)) {
						addCart(cartList);
					} else return;
				}
			},
			error : console.log
		});
	});
}

// 장바구니 상품 추가
const addCart = (cartList) => {
	const headers = {};
	headers['${_csrf.headerName}'] = '${_csrf.token}';
	console.log(headers);
	
	$.ajax({
		url : "${pageContext.request.contextPath}/direct/addCart.do",
		method : "POST",
		headers,
		data : JSON.stringify(cartList),
		contentType : 'application/json; charset=utf-8',
		success(response) {
			const container = document.querySelector('.modal-container');
			const modal = `
			<div class="modal fade" id="complete-modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" role="dialog">
			  <div class="modal-dialog modal-dialog-centered" role="document">
			    <div class="modal-content">
			      <div class="modal-body" style="display: flex; justify-content: center;">
			        <p style="margin:40px 0;">장바구니에 상품이 정상적으로 담겼습니다.
		        		<img src="${pageContext.request.contextPath}/resources/images/cart.png" alt="장바구니 추가" style="width: 120px; margin: 20px auto 0;">
		        	</p>
			      </div>
			      <div class="modal-footer" style="justify-content: center;">
			        <button type="button" class="btn btn-116530" onclick="goCart();" style="font-size: 13px;">장바구니로 이동</button>
			        <button type="button" class="btn btn-EA5C2B" data-bs-dismiss="modal" style="font-size: 13px; width: 118.13px;">계속 쇼핑하기</button>
			      </div>
			    </div>
			  </div>
			</div>`;
			
			container.innerHTML = modal;
			
			$('#complete-modal').modal("show");
			
		},
		error : console.log
	});
};
function goCart() {
	location.href = "${pageContext.request.contextPath}/direct/cart.do"; 
};
	
// 바로 주문
if(order) {
	order.addEventListener('click', (e) => {
		const frm = document.totalProductFrm;
		const container = document.querySelector(".pOption-container");
		
		if(memberId && container.children.length === 0) {
			alert("옵션을 선택해 주세요.");
			return;
		}
		
		frm.action = "${pageContext.request.contextPath}/direct/directOrder.do";
		frm.submit();
	});
}

// 리뷰 점수
window.addEventListener('load', (e) => {
	$.ajax({
		url : "${pageContext.request.contextPath}/direct/reviewAvgScore.do",
		method : "GET",
		data : {dProductNo : dProductNo.value},
		success(response) {
			const reviewAvgScore = response.reviewAvgScore;
			console.log(reviewAvgScore);
			document.querySelector('.reviewAvgScore').innerHTML = reviewAvgScore;
			
			const reviewStar = document.querySelector('.reviewStar');
			
			if(Number(reviewAvgScore) >= 0 && Number(reviewAvgScore) < 1) {
				reviewStar.innerHTML = (`<img src="${pageContext.request.contextPath}/resources/images/emptystar.png" alt="" />
<img src="${pageContext.request.contextPath}/resources/images/emptystar.png" alt="" />
<img src="${pageContext.request.contextPath}/resources/images/emptystar.png" alt="" />
<img src="${pageContext.request.contextPath}/resources/images/emptystar.png" alt="" />
<img src="${pageContext.request.contextPath}/resources/images/emptystar.png" alt="" />`).split("\n").join("");
			}
			else if(Number(reviewAvgScore) >= 1 && Number(reviewAvgScore) < 2) {
				reviewStar.innerHTML = (`<img src="${pageContext.request.contextPath}/resources/images/star.png" alt="" />
<img src="${pageContext.request.contextPath}/resources/images/emptystar.png" alt="" />
<img src="${pageContext.request.contextPath}/resources/images/emptystar.png" alt="" />
<img src="${pageContext.request.contextPath}/resources/images/emptystar.png" alt="" />
<img src="${pageContext.request.contextPath}/resources/images/emptystar.png" alt="" />`).split("\n").join("");
			}
			else if(Number(reviewAvgScore) >= 2 && Number(reviewAvgScore) < 3) {
				reviewStar.innerHTML = (`<img src="${pageContext.request.contextPath}/resources/images/star.png" alt="" />
<img src="${pageContext.request.contextPath}/resources/images/star.png" alt="" />
<img src="${pageContext.request.contextPath}/resources/images/emptystar.png" alt="" />
<img src="${pageContext.request.contextPath}/resources/images/emptystar.png" alt="" />
<img src="${pageContext.request.contextPath}/resources/images/emptystar.png" alt="" />`).split("\n").join("");
			}
			else if(Number(reviewAvgScore) >= 3 && Number(reviewAvgScore) < 4) {
				reviewStar.innerHTML = (`<img src="${pageContext.request.contextPath}/resources/images/star.png" alt="" />
<img src="${pageContext.request.contextPath}/resources/images/star.png" alt="" />
<img src="${pageContext.request.contextPath}/resources/images/star.png" alt="" />
<img src="${pageContext.request.contextPath}/resources/images/emptystar.png" alt="" />
<img src="${pageContext.request.contextPath}/resources/images/emptystar.png" alt="" />`).split("\n").join("");
			}
			else if(Number(reviewAvgScore) >= 4 && Number(reviewAvgScore) < 5) {
				reviewStar.innerHTML = (`<img src="${pageContext.request.contextPath}/resources/images/star.png" alt="" />
<img src="${pageContext.request.contextPath}/resources/images/star.png" alt="" />
<img src="${pageContext.request.contextPath}/resources/images/star.png" alt="" />
<img src="${pageContext.request.contextPath}/resources/images/star.png" alt="" />
<img src="${pageContext.request.contextPath}/resources/images/emptystar.png" alt="" />`).split("\n").join("");
			}
			else {
				reviewStar.innerHTML = (`<img src="${pageContext.request.contextPath}/resources/images/star.png" alt="" />
<img src="${pageContext.request.contextPath}/resources/images/star.png" alt="" />
<img src="${pageContext.request.contextPath}/resources/images/star.png" alt="" />
<img src="${pageContext.request.contextPath}/resources/images/star.png" alt="" />
<img src="${pageContext.request.contextPath}/resources/images/star.png" alt="" />`).split("\n").join("");
			}
		},
		error : console.log
	});
});

// 하단 네비게이션
const items = document.querySelectorAll('.direct-detail-nav-item');

function handleIndicator(el) {
  items.forEach(item => {
    item.classList.remove('is-active');
    item.removeAttribute('style');
  });
 
  el.classList.add('is-active');
  el.style.color = '#FF7F3F';
  el.style.backgroundColor = '#fff';
  el.style.fontWeight = 'bold';
};


items.forEach((item, index) => {
  item.addEventListener('click', (e) => { handleIndicator(e.target)});
  item.classList.contains('is-active') && handleIndicator(item);
});

// 상품문의 등록하기 폼
if(document.querySelector('#enrollInquire')) {
	document.querySelector('#enrollInquire').addEventListener('click', (e) => {
		const container = document.querySelector(".enroll-inquire-modal-container");
		const modal = `
		<div class="modal fade" id="enroll-inquire-modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" role="dialog">
		  <div style="max-width: 680px;" class="modal-dialog modal-dialog-centered" role="document">
		    <div class="modal-content">
			  <div style="padding: 10px 1rem 0px; border-bottom: none;" class="modal-header">
			  	<div style="width: 100%; display: flex; padding-bottom: 4px; border-bottom: 1px solid #dee2e6; justify-content: space-between; align-items: center;">
			        <h5 class="modal-title" id="exampleModalLabel">상품 문의하기</h5>
			        <button style="border: none; background-color: transparent; font-size: 30px; color: #333;" type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			  	</div>
		      </div>
		      <div style="padding: 12px 20px; 0">
		        <div style="width: 100%; display: flex; padding-bottom: 12px; align-items: center; justify-content: flex-start; border-bottom: 1px solid #dee2e6;">
			        <div style="display: inline-flex; width: 100px;">
			       	  <img style="width: 70px; height: 70px; display: inline-block;" src="${pageContext.request.contextPath}/resources/upload/product/${directProduct.directProductAttachments[0].DProductRenamedFilename}" alt="" /> 
			        </div>
			        <div style="display: inline;">
			        	<span>${directProduct.DProductName}</span>
			        </div>
		        </div>
		      </div>
		      <div style="padding: 0 20px 0; border-bottom: none;" class="modal-body">
		      	<div style="width: 100%; padding-bottom: 12px; border-bottom: 1px solid #dee2e6;">
			        <div style="display: flex; justify-content: flex-start; align-items: flex-start; padding: 8px 0;">
			          <div style="width: 100px;">
			        	<span style="padding-right: 65px; top: 8px; position: relative; display: inline;">제목</span>
			          </div>
			          <div style="width: 538px;">
			        	<input type="text" name="inquire_title" placeholder="제목을 입력해 주세요. (최대 30자)" style="height: 38px; width: 100%; padding: 0 5px;" maxlength="30" onkeyup="handleInputLength(this, 30)" required />
			          </div>
			        </div>
			        <div style="display: flex; justify-content: flex-start; align-items: flex-start; padding: 8px 0;">
			          <div style="width: 100px;">
				        <span style="padding-right: 65px; top: 8px; position: relative; display: inline;">내용</span>
				      </div>
			          <textarea name="inquire_content" style="width: 538px; height: 200px; padding: 9px 7px; resize: none;" maxlength="300" placeholder="내용을 입력해 주세요. (최대 300자)&#13;&#10;&#13;&#10; - Q&A는 상품에 대해 판매자에게 문의하는 게시판입니다.&#13;&#10; - 상품과 관련 없는 비방/욕설/명예훼손성 게시글 및 상품과 관련 없는 광고글 등&#13;&#10;   부적절한 게시글 등록 시 글쓰기 제한 및 게시글이 삭제 조치될 수 있습니다." onkeyup="handleInputLength(this, 300)" required></textarea>
			        </div>
			        <div style="width: 100%; padding: 8px 0;">
			        	<div style="display: inline-block; width: 100px;"></div>
			        	<label for="checkSecret">
				        	<input type="checkbox" id="checkSecret" name="check_secret" value=""/>비밀글로 문의하기
			        	</label>
			        </div>
		      	</div>
		      </div>
		      <div class="modal-footer" style="justify-content: center; border-top: none; padding: 16px 20px;">
		        <button type="button" class="btn" data-bs-dismiss="modal" style="font-size: 16px; width: 80px; border: 1px solid #dee2e6;">취소</button>
		        <button type="button" id="sbmEnroll" class="btn" data-bs-dismiss="modal" style="font-size: 16px; width: 80px; background-color: #dee2e6; color: #fff; border: 1px solid #dee2e6; cursor: default;">등록</button>
		      </div>
		    </div>
		  </div>
		</div>`;
		
		container.innerHTML = modal;
		
		$('#enroll-inquire-modal').modal("show");
		
		// 문의 등록
		document.querySelector("#sbmEnroll").addEventListener('click', (sbm) => {
		 	const headers = {};
		 	headers['${_csrf.headerName}'] = '${_csrf.token}';
		 	console.log(headers);
		 	const dProductNo = document.querySelector('#dProductNo');
		 	const memberId = document.querySelector("#memberId");
		 	const inquireTitle = document.querySelector("[name=inquire_title]");
		 	const inquireContent = document.querySelector("[name=inquire_content]");
		 	const checkSecret = document.querySelector("[name=check_secret]");
		 	
		 	if(checkSecret.checked) {
		 		checkSecret.value = 'Y';
		 	}
		 	else {
		 		checkSecret.value = 'N';
		 	}
			
		 	// 유효성 검사
		 	if(inquireTitle.value.length == 0 || inquireContent.value.length == 0) {
		 		e.preventDefault();
		 	}
		 	else {
		 		$.ajax({
			 		url : "${pageContext.request.contextPath}/direct/enrollInquire.do",
			 		method : "POST",
			 		headers,
			 		data : {dProductNo : dProductNo.value,
			 				memberId : memberId.value,
			 				inquireTitle : inquireTitle.value,
			 				content : inquireContent.value,
			 				checkSecret : checkSecret.value},
			 		success(response) {
	 					const containerCom = document.querySelector('.enroll-inquire-complete-container');
	 					const modal = `
	 					<div class="modal fade" id="inquire-complete-modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" role="dialog">
	 					  <div class="modal-dialog modal-dialog-centered" role="document" style="width: 330px;">
	 					    <div class="modal-content">
	 					      <div class="modal-body" style="display: flex; justify-content: center;">
	 					        <p style="margin: 34px 0 12px;">상품 문의가 등록되었습니다.</p>
	 					      </div>
	 					      <div class="modal-footer" style="justify-content: center; border-top: none;">
	 					        <button type="button" class="btn" data-bs-dismiss="modal" style="font-size: 13px; background-color: #F6D860; color: #fff; border: 1px solid #F6D860;" onclick="clickInquire()">확인</button>
	 					      </div>
	 					    </div>
	 					  </div>
	 					</div>`;
	 					
	 					containerCom.innerHTML = modal;
	 					
	 					inquireTitle.value = "";
	 					inquireContent.value = "";
	 					
	 					$('#inquire-complete-modal').modal("show");
			 		},
			 		error : console.log
			 	});
		 	}
		});
	});
}

// 등록 글자수 체크
function handleInputLength(el, max) {
	const targetBtn = document.querySelector('#sbmEnroll');
	
	if(el.name == "inquire_title") {
		const targetTextarea = el.parentElement.parentElement.nextElementSibling.lastElementChild;
		if(el.value.length > 0) {
			if(targetTextarea.value.length > 0) {
				targetBtn.style.border = '1px solid #F6D860';
				targetBtn.style.backgroundColor = '#F6D860';
				targetBtn.style.cursor = 'pointer';
				targetBtn.disabled = false;
			}
			if(el.value.length >= max) {
			 	el.value = el.value.substr(0, max);
			 	setTimeout(() => {
			    alert(`\${max}자 이상 작성할 수 없습니다.`);
			 	}, 50);
			}
		}
		else {
			targetBtn.style.backgroundColor = '#dee2e6';
			targetBtn.style.border = '1px solid #dee2e6';
			targetBtn.style.cursor = 'default';
			targetBtn.disabled = false;
			return false;
		}
	}
	else if(el.name == "inquire_content") {
		const targetInput = el.parentElement.previousElementSibling.lastElementChild.firstElementChild;
		if(el.value.length > 0) {
			if(targetInput.value.length > 0) {
				targetBtn.style.border = '1px solid #F6D860';
				targetBtn.style.backgroundColor = '#F6D860';
				targetBtn.style.cursor = 'pointer';
				targetBtn.disabled = false;
			}
			if(el.value.length >= max) {
			 	el.value = el.value.substr(0, max);
			 	setTimeout(() => {
			    alert(`\${max}자 이상 작성할 수 없습니다.`);
			 	}, 50);
			}
		}
		else {
			targetBtn.style.backgroundColor = '#dee2e6';
			targetBtn.style.border = '1px solid #dee2e6';
			targetBtn.style.cursor = 'default';
			targetBtn.disabled = false;
			return false;
		}
	}
}

function clickInquire (){
	location.reload();
	location.href="#inquireLink";
}
document.querySelectorAll('.page-item').forEach((click) => {
	click.addEventListener('click', (e) => {
	const dProduct = document.querySelector('#dProductNo').value;
	let cPage = e.target.innerText;
		if(e.target.parentElement.parentElement.parentElement.parentElement.className == "dProductInquire") {
			e.target.href=`?dProductNo=\${dProduct}&cPage=\${cPage}#inquireLink`;
		}
		else if(e.target.parentElement.parentElement.parentElement.parentElement.className == "dProductReview") {
			e.target.href=`?dProductNo=\${dProduct}&cPage=\${cPage}#reviewLink`;
		}
	})
})



//상품문의 토글
if(document.querySelector('.tbl-inquire')) {
	
	$(function(){
		$(".tbl-click-toggle").click(function (e){
			let target = e.target;
	  	$(target).parent().next().toggle();
	  });
	});
}

// 내 문의글 삭제
if(document.querySelector(".deleteInquire")) {
	document.querySelectorAll(".deleteInquire").forEach((no) => {
		no.addEventListener('click', (e) => {
			const dInquireNo = e.target.parentElement.parentElement.parentElement.parentElement.previousElementSibling.previousElementSibling;
			const headers = {};
			headers['${_csrf.headerName}'] = '${_csrf.token}';
			console.log(headers);
			
			$('#inquire-delete-modal').modal("show");
			
			document.querySelector('#deleteInquireBtn').addEventListener('click', (e) => {
				$.ajax({
	 				url:"${pageContext.request.contextPath}/direct/deleteInquire.do",
	 				method : "POST",
	 				headers,
	 				data : {dInquireNo : Number(dInquireNo.value)},
	 				success(response) {
	 					const containerCom = document.querySelector('.inquire-delete-complete-container');
	 					const modal = `
	 					<div class="modal fade" id="inquire-delete-complete-modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" role="dialog">
	 					  <div class="modal-dialog modal-dialog-centered" role="document" style="width: 330px;">
	 					    <div class="modal-content">
	 					      <div class="modal-body" style="display: flex; justify-content: center;">
	 					        <p style="margin: 34px 0 12px;">상품 문의가 삭제되었습니다.</p>
	 					      </div>
	 					      <div class="modal-footer" style="justify-content: center; border-top: none;">
	 					        <button type="button" class="btn" data-bs-dismiss="modal" style="font-size: 13px; background-color: #F6D860; color: #fff; border: 1px solid #F6D860;" onclick="clickInquire();">확인</button>
	 					      </div>
	 					    </div>
	 					  </div>
	 					</div>`;
	 					
	 					containerCom.innerHTML = modal;
	 					
	 					$('#inquire-delete-complete-modal').modal("show");
	 				},
	 				error : console.log
	 			});
			});
		});
	});
}	
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>