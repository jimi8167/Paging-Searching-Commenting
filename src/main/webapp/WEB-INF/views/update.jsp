<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

</head>
<body>
	<form action="update" method="post">
		<input type="hidden" name="type" value="${cri.type}"> <input
			type="hidden" name="keyword" value="${cri.keyword}"> <input
			type="hidden" name="page" value="${cri.page }"> <input
			type="hidden" name="perPageNum" value="${cri.perPageNum }">
		<%-- <input type="hidden" name="bno" value="${board.bno}"> --%>
		<table>
			<tr>
				<th>번호</th>
				<td><input type="text" name="bno" readonly value="${board.bno}"}></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" value="${board.title }"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="5" cols="50" name="content">${board.content}</textarea></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><input type="text" name="writer" value="${board.writer }"></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="수정">
					<input type="reset" value="취소">
					<button id="list">목록보기</button>
					<button id="delete">삭제</button> <%-- <input type="button" value="목록보기" onclick="location.href='list'">
		<input type="button" value="삭제" onclick="location.href='delete?bno=${board.bno}'"> --%>
				</td>
			</tr>
		</table>
	</form>
	<br>
	<br>
	<form id="replyForm">
		<input type="hidden" value="${board.bno}" id="bno" />
		<table style="width: 650px">
			<tr>
				<td>작성자</td>
				<td rowspan="2"><textarea rows="2" cols="50" name="content"
						id="content"></textarea></td>
				<td rowspan="2"><button>댓글저장</button></td>
			</tr>

			<tr>
				<td><input type="text" id="writer" name="writer"></td>
			</tr>
		</table>
	</form>

	<br />
	<div id="listReply">댓글 리스트 영역</div>

	<form id="jobForm">
		<input type="hidden" name="type" value="${cri.type}"> <input
			type="hidden" name="keyword" value="${cri.keyword}"> <input
			type="hidden" name="page" value="${cri.page}"> <input
			type="hidden" name="perPageNum" value="${cri.perPageNum}"> <input
			type="hidden" name="bno" value="${board.bno }">
	</form>

	<script type="text/javascript">
		var jobForm = $("#jobForm");
		var replyForm = $("#replyForm");

		$("#list").on("click", function(event) {
			event.preventDefault();

			var targetPage = $(this).attr("href");
			jobForm.attr("action", "/list").attr("method", "get");
			jobForm.find("[name='bno']").remove();
			jobForm.submit();
		});

		$("#delete").on("click", function(event) {
			event.preventDefault();
			jobForm.attr("action", "/delete").attr("method", "get");
			jobForm.submit();
		});

		$("#replyForm button").on("click", function(event) {
			event.preventDefault();
			replyInsert();
		});
		function replyInsert() {

			/* 	var data={
					 bno:$('#bno').val(),
					 content:$('#content').val(),
					 writer:$('#writer').val()
				};
			 */

			var bno = $('#bno').val();
			var content = $('#content').val();
			var writer = $('#writer').val();

			$.ajax({
				type : 'POST',
				url : '/reply/insert.do',
				contentType : 'application/json; charset=utf-8',
				dataType : 'json',
				data : JSON.stringify({
					bno :bno,
					content :content,
					writer :writer

				}),
				success : function(data) {
					alert('댓글 등록 성공')
					listReply();
				}
			});
		}
		function listReply() {
			$ajax({
				type : "get",
				url : "/reply/list.do",
				success : function(result) {
					var output = "<table>";
					for ( var i in result) {
						output += "<tr>";
						output += "<td>" + result[i].content;
						output += " " + result[i].regdate;
						output += " " + result[i].writer;
						output += "</td></td>";
					}
					output += "</table>";
					$("listReply").hmtl(output);
				}

			});

		}
	</script>
</body>
</html>