<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="/WEB-INF/views/includes/header.jsp"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Palmora - Votre Panier</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background-color: #f8f8f8;
            color: #333;
            line-height: 1.6;
            padding: 0;
        }
        
        /* Hero Banner */
        .hero-banner {
            position: relative;
            height: 200px;
            overflow: hidden;
            margin-bottom: 25px;
        }
        
        .hero-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            filter: brightness(0.7);
        }
        
        .hero-content {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 2rem;
            color: white;
            background: linear-gradient(90deg, rgba(0,0,0,0.7) 0%, rgba(0,0,0,0.3) 50%, rgba(0,0,0,0) 100%);
        }
        
        .hero-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            max-width: 600px;
        }

        .main-container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .page-title {
            font-size: .5rem;
            font-weight: 700;
            margin: 1rem 1.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #d4a76a;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: #333;
        }

        .page-title-text {
            display: flex;
            align-items: center;
            font-size: 1.5rem;
            color: #8a5a2f;
        }

        .page-title .cart-icon {
            margin-right: 0.5rem;
            color: #8a5a2f;
        }

        .alert {
            padding: 1rem;
            border-radius: 8px;
            margin: 0 1.5rem 1.5rem;
            font-weight: 500;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .alert-danger {
            background-color: rgba(231, 76, 60, 0.1);
            border-left: 4px solid #e74c3c;
            color: #c0392b;
        }

        .alert-info {
            background-color: #fff;
            border-left: 4px solid #d4a76a;
            color: #8a5a2f;
            padding: 1.5rem;
            text-align: center;
            font-size: 1.1rem;
        }

        .cart-table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            margin: 0 auto;
        }

        .cart-table thead {
            background-color: #8a5a2f;
            color: #fff;
        }

        .cart-table th {
            padding: 1rem;
            text-align: left;
            font-weight: 600;
        }

        .cart-table tbody tr:nth-child(even) {
            background-color: #f0e0c9;
        }

        .cart-table td {
            padding: 1rem;
            vertical-align: middle;
            border-bottom: 1px solid #eee;
        }

        .cart-table tfoot {
            background-color: #f0e0c9;
            font-weight: 700;
        }

        .cart-table tfoot td {
            padding: 1rem;
        }

        .quantity-form {
            display: flex;
            align-items: center;
        }

        .quantity-input {
            width: 70px;
            padding: 0.5rem;
            margin-right: 0.5rem;
            border: 1px solid #d4a76a;
            border-radius: 4px;
            text-align: center;
        }

        .update-btn {
            background-color: #f0e0c9;
            color: #7e4e23;
            border: 1px solid #d4a76a;
            border-radius: 4px;
            padding: 0.5rem;
            cursor: pointer;
            transition: all 0.3s;
        }

        .update-btn:hover {
            background-color: #8a5a2f;
            color: #fff;
        }

        .remove-btn {
            background-color: #fff;
            color: #e74c3c;
            border: 1px solid #e74c3c;
            border-radius: 4px;
            padding: 0.5rem 0.75rem;
            cursor: pointer;
            transition: all 0.3s;
        }

        .remove-btn:hover {
            background-color: #e74c3c;
            color: #fff;
        }

        .total-row {
            font-size: 1.1rem;
        }

        .total-row td {
            padding: 1.25rem 1rem;
        }

        .text-end {
            text-align: right;
        }

        .checkout-form {
            margin: 2rem 0;
            text-align: right;
            padding: 0 1.5rem;
        }

        .checkout-btn {
            background-color: #8a5a2f;
            color: white;
            border: none;
            padding: 0.8rem 1.5rem;
            font-size: 1rem;
            font-weight: 600;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
            display: inline-flex;
            align-items: center;
        }

        .checkout-btn:hover {
            background-color: #6d4219;
        }

        .checkout-icon {
            margin-right: 0.5rem;
        }
        
        /* Features Section */
        .features-section {
            background-color: #f0e0c9;
            padding: 2rem 1.5rem;
            margin: 2rem 0;
        }
        
        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .feature-item {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
        }
        
        .feature-icon {
            font-size: 2.5rem;
            color: #8a5a2f;
            margin-bottom: 1rem;
        }
        
        .feature-title {
            font-size: 1.2rem;
            color: #333;
            margin-bottom: 0.5rem;
        }
        
        .feature-text {
            color: #666;
            font-size: 0.9rem;
        }
        
        /* Continue Shopping Button */
        .continue-shopping {
            display: inline-block;
            margin-top: 1rem;
            background-color: #f0e0c9;
            color: #7e4e23;
            border: 1px solid #d4a76a;
            padding: 0.8rem 1.5rem;
            border-radius: 4px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .continue-shopping:hover {
            background-color: #8a5a2f;
            color: #fff;
        }
        
        .action-buttons {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 1.5rem;
        }

        @media (max-width: 768px) {
            .hero-title {
                font-size: 2rem;
            }
            
            .cart-table {
                font-size: 0.9rem;
            }
            
            .cart-table th:nth-child(2),
            .cart-table td:nth-child(2) {
                display: none;
            }
            
            .features-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 576px) {
            .hero-banner {
                height: 150px;
            }
            
            .hero-title {
                font-size: 1.5rem;
            }
            
            .main-container {
                margin: 20px auto;
            }
            
            .cart-table th,
            .cart-table td {
                padding: 0.75rem 0.5rem;
            }
            
            .features-grid {
                grid-template-columns: 1fr;
            }
            
            .action-buttons {
                flex-direction: column;
                gap: 1rem;
            }
            
            .checkout-form {
                text-align: center;
            }
        }
    </style>
</head>
<body>
    <!-- Hero Banner -->
    <div class="hero-banner">
        <img src="images/bgLogin.avif" alt="Panier" class="hero-image">
        <div class="hero-content">
            <h1 class="hero-title">Votre Panier</h1>
        </div>
    </div>

    <div class="main-container">
        <h2 class="page-title">
            <span class="page-title-text"><i class="fas fa-shopping-cart cart-icon"></i> Détails de votre panier</span>
        </h2>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <c:choose>
            <c:when test="${empty panier}">
                <div class="alert alert-info">Votre panier est vide.</div>
                <div class="action-buttons">
                    <a href="${pageContext.request.contextPath}/" class="continue-shopping">
                        <i class="fas fa-arrow-left"></i> Continuer mes achats
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <table class="cart-table">
                    <thead>
                        <tr>
                            <th>Produit</th>
                            <th>Prix unitaire</th>
                            <th>Quantité</th>
                            <th>Total</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="totalPanier" value="0"/>
                        <c:forEach items="${panier}" var="item">
                            <tr>
                                <td>${item.nom}</td>
                                <td>${item.prix} DT</td>
                                <td>
                                    <form action="panier" method="post" class="quantity-form">
                                        <input type="hidden" name="action" value="update"/>
                                        <input type="hidden" name="productId" value="${item.id}"/>
                                        <input type="number" name="quantity" value="${item.stock}"
                                            min="1" max="99" class="quantity-input"/>
                                        <button type="submit" class="update-btn">
                                            <i class="fas fa-sync-alt"></i>
                                        </button>
                                    </form>
                                </td>
                                <td>
                                    <c:set var="totalItem" value="${item.prix * item.stock}"/>
                                    <strong>${totalItem} DT</strong>
                                    <c:set var="totalPanier" value="${totalPanier + totalItem}"/>
                                </td>
                                <td>
                                    <form action="panier" method="post">
                                        <input type="hidden" name="action" value="remove"/>
                                        <input type="hidden" name="productId" value="${item.id}"/>
                                        <button type="submit" class="remove-btn">
                                            <i class="fas fa-trash-alt"></i> Supprimer
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    <tfoot>
                        <tr class="total-row">
                            <td colspan="3" class="text-end"><strong>Total Général:</strong></td>
                            <td colspan="2"><strong><fmt:formatNumber value="${totalPanier}" type="number" minFractionDigits="2" maxFractionDigits="2" /> DT</strong>
</td>
                        </tr>
                    </tfoot>
                </table>

                <div class="action-buttons">
                    <a href="${pageContext.request.contextPath}/catalogue" class="continue-shopping">
                        <i class="fas fa-arrow-left"></i> Continuer mes achats
                    </a>
                    <form action="commander" method="post" class="checkout-form">
                        <button type="submit" class="checkout-btn">
                            <i class="fas fa-check-circle checkout-icon"></i> Passer la commande
                        </button>
                    </form>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    
    <!-- Features Section -->
    <div class="features-section">
        <div class="features-grid">
            <div class="feature-item">
                <div class="feature-icon">
                    <i class="fas fa-truck"></i>
                </div>
                <h3 class="feature-title">Livraison Rapide</h3>
                <p class="feature-text">Livraison sous 24-48h partout en Tunisie</p>
            </div>
            
            <div class="feature-item">
                <div class="feature-icon">
                    <i class="fas fa-leaf"></i>
                </div>
                <h3 class="feature-title">Produits Frais</h3>
                <p class="feature-text">Directement des producteurs à votre table</p>
            </div>
            
            <div class="feature-item">
                <div class="feature-icon">
                    <i class="fas fa-lock"></i>
                </div>
                <h3 class="feature-title">Paiement Sécurisé</h3>
                <p class="feature-text">Transactions cryptées et sécurisées</p>
            </div>
            
            <div class="feature-item">
                <div class="feature-icon">
                    <i class="fas fa-headset"></i>
                </div>
                <h3 class="feature-title">Service Client</h3>
                <p class="feature-text">Support disponible 7j/7 pour vous accompagner</p>
            </div>
        </div>
    </div>
</body>
</html>