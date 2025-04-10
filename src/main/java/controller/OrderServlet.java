package controller;
import dao.OrderDAO;
import dao.DetailCommandeDAO;
import model.Commande;
import model.DetailCommande;
import model.Produit;
import model.Utilisateur;
import util.DatabaseConnection;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;


public class OrderServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        List<Produit> panier = (List<Produit>) session.getAttribute("panier");
        Utilisateur user = (Utilisateur) session.getAttribute("user");
        
        // Validation checks
        if (user == null) {
            // User not logged in, redirect to login
            session.setAttribute("redirectAfterLogin", "panier");
            response.sendRedirect("login");
            return;
        }
        
        if (panier == null || panier.isEmpty()) {
            // Empty cart, redirect to cart page
            request.setAttribute("error", "Votre panier est vide");
            request.getRequestDispatcher("/panier").forward(request, response);
            return;
        }
        
        Connection con = null;
        try {
            con = DatabaseConnection.getConnection();
            con.setAutoCommit(false);
            
            // Create order
            OrderDAO orderDao = new OrderDAO(con);
            Commande commande = new Commande();
            commande.setUtilisateurId(user.getId());
            commande.setDateCommande(new java.sql.Timestamp(System.currentTimeMillis()));
            commande.setStatut("en attente"); // Match enum in DB: 'en attente', 'expédié', 'livré'
            
            int orderId = orderDao.createOrder(commande);
            
            // Create order details
            DetailCommandeDAO detailDao = new DetailCommandeDAO(con);
            double totalAmount = 0.0;
            
            for (Produit produit : panier) {
                DetailCommande detail = new DetailCommande();
                detail.setCommandeId(orderId);
                detail.setProduitId(produit.getId());
                detail.setQuantite(produit.getStock());
                detail.setPrixUnitaire(produit.getPrix());
                detailDao.createDetail(detail);
                
                // Calculate total
                totalAmount += (produit.getPrix() * produit.getStock());
            }
            
            con.commit();
            
            // Clear shopping cart
            session.removeAttribute("panier");
            
            // Set order number for confirmation page
            session.setAttribute("orderNumber", orderId);
            
            // Redirect to confirmation page
            response.sendRedirect("confirmation.jsp");
            
        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (con != null) con.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            request.setAttribute("error", "Erreur lors de la commande: " + e.getMessage());
            request.getRequestDispatcher("/panier").forward(request, response);
        } finally {
            try {
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Redirect GET requests to cart page
        response.sendRedirect("panier");
    }
}