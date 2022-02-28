<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<title>Account Main Page</title>
<script type="text/javascript">
function logout(){
	alert("안전하게 로그아웃 되었습니다.");
}
</script>

</head>
<body></br>
	<h1>안녕하세요, 의리은행입니다.</h1></br>
	
	<c:if test="${id == null}">
		<a href="loginForm.do"><button class="btn btn-outline-dark">로그인</button></a>
		<a href="createForm.do"><button class="btn btn-outline-dark">계좌 만들기</button></a>
	</c:if>
	<c:if test="${id != null}">
		<a href="list.do"><button class="btn btn-outline-dark">계좌 이용하기</button></a>
		<a href="logout.do"><button class="btn btn-outline-dark" onclick="logout()">로그아웃</button></a>
	</c:if>
	<a href="/"><button class="btn btn-outline-dark">홈으로</button></a>
</body>
</html>