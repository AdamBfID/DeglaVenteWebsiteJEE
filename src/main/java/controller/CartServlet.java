package controller;

import dao.ProductDAO;
import model.Produit;
import util.DatabaseConnection;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CartServlet", urlPatterns = {"/panier"})
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        List<Produit> panier = getOrCreateCart(session);
        request.setAttribute("panier", panier);

        // Forward to the panier.jsp view
        request.getRequestDispatcher("/panier.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        List<Produit> panier = getOrCreateCart(session);

        try (Connection con = DatabaseConnection.getConnection()) {
            ProductDAO productDao = new ProductDAO(con);

            if ("add".equals(action)) {
                int productId = Integer.parseInt(request.getParameter("productId"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));

                Produit product = productDao.getProductById(productId);
                if (product != null && product.getStock() >= quantity) {
                    addToCart(panier, product, quantity);
                }

            } else if ("update".equals(action)) {
                int productId = Integer.parseInt(request.getParameter("productId"));
                int newQuantity = Integer.parseInt(request.getParameter("quantity"));

                updateCartItem(panier, productId, newQuantity, productDao);

            } else if ("remove".equals(action)) {
                int productId = Integer.parseInt(request.getParameter("productId"));
                removeFromCart(panier, productId);
            }

            session.setAttribute("panier", panier);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur de manipulation du panier");
        }

        // Redirect to the GET method to display the cart
        response.sendRedirect(request.getContextPath() + "/panier");
    }

    // Helper method to get or create the cart session
    private List<Produit> getOrCreateCart(HttpSession session) {
        List<Produit> panier = (List<Produit>) session.getAttribute("panier");
        if (panier == null) {
            panier = new ArrayList<>();
            session.setAttribute("panier", panier);
        }
        return panier;
    }

    // Adds a product with quantity to the cart
    private void addToCart(List<Produit> panier, Produit product, int quantity) {
        boolean exists = false;

        for (Produit item : panier) {
            if (item.getId() == product.getId()) {
                item.setStock(item.getStock() + quantity);
                exists = true;
                break;
            }
        }

        if (!exists) {
            Produit copy = new Produit();
            copy.setId(product.getId());
            copy.setNom(product.getNom());
            copy.setPrix(product.getPrix());
            copy.setStock(quantity); // Used as cart quantity
            panier.add(copy);
        }
    }

    // Updates the quantity of a product in the cart
    private void updateCartItem(List<Produit> panier, int productId, int newQuantity, ProductDAO productDao)
            throws SQLException {
        for (Produit item : panier) {
            if (item.getId() == productId) {
                Produit dbProduct = productDao.getProductById(productId);
                if (dbProduct.getStock() >= newQuantity) {
                    item.setStock(newQuantity);
                }
                break;
            }
        }
    }

    // Removes a product from the cart
    private void removeFromCart(List<Produit> panier, int productId) {
        panier.removeIf(item -> item.getId() == productId);
    }
}
