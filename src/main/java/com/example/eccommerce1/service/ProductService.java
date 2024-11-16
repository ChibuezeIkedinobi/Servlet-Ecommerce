package com.example.eccommerce1.service;

import com.example.eccommerce1.repository.ProductRepository;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ProductService {

    private final ProductRepository productRepository = new ProductRepository();

    public void addProduct(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));

        productRepository.addProduct(name, description, price);
        response.sendRedirect("admin.jsp");
    }

    public void removeProduct(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int productId = Integer.parseInt(request.getParameter("productId"));
        productRepository.removeProduct(productId);
        response.sendRedirect("admin.jsp");
    }
}