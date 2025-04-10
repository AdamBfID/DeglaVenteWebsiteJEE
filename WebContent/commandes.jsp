<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="/WEB-INF/views/includes/header.jsp"/>
<%@ page import="java.util.List" %> 
<%@ page import="model.Commande" %> 
<%@ page import="model.Utilisateur" %> 
<!DOCTYPE html> 
<html lang="en"> 
<head>     
    <meta charset="UTF-8">     
    <meta name="viewport" content="width=device-width, initial-scale=1.0">     
    <title>Gestion des Commandes - Delicio</title>
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

        .search-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(126, 78, 35, 0.08);
            margin-bottom: 30px;
        }

        .search-form {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
        }

        .form-group {
            flex: 1;
            min-width: 200px;
        }

        .form-label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
            color: #7e4e23;
            font-size: 0.9rem;
        }

        .search-input, .select-input {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #d4b68c;
            border-radius: 6px;
            font-size: 0.9rem;
            outline: none;
        }

        .date-inputs {
            display: flex;
            gap: 10px;
        }

        .date-inputs input {
            flex: 1;
        }

        .search-input:focus, .select-input:focus {
            border-color: #7e4e23;
            box-shadow: 0 0 0 2px rgba(126, 78, 35, 0.2);
        }

        .search-btn {
            padding: 12px 20px;
            background-color: #7e4e23;
            color: #fff;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
            margin-top: 24px;
        }

        .search-btn:hover {
            background-color: #6a4120;
        }

        .data-card {
            background-color: #fff;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 4px 15px rgba(126, 78, 35, 0.08);
            margin-bottom: 30px;
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

        .status-processing {
            background-color: rgba(45, 156, 219, 0.15);
            color: #2d9cdb;
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

        .pagination {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 20px;
        }

        .page-link {
            padding: 8px 15px;
            border: 1px solid #d4b68c;
            color: #7e4e23;
            border-radius: 4px;
            text-decoration: none;
            font-size: 0.9rem;
            transition: all 0.3s ease;
        }

        .page-link.active {
            background-color: #7e4e23;
            color: #fff;
            border-color: #7e4e23;
        }

        .page-link:hover:not(.active) {
            background-color: #f8f4e9;
        }

        .export-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 15px;
            background-color: #7e4e23;
            color: white;
            border-radius: 4px;
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .export-btn:hover {
            background-color: #6a4120;
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
            .search-form {
                flex-direction: column;
            }
            
            .form-group {
                width: 100%;
            }
            
            .search-btn {
                width: 100%;
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
                <h2>Admin</h2>
            </div>
            <div class="sidebar-menu">
                <div class="menu-item">
                    <i class="fas fa-th-large"></i>
                    <span>Dashboard</span>
                </div>
                <div class="menu-item">
                    <i class="fas fa-box"></i>
                    <span>Les dattes</span>
                </div>
                <div class="menu-item active">
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
                <h1>Gestion des Commandes</h1>
                <div class="user-info">
                    <img src="${pageContext.request.contextPath}/images/admin-avatar.jpg"
                         alt="Admin"
                         onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/default-avatar.jpg';">
                    <span>Admin</span>
                </div>
            </div>

            <!-- Search Section -->
            <div class="search-container">
                <form class="search-form" action="${pageContext.request.contextPath}/admin/orders" method="GET">
                    <div class="form-group">
                        <label class="form-label">ID Commande</label>
                        <input type="text" name="orderId" class="search-input" placeholder="Rechercher par ID..." value="${param.orderId}">
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Client</label>
                        <input type="text" name="client" class="search-input" placeholder="Nom du client..." value="${param.client}">
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Statut</label>
                        <select name="status" class="select-input">
                            <option value="">Tous les statuts</option>
                            <option value="pending" ${param.status == 'pending' ? 'selected' : ''}>En attente</option>
                            <option value="processing" ${param.status == 'processing' ? 'selected' : ''}>En traitement</option>
                            <option value="completed" ${param.status == 'completed' ? 'selected' : ''}>Complété</option>
                            <option value="cancelled" ${param.status == 'cancelled' ? 'selected' : ''}>Annulé</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Période</label>
                        <div class="date-inputs">
                            <input type="date" name="dateFrom" class="search-input" value="${param.dateFrom}">
                            <input type="date" name="dateTo" class="search-input" value="${param.dateTo}">
                        </div>
                    </div>
                    
                    <button type="submit" class="search-btn">
                        <i class="fas fa-search"></i> Rechercher
                    </button>
                </form>
            </div>

            <!-- Orders Table -->
            <div class="data-card">
                <h2>
                    Liste des Commandes
                    <div>
                        <a href="${pageContext.request.contextPath}/admin/order/export?orderId=${param.orderId}&client=${param.client}&status=${param.status}&dateFrom=${param.dateFrom}&dateTo=${param.dateTo}" class="export-btn">
    <i class="fas fa-file-export"></i> Exporter
</a>
                    </div>
                </h2>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Client</th>
                            <th>Date</th>
                            <th>Montant</th>
                            <th>Statut</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty commandes}">
                                <c:forEach var="commande" items="${commandes}">
                                    <tr>
                                        <td>#${commande.id}</td>
                                        <td>
                                            <c:forEach var="utilisateur" items="${utilisateurs}">
                                                <c:if test="${utilisateur.id == commande.utilisateurId}">
                                                    ${utilisateur.nom}
                                                </c:if>
                                            </c:forEach>
                                        </td>
                                        <td><fmt:formatDate value="${commande.dateCommande}" pattern="dd/MM/yyyy HH:mm" /></td>
                                        <td>${commande.montantTotal} DT</td>
                                        <td>
                                            <span class="status-pill status-${commande.statut.toLowerCase()}">${commande.statut}</span>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/admin/order/view?id=${commande.id}" class="action-btn btn-view">
                                                <i class="fas fa-eye"></i> Détails
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/order/edit?id=${commande.id}" class="action-btn btn-edit">
                                                <i class="fas fa-edit"></i> Modifier
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/order/delete?id=${commande.id}" class="action-btn btn-delete" 
                                               onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette commande?')">
                                                <i class="fas fa-trash"></i> Supprimer
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="6" class="empty-message">Aucune commande trouvée</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
                
                <!-- Pagination -->
                <c:if test="${not empty commandes && totalPages > 1}">
                    <div class="pagination">
                        <c:if test="${currentPage > 1}">
                            <a href="${pageContext.request.contextPath}/admin/orders?page=${currentPage - 1}${searchParams}" class="page-link">
                                <i class="fas fa-chevron-left"></i> Précédent
                            </a>
                        </c:if>
                        
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <a href="${pageContext.request.contextPath}/admin/orders?page=${i}${searchParams}" 
                               class="page-link ${currentPage == i ? 'active' : ''}">
                                ${i}
                            </a>
                        </c:forEach>
                        
                        <c:if test="${currentPage < totalPages}">
                            <a href="${pageContext.request.contextPath}/admin/orders?page=${currentPage + 1}${searchParams}" class="page-link">
                                Suivant <i class="fas fa-chevron-right"></i>
                            </a>
                        </c:if>
                    </div>
                </c:if>
            </div>

            <!-- Order Stats -->
            <div class="dashboard-stats" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 20px; margin-bottom: 30px;">
                <div class="stat-card">
                    <h3>Total des commandes</h3>
                    <div class="stat-value">${totalOrders}</div>
                    <div class="stat-desc">Toutes les commandes</div>
                </div>
                <div class="stat-card">
                    <h3>Commandes en attente</h3>
                    <div class="stat-value">${pendingOrders}</div>
                    <div class="stat-desc">Attention requise</div>
                </div>
                <div class="stat-card">
                    <h3>Chiffre d'affaires</h3>
                    <div class="stat-value">${totalRevenue} DT</div>
                    <div class="stat-desc">Toutes commandes</div>
                </div>
                <div class="stat-card">
                    <h3>Commandes récentes</h3>
                    <div class="stat-value">${recentOrders}</div>
                    <div class="stat-desc">Dernières 24 heures</div>
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