<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="모농모농"></jsp:param>
</jsp:include>
	<h2>관리자 문의</h2>
	회원 -> 관리자 문의하기: memberId, inquireTitle, inquireContent
	<div id="enroll-container" class="mx-auto d-flex justify-content-center">
	    <form name="inquireFrm" action="${pageContext.request.contextPath}/inquire/inquireAdmin.do" method="POST" accept-charset="UTF-8" >
            <label for="inquireTitle" class="item">제목 : </label>
            <input type="text" class="form-control item" name="inquireTitle" id="inquireTitle" required/>
            <label for="inquireContent">내용 : </label>
            <textarea name="inquireContent" class="form-control" id="inquireContent" cols="30" rows="10"  style="resize: none;" required></textarea>
            <input type="hidden" class="form-control" name="memberId" id="memberId" value='<sec:authentication property="principal.username"/>'/>
	        <sec:csrfInput />
	        <br />
	        <div class="mb-3 text-center">
				<input type="submit" class="btn btn-EA5C2B-reverse" value="제출">&nbsp;
				<input type="reset" class="btn btn-outline-success" value="취소">
			</div>
	    </form>
	</div>  
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
<script>

</script>