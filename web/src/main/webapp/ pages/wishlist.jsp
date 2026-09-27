<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Wishlist - TechMart Online</title>

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
        .nav-link:hover { color: #3b82f6 !important; }

        .page-section { padding: 3rem 0; }
        h1 {
            font-size: 1.75rem;
            font-weight: 700;
            color: #ffffff;
            letter-spacing: -0.02em;
        }

        .product-grid-5 {
            display: grid;
            grid-template-columns: repeat(5, minmax(0, 1fr));
            gap: 1.25rem;
            margin-top: 1.5rem;
        }
        @media (max-width: 1200px) { .product-grid-5 { grid-template-columns: repeat(4, minmax(0, 1fr)); } }
        @media (max-width: 992px)  { .product-grid-5 { grid-template-columns: repeat(3, minmax(0, 1fr)); } }
        @media (max-width: 768px)  { .product-grid-5 { grid-template-columns: repeat(2, minmax(0, 1fr)); } }
        @media (max-width: 480px)  { .product-grid-5 { grid-template-columns: repeat(1, minmax(0, 1fr)); } }

        .product-card {
            background: rgba(30, 41, 59, 0.4);
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 12px;
            padding: 1rem;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            height: 100%;
        }
        .product-card:hover {
            transform: translateY(-6px);
            background: rgba(30, 41, 59, 0.6);
            border-color: rgba(59, 130, 246, 0.3);
            box-shadow: 0 12px 20px -5px rgba(0,0,0,0.5), 0 4px 12px rgba(37,99,235,0.1);
        }
        .card-link {
            text-decoration: none;
            display: block;
            margin-bottom: 1rem;
        }
        .card-image-wrapper {
            width: 100%;
            height: 150px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 0.75rem;
            background: rgba(15, 23, 42, 0.3);
            border-radius: 8px;
            overflow: hidden;
        }
        .card-image {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
            transition: transform 0.3s ease;
        }
        .product-card:hover .card-image { transform: scale(1.05); }
        .card-brand {
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            color: #60a5fa;
            letter-spacing: 0.05em;
            margin-bottom: 0.25rem;
        }
        .card-name {
            font-size: 0.9rem;
            font-weight: 500;
            color: #f1f5f9;
            line-height: 1.4;
            height: 40px;
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            margin-bottom: 0.5rem;
        }
        .card-price {
            font-size: 1.05rem;
            font-weight: 700;
            color: #ffffff;
        }
        .btn-add-cart {
            background: rgba(59, 130, 246, 0.1);
            border: 1px solid rgba(59, 130, 246, 0.3);
            color: #60a5fa;
            font-size: 0.85rem;
            font-weight: 600;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            width: 100%;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        .btn-add-cart:hover {
            background: #2563eb;
            border-color: #2563eb;
            color: #ffffff;
        }
        .btn-remove-wishlist {
            background: transparent;
            border: none;
            color: #94a3b8;
            font-size: 0.8rem;
            font-weight: 500;
            transition: color 0.2s;
            margin-top: 0.75rem;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 4px;
            width: 100%;
            cursor: pointer;
        }
        .btn-remove-wishlist:hover { color: #f87171; }
        .badge-out-stock {
            background: rgba(239, 68, 68, 0.1);
            border: 1px solid rgba(239, 68, 68, 0.3);
            color: #f87171;
            font-size: 0.8rem;
            font-weight: 600;
            padding: 0.5rem;
            border-radius: 8px;
            text-align: center;
            display: block;
            width: 100%;
        }
        #notiflex-container {
            position: fixed;
            bottom: 24px;
            right: 24px;
            z-index: 1060;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        .notiflex-toast {
            background: rgba(15, 23, 42, 0.9);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border-left: 4px solid #2563eb;
            color: #ffffff;
            padding: 1rem 1.25rem;
            border-radius: 0 8px 8px 0;
            min-width: 300px;
            box-shadow: 0 10px 15px -3px rgba(0,0,0,0.5);
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .notiflex-toast.toast-success { border-left-color: #10b981; }
        .notiflex-toast.toast-error   { border-left-color: #ef4444; }
    </style>
</head>
<body>

<input type="hidden" id="flash-success-msg" value="${sessionScope.flashSuccess}">
<input type="hidden" id="flash-error-msg"   value="${sessionScope.flashError}">
<% session.removeAttribute("flashSuccess"); session.removeAttribute("flashError"); %>

<div id="notiflex-container"></div>

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
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/cart"><i class="bi bi-cart3 me-1"></i> Cart</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/messages"><i class="bi bi-chat-dots me-1"></i> Messages</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container page-section">
    <div class="d-flex justify-content-between align-items-center mb-2">
        <h1>My Wishlist</h1>
        <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-secondary btn-sm text-white border-opacity-10 rounded-pill px-3">
            <i class="bi bi-arrow-left me-1"></i> Continue Shopping
        </a>
    </div>

    <c:if test="${empty wishlistItems}">
        <div class="text-center py-5 mt-4" style="background: rgba(17,24,39,0.4); border: 1px solid rgba(255,255,255,0.05); border-radius: 16px;">
            <i class="bi bi-heartbreak text-muted" style="font-size: 3rem;"></i>
            <p class="text-secondary mt-3 mb-4">Your wishlist is empty. Let's find some elite tech gear!</p>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-primary text-white rounded-3 px-4">Browse Catalog</a>
        </div>
    </c:if>

    <div class="product-grid-5">
        <c:forEach var="w" items="${wishlistItems}">
            <div class="product-card">

                <a href="${pageContext.request.contextPath}/product?id=${w.productId}" class="card-link">
                    <div class="card-image-wrapper">
                        <img src="${pageContext.request.contextPath}/images/${w.imagePath}" alt="${w.name}" class="card-image">
                    </div>
                    <div class="card-brand">${w.brandName}</div>
                    <div class="card-name">${w.name}</div>
                    <div class="card-price">Rs. <fmt:formatNumber value="${w.price}" maxFractionDigits="2" minFractionDigits="2"/></div>
                </a>

                <div class="mt-auto">
                    <c:choose>
                        <c:when test="${w.inStock}">
                            <form method="post" action="${pageContext.request.contextPath}/cart" class="m-0">
                                <input type="hidden" name="action"     value="add">
                                <input type="hidden" name="pId"        value="${w.productId}">
                                <input type="hidden" name="qty"        value="1">
                                <input type="hidden" name="redirectTo" value="/wishlist">
                                <button type="submit" class="btn-add-cart">
                                    <i class="bi bi-cart-plus me-1"></i> Add to cart
                                </button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <span class="badge-out-stock"><i class="bi bi-exclamation-circle me-1"></i> Out of stock</span>
                        </c:otherwise>
                    </c:choose>

                    <form method="post" action="${pageContext.request.contextPath}/wishlist" class="m-0">
                        <input type="hidden" name="pId"        value="${w.productId}">
                        <input type="hidden" name="action"     value="remove">
                        <input type="hidden" name="redirectTo" value="/wishlist">
                        <button type="submit" class="btn-remove-wishlist">
                            <i class="bi bi-trash3 small"></i> Remove Item
                        </button>
                    </form>
                </div>

            </div>
        </c:forEach>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    var Notiflex = {
        show: function(message, type) {
            type = type || 'info';
            var container = document.getElementById('notiflex-container');
            if (!container) return;

            var toast = document.createElement('div');
            var typeClass = '';
            if (type === 'success') typeClass = 'toast-success';
            else if (type === 'error') typeClass = 'toast-error';
            toast.className = 'notiflex-toast animate__animated animate__slideInRight ' + typeClass;

            var icon = '<i class="bi bi-info-circle text-info"></i>';
            if (type === 'success') icon = '<i class="bi bi-check-circle-fill text-success fs-5"></i>';
            if (type === 'error')   icon = '<i class="bi bi-exclamation-triangle-fill text-danger fs-5"></i>';

            toast.innerHTML = icon + ' <div>' + message + '</div>';
            container.appendChild(toast);

            setTimeout(function() {
                toast.classList.replace('animate__slideInRight', 'animate__slideOutRight');
                toast.addEventListener('animationend', function() { toast.remove(); });
            }, 4000);
        }
    };

    document.addEventListener("DOMContentLoaded", function () {
        var successMsg = document.getElementById("flash-success-msg").value;
        var errorMsg   = document.getElementById("flash-error-msg").value;

        if (successMsg && successMsg.trim() !== "") Notiflex.show(successMsg, "success");
        if (errorMsg   && errorMsg.trim()   !== "") Notiflex.show(errorMsg,   "error");
    });
</script>

</body>
</html>

