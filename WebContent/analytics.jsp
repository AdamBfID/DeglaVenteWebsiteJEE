<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="/WEB-INF/views/includes/header.jsp"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sales Analytics</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Font Awesome icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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

        .stats-overview {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
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

        .analytics-row {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 30px;
            margin-bottom: 30px;
        }

        .analytics-card {
            background-color: #fff;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 4px 15px rgba(126, 78, 35, 0.08);
        }

        .analytics-card h2 {
            color: #7e4e23;
            font-size: 1.3rem;
            margin-bottom: 20px;
            font-weight: 600;
        }

        .chart-container {
            position: relative;
            height: 300px;
            width: 100%;
        }

        .top-products {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .product-item {
            display: flex;
            align-items: center;
            background-color: #fdfbf7;
            border-radius: 8px;
            padding: 12px;
            transition: all 0.3s ease;
        }

        .product-item:hover {
            transform: translateX(5px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
        }

        .product-img {
            width: 60px;
            height: 60px;
            border-radius: 6px;
            object-fit: cover;
            margin-right: 15px;
            border: 1px solid #eee;
        }

        .product-details {
            flex: 1;
        }

        .product-details h4 {
            font-size: 1rem;
            color: #333;
            margin-bottom: 5px;
        }

        .product-details p {
            font-size: 0.85rem;
            color: #777;
        }

        .product-sales {
            text-align: right;
        }

        .product-sales .quantity {
            font-size: 1.2rem;
            font-weight: 700;
            color: #7e4e23;
        }

        .product-sales .label {
            font-size: 0.8rem;
            color: #777;
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

        .status-en-attente {
            background-color: rgba(242, 153, 74, 0.15);
            color: #f2994a;
        }

        .status-expédié {
            background-color: rgba(47, 128, 237, 0.15);
            color: #2f80ed;
        }

        .status-livré {
            background-color: rgba(39, 174, 96, 0.15);
            color: #27ae60;
        }

        .inventory-status-low {
            color: #eb5757;
        }

        .inventory-status-medium {
            color: #f2994a;
        }

        .inventory-status-high {
            color: #27ae60;
        }

        .date-filter {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }

        .date-filter select, .date-filter input {
            padding: 8px 12px;
            border: 1px solid #d4b68c;
            border-radius: 6px;
            font-size: 0.9rem;
        }

        .date-filter button {
            padding: 8px 15px;
            background-color: #7e4e23;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .date-filter button:hover {
            background-color: #6a4219;
        }

        .timeline {
            position: relative;
            margin: 20px 0;
            padding-left: 30px;
        }

        .timeline:before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            width: 2px;
            height: 100%;
            background-color: #d4b68c;
        }

        .timeline-item {
            position: relative;
            padding-bottom: 25px;
        }

        .timeline-item:last-child {
            padding-bottom: 0;
        }

        .timeline-item:before {
            content: '';
            position: absolute;
            left: -34px;
            top: 0;
            width: 10px;
            height: 10px;
            border-radius: 50%;
            background-color: #7e4e23;
            border: 2px solid #f8f4e9;
        }

        .timeline-date {
            font-size: 0.85rem;
            color: #777;
            margin-bottom: 5px;
        }

        .timeline-content {
            background-color: white;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .timeline-content h4 {
            margin-bottom: 5px;
            color: #333;
        }

        .timeline-content p {
            font-size: 0.9rem;
            color: #777;
        }

        @media (max-width: 1200px) {
            .analytics-row {
                grid-template-columns: 1fr;
            }
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
            .stats-overview {
                grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
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
                <div class="menu-item">
                    <i class="fas fa-users"></i>
                    <span>Clients</span>
                </div>
                <div class="menu-item active">
                    <i class="fas fa-chart-bar"></i>
                    <span>Analyse</span>
                </div>
            </div>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <div class="page-header">
                <h1>Analyse des Ventes</h1>
                
            </div>

            <!-- Date Filters -->
            <div class="date-filter">
                <select id="periodFilter">
                    <option value="all">Toute la période</option>
                    <option value="month">Mois dernier</option>
                    <option value="quarter">Trimestre dernier</option>
                    <option value="year">Année dernière</option>
                </select>
                <input type="date" id="startDate">
                <input type="date" id="endDate">
                <button id="applyFilter">Appliquer</button>
            </div>

            <!-- Statistics Overview -->
            <div class="stats-overview">
                <div class="stat-card">
                    <h3>Revenue Total</h3>
                    <div class="stat-value">
                        <fmt:formatNumber value="${overallStats.totalRevenue}" type="number" maxFractionDigits="2"/> DT
                    </div>
                    <div class="stat-desc">De toutes les ventes</div>
                </div>
                <div class="stat-card">
                    <h3>Commandes Total</h3>
                    <div class="stat-value">${overallStats.totalOrders}</div>
                    <div class="stat-desc">Nombre de commandes</div>
                </div>
                <div class="stat-card">
                    <h3>Produits</h3>
                    <div class="stat-value">${overallStats.totalProducts}</div>
                    <div class="stat-desc">Types de dattes</div>
                </div>
                <div class="stat-card">
                    <h3>Valeur Moyenne</h3>
                    <div class="stat-value">
                        <fmt:formatNumber value="${overallStats.avgOrderValue}" type="number" maxFractionDigits="2"/> DT
                    </div>
                    <div class="stat-desc">Par commande</div>
                </div>
            </div>

            <!-- Sales Charts -->
            <div class="analytics-row">
                <div class="analytics-card">
                    <h2>Ventes Mensuelles</h2>
                    <div class="chart-container">
                        <canvas id="monthlySalesChart"></canvas>
                    </div>
                </div>
                <div class="analytics-card">
                    <h2>Répartition par Variété</h2>
                    <div class="chart-container">
                        <canvas id="varietyChart"></canvas>
                    </div>
                </div>
            </div>

            <!-- Product Analysis -->
            <div class="analytics-row">
                <div class="analytics-card">
                    <h2>Top 5 Produits</h2>
                    <div class="top-products">
                        <c:forEach var="product" items="${topProducts}">
                            <div class="product-item">
                                <img src="${pageContext.request.contextPath}/images/${product.image}" 
                                     alt="${product.nom}" 
                                     class="product-img"
                                     onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/default_product.jpg';">
                                <div class="product-details">
                                    <h4>${product.nom}</h4>
                                    <p>Variété: ${product.variete}</p>
                                </div>
                                <div class="product-sales">
                                    <div class="quantity">${product.totalQuantity}</div>
                                    <div class="label">vendus</div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <div class="analytics-card">
                    <h2>Status d'Inventaire</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>Produit</th>
                                <th>Variété</th>
                                <th>Prix</th>
                                <th>Stock</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${inventoryStatus}">
                                <tr>
                                    <td>${item.nom}</td>
                                    <td>${item.variete}</td>
                                    <td>${item.prix} DT</td>
                                    <td>${item.stock}</td>
                                    <td>
                                        <span class="inventory-status-${item.stockStatus}">
                                            <c:choose>
                                                <c:when test="${item.stockStatus eq 'low'}">
                                                    <i class="fas fa-exclamation-circle"></i> Bas
                                                </c:when>
                                                <c:when test="${item.stockStatus eq 'medium'}">
                                                    <i class="fas fa-check-circle"></i> Moyen
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fas fa-check-circle"></i> Élevé
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Product Revenue and Timeline -->
            <div class="analytics-row">
                <div class="analytics-card">
                    <h2>Revenu par Produit</h2>
                    <div class="chart-container">
                        <canvas id="productRevenueChart"></canvas>
                    </div>
                </div>
                <div class="analytics-card">
                    <h2>Activité Récente</h2>
                    <div class="timeline">
                        <c:forEach var="order" items="${recentOrders}">
                            <div class="timeline-item">
                                <div class="timeline-date">
                                    <fmt:formatDate value="${order.dateCommande}" pattern="dd MMM yyyy, HH:mm" />
                                </div>
                                <div class="timeline-content">
                                    <h4>Commande #${order.id}</h4>
                                    <p>Client: ${order.clientNom}</p>
                                    <p>Montant: <strong><fmt:formatNumber value="${order.totalAmount}" type="number" maxFractionDigits="2"/> DT</strong></p>
                                    <p>Status: <span class="status-pill status-${order.statut}">${order.statut}</span></p>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <!-- Sales Details Table -->
            <div class="analytics-card" style="margin-bottom: 30px;">
                <h2>Détails des Ventes par Produit</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Produit</th>
                            <th>Variété</th>
                            <th>Quantité Vendue</th>
                            <th>Revenu Total</th>
                            <th>% du Revenu</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="totalRevenue" value="${overallStats.totalRevenue}" />
                        <c:forEach var="product" items="${productSales}">
                            <tr>
                                <td>${product.nom}</td>
                                <td>${product.variete}</td>
                                <td>${product.totalQuantity}</td>
                                <td><fmt:formatNumber value="${product.totalRevenue}" type="number" maxFractionDigits="2"/> DT</td>
                                <td>
                                    <c:if test="${totalRevenue > 0}">
                                        <fmt:formatNumber value="${(product.totalRevenue / totalRevenue) * 100}" type="number" maxFractionDigits="1"/>%
                                    </c:if>
                                    <c:if test="${totalRevenue == 0}">
                                        0%
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </main>
    </div>

    <script>
 // Remove the duplicate event listener block and keep only the one inside DOMContentLoaded

    document.addEventListener('DOMContentLoaded', function() {
        setupMonthlySalesChart();
        setupVarietyChart();
        setupProductRevenueChart();
        
        // Initialize date pickers
        const today = new Date();
        document.getElementById('endDate').valueAsDate = today;
        
        const threeMonthsAgo = new Date();
        threeMonthsAgo.setMonth(today.getMonth() - 3);
        document.getElementById('startDate').valueAsDate = threeMonthsAgo;
        
        // Setup filter events
        document.getElementById('periodFilter').addEventListener('change', function() {
            const today = new Date();
            let startDate = new Date();
            
            switch(this.value) {
                case 'month':
                    startDate.setMonth(today.getMonth() - 1);
                    break;
                case 'quarter':
                    startDate.setMonth(today.getMonth() - 3);
                    break;
                case 'year':
                    startDate.setFullYear(today.getFullYear() - 1);
                    break;
                default:
                    // Show all data - set to minimum date in your data
                    startDate = new Date(2023, 0, 1);
            }
            
            document.getElementById('startDate').valueAsDate = startDate;
            document.getElementById('endDate').valueAsDate = today;
        });
        
        document.getElementById('applyFilter').addEventListener('click', function() {
            // In a real implementation, this would reload data with the selected date range
            alert('Dans une implémentation réelle, ceci rechargerait les données pour la période sélectionnée.');
        });
        
        // Setup sidebar navigation
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
    });

 // Monthly Sales Chart
    function setupMonthlySalesChart() {
        // Parse the data properly - this is the key fix
        let monthlySalesData = [];
        try {
            // First try to parse as JSON (in case it's already formatted correctly)
            monthlySalesData = JSON.parse('${not empty monthlySales ? monthlySales : "[]"}');
        } catch (error) {
            // If that fails, try to handle the non-standard format
            try {
                const rawData = '${not empty monthlySales ? monthlySales : "[]"}';
                // If it's an empty array placeholder, use empty array
                if (rawData === '[]') {
                    monthlySalesData = [];
                } else {
                    // Otherwise parse the non-standard format
                    // Strip outer brackets
                    let content = rawData.slice(1, -1);
                    if (content.trim() === '') {
                        monthlySalesData = [];
                    } else {
                        // Split by commas between objects
                        const items = content.split('},');
                        
                        monthlySalesData = items.map((item, index) => {
                            // Add closing brace if it was removed during split
                            if (!item.endsWith('}')) {
                                item += '}';
                            }
                            
                            // Remove opening brace
                            if (item.startsWith('{')) {
                                item = item.substring(1);
                            }
                            
                            // Split by properties
                            const props = item.split(',');
                            const result = {};
                            
                            props.forEach(prop => {
                                const [key, value] = prop.split('=');
                                if (key && value) {
                                    // Try to convert numeric values
                                    const trimmedKey = key.trim();
                                    const trimmedValue = value.trim();
                                    
                                    if (!isNaN(trimmedValue) && trimmedValue !== '') {
                                        result[trimmedKey] = parseFloat(trimmedValue);
                                    } else {
                                        result[trimmedKey] = trimmedValue;
                                    }
                                }
                            });
                            
                            return result;
                        });
                    }
                }
            } catch (parseError) {
                console.error('Error parsing sales data:', parseError);
                monthlySalesData = [];
            }
        }
        
        console.log('Parsed monthly sales data:', monthlySalesData);
        
        const ctx = document.getElementById('monthlySalesChart').getContext('2d');
        
        if (!ctx) {
            console.error('Could not find monthlySalesChart canvas element');
            return;
        }
        
        const labels = monthlySalesData.map(item => item.monthName || '');
        const salesValues = monthlySalesData.map(item => item.totalSales || 0);
        const orderCounts = monthlySalesData.map(item => item.orderCount || 0);
        
        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [
                    {
                        label: 'Revenu (DT)',
                        data: salesValues,
                        backgroundColor: 'rgba(126, 78, 35, 0.7)',
                        borderColor: '#7e4e23',
                        borderWidth: 1,
                        yAxisID: 'y'
                    },
                    {
                        label: 'Commandes',
                        data: orderCounts,
                        type: 'line',
                        fill: false,
                        backgroundColor: '#d4b68c',
                        borderColor: '#d4b68c',
                        borderWidth: 2,
                        pointBackgroundColor: '#d4b68c',
                        tension: 0.4,
                        yAxisID: 'y1'
                    }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        title: {
                            display: true,
                            text: 'Revenu (DT)'
                        },
                        grid: {
                            color: 'rgba(0, 0, 0, 0.05)'
                        }
                    },
                    y1: {
                        beginAtZero: true,
                        position: 'right',
                        title: {
                            display: true,
                            text: 'Nombre de commandes'
                        },
                        grid: {
                            display: false
                        }
                    },
                    x: {
                        grid: {
                            color: 'rgba(0, 0, 0, 0.05)'
                        }
                    }
                },
                plugins: {
                    legend: {
                        position: 'top'
                    },
                    tooltip: {
                        mode: 'index',
                        intersect: false
                    }
                }
            }
        });
    }

    // Variety Sales Chart (Pie/Doughnut)
    
function setupVarietyChart() {
    // Parse the data properly - using a more robust approach
    let varietyData = [];
    try {
        // First try to parse as JSON
        const rawData = '${not empty salesByVariety ? salesByVariety : "[]"}';
        varietyData = JSON.parse(rawData);
    } catch (error) {
        try {
            const rawData = '${not empty salesByVariety ? salesByVariety : "[]"}';
            console.log('Raw variety data:', rawData);
            
            if (rawData === '[]') {
                varietyData = [];
            } else {
                // Improved parsing logic
                // Remove outer brackets
                let content = rawData.slice(1, -1);
                
                if (content.trim() === '') {
                    varietyData = [];
                } else {
                    // Get individual objects by matching the pattern {key=value, key=value}
                    const regex = /{([^}]*)}/g;
                    const matches = content.match(regex) || [];
                    
                    varietyData = matches.map(match => {
                        // Remove the outer braces
                        const objContent = match.slice(1, -1);
                        const result = {};
                        
                        // Split by commas not inside quotes
                        const propPairs = objContent.split(',');
                        
                        propPairs.forEach(pair => {
                            // Split by first equals sign
                            const equalPos = pair.indexOf('=');
                            if (equalPos > 0) {
                                const key = pair.substring(0, equalPos).trim();
                                const value = pair.substring(equalPos + 1).trim();
                                
                                // Convert to number if possible
                                if (!isNaN(value) && value !== '') {
                                    result[key] = parseFloat(value);
                                } else {
                                    result[key] = value;
                                }
                            }
                        });
                        
                        return result;
                    });
                }
            }
        } catch (parseError) {
            console.error('Error parsing variety data:', parseError);
            varietyData = [];
        }
    }
    
    console.log('Parsed variety data:', varietyData);
    
    // Check if we have valid data with the required properties
    const validData = varietyData.filter(item => 
        item && typeof item.variete !== 'undefined' && 
        typeof item.totalRevenue !== 'undefined'
    );
    
    if (validData.length === 0) {
        console.warn('No valid variety data found with required properties');
        // You could display a message in the UI here
        return;
    }
    
    const ctx = document.getElementById('varietyChart');
    
    if (!ctx) {
        console.error('Could not find varietyChart canvas element');
        return;
    }
    
    const labels = validData.map(item => item.variete || '');
    const values = validData.map(item => item.totalRevenue || 0);
    const backgroundColors = [
        '#7e4e23', '#d4b68c', '#a67c52', '#8c5e2a', '#c0a080', 
        '#5c3a1a', '#e6d5c3', '#b89a7a', '#9b7247', '#e8c8a9'
    ];
    
    // Check if we have actual data to show
    if (labels.length === 0 || values.every(v => v === 0)) {
        console.warn('No data to display in variety chart');
        // You could display a message in the UI here
        return;
    }
    
    new Chart(ctx.getContext('2d'), {
        type: 'doughnut',
        data: {
            labels: labels,
            datasets: [{
                data: values,
                backgroundColor: backgroundColors.slice(0, labels.length),
                borderColor: '#fff',
                borderWidth: 2
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'right'
                },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            const label = context.label || '';
                            const value = context.formattedValue;
                            const dataset = context.dataset;
                            const total = dataset.data.reduce((acc, data) => acc + data, 0);
                            const percentage = Math.round((context.raw / total) * 100);
                            return `${label}: ${value} DT (${percentage}%)`;
                        }
                    }
                }
            }
        }
    });
}

