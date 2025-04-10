package dao;

import model.DetailCommande;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DetailCommandeDAO {
    private Connection connection;
    
    public DetailCommandeDAO(Connection connection) {
        this.connection = connection;
    }
    
    public void createDetail(DetailCommande detail) throws SQLException {
        String query = "INSERT INTO detail_commande (id_commande, id_produit, quantite, prix_unitaire) VALUES (?, ?, ?, ?)";
        PreparedStatement ps = connection.prepareStatement(query);
        ps.setInt(1, detail.getCommandeId());
        ps.setInt(2, detail.getProduitId());
        ps.setInt(3, detail.getQuantite());
        ps.setBigDecimal(4, detail.getPrixUnitaire());
        
        ps.executeUpdate();
    }
    
    public List<DetailCommande> getDetailsByOrderId(int orderId) throws SQLException {
        List<DetailCommande> details = new ArrayList<>();
        String query = "SELECT * FROM detail_commande WHERE id_commande = ?";
        PreparedStatement ps = connection.prepareStatement(query);
        ps.setInt(1, orderId);
        
        ResultSet rs = ps.executeQuery();
        
        while (rs.next()) {
            DetailCommande detail = new DetailCommande();
            detail.setId(rs.getInt("id"));
            detail.setCommandeId(rs.getInt("id_commande"));
            detail.setProduitId(rs.getInt("id_produit"));
            detail.setQuantite(rs.getInt("quantite"));
            detail.setPrixUnitaire(rs.getBigDecimal("prix_unitaire"));
            details.add(detail);
        }
        
        return details;
    }
}