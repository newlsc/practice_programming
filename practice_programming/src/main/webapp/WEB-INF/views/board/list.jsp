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
<title>board list</title>

<style type="text/css">
.title:hover {
	cursor: pointer;
	background: #eee;
}
ul { 
	list-style: none; 
	float: left;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	$(".title").click(function(){
		var id = $(this).prev().text();
		location.href = "listDetail.do?id="+id;
	});
});
</script>

</head>
<body>
	<h1>자유게시판</h1></br>
	<table class="table table-bordered table-sm">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${list != null}">
			<c:forEach items="${list}" var="list">
				<tr class="dataRow">
					<td>${list.id}</td>
					<td class="title">${list.title}</td>
					<td>${list.writer}</td>
					<td><fmt:formatDate value="${list.writeDate}" pattern="yyyy-MM-dd" timeZone="java.util.Date"/></td>
					<td>${list.hit}</td>
				</tr>
			</c:forEach>	
			</c:if>
		</tbody>
	</table>
	<div style="text-align: right;">
		<a href="wirteForm.do" id="write"><button type="button" class="btn btn-outline-dark">글쓰기</button></a>
		<a href="/"><button class="btn btn-outline-dark">홈으로</button></a>
	</div>
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
