<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/includes/header.jsp"/>
<%@ page import="java.util.List" %> 
<%@ page import="model.Produit" %> 
<!DOCTYPE html> 
<html lang="en"> 
<head>     
    <meta charset="UTF-8">     
    <meta name="viewport" content="width=device-width, initial-scale=1.0">     
    <title>Gestion des Dattes - Delicio</title>
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

        .products-container {
            background-color: #fff;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 4px 15px rgba(126, 78, 35, 0.08);
            margin-bottom: 30px;
        }

        .products-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .products-header h2 {
            color: #7e4e23;
            font-size: 1.3rem;
            font-weight: 600;
        }

        .add-product-btn {
            background-color: #7e4e23;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            font-weight: 500;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.3s ease;
            display: inline-flex;
            align-items: center;
        }

        .add-product-btn i {
            margin-right: 8px;
        }

        .add-product-btn:hover {
            background-color: #6a4119;
        }

        .filter-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding: 15px;
            background-color: #f8f4e9;
            border-radius: 8px;
        }

        .search-box {
            display: flex;
            align-items: center;
            background: white;
            border-radius: 6px;
            padding: 8px 15px;
            border: 1px solid #ddd;
            width: 300px;
        }

        .search-box input {
            border: none;
            outline: none;
            width: 100%;
            padding: 5px;
            font-size: 0.9rem;
        }

        .search-box i {
            color: #7e4e23;
            margin-right: 10px;
        }

        .filter-dropdown {
            position: relative;
            display: inline-block;
        }

        .filter-btn {
            background-color: white;
            border: 1px solid #ddd;
            padding: 10px 20px;
            border-radius: 6px;
            font-weight: 500;
            cursor: pointer;
            display: flex;
            align-items: center;
        }

        .filter-btn i {
            margin-right: 8px;
            color: #7e4e23;
        }

        .filter-dropdown-content {
            display: none;
            position: absolute;
            background-color: #fff;
            min-width: 160px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 1;
            border-radius: 6px;
            margin-top: 5px;
            right: 0;
        }

        .filter-dropdown-content a {
            color: #333;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            transition: background-color 0.3s ease;
        }

        .filter-dropdown-content a:hover {
            background-color: #f8f4e9;
        }

        .filter-dropdown:hover .filter-dropdown-content {
            display: block;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        table th, table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        table th {
            background-color: #f8f4e9;
            color: #7e4e23;
            font-weight: 600;
            font-size: 0.9rem;
        }

        table tr:hover td {
            background-color: #fdfbf7;
        }

        .product-image {
            width: 60px;
            height: 60px;
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

        .stock-indicator {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
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

        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        .pagination-btn {
            padding: 8px 15px;
            margin: 0 5px;
            border-radius: 4px;
            background-color: white;
            border: 1px solid #ddd;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .pagination-btn.active {
            background-color: #7e4e23;
            color: white;
            border-color: #7e4e23;
        }

        .pagination-btn:hover:not(.active) {
            background-color: #f8f4e9;
        }

        /* Modal styles for add/edit product */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.5);
        }

        .modal-content {
            background-color: #fff;
            margin: 5% auto;
            padding: 30px;
            border-radius: 10px;
            width: 70%;
            max-width: 800px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.2);
            position: relative;
        }

        .close-modal {
            position: absolute;
            top: 20px;
            right: 30px;
            font-size: 1.5rem;
            font-weight: bold;
            color: #7e4e23;
            cursor: pointer;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #555;
        }

        .form-control {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 0.95rem;
        }

        .form-control:focus {
            border-color: #7e4e23;
            outline: none;
        }

        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }

        .modal-footer {
            margin-top: 30px;
            display: flex;
            justify-content: flex-end;
        }

        .submit-btn {
            background-color: #7e4e23;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 6px;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .submit-btn:hover {
            background-color: #6a4119;
        }

        .cancel-btn {
            background-color: #f8f4e9;
            color: #7e4e23;
            border: 1px solid #7e4e23;
            padding: 12px 25px;
            border-radius: 6px;
            font-weight: 500;
            cursor: pointer;
            margin-right: 10px;
            transition: all 0.3s ease;
        }

        .cancel-btn:hover {
            background-color: #eee;
        }

        .text-center {
            text-align: center;
        }

        .modal-title {
            margin-bottom: 20px;
            color: #7e4e23;
            font-weight: 600;
        }

        .form-row {
            display: flex;
            margin: 0 -10px;
        }

        .form-col {
            flex: 1;
            padding: 0 10px;
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

            .form-row {
                flex-direction: column;
            }

            .modal-content {
                width: 90%;
            }
        }

        @media (max-width: 768px) {
            .filter-bar {
                flex-direction: column;
                align-items: flex-start;
            }

            .search-box {
                width: 100%;
                margin-bottom: 15px;
            }

            .filter-dropdown {
                align-self: flex-end;
            }

            .add-product-btn {
                margin-top: 10px;
                width: 100%;
                justify-content: center;
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

            table {
                display: block;
                overflow-x: auto;
                white-space: nowrap;
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
                <h1>Gestion des Dattes</h1>
               
            </div>

            <!-- Products Container -->
            <div class="products-container">
                <div class="products-header">
                    <h2>Tous les Produits</h2>
                    <button id="addProductBtn" class="add-product-btn">
                        <i class="fas fa-plus"></i> Ajouter un produit
                    </button>
                </div>

                <!-- Filter and Search Bar -->
                <div class="filter-bar">
                    <div class="search-box">
                        <i class="fas fa-search"></i>
                        <input type="text" id="searchInput" placeholder="Rechercher un produit...">
                    </div>
                    <div class="filter-dropdown">
                        <button class="filter-btn">
                            <i class="fas fa-filter"></i> Filtrer par variété
                        </button>
                        <div class="filter-dropdown-content">
                            <a href="${pageContext.request.contextPath}/admin/products">Tous</a>
                            <c:forEach var="variete" items="${varietes}">
                                <a href="${pageContext.request.contextPath}/admin/products?variete=${variete}">${variete}</a>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                <!-- Products Table -->
                <table>
                    <thead>
                        <tr>
                            <th>Image</th>
                            <th>Nom</th>
                            <th>Variété</th>
                            <th>Prix (DT)</th>
                            <th>Stock</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty produits}">
                                <c:forEach var="produit" items="${produits}">
                                    <tr>
                                        <td>
                                            <img src="${pageContext.request.contextPath}/images/${produit.image}" 
                                                 alt="${produit.nom}" 
                                                 class="product-image"
                                                 onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/default_product.jpg';">
                                        </td>
                                        <td>${produit.nom}</td>
                                        <td>${produit.variete}</td>
                                        <td>${produit.prix}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${produit.stock > 20}">
                                                    <span class="stock-indicator stock-high">${produit.stock}</span>
                                                </c:when>
                                                <c:when test="${produit.stock > 5 && produit.stock <= 20}">
                                                    <span class="stock-indicator stock-medium">${produit.stock}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="stock-indicator stock-low">${produit.stock}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <button class="action-btn btn-view view-product" data-id="${produit.id}">Voir</button>
                                            <button class="action-btn btn-edit edit-product" data-id="${produit.id}">Modifier</button>
                                            <a href="${pageContext.request.contextPath}/admin/product/delete?id=${produit.id}" 
                                               class="action-btn btn-delete"
                                               onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce produit?')">Supprimer</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="6" class="text-center">Aucun produit disponible</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>

                <!-- Pagination -->
                <div class="pagination">
                    <button class="pagination-btn"><i class="fas fa-chevron-left"></i></button>
                    <button class="pagination-btn active">1</button>
                    <button class="pagination-btn">2</button>
                    <button class="pagination-btn">3</button>
                    <button class="pagination-btn"><i class="fas fa-chevron-right"></i></button>
                </div>
            </div>
        </main>
    </div>

    <!-- Modal for Adding Product -->
    <div id="addProductModal" class="modal">
        <div class="modal-content">
            <span class="close-modal">&times;</span>
            <h2 class="modal-title">Ajouter un nouveau produit</h2>
            <form action="${pageContext.request.contextPath}/admin/product/add" method="post" enctype="multipart/form-data">
                <div class="form-row">
                    <div class="form-col">
                        <div class="form-group">
                            <label for="nom">Nom du produit</label>
                            <input type="text" id="nom" name="nom" class="form-control" required>
                        </div>
                    </div>
                    <div class="form-col">
                        <div class="form-group">
                            <label for="variete">Variété</label>
                            <input type="text" id="variete" name="variete" class="form-control" required>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-col">
                        <div class="form-group">
                            <label for="prix">Prix (DT)</label>
                            <input type="number" id="prix" name="prix" class="form-control" step="0.01" min="0" required>
                        </div>
                    </div>
                    <div class="form-col">
                        <div class="form-group">
                            <label for="stock">Stock</label>
                            <input type="number" id="stock" name="stock" class="form-control" min="0" required>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea id="description" name="description" class="form-control" required></textarea>
                </div>
                <div class="form-group">
                    <label for="image">Image du produit</label>
                    <input type="file" id="image" name="image" class="form-control" accept="image/*">
                </div>
                <div class="modal-footer">
                    <button type="button" class="cancel-btn" id="closeAddModal">Annuler</button>
                    <button type="submit" class="submit-btn">Ajouter le produit</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Modal for Editing Product -->
    <div id="editProductModal" class="modal">
        <div class="modal-content">
            <span class="close-modal">&times;</span>
            <h2 class="modal-title">Modifier le produit</h2>
            <form action="${pageContext.request.contextPath}/admin/product/edit" method="post" enctype="multipart/form-data">
                <input type="hidden" id="editId" name="id">
                <div class="form-row">
                    <div class="form-col">
                        <div class="form-group">
                            <label for="editNom">Nom du produit</label>
                            <input type="text" id="editNom" name="nom" class="form-control" required>
                        </div>
                    </div>
                    <div class="form-col">
                        <div class="form-group">
                            <label for="editVariete">Variété</label>
                            <input type="text" id="editVariete" name="variete" class="form-control" required>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-col">
                        <div class="form-group">
                            <label for="editPrix">Prix (DT)</label>
                            <input type="number" id="editPrix" name="prix" class="form-control" step="0.01" min="0" required>
                        </div>
                    </div>
                    <div class="form-col">
                        <div class="form-group">
                            <label for="editStock">Stock</label>
                            <input type="number" id="editStock" name="stock" class="form-control" min="0" required>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="editDescription">Description</label>
                    <textarea id="editDescription" name="description" class="form-control" required></textarea>
                </div>
                <div class="form-group">
                    <label for="editImage">Image du produit</label>
                    <input type="file" id="editImage" name="image" class="form-control" accept="image/*">
                    <small>Laissez vide pour conserver l'image actuelle</small>
                </div>
                <div class="form-group">
                    <img id="currentImage" src="" alt="Current product image" style="max-width: 100px; max-height: 100px; display: block; margin-top: 10px;">
                </div>
                <div class="modal-footer">
                    <button type="button" class="cancel-btn" id="closeEditModal">Annuler</button>
                    <button type="submit" class="submit-btn">Enregistrer les modifications</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Modal for Viewing Product Details -->
    <div id="viewProductModal" class="modal">
        <div class="modal-content">
            <span class="close-modal">&times;</span>
            <h2 class="modal-title">Détails du produit</h2>
            <div style="display: flex; margin-bottom: 20px;">
                <div style="flex: 1; padding-right: 20px;">
                    <img id="viewImage" src="" alt="Product image" style="max-width: 100%; border-radius: 8px;">
                </div>
                <div style="flex: 2;">
                    <h3 id="viewNom" style="color: #7e4e23; margin-bottom: 10px; font-size: 1.5rem;"></h3>
                    <p><strong>Variété:</strong> <span id="viewVariete"></span></p>
                    <p><strong>Prix:</strong> <span id="viewPrix"></span> DT</p>
                    <p><strong>Stock:</strong> <span id="viewStock"></span> unités</p>
                </div>
            </div>
            <div>
                <h4 style="color: #7e4e23; margin-bottom: 10px;">Description</h4>
                <p id="viewDescription" style="line-height: 1.7;"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="cancel-btn" id="closeViewModal">Fermer</button>
                <button type="button" class="submit-btn" id="editFromView">Modifier</button>
            </div>
        </div>
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

        // Modal functionality
        const addProductModal = document.getElementById('addProductModal');
        const editProductModal = document.getElementById('editProductModal');
        const viewProductModal = document.getElementById('viewProductModal');
        const addProductBtn = document.getElementById('addProductBtn');
        
        // Open add product modal
        addProductBtn.addEventListener('click', function() {
            addProductModal.style.display = 'block';
        });
        
        // Close add product modal
        document.getElementById('closeAddModal').addEventListener('click', function() {
            addProductModal.style.display = 'none';
        });
        
        // Close edit product modal
        document.getElementById('closeEditModal').addEventListener('click', function() {
            editProductModal.style.display = 'none';
        });
        
        // Close view product modal
         document.getElementById('closeViewModal').addEventListener('click', function() {
            viewProductModal.style.display = 'none';
        });
        
        // Close modals when clicking outside
        window.addEventListener('click', function(event) {
            if (event.target === addProductModal) {
                addProductModal.style.display = 'none';
            }
            if (event.target === editProductModal) {
                editProductModal.style.display = 'none';
            }
            if (event.target === viewProductModal) {
                viewProductModal.style.display = 'none';
            }
        });
        
        // Close modals with the X button
        document.querySelectorAll('.close-modal').forEach(closeBtn => {
            closeBtn.addEventListener('click', function() {
                this.closest('.modal').style.display = 'none';
            });
        });
        
        // View product functionality
        document.querySelectorAll('.view-product').forEach(btn => {
            btn.addEventListener('click', function() {
                const productId = this.getAttribute('data-id');
                // Fetch product details using AJAX
                fetch('${pageContext.request.contextPath}/admin/product/get?id=' + productId)
                    .then(response => response.json())
                    .then(product => {
                        // Populate view modal with product details
                        document.getElementById('viewNom').textContent = product.nom;
                        document.getElementById('viewVariete').textContent = product.variete;
                        document.getElementById('viewPrix').textContent = product.prix;
                        document.getElementById('viewStock').textContent = product.stock;
                        document.getElementById('viewDescription').textContent = product.description;
                        document.getElementById('viewImage').src = '${pageContext.request.contextPath}/images/' + product.image;
                        document.getElementById('viewImage').onerror = function() {
                            this.onerror = null;
                            this.src = '${pageContext.request.contextPath}/images/default_product.jpg';
                        };
                        
                        // Set up edit button from view modal
                        document.getElementById('editFromView').setAttribute('data-id', product.id);
                        document.getElementById('editFromView').addEventListener('click', function() {
                            viewProductModal.style.display = 'none';
                            // Trigger edit modal with same product id
                            const editBtns = document.querySelectorAll('.edit-product');
                            for (let btn of editBtns) {
                                if (btn.getAttribute('data-id') === this.getAttribute('data-id')) {
                                    btn.click();
                                    break;
                                }
                            }
                        });
                        
                        // Show the view modal
                        viewProductModal.style.display = 'block';
                    })
                    .catch(error => console.error('Error fetching product details:', error));
            });
        });
        
        // Edit product functionality
        document.querySelectorAll('.edit-product').forEach(btn => {
            btn.addEventListener('click', function() {
                const productId = this.getAttribute('data-id');
                // Fetch product details using AJAX
                fetch('${pageContext.request.contextPath}/admin/product/get?id=' + productId)
                    .then(response => response.json())
                    .then(product => {
                        // Populate edit modal with product details
                        document.getElementById('editId').value = product.id;
                        document.getElementById('editNom').value = product.nom;
                        document.getElementById('editVariete').value = product.variete;
                        document.getElementById('editPrix').value = product.prix;
                        document.getElementById('editStock').value = product.stock;
                        document.getElementById('editDescription').value = product.description;
                        document.getElementById('currentImage').src = '${pageContext.request.contextPath}/images/' + product.image;
                        document.getElementById('currentImage').onerror = function() {
                            this.onerror = null;
                            this.src = '${pageContext.request.contextPath}/images/default_product.jpg';
                        };
                        
                        // Show the edit modal
                        editProductModal.style.display = 'block';
                    })
                    .catch(error => console.error('Error fetching product details:', error));
            });
        });
        
        // Search functionality
        const searchInput = document.getElementById('searchInput');
        searchInput.addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase();
            const tableRows = document.querySelectorAll('tbody tr');
            
            tableRows.forEach(row => {
                const productName = row.querySelector('td:nth-child(2)').textContent.toLowerCase();
                const productVariety = row.querySelector('td:nth-child(3)').textContent.toLowerCase();
                
                if (productName.includes(searchTerm) || productVariety.includes(searchTerm)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        });
    </script>
</body> 
</html>