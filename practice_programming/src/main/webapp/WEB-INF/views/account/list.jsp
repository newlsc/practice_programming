<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- 아래 한 줄은 제이쿼리(ajax) 사용을 위한 스크립트 입니다. -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	// 아이디 없이 url로 진입 시 
	var id = $("#id").val();
	if (id == "") {
		alert("로그인 후 이용 가능합니다.");
		location.href = "main.do";
	}	
	// 계좌번호 하이픈 추가
	var raw_number = $("#account_number").text()
	$("#account_number").text(raw_number.substring(0,4)+"-"+raw_number.substring(4,7)+"-"+raw_number.substring(7,13));
	// 현재 잔액 콤마 추가 
	var current_balance = $("#current_balance").text().toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','); // 금액 콤마 처리, 더 간결한 방법이 없을까?
	$("#current_balance").text(current_balance);

	// 목록에 콤마 추가 중, 첫번 째 행만 추가되고 있음
	var amount = $("#amount").text().toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','); // 금액 콤마 처리, 더 간결한 방법이 없을까?
	var balance = $("#balance").text().toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','); // 금액 콤마 처리, 더 간결한 방법이 없을까?
	$("#amount").text(amount);
	$("#balance").text(balance);
});
function useAccount(){
// 	 window.open("useAccount.do", "useAccountPopUp", "width=600, height=500");
	var popupX = (window.screen.width / 2) - (600 / 2); // 만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
	var popupY= (window.screen.height /2) - (300 / 2); // 만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
	window.open("useAccount.do", "useAccountPopUp", 'status=no, height=300, width=600, left='+ popupX + ', top='+ popupY + ', screenX='+ popupX + ', screenY= '+ popupY);
}
</script>
<title>account list</title>
</head>
<body></br>
	<h1>계좌 이용하기</h1></br>
	<div style="text-align: right; font-size: 1.5em">
		<input type="hidden" id="id" value="${id}">
		<span>이름 : ${list[0].customer_name}</span> /
		<span>계좌번호 : </span>
		<span id="account_number">${list[0].account_number}</span> /
		<span>잔액 : </span>
		<span id="current_balance">${list[0].current_balance}</span>
		<span>원</span>
	</div></br>
	<div style="text-align: right;">
		<a id="useAccount"><button type="button" class="btn btn-outline-dark" onclick="useAccount()">입출금</button></a>
		<a href="main.do"><button class="btn btn-outline-dark">은행 홈으로</button></a>
	</div></br>	
	<table class="table table-bordered table-sm">
		<thead style="text-align: center;">
			<tr>
				<th>거래 유형</th>
				<th>거래 금액</th>
				<th>잔액</th>
				<th>거래일시</th>
			</tr>
		</thead>
		<tbody style="text-align: center;">
			<c:if test="${list != null}">
			<c:forEach items="${list}" var="list">
				<tr>
					<td>${list.type}</td>
					<td><fmt:formatNumber type="number" value="${list.amount}"></fmt:formatNumber>원</td>
					<td><fmt:formatNumber type="number" value="${list.balance}"></fmt:formatNumber>원</td>
					<td>${list.log_date}</td>
				</tr>
			</c:forEach>	
			</c:if>
		</tbody>
	</table>
	<div>
		<ul class="btn-group pagination">
			<c:if test="${pageUtil.prev}">
				<li><a class="page-link" href="list.do?no=${pageUtil.firstPage}">처음</a></li>
				<li><a class="page-link" href="list.do?no=${pageUtil.startPageNum -1}">이전</a></li>
			</c:if>
			<c:forEach begin="${pageUtil.startPageNum}" end="${pageUtil.endPageNum}" var="no">
				<c:if test="${currentPage != no}">
			 		<li><a class="page-link" href="list.do?no=${no}">${no}</a></li>
		 		</c:if>
				<c:if test="${currentPage == no}">
			 		<li><a class="page-link" style="font-weight: bold" href="list.do?no=${no}">${no}</a></li>
		 		</c:if>
			</c:forEach>
			<c:if test="${pageUtil.next}">
				<li><a class="page-link" href="list.do?no=${pageUtil.endPageNum +1}">다음</a></li>
				<li><a class="page-link" href="list.do?no=${pageUtil.lastPage}">마지막</a></li>
			</c:if>		
		</ul>
	</div>
</body>
</html>