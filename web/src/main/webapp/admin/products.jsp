<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TechMart Online Admin - Products</title>

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
        .monitor-card h2 {
            font-size: 1.2rem;
            font-weight: 600;
            color: #f1f5f9;
            margin-bottom: 1.25rem;
        }

        .form-label {
            color: #cbd5e1;
            font-weight: 500;
            font-size: 0.875rem;
        }
        .form-control, .form-select {
            background: rgba(15, 23, 42, 0.6);
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: #f8fafc;
            padding: 0.65rem 1rem;
            border-radius: 8px;
            transition: all 0.2s ease;
        }
        .form-select option {
            background: #111827;
            color: #f8fafc;
        }
        .form-control:focus, .form-select:focus {
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
            width: 45px;
            height: 45px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            background: #151f32;
        }

        .btn-action-edit {
            background: rgba(59, 130, 246, 0.15);
            color: #60a5fa;
            border: 1px solid rgba(59, 130, 246, 0.2);
            padding: 0.4rem 0.8rem;
            border-radius: 6px;
            font-size: 0.85rem;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.2s; /* FIX: Added unit 's' */
        }
        .btn-action-edit:hover {
            background: #2563eb;
            color: white;
        }
        .btn-action-delete {
            background: rgba(244, 63, 94, 0.15);
            color: #f43f5e;
            border: 1px solid rgba(244, 63, 94, 0.2);
            padding: 0.4rem 0.8rem;
            border-radius: 6px;
            font-size: 0.85rem;
            font-weight: 500;
            transition: all 0.2s; /* FIX: Added unit 's' */
        }
        .btn-action-delete:hover {
            background: #e11d48;
            color: white;
        }

        body.light-mode {
            background: #f8fafc;
            color: #0f172a;
        }
        body.light-mode .admin-content {
            background: linear-gradient(135deg, #f1f5f9 0%, #e2e8f0 100%);
        }
        body.light-mode h1, body.light-mode .monitor-card h2 {
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
        body.light-mode .form-label {
            color: #334155;
        }
        body.light-mode .form-control, body.light-mode .form-select {
            background: #ffffff;
            border: 1px solid #cbd5e1;
            color: #0f172a;
        }
        body.light-mode .form-select option {
            background: #ffffff;
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
        <h1>Products</h1>
        <p class="subtitle">Manage and optimize TechMart Online product catalog</p>

        <c:if test="${not empty error}">
            <div class="alert alert-danger d-flex align-items-center mb-4" role="alert" style="border-radius: 8px;">
                <span class="me-2">⚠️</span>
                <div>${error}</div>
            </div>
        </c:if>

        <div class="monitor-card">
            <h2>${empty editProduct ? "Add New Product" : "Edit Product"}</h2>

            <form method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/admin/products">
                <input type="hidden" name="action" value="${empty editProduct ? 'add' : 'update'}">
                <c:if test="${not empty editProduct}">
                    <input type="hidden" name="pId" value="${editProduct.PId}">
                </c:if>

                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label mb-2">Product Name</label>
                        <input type="text" name="pName" class="form-control w-100" required value="${editProduct.PName}" placeholder="e.g. Galaxy S24 Ultra">
                    </div>

                    <div class="col-md-3">
                        <label class="form-label mb-2">Category</label>
                        <select name="catId" class="form-select w-100" required>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat.catId}" ${not empty editProduct && editProduct.category.catId == cat.catId ? 'selected' : ''}>
                                        ${cat.catName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-3">
                        <label class="form-label mb-2">Brand</label>
                        <select name="brandId" class="form-select w-100" required>
                            <c:forEach var="b" items="${brands}">
                                <option value="${b.brandId}" ${not empty editProduct && editProduct.brand.brandId == b.brandId ? 'selected' : ''}>
                                        ${b.brandName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label mb-2">Price (Rs.)</label>
                        <input type="number" step="0.01" name="price" class="form-control w-100" required value="${editProduct.stock.price}" placeholder="0.00">
                    </div>

                    <div class="col-md-4">
                        <label class="form-label mb-2">Stock Quantity</label>
                        <input type="number" name="qty" class="form-control w-100" required value="${editProduct.stock.qty}" placeholder="0">
                    </div>

                    <div class="col-md-4">
                        <label class="form-label mb-2">Product Image <span class="text-secondary small">${empty editProduct ? '' : '(Leave empty to keep current)'}</span></label>
                        <input type="file" name="image" class="form-control w-100" accept="image/*" ${empty editProduct ? 'required' : ''}>
                    </div>

                    <div class="col-12">
                        <label class="form-label mb-2">Description</label>
                        <textarea name="description" class="form-control w-100" rows="3" placeholder="Write item specifications here...">${editProduct.description}</textarea>
                    </div>
                </div>

                <div class="mt-4 d-flex gap-2">
                    <button type="submit" class="btn ${empty editProduct ? 'btn-primary' : 'btn-warning'} px-4 py-2 fw-medium" style="border-radius: 8px;">
                        ${empty editProduct ? "Add Product" : "Update Product"}
                    </button>
                    <c:if test="${not empty editProduct}">
                        <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-outline-secondary px-4 py-2 fw-medium" style="border-radius: 8px;">
                            Cancel
                        </a>
                    </c:if>
                </div>
            </form>
        </div>

        <div class="monitor-card">
            <h2>All Products Inside Catalog</h2>

            <div class="table-responsive">
                <table class="admin-table">
                    <thead>
                    <tr>
                        <th style="width: 8%">Image</th>
                        <th style="width: 27%">Name</th>
                        <th style="width: 15%">Category</th>
                        <th style="width: 13%">Brand</th>
                        <th style="width: 15%">Price</th>
                        <th style="width: 9%">Qty</th>
                        <th style="width: 13%">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="p" items="${products}">
                        <tr>
                            <td>
                                <img class="thumb" src="${pageContext.request.contextPath}/images/${p.path}" alt="Product">
                            </td>
                            <td class="fw-medium text-white-toggle">${p.PName}</td>
                            <td><span class="badge bg-secondary-subtle text-secondary border border-secondary-subtle px-2 py-1">${p.category.catName}</span></td>
                            <td>${p.brand.brandName}</td>

                            <td class="text-info fw-semibold">
                                Rs. ${String.format("%.2f", p.stock.price)}
                            </td>

                            <td>
                                <c:choose>
                                    <c:when test="${p.stock.qty == 0}">
                                        <span class="text-danger fw-bold">Out of Stock</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="fw-semibold">${p.stock.qty}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <div class="d-flex gap-2">
                                    <a class="btn-action-edit" href="${pageContext.request.contextPath}/admin/products?edit=${p.PId}">
                                        Edit
                                    </a>
                                    <form method="post" action="${pageContext.request.contextPath}/admin/products" onsubmit="return confirm('Are you sure you want to delete this product?');" class="m-0">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="pId" value="${p.PId}">
                                        <button type="submit" class="btn-action-delete">Delete</button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty products}">
                        <tr>
                            <td colspan="7" class="text-muted text-center py-4">No products available inside database.</td>
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

