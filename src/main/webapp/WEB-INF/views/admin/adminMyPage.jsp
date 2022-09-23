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
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="모농모농-관리자페이지"></jsp:param>
</jsp:include>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/admin.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<div id="admin-mypage-container" class="mx-auto mt-10 text-center">

<div id="admin-member-container" class="mx-auto row justify-content-around">
	<a class="col-3" href="${pageContext.request.contextPath}/admin/memberList.do">일반회원</a>
	<a class="col-3"href="${pageContext.request.contextPath}/admin/sellerList.do">판매자회원</a>
</div>

<nav class="nav justify-content-around mt-5 navbar" >
	<a href="${pageContext.request.contextPath}/admin/subscriptionList.do">정기구독</a>
	<a href="${pageContext.request.contextPath}/admin/directProductList.do">직거래</a>
	<div class="dropdown">
	  <button class="btn dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
	    1:1문의
	  </button>
	  <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
	    <li><a href="${pageContext.request.contextPath}/admin/adminInquireList.do?memberType=member">일반회원</a></li>
	    <li><a href="${pageContext.request.contextPath}/admin/adminInquireList.do?memberType=seller">판매자</a></li>
	  </ul>
	</div>
	<div class="dropdown">
	  <button class="btn dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
	    주간채소공지
	  </button>
	  <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
	    <li><a id="noticeWeekVegs" href="#" onclick="buildUrl();">주간채소공지하기</a></li>
	    <li><a href="${pageContext.request.contextPath}/admin/noticeWeekVegsList.do">주간채소히스토리</a></li>
	  </ul>
	</div>
	
</nav>

</div>

<hr />

<script>
const date = new Date();
date.setDate(((todaydate.getDate() - todaydate.getDay())+1)+7);
console.log(date);


let year = date.toISOString().substr(2,2);
let month = date.toISOString().substr(5,2);
let day = date.toISOString().substr(8,2);

const newDay = year+month+day;

function buildUrl(){
	let url = "<c:out value='${pageContext.request.contextPath}/admin/noticeVegs.do?weekCriterion='/>";
	let newUrl = url + newDay;
	console.log(newUrl);
	$("#noticeWeekVegs").attr("href",newUrl);
};
</script>