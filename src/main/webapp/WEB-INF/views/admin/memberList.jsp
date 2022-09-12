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
	<jsp:param name="title" value="모농모농-일반회원관리"></jsp:param>
</jsp:include>
<div id="admin-memberList-container" class="mt-5 mx-auto text-center">
<c:forEach items="${memberList}" var="mem" varStatus="vs">
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
		    <th>${mem.memberName}</th>
		    <th>${mem.memberId}</th>
		    <th>가입일자: ${mem.memberEnrollDate}</th>
		  </tr>
		
		</thead>
		<tbody>
		  <tr>
		    <td></td>
		    <td>주소</td>
		    <td>${mem.memberAddress}</td>
		    <td></td>
		  </tr>
		  <tr>
		    <td></td>
		    <td>연락처</td>
		    <td>${mem.memberPhone}</td>
		    <td></td>
		  </tr>
		  <tr>
		    <td></td>
		    <td>이메일</td>
		    <td>${mem.memberEmail}</td>
		    <td></td>
		  </tr>
		  <tr>
		    <td></td>
		    <td>생년월일</td>
		    <td>${mem.memberBirthday}</td>
		    <td></td>
		  </tr>
		</tbody>
		
	</table>
  </c:forEach>
 </div> 
  <nav>
	${pagebar}
  </nav>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>