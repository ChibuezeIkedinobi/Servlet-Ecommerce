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
<html>
<head>
    <title>Shopping Cart</title>
</head>
    <body>
        <h2>Your Cart</h2>
        <table border="1">
            <tr>
                <th>Product</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Total</th>
            </tr>
            <%
                String username = (String) session.getAttribute("user");
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
                <td colspan="4">Your cart is empty.</td>
            </tr>
            <%
                }
            %>
        </table>
        <a href="home.jsp">Continue Shopping</a>
    </body>
</html>
