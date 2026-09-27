
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Messages - TechMart Online</title>

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

        .msg-card {
            background: rgba(17, 24, 39, 0.6);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 16px;
            padding: 1.5rem;
            margin-top: 1.5rem;
        }

        .msg-table {
            width: 100%;
            border-collapse: collapse;
        }
        .msg-table th {
            background: rgba(15, 23, 42, 0.6);
            color: #94a3b8;
            font-weight: 600;
            padding: 1rem;
            font-size: 0.85rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.08);
        }
        .msg-table td {
            padding: 1.25rem 1rem;
            color: #e2e8f0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.04);
            vertical-align: middle;
        }
        .msg-table tr:hover td {
            background: rgba(255, 255, 255, 0.01);
        }
        .msg-text {
            color: #f1f5f9;
            font-size: 0.95rem;
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
                <li class="nav-item dropdown ms-lg-2">
                    <a class="nav-link btn btn-outline-light btn-sm text-white px-3 py-1.5 border-opacity-10 d-inline-block" href="#" data-bs-toggle="dropdown">
                        <i class="bi bi-person-circle me-1"></i> Account
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end dropdown-menu-dark bg-dark border-secondary border-opacity-20 mt-2 shadow-lg">
                        <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/profile"><i class="bi bi-sliders me-2"></i> My Profile</a></li>
                        <li><hr class="dropdown-divider opacity-10"></li>
                        <li><a class="dropdown-item py-2 text-danger" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right me-2"></i> Logout</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container page-section">
    <div class="d-flex justify-content-between align-items-center mb-2">
        <h1>My Messages & Alerts</h1>
        <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-secondary btn-sm text-white border-opacity-10 rounded-pill px-3">
            <i class="bi bi-arrow-left me-1"></i> Continue Shopping
        </a>
    </div>

    <c:if test="${empty messages}">
        <div class="msg-card text-center py-5">
            <i class="bi bi-chat-left-dots text-muted" style="font-size: 3rem;"></i>
            <p class="text-secondary mt-3 mb-0">You don't have any system notifications or order alerts yet.</p>
        </div>
    </c:if>

    <c:if test="${not empty messages}">
        <div class="msg-card shadow-lg animate__animated animate__fadeIn">
            <div class="table-responsive">
                <table class="msg-table">
                    <thead>
                    <tr>
                        <th style="width: 20%">Alert Category</th>
                        <th style="width: 60%">Message Content Context</th>
                        <th style="width: 20%">Received Date</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="m" items="${messages}">
                        <tr>
                            <td>
                                <c:choose>
                                    <c:when test="${m.notifiType eq 'ORDER_UPDATE'}">
                                            <span class="badge bg-success bg-opacity-25 text-success border border-success border-opacity-50 px-2 py-1" style="font-size: 0.75rem; letter-spacing: 0.03em;">
                                                <i class="bi bi-box-seam me-1"></i> ORDER UPDATE
                                            </span>
                                    </c:when>
                                    <c:when test="${m.notifiType eq 'PROMO'}">
                                            <span class="badge bg-info bg-opacity-25 text-info border border-info border-opacity-50 px-2 py-1" style="font-size: 0.75rem; letter-spacing: 0.03em;">
                                                <i class="bi bi-tag me-1"></i> PROMOTION
                                            </span>
                                    </c:when>
                                    <c:otherwise>
                                            <span class="badge bg-primary bg-opacity-25 text-primary border border-primary border-opacity-50 px-2 py-1" style="font-size: 0.75rem; letter-spacing: 0.03em;">
                                                <i class="bi bi-bell me-1"></i> ${m.notifiType}
                                            </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="msg-text fw-medium">
                                    ${m.message}
                            </td>
                            <td class="text-secondary small font-monospace">
                                    ${m.createdAt}
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
