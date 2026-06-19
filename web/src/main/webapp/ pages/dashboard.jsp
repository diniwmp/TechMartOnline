<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard · TechMart Online</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Sora:wght@600;700&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="tm-app-body">

<div class="tm-topbar">
    <div class="tm-topbar-brand">Tech<span>Mart</span> Online</div>
    <div class="tm-topbar-user">
        <span>${sessionScope.userFirstName} ${sessionScope.userLastName}</span>
        <a class="tm-logout-link" href="${pageContext.request.contextPath}/logout">Log out</a>
    </div>
</div>

<main class="tm-dashboard-main">
    <div class="tm-welcome-card">
        <h1>Welcome back, ${sessionScope.userFirstName} 👋</h1>
        <p>You're logged in as <strong>${sessionScope.userEmail}</strong>.</p>
        <span class="tm-role-badge">${sessionScope.userRole}</span>

        <p style="margin-top:24px; color:#5b6886; font-size:14px;">
            This is a placeholder dashboard. Product catalog, cart, and order
            tracking screens will be added in the next development phase once
            the session/messaging tiers are built out.
        </p>
    </div>
</main>

</body>
</html>
