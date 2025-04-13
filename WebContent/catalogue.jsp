<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/includes/header.jsp"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Palmora - Premium Dates</title>
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
            height: 300px;
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
        
        .hero-subtitle {
            font-size: 1.2rem;
            margin-bottom: 1.5rem;
            max-width: 500px;
        }
        
        .hero-button {
            display: inline-block;
            background-color: #8a5a2f;
            color: #fff;
            border: none;
            padding: 0.8rem 1.5rem;
            font-size: 1rem;
            font-weight: 600;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.3s;
            max-width: fit-content;
        }
        
        .hero-button:hover {
            background-color: #6d4219;
        }
        
        /* Category Navigation */
        .category-nav {
            display: flex;
            justify-content: space-between;
            gap: 15px;
            padding: 0 1.5rem;
            margin-bottom: 25px;
            overflow-x: auto;
            -ms-overflow-style: none;
            scrollbar-width: none;
        }
        
        .category-nav::-webkit-scrollbar {
            display: none;
        }
        
        .category-item {
            display: flex;
            flex-direction: column;
            align-items: center;
            min-width: 100px;
            text-decoration: none;
            color: #333;
            transition: transform 0.2s;
        }
        
        .category-item:hover {
            transform: translateY(-5px);
        }
        
        .category-icon {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background-color: #f0e0c9;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 8px;
            box-shadow: 0 3px 6px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        
        .category-icon img {
            width: 90%;
            height: 90%;
            object-fit: cover;
        }
        
        .category-name {
            font-weight: 500;
            font-size: 0.9rem;
            text-align: center;
        }
        
        /* Featured Products Section */
        .section-title {
            font-size: 1.5rem;
            color: #333;
            margin: 1rem 1.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #d4a76a;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .view-all {
            font-size: 0.9rem;
            color: #8a5a2f;
            text-decoration: none;
            display: flex;
            align-items: center;
        }
        
        .view-all i {
            margin-left: 5px;
        }
        
        /* Product Grid */
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 20px;
            padding: 0 1.5rem;
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
        
        .product-badge {
            position: absolute;
            top: 10px;
            left: 10px;
            background-color: #ff8c00;
            color: white;
            font-size: 0.75rem;
            padding: 4px 8px;
            border-radius: 3px;
            font-weight: 600;
            z-index: 1;
        }
        
        .product-image-container {
            height: 160px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 12px;
            position: relative;
        }
        
        .product-image {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
        }
        
        .wishlist-btn {
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
        
        .wishlist-btn:hover {
            background: #fff;
            color: #e74c3c;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .product-info {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }
        
        .product-title {
            font-size: 1rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
            text-decoration: none;
        }
        
        .product-title:hover {
            color: #8a5a2f;
        }
        
        .product-varietee {
            font-size: 0.85rem;
            color: #666;
            margin-bottom: 6px;
            font-style: italic;
        }
        
        .product-rating {
            display: flex;
            align-items: center;
            margin-bottom: 8px;
        }
        
        .stars {
            color: #ff9900;
            font-size: 0.9rem;
            display: flex;
            margin-right: 5px;
        }
        
        .rating-count {
            font-size: 0.8rem;
            color: #666;
        }
        
        .product-price {
            font-weight: 700;
            font-size: 1.1rem;
            color: #8a5a2f;
            margin-top: auto;
            margin-bottom: 12px;
        }
        
        .add-to-cart {
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
        
        .add-to-cart:hover {
            background-color: #8a5a2f;
            color: #fff;
        }
        
        /* Promotional Banners */
        .promo-banners {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            padding: 0 1.5rem;
            margin-bottom: 2rem;
        }
        
        .promo-banner {
            background: linear-gradient(to right, #8a5a2f, #d4a76a);
            color: white;
            padding: 20px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        
        .promo-content {
            flex: 2;
        }
        
        .promo-title {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 8px;
        }
        
        .promo-text {
            font-size: 0.9rem;
            margin-bottom: 15px;
        }
        
        .promo-button {
            background-color: white;
            color: #8a5a2f;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s;
            text-decoration: none;
            display: inline-block;
        }
        
        .promo-button:hover {
            background-color: #f8f4e9;
        }
        
        .promo-image {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        
        .promo-image img {
            max-width: 100%;
            max-height: 250px;
        }
        
        /* Filters Section */
        .filters {
            background-color: #fff;
            padding: 15px;
            margin: 0 1.5rem 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            align-items: center;
        }
        
        .filter-label {
            font-weight: 600;
            color: #333;
            margin-right: 5px;
        }
        
        .filter-group {
            display: flex;
            align-items: center;
        }
        
        .filter-select {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            background-color: #f9f9f9;
            color: #333;
            font-size: 0.9rem;
        }
        
        .filter-search {
            flex-grow: 1;
            display: flex;
            position: relative;
        }
        
        .filter-search input {
            width: 100%;
            padding: 8px 12px;
            padding-left: 35px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 0.9rem;
        }
        
        .filter-search i {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: #8a5a2f;
        }
        
        /* Responsive Styles */
        @media (max-width: 1000px) {
            .promo-banners {
                grid-template-columns: 1fr;
            }
        }
        
        @media (max-width: 768px) {
            .hero-title {
                font-size: 2rem;
            }
            
            .hero-subtitle {
                font-size: 1rem;
            }
            
            .product-grid {
                grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
            }
            
            .filters {
                flex-direction: column;
                align-items: stretch;
            }
            
            .filter-group {
                width: 100%;
            }
            
            .filter-select {
                flex-grow: 1;
            }
        }
        
        @media (max-width: 480px) {
            .hero-banner {
                height: 220px;
            }
            
            .hero-title {
                font-size: 1.5rem;
            }
            
            .category-nav {
                padding: 0 1rem;
            }
            
            .product-grid {
                grid-template-columns: repeat(2, 1fr);
                padding: 0 1rem;
                gap: 15px;
            }
            
            .section-title, .filters, .promo-banners {
                padding: 0 1rem;
                margin: 1rem;
            }
        }
    </style>
</head>
<body>
    <!-- Hero Banner -->
    <div class="hero-banner">
        <img src="images/bgLogin.avif" alt="Selection de dattes premium" class="hero-image">
        <div class="hero-content">
            <h1 class="hero-title">Découvrez nos dattes d'exception</h1>
            <p class="hero-subtitle">Sélection premium de dattes fraîches, directement des producteurs aux meilleurs prix</p>
            <a href="#products" class="hero-button">Découvrir</a>
        </div>
    </div>
    
    <!-- Category Navigation -->
    <div class="category-nav">
        <a href="#deglet" class="category-item">
            <div class="category-icon">
                <img src="images/deglet.jpg" alt="Deglet Nour">
            </div>
            <span class="category-name">Deglet Nour</span>
        </a>
        <a href="#medjool" class="category-item">
            <div class="category-icon">
                <img src="images/medjool.jpg" alt="Medjool">
            </div>
            <span class="category-name">Medjool</span>
        </a>
        <a href="#bio" class="category-item">
            <div class="category-icon">
                <img src="images/bio.png" alt="Bio">
            </div>
            <span class="category-name">Bio</span>
        </a>
        <a href="#pack" class="category-item">
            <div class="category-icon">
                <img src="images/gift-box.webp" alt="Idées Cadeaux">
            </div>
            <span class="category-name">Coffrets</span>
        </a>
        <a href="#gift" class="category-item">
            <div class="category-icon">
                <img src="images/premium-box.webp" alt="Coffrets">
            </div>
            <span class="category-name">Cadeaux</span>
        </a>
    </div>
    
    <!-- Filters Section -->
    <div class="filters">
        <div class="filter-group">
            <span class="filter-label">Trier par:</span>
            <select class="filter-select">
                <option value="popularity">Popularité</option>
                <option value="price-asc">Prix: croissant</option>
                <option value="price-desc">Prix: décroissant</option>
                <option value="newest">Nouveautés</option>
            </select>
        </div>
        
        <div class="filter-group">
            <span class="filter-label">Variété:</span>
            <select class="filter-select">
                <option value="all">Toutes</option>
                <option value="deglet">Deglet Nour</option>
                <option value="medjool">Medjool</option>
                <option value="khouat">Khouat Allig</option>
                <option value="other">Autres</option>
            </select>
        </div>
        
        <div class="filter-search">
            <i class="fas fa-search"></i>
            <input type="text" id="productSearch" placeholder="Rechercher des dattes..." aria-label="Rechercher">
        </div>
    </div>
    
    <!-- Best Sellers Section -->
    <div id="products">
        <h2 class="section-title">
            Meilleures Ventes
            <a href="#allproducts" class="view-all">Voir tout <i class="fas fa-chevron-right"></i></a>
        </h2>
        
        <div class="product-grid">
            <c:forEach items="${produits}" var="produit" begin="0" end="5">
            
                <div class="product-card" data-name="${produit.nom.toLowerCase()}" data-variety="${produit.variete.toLowerCase()}">
                    <c:if test="${produit.stock < 10}">
                        <span class="product-badge">Stock limité</span>
                    </c:if>
                    
                    <div class="product-image-container">
                        <c:if test="${not empty produit.image}">
                        
                            <img src="images/${produit.image}" class="product-image" alt="${produit.nom}">
                        </c:if>
                        <button class="wishlist-btn" aria-label="Ajouter aux favoris">
                            <i class="fas fa-heart"></i>
                        </button>
                    </div>
                    
                    <div class="product-info">
                        <a href="${pageContext.request.contextPath}/product/${produit.id}" class="product-title">${produit.nom}</a>
                        <p class="product-varietee">Variété: ${produit.variete}</p>
                        
                        <div class="product-rating">
                            <div class="stars">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star-half-alt"></i>
                            </div>
                            <span class="rating-count">(68)</span>
                        </div>
                        
                        <p class="product-price">${produit.prix} Dt/kg</p>
                    </div>
                    
                    <form action="${pageContext.request.contextPath}/panier" method="post">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productId" value="${produit.id}">
                        <input type="hidden" name="quantity" value="1">
                        <button type="submit" class="add-to-cart">
                            <i class="fas fa-shopping-cart"></i> Ajouter au panier
                        </button>
                    </form>
                </div>
            </c:forEach>
        </div>
    </div>
    
    <!-- Promotional Banners -->
    <div class="promo-banners">
        <div class="promo-banner">
            <div class="promo-content">
                <h3 class="promo-title">Livraison Gratuite</h3>
                <p class="promo-text">Pour toute commande supérieure à 80 DT</p>
                <a href="#" class="promo-button">En savoir plus</a>
            </div>
            <div class="promo-image">
                <img src="images/delivery.png" alt="Livraison gratuite">
            </div>
        </div>
        
        <div class="promo-banner">
            <div class="promo-content">
                <h3 class="promo-title">Offre Spéciale Ramadan</h3>
                <p class="promo-text">-15% sur une sélection de coffrets</p>
                <a href="#" class="promo-button">Découvrir</a>
            </div>
            <div class="promo-image">
                <img src="images/ramadan.png" alt="Offre Ramadan">
            </div>
        </div>
    </div>
    
    <!-- New Arrivals Section -->
    <h2 class="section-title">
        Nouveautés
        <a href="#new" class="view-all">Voir tout <i class="fas fa-chevron-right"></i></a>
    </h2>
    
    <div class="product-grid">
        <c:forEach items="${produits}" var="produit" begin="4" end="10">
            <div class="product-card" data-name="${produit.nom.toLowerCase()}" data-variety="${produit.variete.toLowerCase()}">
                <div class="product-image-container">
                    <c:if test="${not empty produit.image}">
                    <img src="images/${produit.image}" class="product-image" alt="${produit.nom}">
                    </c:if>
                    <button class="wishlist-btn" aria-label="Ajouter aux favoris">
                        <i class="fas fa-heart"></i>
                    </button>
                </div>
                
                <div class="product-info">
                    <a href="${pageContext.request.contextPath}/product/${produit.id}" class="product-title">${produit.nom}</a>
                    <p class="product-varietee">Variété: ${produit.variete}</p>
                    
                    <div class="product-rating">
                        <div class="stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="far fa-star"></i>
                        </div>
                        <span class="rating-count">(42)</span>
                    </div>
                    
                    <p class="product-price">${produit.prix} Dt/kg</p>
                </div>
                
                <form action="${pageContext.request.contextPath}/panier" method="post">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="productId" value="${produit.id}">
                    <input type="hidden" name="quantity" value="1">
                    <button type="submit" class="add-to-cart">
                        <i class="fas fa-shopping-cart"></i> Ajouter au panier
                    </button>
                </form>
            </div>
        </c:forEach>
    </div>
    
    <!-- Featured Categories Section -->
    <h2 class="section-title">
        Collections Premium
        <a href="#collections" class="view-all">Voir tout <i class="fas fa-chevron-right"></i></a>
    </h2>
    
    <div class="product-grid">
        <!-- Featured Collection Items -->
        <div class="product-card">
            <div class="product-image-container">
                <img src="images/gift-box.webp" class="product-image" alt="Coffret Premium">
                <button class="wishlist-btn" aria-label="Ajouter aux favoris">
                    <i class="fas fa-heart"></i>
                </button>
            </div>
            
            <div class="product-info">
                <a href="#" class="product-title">Coffret Prestige</a>
                <p class="product-varietee">Assortiment de variétés</p>
                
                <div class="product-rating">
                    <div class="stars">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                    <span class="rating-count">(124)</span>
                </div>
                
                <p class="product-price">120 Dt</p>
            </div>
            
            <form action="${pageContext.request.contextPath}/panier" method="post">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="productId" value="premium1">
                <input type="hidden" name="quantity" value="1">
                <button type="submit" class="add-to-cart">
                    <i class="fas fa-shopping-cart"></i> Ajouter au panier
                </button>
            </form>
        </div>
        
        <div class="product-card">
            <div class="product-image-container">
                <img src="images/premium-box.webp" class="product-image" alt="Coffret Cadeau">
                <button class="wishlist-btn" aria-label="Ajouter aux favoris">
                    <i class="fas fa-heart"></i>
                </button>
            </div>
            
            <div class="product-info">
                <a href="#" class="product-title">Coffret Cadeau</a>
                <p class="product-varietee">Medjool Premium</p>
                
                <div class="product-rating">
                    <div class="stars">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                    </div>
                    <span class="rating-count">(86)</span>
                </div>
                
                <p class="product-price">95 Dt</p>
            </div>
            
            <form action="${pageContext.request.contextPath}/panier" method="post">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="productId" value="premium2">
                <input type="hidden" name="quantity" value="1">
                <button type="submit" class="add-to-cart">
                    <i class="fas fa-shopping-cart"></i> Ajouter au panier
                </button>
            </form>
        </div>
        
        <div class="product-card">
            <span class="product-badge">Nouveau</span>
            <div class="product-image-container">
                <img src="images/deglet-pack.jpg" class="product-image" alt="Pack Dégustation">
                <button class="wishlist-btn" aria-label="Ajouter aux favoris">
                    <i class="fas fa-heart"></i>
                </button>
            </div>
            
            <div class="product-info">
                <a href="#" class="product-title">Pack Dégustation</a>
                <p class="product-varietee">Variétés Mixtes</p>
                
                <div class="product-rating">
                    <div class="stars">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="far fa-star"></i>
                    </div>
                    <span class="rating-count">(38)</span>
                </div>
                
                <p class="product-price">65 Dt</p>
            </div>
            
            <form action="${pageContext.request.contextPath}/panier" method="post">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="productId" value="premium3">
                <input type="hidden" name="quantity" value="1">
                <button type="submit" class="add-to-cart">
                    <i class="fas fa-shopping-cart"></i> Ajouter au panier
                </button>
            </form>
        </div>
        
        <div class="product-card">
            <div class="product-image-container">
                <img src="images/bio.png" class="product-image" alt="Sélection Bio">
                <button class="wishlist-btn" aria-label="Ajouter aux favoris">
                    <i class="fas fa-heart"></i>
                </button>
            </div>
            
            <div class="product-info">
                <a href="#" class="product-title">Sélection Bio</a>
                <p class="product-varietee">Agriculture Biologique</p>
                
                <div class="product-rating">
                    <div class="stars">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                    <span class="rating-count">(52)</span>
                </div>
                
                <p class="product-price">85 Dt</p>
            </div>
            
            <form action="${pageContext.request.contextPath}/panier" method="post">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="productId" value="premium4">
                <input type="hidden" name="quantity" value="1">
                <button type="submit" class="add-to-cart">
                    <i class="fas fa-shopping-cart"></i> Ajouter au panier
                </button>
            </form>
        </div>
    </div>
    
    <!-- Features Section -->
    <div style="background-color: #f8f4e9; padding: 2rem 1.5rem; margin: 2rem 0;">
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 2rem; max-width: 1200px; margin: 0 auto;">
            <div style="display: flex; flex-direction: column; align-items: center; text-align: center;">
                <div style="font-size: 2.5rem; color: #8a5a2f; margin-bottom: 1rem;">
                    <i class="fas fa-truck"></i>
                </div>
                <h3 style="font-size: 1.2rem; color: #333; margin-bottom: 0.5rem;">Livraison Rapide</h3>
                <p style="color: #666; font-size: 0.9rem;">Livraison sous 24-48h partout en Tunisie</p>
            </div>
            
            <div style="display: flex; flex-direction: column; align-items: center; text-align: center;">
                <div style="font-size: 2.5rem; color: #8a5a2f; margin-bottom: 1rem;">
                    <i class="fas fa-leaf"></i>
                </div>
                <h3 style="font-size: 1.2rem; color: #333; margin-bottom: 0.5rem;">Produits Frais</h3>
                <p style="color: #666; font-size: 0.9rem;">Directement des producteurs à votre table</p>
            </div>
            
            <div style="display: flex; flex-direction: column; align-items: center; text-align: center;">
                <div style="font-size: 2.5rem; color: #8a5a2f; margin-bottom: 1rem;">
                    <i class="fas fa-lock"></i>
                </div>
                <h3 style="font-size: 1.2rem; color: #333; margin-bottom: 0.5rem;">Paiement Sécurisé</h3>
                <p style="color: #666; font-size: 0.9rem;">Transactions cryptées et sécurisées</p>
            </div>
            
            <div style="display: flex; flex-direction: column; align-items: center; text-align: center;">
                <div style="font-size: 2.5rem; color: #8a5a2f; margin-bottom: 1rem;">
                    <i class="fas fa-headset"></i>
                </div>
                <h3 style="font-size: 1.2rem; color: #333; margin-bottom: 0.5rem;">Service Client</h3>
                <p style="color: #666; font-size: 0.9rem;">Support disponible 7j/7 pour vous accompagner</p>
            </div>
        </div>
    </div>
    
    <!-- Newsletter Section -->
    <div style="background: linear-gradient(to right, #7e4e23, #8a5a2f); color: white; padding: 3rem 1.5rem; margin-bottom: 2rem; text-align: center;">
        <h2 style="font-size: 1.8rem; margin-bottom: 1rem;">Restez informé</h2>
        <p style="max-width: 600px; margin: 0 auto 1.5rem; font-size: 1rem;">Inscrivez-vous à notre newsletter pour recevoir nos offres exclusives et nos nouveautés</p>
        
        <form style="max-width: 500px; margin: 0 auto; display: flex; gap: 10px;">
            <input type="email" placeholder="Votre adresse email" required style="flex-grow: 1; padding: 0.8rem; border: none; border-radius: 4px; font-size: 1rem;">
            <button type="submit" style="background-color: #d4a76a; color: #333; border: none; padding: 0 1.5rem; border-radius: 4px; font-weight: 600; cursor: pointer; transition: background-color 0.3s;">S'inscrire</button>
        </form>
    </div>

    <!-- Product Script -->
    <script>
    document.addEventListener('DOMContentLoaded', function() {
        // Search functionality
        const productSearch = document.getElementById('productSearch');
        const productCards = document.querySelectorAll('.product-card');
        
        if (productSearch) {
            productSearch.addEventListener('input', function() {
                const searchTerm = this.value.toLowerCase().trim();
                
                productCards.forEach(card => {
                    const productName = card.getAttribute('data-name') || '';
                    const productVariety = card.getAttribute('data-variety') || '';
                    const titleElement = card.querySelector('.product-title');
                    const productTitle = titleElement ? titleElement.textContent.toLowerCase() : '';
                    
                    const isVisible = productName.includes(searchTerm) || 
                                     productVariety.includes(searchTerm) ||
                                     productTitle.includes(searchTerm);
                    
                    card.style.display = isVisible ? 'flex' : 'none';
                });
            });
        }
        
        // Wishlist functionality
        const wishlistButtons = document.querySelectorAll('.wishlist-btn');
        
        wishlistButtons.forEach(button => {
            button.addEventListener('click', function(e) {
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
        
        // Sort select functionality
        const sortSelect = document.querySelector('.filter-select');
        
        if (sortSelect) {
            sortSelect.addEventListener('change', function() {
                // Add sort functionality here
                console.log('Sort changed to: ' + this.value);
            });
        }
    });
    </script>
</body>
</html>