<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account · TechMart Online</title>
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
                Your next phone, laptop,<br/>
                or upgrade is <span class="tm-highlight">one click away</span>.
            </div>
            <div class="tm-brand-meta">
                <div><span class="tm-dot"></span> Fast checkout</div>
                <div><span class="tm-dot"></span> Live stock</div>
                <div><span class="tm-dot"></span> Order tracking</div>
            </div>
        </div>
    </div>

    <!-- Form panel -->
    <div class="tm-form-panel">
        <div class="tm-form-eyebrow">Get started</div>
        <h1 class="tm-form-title">Create your account</h1>
        <p class="tm-form-subtitle">Takes less than a minute.</p>

        <c:if test="${not empty errorMessage}">
            <div class="tm-alert tm-alert-error">⚠ ${errorMessage}</div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/register">
            <div class="tm-field tm-field-row">
                <div>
                    <label class="tm-label" for="firstName">First name</label>
                    <input class="tm-input" type="text" id="firstName" name="firstName"
                           placeholder="Nimal" value="${firstName}" required autofocus>
                </div>
                <div>
                    <label class="tm-label" for="lastName">Last name</label>
                    <input class="tm-input" type="text" id="lastName" name="lastName"
                           placeholder="Perera" value="${lastName}" required>
                </div>
            </div>

            <div class="tm-field">
                <label class="tm-label" for="email">Email address</label>
                <input class="tm-input" type="email" id="email" name="email"
                       placeholder="you@example.com" value="${email}" required>
            </div>

            <div class="tm-field">
                <label class="tm-label" for="mobile">Mobile number</label>
                <input class="tm-input" type="text" id="mobile" name="mobile"
                       placeholder="077 123 4567" value="${mobile}" required>
            </div>

            <div class="tm-field tm-field-row">
                <div>
                    <label class="tm-label" for="password">Password</label>
                    <input class="tm-input" type="password" id="password" name="password"
                           placeholder="At least 6 characters" minlength="6" required>
                </div>
                <div>
                    <label class="tm-label" for="confirmPassword">Confirm password</label>
                    <input class="tm-input" type="password" id="confirmPassword" name="confirmPassword"
                           placeholder="Re-enter password" minlength="6" required>
                </div>
            </div>

            <button type="submit" class="tm-btn tm-btn-primary">Create account</button>
        </form>

        <div class="tm-form-footer">
            Already have an account? <a href="${pageContext.request.contextPath}/login">Log in</a>
        </div>
    </div>

</div>

</body>
</html>
