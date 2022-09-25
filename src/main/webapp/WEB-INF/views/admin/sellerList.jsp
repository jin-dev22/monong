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
<jsp:include page="/WEB-INF/views/admin/adminMyPage.jsp">
	<jsp:param name="title" value="모농모농-판매자회원관리"></jsp:param>
</jsp:include>
<div id="admin-sellerList-container" class="mt-5 mx-auto text-center">

<c:if test="${empty sellerList}">
	<div class="mx-auto mt-5 text-center">
		<h3>판매자 목록이 없어요 :(</h3>
	</div>
</c:if>

<c:if test="${not empty sellerList}">
<div id="admin-sellerList-wait-container">
	<h1>가입 대기</h1>
	<h1><strong><a href="${pageContext.request.contextPath}/admin/sellerWaitList.do">${totalWaitSeller} 명</a></strong></h1>
</div>


<c:forEach items="${sellerList}" var="sel" varStatus="vs">
	<table class="table mt-5 table-borderless">
	<colgroup>
	<col style="width: 100px">
	<col style="width: 200px">
	<col style="width: 500px">
	<col style="width: 200px">
	</colgroup>
		<thead>
		  <tr class="table-active">
		    <th>${vs.count}</th>
		    <th>${sel.memberName}</th>
		    <th>${sel.memberId}</th>
		    <th>가입승인 : ${sel.sellerInfo.sellerEnrollDate}</th>
		  </tr>
		
		</thead>
		<tbody>
		  <tr>
		    <td></td>
		    <td>주소</td>
		    <td>${sel.memberAddress}</td>
		    <td></td>
		  </tr>
		  <tr>
		    <td></td>
		    <td>연락처</td>
		    <td>${sel.memberPhone}</td>
		    <td></td>
		  </tr>
		  <tr>
		    <td></td>
		    <td>이메일</td>
		    <td>${sel.memberEmail}</td>
		    <td></td>
		  </tr>
		  <tr>
		    <td></td>
		    <td>사업자등록번호</td>
		    <td>${sel.sellerInfo.sellerRegNo}</td>
		    <td></td>
		  </tr>
		</tbody>
		
	</table>
  </c:forEach>
  <nav>
	${pagebar}
  </nav>
</c:if>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>