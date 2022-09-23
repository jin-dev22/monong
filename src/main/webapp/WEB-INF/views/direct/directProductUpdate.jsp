<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<!-- include summernote css/js-->
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.js"></script>
<!-- include summernote-ko-KR -->
<script src="/resources/js/summernote-ko-KR.js"></script>​
<style>
div#enroll-container{
    margin: 50px auto;
    width: fit-content;
 }

 #enroll-container .enroll-info-btn{
    margin-left: 15px;
 } 
 .enroll-info-container{
    width: 600px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 15px 0;
 }
 
 .enroll-info-label{
    display: inline-block;
    text-align: left;
    width: 150px;
    font-weight: bold;
 }

 .enroll-info{
    display: flex;
    align-items: center;
    width: 300px;
 }
 
 .enroll-info-file{
    display: flex;
    align-items: center;
    width: 300px;
 }

 .enroll-info input{
    width: 300px;
 }
 
 .enroll-form-required{
	color: red;
}

#DProductContent-container{
	width: 600px;
}
.delFiles-container{
	overflow-x: auto;
	width: 300px;
}

div.option-row{
	height: 30px;
	display: flex;
	width: 500px;
	
}
label.optName-label{
	width:50px;
}
div.option-row input.update-dStock{
	width: 50px;
}
div.opntion-list-container{
	/* display: flex;
	align-items: center; */
}
div.note-toolbar {
   /*  position: relative; */
    z-index: 0;
}
</style>
<div id="enroll-container" class="mx-auto text-center">
<sec:authentication property="principal" var="loginMember"/>
<c:if test="${loginMember.memberId eq prod.memberId}">
	<form name="productUpdateFrm" action="${pageContext.request.contextPath}/direct/directProductUpdate.do" method="POST" accept-charset="UTF-8" enctype="multipart/form-data">
        <input type="hidden" name="dProductNo" value="${prod.DProductNo}"/>
        <div class="mx-auto">
        	<div class="enroll-info-container">
        		<span class="enroll-info-label">판매자</span>
        		<span class="enroll-info">
        			<span id="memberId-container">
                    	<input type="text" class="form-control" name="memberId" value="${loginMember.memberId}" readonly required>
                    </span>
        		</span>
        	</div>
        	<div class="enroll-info-container">
        		<span class="enroll-info-label">상품명<span class="enroll-form-required">*</span></span>
        		<span class="enroll-info">
        			<span id="DProductName-container">
                    	<input type="text" class="form-control" name="DProductName" id="DProductName" value="${prod.DProductName}" readonly required>
                    </span>
        		</span>
        	</div>
        	<div class="enroll-info-container">
        		<span class="enroll-info-label"><label for="upFile">기존파일</label></span>
        		<span class="delFiles-container">
	        		<c:forEach items="${prod.directProductAttachments}" var="attach" varStatus="vs">
						<label class="btn btn-outline-danger" title="삭제"> 
							<img src="${pageContext.request.contextPath}/resources/upload/product/${attach.DProductRenamedFilename}" style="width:50px;" alt="" />
							<input type="checkbox" name="delFileNo" class="btn btn-outline-danger chk-delfile" id="delFileNo${vs.count}"
								value="${attach.DProductAttachNo}">삭제
						</label>
	        		</c:forEach>
           		</span>
           </div>
        	<div class="enroll-info-container">
        		<span class="enroll-info-label"><label for="upFile">상품 사진</label></span>
        		<span class="enroll-info">
        			<span id="file-container">
           			<input class="form-control" name="upFile" type="file" id="upFile1">
           			<input class="form-control" name="upFile" type="file" id="upFile2">
           			<input class="form-control" name="upFile" type="file" id="upFile3">
           			<input class="form-control" name="upFile" type="file" id="upFile4">
           			</span>
           		</span>
           </div>
           
           <div class="enroll-info-container">
        		<span class="enroll-info-label">상품 상세 설명<span class="enroll-form-required">*</span></span>
       			<span class="enroll-info">
       				<span id="DProductContent-container">
                       	<textarea name="DProductContent" id="summernote"></textarea>
                       </span>
       			</span>
        	</div>
        	<div class="enroll-info-container">
        		<span class="enroll-info-label">상품 가격<span class="enroll-form-required">*</span></span>
        		<span class="enroll-info">
        			<span id="DDefaultPrice-container">
                    	<input type="text" maxlength="10" onkeyup="inputNumberFormat(this);" 
                    			class="form-control price" name="DDefaultPrice" id="DDefaultPrice" 
                    			value="<fmt:formatNumber value="${prod.DDefaultPrice}" pattern="#,###" />" required>
                    </span>
        		</span>
        	</div>
        	<div class="enroll-info-container">
        		<span class="enroll-info-label">배송비<span class="enroll-form-required">*</span></span>
        		<span class="enroll-info">
        			<span id="DDeliveryFee-container">
                    	<input type="text" maxlength="10" class="form-control price" name="DDeliveryFee" id="DDeliveryFee" 
                    			value="<fmt:formatNumber value="${prod.DDeliveryFee}" pattern="#,###" />" readOnly required>
                    </span>
        		</span>
        	</div>
		</div>
		<div class="enroll-info-container">
	   		<span class="enroll-info-label">상품 옵션</span>
    	 		<div class="opntion-list-container">
     			<c:forEach items="${prod.directProductOptions}" var="opt" varStatus="vStatus">
     				<div class="option-one">
	     				<div class="option-row">
		      				<label for="dOptionName${vStatus.count}" class="optName-label">옵션${vStatus.count}</label>
		    	   			<input type="text" name="directProductOptions[${vStatus.index}].dOptionName" 
		    	   					id="dOptionName${vStatus.count}" value="${opt.DOptionName}" readOnly/> 
	     				</div>
	     				<div class="option-row">
							<span>가격 </span>
							<input type="text" name="directProductOptions[${vStatus.index}].dPrice" 
									maxlength="10" onkeyup="inputNumberFormat(this);"
									class="price" value="<fmt:formatNumber value="${opt.DPrice}" pattern="#,###" />" />
	     				</div>
	     				<div class="option-row">
							<label for="dStock${vStatus.count}">수량</label>
							<input type="number" min="0" name="directProductOptions[${vStatus.index}].dStock" class="update-dStock" 
									id="dStock${vStatus.count}" value="${opt.DStock}" onchange="checkStatus(this)"/>
			       			<select name="directProductOptions[${vStatus.index}].dSaleStatus" id="direct-saleStatus${vStatus.count}">
								<option value="판매중" ${opt.DSaleStatus eq '판매중' ? 'selected' : ''}>판매중</option>
								<option value="판매중단" ${opt.DSaleStatus eq '판매중단' ? 'selected' : ''}>판매중단</option>
								<option value="판매마감" ${opt.DSaleStatus eq '판매마감' ? 'selected' : ''}>판매마감</option>
							</select>
							<input type="hidden" name="directProductOptions[${vStatus.index}].dOptionNo" value="${opt.DOptionNo}" />
							<%-- <input type="hidden" name="directProductOptions[${vStatus.index}].dProductNo" value="${prod.DProductNo}"/> --%>
	     				</div>
	    				<br />
	    				<span class="vStatus" style="display: none">${vStatus.count}</span>
     				</div>
     			</c:forEach>
     		</div>
        </div>
   			<button type="button" onclick="addOption(this.form)">옵션추가</button>
   			<button type="button" onclick="delOption(this.form)">옵션삭제</button>
		<sec:csrfInput />
        <div class="enroll-info-container">
	        <input type="submit" class="btn btn-EA5C2B" value="상품 수정">&nbsp;
	        <input type="reset" class="btn btn-116530" value="취소">
        </div>
		<sec:csrfInput />
	</form>
