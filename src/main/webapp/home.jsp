<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.eccommerce1.Util" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: bueze
  Date: 12/11/2024
  Time: 11:53 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<%
  HttpSession session3 = request.getSession(false);
  String username = (session3 != null) ? (String) session3.getAttribute("user") : null;
%>

<html>
<head>
  <title>Home</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f9;
      margin: 20px;
    }

    .header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      background-color: #007bff;
      padding: 10px;
      color: white;
    }

    .header a {
      text-decoration: none;
      color: white;
      margin-left: 20px;
      font-weight: bold;
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

    form {
      display: inline-block;
    }

    input[type="number"] {
      width: 50px;
      padding: 5px;
      margin-right: 5px;
      text-align: center;
    }

    button {
      padding: 5px 10px;
      background-color: #007bff;
      border: none;
      color: #fff;
      cursor: pointer;
      border-radius: 3px;
      font-size: 14px;
    }

    button:hover {
      background-color: #0056b3;
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
  <h1>Welcome to Our Store</h1>
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
<h2>Products</h2>
<table>
  <tr>
    <th>Name</th>
    <th>Description</th>
    <th>Price</th>
    <th>Action</th>
  </tr>
  <%
    try (Connection conn = Util.getConnection();
         Statement stmt = conn.createStatement();
         ResultSet rs = stmt.executeQuery("SELECT * FROM products")) {
      while (rs.next()) {
  %>
  <tr>
    <td><%= rs.getString("name") %></td>
    <td><%= rs.getString("description") %></td>
    <td><%= rs.getDouble("price") %></td>
    <td>
      <% if (username != null) { %>
      <form action="CartServlet" method="post">
        <input type="hidden" name="action" value="addToCart">
        <input type="hidden" name="productId" value="<%= rs.getInt("id") %>">
        <label>Quantity:</label>
        <input type="number" name="quantity" min="1" value="1">
        <button type="submit">Add to Cart</button>
      </form>
      <% } else { %>
      <a href="login.jsp">Login to Add to Cart</a>
      <% } %>
    </td>
  </tr>
  <%
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
  %>
</table>
<a href="cart.jsp">View Cart</a>
</body>
</html>