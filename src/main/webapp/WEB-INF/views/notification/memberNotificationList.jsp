<%@page import="com.kh.monong.member.model.dto.Member"%>
<%@page import="com.kh.monong.notice.model.dto.MessageType"%>
<%@page import="com.kh.monong.common.enums.YN"%>
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
	<jsp:param name="title" value="모농모농-알림내역"></jsp:param>
</jsp:include>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/member.css" />
<style>
input.btn-notice-moveTo{
	background-color: transparent;
    background-repeat: no-repeat;
    border: none;
    cursor: pointer;
    overflow: hidden;
    outline: none;
}
table.tbl-notification th{
	text-align:center;
}
table.tbl-notification tr>td{
	text-align:center;
}
</style>
<div id="member-notification-list-container">
	<table class="table tbl-notification">
		<thead class="thead-light">
			<tr>
				<th scope="col">알림</th>
				<th scope="col">내용</th>
				<th scope="col">발생일</th>
				<th scope="col">확인</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${not empty notificationList}">
				<c:forEach items="${notificationList}" var="notice" varStatus="vs">
					<tr>
						<td>
							<div class="notice-url${vs.count}">
								<c:choose>
									<c:when test="${notice.messageType eq MessageType.SO_STATUS}">
										정기구독
										<input type="hidden" name="url${vs.count}" value="${pageContext.request.contextPath}/member/memberSubscribeList.do"/>
									</c:when>
									<c:when test="${notice.messageType eq MessageType.DO_STATUS}">
										직거래
										<sec:authorize access="hasRole('ROLE_MEMBER')">
											<input type="hidden" name="url${vs.count}" value="${pageContext.request.contextPath}/member/memberDirectDetail.do?dOrderNo=${notice.DOrderNo}"/>
										</sec:authorize>
										<sec:authorize access="hasRole('ROLE_SELLER')">
											<input type="hidden" name="url${vs.count}" value="${pageContext.request.contextPath}/member/sellerDirectOrderList.do"/>
										</sec:authorize>
									</c:when>
									<c:when test="${notice.messageType eq MessageType.INQ_ANSWERD}">
										관리자문의
										<input type="hidden" name="url${vs.count}" value="${pageContext.request.contextPath}/member/memberInquireList.do"/>
									</c:when>
									<c:when test="${notice.messageType eq MessageType.D_INQ_ANSWERED}">
										판매자문의
										<input type="hidden" name="url${vs.count}" value="${pageContext.request.contextPath}/member/memberDirectInquireList.do"/>
									</c:when>
									<c:when test="${notice.messageType eq MessageType.NEW_D_INQ}">
										상품문의
										<input type="hidden" name="url${vs.count}" value="${pageContext.request.contextPath}/member/sellerProductQnAList.do"/>
									</c:when>
								</c:choose>
							</div>
						</td>
						<td>
						<div class="btn-notice${vs.count}">
	 						<input type="button" name="notiContent${vs.count}" class="btn-notice-moveTo" value="${notice.notiContent}" onclick="moveTo(${vs.count})"/>
							<input type="hidden" name="notiNo${vs.count}" value="${notice.notiNo}" />
						</div>
						</td>
						<td>
							<fmt:parseDate value="${notice.notiCreatedAt}" pattern="yyyy-MM-dd" var="createdAt"/>
							<fmt:formatDate value="${createdAt}" pattern="yyyy-MM-dd"/>
						</td>
						<td>
							<span class="notice-isRead${vs.count}">
								${notice.notiIsRead eq YN.N ? "미확인" : "확인"}
							</span>
							<sec:csrfInput />
						</td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
</div>
<nav>
${pagebar}
</nav>
<script>
const headers = {};
headers['${_csrf.headerName}'] = '${_csrf.token}';
console.log(headers);

function moveTo(cnt){
	const notiNo = document.querySelector(`[name=notiNo\${cnt}]`);
	const url = document.querySelector(`[name=url\${cnt}]`);
	const hasRead = document.querySelector(`.notice-isRead\${cnt}`);
	console.log(notiNo.value, url.value);
	
	$.ajax({
		url : "${pageContext.request.contextPath}/notification/memberNotificationList.do",
		method : "POST",
		headers,
		data : {notiNo:notiNo.value},
		success(result){
			hasRead.innerText = "확인";
		},
		error(jqxhr, statusText, err){
			console.log(jqxhr, statusText, err);
		}
	})

	if(confirm("페이지를 이동할까요?")){
		location.href = url.value;		
	}
}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>