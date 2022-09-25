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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/brandStory.css" />
<!-- 브랜드스토리 -->
<div class="story-head">
	<div class="story-head-title">
		<p>잘 자란 농산물의 1/3이 버려지고 있어요&#128549;</p>
		<div class="story-head-content">
			<p>못난이 농산물의 적절한 판로가 없어</p>
			<p>헐값에 처분되거나 폐기되는 상황입니다.</p>
			<p><span class="story-accent">모농모농</span>은 못난이 농산물들의 판로를 제공하고, 불필요한 낭비를 줄이고자 합니다.</p>
		</div>	
	</div>
	<div class="story-head-title">
		<p>이들이 못난이가 된 사연</p>
		<img src="${pageContext.request.contextPath}/resources/images/story/못난이사연이미지.JPG" alt="어글리어스-이들이 못난이가 된 사연 이미지 사용" />
	</div>
</div>

<hr />
<div class="story-middle">
	<p>못난이 채소박스 구독!</p>
	<span>이렇게 진행돼요!</span>
	<img src="${pageContext.request.contextPath}/resources/images/story/진행상태1.jpg" alt="진행1" width="640px"/>
	<img src="${pageContext.request.contextPath}/resources/images/story/진행상태2.jpg" alt="진행2" width="640px"/>
</div>

<hr />
<div class="story-footer">
	<p>모두의 미션</p>
	<p class="story-border-bottom">지속가능한 식탁을 만듭니다.</p>
	<div class="">
		<p>농산물의 폐기 문제는 지구 온난화의 원인이 되고 물과 비료, 노동 에너지의 낭비로 이어집니다.</p>
		<p>농산물들의 제 가치를 찾아, 음식물 폐기는 줄이고 친환경 땅을 늘림으로써</p>
		<p>소비자의 건강한 식탁과 미래를 위한 환경이 지속가능하게 합니다.</p>
	</div>
	<div class="story-content-grid">
		<p class="story-big">349,293kg +</p>
		<p class="story-big">259</p>
		<p class="story-big">208,508개</p>
		<p class="story-content-bg">구출한 농산물</p>
		<p class="story-content-bg">함께 하는 농가</p>
		<p class="story-content-bg">아낀 플라스틱</p>
	</div>
	<button type="button" class="btn btn-EA5C2B" onclick="location.href='${pageContext.request.contextPath}/subscribe/subscribeMain.do'">모농모농과 함께하기</button>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>