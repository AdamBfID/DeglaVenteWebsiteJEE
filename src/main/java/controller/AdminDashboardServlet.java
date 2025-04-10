package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.OrderDAO;
import dao.ProductDAO;
import model.Produit;
import model.Commande;
import util.DatabaseConnection;


public class AdminDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (Connection con = DatabaseConnection.getConnection()) {
            ProductDAO productDao = new ProductDAO(con);
            OrderDAO orderDao = new OrderDAO(con);

            List<Produit> produits = productDao.getAllProduits();
            List<Commande> commandes = orderDao.getRecentOrders(10);

            request.setAttribute("produits", produits);
            request.setAttribute("commandes", commandes);
            
            // Use an absolute path to the JSP file
            request.getRequestDispatcher("/dashboard.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }
}