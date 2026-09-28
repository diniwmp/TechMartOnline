

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TechMart Online Admin - Notifications</title>

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
        body.light-mode .admin-table th {
            background: rgba(226, 232, 240, 0.8);
            color: #334155;
            border-bottom: 1px solid rgba(0, 0, 0, 0.08);
        }
        body.light-mode .admin-table td {
            color: #1e293b;
            border-bottom: 1px solid rgba(0, 0, 0, 0.04);
        }
    </style>
</head>
<body>

<div class="admin-wrapper">
    <%@ include file="_sidebar.jsp" %>

    <div class="admin-content">
        <h1>Notifications</h1>
        <p class="subtitle">System events captured automatically by the Stock Alert Message-Driven Bean (MDB)</p>

        <div class="monitor-card">
            <div class="table-responsive">
                <table class="admin-table">
                    <thead>
                    <tr>
                        <th style="width: 15%">Type</th>
                        <th style="width: 60%">Message</th>
                        <th style="width: 25%">Created At</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="n" items="${notifications}">
                        <tr>
                            <td>
                                <c:choose>
                                    <c:when test="${n.notifiType == 'OUT_OF_STOCK'}">
                                            <span class="badge bg-danger bg-opacity-25 text-danger border border-danger border-opacity-50 px-2 py-1" style="font-size: 0.8rem;">
                                                OUT OF STOCK
                                            </span>
                                    </c:when>
                                    <c:when test="${n.notifiType == 'LOW_STOCK'}">
                                            <span class="badge bg-warning bg-opacity-25 text-warning border border-warning border-opacity-50 px-2 py-1" style="font-size: 0.8rem;">
                                                LOW STOCK
                                            </span>
                                    </c:when>
                                    <c:otherwise>
                                            <span class="badge bg-info bg-opacity-25 text-info border border-info border-opacity-50 px-2 py-1" style="font-size: 0.8rem;">
                                                    ${n.notifiType}
                                            </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="fw-medium text-white-toggle">${n.message}</td>
                            <td class="text-secondary small">${n.createdAt}</td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty notifications}">
                        <tr>
                            <td colspan="3" class="text-muted text-center py-4">
                                🔔 No new system alerts or notifications found.
                            </td>
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