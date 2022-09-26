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
<jsp:include page="/WEB-INF/views/admin/adminMyPage.jsp"></jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminSubscription.css" />

<div class="btn-fillter-container">
	<div>
		<button type="button" class="btn btn-116530" onclick="location.href=`${pageContext.request.contextPath}/admin/subscriptionList.do`;">전체 조회</button>
		<button type="button" class="btn btn-116530-reverse" onclick="location.href=`${pageContext.request.contextPath}/admin/subscriptionOrderList.do`;">출고 관리</button>
	</div>
	<div class="btn-fillter-wrapper">
		<div class="spinner"></div>
		<select class="form-select" aria-label="Default select example" onchange="findByQuitYn()">
			<option value="N" selected>구독중</option>
			<option value="Y">구독종료</option>
		</select>
	</div>
</div>
<div id="admin-subscriptionList-container" class="mt-5 mx-auto text-center">
<c:if test="${empty subscriptionList}">
	<span>구독중인 결과가 없어요.&#128546;</span>
</c:if>
<c:if test="${not empty subscriptionList}">
	<p style="text-align:left;">총 ${totalContent}건</p>
	<c:forEach items="${subscriptionList}" var="sub" varStatus="vs">
		<table class="table admin-subscriptionList">
			<thead>
				<tr class="admin-subscriptionList-table-header" data-subscription-no="${sub.SNo}">
					<th scope="col" colspan="2">구독번호 - ${sub.SNo}</th>
					<th scope="col">다음 결제일: ${sub.SPaymentDate}</th>
					<th scope="col">다음 배송일: ${sub.SNextDeliveryDate}</th>
				</tr>
			</thead>
			<tbody>
				<tr data-subscription-no="${sub.SNo}">
					<th scope="row" rowspan="3">${vs.count}</th>
					<td>
						정기구독박스 - 
						<c:if test="${sub.SProductCode eq 'SP1'}">싱글</c:if>
						<c:if test="${sub.SProductCode eq 'SP2'}">레귤러</c:if>
						<c:if test="${sub.SProductCode eq 'SP3'}">라지</c:if>
					</td>
					<td>
						제외채소:
						<c:if test="${sub.SExcludeVegs eq null}">없음</c:if> 
						<c:if test="${sub.SExcludeVegs ne null}">${sub.SExcludeVegs}</c:if>
					</td>
					<td>배송주기: ${sub.SDeliveryCycle}주</td>
				</tr>
				<tr data-subscription-no="${sub.SNo}">
					<td>수령자: ${sub.SRecipient}</td>
					<td>배송지: ${sub.SAddress} ${sub.SAddressEx}</td>
					<c:set value="${sub.SPhone}" var="phone"></c:set>
					<td>
						연락처: ${fn:substring(phone, 0, 3)}-****-${fn:substring(phone, 7, 11)}
					</td>
				</tr>
			</tbody>
		</table>
	</c:forEach>
</c:if>
</div> 
<nav class="pagebar">
	${pagebar}
</nav>
<script>
// 회원별 구독결제내역
const tagClickHandler = (e) => {
	const parent = e.target.parentElement;
	const subNo = parent.dataset.subscriptionNo;
	if(subNo)
		location.href = `${pageContext.request.contextPath}/admin/subscriptionListDetail.do?subNo=\${subNo}`;
};
document.querySelectorAll("[data-subscription-no]").forEach((tag) => {
	tag.addEventListener('click', tagClickHandler);
});

