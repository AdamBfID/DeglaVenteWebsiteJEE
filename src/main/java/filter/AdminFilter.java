package filter;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import model.Utilisateur;

@WebFilter("/admin/*")
public class AdminFilter implements Filter {
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        
        HttpSession session = req.getSession(false);
        Utilisateur user = (session != null) ? (Utilisateur)session.getAttribute("user") : null;
        
        if(session == null || user == null || !"admin".equals(user.getRole())) {
            res.sendRedirect(req.getContextPath() + "/login");
        } else {
            chain.doFilter(request, response);
        }
    }
    
    public void init(FilterConfig fConfig) throws ServletException {
        // Initialization code if needed
    }
    
    public void destroy() {
        // Cleanup code if needed
    }
}