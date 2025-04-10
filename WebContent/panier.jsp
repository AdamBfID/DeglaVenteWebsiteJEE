<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/includes/header.jsp"/>

<style>
    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    body {
        background-color: #f8f4e9;
        color: #333;
        line-height: 1.6;
    }

    .main-container {
        max-width: 1000px;
        margin: 40px auto;
        padding: 0 20px;
    }

    .page-title {
        color: #7e4e23;
        font-size: 2.2rem;
        font-weight: 700;
        margin-bottom: 1.5rem;
        padding-bottom: 0.75rem;
        border-bottom: 3px solid #d4b68c;
        display: flex;
        align-items: center;
    }

    .page-title .cart-icon {
        margin-right: 0.5rem;
    }

    .alert {
        padding: 1rem;
        border-radius: 8px;
        margin-bottom: 1.5rem;
        font-weight: 500;
    }

    .alert-danger {
        background-color: rgba(231, 76, 60, 0.1);
        border-left: 4px solid #e74c3c;
        color: #c0392b;
    }

    .alert-info {
        background-color: rgba(52, 152, 219, 0.1);
        border-left: 4px solid #3498db;
        color: #2980b9;
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
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
    }

    .cart-table thead {
        background-color: #7e4e23;
        color: #fff;
    }

    .cart-table th {
        padding: 1rem;
        text-align: left;
        font-weight: 600;
    }

    .cart-table tbody tr:nth-child(even) {
        background-color: #f8f4e9;
    }

    .cart-table td {
        padding: 1rem;
        vertical-align: middle;
        border-bottom: 1px solid #eee;
    }

    .cart-table tfoot {
        background-color: #f8f4e9;
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
        border: 2px solid #d4b68c;
        border-radius: 6px;
        text-align: center;
    }

    .update-btn {
        background-color: #d4b68c;
        color: #7e4e23;
        border: none;
        border-radius: 4px;
        padding: 0.5rem;
        cursor: pointer;
        transition: all 0.2s ease;
    }

    .update-btn:hover {
        background-color: #7e4e23;
        color: #fff;
    }

    .remove-btn {
        background-color: #e74c3c;
        color: #fff;
        border: none;
        border-radius: 6px;
        padding: 0.5rem 0.75rem;
        cursor: pointer;
        transition: all 0.2s ease;
    }

    .remove-btn:hover {
        background-color: #c0392b;
        transform: translateY(-2px);
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
        margin-top: 2rem;
        text-align: right;
    }

    .checkout-btn {
        background-color: #27ae60;
        color: white;
        border: none;
        padding: 0.85rem 1.75rem;
        font-size: 1.1rem;
        border-radius: 6px;
        cursor: pointer;
        font-weight: 600;
        letter-spacing: 0.5px;
        transition: all 0.3s ease;
        box-shadow: 0 4px 10px rgba(39, 174, 96, 0.2);
        display: inline-flex;
        align-items: center;
    }

    .checkout-btn:hover {
        background-color: #219653;
        transform: translateY(-2px);
        box-shadow: 0 6px 12px rgba(39, 174, 96, 0.3);
    }

    .checkout-btn:active {
        transform: translateY(0);
    }

    .checkout-icon {
        margin-right: 0.5rem;
    }

    @media (max-width: 768px) {
        .page-title {
            font-size: 1.8rem;
        }
        
        .cart-table {
            font-size: 0.9rem;
        }
        
        .cart-table th:nth-child(2),
        .cart-table td:nth-child(2) {
            display: none;
        }
    }

    @media (max-width: 576px) {
        .page-title {
            font-size: 1.5rem;
        }
        
        .main-container {
            margin: 20px auto;
        }
        
        .cart-table th,
        .cart-table td {
            padding: 0.75rem 0.5rem;
        }
    }
</style>

<div class="main-container">
    <h1 class="page-title"><span class="cart-icon">🛒</span> Votre Panier</h1>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <c:choose>
        <c:when test="${empty panier}">
            <div class="alert alert-info">Votre panier est vide.</div>
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
                            <td>${item.prix} DH</td>
                            <td>
                                <form action="panier" method="post" class="quantity-form">
                                    <input type="hidden" name="action" value="update"/>
                                    <input type="hidden" name="productId" value="${item.id}"/>
                                    <input type="number" name="quantity" value="${item.stock}"
                                        min="1" max="99" class="quantity-input"/>
                                    <button type="submit" class="update-btn">✓</button>
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
                                    <button type="submit" class="remove-btn">Supprimer</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
                <tfoot>
                    <tr class="total-row">
                        <td colspan="3" class="text-end"><strong>Total Général:</strong></td>
                        <td colspan="2"><strong>${totalPanier} DT</strong></td>
                    </tr>
                </tfoot>
            </table>

            <form action="commander" method="post" class="checkout-form">
                <button type="submit" class="checkout-btn">
                    <span class="checkout-icon">✅</span> Passer la commande
                </button>
            </form>
        </c:otherwise>
    </c:choose>
</div>