
package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Commande;
import model.Utilisateur;
import util.DatabaseConnection;

@WebServlet("/admin/orders")
public class CommandesServletAdmin extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Number of orders to display per page
    private static final int ITEMS_PER_PAGE = 10;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get search parameters
        String orderIdParam = request.getParameter("orderId");
        String clientParam = request.getParameter("client");
        String statusParam = request.getParameter("status");
        String dateFromParam = request.getParameter("dateFrom");
        String dateToParam = request.getParameter("dateTo");
        
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
            // Get all users for display purposes (to show names instead of IDs)
            List<Utilisateur> utilisateurs = getAllUsers(conn);
            request.setAttribute("utilisateurs", utilisateurs);
            
            // Prepare the query parameters
            List<Object> queryParams = new ArrayList<>();
            
            // Build the query for commandes
            StringBuilder countQuery = new StringBuilder("SELECT COUNT(*) FROM commande c JOIN utilisateur u ON c.id_utilisateur = u.id WHERE 1=1");
            StringBuilder query = new StringBuilder("SELECT c.id, c.id_utilisateur, c.date_commande, c.statut, " +
                                                  "(SELECT SUM(dc.quantite * dc.prix_unitaire) FROM detail_commande dc WHERE dc.id_commande = c.id) as montant_total " +
                                                  "FROM commande c JOIN utilisateur u ON c.id_utilisateur = u.id WHERE 1=1");
            
            // Add filters to the query
            if (orderIdParam != null && !orderIdParam.trim().isEmpty()) {
                countQuery.append(" AND c.id = ?");
                query.append(" AND c.id = ?");
                queryParams.add(Integer.parseInt(orderIdParam.trim()));
            }
            
            if (clientParam != null && !clientParam.trim().isEmpty()) {
                countQuery.append(" AND u.nom LIKE ?");
                query.append(" AND u.nom LIKE ?");
                queryParams.add("%" + clientParam.trim() + "%");
            }
            
            if (statusParam != null && !statusParam.trim().isEmpty()) {
                countQuery.append(" AND c.statut = ?");
                query.append(" AND c.statut = ?");
                queryParams.add(statusParam.trim());
            }
            
            // Date range filter
            if (dateFromParam != null && !dateFromParam.trim().isEmpty()) {
                countQuery.append(" AND c.date_commande >= ?");
                query.append(" AND c.date_commande >= ?");
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    Date dateFrom = sdf.parse(dateFromParam);
                    queryParams.add(new Timestamp(dateFrom.getTime()));
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
            
            if (dateToParam != null && !dateToParam.trim().isEmpty()) {
                countQuery.append(" AND c.date_commande <= ?");
                query.append(" AND c.date_commande <= ?");
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    Date dateTo = sdf.parse(dateToParam);
                    // Add one day to include the whole day
                    dateTo.setTime(dateTo.getTime() + 86400000);
                    queryParams.add(new Timestamp(dateTo.getTime()));
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
            
            // Count total orders with filters
            int totalOrders = 0;
            try (PreparedStatement countStmt = conn.prepareStatement(countQuery.toString())) {
                for (int i = 0; i < queryParams.size(); i++) {
                    countStmt.setObject(i + 1, queryParams.get(i));
                }
                
                ResultSet countRs = countStmt.executeQuery();
                if (countRs.next()) {
                    totalOrders = countRs.getInt(1);
                }
            }
            
            // Calculate total pages
            int totalPages = (int) Math.ceil((double) totalOrders / ITEMS_PER_PAGE);
            
            // Ensure the requested page is within bounds
            if (page > totalPages && totalPages > 0) {
                page = totalPages;
            }
            
            // Calculate the offset for pagination
            int offset = (page - 1) * ITEMS_PER_PAGE;
            
            // Add order by and limit clauses
            query.append(" ORDER BY c.date_commande DESC LIMIT ? OFFSET ?");
            
            // Get orders with pagination
            List<Commande> commandes = new ArrayList<>();
            try (PreparedStatement stmt = conn.prepareStatement(query.toString())) {
                for (int i = 0; i < queryParams.size(); i++) {
                    stmt.setObject(i + 1, queryParams.get(i));
                }
                stmt.setInt(queryParams.size() + 1, ITEMS_PER_PAGE);
                stmt.setInt(queryParams.size() + 2, offset);
                
                ResultSet rs = stmt.executeQuery();
                
                while (rs.next()) {
                    Commande commande = new Commande();
                    commande.setId(rs.getInt("id"));
                    commande.setUtilisateurId(rs.getInt("id_utilisateur"));
                    commande.setDateCommande(rs.getTimestamp("date_commande"));
                    commande.setStatut(rs.getString("statut"));
                    commande.setMontantTotal(rs.getDouble("montant_total"));
                    commandes.add(commande);
                }
            }
            
            // Get statistics for dashboard
            Map<String, Object> stats = getOrderStats(conn);
            
            // Build search parameters for pagination links
            StringBuilder searchParams = new StringBuilder();
            if (orderIdParam != null && !orderIdParam.isEmpty()) {
                searchParams.append("&orderId=").append(orderIdParam);
            }
            if (clientParam != null && !clientParam.isEmpty()) {
                searchParams.append("&client=").append(clientParam);
            }
            if (statusParam != null && !statusParam.isEmpty()) {
                searchParams.append("&status=").append(statusParam);
            }
            if (dateFromParam != null && !dateFromParam.isEmpty()) {
                searchParams.append("&dateFrom=").append(dateFromParam);
            }
            if (dateToParam != null && !dateToParam.isEmpty()) {
                searchParams.append("&dateTo=").append(dateToParam);
            }
            
            // Set attributes for the JSP
            request.setAttribute("commandes", commandes);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("searchParams", searchParams.toString());
            request.setAttribute("stats", stats);
            
            // Set search parameters for form retention
            request.setAttribute("orderId", orderIdParam);
            request.setAttribute("client", clientParam);
            request.setAttribute("status", statusParam);
            request.setAttribute("dateFrom", dateFromParam);
            request.setAttribute("dateTo", dateToParam);
            
            // Forward the request to the JSP
            request.getRequestDispatcher("/commandes.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error: " + e.getMessage());
        }
    }
    
    /**
     * Handle POST requests (e.g., for order status updates)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("updateStatus".equals(action)) {
            // Update order status
            String orderId = request.getParameter("orderId");
            String newStatus = request.getParameter("newStatus");
            
            if (orderId != null && newStatus != null) {
                try (Connection conn = DatabaseConnection.getConnection()) {
                    updateOrderStatus(conn, Integer.parseInt(orderId), newStatus);
                    // Redirect back to the orders page with success message
                    response.sendRedirect(request.getContextPath() + "/admin/orders?message=statusUpdated");
                } catch (SQLException | NumberFormatException e) {
                    e.printStackTrace();
                    response.sendRedirect(request.getContextPath() + "/admin/orders?error=" + e.getMessage());
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/orders?error=missingParameters");
            }
        } else {
            // Invalid action, redirect back to orders page
            response.sendRedirect(request.getContextPath() + "/admin/orders");
        }
    }
    
    /**
     * Get all users from the database
     */
    private List<Utilisateur> getAllUsers(Connection conn) throws SQLException {
        List<Utilisateur> users = new ArrayList<>();
        
        String query = "SELECT id, nom, email FROM utilisateur ORDER BY nom";
        
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Utilisateur user = new Utilisateur();
                user.setId(rs.getInt("id"));
                user.setNom(rs.getString("nom"));
                user.setEmail(rs.getString("email"));
                users.add(user);
            }
        }
        
        return users;
    }
    
    /**
     * Update the status of an order
     */
    private void updateOrderStatus(Connection conn, int orderId, String newStatus) throws SQLException {
        String query = "UPDATE commande SET statut = ? WHERE id = ?";
        
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, newStatus);
            stmt.setInt(2, orderId);
            
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected == 0) {
                throw new SQLException("Failed to update order status. Order ID " + orderId + " not found.");
            }
        }
    }
    
    /**
     * Get order statistics for the dashboard
     */
    private Map<String, Object> getOrderStats(Connection conn) throws SQLException {
        Map<String, Object> stats = new HashMap<>();
        
        // Get total number of orders
        try (PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM commande")) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                stats.put("totalOrders", rs.getInt(1));
            }
        }
        
        // Get number of pending orders
        try (PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM commande WHERE statut = 'en attente'")) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                stats.put("pendingOrders", rs.getInt(1));
            }
        }
        
        // Get number of shipped orders
        try (PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM commande WHERE statut = 'expédié'")) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                stats.put("shippedOrders", rs.getInt(1));
            }
        }
        
        // Get number of delivered orders
        try (PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM commande WHERE statut = 'livré'")) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                stats.put("deliveredOrders", rs.getInt(1));
            }
        }
        
        // Get today's orders count
        try (PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM commande WHERE DATE(date_commande) = CURRENT_DATE")) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                stats.put("todayOrders", rs.getInt(1));
            }
        }
        
        // Get today's revenue
        try (PreparedStatement stmt = conn.prepareStatement(
                "SELECT SUM(dc.quantite * dc.prix_unitaire) " +
                "FROM commande c " +
                "JOIN detail_commande dc ON c.id = dc.id_commande " +
                "WHERE DATE(c.date_commande) = CURRENT_DATE")) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Double revenue = rs.getDouble(1);
                stats.put("todayRevenue", revenue != null ? revenue : 0.0);
            }
        }
        
        // Get orders by status for pie chart
        Map<String, Integer> ordersByStatus = new HashMap<>();
        try (PreparedStatement stmt = conn.prepareStatement("SELECT statut, COUNT(*) as count FROM commande GROUP BY statut")) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                ordersByStatus.put(rs.getString("statut"), rs.getInt("count"));
            }
            stats.put("ordersByStatus", ordersByStatus);
        }
        
        return stats;
    }
}