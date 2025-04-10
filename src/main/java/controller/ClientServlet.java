package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Utilisateur;
import util.DatabaseConnection;

@WebServlet("/admin/clients")
public class ClientServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Number of users to display per page
    private static final int ITEMS_PER_PAGE = 10;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchQuery = request.getParameter("search");
        int page = 1;
        
        // Get the requested page number if provided
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) {
                    page = 1;
                }
            } catch (NumberFormatException e) {
                // If the page parameter is not a valid number, default to page 1
            }
        }
        
        try (Connection conn = DatabaseConnection.getConnection()) {
            List<Utilisateur> utilisateurs = new ArrayList<>();
            int totalUsers = 0;
            
            // Count total users that match the search criteria
            StringBuilder countQuery = new StringBuilder("SELECT COUNT(*) FROM utilisateur");
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                countQuery.append(" WHERE nom LIKE ? OR email LIKE ? OR role LIKE ?");
            }
            
            try (PreparedStatement countStmt = conn.prepareStatement(countQuery.toString())) {
                if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                    String searchPattern = "%" + searchQuery.trim() + "%";
                    countStmt.setString(1, searchPattern);
                    countStmt.setString(2, searchPattern);
                    countStmt.setString(3, searchPattern);
                }
                
                ResultSet countRs = countStmt.executeQuery();
                if (countRs.next()) {
                    totalUsers = countRs.getInt(1);
                }
            }
            
            // Calculate total pages
            int totalPages = (int) Math.ceil((double) totalUsers / ITEMS_PER_PAGE);
            
            // Ensure the requested page is within bounds
            if (page > totalPages && totalPages > 0) {
                page = totalPages;
            }
            
            // Calculate the offset for pagination
            int offset = (page - 1) * ITEMS_PER_PAGE;
            
            // Query to fetch users with pagination and search
            StringBuilder query = new StringBuilder("SELECT id, nom, email,mot_de_passe, role FROM utilisateur");
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                query.append(" WHERE nom LIKE ? OR email LIKE ? OR role LIKE ?");
            }
            query.append(" ORDER BY id DESC LIMIT ? OFFSET ?");
            
            try (PreparedStatement stmt = conn.prepareStatement(query.toString())) {
                int paramIndex = 1;
                
                if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                    String searchPattern = "%" + searchQuery.trim() + "%";
                    stmt.setString(paramIndex++, searchPattern);
                    stmt.setString(paramIndex++, searchPattern);
                    stmt.setString(paramIndex++, searchPattern);
                }
                
                stmt.setInt(paramIndex++, ITEMS_PER_PAGE);
                stmt.setInt(paramIndex, offset);
                
                ResultSet rs = stmt.executeQuery();
                
                while (rs.next()) {
                    Utilisateur utilisateur = new Utilisateur();
                    utilisateur.setId(rs.getInt("id"));
                    utilisateur.setNom(rs.getString("nom"));
                    utilisateur.setEmail(rs.getString("email"));
                    utilisateur.setMotDePasse(rs.getString("mot_de_passe"));
                    utilisateur.setRole(rs.getString("role"));
                    utilisateurs.add(utilisateur);
                }
            }
            
            // Set attributes for the JSP
            request.setAttribute("utilisateurs", utilisateurs);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", page);
            request.setAttribute("searchQuery", searchQuery);
            
            // Forward to the JSP page
            request.getRequestDispatcher("/clients.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle POST requests if needed (like bulk actions, etc.)
        doGet(request, response);
    }
}