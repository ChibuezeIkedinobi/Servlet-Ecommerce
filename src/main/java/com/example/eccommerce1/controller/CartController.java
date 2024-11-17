package com.example.eccommerce1.controller;

import com.example.eccommerce1.service.CartService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/CartServlet")
public class CartController extends HttpServlet {

    private final CartService cartService = new CartService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String action = request.getParameter("action");

        try {
            if ("addToCart".equals(action)) {
                cartService.addToCart(request, response);
            } else if ("removeFromCart".equals(action)) {
                cartService.removeFromCart(request, response);
            } else if ("checkout".equals(action)) {
                cartService.checkout(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