</c:if>
<c:if test="${not(loginMember.memberId eq prod.memberId)}">
	<h2>올바른 접근이 아닙니다.</h2><!-- 판매글 작성자가 아닌 다른 계정이 url로 접속할 경우 대비 -->
</c:if>
</div>

<script>
/**
 * 제출 전 검사
 */
document.querySelector('[name="productUpdateFrm"]').addEventListener('submit', (e)=>{
	e.preventDefault();
	const frm = e.target;
	const price = frm.querySelectorAll(".price");
	price.forEach((elem)=>{
		let str = elem.value;
		elem.value = uncomma(str);
		//console.log(elem.value);	
	});
	
	const oldFileCnt = frm.querySelectorAll(".chk-delfile").length;
	const delChkdCnt = frm.querySelectorAll(".chk-delfile:checked").length;
	const upFiles = Array.from(frm.querySelectorAll("[name=upFile]"));
	const upFileCnt = upFiles.reduce((cnt, elem) => {
		console.log(elem.value);
		if(elem.value){
			cnt++;
		}
		return cnt;
	}, 0);
	const allcnt = upFileCnt + oldFileCnt - delChkdCnt;

	if(allcnt == 0){
		alert("상품사진 파일은 하나이상 있어야 해요.");
		window.scrollTo(0,0);
		return;
	}	
	if(allcnt > 4){
		alert("상품사진은 최대 4개까지 등록할 수 있어요.");
		window.scrollTo(0,0);
		return;
	}
	
	frm.submit();
});

