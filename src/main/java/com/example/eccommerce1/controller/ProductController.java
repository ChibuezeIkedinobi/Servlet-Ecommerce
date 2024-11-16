package com.example.eccommerce1.controller;

import com.example.eccommerce1.service.ProductService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/ProductServlet")
public class ProductController extends HttpServlet {

    private final ProductService productService = new ProductService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("role") : null;

        // Check if user is an admin
        if (!"admin".equalsIgnoreCase(role)) {
            response.sendRedirect("error.jsp");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("addProduct".equals(action)) {
                productService.addProduct(request, response);
            } else if ("removeProduct".equals(action)) {
                productService.removeProduct(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
