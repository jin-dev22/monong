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
<h1>관리자 1:1 문의</h1>
<div id="member-inquire-container">
	<c:if test="${empty inqList}">
		<div>문의 내역이 없습니다.</div>
	</c:if>
	<c:if test="${not empty inqList}">
		<div class="inquire-header"><span>제목</span><span>작성일</span><span>답변</span></div>
		<div class="accordion" id="inqList-accordion">
			<c:forEach items="${inqList}" var="inq" varStatus="vs">
				<div class="accordion-item">
				    <h2 class="accordion-header" id="heading${vs.count}">
				      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapse${vs.count}" aria-expanded="true" aria-controls="collapse${vs.count}">
				        <span>${inq.inquireTitle}</span>
						<span>${inq.inquireCreatedAt}</span>
						<span>${inq.hasAnswer eq 'Y' ? '답변완료' : '답변 대기중'}</span>
				      </button>
				    </h2>
					<div id="collapse${vs.count}" class="accordion-collapse collapse" aria-labelledby="heading${vs.count}" data-bs-parent="#inqList-accordion">
				      <div class="accordion-body">
				        <div class="inq-content-container">
				        	<span class="inq-memberId">${inq.memberId}</span> <span>${inq.inquireContent}</span>
				        </div>
				        <div class="inq-answer">
				        	<form action="" accept-charset="UTF-8">
					        	<label for="inquireAContent">관리자 : </label>
					        	<textarea name="inquireAContent" id="inquireAContent" cols="30" rows="10">${inq.inquireAnswer.inquireAContent}</textarea>
					        	<span>${inq.inquireAnswer.inquireAnsweredAt}</span>
					        	<input type="hidden" name="inquireNo" value="${inq.inquireNo}"/>
					        	<sec:csrfInput />
					        	<button type="button" name="bntSubmitAns" onclick="submitAnswer(this.form);" ${inq.hasAnswer eq 'Y' ? 'disabled' : ''}>답변등록</button>
				        	</form>
				        </div>
				      </div>
				    </div>			
				</div>
			</c:forEach>
		</div>
		<script>
		const headers = {};
		headers['${_csrf.headerName}'] = '${_csrf.token}';
		const submitAnswer = (frm) =>{
			const {inquireAContent, inquireNo, bntSubmitAns} = frm;
			console.log(inquireAContent.value, inquireNo.value, bntSubmitAns);
			
			if(confirm("답변을 등록하시겠습니까?")){
				$.ajax({
					url : "${pageContext.request.contextPath}/admin/inquireAnswer.do",
					method : "POST",
					data : {inquireAContent : inquireAContent.value, inquireNo : inqureNo.value},
					success(result){
						console.log(result);
						if(result > 0){
							bntSubmitAns.disabled = true;
							//해보고 내용 남아있는지 확인하기
						}
						
					},
					error(jqxhr, statusText, err){
						console.log(jqxhr, statusText, err);
					}
				});
			}
		};
		</script>
	</c:if>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>