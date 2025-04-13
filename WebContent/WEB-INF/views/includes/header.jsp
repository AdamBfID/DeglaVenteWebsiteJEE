<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
    .header-main {
        display: flex;
        align-items: center;
        padding: 0.8rem 1.5rem;
        background: linear-gradient(to bottom, #8a5a2f, #6d4219);
        color: #fff;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
        position: sticky;
        top: 0;
        margin: 0;
        z-index: 100;
    }

    .logo-container {
        font-size: 1.6rem;
        font-weight: 700;
        padding: 0.5rem 0;
        margin-right: 1.5rem;
    }

    .logo-link {
        text-decoration: none;
        color: #fff;
        transition: color 0.2s ease;
    }

    .logo-link:hover {
        color: #ffd280;
    }

    .search-container {
        flex-grow: 1;
        display: flex;
        max-width: 700px;
        height: 40px;
        margin: 0 1rem;
    }

    .search-container select {
        border-radius: 4px 0 0 4px;
        border: none;
        background-color: #f3f3f3;
        color: #333;
        padding: 0 0.8rem;
        font-size: 0.85rem;
        border-right: 1px solid #ddd;
    }

    .search-container input {
        flex-grow: 1;
        padding: 0.5rem 1rem;
        border: none;
        font-size: 0.95rem;
    }

    .search-container input:focus {
        outline: none;
    }

    .search-button {
        background-color: #d4a76a;
        border: none;
        width: 45px;
        border-radius: 0 4px 4px 0;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: background-color 0.2s;
    }

    .search-button:hover {
        background-color: #c1914f;
    }

    .search-icon {
        font-size: 1.2rem;
    }

    .nav-container {
        display: flex;
        gap:2rem;
        align-items: center;
        margin-left: auto;
    }

    .nav-item {
        text-decoration: none;
        color: #fff;
        display: flex;
        flex-direction: column;
        padding: 0.3rem;
        border-radius: 2px;
        transition: all 0.2s;
    }

    .nav-item:hover {
        background-color: rgba(255, 255, 255, 0.1);
    }

    .nav-item span:first-child {
        font-size: 0.75rem;
        opacity: 0.9;
    }

    .nav-item span:last-child {
        font-weight: 600;
        font-size: 0.9rem;
    }

    .cart-link {
        text-decoration: none;
        color: #fff;
        display: flex;
        align-items: flex-end;
        position: relative;
        margin-left: 0.5rem;
        transition: all 0.2s;
    }

    .cart-link:hover {
        color: #ffd280;
    }

    .cart-icon {
        font-size: 1.8rem;
        position: relative;
    }

    .cart-badge {
        position: absolute;
        top: -8px;
        right: -8px;
        background: #ff8c00;
        color: #fff;
        border-radius: 50%;
        padding: 0 6px;
        font-size: 0.9rem;
        font-weight: bold;
    }

    .cart-text {
        font-weight: 600;
        margin-left: 3px;
    }

    .account-button, .login-button {
        cursor: pointer;
    }

    .login-button {
        background-color: #d4a76a;
        color: #2e1e0c;
        border: none;
        padding: 0.5rem 1.2rem;
        border-radius: 4px;
        font-weight: 600;
        transition: all 0.2s;
    }

    .login-button:hover {
        background-color: #c1914f;
    }

    @media (max-width: 800px) {
        .header-main {
            padding: 0.6rem 1rem;
            flex-wrap: wrap;
        }
        
        .search-container {
            order: 3;
            width: 100%;
            margin: 0.8rem 0 0.4rem;
            max-width: none;
        }
        
        .nav-container {
            margin-left: auto;
        }
        
        .nav-item span:first-child {
            display: none;
        }
    }

    @media (max-width: 600px) {
        .header-main {
            padding: 0.5rem;
        }
        
        .logo-container {
            font-size: 1.4rem;
            margin-right: 0.5rem;
        }
        
        .nav-item {
            padding: 0.2rem;
        }
    }
</style>

<header class="header-main">
    <div class="logo-container">
        <a href="${pageContext.request.contextPath}/catalogue" class="logo-link">Palmora</a>
    </div>

    <div class="search-container">
        <select>
            <option value="all">Toutes</option>
            <option value="deglet">Deglet Nour</option>
            <option value="medjool">Medjool</option>
            <option value="bio">Bio</option>
        </select>
        <input type="text" placeholder="Rechercher des dattes..." aria-label="Rechercher">
        <button class="search-button" aria-label="Rechercher">
             <i class="fas fa-search"></i>
        </button>
    </div>

    <nav class="nav-container">
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <!-- Authenticated User Section -->
                <div class="nav-item account-button">
                    <span>Bonjour,</span>
                    <span> ${sessionScope.user.nom}</span>
                </div>
                
                <c:if test="${sessionScope.user.role == 'admin'}">
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-item">
                        <span>Accès</span>
                        <span>Dashboard</span>
                    </a>
                </c:if>
                
                <a href="${pageContext.request.contextPath}/logout" class="nav-item">
                    <span>Quitter</span>
                    <span>Déconnexion</span>
                </a>
                
                <c:if test="${sessionScope.user.role == 'client'}">
                    <a href="${pageContext.request.contextPath}/panier" class="cart-link">
                        <div class="cart-icon">🛒
                            <c:if test="${not empty sessionScope.panier}">
                                <span class="cart-badge">${sessionScope.panier.size()}</span>
                            </c:if>
                        </div>
                        <span class="cart-text">Panier</span>
                    </a>
                </c:if>
            </c:when>

            <c:otherwise>
                <!-- Guest User Section -->
                <a href="${pageContext.request.contextPath}/login" class="nav-item">
                    <span>Compte</span>
                    <span>Se connecter</span>
                </a>
                <a href="${pageContext.request.contextPath}/register" class="login-button">
                    S'inscrire
                </a>
            </c:otherwise>
        </c:choose>
    </nav>
</header>