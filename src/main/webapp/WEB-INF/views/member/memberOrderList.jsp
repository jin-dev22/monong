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
<div id="member-orderList-container" class="mx-auto mt-5 text-center">
<table id="member-orderList-tbl" class="table table-bordered table-striped text-center">
<thead>
  <tr>
    <td class="tg-0lax" rowspan="4">사진</td>
    <td class="tg-0pky">상품번호</td>
    <td class="tg-0lax"></td>
    <td class="tg-0lax"></td>
  </tr>
  <tr>
    <td class="tg-0pky">상품명</td>
    <td class="tg-0lax">가격</td>
    <td class="tg-0lax">후기작성</td>
  </tr>
  <tr>
    <td class="tg-0pky">옵션</td>
    <td class="tg-0lax">결제상태</td>
    <td class="tg-0lax">주문취소</td>
  </tr>
  <tr>
    <td class="tg-0pky">수량</td>
    <td class="tg-0lax"></td>
    <td class="tg-0lax"></td>
  </tr>
</thead>
</table>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>