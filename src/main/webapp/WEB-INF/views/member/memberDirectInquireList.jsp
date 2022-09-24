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
<div id="member-directInquire-container">
	<c:if test="${empty directInqList}">
		<div class="mx-auto mt-5 text-center">
			<h3>문의하신 내역이 없어요 :(</h3>
			<span>상품 페이지에서 판매자에게 문의하실 수 있습니다</span>
		</div>
	</c:if>
	<c:if test="${not empty directInqList}">
		<div class="mx-auto mt-5 text-center">
			<h3>관리자 문의내역</h3>
		</div>
		<table class="table table-border text-center mb-0">
		<colgroup>
		<col style="width: 100px">
		<col style="width: 120px">
		<col style="width: 100px">
		<col style="width: 740px">
		</colgroup>
		<thead>
		  <tr class="table-active">
		    <td>작성일</td>
		    <td>답변상태</td>
		    <td>제목</td>
		    <td></td>
		  </tr>
		</thead>
		</table>
		<div class="accordion" id="inqList-accordion">
			<c:forEach items="${directInqList}" var="inq" varStatus="vs">
				<div class="accordion-item">
					<div class="accordion-header" id="heading${vs.count}">
						<button class="accordion-button" type="button"
							data-bs-toggle="collapse" data-bs-target="#collapse${vs.count}"
							aria-expanded="true" aria-controls="collapse${vs.count}">
							<span>
							${inq.createdAt}&emsp;&emsp;<span ${inq.hasAnswer eq 'Y' ? "class='text-success'" : "class='text-danger'"}>${inq.hasAnswer eq 'Y' ? '답변완료' : '답변 대기중'}</span>&emsp;&emsp;&emsp;&emsp;${inq.inquireTitle}</span>
						</button>
					</div>
					<div id="collapse${vs.count}" class="accordion-collapse collapse"
						aria-labelledby="heading${vs.count}"
						data-bs-parent="#inqList-accordion">
						<div class="accordion-body">
							<div class="inq-content-container inq-form-align">
								<table class="table table-borderless text-center">
									<thead>
										<tr>
											<th colspan="2">🥕문의상품 : <a
												href="${pageContext.request.contextPath}/direct/directProductDetail.do?dProductNo=${inq.DProductNo}">${inq.DProductName}</a></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td rowspan="2" class="pt-5"><strong>문의내용</strong></td>
											<td rowspan="2"><textarea name="memberId" id="memberId"
													cols="100" rows="5" style="resize: none;" readOnly>${inq.content}</textarea></td>
										</tr>
									</tbody>
								</table>
							</div>
							<br />
							<div class="inq-answer">
								<c:if test="${inq.hasAnswer eq 'Y'}">
									<div class="inq-form-align">
										<table class="table table-borderless text-center">
											<tbody>
												<tr>
													<td class="pt-5 text-success"><strong>🍃판매자 :</strong></td>
													<td colspan="2" rowspan="2"><textarea
															name="inquireAContent" id="inquireAContent" cols="100"
															rows="5" style="resize: none;" readOnly>${inq.directInquireAnswer.DInquireAContent}</textarea></td>
												</tr>
												<tr>
													<td>${inq.directInquireAnswer.DInquireAnsweredAt}</td>
												</tr>
											</tbody>
										</table>
										<input type="hidden" name="inquireNo"
											value="${inq.DInquireNo}" />
										<sec:csrfInput />
									</div>
								</c:if>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
		<nav>${pagebar}</nav>
	</c:if>

</div>
<script>
$("#lnik-dInqList").css("color","EA5C2B");
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>