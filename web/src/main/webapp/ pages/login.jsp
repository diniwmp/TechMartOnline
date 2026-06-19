<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Log In · TechMart Online</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Sora:wght@600;700&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="tm-auth-body">

<div class="tm-auth-shell">

    <!-- Brand panel -->
    <div class="tm-brand-panel">
        <div class="tm-brand-logo">Tech<span>Mart</span> Online</div>
        <div>
            <div class="tm-brand-tagline">
                Welcome back to <span class="tm-highlight">the future</span><br/>
                of your tech shopping.
            </div>
            <div class="tm-brand-meta">
                <div><span class="tm-dot"></span> Phones</div>
                <div><span class="tm-dot"></span> Laptops</div>
                <div><span class="tm-dot"></span> Accessories</div>
            </div>
        </div>
    </div>

    <!-- Form panel -->
    <div class="tm-form-panel">
        <div class="tm-form-eyebrow">Sign in</div>
        <h1 class="tm-form-title">Log in to your account</h1>
        <p class="tm-form-subtitle">Pick up your cart right where you left it.</p>

        <c:if test="${not empty errorMessage}">
            <div class="tm-alert tm-alert-error">⚠ ${errorMessage}</div>
        </c:if>
        <c:if test="${not empty successMessage}">
            <div class="tm-alert tm-alert-success">✓ ${successMessage}</div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/login">
            <div class="tm-field">
                <label class="tm-label" for="email">Email address</label>
                <input class="tm-input" type="email" id="email" name="email"
                       placeholder="you@example.com" value="${email}" required autofocus>
            </div>
            <div class="tm-field">
                <label class="tm-label" for="password">Password</label>
                <input class="tm-input" type="password" id="password" name="password"
                       placeholder="••••••••" required>
            </div>
            <button type="submit" class="tm-btn tm-btn-primary">Log in</button>
        </form>

        <div class="tm-form-footer">
            New to TechMart? <a href="${pageContext.request.contextPath}/register">Create an account</a>
        </div>
    </div>

</div>

</body>
</html>
