package com.example.eccommerce1.shopServlet;

import com.example.eccommerce1.Util;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/ProductServlet")
public class ProductServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp"); // Redirect non-admins to login
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("addProduct".equals(action)) {
                addProduct(request, response);
            } else if ("removeProduct".equals(action)) {
                removeProduct(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Redirect to an error page in case of failure
        }
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");

        // Validate input
        if (name == null || description == null || priceStr == null || name.trim().isEmpty() || description.trim().isEmpty()) {
            throw new IllegalArgumentException("Invalid input data");
        }

        double price;
        try {
            price = Double.parseDouble(priceStr);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Invalid price format", e);
        }

        // Insert the product into the database
        try (Connection connection = Util.getConnection();
             PreparedStatement statement = connection.prepareStatement("INSERT INTO products (name, description, price) VALUES (?, ?, ?)")) {
            statement.setString(1, name);
            statement.setString(2, description);
            statement.setDouble(3, price);
            statement.executeUpdate();
        }

        response.sendRedirect("admin.jsp");
    }

    private void removeProduct(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String productIdStr = request.getParameter("productId");

        // Validate input
        if (productIdStr == null || productIdStr.trim().isEmpty()) {
            throw new IllegalArgumentException("Invalid product ID");
        }

        int productId;
        try {
            productId = Integer.parseInt(productIdStr);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Invalid product ID format", e);
        }

        // Remove the product from the database
        try (Connection connection = Util.getConnection();
             PreparedStatement statement = connection.prepareStatement("DELETE FROM products WHERE id = ?")) {
            statement.setInt(1, productId);
            statement.executeUpdate();
        }

        response.sendRedirect("admin.jsp");
    }
}