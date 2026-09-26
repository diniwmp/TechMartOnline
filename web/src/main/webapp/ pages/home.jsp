
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TechMart Online - Tech & Gadget Store</title>

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
        }
        .search-input {
            background: rgba(30, 41, 59, 0.6);
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: #ffffff;
            border-radius: 8px 0 0 8px;
        }
        .search-input:focus {
            background: rgba(30, 41, 59, 0.8);
            border-color: #3b82f6;
            color: #ffffff;
            box-shadow: none;
        }
        .search-btn {
            border-radius: 0 8px 8px 0;
            background: #2563eb;
            border: none;
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

        .carousel-item {
            height: 480px;
            background-size: cover;
            background-position: center;
            position: relative;
        }
        .carousel-item::before {
            content: '';
            position: absolute;
            width: 100%;
            height: 100%;
            background: linear-gradient(to right, rgba(11, 15, 25, 0.9) 30%, rgba(11, 15, 25, 0.2) 100%);
        }
        .carousel-caption {
            text-align: left;
            left: 8%;
            right: auto;
            bottom: 25%;
            max-width: 550px;
        }
        .carousel-caption h1 {
            font-size: 3rem;
            font-weight: 800;
            letter-spacing: -0.04em;
            line-height: 1.1;
        }

        .category-section {
            padding: 3rem 0 1rem 0;
        }
        .category-title {
            font-size: 1.5rem;
            font-weight: 700;
            position: relative;
            padding-bottom: 0.5rem;
        }
        .category-title::after {
            content: '';
            position: absolute;
            left: 0;
            bottom: 0;
            width: 50px;
            height: 3px;
            background: #2563eb;
            border-radius: 2px;
        }
        .see-more-link {
            color: #3b82f6;
            text-decoration: none;
            font-weight: 500;
            font-size: 0.9rem;
            transition: gap 0.2s;
        }
        .see-more-link:hover {
            color: #60a5fa;
        }

        .product-grid-5 {
            display: grid;
            grid-template-columns: repeat(5, minmax(0, 1fr));
            gap: 1.25rem;
        }
        @media (max-width: 1200px) { .product-grid-5 { grid-template-columns: repeat(4, minmax(0, 1fr)); } }
        @media (max-width: 992px) { .product-grid-5 { grid-template-columns: repeat(3, minmax(0, 1fr)); } }
        @media (max-width: 768px) { .product-grid-5 { grid-template-columns: repeat(2, minmax(0, 1fr)); } }
        @media (max-width: 480px) { .product-grid-5 { grid-template-columns: repeat(1, minmax(0, 1fr)); } }

        footer {
            background: #090d16;
            border-top: 1px solid rgba(255, 255, 255, 0.05);
            padding-top: 4rem;
            margin-top: 5rem;
        }
        .footer-heading {
            font-size: 1rem;
            font-weight: 600;
            color: #ffffff;
            margin-bottom: 1.25rem;
        }
        .footer-links {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .footer-links li {
            margin-bottom: 0.75rem;
        }
        .footer-links a {
            color: #94a3b8;
            text-decoration: none;
            font-size: 0.9rem;
            transition: color 0.2s;
        }
        .footer-links a:hover {
            color: #ffffff;
        }
        .social-icon {
            width: 36px;
            height: 36px;
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            color: #94a3b8;
            text-decoration: none;
            transition: all 0.2s;
        }
        .social-icon:hover {
            background: #2563eb;
            color: white;
            border-color: #2563eb;
            transform: translateY(-2px);
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
            border-top: 1px solid rgba(255, 255, 255, 0.05);
            border-right: 1px solid rgba(255, 255, 255, 0.05);
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
            color: #ffffff;
            padding: 1rem 1.25rem;
            border-radius: 0 8px 8px 0;
            min-width: 300px;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.5);
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .notiflex-toast.toast-error { border-left-color: #ef4444; }
        .notiflex-toast.toast-success { border-left-color: #10b981; }
    </style>
</head>
<body>

<input type="hidden" id="flash-success-msg" value="${success}">
<input type="hidden" id="flash-error-msg" value="${error}">

<div id="notiflex-container"></div>

<nav class="navbar navbar-expand-lg sticky-top">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/">
            <i class="bi bi-cpu text-primary fs-3"></i> TechMart Online
        </a>
        <button class="navbar-toggler border-0 text-white" type="button" data-bs-toggle="collapse" data-bs-target="#navContainer">
            <i class="bi bi-list fs-2"></i>
        </button>

        <div class="collapse navbar-collapse" id="navContainer">
            <form action="${pageContext.request.contextPath}/products" method="get" class="d-flex mx-auto col-lg-5 col-md-8 mt-3 mt-lg-0">
                <input type="text" name="q" class="form-control search-input shadow-none" placeholder="Search elite gadgets, brands, electronics..." required>
                <button type="submit" class="btn btn-primary search-btn px-3 text-white"><i class="bi bi-search"></i></button>
            </form>

            <ul class="navbar-nav ms-auto mb-2 mb-lg-0 gap-2 align-items-lg-center">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/wishlist"><i class="bi bi-heart me-1"></i> Wishlist</a></li>
                <li class="nav-item"><a class="nav-link position-relative" href="${pageContext.request.contextPath}/cart"><i class="bi bi-cart3 me-1"></i> Cart</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/messages"><i class="bi bi-chat-dots me-1"></i> Messages</a></li>
                <li class="nav-item dropdown ms-lg-2">
                    <a class="nav-link btn btn-outline-light btn-sm text-white px-3 py-1.5 border-opacity-10 d-inline-block" href="#" data-bs-toggle="dropdown">
                        <i class="bi bi-person-circle me-1"></i> Account
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end dropdown-menu-dark bg-dark border-secondary border-opacity-20 mt-2 shadow-lg">
                        <li><a class="dropdown-menu-item dropdown-item py-2" href="${pageContext.request.contextPath}/profile"><i class="bi bi-sliders me-2">My Profile</i></a></li>
                        <li><hr class="dropdown-divider opacity-10"></li>
                        <li><a class="dropdown-menu-item dropdown-item py-2 text-danger" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right me-2"></i> Logout</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div id="heroCarousel" class="carousel slide carousel-fade shadow-lg" data-bs-ride="carousel">
    <div class="carousel-indicators">
        <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="0" class="active"></button>
        <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="1"></button>
    </div>
    <div class="carousel-inner">
        <div class="carousel-item active" style="background-image: linear-gradient(rgba(0,0,0,0.2), rgba(0,0,0,0.2)), url('https://images.unsplash.com/photo-1616348436168-de43ad0db179?q=80&w=1600&auto=format&fit=crop');">
            <div class="carousel-caption animate__animated animate__fadeInUp">
                <span class="badge bg-primary mb-3 px-3 py-2 fw-medium rounded-pill">NEW RELEASES</span>
                <h1>Smartphones Available Now</h1>
                <p class="text-secondary mt-2 mb-4">Experience lightning-fast processing speeds, brilliant cinematic view displays, and ultimate triple lens pro camera systems.</p>
                <a href="${pageContext.request.contextPath}/products?cat=1" class="btn btn-primary px-4 py-2.5 fw-semibold rounded-3 text-white">Explore Catalog &rarr;</a>
            </div>
        </div>
        <div class="carousel-item" style="background-image: linear-gradient(rgba(0,0,0,0.2), rgba(0,0,0,0.2)), url('https://images.unsplash.com/photo-1593642632823-8f785ba67e45?q=80&w=1600&auto=format&fit=crop');">
            <div class="carousel-caption animate__animated animate__fadeInUp">
                <span class="badge bg-success mb-3 px-3 py-2 fw-medium rounded-pill">EXCLUSIVE OFFERS</span>
                <h1>Ultimate Laptops For Work & Play</h1>
                <p class="text-secondary mt-2 mb-4">Power up your workflow setup with modern flagship processors, studio graphics arrays, and long battery life optimizations.</p>
                <a href="${pageContext.request.contextPath}/products?cat=2" class="btn btn-success px-4 py-2.5 fw-semibold rounded-3 text-white">Shop Hardware &rarr;</a>
            </div>
        </div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#heroCarousel" data-bs-slide="prev"><span class="carousel-control-prev-icon"></span></button>
    <button class="carousel-control-next" type="button" data-bs-target="#heroCarousel" data-bs-slide="next"><span class="carousel-control-next-icon"></span></button>
</div>

<div class="container my-5">
    <c:forEach var="cat" items="${categories}">
        <c:if test="${not empty productsByCategory[cat.catId]}">
            <div class="category-section">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="category-title">${cat.catName}</h2>
                    <a href="${pageContext.request.contextPath}/products?cat=${cat.catId}" class="see-more-link">
                        See More <i class="bi bi-arrow-right ms-1"></i>
                    </a>
                </div>

                <div class="product-grid-5">
                    <c:forEach var="p" items="${productsByCategory[cat.catId]}">
                        <%@ include file="_product-card.jsp" %>
                    </c:forEach>
                </div>
            </div>
        </c:if>
    </c:forEach>
</div>

<footer>
    <div class="container">
        <div class="row g-4 mb-5">
            <div class="col-lg-4 col-md-6">
                <div class="d-flex align-items-center gap-2 mb-3">
                    <i class="bi bi-cpu text-primary fs-3"></i>
                    <span class="fs-4 fw-bold text-white">TechMart Online</span>
                </div>
                <p class="text-secondary small pe-lg-4">Your trusted partner for buying flagship smartphones,and genuine accessories with real manufacturing warranties.</p>
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
                    <li><a href="${pageContext.request.contextPath}/">Home</a></li>
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
    const Notiflex = {
        show(message, type = 'info') {
            const container = document.getElementById('notiflex-container');
            if (!container) return;

            const toast = document.createElement('div');

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

    function addToCart(productId) {

        fetch(`${pageContext.request.contextPath}/cart?action=add&pId=` + productId, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            }
        })
            .then(response => {
                if (response.ok) {
                    Notiflex.show("Product added to cart successfully!", "success");
                } else {
                    Notiflex.show("Failed to add product to cart. Please try again.", "error");
                }
            })
            .catch(error => {
                console.error('Cart Ajax Error:', error);
                Notiflex.show("Network error! Could not connect to TechMart servers.", "error");
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
