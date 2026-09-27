<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - TechMart Online</title>

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

        .page-section {
            padding: 3rem 0;
        }
        h1 {
            font-size: 1.75rem;
            font-weight: 700;
            color: #ffffff;
            letter-spacing: -0.02em;
        }
        h2 {
            font-size: 1.2rem;
            font-weight: 600;
            color: #ffffff;
            margin-bottom: 1.25rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .profile-card {
            background: rgba(17, 24, 39, 0.6);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 16px;
            padding: 1.75rem;
            height: 100%;
        }

        .form-label {
            color: #94a3b8;
            font-size: 0.85rem;
            font-weight: 500;
        }
        .form-control {
            background: rgba(15, 23, 42, 0.5) !important;
            border: 1px solid rgba(255, 255, 255, 0.1) !important;
            color: white !important;
            border-radius: 8px !important;
            padding: 0.55rem 0.75rem !important;
            font-size: 0.9rem !important;
        }
        .form-control:focus {
            border-color: #2563eb !important;
            box-shadow: none !important;
        }
        .form-control:disabled {
            background: rgba(15, 23, 42, 0.3) !important;
            border-color: rgba(255, 255, 255, 0.05) !important;
            color: #64748b !important;
        }
        .btn-save-profile {
            background: #2563eb;
            color: white;
            border: none;
            padding: 0.6rem 1.5rem;
            font-weight: 600;
            font-size: 0.9rem;
            border-radius: 8px;
            transition: all 0.2s;
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.2);
            width: 100%;
        }
        .btn-save-profile:hover {
            background: #1d4ed8;
            transform: translateY(-1px);
        }

        .history-table {
            width: 100%;
            border-collapse: collapse;
        }
        .history-table th {
            background: rgba(15, 23, 42, 0.6);
            color: #94a3b8;
            font-weight: 600;
            padding: 0.85rem 1rem;
            font-size: 0.8rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.08);
        }
        .history-table td {
            padding: 1rem;
            color: #e2e8f0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.04);
            vertical-align: middle;
            font-size: 0.9rem;
        }
        .history-table tr:hover td {
            background: rgba(255, 255, 255, 0.01);
        }
        .btn-view-invoice {
            background: rgba(59, 130, 246, 0.1);
            border: 1px solid rgba(59, 130, 246, 0.2);
            color: #60a5fa;
            font-size: 0.8rem;
            font-weight: 500;
            padding: 0.35rem 0.75rem;
            border-radius: 6px;
            text-decoration: none;
            transition: all 0.2s;
        }
        .btn-view-invoice:hover {
            background: #2563eb;
            color: white;
        }
    </style>
</head>
<body>

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
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/messages"><i class="bi bi-chat-dots me-1"></i> Messages</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container page-section">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1>My Account Profile</h1>
        <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-secondary btn-sm text-white border-opacity-10 rounded-pill px-3">
            <i class="bi bi-arrow-left me-1"></i> Continue Shopping
        </a>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success bg-success bg-opacity-10 border-success border-opacity-20 text-success rounded-3 mb-4 animate__animated animate__fadeIn" role="alert">
            <i class="bi bi-check-circle me-2"></i> ${success}
        </div>
    </c:if>

    <div class="row g-4">

        <div class="col-lg-4">
            <div class="profile-card shadow-lg animate__animated animate__fadeInLeft">
                <h2><i class="bi bi-person-gear text-primary"></i> Personal Details</h2>
                <form method="post" action="${pageContext.request.contextPath}/profile" class="mt-3">
                    <div class="mb-3">
                        <label class="form-label">Email Address (Login Account)</label>
                        <input type="text" class="form-control" value="${user.email}" disabled>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">First Name</label>
                        <input type="text" class="form-control shadow-none" name="firstName" value="${user.firstName}" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Last Name</label>
                        <input type="text" class="form-control shadow-none" name="lastName" value="${user.lastName}" required>
                    </div>
                    <div class="mb-4">
                        <label class="form-label">Mobile Contact Number</label>
                        <input type="text" class="form-control shadow-none" name="mobile" value="${user.mobile}" required>
                    </div>
                    <button type="submit" class="btn-save-profile text-white"><i class="bi bi-cloud-arrow-up me-1"></i> Save Profile Changes</button>
                </form>

                <a href="${pageContext.request.contextPath}/logout" class="btn btn-link text-danger text-decoration-none text-center d-block small mt-4 w-100">
                    <i class="bi bi-box-arrow-right me-1"></i> Securely Logout of System
                </a>
            </div>
        </div>

        <div class="col-lg-8">
            <div class="profile-card shadow-lg animate__animated animate__fadeInRight">
                <h2><i class="bi bi-clock-history text-primary"></i> Order History & Purchases</h2>

                <c:if test="${empty orders}">
                    <div class="text-center py-5 text-muted">
                        <i class="bi bi-bag-x" style="font-size: 2.5rem;"></i>
                        <p class="mt-3 small mb-0">No transaction footprints found. You haven't placed any invoices yet.</p>
                    </div>
                </c:if>

                <c:if test="${not empty orders}">
                    <div class="table-responsive">
                        <table class="history-table">
                            <thead>
                            <tr>
                                <th style="width: 15%">Order #</th>
                                <th style="width: 25%">Transaction Date</th>
                                <th style="width: 20%">Total Amount</th>
                                <th style="width: 20%">Lifecycle Status</th>
                                <th style="width: 20%"></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="o" items="${orders}">
                                <tr>
                                    <td class="fw-semibold text-white">#${o.orderId}</td>
                                    <td class="text-secondary small">${o.orderDate}</td>
                                    <td class="font-monospace text-white fw-medium">Rs. <fmt:formatNumber value="${o.totalAmount}" maxFractionDigits="2" minFractionDigits="2"/></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${o.orderStatus == 'PAID' || o.orderStatus == 'DELIVERED'}">
                                                    <span class="badge bg-success bg-opacity-25 text-success border border-success border-opacity-50 px-2 py-1" style="font-size: 0.75rem;">
                                                            ${o.orderStatus}
                                                    </span>
                                            </c:when>
                                            <c:when test="${o.orderStatus == 'PENDING' || o.orderStatus == 'PROCESSING'}">
                                                    <span class="badge bg-warning bg-opacity-25 text-warning border border-warning border-opacity-50 px-2 py-1" style="font-size: 0.75rem;">
                                                            ${o.orderStatus}
                                                    </span>
                                            </c:when>
                                            <c:otherwise>
                                                    <span class="badge bg-danger bg-opacity-25 text-danger border border-danger border-opacity-50 px-2 py-1" style="font-size: 0.75rem;">
                                                            ${o.orderStatus}
                                                    </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-end">
                                        <a class="btn-view-invoice" href="${pageContext.request.contextPath}/invoice?orderId=${o.orderId}">
                                            <i class="bi bi-file-earmark-text me-1"></i> Invoice
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>
            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