// Add this function to help debug your data format
function debugDataFormat() {
    // Log the raw data to see exactly what format it's in
    console.log('Raw monthly sales data:', '${not empty monthlySales ? monthlySales : "[]"}');
    console.log('Raw variety data:', '${not empty salesByVariety ? salesByVariety : "[]"}');
    console.log('Raw product data:', '${not empty productSales ? productSales : "[]"}');
}

    // Product Revenue Chart (Horizontal Bar)
    function setupProductRevenueChart() {
       
        let productData = [];
        try {
            
            productData = JSON.parse('${not empty productSales ? productSales : "[]"}');
        } catch (error) {
            
            try {
                const rawData = '${not empty productSales ? productSales : "[]"}';
               
                if (rawData === '[]') {
                    productData = [];
                } else {
                    
                    let content = rawData.slice(1, -1);
                    if (content.trim() === '') {
                        productData = [];
                    } else {
                       
                        const items = content.split('},');
                        
                        productData = items.map((item, index) => {
                         
                            if (!item.endsWith('}')) {
                                item += '}';
                            }
                            
                           
                            if (item.startsWith('{')) {
                                item = item.substring(1);
                            }
                            
                            
                            const props = item.split(',');
                            const result = {};
                            
                            props.forEach(prop => {
                                const [key, value] = prop.split('=');
                                if (key && value) {
                                    // Try to convert numeric values
                                    const trimmedKey = key.trim();
                                    const trimmedValue = value.trim();
                                    
                                    if (!isNaN(trimmedValue) && trimmedValue !== '') {
                                        result[trimmedKey] = parseFloat(trimmedValue);
                                    } else {
                                        result[trimmedKey] = trimmedValue;
                                    }
                                }
                            });
                            
                            return result;
                        });
                    }
                }
            } catch (parseError) {
                console.error('Error parsing product data:', parseError);
                productData = [];
            }
        }
        
        console.log('Parsed product data:', productData);
        
        const ctx = document.getElementById('productRevenueChart').getContext('2d');
        
        if (!ctx) {
            console.error('Could not find productRevenueChart canvas element');
            return;
        }
        
        // Sort by revenue descending and take top 8
        const sortedData = [...productData].sort((a, b) => (b.totalRevenue || 0) - (a.totalRevenue || 0)).slice(0, 8);
        
        const labels = sortedData.map(item => item.nom || '');
        const values = sortedData.map(item => item.totalRevenue || 0);
        
        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Revenu (DT)',
                    data: values,
                    backgroundColor: 'rgba(126, 78, 35, 0.7)',
                    borderColor: '#7e4e23',
                    borderWidth: 1
                }]
            },
            options: {
                indexAxis: 'y',
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    x: {
                        beginAtZero: true,
                        grid: {
                            color: 'rgba(0, 0, 0, 0.05)'
                        }
                    },
                    y: {
                        grid: {
                            display: false
                        }
                    }
                },
                plugins: {
                    legend: {
                        display: false
                    }
                }
            }
        });
    }
    </script>
</body>
</html>