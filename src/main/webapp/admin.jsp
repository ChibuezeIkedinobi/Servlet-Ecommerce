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
      HttpSession session1 = request.getSession(false);
      if (!"admin".equals(session1.getAttribute("user"))) {
        response.sendRedirect("login.jsp"); // Redirect non-admins to login
        return; // Stop further execution
      }
    %>
<html>
<head>
  <title>Admin Dashboard</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 20px;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
    }
    table, th, td {
      border: 1px solid black;
    }
    th, td {
      padding: 10px;
      text-align: center;
    }
    form {
      margin: 10px 0;
    }
  </style>
</head>
<body>
<h2>Admin Dashboard</h2>

<!-- Form to Add Products -->
<h3>Add New Product</h3>
<form action="ProductServlet" method="post">
  <input type="hidden" name="action" value="addProduct">
  <label>Product Name:</label>
  <input type="text" name="name" required><br>
  <label>Description:</label>
  <textarea name="description" required></textarea><br>
  <label>Price:</label>
  <input type="number" name="price" step="0.01" required><br>
  <button type="submit">Add Product</button>
</form>

<!-- Display Existing Products -->
<h3>Manage Products</h3>
<table>
  <tr>
    <th>ID</th>
    <th>Name</th>
    <th>Description</th>
    <th>Price</th>
    <th>Action</th>
  </tr>
  <%
    try (Connection connection = Util.getConnection();
         PreparedStatement statement = connection.prepareStatement("SELECT * FROM products")) {
      ResultSet resultSet = statement.executeQuery();
      while (resultSet.next()) {
  %>
  <tr>
    <td><%= resultSet.getInt("id") %></td>
    <td><%= resultSet.getString("name") %></td>
    <td><%= resultSet.getString("description") %></td>
    <td><%= resultSet.getDouble("price") %></td>
    <td>
      <!-- Form to Remove Product -->
      <form action="ProductServlet" method="post" style="display:inline;">
        <input type="hidden" name="action" value="removeProduct">
        <input type="hidden" name="productId" value="<%= resultSet.getInt("id") %>">
        <button type="submit">Remove</button>
      </form>
    </td>
  </tr>
  <%
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
  %>
</table>
<a href="home.jsp">Go to Home</a>
</body>
</html>
