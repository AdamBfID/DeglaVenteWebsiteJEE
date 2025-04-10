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

    .confirmation-container {
        max-width: 800px;
        margin: 60px auto;
        padding: 40px;
        background-color: #fff;
        border-radius: 12px;
        box-shadow: 0 6px 18px rgba(0, 0, 0, 0.1);
        text-align: center;
    }

    .confirmation-icon {
        font-size: 4rem;
        color: #27ae60;
        margin-bottom: 1.5rem;
    }

    .confirmation-title {
        color: #7e4e23;
        font-size: 2rem;
        font-weight: 700;
        margin-bottom: 1rem;
    }

    .confirmation-message {
        font-size: 1.1rem;
        color: #555;
        margin-bottom: 2rem;
        line-height: 1.8;
    }

    .order-number {
        background-color: #f8f4e9;
        border: 2px dashed #d4b68c;
        padding: 1rem 2rem;
        border-radius: 8px;
        font-size: 1.2rem;
        color: #7e4e23;
        font-weight: 600;
        display: inline-block;
        margin-bottom: 2rem;
    }

    .confirmation-actions {
        margin-top: 2rem;
    }

    .btn {
        display: inline-block;
        padding: 0.8rem 1.5rem;
        border-radius: 6px;
        font-weight: 600;
        text-decoration: none;
        transition: all 0.3s ease;
        margin: 0 0.5rem 1rem 0.5rem;
    }

    .btn-primary {
        background-color: #7e4e23;
        color: #fff;
        box-shadow: 0 4px 10px rgba(126, 78, 35, 0.2);
    }

    .btn-primary:hover {
        background-color: #6a4219;
        transform: translateY(-2px);
        box-shadow: 0 6px 12px rgba(126, 78, 35, 0.3);
    }

    .btn-secondary {
        background-color: #d4b68c;
        color: #7e4e23;
        box-shadow: 0 4px 10px rgba(212, 182, 140, 0.2);
    }

    .btn-secondary:hover {
        background-color: #c9a778;
        transform: translateY(-2px);
        box-shadow: 0 6px 12px rgba(212, 182, 140, 0.3);
    }

    .additional-info {
        margin-top: 3rem;
        padding-top: 2rem;
        border-top: 2px solid #f0e6d2;
        text-align: left;
    }

    .additional-info h3 {
        color: #7e4e23;
        margin-bottom: 1rem;
        font-size: 1.3rem;
    }

    .additional-info p {
        margin-bottom: 1rem;
        color: #666;
    }

    @media (max-width: 768px) {
        .confirmation-container {
            margin: 30px auto;
            padding: 30px 20px;
        }
        
        .confirmation-title {
            font-size: 1.7rem;
        }
    }
</style>

<div class="confirmation-container">
    <div class="confirmation-icon">✅</div>
    <h1 class="confirmation-title">Commande Confirmée!</h1>
    <p class="confirmation-message">
        Merci pour votre commande. Nous avons bien reçu votre paiement et nous préparons votre commande pour l'expédition.
        Vous recevrez un email de confirmation avec les détails de votre commande.
    </p>
    
    <div class="order-number">
        <c:choose>
            <c:when test="${not empty sessionScope.orderNumber}">
                Commande #${sessionScope.orderNumber}
            </c:when>
            <c:otherwise>
                Commande #${System.currentTimeMillis() % 10000 + 1000}
            </c:otherwise>
        </c:choose>
    </div>
    
    <div class="confirmation-actions">
        <a href="catalogue" class="btn btn-secondary">Continuer vos achats</a>
        <a href="historique" class="btn btn-primary">Voir mes commandes</a>
    </div>
    
    <div class="additional-info">
        <h3>Informations complémentaires</h3>
        <p>Votre commande sera traitée dans les plus brefs délais. Le délai de livraison estimé est de 3-5 jours ouvrables.</p>
        <p>Si vous avez des questions concernant votre commande, n'hésitez pas à contacter notre service client au <strong>+216-XX-XXX-XXX</strong> ou par email à <strong>support@example.com</strong>.</p>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp"/>