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
<html>
<head>
    <title>Home</title>
</head>
  <body>
    <h2>Products</h2>
    <table border="1">
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
          <form action="CartServlet" method="post">
            <input type="hidden" name="action" value="addToCart">
            <input type="hidden" name="productId" value="<%= rs.getInt("id") %>">
            <label>Quantity:</label>
            <input type="number" name="quantity" min="1" value="1">
            <button type="submit">Add to Cart</button>
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
    <a href="cart.jsp">View Cart</a>
  </body>
</html>
