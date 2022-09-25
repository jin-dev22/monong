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
<jsp:include page="/WEB-INF/views/member/sellerMyPage.jsp"></jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/inquire/inquireAccordion.css" />
<div id="member-inquire-container">
	<c:if test="${empty inqList}">
		<div class="mx-auto mt-5 text-center">
			<h3>문의 내역이 없어요 :(</h3>
		</div>
	</c:if>
	<c:if test="${not empty inqList}">
		<div class="mx-auto mt-5 mb-5 text-center">
			<h3>판매자 1:1문의내역</h3>
		</div>
		<table class="table table-border text-center mb-0">
		<colgroup>
		<col style="width: 150px">
		<col style="width: 120px">
		<col style="width: 150px">
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
				      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse${vs.count}" aria-expanded="true" aria-controls="collapse${vs.count}">
				        <span>${inq.createdAt}&emsp;&emsp;&emsp;<span ${inq.hasAnswer eq 'Y' ? "class='text-success'" : "class='text-danger'"}>${inq.hasAnswer eq 'Y' ? '답변완료' : '답변 대기중'}</span>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;${inq.inquireTitle}</span>
				      </button>
				    </div>
					<div id="collapse${vs.count}" class="accordion-collapse collapse" aria-labelledby="heading${vs.count}" data-bs-parent="#inqList-accordion">
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
								    <td rowspan="2" class="pt-5"><strong>🥕${inq.memberId} :</strong></td>
								    <td rowspan="2"><textarea name="memberId" id="memberId" cols="100" rows="5" style="resize: none;" readOnly>${inq.content}</textarea></td>
								  </tr>
								</tbody>
							</table>
			        	</div>
				        <br />
				        <div class="inq-answer px-4">
				        	<form action="" accept-charset="UTF-8">
				        		<div class="inq-form-align">
					        		<div class="inq-form-align">
							        	<label for="dInquireAContent" class="text-success">🍉<sec:authentication property="principal.username"/> :&nbsp;</label>
							        	<textarea name="dInquireAContent" id="dInquireAContent" cols="80" rows="10" style="resize: none;">${inq.directInquireAnswer.DInquireAContent}</textarea>
					        		</div>
									<div class="px-2 d-flex flex-column justify-content-space-between">
							        	<span>${inq.directInquireAnswer.DInquireAnsweredAt}</span>
							        	<input type="hidden" name="dInquireNo" value="${inq.DInquireNo}"/>
							        	<input type="hidden" name="memberId" value="${inq.memberId}"/>
							        	<input type="hidden" name="notiContent" value="${inq.inquireTitle}"/>
							        	<sec:csrfInput />
							        	<br />
							        	<button type="button" name="bntSubmitAns" class="btn btn-EA5C2B-reverse inquire-answer-btn" onclick="submitAnswer(this.form);" ${inq.hasAnswer eq 'Y' ? 'disabled' : ''}>답변등록</button>
									</div>
				        		</div>
				        	</form>
				        </div>
				      </div>
				    </div>			
				</div>
			</c:forEach>
			<nav>
			${pagebar}
			</nav>
		</div>
		<script>
		const headers = {};
		headers['${_csrf.headerName}'] = '${_csrf.token}';
		const submitAnswer = (frm) =>{
			const {dInquireAContent, dInquireNo, memberId, notiContent, bntSubmitAns} = frm;
			console.log(dInquireAContent.value, dInquireNo.value, memberId.value, notiContent.value, bntSubmitAns);
			
			if(confirm("답변 등록시 수정/삭제할 수 없습니다. 등록하시겠습니까?")){
				$.ajax({
					url : "${pageContext.request.contextPath}/member/sellerProductQnAList.do",
					headers,
					method : "POST",
					data : {dInquireAContent : dInquireAContent.value, dInquireNo : dInquireNo.value, 
						memberId : memberId.value, notiContent:notiContent.value},
					success(result){
						console.log(result);
						if(result > 0){
							bntSubmitAns.disabled = true;
						}
						
					},
					error(jqxhr, statusText, err){
						console.log(jqxhr, statusText, err);
					}
				});
			}
		};
		
		$("#lnik-dInqList").css("color","EA5C2B");
		</script>
	</c:if>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>