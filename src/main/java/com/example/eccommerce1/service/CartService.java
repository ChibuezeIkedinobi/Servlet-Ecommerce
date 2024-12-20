package com.example.eccommerce1.service;

import com.example.eccommerce1.repository.CartRepository;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CartService {

    private final CartRepository cartRepository = new CartRepository();

    public void addToCart(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String username = (String) request.getSession().getAttribute("user");

        cartRepository.addToCart(username, productId, quantity);
        response.sendRedirect("cart.jsp");
    }

    public void removeFromCart(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int productId = Integer.parseInt(request.getParameter("productId"));
        String username = (String) request.getSession().getAttribute("user");

        cartRepository.removeFromCart(username, productId);
        response.sendRedirect("cart.jsp");
    }

    public void checkout(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String username = (String) request.getSession().getAttribute("user");

        cartRepository.clearCart(username);
        response.sendRedirect("cart.jsp");
    }
}