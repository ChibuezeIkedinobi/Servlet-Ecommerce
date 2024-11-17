<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.eccommerce1.util.Util" %>
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
        /* General Styling */
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9fb;
            margin: 0;
            padding: 0;
        }

        /* Header Styling */
        .header {
            background-color: #007bff;
            color: #fff;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .header h1 {
            margin: 0;
            font-size: 24px;
        }

        .header div {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .header span {
            font-size: 16px;
        }

        .header a {
            color: #fff;
            text-decoration: none;
            background-color: #0056b3;
            padding: 8px 12px;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }

        .header a:hover {
            background-color: #003f8f;
        }

        /* Main Content Styling */
        h2 {
            text-align: center;
            color: #333;
            margin: 20px 0;
        }

        table {
            width: 90%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        table th, table td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
        }

        table th {
            background-color: #f2f2f2;
            color: #555;
        }

        table tr:hover {
            background-color: #f9f9fb;
        }

        table tr:last-child td {
            font-weight: bold;
            color: #007bff;
        }

        /* Buttons and Links */
        .btn-container {
            text-align: center;
            margin: 20px 0;
        }

        .btn-container a, .btn-container form button {
            text-decoration: none;
            color: #fff;
            background-color: #007bff;
            padding: 10px 20px;
            border-radius: 4px;
            font-size: 16px;
            font-weight: bold;
            transition: background-color 0.3s ease;
            border: none;
            cursor: pointer;
        }

        .btn-container a:hover, .btn-container form button:hover {
            background-color: #0056b3;
        }

        .btn-remove {
            background-color: #dc3545;
            color: #fff;
            padding: 8px 12px;
            border-radius: 4px;
            font-size: 14px;
            font-weight: bold;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn-remove:hover {
            background-color: #c82333;
        }

        .empty-cart {
            text-align: center;
            color: #888;
            font-size: 16px;
            margin: 20px 0;
        }

        .empty-cart a {
            color: #007bff;
            text-decoration: none;
            font-weight: bold;
        }

        .empty-cart a:hover {
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
        <th>Action</th>
    </tr>
    <%
        if (username != null) {
            try (Connection connection = Util.getConnection();
                 PreparedStatement statement = connection.prepareStatement(
                         "SELECT p.name, c.quantity, p.price, (c.quantity * p.price) AS total, p.id AS productId " +
                                 "FROM cart c " +
                                 "JOIN products p ON c.product_id = p.id " +
                                 "JOIN users u ON c.user_id = u.id " +
                                 "WHERE u.username = ?")) {
                statement.setString(1, username);
                ResultSet resultSet = statement.executeQuery();
                double grandTotal = 0.0;
                while (resultSet.next()) {
                    grandTotal += resultSet.getDouble("total");
                    int productId = resultSet.getInt("productId");
    %>
    <tr>
        <td><%= resultSet.getString("name") %></td>
        <td><%= resultSet.getInt("quantity") %></td>
        <td>N<%= resultSet.getDouble("price") %></td>
        <td>N<%= resultSet.getDouble("total") %></td>
        <td>
            <form action="CartServlet" method="post" style="display:inline;">
                <input type="hidden" name="action" value="removeFromCart">
                <input type="hidden" name="productId" value="<%= productId %>">
                <button type="submit" class="btn-remove">Remove</button>
            </form>
        </td>
    </tr>
    <%
        }
    %>
    <tr>
        <td colspan="3">Grand Total</td>
        <td colspan="2">N<%= grandTotal %></td>
    </tr>
    <%
        } catch (Exception e) {
            e.printStackTrace();
        }
    } else {
    %>
    <tr>
        <td colspan="5" class="empty-cart">Please <a href="login.jsp">login</a> to view your cart.</td>
    </tr>
    <%
        }
    %>
</table>

<div class="btn-container">
    <a href="home.jsp">Continue Shopping</a>
    <% if (username != null) { %>
    <form action="CartServlet" method="post" style="display:inline;">
        <input type="hidden" name="action" value="checkout">
        <button type="submit">Checkout</button>
    </form>
    <% } %>
</div>
</body>
</html>