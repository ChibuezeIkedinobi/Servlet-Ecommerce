package com.example.eccommerce1.repository;

import com.example.eccommerce1.util.Util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserRepository {
    public void registerUser(String username, String password, String role) throws Exception {
        try (Connection connection = Util.getConnection();
             PreparedStatement statement = connection.prepareStatement("INSERT INTO users (username, password, role) VALUES (?, ?, ?)")) {
            statement.setString(1, username);
            statement.setString(2, password);
            statement.setString(3, role);
            statement.executeUpdate();
        }
    }

    public String validateLogin(String username, String password) throws Exception {
        try (Connection connection = Util.getConnection();
             PreparedStatement statement = connection.prepareStatement("SELECT role FROM users WHERE username = ? AND password = ?")) {
            statement.setString(1, username);
            statement.setString(2, password);

            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString("role");
            }
        }
        return null;
    }
}
