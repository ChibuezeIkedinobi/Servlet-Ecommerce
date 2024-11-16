<%--
  Created by IntelliJ IDEA.
  User: bueze
  Date: 16/11/2024
  Time: 3:14 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%--%>
<%--    // Invalidate the current session--%>
<%--    HttpSession session = request.getSession(false);--%>
<%--    if (session != null) {--%>
<%--        session.invalidate();--%>
<%--    }--%>

<%--    // Redirect the user to the login page--%>
<%--    response.sendRedirect("login.jsp");--%>
<%--%>--%>
<html>
<head>
    <title>Log Out</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            text-align: center;
            margin-top: 50px;
        }
        h1 {
            color: #333;
        }
        p {
            margin-top: 20px;
            font-size: 16px;
            color: #555;
        }
        a {
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
        }
        a:hover {
            color: #0056b3;
        }
    </style>
</head>
<body>
<h1>You have been logged out</h1>
<p><a href="login.jsp">Click here</a> to log in again.</p>
</body>
</html>