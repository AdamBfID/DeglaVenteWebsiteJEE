<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/includes/header.jsp"/>
<%@ page import="java.util.List" %> 
<%@ page import="model.Produit" %> 
<%@ page import="model.Commande" %> 
<!DOCTYPE html> 
<html lang="en"> 
<head>     
    <meta charset="UTF-8">     
    <meta name="viewport" content="width=device-width, initial-scale=1.0">     
    <title>Admin Dashboard - Delicio</title>
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

        .dashboard-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background-color: #fff;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 15px rgba(126, 78, 35, 0.08);
            border-left: 4px solid #7e4e23;
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-card h3 {
            color: #7e4e23;
            font-size: 1rem;
            margin-bottom: 10px;
            font-weight: 600;
        }

        .stat-card .stat-value {
            font-size: 1.8rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 5px;
        }

        .stat-card .stat-desc {
            font-size: 0.85rem;
            color: #777;
        }

        .data-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(500px, 1fr));
            gap: 30px;
            margin-bottom: 30px;
        }

        .data-card {
            background-color: #fff;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 4px 15px rgba(126, 78, 35, 0.08);
        }

        .data-card h2 {
            color: #7e4e23;
            font-size: 1.3rem;
            margin-bottom: 20px;
            font-weight: 600;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .data-card h2 .card-action {
            font-size: 0.85rem;
            color: #7e4e23;
            text-decoration: none;
            padding: 5px 12px;
            background-color: rgba(126, 78, 35, 0.1);
            border-radius: 20px;
            transition: all 0.3s ease;
        }

        .data-card h2 .card-action:hover {
            background-color: rgba(126, 78, 35, 0.2);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        table th, table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        table th {
            background-color: #f8f4e9;
            color: #7e4e23;
            font-weight: 600;
            font-size: 0.9rem;
        }

        table tr:last-child td {
            border-bottom: none;
        }

        table tr:hover td {
            background-color: #fdfbf7;
        }

        .status-pill {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .status-completed {
            background-color: rgba(39, 174, 96, 0.15);
            color: #27ae60;
        }

        .status-pending {
            background-color: rgba(242, 153, 74, 0.15);
            color: #f2994a;
        }

        .status-cancelled {
            background-color: rgba(235, 87, 87, 0.15);
            color: #eb5757;
        }

        .product-image {
            width: 50px;
            height: 50px;
            border-radius: 6px;
            object-fit: cover;
            border: 1px solid #eee;
        }

        .action-btn {
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 0.8rem;
            font-weight: 500;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
            margin-right: 5px;
        }

        .btn-view {
            background-color: rgba(126, 78, 35, 0.1);
            color: #7e4e23;
        }

        .btn-edit {
            background-color: rgba(242, 153, 74, 0.15);
            color: #f2994a;
        }

        .btn-delete {
            background-color: rgba(235, 87, 87, 0.15);
            color: #eb5757;
        }

        .action-btn:hover {
            opacity: 0.8;
        }

        .empty-message {
            text-align: center;
            padding: 40px 20px;
            color: #777;
            font-style: italic;
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

            .data-container {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .dashboard-stats {
                grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
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
                <h2> Admin</h2>
            </div>
            <div class="sidebar-menu">
                <div class="menu-item active">
                    <i class="fas fa-th-large"></i>
                    <span>Dashboard</span>
                </div>
                <div class="menu-item">
                    <i class="fas fa-box"></i>
                    <span>Les dattes:</span>
                </div>
                <div class="menu-item">
                    <i class="fas fa-shopping-cart"></i>
                    <span>Commande</span>
                </div>
                <div href="${pageContext.request.contextPath}/admin/clients"  class="menu-item">
                
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
                <h1>Dashboard</h1>
                <div class="user-info">
                    <img src="images/${produit.image}"
                         alt="Admin"
                         onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/default-avatar.jpg';">
                    <span>Admin</span>
                </div>
            </div>

            <!-- Statistics Cards -->
            <div class="dashboard-stats">
                <div class="stat-card">
                    <h3>Total produits</h3>
                    <div class="stat-value">${produits.size()}</div>
                    <div class="stat-desc">Disponibles</div>
                </div>
                <div class="stat-card">
                    <h3>Commandes recents</h3>
                    <div class="stat-value">${commandes.size()}</div>
                    <div class="stat-desc">la derniere periode</div>
                </div>
                <div class="stat-card">
                    <h3>Revenue totales</h3>
                    <div class="stat-value">
                        <%-- Calculate total revenue --%>
                        <% 
                            double totalRevenue = 0;
                            List<Commande> commandes = (List<Commande>) request.getAttribute("commandes");
                            if (commandes != null) {
                                for (Commande commande : commandes) {
                                    totalRevenue += commande.getMontantTotal();
                                }
                            }
                            out.print(String.format("%.2f", totalRevenue));
                        %> Dt
                    </div>
                    <div class="stat-desc">De toutes les commandes</div>
                </div>
                <div class="stat-card">
                    <h3>Commande en cours</h3>
                    <div class="stat-value">
                        <%-- Calculate pending orders --%>
                        <% 
                            int pendingOrders = 0;
                            if (commandes != null) {
                                for (Commande commande : commandes) {
                                    if ("pending".equalsIgnoreCase(commande.getStatut())) {
                                        pendingOrders++;
                                    }
                                }
                            }
                            out.print(pendingOrders);
                        %>
                    </div>
                    <div class="stat-desc">attention requis</div>
                </div>
            </div>

            <!-- Data Tables -->
            <div class="data-container">
                <!-- Products Table -->
                <div class="data-card">
                    <h2>
                        Recent Products
                        <a href="${pageContext.request.contextPath}/admin/products" class="card-action">Voir touts</a>
                    </h2>
                    <table>
                        <thead>
                            <tr>
                                <th>Image</th>
                                <th>Nom</th>
                                <th>Prix</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty produits}">
                                    <c:forEach var="produit" items="${produits}" begin="0" end="4">
                                        <tr>
                                            <td>
                                                <img src="images/${produit.image}" 
                                                     alt="${produit.nom}" 
                                                     class="product-image"
                                                     onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/default_product.jpg';">
                                            </td>
                                            <td>${produit.nom}</td>
                                            <td>${produit.prix}DT</td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/admin/product/view?id=${produit.id}" class="action-btn btn-view">Voir</a>
                                                <a href="${pageContext.request.contextPath}/admin/product/edit?id=${produit.id}" class="action-btn btn-edit">Modifier</a>
                                                <a href="${pageContext.request.contextPath}/admin/product/delete?id=${produit.id}" class="action-btn btn-delete" 
                                                   onclick="return confirm('Vous etes sur vous voulez supprimer ce produit?')">Supprimer</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="4" class="empty-message">Pas de produit disponible, Ajouter des produits</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>

                <!-- Orders Table -->
                <div class="data-card">
                    <h2>
                        Recent Orders
                        <a href="${pageContext.request.contextPath}/admin/orders" class="card-action">Voir touts</a>
                    </h2>
                    <table>
                        <thead>
                            <tr>
                                <th>Commande ID</th>
                                <th>Client</th>
                                <th>Date</th>
                                <th>Statuts</th>
                                <th>Total</th>
                            </tr>ss
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty commandes}">
                                    <c:forEach var="commande" items="${commandes}" begin="0" end="4">
                                        <tr>
                                            <td>#${commande.id}</td>
                                            <td>${commande.utilisateurId}</td>
                                            <td>${commande.dateCommande}</td>
                                            <td>
                                                <span class="status-pill status-${commande.statut.toLowerCase()}">${commande.statut}</span>
                                            </td>
                                            <td>${commande.montantTotal}DT</td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="5" class="empty-message">Aucun commandes trouvé</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="data-card">
                <h2>Quick Actions</h2>
                <div style="display: flex; gap: 15px; margin-top: 20px;">
                    <a href="${pageContext.request.contextPath}/admin/product/add" 
                       style="flex: 1; text-decoration: none; padding: 15px; text-align: center; background-color: #7e4e23; color: white; border-radius: 8px; font-weight: 500;">
                        <i class="fas fa-plus" style="margin-right: 8px;"></i>Ajouter un produit
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/order/pending" 
                       style="flex: 1; text-decoration: none; padding: 15px; text-align: center; background-color: #d4b68c; color: #7e4e23; border-radius: 8px; font-weight: 500;">
                        <i class="fas fa-tasks" style="margin-right: 8px;"></i>voir les commandes en cours
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/analytics" 
                       style="flex: 1; text-decoration: none; padding: 15px; text-align: center; background-color: #f8f4e9; color: #7e4e23; border: 1px solid #d4b68c; border-radius: 8px; font-weight: 500;">
                        <i class="fas fa-chart-line" style="margin-right: 8px;"></i>Voir les rapports
                    </a>
                </div>
            </div>
        </main>
    </div>

    <script>
        // Simple JavaScript for sidebar menu functionality
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