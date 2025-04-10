<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/includes/header.jsp"/>
<%@ page import="java.util.List" %> 
<%@ page import="model.Utilisateur" %> 
<!DOCTYPE html> 
<html lang="en"> 
<head>     
    <meta charset="UTF-8">     
    <meta name="viewport" content="width=device-width, initial-scale=1.0">     
    <title>Gestion des Clients - Delicio</title>
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
            gap: 15px;
        }

        .search-input {
            flex: 1;
            padding: 12px 15px;
            border: 1px solid #d4b68c;
            border-radius: 6px;
            font-size: 0.9rem;
            outline: none;
        }

        .search-input:focus {
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

        .role-badge {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .role-admin {
            background-color: rgba(126, 78, 35, 0.15);
            color: #7e4e23;
        }

        .role-client {
            background-color: rgba(39, 174, 96, 0.15);
            color: #27ae60;
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
                <div class="menu-item">
                    <i class="fas fa-shopping-cart"></i>
                    <span>Commande</span>
                </div>
                <div class="menu-item active">
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
                <h1>Gestion des Clients</h1>
                <div class="user-info">
                    <img src="${pageContext.request.contextPath}/images/admin-avatar.jpg"
                         alt="Admin"
                         onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/default-avatar.jpg';">
                    <span>Admin</span>
                </div>
            </div>

            <!-- Search Section -->
            <div class="search-container">
                <form class="search-form" action="${pageContext.request.contextPath}/admin/clients" method="GET">
                    <input type="text" name="search" class="search-input" placeholder="Rechercher par nom, email ou rôle..." value="${param.search}">
                    <button type="submit" class="search-btn">
                        <i class="fas fa-search"></i> Rechercher
                    </button>
                </form>
            </div>

            <!-- Users Table -->
            <div class="data-card">
                <h2>
                    Liste des Utilisateurs
                    <a href="${pageContext.request.contextPath}/admin/client/add" class="card-action">
                        <i class="fas fa-plus"></i> Nouveau Client
                    </a>
                </h2>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nom</th>
                            <th>Email</th>
                            <th>Rôle</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty utilisateurs}">
                                <c:forEach var="utilisateur" items="${utilisateurs}">
                                    <tr>
                                        <td>#${utilisateur.id}</td>
                                        <td>${utilisateur.nom}</td>
                                        <td>${utilisateur.email}</td>
                                        <td>
                                            <span class="role-badge role-${utilisateur.role.toLowerCase()}">${utilisateur.role}</span>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/admin/client/view?id=${utilisateur.id}" class="action-btn btn-view">
                                                <i class="fas fa-eye"></i> Voir
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/client/edit?id=${utilisateur.id}" class="action-btn btn-edit">
                                                <i class="fas fa-edit"></i> Modifier
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/client/delete?id=${utilisateur.id}" class="action-btn btn-delete" 
                                               onclick="return confirm('Êtes-vous sûr de vouloir supprimer cet utilisateur?')">
                                                <i class="fas fa-trash"></i> Supprimer
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="5" class="empty-message">Aucun utilisateur trouvé</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
                
                <!-- Pagination -->
                <c:if test="${not empty utilisateurs && totalPages > 1}">
                    <div class="pagination">
                        <c:if test="${currentPage > 1}">
                            <a href="${pageContext.request.contextPath}/admin/clients?page=${currentPage - 1}&search=${param.search}" class="page-link">
                                <i class="fas fa-chevron-left"></i> Précédent
                            </a>
                        </c:if>
                        
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <a href="${pageContext.request.contextPath}/admin/clients?page=${i}&search=${param.search}" 
                               class="page-link ${currentPage == i ? 'active' : ''}">
                                ${i}
                            </a>
                        </c:forEach>
                        
                        <c:if test="${currentPage < totalPages}">
                            <a href="${pageContext.request.contextPath}/admin/clients?page=${currentPage + 1}&search=${param.search}" class="page-link">
                                Suivant <i class="fas fa-chevron-right"></i>
                            </a>
                        </c:if>
                    </div>
                </c:if>
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