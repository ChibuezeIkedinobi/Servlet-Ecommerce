package com.example.eccommerce1.repository;

import com.example.eccommerce1.util.Util;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class ProductRepository {
    public void addProduct(String name, String description, double price) throws Exception {
        try (Connection connection = Util.getConnection();
             PreparedStatement statement = connection.prepareStatement("INSERT INTO products (name, description, price) VALUES (?, ?, ?)")) {
            statement.setString(1, name);
            statement.setString(2, description);
            statement.setDouble(3, price);
            statement.executeUpdate();
        }
    }

    public void removeProduct(int productId) throws Exception {
        try (Connection connection = Util.getConnection();
             PreparedStatement statement = connection.prepareStatement("DELETE FROM products WHERE id = ?")) {
            statement.setInt(1, productId);
            statement.executeUpdate();
        }
    }
}
