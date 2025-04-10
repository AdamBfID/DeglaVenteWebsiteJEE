<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>

    .header-main {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 1rem 2rem;
        background: linear-gradient(to right, #7e4e23, #8a5a2f);
        color: #fff;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        position: sticky;
        top: 0;
        margin:0;
        z-index: 100;
    }

    .logo-container {
        font-size: 1.8rem;
        font-weight: 700;
        letter-spacing: 0.5px;
    }

    .logo-link {
        text-decoration: none;
        color: #fff;
        transition: color 0.2s ease;
    }

    .logo-link:hover {
        color: #f8f4e9;
    }

    .nav-container {
        display: flex;
        gap: 1.5rem;
        align-items: center;
    }

    .user-greeting {
        color: #f8f4e9;
        font-weight: 500;
        margin-right: 0.5rem;
    }

    .cart-link {
        text-decoration: none;
        color: #fff;
        background-color: rgba(255, 255, 255, 0.15);
        padding: 0.5rem 1rem;
        border-radius: 6px;
        display: flex;
        align-items: center;
        position: relative;
        font-weight: 500;
        transition: all 0.2s ease;
    }

    .cart-link:hover {
        background-color: rgba(255, 255, 255, 0.25);
    }

    .cart-icon {
        font-size: 1.2rem;
        margin-right: 0.4rem;
    }

    .cart-badge {
        position: absolute;
        top: -8px;
        right: -8px;
        background: #d4b68c;
        color: #7e4e23;
        border-radius: 50%;
        padding: 2px 6px;
        font-size: 0.8rem;
        font-weight: bold;
        border: 2px solid #7e4e23;
    }

    .logout-link {
        text-decoration: none;
        color: #fff;
        background-color: rgba(255, 255, 255, 0.1);
        padding: 0.5rem 1rem;
        border-radius: 6px;
        font-weight: 500;
        transition: all 0.2s ease;
    }

    .logout-link:hover {
        background-color: rgba(220, 53, 69, 0.8);
    }

    .login-link {
        text-decoration: none;
        color: #7e4e23;
        background-color: #f8f4e9;
        padding: 0.6rem 1.2rem;
        border-radius: 6px;
        font-weight: 600;
        transition: all 0.2s ease;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
    }

    .login-link:hover {
        background-color: #fff;
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    @media (max-width: 600px) {
        .header-main {
            padding: 1rem;
            flex-direction: column;
            gap: 0.8rem;
        }
        
        .user-greeting {
            display: none;
        }
    }
</style>

<header class="header-main">
    <div class="logo-container">
        <a href="${pageContext.request.contextPath}/catalogue" class="logo-link">DatteVente</a>
    </div>

    <nav class="nav-container">
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <!-- Authenticated User Section -->
                <div style="display: flex; align-items: center; gap: 1rem;">
                    <span class="user-greeting">
                        Bonjour, ${sessionScope.user.nom}
                    </span>
					
                    <!-- Cart Link -->
                    <c:choose>
    <c:when test="${sessionScope.user.role == 'client'}">
        <a href="${pageContext.request.contextPath}/panier" class="cart-link">
            <span class="cart-icon">🛒</span> Panier
            <c:if test="${not empty sessionScope.panier}">
                <span class="cart-badge">
                    ${sessionScope.panier.size()}
                </span>
            </c:if>
        </a>
    </c:when>
</c:choose>

                    <c:choose>
    <c:when test="${sessionScope.user.role == 'admin'}">
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="cart-link">
            <span class="cart-icon">💲</span> Dashboard
            
        </a>
    </c:when>
</c:choose>


                    <!-- Logout Link -->
                    <a href="${pageContext.request.contextPath}/logout" class="logout-link">
                        Déconnexion
                    </a>
                </div>
            </c:when>

            <c:otherwise>
                <!-- Guest User Section -->
                <a href="${pageContext.request.contextPath}/login" class="login-link">
                    Connexion
                </a>
            </c:otherwise>
        </c:choose>
    </nav>
</header>