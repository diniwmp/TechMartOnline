
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TechMart Online Admin - Inventory</title>

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

        .form-control {
            background: rgba(15, 23, 42, 0.6);
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: #f8fafc;
            padding: 0.4rem 0.75rem;
            border-radius: 8px;
            transition: all 0.2s ease;
        }
        .form-control:focus {
            background: rgba(15, 23, 42, 0.8);
            border-color: #3b82f6;
            color: #f8fafc;
            box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.25);
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

        .thumb {
            width: 42px;
            height: 42px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            background: #151f32;
        }

        .btn-apply {
            background: #2563eb;
            color: white;
            border: none;
            padding: 0.4rem 1rem;
            border-radius: 8px;
            font-size: 0.85rem;
            font-weight: 500;
            transition: all 0.2s;
        }
        .btn-apply:hover {
            background: #1d4ed8;
        }

        body.light-mode {
            background: #f8fafc;
            color: #0f172a;
        }
        body.light-mode .admin-content {
            background: linear-gradient(135deg, #f1f5f9 0%, #e2e8f0 100%);
        }
        body.light-mode h1 {
            color: #0f172a;
        }
        body.light-mode .subtitle {
            color: #475569;
        }
        body.light-mode .monitor-card {
            background: rgba(255, 255, 255, 0.8);
            border: 1px solid rgba(0, 0, 0, 0.06);
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
        }
        body.light-mode .form-control {
            background: #ffffff;
            border: 1px solid #cbd5e1;
            color: #0f172a;
        }
        body.light-mode .form-control:focus {
            border-color: #2563eb;
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
        body.light-mode .thumb {
            border: 1px solid rgba(0, 0, 0, 0.08);
            background: #f1f5f9;
        }
    </style>
</head>
<body>

<div class="admin-wrapper">
    <%@ include file="_sidebar.jsp" %>

    <div class="admin-content">
        <h1>Inventory</h1>
        <p class="subtitle">Live stock levels — restock or adjust quantities dynamically</p>

        <div class="monitor-card">
            <div class="table-responsive">
                <table class="admin-table">
                    <thead>
                    <tr>
                        <th style="width: 8%">Image</th>
                        <th style="width: 42%">Product</th>
                        <th style="width: 15%">Current Qty</th>
                        <th style="width: 15%">Status</th>
                        <th style="width: 20%">Adjust Stock</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="p" items="${products}">
                        <tr>
                            <td>
                                <img class="thumb" src="${pageContext.request.contextPath}/images/${p.path}" alt="Product">
                            </td>
                            <td class="fw-medium text-white-toggle">${p.PName}</td>
                            <td class="fw-semibold">${p.stock.qty}</td>
                            <td>
                                <c:if test="${p.stock.qty <= 5}">
                                    <span class="badge bg-danger bg-opacity-25 text-danger border border-danger border-opacity-50 px-2 py-1" style="font-size: 0.8rem;">Low Stock</span>
                                </c:if>
                                <c:if test="${p.stock.qty > 5}">
                                    <span class="badge bg-success bg-opacity-25 text-success border border-success border-opacity-50 px-2 py-1" style="font-size: 0.8rem;">In Stock</span>
                                </c:if>
                            </td>
                            <td>
                                <form method="post" action="${pageContext.request.contextPath}/admin/inventory" class="m-0">
                                    <input type="hidden" name="pId" value="${p.PId}">
                                    <div class="input-group" style="max-width: 160px;">
                                        <input type="number" name="delta" class="form-control form-control-sm text-center" placeholder="+/- qty" required>
                                        <button type="submit" class="btn-apply">Apply</button>
                                    </div>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty products}">
                        <tr>
                            <td colspan="5" class="text-muted text-center py-4">No inventory logs sync available.</td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        if (document.body.classList.contains("light-mode")) {
            document.querySelectorAll(".text-white-toggle").forEach(el => el.style.color = "#0f172a");
        }
    });
</script>

</body>
</html>