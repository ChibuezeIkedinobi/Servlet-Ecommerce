package com.example.eccommerce1.service;

import com.example.eccommerce1.repository.UserRepository;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class UserService {

    private final UserRepository userRepository = new UserRepository();

    public void registerUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        userRepository.registerUser(username, password, "user");
        response.sendRedirect("login.jsp");
    }

    public void loginUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        String role = userRepository.validateLogin(username, password);
        if (role != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", username);
            session.setAttribute("role", role);

            if ("admin".equalsIgnoreCase(role)) {
                response.sendRedirect("admin.jsp");
            } else {
                response.sendRedirect("home.jsp");
            }
        } else {
            response.sendRedirect("login.jsp?error=Invalid credentials");
        }
    }
}