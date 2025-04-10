package controller;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import dao.UserDAO;
import model.Utilisateur;
import util.DatabaseConnection;


public class LoginServlet extends HttpServlet {
	
	  /**
	 * 
	 */
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	        request.getRequestDispatcher("/login.jsp").forward(request, response);
	    }
	
	
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        try {
            Connection con = DatabaseConnection.getConnection();
            UserDAO userDao = new UserDAO(con);
            Utilisateur user = userDao.authenticate(email, password);
            
            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                
                if (user.getRole().equals("admin")) {
                    response.sendRedirect("admin/dashboard");
                } else {
                    response.sendRedirect("catalogue");
                }
            } else {
                request.setAttribute("error", "Email ou mot de passe incorrect");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}