// 구독여부 필터링
const findByQuitYn = (num) => {
	const container = document.querySelector("#admin-subscriptionList-container"); 
	const selectOption = $(".form-select option:selected").val();
	const spinner = document.querySelector(".spinner");
	
	// 페이징용
	let cPage = num;
	const limit = 5;
	let totalPages = 0;
	
	$.ajax({
		url: `${pageContext.request.contextPath}/admin/findByQuitYn.do`,
		data: {selectOption, cPage},
		beforeSend: function(){
			spinner.innerHTML = `
				<div class="spinner-border text-warning" role="status">
				  <span class="sr-only">Loading...</span>
				</div>
			`;
		},
		success(response){
			console.log(response); // 확인용
			const {findSubscriptionList, cPage, findTotalContent} = response;
			
			// 페이징
			if(findTotalContent == 0){
				container.innerHTML = '조회결과가 없습니다.';
				$(".pagebar").html("");
				spinner.innerHTML = '';
				return;
			}
			else {
				totalPages = Math.ceil(findTotalContent / limit);
				// pageLink(현재페이지, 전체페이지, 호출할 함수 이름)
				let htmlStr = pageLink(cPage, totalPages, "findByQuitYn");
				$(".pagebar").html("");
				$(".pagebar").html(htmlStr);
			};
			
			container.innerHTML = findSubscriptionList.reduce((html, list, index) => {
				console.log(list);
				const {
					sno, spaymentDate, snextDeliveryDate, sproductCode, sexcludeVegs, sdeliveryCycle, srecipient, saddress, saddressEx, sphone
				} = list;
				const [p_yyyy, p_MM, p_dd] = spaymentDate;
				const [d_yyyy, d_MM, d_dd] = snextDeliveryDate;
				
				return `\${html}
				<table class="table admin-subscriptionList">
					<thead>
						<tr class="admin-subscriptionList-table-header">
							<th scope="col" colspan="2">구독번호 - \${sno}</th>
							<th scope="col">다음 결제일: \${p_yyyy}-\${p_MM < 10 ? '0'+p_MM : p_MM}-\${p_dd < 10 ? '0'+p_dd : p_dd}</th>
							<th scope="col">다음 배송일: \${d_yyyy}-\${d_MM < 10 ? '0'+d_MM : d_MM}-\${d_dd < 10 ? '0'+d_dd : d_dd}</th>
						</tr>
					</thead>
					<tbody>
						<tr data-subscription-no="\${sno}">
							<th scope="row" rowspan="3">\${index + 1}</th>
							<td>
								정기구독박스 - \${sproductCode == 'SP1' ? '싱글' : (sproductCode == 'SP2' ? '레귤러' : '라지')}
							</td>
							<td>
								제외채소: \${sexcludeVegs == null ? '없음' : sexcludeVegs}
							</td>
							<td>배송주기: \${sdeliveryCycle}주</td>
						</tr>
						<tr>
							<td>수령자: \${srecipient}</td>
							<td>배송지: \${saddress} \${saddressEx == null ? '' : saddressEx}</td>
							<td>연락처: \${sphone.substring(0, 3)}-****-\${sphone.substring(7, 11)}</td>
						</tr>
					</tbody>
				</table>`;
			}, '');
			spinner.innerHTML = '';
		},
		error(error){
			spinner.innerHTML = '';
		}
	});
};

function pageLink(cPage, totalPages, funName){
	cPage = Number(cPage);
	totalPages = Number(totalPages);
	let pagebarTag = "";
	const pagebarSize = 5;
	let pagebarStart = (Math.floor((cPage - 1) / pagebarSize) * pagebarSize) + 1;
	let pagebarEnd = pagebarStart + pagebarSize - 1;
	let pageNo = pagebarStart;
	
	pagebarTag += "<ul class=\"pagination justify-content-center\">\r\n";
	
	// 1. previous 
	if(pageNo == 1) {
		pagebarTag += "<li class=\"page-item disabled\">\r\n"
				+ "	      <a class=\"page-link\" href=\"#\" aria-label=\"Previous\">\r\n"
				+ "	        <span aria-hidden=\"true\">&laquo;</span>\r\n"
				+ "	        <span class=\"sr-only\">Previous</span>\r\n"
				+ "	      </a>\r\n"
				+ "	    </li>\r\n";
	}
	else {
		pagebarTag += "<li class=\"page-item\">\r\n"
				+ "	      <a class=\"page-link\" href=\'javascript:" + funName + "(" + (pageNo - 1) + ");\' aria-label=\"Previous\">\r\n"
				+ "	        <span aria-hidden=\"true\">&laquo;</span>\r\n"
				+ "	        <span class=\"sr-only\">Previous</span>\r\n"
				+ "	      </a>\r\n"
				+ "	    </li>\r\n";
	}
	
	// 2. pageNo
	while(pageNo <= pagebarEnd && pageNo <= totalPages) {
		if(pageNo == cPage) {
			pagebarTag += "<li class=\"page-item active\"><a class=\"page-link\" href=\"#\">" + pageNo + "</a></li>\r\n";
		}
		else {
			pagebarTag += "<li class=\"page-item\"><a class=\"page-link\" href=\'javascript:" + funName + "(" + pageNo + ");'>" + pageNo + "</a></li>\r\n";
		}
		pageNo++;
	}
	
	// 3. next
	if(pageNo > totalPages) {
		pagebarTag += "<li class=\"page-item disabled\">\r\n"
				+ "	      <a class=\"page-link\" href=\"#\" aria-label=\"Next\">\r\n"
				+ "	        <span aria-hidden=\"true\">&raquo;</span>\r\n"
				+ "	        <span class=\"sr-only\">Next</span>\r\n"
				+ "	      </a>\r\n"
				+ "	    </li>\r\n";
	}
	else {
		pagebarTag += "<li class=\"page-item\">\r\n"
				+ "	      <a class=\"page-link\" href=\'javascript:" + funName + "(" + pageNo + ");\' aria-label=\"Next\">\r\n"
				+ "	        <span aria-hidden=\"true\">&raquo;</span>\r\n"
				+ "	        <span class=\"sr-only\">Next</span>\r\n"
				+ "	      </a>\r\n"
				+ "	    </li>\r\n";
	}
	
	pagebarTag += "</ul>";
	return pagebarTag;
};
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>