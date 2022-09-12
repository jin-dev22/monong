<%@page import="java.time.LocalDate"%>
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
<div id="admin-waitList-container" class="mt-5 mx-auto text-center">
<div id="admin-sellerList-wait-container">
	<h2><%=LocalDate.now()%></h2>
	<h2>현재 가입 대기 건수</h2>
	<h1><strong>${totalWaitSeller}</strong>건</h1>
	<br />
	<h2>이번 달 가입 승인 건수 <strong>${totalSellerEnroll}</strong> 건</h2>
</div>

<c:forEach items="${sellerWaitList}" var="sel" varStatus="vs">
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
		    <th>${sel.memberEnrollDate}</th>
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
		    <td rowspan="2" class="text-center">
		     <form:form name="adminSellerUpdateFrm" action="${pageContext.request.contextPath}/admin/updateSellerStatus.do" method="post" onsubmit="return confirm('승인처리 하시겠습니까?');">
		    	<input type="hidden" name="id" value="${sel.memberId}"/>
		    	<button type="submit" id="admin-sellerEnroll-ok-btn" class="btn btn-success">승인</button>
		    </form:form>
		    </td>
		  </tr>
		  <tr>
		    <td></td>
		    <td>이메일</td>
		    <td>${sel.memberEmail}</td>
		  </tr>
		  <tr>
		    <td></td>
		    <td>사업자등록번호</td>
		    <td>${sel.sellerInfo.sellerRegNo}</td>
		    <td rowspan="2" class="text-center">
		    <button id="admin-sellerEnroll-del-btn" class="btn btn-danger">거절</button>
		    </td>
		  </tr>
		  <tr>
		    <td></td>
		    <td>사업자등록증파일</td>
		    <td><a href="${pageContext.request.contextPath}/admin/fileDownload.do?no=${sel.attachment.sellerAttachNo}">${sel.attachment.renamedFilename}</a></td>
		  </tr>
		</tbody>	
	</table>
  </c:forEach>
</div>
  <nav>
	${pagebar}
  </nav>
<script>
document.querySelector
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>