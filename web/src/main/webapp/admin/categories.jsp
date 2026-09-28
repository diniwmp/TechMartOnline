
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TechMart Online Admin - Categories</title>

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
        .form-control {
            background: rgba(15, 23, 42, 0.6);
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: #f8fafc;
            padding: 0.65rem 1rem;
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
            color: #cbd5e1;
            border-bottom: 1px solid rgba(255, 255, 255, 0.04);
            vertical-align: middle;
        }
        .admin-table tr:hover td {
            background: rgba(255, 255, 255, 0.02);
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
            transition: all 0.2s;
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
            transition: all 0.2s;
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
            color: #334155;
            border-bottom: 1px solid rgba(0, 0, 0, 0.04);
        }
        body.light-mode .admin-table tr:hover td {
            background: rgba(0, 0, 0, 0.01);
        }
    </style>
</head>
<body>

<div class="admin-wrapper">
    <%@ include file="_sidebar.jsp" %>

    <div class="admin-content">
        <h1>Categories</h1>
        <p class="subtitle">Manage product categories inside TechMart Online</p>

        <c:if test="${not empty error}">
            <div class="alert alert-danger d-flex align-items-center mb-4" role="alert" style="border-radius: 8px;">
                <span class="me-2">⚠️</span>
                <div>${error}</div>
            </div>
        </c:if>

        <div class="row g-4">
            <div class="col-lg-4">
                <div class="monitor-card">
                    <h2>${empty editCategory ? "Add New Category" : "Edit Category"}</h2>

                    <form method="post" action="${pageContext.request.contextPath}/admin/categories">
                        <input type="hidden" name="action" value="${empty editCategory ? 'add' : 'update'}">
                        <c:if test="${not empty editCategory}">
                            <input type="hidden" name="catId" value="${editCategory.catId}">
                        </c:if>

                        <div class="mb-4">
                            <label class="form-label mb-2">Category Name</label>
                            <input type="text" name="catName" class="form-control w-100" required value="${editCategory.catName}" placeholder="e.g. Smartphones">
                        </div>

                        <button type="submit" class="btn ${empty editCategory ? 'btn-primary' : 'btn-warning'} w-100 py-2 fw-medium" style="border-radius: 8px;">
                            ${empty editCategory ? "Add Category" : "Update Category"}
                        </button>

                        <c:if test="${not empty editCategory}">
                            <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-outline-secondary w-100 mt-2 py-2 fw-medium" style="border-radius: 8px;">
                                Cancel Edit
                            </a>
                        </c:if>
                    </form>
                </div>
            </div>

            <div class="col-lg-8">
                <div class="monitor-card">
                    <h2>All Available Categories</h2>

                    <div class="table-responsive">
                        <table class="admin-table">
                            <thead>
                            <tr>
                                <th style="width: 15%">ID</th>
                                <th style="width: 55%">Name</th>
                                <th style="width: 30%">Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="cat" items="${categories}">
                                <tr>
                                    <td class="fw-bold text-secondary">#${cat.catId}</td>
                                    <td class="fw-medium style-cat-name">${cat.catName}</td>
                                    <td>
                                        <div class="d-flex gap-2">
                                            <a class="btn-action-edit" href="${pageContext.request.contextPath}/admin/categories?edit=${cat.catId}">
                                                Edit
                                            </a>

                                            <form method="post" action="${pageContext.request.contextPath}/admin/categories" onsubmit="return confirm('Are you sure you want to delete this category?');" class="m-0">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="catId" value="${cat.catId}">
                                                <button type="submit" class="btn-action-delete">Delete</button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty categories}">
                                <tr>
                                    <td colspan="3" class="text-muted text-center py-4">No categories configured yet.</td>
                                </tr>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        if (document.body.classList.contains("light-mode")) {
            document.querySelectorAll(".style-cat-name").forEach(el => el.style.color = "#0f172a");
        }
    });
</script>

</body>
</html>