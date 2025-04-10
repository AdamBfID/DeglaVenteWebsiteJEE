package dao;

import model.Produit;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
    private Connection connection;

    public ProductDAO(Connection connection) {
        this.connection = connection;
    }

    // Get all products
    public List<Produit> getAllProduits() throws SQLException {
        List<Produit> produits = new ArrayList<>();
        String query = "SELECT * FROM produit";
        
        try (PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {
            
            while (resultSet.next()) {
                Produit produit = mapResultSetToProduit(resultSet);
                produits.add(produit);
            }
        }
        return produits;
    }

    // Get product by ID
    public Produit getProductById(int id) throws SQLException {
        String query = "SELECT * FROM produit WHERE id = ?";
        Produit produit = null;
        
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    produit = mapResultSetToProduit(resultSet);
                }
            }
        }
        return produit;
    }

    // Add new product
    public int addProduct(Produit produit) throws SQLException {
        String query = "INSERT INTO produit (nom, variete, prix, stock, description, image) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            setProductParameters(statement, produit);
            statement.executeUpdate();
            
            try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                }
            }
        }
        return -1;
    }

    // Update existing product
    public boolean updateProduct(Produit produit) throws SQLException {
        String query = "UPDATE produit SET nom = ?, variete = ?, prix = ?, stock = ?, description = ?, image = ? WHERE id = ?";
        
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            setProductParameters(statement, produit);
            statement.setInt(7, produit.getId());
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Delete product
    public boolean deleteProduct(int id) throws SQLException {
        String query = "DELETE FROM produit WHERE id = ?";
        
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, id);
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Filter products by variety
    public List<Produit> getProductsByVariety(String variety) throws SQLException {
        List<Produit> produits = new ArrayList<>();
        String query = "SELECT * FROM produit WHERE variete = ?";
        
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, variety);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Produit produit = mapResultSetToProduit(resultSet);
                    produits.add(produit);
                }
            }
        }
        return produits;
    }

    // Helper method to map ResultSet to Produit object
    private Produit mapResultSetToProduit(ResultSet resultSet) throws SQLException {
        Produit produit = new Produit();
        produit.setId(resultSet.getInt("id"));
        produit.setNom(resultSet.getString("nom"));
        produit.setVariete(resultSet.getString("variete"));
        produit.setPrix(resultSet.getDouble("prix"));
        produit.setStock(resultSet.getInt("stock"));
        produit.setDescription(resultSet.getString("description"));
        produit.setImage(resultSet.getString("image"));
        return produit;
    }

    // Helper method to set PreparedStatement parameters
    private void setProductParameters(PreparedStatement statement, Produit produit) throws SQLException {
        statement.setString(1, produit.getNom());
        statement.setString(2, produit.getVariete());
        statement.setDouble(3, produit.getPrix());
        statement.setInt(4, produit.getStock());
        statement.setString(5, produit.getDescription());
        statement.setString(6, produit.getImage());
    }
}