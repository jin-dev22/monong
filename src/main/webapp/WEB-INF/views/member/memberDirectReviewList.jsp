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
<div id="member-direct-review-list-container">
	
	<c:if test="${empty directReviewList}">
		<div class="mx-auto mt-5 text-center">
			<h3>작성한 후기가 없어요 :(</h3>
			<span>후기는 상품이 배송완료된 후에 작성할 수 있어요!</span>
		</div>
	</c:if>
	<div class="mx-auto mt-5 mb-5 text-center">
		<h3>작성 완료 후기</h3>
		
	</div>
	<table id="direct-reviewList-tbl" class="table" style="undefined;table-layout: fixed; width: 1100px">
		<colgroup>
			<col style="width: 300px">
			<col style="width: 400px">
			<col style="width: 200px">
			<col style="width: 200px">
		</colgroup>
		<thead>
		  <tr>
		    <th>상품명</th>
		    <th>제목</th>
		    <th>별점</th>
		    <th>작성일</th>
		  </tr>
		</thead>
		<tbody>
		<c:forEach items="${directReviewList}" var="reviewList">
		  <tr class="table-active">
		    <td><a class="member-mypage-color-a" href = "${pageContext.request.contextPath}/direct/directProductDetail.do?dProductNo=${reviewList.reviewProd.DProductNo}">${reviewList.reviewProd.DProductName}-${reviewList.reviewOpt.DOptionName}</a></td>
		    <td>${reviewList.dReviewTitle}</td>
		    <td>⭐ ${reviewList.reviewRating}</td>
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
		
</div>	
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>