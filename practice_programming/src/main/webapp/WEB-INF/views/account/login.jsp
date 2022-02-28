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
<title>Account Login Page</title>
<script type="text/javascript">
$(document).ready(function(){
	$("#id").focus();
});
function loginCheck(){
	var id = $("#id").val();
	var pw = $("#pw").val();
	if (id.length == 0) {
		alert("아이디를 입력해주세요.");
		$("#id").focus();
		return false;
	}
	if (pw.length == 0) {
		alert("비밀번호를 입력해주세요.");
		$("#pw").focus();
		return false;
	} else {
		$.ajax({
			url : "loginCheck.do",
			type : "post",
			data : {id : id, pw : pw},
			dataType : "text", // 지금은 이 데이터 타입이 맞다. HashMap 이라서 그런가?
			success : function(result, status, xhr){
				if (result == "unmatch") {
					alert("아이디 또는 비밀번호가 맞지않습니다.\n다시 시도해주세요.");
					$("#id").focus();
					return false;
				} else {
					document.login.submit();
				}
			}, error : function(result, status, error){
				alert("일시적인 오류입니다. 다시 시도해주세요.");
				alert(status);
				alert(error);
			}	
		});
	}
}
function accountHome(){
	location.href = "main.do";
}
function createAccount(){
	location.href = "createForm.do";
}
</script>

</head>
<body></br>
	<h1>의리은행 로그인 페이지입니다.</h1></br>
	<form action="login.do" name="login" method="post">
		<div class="mb-3 mt-3">
		  <label for="id" class="form-label">아이디</label>
		  <input type="text" class="form-control" id="id" name="id" maxlength="20" placeholder="아이디를 입력해주세요.">
		</div>
		<div class="mb-3">
		  <label for="pw" class="form-label">비밀번호</label>
		  <input type="password" class="form-control" id="pw" name="pw" placeholder="비밀번호를 입력해주세요.">
		</div>
		<button type="button" class="btn btn-outline-dark" onclick="accountHome()">의리은행 홈</button>
		<button type="button" class="btn btn-outline-dark" onclick="createAccount()">계좌 만들기</button>
		<button type="button" class="btn btn-outline-dark" onclick="loginCheck()">로그인</button>
	</form>
</body>
</html>