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

<html>
<head>
  <title>Admin Dashboard</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f9;
      color: #333;
      margin: 0;
      padding: 0;
    }

    header {
      background-color: #007bff;
      color: #fff;
      padding: 10px 20px;
      text-align: center;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    header h2 {
      margin: 0;
      font-size: 24px;
    }

    .container {
      max-width: 1200px;
      margin: 20px auto;
      padding: 20px;
      background-color: #fff;
      border-radius: 8px;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }

    h3 {
      color: #007bff;
      border-bottom: 2px solid #007bff;
      padding-bottom: 5px;
    }

    form {
      margin: 20px 0;
    }

    form label {
      display: block;
      margin-bottom: 8px;
      font-weight: bold;
    }

    form input[type="text"],
    form textarea,
    form input[type="number"] {
      width: 100%;
      padding: 8px;
      margin-bottom: 15px;
      border: 1px solid #ddd;
      border-radius: 4px;
      box-sizing: border-box;
    }

    form button {
      background-color: #007bff;
      color: #fff;
      border: none;
      padding: 10px 15px;
      border-radius: 5px;
      cursor: pointer;
      font-size: 16px;
    }

    form button:hover {
      background-color: #0056b3;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
    }

    table th, table td {
      border: 1px solid #ddd;
      padding: 12px;
      text-align: center;
    }

    table th {
      background-color: #007bff;
      color: #fff;
    }

    table tr:nth-child(even) {
      background-color: #f9f9f9;
    }

    table tr:hover {
      background-color: #f1f1f1;
    }

    .btn-remove {
      background-color: #dc3545;
      color: #fff;
      border: none;
      padding: 8px 10px;
      border-radius: 4px;
      cursor: pointer;
      font-size: 14px;
    }

    .btn-remove:hover {
      background-color: #c82333;
    }

    a {
      display: inline-block;
      margin-top: 20px;
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

<header>
  <h2>Admin Dashboard</h2>
</header>

<div class="container">

  <h3>Add New Product</h3>
  <form action="ProductServlet" method="post">
    <input type="hidden" name="action" value="addProduct">
    <label>Product Name:</label>
    <input type="text" name="name" required>
    <label>Description:</label>
    <textarea name="description" required></textarea>
    <label>Price:</label>
    <input type="number" name="price" step="0.01" required>
    <button type="submit">Add Product</button>
  </form>

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
      <td>$<%= resultSet.getDouble("price") %></td>
      <td>

        <form action="ProductServlet" method="post" style="display:inline;">
          <input type="hidden" name="action" value="removeProduct">
          <input type="hidden" name="productId" value="<%= resultSet.getInt("id") %>">
          <button type="submit" class="btn-remove">Remove</button>
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
  <a href="home.jsp" target="_blank">Go to Home</a>
</div>

</body>
</html>