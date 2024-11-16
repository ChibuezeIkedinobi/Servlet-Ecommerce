<%--
  Created by IntelliJ IDEA.
  User: bueze
  Date: 12/11/2024
  Time: 11:52 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
</head>
<body>
<h2>Login</h2>
<form action="UserServlet" method="post">
    <input type="hidden" name="action" value="login">
    <label>Username:</label>
    <input type="text" name="username" required><br>
    <label>Password:</label>
    <input type="password" name="password" required><br>
    <button type="submit">Login</button>
</form>
<p>Don't have an account? <a href="register.jsp">Register here</a></p>
</body>
</html>
