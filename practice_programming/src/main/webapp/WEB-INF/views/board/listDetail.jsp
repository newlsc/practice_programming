<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
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
<title>board detail</title>
<script type="text/javascript">
$(document).ready(function(){
	// 직전 댓글 여부 작성
	var replyForm = $("#replyForm");
	var justReplied = window.location.href
	if (justReplied.indexOf("justReplied") != -1) {
	} else{
		replyForm.hide(); // 처음에는 댓글 작성란 숨김 처리
	}
});

function clickDelete(){
	if (confirm("게시물을 삭제 하시겠습니까?") == true) {
		var id = $("#id").val();
		location.href = "delete.do?id="+id;
		alert("게시물이 삭제 되었습니다.");
	} else{
		return false;
	}
}
function clickReply(){
	var replyForm = $("#replyForm");
	replyForm.show();
}
function cancelReply(){
	var replyForm = $("#replyForm");
	var replyWriteForm = $("#replyWriteForm");
	replyForm.hide();
	replyWriteForm.val("");
}
function replySubmit(){
	var id = $("#id").val();
	var content = $("#replyWriteForm").val().trim();
	var replyForm = $("#replyForm");
	if (content == "") {
		alert("아직 댓글을 작성하지 않았습니다.");
		return false;
	} else {
		document.replyForm.submit();
		alert("댓글이 작성되었습니다.");
	}
}
</script>
</head>
<body>
	<div class="container mt-3">
		<h2>게시물 상세보기</h2></br>
		<h4>작성자</h4>
	    <input type="text" class="form-control" readonly="readonly" value="${detail[0].writer}"></br>
		<h4>제목</h4>
		<input type="hidden" id="id" value="${detail[0].id}">
	    <input type="text" class="form-control" readonly="readonly" value="${detail[0].title}"></br>
		<h4>내용</h4>
		<textarea class="form-control" rows="7" cols="170" readonly="readonly">${detail[0].content}</textarea></br>
  		<a href="list.do"><button type="button" class="btn btn-outline-dark">목록</button></a>
  		<a href="updateForm.do?id=${detail[0].id}"><button id="update" type="button" class="btn btn-outline-dark">수정</button></a>
  		<button id="delete" type="button" class="btn btn-outline-dark" onclick="clickDelete()">삭제</button>&emsp;
  		<button id="reply" type="button" class="btn btn-outline-primary" onclick="clickReply()">댓글(${replyTotal})</button>
  	</div>
  	
  	
  	<div class="container mt-3" id="replyForm">
		<c:forEach items="${reply}" var="reply">
			<div id="replyContent">
				<input type="hidden" value="${reply.reply_id}">
				<textarea class="form-control" id="reply" rows="3" cols="170" readonly="readonly">
<fmt:formatDate value="${reply.writeDate}" pattern="yyyy-MM-dd HH:mm" timeZone="java.util.Date"/>
${reply.content}
				</textarea>
			</div>
  		</c:forEach></br>
		<form name="replyForm" action="writeReply.do" method="post">
			<div class="form-group">
				<input type="hidden" name="id" value="${detail[0].id}">
				<textarea id="replyWriteForm" name="content" class="form-control" rows="2" placeholder="댓글은 최대 100자까지 작성할 수 있습니다." maxlength="100"></textarea>
			</div></br>
			<button type="button" class="btn btn-outline-primary" onclick="replySubmit()">댓글 등록</button>
			<button id="replyCancel" type="button" class="btn btn-outline-primary" onclick="cancelReply()">취소</button>
		</form>
	</div></br>
</body>
</html>