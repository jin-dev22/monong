﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
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
            <div style="background-image:url(${pageContext.request.contextPath}/resources/upload/product/${directProduct.directProductAttachments[1].DProductRenamedFilename});background-size: cover;background-position: center;"> </div>
        </c:if>
        <c:if test="${not empty directProduct.directProductAttachments[3].DProductRenamedFilename}">
            <div style="background-image:url(${pageContext.request.contextPath}/resources/upload/product/${directProduct.directProductAttachments[1].DProductRenamedFilename});background-size: cover;background-position: center;"> </div>
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
	    	<button type="button" class="btn-add-cart btn-116530" id="cart">장바구니</button>
	    </sec:authorize>
	    <sec:authorize access="isAnonymous()">
	    	<button type="button" class="btn-add-order btn-EA5C2B" id="order" onclick="checkLogin();">주문하기</button>
	    </sec:authorize>
	    <sec:authorize access="isAuthenticated()">
	    	<button type="button" class="btn-add-order btn-EA5C2B" id="order">주문하기</button>
	    </sec:authorize>
	</div>
	<div class="modal-container"></div>
  </div>
  <div class="direct-footer-container">
  	  <div style="border-top: 1px solid #e5e7eb; background-color: #e5e7eb;"></div>
  	  <nav class="direct-detail-nav">
		  <div id="info" class="direct-detail-nav-item is-active">상품 정보</div>
		  <div id="inquire" class="direct-detail-nav-item">상품 문의</div>
		  <div id="review" class="direct-detail-nav-item">이용 후기</div>
	  </nav>
	  <div style="border-top: 1px solid #EA5C2B; background-color: #EA5C2B;"></div>
	  <div class="dProductContent">
	  	${directProduct.DProductContent}
	  </div>
	  <div class="dProductInquire">
	  야호야호야호야 이건 문의
	  </div>
	  <!-- 재경 시작 -->
	  <div class="dProductReview"></div>
	  <!-- 재경 끝 -->
	  
  </div>
</main>
<script>
// 재경 시작
document.querySelector("#review").addEventListener('click', (e) => {
	$.ajax({
		url : "${pageContext.request.contextPath}/direct/directProductList.do",
		success(data){
			console.log(data);
			const {dReviewTitle, dOptionName, reviewRating, dReviewCreatedAt, dReviewContent} = data;
			
			const wrapper = document.querySelector(".dProductReview");
			wrapper.innerHTML = `
			
			<c:if test="${empty dReviewList}">
				<div class="mx-auto mt-5 text-center">
					<h3>작성한 후기가 없어요 :(</h3>
				</div>
			</c:if>
			<c:if test="${not empty dReviewList}">	
				<table id="direct-reviewList-tbl" class="table" style="undefined;table-layout: fixed; width: 1100px">
					<colgroup>
						<col style="width: 300px">
						<col style="width: 400px">
						<col style="width: 200px">
						<col style="width: 200px">
					</colgroup>
					<thead>
					  <tr>
					    <th>제목</th>
					    <th>옵션</th>
					    <th>별점</th>
					    <th>작성일</th>
					  </tr>
					</thead>
					<tbody>
					<c:forEach items="${dReviewList}" var="dReviewList">
					  <tr class="table-active">
					    <td><a class="member-mypage-color-a" href = "${pageContext.request.contextPath}/direct/directProductDetail.do?dProductNo=${reviewList.reviewProd.DProductNo}">${reviewList.reviewProd.DProductName}-${reviewList.reviewOpt.DOptionName}</a></td>
					    <td>${dReviewList.dReviewTitle}</td>
					    <td>⭐ ${dReviewList.reviewRating}</td>
					    <td>
					    	<fmt:parseDate value="${reviewList.dReviewCreatedAt}" pattern="yyyy-MM-dd HH:mm:ss" var="reviewDate"/>
							<fmt:formatDate value="${reviewDate}" pattern="yyyy-MM-dd"/>
					    </td>
					  </tr>
					  <tr>
					    <td rowspan="2">
					    	<c:if test="${reviewList.reviewAttach.DReviewRenamedFilename == null}">
					    		
					    	</c:if>
					    	<c:if test="${reviewList.reviewAttach.DReviewRenamedFilename != null}">
					    		<img src="${pageContext.request.contextPath}/resources/upload/directReviewAttach/${reviewList.reviewAttach.DReviewRenamedFilename}" alt="" />
					    	</c:if>
					    </td>
					    <td colspan="2" rowspan="2">${reviewList.dReviewContent}</td>
					    <td>
							<button class="btn btn-116530" onclick="location.href='${pageContext.request.contextPath}/member/memberDirectReviewUpdateForm.do?dReviewNo=${reviewList.dReviewNo}'">수정</button>
					    </td>
					  </tr>
					  <tr>
					    <td>
					    <form:form
					    	action="${pageContext.request.contextPath}/member/deleteDirectReview.do">
					    	<input type="hidden" name="dReviewNo" value="${reviewList.dReviewNo}" />
						    <button type="submit" class="btn btn-danger" onclick="return confirm('리뷰를 삭제하시겠습니까?')">삭제</button>
					    </form:form>
					    </td>
					  </tr>
					 </c:forEach>
					</tbody>
					</table>
					<nav>
						${pagebar}
					</nav>
				</c:if>
			</div>	
			`;
			
		},
		error : console.log
	});
});
// 재경 끝

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
			
			container.insertAdjacentHTML('beforeend', modal);
			
			$('#complete-modal').modal("show");
			
		},
		error : console.log
	});
};
function goCart() {
	location.href = "${pageContext.request.contextPath}/direct/cart.do"; 
};
	
// 바로 주문
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
			else if(Number(reviewAvgScore) = 5) {
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


const detailNav= document.querySelectorAll(".direct-detail-nav-item");
detailNav.forEach((nav) => {
	nav.addEventListener('click', (e) => {
		const info = document.querySelector('.dProductContent');
		const inquire = document.querySelector('.dProductInquire');
		const review = document.querySelector('.dProductReview');
		
		if(e.target.id == "info") {
			info.style.display = 'block';
			inquire.style.display = 'none';
			review.style.display = 'none';
		}
		if(e.target.id == "inquire") {
			info.style.display = 'none';
			inquire.style.display = 'block';
			review.style.display = 'none';
		}
		if(e.target.id == "review") {
			info.style.display = 'none';
			inquire.style.display = 'none';
			review.style.display = 'block';
		}
	});
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>