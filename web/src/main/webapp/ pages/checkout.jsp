
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - TechMart Online</title>

    <!-- Bootstrap 5, Animate.css, Fonts & PayHere Runtime -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <script src="https://www.payhere.lk/lib/payhere.js"></script>

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #0b0f19;
            color: #f8fafc;
            overflow-x: hidden;
        }

        /* Modern Glassmorphism Navbar */
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

        /* Premium Section Content Cards */
        .checkout-card {
            background: rgba(17, 24, 39, 0.6);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 16px;
            padding: 2rem;
            height: 100%;
        }
        h2 {
            font-size: 1.35rem;
            font-weight: 600;
            color: #ffffff;
            letter-spacing: -0.02em;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        /* Forms Layout */
        .form-label {
            color: #94a3b8;
            font-size: 0.85rem;
            font-weight: 500;
            margin-bottom: 0.4rem;
        }
        .form-control {
            background: rgba(15, 23, 42, 0.5) !important;
            border: 1px solid rgba(255, 255, 255, 0.1) !important;
            color: white !important;
            border-radius: 8px !important;
            padding: 0.6rem 0.75rem !important;
            font-size: 0.9rem !important;
        }
        .form-control:focus {
            border-color: #2563eb !important;
            box-shadow: none !important;
        }

        /* Order Invoice Summary Rows */
        .summary-wrapper {
            display: flex;
            flex-direction: column;
            gap: 0.85rem;
        }
        .summary-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.92rem;
            color: #94a3b8;
        }
        .summary-row.product-item span:first-child {
            color: #e2e8f0;
            font-weight: 500;
        }
        .summary-row.total {
            border-top: 1px solid rgba(255, 255, 255, 0.08);
            padding-top: 1rem;
            margin-top: 0.5rem;
            font-size: 1.2rem;
            font-weight: 700;
            color: #ffffff;
        }

        /* Premium Buttons */
        .btn-checkout-action {
            background: #2563eb;
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            font-size: 0.95rem;
            border-radius: 8px;
            transition: all 0.2s;
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.25);
            width: 100%;
        }
        .btn-checkout-action:hover {
            background: #1d4ed8;
            transform: translateY(-1px);
        }
        .btn-payhere {
            background: #ff9900;
            color: #111111;
            border: none;
            padding: 0.75rem 1.5rem;
            font-weight: 700;
            font-size: 1rem;
            border-radius: 8px;
            transition: all 0.2s;
            box-shadow: 0 4px 12px rgba(255, 153, 0, 0.2);
            width: 100%;
        }
        .btn-payhere:hover {
            background: #e68a00;
            transform: translateY(-1px);
        }
    </style>
</head>
<body>

<%@ include file="_flash_alert.jsp" %>

<!-- Global Modern Top Navigation Menu Header -->
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
            </ul>
        </div>
    </div>
</nav>

