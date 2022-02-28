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
	$("#customer_name").focus();
});
var idCheck = "unchecked"; // id 중복 확인을 위한 전역 변수 설정
var checkedId = "nothing"; // 중복 확인 후 변경을 방지하기 위한 전역 변수 설정

function characterCheck(obj){
	var regExp = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;
	if (regExp.test(obj.value)) {
		obj.value = obj.value.substring( 0 , obj.value.length - 1 ); // 입력한 특수문자 한 자리 지움 
	}
}
function numberCheck(){
	if (event.keyCode<48 || event.keyCode>57) {
		event.returnValue = false;
	}
}
function duplicatedCheck(){
	var id = $("#id").val().trim();
	if (id.length < 6 ) {
		alert("아이디는 6자 이상이어야 합니다.");
		$("#id").focus();
		return false;	
	} else {
		$.ajax({
			url : "idCheck.do",
			type : "post",
			data : {id : id},
			dadaType : "json",
			success : function(result){
				if (result.length > 5) {
					alert("사용할 수 없는 아이디입니다.")
					$("#id").focus();
				} else {
					idCheck = "checked";
					checkedId = $("#id").val();
					alert("사용 가능한 아이디입니다.");
				}
			}
		})
	}
}
function createFormCheck() {
	var nameLength = $("#customer_name").val().trim().length;
	var numberLength = $("#contact_number").val().trim().length;
	var idLength = $("#id").val().trim().length;
	var pwLength = $("#pw").val().trim().length;
	var pwCheckLength = $("#pwCheck").val().trim().length;
	var pwValue = $("#pw").val();
	var pwCheckValue = $("#pwCheck").val();
	
	if( nameLength < 2) {
		alert("이름은 두 자 이상이어야 합니다.");
		$("#customer_name").focus();
		return false;
	}
	if( numberLength < 10) {
		alert("전화번호는 10자 이상이어야 합니다.");
		$("#contact_number").focus();
		return false;
	}
	if (idLength < 6) {
		alert("아이디는 6자 이상이어야 합니다.");
		$("#id").focus();
		return false;
	}
	if (pwLength < 6) {
		alert("비밀번호는 6자 이상이어야합니다.(띄어쓰기 불가)");
		$("#pw").focus();
		return false;
	}
	if (pwValue != pwCheckValue) {
		alert("비밀번호 확인이 일치하지 않습니다.");
		$("#pw").val("");
		$("#pwCheck").val("");
		$("#pw").focus();
		return false;
	}
	if (idCheck == "unchecked") {
		alert("아이디 중복 확인 바랍니다.");
		$("#idCheck").focus();
		return false;
	}
	// 아이디 중복 후 아이디 변경 확인용
	if ($("#id").val() != checkedId) {
		alert("아이디 중복 다시 확인 바랍니다.");
		idCheck = "unchecked";
		$("#id").focus();
		return false;
	}
	alert("축하합니다. 계좌가 개설되었습니다.\n가입 축하 10,000원을 드립니다.");
	document.createForm.submit();
}
</script>


<title>의리은행 계좌 만들기</title>
</head>
<body>
	<div class="container mt-3">
		<form name="createForm" action="createAccount.do" method="post">
			<h1>의리은행 계좌 만들기</h1></br><!-- 	이메일 인증 방식 고려 중 -->
			<h5>이름</h5><p>* 2 ~ 10자 까지 작성 가능하며 특수문자 사용 불가합니다.</p>
		    <input id="customer_name" name="customer_name" type="text" class="form-control" maxlength="10" onkeyup="characterCheck(this)" onkeydown="characterCheck(this)"></br>
			<h5>전화번호</h5><p>* 번호만 입력가능합니다.</p>
		    <input id="contact_number" name="contact_number" type="text" class="form-control" maxlength="11" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"></br>
			<h5>아이디</h5><p>* 6 ~ 20자 까지 작성 가능하며 특수문자 사용 불가합니다.(아이디 중복 확인 필수)</p>
		    <input type="text" id="id" name="id" class="form-control" maxlength="20" onkeyup="characterCheck(this)" onkeydown="characterCheck(this)">
			<p><button type="button" id="idCheck" onclick="duplicatedCheck()">아이디 중복 확인</button></p>
			<h5>비밀번호</h5><p>* 6 ~ 20자 까지 작성 가능하며 특수문자 사용 허용합니다.</p>
		    <input type="password" id="pw" name="pw" class="form-control" maxlength="20"></br>
			<h5>비밀번호 확인</h5>
		    <input type="password" id="pwCheck" name="pwCheck" class="form-control" maxlength="20"></br>
	  		<a href="main.do"><button type="button" class="btn btn-outline-dark">취소</button></a>
	  		<button type="reset" class="btn btn-outline-dark">새로입력</button>
	  		<button type="button" class="btn btn-outline-dark" onclick="createFormCheck();">만들기</button>
	  	</form>
  	</div>
</body>
</html>