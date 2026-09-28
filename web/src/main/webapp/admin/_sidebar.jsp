
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    .sidebar-wrapper {
        width: 260px;
        background: #0f172a;
        border-right: 1px solid rgba(255, 255, 255, 0.05);
        display: flex;
        flex-direction: column;
        padding: 1.5rem 1rem;
    }
    .sidebar-brand {
        font-size: 1.25rem;
        font-weight: 700;
        color: #ffffff;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        padding-bottom: 1.5rem;
        margin-bottom: 1.5rem;
        border-bottom: 1px solid rgba(255, 255, 255, 0.05);
    }
    .sidebar-brand span {
        color: #60a5fa;
        font-size: 0.8rem;
        font-weight: 400;
    }
    .sidebar-menu {
        list-style: none;
        padding: 0;
        margin: 0;
        display: flex;
        flex-direction: column;
        gap: 0.4rem;
    }
    .sidebar-link {
        display: flex;
        align-items: center;
        padding: 0.75rem 1rem;
        color: #94a3b8;
        text-decoration: none;
        border-radius: 8px;
        font-weight: 500;
        font-size: 0.95rem;
        transition: all 0.2s ease;
    }
    .sidebar-link:hover {
        background: rgba(255, 255, 255, 0.03);
        color: #f1f5f9;
    }
    .sidebar-link.active {
        background: rgba(59, 130, 246, 0.15);
        color: #60a5fa;
        border: 1px solid rgba(59, 130, 246, 0.2);
    }
    .sidebar-footer {
        margin-top: auto;
        padding-top: 1rem;
        border-top: 1px solid rgba(255, 255, 255, 0.05);
    }
    .logout-link {
        color: #f43f5e;
    }
    .logout-link:hover {
        background: rgba(244, 63, 94, 0.1);
        color: #fda4af;
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
    body.light-mode .stat-card, body.light-mode .monitor-card {
        background: rgba(255, 255, 255, 0.8);
        border: 1px solid rgba(0, 0, 0, 0.06);
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
    }
    body.light-mode .stat-card .value {
        color: #0f172a;
    }
    body.light-mode .stat-card .label {
        color: #64748b;
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
    body.light-mode .log-terminal {
        background: #f1f5f9;
        border: 1px solid rgba(0, 0, 0, 0.06);
        color: #065f46; /* Darker green for readability */
    }
    body.light-mode .log-terminal .text-white {
        color: #0f172a !important;
    }
</style>

<div class="sidebar-wrapper">
    <div class="sidebar-brand">
        <div>
            TechMart
            <div class="text-muted" style="font-size: 0.75rem; font-weight: 400; letter-spacing: 0.05em;">ADMIN PANEL</div>
        </div>
    </div>

    <ul class="sidebar-menu">
        <li>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link active">
                Dashboard
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/categories" class="sidebar-link">
                Categories
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/brands" class="sidebar-link">
                Brands
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/products" class="sidebar-link">
                Products
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/inventory" class="sidebar-link">
                Inventory
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/admin/orders" class="sidebar-link">
                Orders
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/users" class="sidebar-link">
                User
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/notifications" class="sidebar-link">
                Notifications
            </a>
        </li>
    </ul>

    <div class="sidebar-footer">
        <button id="theme-toggle" class="sidebar-link w-100 border-0 text-start bg-transparent mb-2" style="color: #94a3b8;">
            <span id="theme-icon" class="me-2">☀️</span> <span id="theme-text">Light Mode</span>
        </button>

        <a href="${pageContext.request.contextPath}/logout" class="sidebar-link logout-link">
            Logout
        </a>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const themeToggleBtn = document.getElementById("theme-toggle");
        const themeIcon = document.getElementById("theme-icon");
        const themeText = document.getElementById("theme-text");
        const body = document.body;


        const currentTheme = localStorage.getItem("theme");

        if (currentTheme === "light") {
            body.classList.add("light-mode");
            themeIcon.innerText = "🌙";
            themeText.innerText = "Dark Mode";
        } else {
            body.classList.remove("light-mode");
            themeIcon.innerText = "☀️";
            themeText.innerText = "Light Mode";
        }


        themeToggleBtn.addEventListener("click", function () {
            body.classList.toggle("light-mode");

            if (body.classList.contains("light-mode")) {
                localStorage.setItem("theme", "light");
                themeIcon.innerText = "🌙";
                themeText.innerText = "Dark Mode";

                if(typeof Chart !== 'undefined') { updateChartsToLightMode(); }
            } else {
                localStorage.setItem("theme", "dark");
                themeIcon.innerText = "☀️";
                themeText.innerText = "Light Mode";


                if(typeof Chart !== 'undefined') { window.location.reload(); }
            }
        });
    });
</script>


