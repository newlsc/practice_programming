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
	$("#writer").focus();
});
function writeFormCheck(){
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
	alert("게시물이 작성되었습니다.");
	document.writeForm.submit();
}
</script>
</head>
<body>
	<div class="container mt-3">
		<form name="writeForm" action="write.do" method="post">
			<h2>게시물 작성</h2></br>
			<h4>작성자</h4><p>* 최대 20자까지 작성 가능합니다.</p>
		    <input type="text" id="writer" name="writer" class="form-control"></br>
			<h4>제목</h4><p>* 최대 20자까지 작성 가능합니다.</p>
		    <input id="title" name="title" type="text" class="form-control"></br>
			<h4>내용</h4><p>* 최대 300자까지 작성 가능합니다.</p>
			<textarea class="form-control" rows="7" cols="170" id="content" name="content"></textarea></br>
	  		<a href="list.do"><button type="button" class="btn btn-outline-dark">취소</button></a>
	  		<button type="reset" class="btn btn-outline-dark">새로입력</button>
	  		<button type="button" class="btn btn-outline-dark" onclick="writeFormCheck();">작성</button>
	  	</form>
  	</div>
</body>
</html>