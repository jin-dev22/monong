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
	<jsp:param name="title" value="모농모농-관리자페이지"></jsp:param>
</jsp:include>
<div id="admin-notice-week-vags-list-container" class="mx-auto mt-5 mb-5 text-center">
<c:if test="${empty noticeVegsList}">
		<div class="mx-auto text-center">
			<h3>공지 히스토리가 없어요 :(</h3>
		</div>
</c:if>
<c:if test="${not empty noticeVegsList}">
	<div class="mx-auto mt-5 mb-5 text-center">
		<h3>주간채소공지 히스토리</h3>
	</div>
	<table class="table table-border text-center">
		<colgroup>
			<col style="width:200px;" />
			<col style="width:600px;"/>
			<col style="width:150px;"/>
		</colgroup>
	<thead>
	  <tr>
	    <th>공지날짜</th>
	    <th>채소</th>
	    <th></th>
	  </tr>
	</thead>
	<tbody>
	 <c:forEach items="${noticeVegsList}" var="noticeList">
	  <tr>
	    <td>${noticeList.weekCriterion}</td>
	    <td>${noticeList.vegComposition}</td>
	    <td></td>
	  </tr>
	 </c:forEach>
	</tbody>
	</table>
	<nav>${pagebar}</nav>
</c:if>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>