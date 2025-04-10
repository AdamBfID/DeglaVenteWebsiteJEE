package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Commande;
import model.Utilisateur;
import util.DatabaseConnection;

@WebServlet("/admin/order/export")
public class OrderExportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get filter parameters
        String orderIdParam = request.getParameter("orderId");
        String clientParam = request.getParameter("client");
        String statusParam = request.getParameter("status");
        String dateFromParam = request.getParameter("dateFrom");
        String dateToParam = request.getParameter("dateTo");
        
        try (Connection conn = DatabaseConnection.getConnection()) {
            // Get all users for mapping IDs to names
            List<Utilisateur> utilisateurs = getAllUsers(conn);
            
            // Get filtered orders
            List<Commande> commandes = getFilteredOrders(conn, orderIdParam, clientParam, statusParam, dateFromParam, dateToParam);
            
            // Set response headers for CSV download
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd_HHmmss");
            String timestamp = dateFormat.format(new java.util.Date());
            String filename = "commandes_" + timestamp + ".csv";
            
            response.setContentType("text/csv");
            response.setHeader("Content-Disposition", "attachment; filename=" + filename);
            
            // Create CSV content
            PrintWriter writer = response.getWriter();
            
            // Add UTF-8 BOM to help Excel recognize it as UTF-8
            writer.write('\ufeff');
            
            // Write CSV header
            writer.println("ID,Client,Date,Montant (DT),Statut");
            
            // Write data rows
            SimpleDateFormat outputDateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
            for (Commande commande : commandes) {
                StringBuilder line = new StringBuilder();
                
                // ID
                line.append(commande.getId()).append(",");
                
                // Client
                String clientName = "";
                for (Utilisateur user : utilisateurs) {
                    if (user.getId() == commande.getUtilisateurId()) {
                        clientName = user.getNom() ;
                        break;
                    }
                }
                // Escape commas in client name if any
                line.append("\"").append(clientName.replace("\"", "\"\"")).append("\",");
                
                // Date
                line.append("\"").append(outputDateFormat.format(commande.getDateCommande())).append("\",");
                
                // Montant
                line.append(commande.getMontantTotal()).append(",");
                
                // Status
                line.append("\"").append(commande.getStatut()).append("\"");
                
                writer.println(line.toString());
            }
            
            writer.flush();
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error: " + e.getMessage());
        }
    }
    
    // The getAllUsers and getFilteredOrders methods remain the same as in your Excel version

}