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
<title>board update</title>
<script type="text/javascript">
$(document).ready(function(){
	$("#title").focus();
});
function updateFormCheck(){
	var titleLength = $("#title").val().trim().length;
	var contentLength = $("#content").val().trim().length;
	var writerLength = $("#writer").val().trim().length;
	
	if( titleLength < 2) {
		alert("제목은 두 자 이상이어야 합니다.");
		$("#title").focus();
		return false;
	}
	if( titleLength > 20) {
		alert("제목은 최대 20자 까지 작성가능합니다.");
		$("#title").focus();
		return false;
	}
	if (contentLength < 5) {
		alert("내용은 다섯 자 이상이어야 합니다.");
		$("#content").focus();
		return false;
	}
	if (contentLength > 300) {
		alert("내용은 최대 300자 까지 작성 가능합니다.");
		$("#content").focus();
		return false;
	}
	if (writerLength < 2) {
		alert("작성자는 두 자 이상이어야 합니다.");
		$("#writer").focus();
		return false;
	}
	if (writerLength > 20) {
		alert("작성자는 최대 20자 까지 작성 가능합니다.");
		$("#writer").focus();
		return false;
	}
	alert("게시물이 수정되었습니다.");
	document.updateForm.submit();
}
</script>
</head>
<body>
	<div class="container mt-3">
		<form name="updateForm" action="update.do" method="post">
			<h2>게시물 수정</h2></br>
			<h4>작성자</h4><p>* 최대 20자까지 작성 가능합니다.</p>
		    <input type="text" id="writer" name="writer" class="form-control" value="${detail[0].writer}"></br>
			<h4>제목</h4><p>* 최대 20자까지 작성 가능합니다.</p>
			<input type="hidden" name="id" value="${detail[0].id}">
		    <input id="title" name="title" type="text" class="form-control" value="${detail[0].title}" ></br>
			<h4>내용</h4><p>* 최대 300자까지 작성 가능합니다.</p>
			<textarea class="form-control" rows="7" cols="170" id="content" name="content">${detail[0].content}</textarea></br>
	  		<a href="listDetail.do?id=${detail[0].id}"><button type="button" class="btn btn-outline-dark">취소</button></a>
	  		<button type="reset" class="btn btn-outline-dark">새로입력</button>
	  		<button type="button" class="btn btn-outline-dark" onclick="updateFormCheck();">수정</button>
	  	</form>
  	</div>
  	<div>
  	</div>
</body>
</html>