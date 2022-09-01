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

<h1>모농모농 index 페이지</h1>
<p>공통적으로 사용되는건 common.css에 구분자 생성 후 추가해주시고, 각 파트의 css, js는 따로 폴더 생성 후 작업해주세요.</p>
<p>아이디/클래스명은 btn, image 이렇게 간단하게 작업하시면 겹칠 수 있기 때문에 dir-btn, subscribe-btn 이런식으로 작성부탁드립니다.</p>
<p>아이디/클래스명 없이 a태그, p태그, form태그 이렇게 태그만 적성하지말고 *dir-btn a {} 이런식으로 2레벨 이상으로 작성해주세요(나중에 합치다보면 다른사람 css에도 적용이 되는 경우가 있습니다.)</p>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>