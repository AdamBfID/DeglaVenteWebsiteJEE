<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/includes/header.jsp"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Palmora - ${produit.nom}</title>
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
        
        .product-container {
            max-width: 1200px;
            margin: 25px auto;
            padding: 0 20px;
        }
        
        .breadcrumb {
            display: flex;
            flex-wrap: wrap;
            margin-bottom: 20px;
            font-size: 0.9rem;
        }
        
        .breadcrumb a {
            color: #8a5a2f;
            text-decoration: none;
            margin-right: 5px;
        }
        
        .breadcrumb a:hover {
            text-decoration: underline;
        }
        
        .breadcrumb span {
            margin: 0 5px;
        }
        
        .product-details {
            display: flex;
            flex-wrap: wrap;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        
        .product-image-gallery {
            flex: 1;
            min-width: 300px;
            padding: 20px;
        }
        
        .main-image-container {
            height: 350px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 15px;
            border-radius: 8px;
            overflow: hidden;
            background-color: #f9f9f9;
        }
        
        .main-image {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
        }
        
        .image-thumbnails {
            display: flex;
            gap: 10px;
            overflow-x: auto;
        }
        
        .thumbnail {
            width: 80px;
            height: 80px;
            border-radius: 4px;
            border: 2px solid #ddd;
            overflow: hidden;
            cursor: pointer;
            transition: border-color 0.3s;
        }
        
        .thumbnail:hover {
            border-color: #8a5a2f;
        }
        
        .thumbnail.active {
            border-color: #8a5a2f;
        }
        
        .thumbnail img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .product-info {
            flex: 1;
            min-width: 300px;
            padding: 30px;
            display: flex;
            flex-direction: column;
        }
        
        .product-title {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 10px;
            color: #333;
        }
        
        .product-variety {
            font-size: 1rem;
            color: #666;
            font-style: italic;
            margin-bottom: 15px;
        }
        
        .product-rating {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .stars {
            color: #ff9900;
            font-size: 1rem;
            display: flex;
            margin-right: 10px;
        }
        
        .rating-count {
            font-size: 0.9rem;
            color: #666;
        }
        
        .product-price {
            font-size: 1.6rem;
            font-weight: 700;
            color: #8a5a2f;
            margin-bottom: 20px;
        }
        
        .availability {
            display: flex;
            align-items: center;
            font-size: 0.9rem;
            margin-bottom: 25px;
        }
        
        .available {
            color: #2ecc71;
            margin-right: 5px;
        }
        
        .limited-stock {
            color: #f39c12;
            margin-right: 5px;
        }
        
        .out-of-stock {
            color: #e74c3c;
            margin-right: 5px;
        }
        
        .product-description {
            margin-bottom: 25px;
            color: #555;
            line-height: 1.7;
        }
        
        .quantity-container {
            display: flex;
            align-items: center;
            margin-bottom: 25px;
        }
        
        .quantity-label {
            margin-right: 15px;
            font-weight: 600;
        }
        
        .quantity-selector {
            display: flex;
            align-items: center;
            border: 1px solid #ddd;
            border-radius: 4px;
            overflow: hidden;
        }
        
        .quantity-btn {
            background-color: #f0e0c9;
            border: none;
            width: 40px;
            height: 40px;
            font-size: 1.2rem;
            color: #8a5a2f;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        
        .quantity-btn:hover {
            background-color: #d4a76a;
        }
        
        .quantity-input {
            width: 60px;
            height: 40px;
            border: none;
            border-left: 1px solid #ddd;
            border-right: 1px solid #ddd;
            text-align: center;
            font-size: 1rem;
        }
        
        .action-buttons {
            display: flex;
            gap: 15px;
            margin-bottom: 25px;
        }
        
        .add-to-cart-btn {
            flex: 2;
            background-color: #8a5a2f;
            color: #fff;
            border: none;
            padding: 12px 0;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 600;
            transition: background-color 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .add-to-cart-btn:hover {
            background-color: #6d4219;
        }
        
        .add-to-cart-btn i {
            margin-right: 8px;
        }
        
        .wishlist-btn {
            flex: 1;
            background-color: #f0e0c9;
            color: #8a5a2f;
            border: 1px solid #d4a76a;
            padding: 12px 0;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .wishlist-btn:hover {
            background-color: #d4a76a;
        }
        
        .wishlist-btn i {
            margin-right: 8px;
        }
        
        .details-tabs {
            margin-top: 30px;
        }
        
        .tab-header {
            display: flex;
            border-bottom: 1px solid #ddd;
            margin-bottom: 20px;
        }
        
        .tab-btn {
            padding: 12px 20px;
            background: none;
            border: none;
            border-bottom: 3px solid transparent;
            font-size: 1rem;
            font-weight: 600;
            color: #666;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .tab-btn.active {
            color: #8a5a2f;
            border-bottom-color: #8a5a2f;
        }
        
        .tab-btn:hover:not(.active) {
            color: #333;
            background-color: #f5f5f5;
        }
        
        .tab-content {
            padding: 0 10px;
        }
        
        .tab-pane {
            display: none;
        }
        
        .tab-pane.active {
            display: block;
        }
        
        .product-meta {
            margin-top: auto;
            padding-top: 25px;
            border-top: 1px solid #eee;
            font-size: 0.9rem;
            color: #777;
        }
        
        .meta-item {
            margin-bottom: 8px;
        }
        
        .meta-label {
            font-weight: 600;
            margin-right: 5px;
        }
        
        .similar-products {
            margin-top: 40px;
        }
        
        .section-title {
            font-size: 1.5rem;
            color: #333;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #d4a76a;
        }
        
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 20px;
            margin-bottom: 2rem;
        }
        
        .product-card {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            padding: 15px;
            transition: transform 0.3s, box-shadow 0.3s;
            display: flex;
            flex-direction: column;
            position: relative;
        }
        
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.15);
        }
        
        .product-image-container {
            height: 160px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 12px;
            position: relative;
        }
        
        .card-wishlist-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            background: rgba(255, 255, 255, 0.8);
            border: none;
            width: 30px;
            height: 30px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            color: #999;
            transition: all 0.2s;
        }
        
        .card-wishlist-btn:hover {
            background: #fff;
            color: #e74c3c;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .product-image {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
        }
        
        .card-product-info {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }
        
        .card-product-title {
            font-size: 1rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
            text-decoration: none;
        }
        
        .card-product-title:hover {
            color: #8a5a2f;
        }
        
        .card-product-variety {
            font-size: 0.85rem;
            color: #666;
            margin-bottom: 6px;
            font-style: italic;
        }
        
        .card-product-rating {
            display: flex;
            align-items: center;
            margin-bottom: 8px;
        }
        
        .card-stars {
            color: #ff9900;
            font-size: 0.9rem;
            display: flex;
            margin-right: 5px;
        }
        
        .card-rating-count {
            font-size: 0.8rem;
            color: #666;
        }
        
        .card-product-price {
            font-weight: 700;
            font-size: 1.1rem;
            color: #8a5a2f;
            margin-top: auto;
            margin-bottom: 12px;
        }
        
        .card-add-to-cart {
            background-color: #f0e0c9;
            color: #7e4e23;
            border: 1px solid #d4a76a;
            padding: 8px 0;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s;
            width: 100%;
            text-align: center;
        }
        
        .card-add-to-cart:hover {
            background-color: #8a5a2f;
            color: #fff;
        }
        
        @media (max-width: 768px) {
            .product-details {
                flex-direction: column;
            }
            
            .main-image-container {
                height: 250px;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .product-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
    </style>
</head>
<body>
    <div class="product-container">
        <!-- Breadcrumb Navigation -->
        <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}/">Accueil</a>
            <span>/</span>
            <a href="${pageContext.request.contextPath}/#products">Produits</a>
            <span>/</span>
            <a href="${pageContext.request.contextPath}/#${produit.variete.toLowerCase()}">${produit.variete}</a>
            <span>/</span>
            ${produit.nom}
        </div>
        
        <!-- Product Details -->
        <div class="product-details">
            <!-- Product Image Gallery -->
            <div class="product-image-gallery">
                <div class="main-image-container">
                    <img src="${pageContext.request.contextPath}/images/${produit.image}" alt="${produit.nom}" class="main-image" id="mainImage">
                </div>
                
                <!-- Image Thumbnails -->
                <div class="image-thumbnails">
                    <div class="thumbnail active" data-image="${produit.image}">
                        <img src="${pageContext.request.contextPath}/images/${produit.image}" alt="${produit.nom}">
                    </div>
                    
                  
                </div>
            </div>
            
            <!-- Product Information -->
            <div class="product-info">
                <h1 class="product-title">${produit.nom}</h1>
                <p class="product-variety">Variété: ${produit.variete}</p>
                
                <div class="product-rating">
                    <div class="stars">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                    </div>
                    <span class="rating-count">(68 avis)</span>
                </div>
                
                <p class="product-price">${produit.prix} Dt/kg</p>
                
                <div class="availability">
                    <c:choose>
                        <c:when test="${produit.stock > 20}">
                            <i class="fas fa-check-circle available"></i>
                            <span>En stock</span>
                        </c:when>
                        <c:when test="${produit.stock > 0}">
                            <i class="fas fa-exclamation-circle limited-stock"></i>
                            <span>Stock limité (${produit.stock} restants)</span>
                        </c:when>
                        <c:otherwise>
                            <i class="fas fa-times-circle out-of-stock"></i>
                            <span>Rupture de stock</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <div class="product-description">
                    ${produit.description}
                </div>
                
                <div class="quantity-container">
                    <span class="quantity-label">Quantité:</span>
                    <div class="quantity-selector">
                        <button class="quantity-btn" id="decrease">-</button>
                        <input type="number" min="1" max="${produit.stock}" value="1" class="quantity-input" id="quantity">
                        <button class="quantity-btn" id="increase">+</button>
                    </div>
                </div>
                
                <div class="action-buttons">
                    <form action="${pageContext.request.contextPath}/panier" method="post" id="addToCartForm">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productId" value="${produit.id}">
                        <input type="hidden" name="quantity" value="1" id="quantityInput">
                        <button type="submit" class="add-to-cart-btn">
                            <i class="fas fa-shopping-cart"></i> Ajouter au panier
                        </button>
                    </form>
                    <button class="wishlist-btn">
                        <i class="far fa-heart"></i> Favoris
                    </button>
                </div>
                
                <div class="product-meta">
                    <p class="meta-item"><span class="meta-label">Catégorie:</span> ${produit.variete}</p>
                    <p class="meta-item"><span class="meta-label">Code produit:</span> PALM-${produit.id}</p>
                    <p class="meta-item"><span class="meta-label">Partager:</span> 
                        <a href="#" aria-label="Partager sur Facebook"><i class="fab fa-facebook-square"></i></a>
                        <a href="#" aria-label="Partager sur Twitter"><i class="fab fa-twitter-square"></i></a>
                        <a href="#" aria-label="Partager sur Pinterest"><i class="fab fa-pinterest-square"></i></a>
                    </p>
                </div>
            </div>
        </div>
        
        <!-- Product Details Tabs -->
        <div class="details-tabs">
            <div class="tab-header">
                <button class="tab-btn active" data-tab="description">Description</button>
                <button class="tab-btn" data-tab="additional">Informations Complémentaires</button>
                <button class="tab-btn" data-tab="reviews">Avis (68)</button>
                <button class="tab-btn" data-tab="shipping">Livraison & Retours</button>
            </div>
            
            <div class="tab-content">
                <div class="tab-pane active" id="description">
                    <p>${produit.description}</p>
                    <p>Nos dattes sont récoltées à la main et soigneusement sélectionnées pour vous garantir une qualité exceptionnelle. Riches en fibres, minéraux et antioxydants, elles constituent un choix santé idéal pour combler vos envies de sucré.</p>
                    <p>Conservation: Conserver dans un endroit frais et sec. Une fois ouvert, conservez au réfrigérateur.</p>
                </div>
                
                <div class="tab-pane" id="additional">
                    <h3>Informations Nutritionnelles</h3>
                    <p>Pour 100g:</p>
                    <ul>
                        <li>Énergie: 282 kcal</li>
                        <li>Protéines: 2.5g</li>
                        <li>Glucides: 75g dont sucres: 63g</li>
                        <li>Lipides: 0.4g</li>
                        <li>Fibres: 8g</li>
                    </ul>
                    <p>Origine: Tunisie</p>
                </div>
                
                <div class="tab-pane" id="reviews">
                    <p>Aucun avis pour le moment. Soyez le premier à donner votre avis sur "${produit.nom}"</p>
                    <a href="#" style="color: #8a5a2f; text-decoration: none; font-weight: 600; margin-top: 15px; display: inline-block;">Laisser un avis</a>
                </div>
                
                <div class="tab-pane" id="shipping">
                    <h3>Livraison</h3>
                    <p>Nous proposons une livraison partout en Tunisie sous 24-48h ouvrables. La livraison est gratuite pour toute commande supérieure à 80 DT.</p>
                    
                    <h3>Retours et Remboursements</h3>
                    <p>Si vous n'êtes pas satisfait de votre achat, vous disposez de 14 jours pour nous retourner le produit dans son emballage d'origine. Les frais de retour sont à votre charge.</p>
                </div>
            </div>
        </div>
        
        <!-- Similar Products -->
        <div class="similar-products">
            <h2 class="section-title">Vous pourriez aussi aimer</h2>
            
            <div class="product-grid">
                <c:forEach items="${similaireProduits}" var="similaire" begin="0" end="3">
                    <div class="product-card">
                        <div class="product-image-container">
                            <img src="${pageContext.request.contextPath}/images/${similaire.image}" class="product-image" alt="${similaire.nom}">
                            <button class="card-wishlist-btn" aria-label="Ajouter aux favoris">
                                <i class="far fa-heart"></i>
                            </button>
                        </div>
                        
                        <div class="card-product-info">
                            <a href="${pageContext.request.contextPath}/product/${similaire.id}" class="card-product-title">${similaire.nom}</a>
                            <p class="card-product-variety">Variété: ${similaire.variete}</p>
                            
                            <div class="card-product-rating">
                                <div class="card-stars">
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="far fa-star"></i>
                                </div>
                                <span class="card-rating-count">(42)</span>
                            </div>
                            
                            <p class="card-product-price">${similaire.prix} Dt/kg</p>
                        </div>
                        
                        <form action="${pageContext.request.contextPath}/panier" method="post">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="productId" value="${similaire.id}">
                            <input type="hidden" name="quantity" value="1">
                            <button type="submit" class="card-add-to-cart">
                                <i class="fas fa-shopping-cart"></i> Ajouter au panier
                            </button>
                        </form>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Thumbnail gallery functionality
            const thumbnails = document.querySelectorAll('.thumbnail');
            const mainImage = document.getElementById('mainImage');
            
            thumbnails.forEach(thumb => {
                thumb.addEventListener('click', function() {
                    // Remove active class from all thumbnails
                    thumbnails.forEach(t => t.classList.remove('active'));
                    
                    // Add active class to clicked thumbnail
                    this.classList.add('active');
                    
                    // Update main image
                    const imageSrc = this.getAttribute('data-image');
                    mainImage.src = '${pageContext.request.contextPath}/images/' + imageSrc;
                });
            });
            
            // Quantity selector functionality
            const quantityInput = document.getElementById('quantity');
            const decreaseBtn = document.getElementById('decrease');
            const increaseBtn = document.getElementById('increase');
            const hiddenQuantityInput = document.getElementById('quantityInput');
            
            // Update hidden input value when quantity changes
            quantityInput.addEventListener('change', function() {
                hiddenQuantityInput.value = this.value;
            });
            
            decreaseBtn.addEventListener('click', function() {
                let value = parseInt(quantityInput.value);
                if (value > 1) {
                    quantityInput.value = value - 1;
                    hiddenQuantityInput.value = quantityInput.value;
                }
            });
            
            increaseBtn.addEventListener('click', function() {
                let value = parseInt(quantityInput.value);
                let max = parseInt(quantityInput.getAttribute('max'));
                if (value < max) {
                    quantityInput.value = value + 1;
                    hiddenQuantityInput.value = quantityInput.value;
                }
            });
            
            // Tabs functionality
            const tabButtons = document.querySelectorAll('.tab-btn');
            const tabPanes = document.querySelectorAll('.tab-pane');
            
            tabButtons.forEach(button => {
                button.addEventListener('click', function() {
                    // Remove active class from all buttons and panes
                    tabButtons.forEach(btn => btn.classList.remove('active'));
                    tabPanes.forEach(pane => pane.classList.remove('active'));
                    
                    // Add active class to clicked button
                    this.classList.add('active');
                    
                    // Show corresponding tab pane
                    const tabId = this.getAttribute('data-tab');
                    document.getElementById(tabId).classList.add('active');
                });
            });
            
            // Wishlist functionality
            const wishlistBtn = document.querySelector('.wishlist-btn');
            const wishlistIcon = wishlistBtn.querySelector('i');
            
            wishlistBtn.addEventListener('click', function() {
                if (wishlistIcon.classList.contains('far')) {
                    wishlistIcon.classList.remove('far');
                    wishlistIcon.classList.add('fas');
                    alert('Produit ajouté aux favoris!');
                } else {
                    wishlistIcon.classList.remove('fas');
                    wishlistIcon.classList.add('far');
                    alert('Produit retiré des favoris!');
                }
            });
            
            // Card wishlist buttons
            const cardWishlistBtns = document.querySelectorAll('.card-wishlist-btn');
            
            cardWishlistBtns.forEach(btn => {
                btn.addEventListener('click', function(e) {
                    e.preventDefault();
                    const icon = this.querySelector('i');
                    
                    if (icon.classList.contains('far')) {
                        icon.classList.remove('far');
                        icon.classList.add('fas');
                        icon.style.color = '#e74c3c';
                    } else {
                        icon.style.color = '';
                        icon.classList.remove('fas');
                        icon.classList.add('far');
                    }
                });
            });
        });
    </script>
</body>
</html>