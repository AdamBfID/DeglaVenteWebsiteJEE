<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/includes/header.jsp"/>
<%@ page import="model.Produit" %> 
<!DOCTYPE html> 
<html lang="en"> 
<head>     
    <meta charset="UTF-8">     
    <meta name="viewport" content="width=device-width, initial-scale=1.0">     
    <title>Détails du Produit - Delicio</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>         
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Montserrat', sans-serif;
        }

        body {
            background-color: #f8f4e9;
            color: #333;
            line-height: 1.6;
            min-height: 100vh;
        }

        .dashboard-container {
            display: flex;
            min-height: 100vh;
        }

        .sidebar {
            width: 250px;
            background-color: #7e4e23;
            color: #fff;
            padding: 20px 0;
            box-shadow: 4px 0 10px rgba(0, 0, 0, 0.1);
            position: fixed;
            height: 100vh;
            overflow-y: auto;
        }

        .logo {
            text-align: center;
            padding: 20px 15px;
            margin-bottom: 30px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .logo h2 {
            color: #fff;
            font-weight: 700;
            font-size: 1.8rem;
            letter-spacing: 1px;
        }

        .sidebar-menu {
            padding: 0 15px;
        }

        .menu-item {
            padding: 12px 15px;
            margin-bottom: 5px;
            border-radius: 6px;
            transition: all 0.3s ease;
            cursor: pointer;
            display: flex;
            align-items: center;
            font-weight: 500;
        }

        .menu-item.active {
            background-color: #d4b68c;
            color: #7e4e23;
        }

        .menu-item:hover:not(.active) {
            background-color: rgba(212, 182, 140, 0.2);
        }

        .menu-item i {
            margin-right: 10px;
            font-size: 1.2rem;
        }

        .main-content {
            flex: 1;
            margin-left: 250px;
            padding: 20px 30px;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 2px solid #d4b68c;
        }

        .page-header h1 {
            color: #7e4e23;
            font-weight: 700;
            font-size: 1.8rem;
        }

        .user-info {
            display: flex;
            align-items: center;
        }

        .user-info img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 10px;
            border: 2px solid #d4b68c;
        }

        .user-info span {
            font-weight: 600;
            color: #7e4e23;
        }

        .product-container {
            background-color: #fff;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 4px 15px rgba(126, 78, 35, 0.08);
            margin-bottom: 30px;
        }

        .product-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .product-header h2 {
            color: #7e4e23;
            font-size: 1.5rem;
            font-weight: 600;
        }

        .back-btn {
            padding: 8px 20px;
            background-color: #f8f4e9;
            border: 1px solid #d4b68c;
            color: #7e4e23;
            border-radius: 6px;
            font-weight: 500;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
        }

        .back-btn i {
            margin-right: 8px;
        }

        .back-btn:hover {
            background-color: #d4b68c;
            color: #7e4e23;
        }

        .product-details {
            display: flex;
            gap: 40px;
        }

        .product-image-container {
            flex: 1;
        }

        .product-image {
            width: 100%;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            object-fit: cover;
            max-height: 400px;
        }

        .product-info {
            flex: 2;
        }

        .product-name {
            font-size: 1.8rem;
            color: #7e4e23;
            margin-bottom: 10px;
            font-weight: 700;
        }

        .product-meta {
            margin-bottom: 20px;
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }

        .meta-item {
            display: flex;
            gap: 10px;
            margin-bottom: 12px;
        }

        .meta-label {
            font-weight: 600;
            color: #666;
            width: 100px;
        }

        .meta-value {
            flex: 1;
        }

        .product-description h3 {
            font-size: 1.3rem;
            color: #7e4e23;
            margin-bottom: 15px;
            font-weight: 600;
        }

        .description-content {
            line-height: 1.8;
            color: #444;
        }

        .actions-container {
            margin-top: 30px;
            display: flex;
            gap: 15px;
        }

        .action-btn {
            padding: 12px 25px;
            border-radius: 6px;
            font-weight: 500;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
        }

        .btn-edit {
            background-color: #7e4e23;
            color: white;
        }

        .btn-delete {
            background-color: #f8f4e9;
            color: #eb5757;
            border: 1px solid #eb5757;
        }

        .action-btn i {
            margin-right: 8px;
        }

        .action-btn:hover {
            opacity: 0.9;
        }

        .stock-indicator {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            margin-left: 10px;
        }

        .stock-high {
            background-color: rgba(39, 174, 96, 0.15);
            color: #27ae60;
        }

        .stock-medium {
            background-color: rgba(242, 153, 74, 0.15);
            color: #f2994a;
        }

        .stock-low {
            background-color: rgba(235, 87, 87, 0.15);
            color: #eb5757;
        }

        @media (max-width: 992px) {
            .sidebar {
                width: 80px;
                transition: all 0.3s ease;
            }

            .logo h2 {
                display: none;
            }

            .menu-item span {
                display: none;
            }

            .menu-item i {
                margin-right: 0;
                font-size: 1.5rem;
            }

            .main-content {
                margin-left: 80px;
            }
        }

        @media (max-width: 768px) {
            .product-details {
                flex-direction: column;
            }

            .product-image-container {
                margin-bottom: 20px;
            }
        }

        @media (max-width: 576px) {
            .main-content {
                padding: 15px;
            }

            .page-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .user-info {
                margin-top: 15px;
            }

            .product-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .back-btn {
                margin-top: 15px;
            }

            .actions-container {
                flex-direction: column;
            }

            .action-btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
    <!-- Font Awesome icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head> 
<body>
    <div class="dashboard-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="logo">
                <h2>Admin</h2>
            </div>
            <div class="sidebar-menu">
                <div class="menu-item">
                    <i class="fas fa-th-large"></i>
                    <span>Dashboard</span>
                </div>
                <div class="menu-item active">
                    <i class="fas fa-box"></i>
                    <span>Les dattes</span>
                </div>
                <div class="menu-item">
                    <i class="fas fa-shopping-cart"></i>
                    <span>Commande</span>
                </div>
                <div class="menu-item">
                    <i class="fas fa-users"></i>
                    <span>Clients</span>
                </div>
                <div class="menu-item">
                    <i class="fas fa-chart-bar"></i>
                    <span>Analyse</span>
                </div>
            </div>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <div class="page-header">
                <h1>Détails du Produit</h1>
                <div class="user-info">
                    <img src="${pageContext.request.contextPath}/images/admin-avatar.jpg" 
                         alt="Admin"
                         onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/default-avatar.jpg';">
                    <span>Admin</span>
                </div>
            </div>

            <!-- Product Container -->
            <div class="product-container">
                <div class="product-header">
                    <h2>Fiche Produit</h2>
                    <a href="${pageContext.request.contextPath}/admin/products" class="back-btn">
                        <i class="fas fa-arrow-left"></i> Retour à la liste
                    </a>
                </div>

                <div class="product-details">
                    <div class="product-image-container">
                        <img src="${pageContext.request.contextPath}/images/${produit.image}" 
                             alt="${produit.nom}" 
                             class="product-image"
                             onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/default_product.jpg';">
                    </div>
                    <div class="product-info">
                        <h1 class="product-name">${produit.nom}</h1>
                        
                        <div class="product-meta">
                            <div class="meta-item">
                                <div class="meta-label">Variété:</div>
                                <div class="meta-value">${produit.variete}</div>
                            </div>
                            <div class="meta-item">
                                <div class="meta-label">Prix:</div>
                                <div class="meta-value">${produit.prix} DT</div>
                            </div>
                            <div class="meta-item">
                                <div class="meta-label">Stock:</div>
                                <div class="meta-value">
                                    ${produit.stock} unités
                                    <c:choose>
                                        <c:when test="${produit.stock > 20}">
                                            <span class="stock-indicator stock-high">En stock</span>
                                        </c:when>
                                        <c:when test="${produit.stock > 5 && produit.stock <= 20}">
                                            <span class="stock-indicator stock-medium">Stock limité</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="stock-indicator stock-low">Stock faible</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                        
                        <div class="product-description">
                            <h3>Description</h3>
                            <div class="description-content">
                                ${produit.description}
                            </div>
                        </div>
                        
                        <div class="actions-container">
                            <a href="${pageContext.request.contextPath}/admin/product/edit?id=${produit.id}" class="action-btn btn-edit">
                                <i class="fas fa-edit"></i> Modifier ce produit
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/product/delete?id=${produit.id}" 
                               class="action-btn btn-delete"
                               onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce produit?')">
                                <i class="fas fa-trash"></i> Supprimer ce produit
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script>
        // Menu navigation
        document.querySelectorAll('.menu-item').forEach(item => {
            item.addEventListener('click', function() {
                const isActive = this.classList.contains('active');
                if (!isActive) {
                    document.querySelector('.menu-item.active')?.classList.remove('active');
                    this.classList.add('active');
                    
                    // Navigation based on menu item
                    const text = this.querySelector('span').textContent.trim();
                    switch(text) {
                        case 'Dashboard':
                            window.location.href = "${pageContext.request.contextPath}/admin/dashboard";
                            break;
                        case 'Les dattes':
                            window.location.href = "${pageContext.request.contextPath}/admin/products";
                            break;
                        case 'Commande':
                            window.location.href = "${pageContext.request.contextPath}/admin/orders";
                            break;
                        case 'Clients':
                            window.location.href = "${pageContext.request.contextPath}/admin/clients";
                            break;
                        case 'Analyse':
                            window.location.href = "${pageContext.request.contextPath}/admin/analytics";
                            break;
                    }
                }
            });
        });
	</script>
	</body> 
</html>