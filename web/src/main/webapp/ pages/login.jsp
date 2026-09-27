
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TechMart Online - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .auth-card {
            background: rgba(30, 41, 59, 0.7);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 16px;
            padding: 2.5rem;
            width: 100%;
            max-width: 420px;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.3), 0 10px 10px -5px rgba(0, 0, 0, 0.2);
        }
        .form-control {
            background: rgba(15, 23, 42, 0.6);
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: #f8fafc;
            padding: 0.75rem 1rem;
            border-radius: 8px;
        }
        .form-control:focus {
            background: rgba(15, 23, 42, 0.8);
            border-color: #3b82f6;
            color: #f8fafc;
            box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.25);
        }
        .btn-primary {
            background: #2563eb;
            border: none;
            padding: 0.75rem;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.2s;
        }
        .btn-primary:hover {
            background: #1d4ed8;
            transform: translateY(-1px);
        }
    </style>
</head>
<body>

<div class="auth-card">
    <div class="text-center mb-4">
        <h1 class="text-white fw-bold tracking-tight mb-1" style="font-size: 2rem;">TechMartOnline</h1>
        <p class="text-muted small">Welcome back. Log in to your account</p>
    </div>

    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger d-flex align-items-center" role="alert" style="border-radius: 8px; font-size: 0.9rem;">
        <svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Danger:" fill="currentColor" viewBox="0 0 16 16">
            <path d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
        </svg>
        <div><%= request.getAttribute("error") %></div>
    </div>
    <% } %>

    <% if (request.getAttribute("success") != null) { %>
    <div class="alert alert-success d-flex align-items-center" role="alert" style="border-radius: 8px; font-size: 0.9rem;">
        <svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Success:" fill="currentColor" viewBox="0 0 16 16">
            <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"/>
        </svg>
        <div><%= request.getAttribute("success") %></div>
    </div>
    <% } %>

    <form action="${pageContext.request.contextPath}/login" method="post" class="needs-validation">
        <div class="mb-3">
            <label for="email" class="form-label text-light small fw-medium">Email address</label>
            <input type="email" id="email" name="email" class="form-control" placeholder="you@example.com" required>
        </div>

        <div class="mb-4">
            <label for="password" class="form-label text-light small fw-medium">Password</label>
            <input type="password" id="password" name="password" class="form-control" placeholder="••••••••" required>
        </div>

        <button type="submit" class="btn btn-primary w-100 mb-3">Log In</button>
    </form>

    <div class="text-center pt-2">
        <p class="text-white small mb-0">Don't have an account?
            <a href="${pageContext.request.contextPath}/register" class="text-primary text-decoration-none fw-medium">Create one</a>
        </p>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


