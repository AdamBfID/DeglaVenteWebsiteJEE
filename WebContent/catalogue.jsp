<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/includes/header.jsp"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catalogue de Dattes</title>
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
            padding: 0px;
        }
        
        .header {
            text-align: center;
            padding: 20px 0;
            margin-bottom: 20px;
            border-bottom: 2px solid #d4b68c;
        }
        
        .header h1 {
            color: #7e4e23;
            font-size: 2.5em;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 15px;
        }
        
        .search-container {
            max-width: 600px;
            margin: 0 auto 30px;
            position: relative;
        }
        
        .search-container input {
            width: 100%;
            padding: 12px 20px;
            font-size: 16px;
            border: 2px solid #d4b68c;
            border-radius: 30px;
            background-color: #fff;
            transition: all 0.3s ease;
        }
        
        .search-container input:focus {
            outline: none;
            border-color: #7e4e23;
            box-shadow: 0 0 8px rgba(126, 78, 35, 0.4);
        }
        
        .search-container input::placeholder {
            color: #999;
        }
        
        .search-icon {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #7e4e23;
            font-size: 20px;
        }
        
        .product-list {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 25px;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .product-card {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: 300px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            display: flex;
            flex-direction: column;
        }
        
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }
        
        .product-card h3 {
            color: #7e4e23;
            font-size: 1.4em;
            margin-bottom: 10px;
            border-bottom: 1px solid #f0e0c9;
            padding-bottom: 10px;
        }
        
        .product-image-container {
            height: 200px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 15px 0;
            overflow: hidden;
        }
        
        .product-image {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
            border-radius: 4px;
            transition: transform 0.3s ease;
        }
        
        .product-image:hover {
            transform: scale(1.05);
        }
        
        .product-info {
            margin-bottom: 15px;
            flex-grow: 1;
        }
        
        .product-info p {
            margin-bottom: 8px;
        }
        
        .variete {
            font-style: italic;
            color: #666;
        }
        
        .price {
            font-weight: bold;
            color: #7e4e23;
            font-size: 1.2em;
        }
        
        .stock {
            color: #4CAF50;
            font-weight: 500;
        }
        
        .stock.low {
            color: #ff9800;
        }
        
        .stock.very-low {
            color: #f44336;
        }
        
        .description {
            font-size: 0.95em;
            color: #555;
            line-height: 1.5;
            margin-top: 10px;
        }
        
        .add-to-cart-form {
            margin-top: auto;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        
        .quantity-input {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }
        
        .quantity-input label {
            margin-right: 10px;
            font-weight: 500;
        }
        
        .quantity-input input {
            width: 60px;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            text-align: center;
        }
        
        .add-button {
            background-color: #7e4e23;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 500;
            transition: background-color 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .add-button:hover {
            background-color: #61381a;
        }
        
        .no-results {
            width: 100%;
            text-align: center;
            padding: 30px;
            font-size: 1.2em;
            color: #666;
            display: none;
        }
        
        @media (max-width: 768px) {
            .product-list {
                gap: 15px;
            }
            
            .product-card {
                width: calc(50% - 15px);
                padding: 15px;
            }
        }
        
        @media (max-width: 480px) {
            .product-card {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Notre Catalogue de Dattes</h1>
    </div>
    
    <div class="search-container">
        <input type="text" id="searchInput" placeholder="Rechercher des dattes par nom..." aria-label="Rechercher des dattes">
        <span class="search-icon">🔍</span>
    </div>
    
    <div class="product-list" id="productList">
        <c:forEach items="${produits}" var="produit">
            <div class="product-card" data-name="${produit.nom.toLowerCase()}" data-variety="${produit.variete.toLowerCase()}">
                <h3>${produit.nom}</h3>
                
                <div class="product-image-container">
                    <c:if test="${not empty produit.image}">
                        <img src="images/${produit.image}" class="product-image" alt="${produit.nom}">
                    </c:if>
                </div>
                
                <div class="product-info">
                    <p class="variete">Variété: ${produit.variete}</p>
                    <p class="price">Prix: ${produit.prix} Dt/kg</p>
                    <p class="stock ${produit.stock < 10 ? (produit.stock < 5 ? 'very-low' : 'low') : ''}">
                        Stock disponible: ${produit.stock}
                    </p>
                    <p class="description">${produit.description}</p>
                </div>
                
                <form class="add-to-cart-form" action="${pageContext.request.contextPath}/panier" method="post">
    <input type="hidden" name="action" value="add" /> <!-- ✅ this is essential -->
    <input type="hidden" name="productId" value="${produit.id}">
    <div class="quantity-input">
        <label for="quantity-${produit.id}">Quantité:</label>
        <input type="number" id="quantity-${produit.id}" name="quantity" value="1" min="1" max="${produit.stock}">
    </div>
    <button class="add-button" type="submit">Ajouter au panier</button>
</form>

            </div>
        </c:forEach>
    </div>
    
    <div class="no-results" id="noResults">
        Aucun produit ne correspond à votre recherche.
    </div>

    <script>
    document.addEventListener('DOMContentLoaded', function() {
        const searchInput = document.getElementById('searchInput');
        const productCards = document.querySelectorAll('.product-card');
        const productList = document.getElementById('productList');
        const noResults = document.getElementById('noResults');
        
        searchInput.addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase().trim();
            let visibleCount = 0;
            
            productCards.forEach(card => {
                const productName = card.getAttribute('data-name');
                const productVariety = card.getAttribute('data-variety');
                const isVisible = productName.includes(searchTerm) || productVariety.includes(searchTerm);
                
                card.style.display = isVisible ? 'flex' : 'none';
                
                if (isVisible) {
                    visibleCount++;
                }
            });
            
            if (visibleCount === 0) {
                noResults.style.display = 'block';
            } else {
                noResults.style.display = 'none';
            }
        });
        
        // Optional: Clear search when clicking the X (clear button) in the search input
        searchInput.addEventListener('search', function() {
            if (this.value === '') {
                productCards.forEach(card => {
                    card.style.display = 'flex';
                });
                noResults.style.display = 'none';
            }
        });
    });
    </script>
</body>
</html>