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
<div id="member-direct-review-enroll-list-container">
	
	<c:if test="${empty orderProdList}">
		<br /><br />
		<div class="mx-auto mt-5 text-center">
			<h3>후기를 작성할 수 있는 상품이 없어요 :(</h3>
			<span>후기는 상품이 배송완료된 후에 작성할 수 있어요!</span>
		</div>
	</c:if>
	
	<c:if test="${not empty orderProdList}">
	<div class="mx-auto mt-5 mb-5 text-center">
		<h3>작성 가능 후기</h3>
		<span>후기는 상품 당, 한 건만 작성하실 수 있습니다 :)</span>
	</div>
	<c:forEach items="${orderProdList}" var="oList">
		<table class="table table-borderless">
			<thead>
			  <tr class="table-active">
			    <th>${oList.dOrderNo}</th>
			    <th colspan="2"></th>
			    <th>배송완료</th>
			  </tr>
			</thead>
			<tbody>
			  <tr>
			    <td rowspan="2">
			    	<img src="${pageContext.request.contextPath}/resources/upload/product/${oList.directattachs.DProductRenamedFilename}" alt="" />
		    		<c:if test="${oList.directattachs.DProductRenamedFilename eq null}">
			    		<img src="${pageContext.request.contextPath}/resources/images/logo.PNG" alt="로고"/>
			    	</c:if>
			    </td>
			    <td colspan="2"> <a href = "${pageContext.request.contextPath}/direct/directProductDetail.do?dProductNo=${oList.directProds.DProductNo}">${oList.directProds.DProductName} - ${oList.directOptions.DOptionName}</a></td>
			    <td rowspan="2">
					<a class="member-mypage-color-a" href="${pageContext.request.contextPath}/member/memberDirectReviewEnrollForm.do?dOrderNo=${oList.dOrderNo}&dOptionNo=${oList.directOptions.DOptionNo}">리뷰쓰기</a>
				</td>
			  </tr>
			  <tr>
			    <td colspan="2">수량 : ${oList.dOptionCount} 개</td>
			  </tr>
			</tbody>
		</table>
		<hr />
	</c:forEach>
	
	<nav>${pagebar}</nav>
	</c:if>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>