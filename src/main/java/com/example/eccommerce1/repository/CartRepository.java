package com.example.eccommerce1.repository;

import com.example.eccommerce1.util.Util;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class CartRepository {

    public void addToCart(String username, int productId, int quantity) throws Exception {
        try (Connection connection = Util.getConnection();
             PreparedStatement statement = connection.prepareStatement("INSERT INTO cart (user_id, product_id, quantity) VALUES ((SELECT id FROM users WHERE username = ?), ?, ?)")) {
            statement.setString(1, username);
            statement.setInt(2, productId);
            statement.setInt(3, quantity);
            statement.executeUpdate();
        }
    }
}