<div class="container my-5">

    <c:choose>
        <c:when test="${readyForPayment}">
            <div class="row g-4 animate__animated animate__fadeIn">

                <!-- Left Column: Payment Form Gateway Trigger Framework -->
                <div class="col-lg-7">
                    <div class="checkout-card d-flex flex-column justify-content-center">
                        <h2><i class="bi bi-shield-check text-success"></i> Order Securely Created</h2>
                        <p class="text-secondary small mb-4">Invoice footprint reference **#${order.orderId}** has been committed to the system module repository. Complete your checkout securely via PayHere endpoint interface.</p>

                        <button id="payNowBtn" class="btn-payhere mb-3 text-dark">
                            <i class="bi bi-credit-card-2-front-fill me-2"></i> Pay Securely with PayHere
                        </button>
                        <div class="text-muted small text-center"><i class="bi bi-lock-fill text-muted me-1"></i> You'll be redirected to PayHere's dynamic token checkout platform window.</div>
                    </div>
                </div>

                <div class="col-lg-5">
                    <div class="checkout-card">
                        <h2><i class="bi bi-receipt-cutoff text-primary"></i> Invoice Statement</h2>
                        <div class="summary-wrapper">
                            <c:forEach var="item" items="${order.items}">
                                <div class="summary-row product-item">
                                    <span>${item.productName} <span class="text-muted small">x${item.qty}</span></span>
                                    <span class="font-monospace">Rs. <fmt:formatNumber value="${item.unitPrice * item.qty}" maxFractionDigits="2" minFractionDigits="2"/></span>
                                </div>
                            </c:forEach>
                            <div class="summary-row border-top border-secondary border-opacity-10 pt-2 mt-2">
                                <span>Subtotal</span>
                                <span class="font-monospace">Rs. <fmt:formatNumber value="${order.subtotal}" maxFractionDigits="2" minFractionDigits="2"/></span>
                            </div>
                            <div class="summary-row">
                                <span>Shipping Fee Matrix</span>
                                <span class="font-monospace">Rs. <fmt:formatNumber value="${order.shippingFee}" maxFractionDigits="2" minFractionDigits="2"/></span>
                            </div>
                            <div class="summary-row total">
                                <span>Total Payable</span>
                                <span class="font-monospace text-primary">Rs. <fmt:formatNumber value="${order.totalAmount}" maxFractionDigits="2" minFractionDigits="2"/></span>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <script>
                var payment = {
                    "sandbox": true,
                    "merchant_id": "${merchantId}",
                    "return_url": "${pageContext.request.contextPath}/payhere/return?orderId=${order.orderId}",
                    "cancel_url": "${pageContext.request.contextPath}/cart",
                    "notify_url": "${notifyUrl}",
                    "order_id": "${order.orderId}",
                    "items": "${itemsDescription}",
                    "amount": "${amount}",
                    "currency": "LKR",
                    "hash": "${hash}",
                    "first_name": "${order.shippingName}",
                    "last_name": "",
                    "email": "${userEmail}",
                    "phone": "${order.shippingPhone}",
                    "address": "${order.shippingAddress}",
                    "city": "${order.shippingCity}",
                    "country": "Sri Lanka"
                };

                payhere.onCompleted = function (orderId) {
                    window.location.href = "${pageContext.request.contextPath}/payhere/return?orderId=" + orderId;
                };
                payhere.onDismissed = function () {
                    alert("Payment was not completed.");
                };
                payhere.onError = function (error) {
                    alert("Payment error: " + error);
                };

                document.getElementById('payNowBtn').addEventListener('click', function () {
                    payhere.startPayment(payment);
                });

                window.addEventListener('load', function () {
                    payhere.startPayment(payment);
                });
            </script>
        </c:when>

        <c:otherwise>
            <div class="row g-4 animate__animated animate__fadeIn">

                <div class="col-lg-7">
                    <div class="checkout-card">
                        <h2><i class="bi bi-truck text-primary"></i> Shipping Information</h2>
                        <form method="post" action="${pageContext.request.contextPath}/checkout" class="mt-3">
                            <div class="mb-3">
                                <label class="form-label">Full Name</label>
                                <input type="text" class="form-control shadow-none" name="shippingName" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Active Phone Number</label>
                                <input type="text" class="form-control shadow-none" name="shippingPhone" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Delivery Address</label>
                                <input type="text" class="form-control shadow-none" name="shippingAddress" required>
                            </div>
                            <div class="mb-4">
                                <label class="form-label">City</label>
                                <input type="text" class="form-control shadow-none" name="shippingCity" required>
                            </div>
                            <button type="submit" class="btn-checkout-action text-white">
                                Proceed to Secure Payment <i class="bi bi-arrow-right ms-1"></i>
                            </button>
                        </form>
                    </div>
                </div>

                <div class="col-lg-5">
                    <div class="checkout-card">
                        <h2><i class="bi bi-bag-check text-primary"></i> Order Summary</h2>
                        <div class="summary-wrapper">
                            <c:forEach var="item" items="${cartItems}">
                                <div class="summary-row product-item">
                                    <span>${item.name} <span class="text-muted small">x${item.qty}</span></span>
                                    <span class="font-monospace">Rs. <fmt:formatNumber value="${item.subtotal}" maxFractionDigits="2" minFractionDigits="2"/></span>
                                </div>
                            </c:forEach>
                            <div class="summary-row border-top border-secondary border-opacity-10 pt-2 mt-2">
                                <span>Subtotal</span>
                                <span class="font-monospace">Rs. <fmt:formatNumber value="${subtotal}" maxFractionDigits="2" minFractionDigits="2"/></span>
                            </div>
                            <div class="summary-row">
                                <span>Shipping Fee</span>
                                <span class="font-monospace">Rs. <fmt:formatNumber value="${shippingFee}" maxFractionDigits="2" minFractionDigits="2"/></span>
                            </div>
                            <div class="summary-row total">
                                <span>Total Amount</span>
                                <span class="font-monospace text-primary">Rs. <fmt:formatNumber value="${total}" maxFractionDigits="2" minFractionDigits="2"/></span>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </c:otherwise>
    </c:choose>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>

