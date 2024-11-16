<%--
  Created by IntelliJ IDEA.
  User: bueze
  Date: 12/11/2024
  Time: 11:53 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin</title>
</head>
  <body>
    <h2>Add New Product</h2>
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
    <a href="home.jsp">Go to Home</a>
  </body>
</html>
