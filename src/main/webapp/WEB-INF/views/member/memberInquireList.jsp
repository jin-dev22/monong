<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<sec:authorize access="isAuthenticated() && !hasRole('ROLE_SELLER')">
	<jsp:include page="/WEB-INF/views/member/memberMyPage.jsp"></jsp:include>
</sec:authorize>
<sec:authorize access="hasRole('ROLE_SELLER')">
	<jsp:include page="/WEB-INF/views/member/sellerMyPage.jsp"></jsp:include>
</sec:authorize>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/inquire/inquireAccordion.css" />
<div id="member-inquire-container">
	<c:if test="${empty inqList}">
		<div class="mx-auto mt-5 text-center">
			<h3>문의하신 내역이 없어요 :(</h3>
			<span>아래 '문의하기' 에서 관리자에게 문의하실 수 있습니다</span>
		</div>
	</c:if>
	<c:if test="${not empty inqList}">
		<div class="mx-auto mt-5 mb-5 text-center">
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
			<c:forEach items="${inqList}" var="inq" varStatus="vs">
				<div class="accordion-item">
				    <div class="accordion-header" id="heading${vs.count}">
				      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapse${vs.count}" aria-expanded="true" aria-controls="collapse${vs.count}">
				        <span>${inq.inquireCreatedAt}&emsp;&emsp;&emsp;<span ${inq.hasAnswer eq 'Y' ? "class='text-success'" : "class='text-danger'"}>${inq.hasAnswer eq 'Y' ? '답변완료' : '답변 대기중'}</span>&emsp;&emsp;&emsp;&emsp;${inq.inquireTitle}</span>
				      </button>
				    </div>
					<div id="collapse${vs.count}" class="accordion-collapse collapse" aria-labelledby="heading${vs.count}" data-bs-parent="#inqList-accordion">
				      <div class="accordion-body">
				        <div class="inq-content-container inq-form-align">
				        	<table class="table table-borderless text-center">
								<tbody>
								  <tr>
								    <td rowspan="2" class="pt-5"><strong>🥕${inq.memberId} :</strong></td>
								    <td rowspan="2"><textarea name="memberId" id="memberId" cols="100" rows="5" style="resize: none;" readOnly>${inq.inquireContent}</textarea></td>
								  </tr>
								</tbody>
							</table>
				        </div>
				        <br />
				        <div class="inq-answer">
				    		<c:if test="${not empty inq.inquireAnswer.inquireANo}">
				        		<div class="inq-form-align">
					        		<table class="table table-borderless text-center">
									<tbody>
									  <tr>
									    <td class="pt-5 text-success"><strong>🍃관리자 :</strong></td>
									    <td colspan="2" rowspan="2"><textarea name="inquireAContent" id="inquireAContent" cols="100" rows="5" style="resize: none;" readOnly>${inq.inquireAnswer.inquireAContent}</textarea></td>
									  </tr>
									  <tr>
									    <td>${inq.inquireAnswer.inquireAnsweredAt}</td>
									  </tr>
									</tbody>
									</table>
									</div>
							        	<input type="hidden" name="inquireNo" value="${inq.inquireNo}"/>
							        	<sec:csrfInput />
				    		</c:if>
				        </div>
				      </div>
				    </div>			
				</div>
			</c:forEach>
		</div>
		<nav>
			${pagebar}
		</nav>
	</c:if>
</div>
<script>	
	$("#lnik-inqList").css("color","EA5C2B")
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>