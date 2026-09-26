
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Shopping Cart - TechMart Online</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #0b0f19;
            color: #f8fafc;
            overflow-x: hidden;
        }

        .navbar {
            background: rgba(15, 23, 42, 0.85) !important;
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
            padding: 0.85rem 0;
        }
        .navbar-brand {
            font-weight: 700;
            letter-spacing: -0.03em;
            color: #ffffff !important;
            text-decoration: none;
        }
        .nav-link {
            color: #94a3b8 !important;
            font-weight: 500;
            font-size: 0.95rem;
            transition: color 0.2s;
        }
        .nav-link:hover {
            color: #3b82f6 !important;
        }

        /* Premium Section Layout */
        .page-section {
            padding: 3rem 0;
        }
        h1 {
            font-size: 1.75rem;
            font-weight: 700;
            color: #ffffff;
            letter-spacing: -0.02em;
        }

        .cart-card {
            background: rgba(17, 24, 39, 0.6);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 16px;
            padding: 1.5rem;
            margin-top: 1.5rem;
        }

        /* Premium Modern Table Architecture */
        .cart-table {
            width: 100%;
            border-collapse: collapse;
        }
        .cart-table th {
            background: rgba(15, 23, 42, 0.6);
            color: #94a3b8;
            font-weight: 600;
            padding: 1rem;
            font-size: 0.85rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.08);
        }
        .cart-table td {
            padding: 1.25rem 1rem;
            color: #e2e8f0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.04);
            vertical-align: middle;
        }
        .thumb {
            width: 50px;
            height: 50px;
            object-fit: contain;
            background: rgba(255, 255, 255, 0.03);
            border-radius: 6px;
            padding: 4px;
            border: 1px solid rgba(255, 255, 255, 0.05);
        }

        /* Inputs & Custom Action Buttons */
        .qty-input {
            width: 65px;
            background: rgba(15, 23, 42, 0.5);
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: white;
            padding: 0.35rem;
            border-radius: 6px;
            /*text-center;*/
            font-size: 0.9rem;
        }
        .qty-input:focus {
            border-color: #2563eb;
            outline: none;
        }
        .btn-update-cart {
            background: rgba(59, 130, 246, 0.1);
            border: 1px solid rgba(59, 130, 246, 0.2);
            color: #60a5fa;
            font-size: 0.8rem;
            font-weight: 500;
            padding: 0.35rem 0.75rem;
            border-radius: 6px;
            transition: all 0.2s;
        }
        .btn-update-cart:hover {
            background: #2563eb;
            color: white;
        }
        .btn-remove-cart {
            background: rgba(239, 64, 64, 0.1);
            border: 1px solid rgba(239, 64, 64, 0.2);
            color: #f87171;
            font-size: 0.8rem;
            padding: 0.35rem 0.75rem;
            border-radius: 6px;
            transition: all 0.2s;
        }
        .btn-remove-cart:hover {
            background: #ef4444;
            color: white;
        }

        /* Custom Checkout Layout Panel */
        .summary-panel {
            background: rgba(15, 23, 42, 0.5);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 12px;
            padding: 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 1.5rem;
        }
        .total-price {
            font-size: 1.25rem;
            font-weight: 700;
            color: #ffffff;
        }
        .btn-checkout {
            background: #2563eb;
            color: white;
            border: none;
            padding: 0.75rem 1.75rem;
            font-weight: 600;
            border-radius: 8px;
            font-size: 0.95rem;
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
            transition: all 0.2s;
        }
        .btn-checkout:hover {
            background: #1d4ed8;
            transform: translateY(-1px);
        }

        /* Custom Bootstrap Checkbox Style Overlay */
        .form-check-input {
            background-color: rgba(15, 23, 42, 0.5);
            border-color: rgba(255, 255, 255, 0.15);
            cursor: pointer;
        }
        .form-check-input:checked {
            background-color: #2563eb;
            border-color: #2563eb;
        }
    </style>
</head>
<body>

<%@ include file="_flash_alert.jsp" %>

