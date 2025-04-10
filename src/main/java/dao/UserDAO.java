package dao;

import model.Utilisateur;
import java.sql.*;

public class UserDAO {
    private Connection con;

    public UserDAO(Connection con) {
        this.con = con;
    }

    public Utilisateur authenticate(String email, String password) throws SQLException {
        String query = "SELECT * FROM utilisateur WHERE email = ? AND mot_de_passe = ?";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new Utilisateur(
                        rs.getInt("id"),
                        rs.getString("nom"),
                        rs.getString("email"),
                        rs.getString("mot_de_passe"),
                        rs.getString("role")
                    );
                }
            }
        }
        return null;
    }
    
    
    public boolean emailExists(String email) throws SQLException {
        String query = "SELECT COUNT(*) FROM utilisateur WHERE email = ?";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, email);
            try (ResultSet rs = pstmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    public void createUser(Utilisateur user) throws SQLException {
        String query = "INSERT INTO utilisateur (nom, email, mot_de_passe, role) VALUES (?, ?, ?, 'client')";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, user.getNom());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getMotDePasse());
            pstmt.executeUpdate();
        }
    }
}