<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TechMart Online - Register</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body.auth-bg {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
            padding: 2rem 0;
        }
        .auth-card {
            background: rgba(30, 41, 59, 0.7);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 16px;
            padding: 2.5rem;
            width: 100%;
            max-width: 550px;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.4), 0 10px 10px -5px rgba(0, 0, 0, 0.2);
        }
        .auth-logo {
            font-size: 2.25rem;
            font-weight: 700;
            color: #ffffff;
            letter-spacing: -0.05em;
        }
        .auth-sub {
            color: #94a3b8;
            font-size: 0.95rem;
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
        .btn-submit {
            background: #2563eb;
            color: white;
            border: none;
            padding: 0.75rem;
            border-radius: 8px;
            font-weight: 500;
            width: 100%;
            transition: all 0.2s ease;
        }
        .btn-submit:hover {
            background: #1d4ed8;
            transform: translateY(-1px);
        }
        .auth-footer {
            color: #94a3b8;
            font-size: 0.875rem;
            margin-top: 1.5rem;
        }
        .auth-footer a {
            color: #3b82f6;
            text-decoration: none;
            font-weight: 500;
        }
        .auth-footer a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body class="auth-bg">

<div class="auth-card text-center">
    <h1 class="auth-logo mb-1">TechMart Online</h1>
    <p class="auth-sub mb-4">Create your account to get started.</p>

    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger d-flex align-items-center text-start mb-3" role="alert" style="border-radius: 8px; font-size: 0.9rem; background-color: rgba(239, 68, 68, 0.2); border: 1px solid rgba(239, 68, 68, 0.3); color: #fca5a5;">
        <div class="me-2">⚠️</div>
        <div><%= request.getAttribute("error") %></div>
    </div>
    <% } %>

    <form action="${pageContext.request.contextPath}/register" method="post" class="auth-form text-start">

        <div class="row g-3 mb-4">
            <div class="col-md-6">
                <label class="form-label mb-2">First Name</label>
                <input type="text" name="firstName" class="form-control" required placeholder="John">
            </div>

            <div class="col-md-6">
                <label class="form-label mb-2">Last Name</label>
                <input type="text" name="lastName" class="form-control" required placeholder="Doe">
            </div>

            <div class="col-md-6">
                <label class="form-label mb-2">Email address</label>
                <input type="email" name="email" class="form-control" required placeholder="name@example.com">
            </div>

            <div class="col-md-6">
                <label class="form-label mb-2">Mobile Number</label>
                <input type="text" name="mobile" class="form-control" required placeholder="07XXXXXXXX">
            </div>

            <div class="col-md-6">
                <label class="form-label mb-2">Password</label>
                <input type="password" name="password" class="form-control" required placeholder="••••••••">
            </div>

            <div class="col-md-6">
                <label class="form-label mb-2">Confirm Password</label>
                <input type="password" name="confirmPassword" class="form-control" required placeholder="••••••••">
            </div>
        </div>

        <button type="submit" class="btn-submit">Create Account</button>
    </form>

    <p class="auth-footer mb-0">Already have an account?
        <a href="${pageContext.request.contextPath}/login">Log in</a>
    </p>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>