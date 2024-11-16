package com.example.eccommerce1.shopServlet;

import com.example.eccommerce1.Util;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String action = request.getParameter("action");

        if ("addToCart".equals(action)) {
            try {
                addToCart(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("error.jsp");
            }
        }
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String username = (String) request.getSession().getAttribute("user");

        try (Connection connection = Util.getConnection();
             PreparedStatement statement = connection.prepareStatement("INSERT INTO cart (user_id, product_id, quantity) VALUES ((SELECT id FROM users WHERE username = ?), ?, ?)")) {
            statement.setString(1, username);
            statement.setInt(2, productId);
            statement.setInt(3, quantity);
            statement.executeUpdate();
            response.sendRedirect("cart.jsp");
        }
    }
}
