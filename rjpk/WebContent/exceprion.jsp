<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>エラー内容</title>
</head>
<body>
	<h1>エラーが起きました。</h1>
	<p><%= pageContext.getClass().getName() %></p>
	<p><%= exception.getMessage() %></p>
	<a href="index.jsp">TOPページへ</a>
</body>
</html>