<nav class="navbar navbar-expand-lg sticky-top">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/home">
            <i class="bi bi-cpu text-primary fs-3"></i> TechMart Online
        </a>
        <button class="navbar-toggler border-0 text-white" type="button" data-bs-toggle="collapse" data-bs-target="#navContainer">
            <i class="bi bi-list fs-2"></i>
        </button>

        <div class="collapse navbar-collapse" id="navContainer">
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0 gap-3 align-items-lg-center">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/home"><i class="bi bi-house-door me-1"></i> Home</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/products"><i class="bi bi-grid-3x3-gap me-1"></i> Products</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/wishlist"><i class="bi bi-heart me-1"></i> Wishlist</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/messages"><i class="bi bi-chat-dots me-1"></i> Messages</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container page-section">
    <div class="d-flex justify-content-between align-items-center mb-2">
        <h1>Your Shopping Cart</h1>
        <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-secondary btn-sm text-white border-opacity-10 rounded-pill px-3">
            <i class="bi bi-arrow-left me-1"></i> Continue Shopping
        </a>
    </div>

    <c:if test="${empty cartItems}">
        <div class="cart-card text-center py-5">
            <i class="bi bi-cart-x text-muted" style="font-size: 3rem;"></i>
            <p class="text-secondary mt-3 mb-4">Your shopping cart feels light. Let's load it up with premium gear!</p>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-primary text-white rounded-3 px-4">Browse Premium Products</a>
        </div>
    </c:if>

    <c:if test="${not empty cartItems}">
        <form id="checkoutForm" method="post" action="${pageContext.request.contextPath}/cart">
            <input type="hidden" name="action" value="checkout">
        </form>

        <div class="cart-card shadow-lg">
            <div class="table-responsive">
                <table class="cart-table">
                    <thead>
                    <tr>
                        <th style="width: 5%"></th>
                        <th style="width: 45%">Product Specification</th>
                        <th style="width: 15%">Unit Price</th>
                        <th style="width: 20%">Quantity Matrix</th>
                        <th style="width: 15%">Subtotal</th>
                        <th style="width: 5%"></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="item" items="${cartItems}">
                        <tr>
                            <td>
                                <input class="form-check-input shadow-none" type="checkbox" form="checkoutForm" name="selectedItems" value="${item.cartItemId}" checked>
                            </td>
                            <td>
                                <div class="d-flex align-items-center gap-3">
                                    <img class="thumb" src="${pageContext.request.contextPath}/images/${item.imagePath}" alt="${item.name}">
                                    <span class="fw-medium text-white-toggle">${item.name}</span>
                                </div>
                            </td>
                            <td class="text-secondary font-monospace">Rs. <fmt:formatNumber value="${item.price}" maxFractionDigits="2" minFractionDigits="2"/></td>
                            <td>
                                <form method="post" action="${pageContext.request.contextPath}/cart" class="d-flex align-items-center gap-2">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="cartItemId" value="${item.cartItemId}">
                                    <input type="number" name="qty" value="${item.qty}" min="1" max="${item.availableStock}" class="qty-input shadow-none text-center">
                                    <button type="submit" class="btn-update-cart"><i class="bi bi-arrow-clockwise"></i></button>
                                </form>
                            </td>
                            <td class="fw-semibold text-primary font-monospace">Rs. <fmt:formatNumber value="${item.subtotal}" maxFractionDigits="2" minFractionDigits="2"/></td>
                            <td>
                                <form method="post" action="${pageContext.request.contextPath}/cart" class="m-0">
                                    <input type="hidden" name="action" value="remove">
                                    <input type="hidden" name="cartItemId" value="${item.cartItemId}">
                                    <button type="submit" class="btn-remove-cart"><i class="bi bi-trash3"></i></button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="summary-panel shadow-sm">
            <div class="d-flex flex-column">
                <span class="text-secondary small fw-medium text-uppercase" style="letter-spacing: 0.05em;">Estimated Total</span>
                <span class="total-price font-monospace">Rs. <fmt:formatNumber value="${subtotal}" maxFractionDigits="2" minFractionDigits="2"/></span>
            </div>
            <button type="submit" form="checkoutForm" class="btn-checkout text-white d-flex align-items-center gap-2">
                Proceed to Checkout <i class="bi bi-credit-card-2-back"></i>
            </button>
        </div>
    </c:if>
</div>

</body>
</html>