/**
 * 재고 0 이상입력시 판매마감(품절) 상태인지 확인 후 변경처리.
 * 재고 0 입력시 판매마감 상태로 자동변경
 */
function checkStatus(stock){
//	console.log(stock.value);
	const $select = $(stock).next();
	const status = $select.val();
	if(stock.value > 0 && status == "판매마감"){
		alert("입력 수량이 0이상인 경우 자동으로 판매중 상태로 변경돼요. 꼭 판매상태를 확인해 주세요!");
		$select.val("판매중");
	}else if(stock.value == 0 && status != "판매마감"){
		alert("입력 수량이 0인 경우 자동으로 판매마감 상태로 변경돼요. 꼭 수량을 확인해 주세요!");
		$select.val("판매마감");
		
	}
//	console.log($select.val());
}

/**
 * 가격입력 세자리 콤마 텍스트 <-> 문자열 변환함수
 */
function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

function uncomma(str) {
    str = String(str);
    return str.replace(/[^\d]+/g, '');
} 

function inputNumberFormat(obj) {
    obj.value = comma(uncomma(obj.value));
}

function onlynumber(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g,'$1');
}

const vStatusCnt = parseInt(document.querySelector(".option-one:last-child").querySelector(".vStatus:last-child").innerText);
let newOptCnt = 1;
/**
 * 추가한 옵션 삭제 메소드
 */
function delOption(optList){
	const lastOne = document.querySelector(".option-one:last-child");
	const delCnt = parseInt(lastOne.querySelector(".vStatus").innerText);
	console.log(lastOne, delCnt);
	if(delCnt > vStatusCnt){
		lastOne.remove();
		newOptCnt--;		
	}else{
		alert("기존 옵션은 삭제하실 수 없습니다.");
	}
}
/**
 * 옵션 추가 메소드
 */
function addOption (optList)  {
	console.log(optList);
	const lastOne = document.querySelector(".option-one:last-child");
	const cnt = vStatusCnt + newOptCnt;
	newOptCnt++;
	
	html= `<div class="option-one">
			<div class="option-row">
			<label for="dOptionName\${cnt}" class="optName-label">옵션\${cnt}</label>
			<input type="text" name="directProductOptions[\${cnt-1}].dOptionName" id="dOptionName\${cnt}" value=""/> 
		</div>
		<div class="option-row">
		<span>가격 </span>
		<input type="text" name="directProductOptions[\${cnt-1}].dPrice" 
			 maxlength="10" onkeyup="inputNumberFormat(this);"
			 class="price" value=""/>
		</div>
		<div class="option-row">
		<label for="dStock\${cnt}">수량</label>
		<input type="number" min="0" name="directProductOptions[\${cnt-1}].dStock" class="update-dStock" id="dStock\${cnt}"  
				onchange="checkStatus(this)" value=""/>
			<select name="directProductOptions[\${cnt-1}].dSaleStatus" id="direct-saleStatus\${cnt}">
			<option value="판매중" selected>판매중</option>
			<option value="판매중단">판매중단</option>
			<option value="판매마감">판매마감</option>
		</select>
		</div>
	<br />
	<span class="vStatus" style="display: none">\${cnt}</span>
	</div>`;
	$(lastOne).after(html);
}

document.querySelectorAll("[name=upFile]").forEach((input) => {
	input.addEventListener("change", (e) => {
		const {files} = e.target;
		const label = e.target.nextElementSibling;
		if(files[0]){
			label.textContent = files[0].name;	
		}
		else {
			label.textContent = "파일을 선택하세요";
		}
	});
});
$(document).ready(function() {
	  $('#summernote').summernote({
	        minHeight: 370,
	        maxHeight: null,
	        disableResizeEditor: true,
	        lang : 'ko-KR'
	  });

	  $("#summernote").summernote('code',  '${prod.DProductContent}');
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>