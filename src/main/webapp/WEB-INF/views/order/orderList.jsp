<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <link rel="stylesheet" href="/resources/order/dist/css/order.css"> -->
<!-- 다음주소 -->
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
</head>
<body>

	<div class="content_area">
		<div class="content_subject">
			<span>주문현황</span>
			<div class="content_main">
				<!-- 게시물 O -->
				<c:if test="${listCheck != 'empty' }">

					<table class="order_table">
						<colgroup>
							<col width="21%">
							<col width="20%">
							<col width="20%">
							<col width="20%">
							<col width="19%%">
						</colgroup>
						<thead>
							<tr>
								<td class="th_column_1">주문 번호</td>
								<td class="th_column_2">주문 아이디</td>
								<td class="th_column_3">주문 날짜</td>
								<td class="th_column_4">주문 상태</td>
								<td class="th_column_5">취소</td>
							</tr>
						</thead>
						<c:forEach items="${list}" var="list">
							<tr>
								<td><c:out value="${list.orderId}"></c:out></td>
								<td><c:out value="${list.userid}"></c:out></td>
								<td><fmt:formatDate value="${list.orderDate}"
										pattern="yyyy-MM-dd" /></td>
								<td><c:out value="${list.orderState}" /></td>
								<td><c:if test="${list.orderState ==  '배송준비'}">
										<button class="delete_btn" data-orderid="${list.orderId}">취소</button>
									</c:if></td>
							</tr>
						</c:forEach>
					</table>
				</c:if>

				<!-- 게시물 X  -->
				<c:if test="${listCheck == 'empty'}">
					<div class="table_empty">없음</div>
				</c:if>
			</div>

			<!-- 검색 영역 -->
			<div class="search_wrap">
				<form id="searchForm" action="/orderList" method="get">
					<div class="search_input">
						<input type="text" name="keyword"
							value='<c:out value="${pageMaker.cri.keyword}"></c:out>'>
						<input type="hidden" name="pageNum"
							value='<c:out value="${pageMaker.cri.pageNum }"></c:out>'>
						<input type="hidden" name="amount" value='${pageMaker.cri.amount}'>
						<button class='btn search_btn'>검 색</button>
					</div>
				</form>
			</div>

		</div>
		<!-- 페이지 이동 인터페이스 영역 -->
		<div class="pageMaker_wrap">

			<ul class="pageMaker">

				<!-- 이전 버튼 -->
				<c:if test="${pageMaker.prev}">
					<li class="pageMaker_btn prev"><a
						href="${pageMaker.startPage - 1}">이전</a></li>
				</c:if>

				<!-- 페이지 번호 -->
				<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}"
					var="num">
					<li class="pageMaker_btn ${pageMaker.cri.pageNum == num ? "active":""}">
						<a href="${num}">${num}</a>
					</li>
				</c:forEach>

				<!-- 다음 버튼 -->
				<c:if test="${pageMaker.next}">
					<li class="pageMaker_btn next"><a
						href="${pageMaker.endPage + 1 }">다음</a></li>
				</c:if>

			</ul>

		</div>

	</div>

	<form id="moveForm" action="/orderList" method="get">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
		<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
		<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
	</form>

	<form id="deleteForm" action="/orderCancle" method="post">
		<input type="hidden" name="orderId"> <input type="hidden"
			name="pageNum" value="${pageMaker.cri.pageNum}"> <input
			type="hidden" name="amount" value="${pageMaker.cri.amount}">
		<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
		<input type="hidden" name="userid" value="${member.userid}">
	</form>
	<script>
		let searchForm = $('#searchForm');
		let moveForm = $('#moveForm');

		/* 검색 버튼 동작 */
		$("#searchForm button").on("click", function(e) {

			e.preventDefault();

			/* 검색 키워드 유효성 검사 */
			if (!searchForm.find("input[name='keyword']").val()) {
				alert("키워드를 입력하십시오");
				return false;
			}

			searchForm.find("input[name='pageNum']").val("1");

			searchForm.submit();

		});

		/* 페이지 이동 버튼 */
		$(".pageMaker_btn a").on("click", function(e) {

			e.preventDefault();

			console.log($(this).attr("href"));

			moveForm.find("input[name='pageNum']").val($(this).attr("href"));

			moveForm.submit();

		});

		$(".delete_btn").on("click", function(e) {

			e.preventDefault();

			let id = $(this).data("orderid");

			$("#deleteForm").find("input[name='orderId']").val(id);
			$("#deleteForm").submit();
		});
	</script>


</body>
</html>

<%@ include file="/WEB-INF/views/includes/footer.jsp"%>