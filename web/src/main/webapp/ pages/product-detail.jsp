<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.name} - TechMart Online</title>

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

        .detail-wrapper {
            background: rgba(17, 24, 39, 0.6);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 20px;
            padding: 2.5rem;
            margin-top: 2rem;
        }

        .image-showcase {
            background: rgba(15, 23, 42, 0.3);
            border: 1px solid rgba(255, 255, 255, 0.03);
            border-radius: 14px;
            padding: 2rem;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 420px;
        }
        .detail-image {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
            transition: transform 0.3s ease;
        }
        .image-showcase:hover .detail-image {
            transform: scale(1.03);
        }

        h1 {
            font-size: 2.25rem;
            font-weight: 700;
            color: #ffffff;
            letter-spacing: -0.02em;
            line-height: 1.2;
        }
        .detail-brand {
            font-size: 0.85rem;
            font-weight: 600;
            color: #60a5fa;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        .detail-price {
            font-size: 1.75rem;
            font-weight: 700;
            color: #ffffff;
            margin: 1rem 0;
        }
        .detail-description {
            color: #94a3b8;
            font-size: 0.95rem;
            line-height: 1.6;
            border-top: 1px solid rgba(255, 255, 255, 0.05);
            padding-top: 1rem;
            margin-bottom: 1.5rem;
        }

        .qty-wrapper {
            max-width: 120px;
        }
        .qty-input {
            background: rgba(15, 23, 42, 0.5) !important;
            border: 1px solid rgba(255, 255, 255, 0.1) !important;
            color: white !important;
            border-radius: 8px !important;
            padding: 0.5rem !important;
        }
        .btn-add-cart-lg {
            background: #2563eb;
            color: white;
            border: none;
            padding: 0.65rem 1.5rem;
            font-weight: 600;
            border-radius: 8px;
            transition: all 0.2s;
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.25);
        }
        .btn-add-cart-lg:hover {
            background: #1d4ed8;
            transform: translateY(-1px);
        }

        .btn-wishlist-lg {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(255, 255, 255, 0.08);
            color: #94a3b8;
            padding: 0.65rem 1.25rem;
            font-weight: 500;
            font-size: 0.9rem;
            border-radius: 8px;
            transition: all 0.2s;
            width: 100%;
        }
        .btn-wishlist-lg:hover {
            background: rgba(239, 68, 68, 0.1);
            border-color: rgba(239, 68, 68, 0.2);
            color: #f87171;
        }
        .btn-wishlist-lg.active-wish {
            background: rgba(239, 68, 68, 0.15) !important;
            border-color: rgba(239, 68, 68, 0.3) !important;
            color: #f87171 !important;
        }

        .badge-out-stock-lg {
            background: rgba(239, 68, 68, 0.1);
            border: 1px solid rgba(239, 68, 68, 0.3);
            color: #f87171;
            padding: 0.65rem 1.5rem;
            font-weight: 600;
            border-radius: 8px;
            display: inline-block;
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
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.5);
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .notiflex-toast.toast-success { border-left-color: #10b981; }
        .notiflex-toast.toast-error { border-left-color: #ef4444; }
    </style>
</head>
<body>

<input type="hidden" id="flash-success-msg" value="${success}">
<input type="hidden" id="flash-error-msg" value="${error}">

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
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/wishlist"><i class="bi bi-heart me-1"></i> Wishlist</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/cart"><i class="bi bi-cart3 me-1"></i> Cart</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container my-5">

    <a href="${pageContext.request.contextPath}/products" class="btn btn-link text-secondary text-decoration-none p-0 mb-3 small d-inline-flex align-items-center gap-1">
        <i class="bi bi-arrow-left"></i> Back to Catalog
    </a>

    <div class="detail-wrapper shadow-lg">
        <div class="row g-5">

            <div class="col-lg-6">
                <div class="image-showcase">
                    <img src="${pageContext.request.contextPath}/images/${product.imagePath}" class="detail-image animate__animated animate__fadeIn" alt="${product.name}">
                </div>
            </div>

            <div class="col-lg-6 d-flex flex-column justify-content-center">
                <div class="detail-info">
                    <div class="detail-brand mb-1">${product.brandName} Design Build</div>
                    <h1>${product.name}</h1>

                    <div class="detail-price font-monospace text-primary">Rs. <fmt:formatNumber value="${product.price}" maxFractionDigits="2" minFractionDigits="2"/></div>
                    <p class="detail-description">${product.description}</p>

                    <div class="mb-4">
                        <c:choose>
                            <c:when test="${product.inStock}">
                                <div class="d-flex align-items-end gap-3 flex-wrap">
                                    <div class="qty-wrapper flex-grow-1">
                                        <label class="form-label text-secondary small fw-medium mb-1">Quantity</label>
                                        <input type="number" id="purchase-qty" class="form-control qty-input shadow-none text-center" value="1" min="1" max="${product.availableQty}">
                                    </div>
                                    <button type="button" class="btn-add-cart-lg flex-grow-2 text-white px-4" onclick="addDetailedToCart('${product.id}')">
                                        <i class="bi bi-cart-plus me-2"></i> Add to Cart
                                    </button>
                                </div>
                                <div class="text-success small mt-2 d-flex align-items-center gap-1">
                                    <i class="bi bi-check2-circle"></i> In Stock (${product.availableQty} units ready to ship)
                                </div>
                            </c:when>
                            <c:otherwise>
                                <span class="badge-out-stock-lg"><i class="bi bi-exclamation-triangle me-2"></i> Out of stock</span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <form method="post" action="${pageContext.request.contextPath}/wishlist" class="m-0 border-top border-secondary border-opacity-10 pt-3">
                        <input type="hidden" name="pId" value="${product.id}">
                        <input type="hidden" name="redirectTo" value="${currentPageUrl}">
                        <c:choose>
                            <c:when test="${inWishlist}">
                                <input type="hidden" name="action" value="remove">
                                <button type="submit" class="btn-wishlist-lg active-wish d-flex align-items-center justify-content-center gap-2">
                                    <i class="bi bi-heart-fill"></i> Remove from Wishlist
                                </button>
                            </c:when>
                            <c:otherwise>
                                <input type="hidden" name="action" value="add">
                                <button type="submit" class="btn-wishlist-lg d-flex align-items-center justify-content-center gap-2">
                                    <i class="bi bi-heart"></i> Add to Wishlist
                                </button>
                            </c:otherwise>
                        </c:choose>
                    </form>

                </div>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const Notiflex = {
        show(message, type = 'info') {
            const container = document.getElementById('notiflex-container');
            if (!container) return;

            const toast = document.createElement('div');
            // Compiler Escape Fixes using backslash
            toast.className = `notiflex-toast animate__animated animate__slideInRight \${type === 'success' ? 'toast-success' : type === 'error' ? 'toast-error' : ''}`;

            let icon = '<i class="bi bi-info-circle text-info"></i>';
            if (type === 'success') icon = '<i class="bi bi-check-circle-fill text-success fs-5"></i>';
            if (type === 'error') icon = '<i class="bi bi-exclamation-triangle-fill text-danger fs-5"></i>';

            toast.innerHTML = `\${icon} <div>\${message}</div>`;
            container.appendChild(toast);

            setTimeout(() => {
                toast.classList.replace('animate__slideInRight', 'animate__slideOutRight');
                toast.addEventListener('animationend', () => toast.remove());
            }, 4000);
        }
    };

    <footer>
        <div class="container">
            <div class="row g-4 mb-5">
                <div class="col-lg-4 col-md-6">
                    <div class="d-flex align-items-center gap-2 mb-3">
                        <i class="bi bi-cpu text-primary fs-3"></i>
                        <span class="fs-4 fw-bold text-white">TechMart Online</span>
                    </div>
                    <p class="text-secondary small pe-lg-4">Your trusted partner for buying flagship smartphones, multi-thread engineering laptops, and genuine accessories with real manufacturing warranties.</p>
                    <div class="d-flex gap-2 mt-4">
                        <a href="#" class="social-icon"><i class="bi bi-facebook"></i></a>
                        <a href="#" class="social-icon"><i class="bi bi-instagram"></i></a>
                        <a href="#" class="social-icon"><i class="bi bi-twitter-x"></i></a>
                        <a href="#" class="social-icon"><i class="bi bi-linkedin"></i></a>
                    </div>
                </div>

                <div class="col-lg-2 col-md-3 col-6">
                    <h5 class="footer-heading">Quick Links</h5>
                    <ul class="footer-links">
                        <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/products">All Products</a></li>
                        <li><a href="${pageContext.request.contextPath}/cart">My Cart</a></li>
                        <li><a href="${pageContext.request.contextPath}/wishlist">Wishlist</a></li>
                    </ul>
                </div>

                <div class="col-lg-2 col-md-3 col-6">
                    <h5 class="footer-heading">Help & Support</h5>
                    <ul class="footer-links">
                        <li><a href="#">Contact Us</a></li>
                        <li><a href="#">FAQS & Help</a></li>
                        <li><a href="#">Return Policy</a></li>
                        <li><a href="#">Privacy Framework</a></li>
                    </ul>
                </div>

                <div class="col-lg-4 col-md-12">
                    <h5 class="footer-heading">Subscribe to Newsletter</h5>
                    <p class="text-secondary small mb-3">Get real-time flash deal updates, voucher drops, and newly stocked arrival announcements straight into your inbox.</p>
                    <div class="input-group">
                        <input type="email" class="form-control form-control-sm bg-transparent border-secondary border-opacity-20 text-white shadow-none px-3" placeholder="Enter your email address" style="border-radius: 8px 0 0 8px;">
                            <button class="btn btn-primary btn-sm px-3 text-white" type="button" style="border-radius: 0 8px 8px 0;">Join</button>
                    </div>
                </div>
            </div>

            <div class="py-3 border-top border-secondary border-opacity-10 d-flex flex-column flex-md-row justify-content-between align-items-center gap-2 text-secondary small">
                <div>&copy; 2026 TechMart Online (Pvt) Ltd. All Rights Reserved.</div>
                <div class="d-flex gap-3">
                    <span class="text-muted"><i class="bi bi-shield-check me-1 text-success"></i> Secure SSL Checkout</span>
                    <span class="text-muted"><i class="bi bi-truck me-1 text-primary"></i> Islandwide Delivery</span>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function addDetailedToCart(productId) {
    const quantityInput = document.getElementById('purchase-qty');
    const qtyValue = quantityInput ? quantityInput.value : 1;

    fetch(`${pageContext.request.contextPath}/cart?action=add&pId=` + productId + `&qty=` + qtyValue, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        }
    })
        .then(response => {
            if (response.ok) {
                Notiflex.show("Selected quantity added to cart successfully!", "success");
            } else {
                Notiflex.show("Failed to modify cart schema.", "error");
            }
        })
        .catch(error => {
            console.error('Detailed Product Ajax Cart Error:', error);
            Notiflex.show("Network connection state error.", "error");
        });
    }

    document.addEventListener("DOMContentLoaded", function () {
    const successMsg = document.getElementById("flash-success-msg").value;
    const errorMsg = document.getElementById("flash-error-msg").value;

    if (successMsg && successMsg.trim() !== "") {
        Notiflex.show(successMsg, "success");
    }
    if (errorMsg && errorMsg.trim() !== "") {
        Notiflex.show(errorMsg, "error");
    }
    });
</script>

</body>
</html>

