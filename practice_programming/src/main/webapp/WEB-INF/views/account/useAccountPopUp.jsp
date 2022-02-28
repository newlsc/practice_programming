<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	$("#amount").focus();
});
// 엔터키 방지
$(document).keypress(function(e) { 
	if (e.keyCode == 13) e.preventDefault(); 
});
function inputNumberFormat(obj){
     obj.value = comma(uncomma(obj.value));
}
function comma(str){
     str = String(str);
     return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
} 
function uncomma(str){
     str = String(str);
     return str.replace(/[^\d]+/g, '');
}
function checkForm(){
	var id = $("#id").val();
	var type = $("#type").val();
	var amount = $("#amount").val();
	var dealAvailable = "none";
	if (type == "") {
		alert("거래 유형을 선택해주세요.");
		return false;
	}
	if (amount == "") {
		alert("금액을 입력해주세요.");
		$("#amount").focus();
		return false;
	}
	if (amount.substring(0, 1) == 0) {
		alert("올바른 금액을 입력해주세요.");
		$("#amount").focus();
		return false;
	}
	amountParsing = parseInt(amount.replace(/,/g,"")); // 금액의 콤마 제거 
	// ajax로 입출금 가능여부 확인
	$.ajax({
		url :"balanceCheck.do",
		type : "post",
		async: false,
		data : {id : id, type : type, amount : amountParsing},
		dataType : "text",
		success : function(result){
			if (result == "amountLimit") {
				alert("잔액이 1억원을 초과하게 됩니다.");
				$("#amount").focus();
				return false;
			} 
			if (result == "lackOfBalance") {
				alert("잔액이 부족합니다.");
				$("#amount").focus();
				return false;
			} 
			if (result == "tradeable") {
				dealAvailable = "available";
				updateAccount(id, type, amountParsing);
			}
		},
		error : function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	}).then(function(){
		afterUpdateAccount(dealAvailable);
	});
}
function updateAccount(id, type, amountParsing){
	var updateAccount = $("<form><form/>");
	updateAccount.attr("name", "updateAccount");
	updateAccount.attr("action", "updateAccount.do");
	updateAccount.attr("method", "post");
	updateAccount.append($("<input/>", {type : "hidden", name : "id", value : id}));
	updateAccount.append($("<input/>", {type : "hidden", name : "type", value : type}));
	updateAccount.append($("<input/>", {type : "hidden", name : "amount", value : amountParsing}));
	updateAccount.appendTo("body");
	updateAccount.submit();
}
function afterUpdateAccount(dealAvailable){
	if (dealAvailable != "available") {
		$("#amount").focus();
		return false;
	} else {
		alert("거래가 정상처리 되었습니다.");
		window.close();
		opener.parent.location.reload();
	}
}
</script>
<title>Use Account</title>
</head>
<body>
	<div>	
		<p>* 의리은행 잔액은 1억원을 넘을 수 없습니다.</p>
		<select id="type" name="type">
			<option value="">선택</option>
			<option value="입금">입금</option>
			<option value="출금">출금</option>
		</select>
		<input id="id" name="id" type="hidden" value="${id}">
		<input id="amount" name="amount" maxlength="11" type="text" placeholder="금액을 입력해주세요." onkeyup="inputNumberFormat(this)">
		<button type="button" onclick="checkForm()">확인</button>
	</div>
</body>
</html>