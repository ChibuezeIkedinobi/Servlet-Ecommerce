<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.eccommerce1.Util" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: bueze
  Date: 12/11/2024
  Time: 11:53 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession session2 = request.getSession(false);
    String username = (session2 != null) ? (String) session2.getAttribute("user") : null;
%>

<html>
<head>
    <title>Shopping Cart</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 20px;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        table th, table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }

        table th {
            background-color: #f8f9fa;
            color: #555;
        }

        table tr:hover {
            background-color: #f1f1f1;
        }

        table tr:last-child td {
            font-weight: bold;
            color: #007bff;
        }

        a {
            display: block;
            text-align: center;
            margin: 20px auto;
            text-decoration: none;
            color: #007bff;
            font-size: 16px;
            font-weight: bold;
        }

        a:hover {
            color: #0056b3;
        }
    </style>
</head>
<body>
<div class="header">
    <h1>Shopping Cart</h1>
    <div>
        <% if (username != null) { %>
        <span>Logged in as <%= username %></span>
        <a href="logout.jsp">Logout</a>
        <% } else { %>
        <a href="login.jsp">Login</a>
        <a href="register.jsp">Register</a>
        <% } %>
    </div>
</div>

<h2>Your Cart</h2>
<table>
    <tr>
        <th>Product</th>
        <th>Quantity</th>
        <th>Price</th>
        <th>Total</th>
    </tr>
    <%
        if (username != null) {
            try (Connection connection = Util.getConnection();
                 PreparedStatement statement = connection.prepareStatement(
                         "SELECT p.name, c.quantity, p.price, (c.quantity * p.price) AS total " +
                                 "FROM cart c " +
                                 "JOIN products p ON c.product_id = p.id " +
                                 "JOIN users u ON c.user_id = u.id " +
                                 "WHERE u.username = ?")) {
                statement.setString(1, username);
                ResultSet resultSet = statement.executeQuery();
                double grandTotal = 0.0;
                while (resultSet.next()) {
                    grandTotal += resultSet.getDouble("total");
    %>
    <tr>
        <td><%= resultSet.getString("name") %></td>
        <td><%= resultSet.getInt("quantity") %></td>
        <td><%= resultSet.getDouble("price") %></td>
        <td><%= resultSet.getDouble("total") %></td>
    </tr>
    <%
        }
    %>
    <tr>
        <td colspan="3">Grand Total</td>
        <td><%= grandTotal %></td>
    </tr>
    <%
        } catch (Exception e) {
            e.printStackTrace();
        }
    } else {
    %>
    <tr>
        <td colspan="4">Please <a href="login.jsp">login</a> to view your cart.</td>
    </tr>
    <%
        }
    %>
</table>
<a href="home.jsp">Continue Shopping</a>
</body>
</html>