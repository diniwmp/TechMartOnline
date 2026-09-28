

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TechMart Online Admin - Orders</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: #0b0f19;
            color: #f8fafc;
            margin: 0;
        }
        .admin-wrapper {
            display: flex;
            min-height: 100vh;
        }
        .admin-content {
            flex: 1;
            padding: 2.5rem;
            background: linear-gradient(135deg, #0b0f19 0%, #111827 100%);
            overflow-y: auto;
        }
        h1 {
            font-size: 2rem;
            font-weight: 700;
            color: #ffffff;
            margin-bottom: 0.25rem;
        }
        .subtitle {
            color: #94a3b8;
            font-size: 0.95rem;
            margin-bottom: 2rem;
        }

        .monitor-card {
            background: rgba(17, 24, 39, 0.6);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 16px;
            padding: 1.75rem;
            margin-bottom: 1.75rem;
        }

        .chip-group {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
            margin-bottom: 1.75rem;
        }
        .status-chip {
            padding: 0.5rem 1.25rem;
            border-radius: 50px;
            background: rgba(30, 41, 59, 0.4);
            border: 1px solid rgba(255, 255, 255, 0.08);
            color: #94a3b8;
            font-size: 0.85rem;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.2s ease;
        }
        .status-chip:hover {
            background: rgba(59, 130, 246, 0.1);
            color: #f1f5f9;
            border-color: rgba(59, 130, 246, 0.3);
        }
        .status-chip.active-chip {
            background: #2563eb !important;
            color: white !important;
            border-color: #2563eb !important;
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
        }

        .admin-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.9rem;
        }
        .admin-table th {
            background: rgba(15, 23, 42, 0.6);
            color: #94a3b8;
            font-weight: 600;
            padding: 0.85rem 1rem;
            text-align: left;
            border-bottom: 1px solid rgba(255, 255, 255, 0.08);
        }
        .admin-table td {
            padding: 0.85rem 1rem;
            color: #e2e8f0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.04);
            vertical-align: middle;
        }
        .admin-table tr:hover td {
            background: rgba(255, 255, 255, 0.02);
        }

        .form-select-sm {
            background: rgba(15, 23, 42, 0.6);
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: #f8fafc;
            border-radius: 6px;
        }
        .form-select-sm option {
            background: #111827;
            color: #f8fafc;
        }

        .btn-update {
            background: rgba(59, 130, 246, 0.15);
            color: #60a5fa;
            border: 1px solid rgba(59, 130, 246, 0.2);
            padding: 0.3rem 0.75rem;
            border-radius: 6px;
            font-size: 0.8rem;
            font-weight: 500;
            transition: all 0.2s ease;
        }
        .btn-update:hover {
            background: #2563eb;
            color: white;
        }

        .pagination .page-link {
            background: rgba(30, 41, 59, 0.4);
            border: 1px solid rgba(255, 255, 255, 0.08);
            color: #94a3b8;
            padding: 0.5rem 0.75rem;
            transition: all 0.2s;
        }
        .pagination .page-link:hover {
            background: rgba(255, 255, 255, 0.05);
            color: #ffffff;
        }
        .pagination .page-item.active .page-link {
            background: #2563eb;
            border-color: #2563eb;
            color: white;
        }


        body.light-mode {
            background: #f8fafc;
            color: #0f172a;
        }
        body.light-mode .admin-content {
            background: linear-gradient(135deg, #f1f5f9 0%, #e2e8f0 100%);
        }
        body.light-mode h1 { color: #0f172a; }
        body.light-mode .subtitle { color: #475569; }
        body.light-mode .monitor-card {
            background: rgba(255, 255, 255, 0.8);
            border: 1px solid rgba(0, 0, 0, 0.06);
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
        }
        body.light-mode .status-chip {
            background: #ffffff;
            border: 1px solid #cbd5e1;
            color: #64748b;
        }
        body.light-mode .status-chip:hover {
            background: #f1f5f9;
            color: #0f172a;
        }
        body.light-mode .admin-table th {
            background: rgba(226, 232, 240, 0.8);
            color: #334155;
            border-bottom: 1px solid rgba(0, 0, 0, 0.08);
        }
        body.light-mode .admin-table td {
            color: #1e293b;
            border-bottom: 1px solid rgba(0, 0, 0, 0.04);
        }
        body.light-mode .form-select-sm {
            background: #ffffff;
            border: 1px solid #cbd5e1;
            color: #0f172a;
        }
        body.light-mode .form-select-sm option {
            background: #ffffff;
            color: #0f172a;
        }
        body.light-mode .pagination .page-link {
            background: #ffffff;
            border: 1px solid #cbd5e1;
            color: #475569;
        }
    </style>
</head>
<body>

<div class="admin-wrapper">
    <%@ include file="_sidebar.jsp" %>

    <div class="admin-content">
        <h1>Orders Management</h1>
        <p class="subtitle">Track incoming sales and manage real-time lifecycle states</p>

        <c:if test="${not empty success}">
            <div class="alert alert-success d-flex align-items-center mb-3" style="border-radius: 8px;">
                <span class="me-2">✓</span><div>${success}</div>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger d-flex align-items-center mb-3" style="border-radius: 8px;">
                <span class="me-2">⚠️</span><div>${error}</div>
            </div>
        </c:if>

        <div class="chip-group">
            <a href="${pageContext.request.contextPath}/admin/orders" class="status-chip ${empty selectedStatus || selectedStatus == 'ALL' ? 'active-chip' : ''}">All Orders</a>
            <a href="${pageContext.request.contextPath}/admin/orders?status=PENDING" class="status-chip ${selectedStatus == 'PENDING' ? 'active-chip' : ''}">Pending</a>
            <a href="${pageContext.request.contextPath}/admin/orders?status=PAID" class="status-chip ${selectedStatus == 'PAID' ? 'active-chip' : ''}">Paid</a>
            <a href="${pageContext.request.contextPath}/admin/orders?status=PROCESSING" class="status-chip ${selectedStatus == 'PROCESSING' ? 'active-chip' : ''}">Processing</a>
            <a href="${pageContext.request.contextPath}/admin/orders?status=SHIPPED" class="status-chip ${selectedStatus == 'SHIPPED' ? 'active-chip' : ''}">Shipped</a>
            <a href="${pageContext.request.contextPath}/admin/orders?status=DELIVERED" class="status-chip ${selectedStatus == 'DELIVERED' ? 'active-chip' : ''}">Delivered</a>
            <a href="${pageContext.request.contextPath}/admin/orders?status=CANCELLED" class="status-chip ${selectedStatus == 'CANCELLED' ? 'active-chip' : ''}">Cancelled</a>
        </div>

        <div class="monitor-card">
            <div class="table-responsive">
                <table class="admin-table">
                    <thead>
                    <tr>
                        <th style="width: 10%">Order #</th>
                        <th style="width: 25%">Customer</th>
                        <th style="width: 15%">Date</th>
                        <th style="width: 15%">Total</th>
                        <th style="width: 15%">Status</th>
                        <th style="width: 20%">Update Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="o" items="${orders}">
                        <tr>
                            <td class="fw-bold text-secondary">#${o.orderId}</td>
                            <td class="text-white-toggle fw-medium">${o.userEmail}</td>
                            <td class="small text-muted-toggle">${o.orderDate}</td>
                            <td class="text-info fw-semibold">Rs. ${String.format("%.2f", o.totalAmount)}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${o.orderStatus == 'DELIVERED' || o.orderStatus == 'PAID'}">
                                        <span class="badge bg-success bg-opacity-25 text-success border border-success border-opacity-50 px-2 py-1">${o.orderStatus}</span>
                                    </c:when>
                                    <c:when test="${o.orderStatus == 'CANCELLED'}">
                                        <span class="badge bg-danger bg-opacity-25 text-danger border border-danger border-opacity-50 px-2 py-1">${o.orderStatus}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-warning bg-opacity-25 text-warning border border-warning border-opacity-50 px-2 py-1">${o.orderStatus}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <form method="post" action="${pageContext.request.contextPath}/admin/orders" class="d-flex gap-2 m-0">
                                    <input type="hidden" name="orderId" value="${o.orderId}">
                                    <input type="hidden" name="currentFilter" value="${selectedStatus}">

                                    <select name="newStatus" class="form-select form-select-sm py-1" style="max-width: 130px;">
                                        <option value="PENDING" ${o.orderStatus == 'PENDING' ? 'selected' : ''}>Pending</option>
                                        <option value="PAID" ${o.orderStatus == 'PAID' ? 'selected' : ''}>Paid</option>
                                        <option value="PROCESSING" ${o.orderStatus == 'PROCESSING' ? 'selected' : ''}>Processing</option>
                                        <option value="SHIPPED" ${o.orderStatus == 'SHIPPED' ? 'selected' : ''}>Shipped</option>
                                        <option value="DELIVERED" ${o.orderStatus == 'DELIVERED' ? 'selected' : ''}>Delivered</option>
                                        <option value="CANCELLED" ${o.orderStatus == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                                    </select>
                                    <button type="submit" class="btn-update">Update</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty orders}">
                        <tr>
                            <td colspan="6" class="text-muted text-center py-4">No logged orders found matching this filter state.</td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>

            <c:if test="${totalPages > 1}">
                <nav class="d-flex justify-content-center mt-4">
                    <ul class="pagination pagination-sm m-0">
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/admin/orders?page=${currentPage - 1}${not empty selectedStatus ? '&status='.concat(selectedStatus) : ''}">&laquo;</a>
                        </li>

                        <c:forEach begin="1" end="${totalPages}" var="pageNo">
                            <li class="page-item ${currentPage == pageNo ? 'active' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/admin/orders?page=${pageNo}${not empty selectedStatus ? '&status='.concat(selectedStatus) : ''}">${pageNo}</a>
                            </li>
                        </c:forEach>

                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/admin/orders?page=${currentPage + 1}${not empty selectedStatus ? '&status='.concat(selectedStatus) : ''}">&raquo;</a>
                        </li>
                    </ul>
                </nav>
            </c:if>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        if (document.body.classList.contains("light-mode")) {
            document.querySelectorAll(".text-white-toggle").forEach(el => el.style.color = "#0f172a");
            document.querySelectorAll(".text-muted-toggle").forEach(el => el.style.color = "#64748b");
        }
    });
</script>

</body>
</html>