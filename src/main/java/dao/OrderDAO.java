package dao;

import model.Commande;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
    private Connection connection;
    
    public OrderDAO(Connection connection) {
        this.connection = connection;
    }
    
    public int createOrder(Commande commande) throws SQLException {
        String query = "INSERT INTO commande (id_utilisateur, date_commande, statut) VALUES (?, ?, ?)";
        PreparedStatement ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
        ps.setInt(1, commande.getUtilisateurId());
        ps.setTimestamp(2, commande.getDateCommande());
        ps.setString(3, commande.getStatut());
        
        ps.executeUpdate();
        
        ResultSet generatedKeys = ps.getGeneratedKeys();
        if (generatedKeys.next()) {
            return generatedKeys.getInt(1);
        } else {
            throw new SQLException("Creating order failed, no ID obtained.");
        }
    }
    
    public Commande getOrderById(int id) throws SQLException {
        String query = "SELECT * FROM commande WHERE id = ?";
        PreparedStatement ps = connection.prepareStatement(query);
        ps.setInt(1, id);
        
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            Commande commande = new Commande();
            commande.setId(rs.getInt("id"));
            commande.setUtilisateurId(rs.getInt("id_utilisateur"));
            commande.setDateCommande(rs.getTimestamp("date_commande"));
            commande.setStatut(rs.getString("statut"));
            // Note: The montant_total field doesn't exist in DB schema
            // commande.setMontantTotal(rs.getDouble("montant_total"));
            return commande;
        }
        
        return null;
    }
    
    public List<Commande> getOrdersByUserId(int userId) throws SQLException {
        List<Commande> orders = new ArrayList<>();
        String query = "SELECT c.*, COALESCE(SUM(dc.quantite * dc.prix_unitaire), 0) as montant_total " +
                       "FROM commande c " +
                       "LEFT JOIN detail_commande dc ON c.id = dc.id_commande " +
                       "WHERE c.id_utilisateur = ? " +
                       "GROUP BY c.id " +
                       "ORDER BY c.date_commande DESC";
        
        PreparedStatement ps = connection.prepareStatement(query);
        ps.setInt(1, userId);
        
        ResultSet rs = ps.executeQuery();
        
        while (rs.next()) {
            Commande commande = new Commande();
            commande.setId(rs.getInt("id"));
            commande.setUtilisateurId(rs.getInt("id_utilisateur"));
            commande.setDateCommande(rs.getTimestamp("date_commande"));
            commande.setStatut(rs.getString("statut"));
            commande.setMontantTotal(rs.getDouble("montant_total"));
            orders.add(commande);
        }
        
        return orders;
    }
    
    /**
     * Retrieves the most recent orders from the database.
     * 
     * @param limit The maximum number of orders to retrieve
     * @return A list of the most recent orders
     * @throws SQLException If a database error occurs
     */
    public List<Commande> getRecentOrders(int limit) throws SQLException {
        List<Commande> recentOrders = new ArrayList<>();
        String query = "SELECT c.*, COALESCE(SUM(dc.quantite * dc.prix_unitaire), 0) as montant_total " +
                       "FROM commande c " +
                       "LEFT JOIN detail_commande dc ON c.id = dc.id_commande " +
                       "GROUP BY c.id " +
                       "ORDER BY c.date_commande DESC " +
                       "LIMIT ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Commande commande = new Commande();
                commande.setId(rs.getInt("id"));
                commande.setUtilisateurId(rs.getInt("id_utilisateur"));
                commande.setDateCommande(rs.getTimestamp("date_commande"));
                commande.setStatut(rs.getString("statut"));
                commande.setMontantTotal(rs.getDouble("montant_total"));
                recentOrders.add(commande);
            }
        }
        
        return recentOrders;
    }
    
    public void updateOrderStatus(int orderId, String status) throws SQLException {
        String query = "UPDATE commande SET statut = ? WHERE id = ?";
        PreparedStatement ps = connection.prepareStatement(query);
        ps.setString(1, status);
        ps.setInt(2, orderId);
        ps.executeUpdate();
    }
    
    // Since there's no montant_total column in the database table,
    // we'll calculate it from detail_commande instead of updating it
    public double calculateOrderTotal(int orderId) throws SQLException {
        String query = "SELECT SUM(quantite * prix_unitaire) as total " +
                       "FROM detail_commande WHERE id_commande = ?";
        PreparedStatement ps = connection.prepareStatement(query);
        ps.setInt(1, orderId);
        
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getDouble("total");
        }
        return 0.0;
    }
}