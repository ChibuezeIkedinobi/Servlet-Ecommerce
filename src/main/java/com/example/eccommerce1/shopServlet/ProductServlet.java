package com.example.eccommerce1.shopServlet;

import com.example.eccommerce1.Util;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/ProductServlet")
public class ProductServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String action = request.getParameter("action");

        if ("addProduct".equals(action)) {
            try {
                addProduct(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("error.jsp");
            }
        }
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));

        try (Connection connection = Util.getConnection();
             PreparedStatement statement = connection.prepareStatement("INSERT INTO products (name, description, price) VALUES (?, ?, ?)")) {
            statement.setString(1, name);
            statement.setString(2, description);
            statement.setDouble(3, price);
            statement.executeUpdate();
            response.sendRedirect("admin.jsp");
        }
    }
}
