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
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/direct.css" />
<main>
    <div class="container">
        <section class="py-5 text-center container">
            <h3>직거래&#127805</h3>
        </section>		    
			<div class="col">
		        <div class="card card-cover h-100 overflow-hidden text-white bg-dark rounded-5 shadow-lg">
		          <div class="d-flex flex-column h-100 p-5 pb-3 text-black text-shadow-2">
		          <a id="moveToPage">
		            <h6 class="pt-5 mt-5 mb-5 display-8 lh-10"></h6>
		          </a>
		            <ul class="d-flex list-unstyled mt-auto">
		              <li class="me-auto">
		                <small></small>
		              </li>
		              <li class="d-flex align-items-center me-3">
		              	<small></small>
		              </li>
		              <li class="d-flex align-items-center">
		                <small>&nbsp;</small>
		              </li>
		            </ul>
		          </div>
		        </div>
		     </div>
		</div>
	</div>
		<p class="pagination justify-content-center"></p>
</main>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>