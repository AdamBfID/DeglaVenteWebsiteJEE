package controller;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.ProductDAO;
import model.Produit;
import util.DatabaseConnection;


public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Get database connection
            Connection con = DatabaseConnection.getConnection();
           
            ProductDAO productDao = new ProductDAO(con);
            
            // Get all products
            List<Produit> produits = productDao.getAllProduits();
            
            // Set attributes for JSP
            request.setAttribute("produits", produits);
            
            // Forward to catalogue JSP
            request.getRequestDispatcher("/catalogue.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}