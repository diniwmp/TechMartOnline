
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TechMart Online Admin - Dashboard</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

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

        .stat-card {
            background: rgba(30, 41, 59, 0.45);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 12px;
            padding: 1.5rem;
            display: flex;
            flex-direction: column;
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-2px);
            border-color: rgba(59, 130, 246, 0.3);
        }

        .stat-card .value {
            font-size: 2.25rem;
            font-weight: 700;
            color: #ffffff;
            line-height: 1;
            margin-bottom: 0.5rem;
        }

        .stat-card .label {
            color: #94a3b8;
            font-size: 0.875rem;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .monitor-card {
            background: rgba(17, 24, 39, 0.6);
            backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 16px;
            padding: 1.5rem;
            height: 100%;
        }

        .monitor-card h2 {
            font-size: 1.1rem;
            font-weight: 600;
            color: #f1f5f9;
            margin-bottom: 1.25rem;
        }

        .log-terminal {
            background: #070a12;
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 8px;
            padding: 1rem;
            font-family: 'Courier New', Courier, monospace;
            font-size: 0.85rem;
            max-height: 320px;
            overflow-y: auto;
            color: #34d399;
        }

        .log-entry {
            margin-bottom: 0.4rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.02);
            padding-bottom: 0.2rem;
        }

        .log-time {
            color: #60a5fa;
        }

        .log-ms {
            color: #f43f5e;
        }

        /* Custom Modern Table */
        .admin-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.9rem;
        }

        .admin-table th {
            background: rgba(15, 23, 42, 0.6);
            color: #94a3b8;
            font-weight: 600;
            padding: 0.75rem 1rem;
            text-align: left;
            border-bottom: 1px solid rgba(255, 255, 255, 0.08);
        }

        .admin-table td {
            padding: 0.75rem 1rem;
            color: #cbd5e1;
            border-bottom: 1px solid rgba(255, 255, 255, 0.04);
        }

        .admin-table tr:hover td {
            background: rgba(255, 255, 255, 0.02);
        }
    </style>
</head>
<body>

<div class="admin-wrapper">
    <%@ include file="_sidebar.jsp" %>

    <div class="admin-content">
        <div class="d-flex justify-content-between align-items-center mb-1">
            <h1>E-Commerce Platform Modernization</h1>
            <span class="badge bg-primary px-3 py-2"
                  style="font-size: 0.85rem; background-color: rgba(59, 130, 246, 0.2) !important; color: #60a5fa; border: 1px solid rgba(59, 130, 246, 0.3)">
                Live System Metrics
            </span>
        </div>
        <p class="subtitle">Real-Time Jakarta EE Performance & Store Overview</p>

        <div class="row g-4 mb-4">
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="value text-info">${productCount}</div>
                    <div class="label">Total Products</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="value text-warning">${categoryCount}</div>
                    <div class="label">Categories</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="value text-success">${brandCount}</div>
                    <div class="label">Brands Connected</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="value text-danger">0.87 <span style="font-size: 1rem;">ms</span></div>
                    <div class="label">Avg Response Latency</div>
                </div>
            </div>
        </div>

        <div class="row g-4 mb-4">
            <div class="col-lg-8">
                <div class="monitor-card">
                    <h2>System Throughput & Response Time (Simulated Live)</h2>
                    <div style="height: 280px; position: relative;">
                        <canvas id="throughputChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="monitor-card">
                    <h2>Operation Breakdowns</h2>
                    <div style="height: 280px; position: relative;"
                         class="d-flex align-items-center justify-content-center">
                        <canvas id="operationChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-4">
            <div class="col-md-6">
                <div class="monitor-card" style="max-height: 380px; overflow-y: auto;">
                    <h2>Average Execution Time by Operation</h2>
                    <table class="admin-table">
                        <thead>
                        <tr>
                            <th>Operation</th>
                            <th>Avg. Time (ms)</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="entry" items="${avgByOperation}">
                            <tr>
                                <td class="fw-medium ">${entry.key}</td>
                                <td class="text-danger fw-bold">
                                    <fmt:formatNumber value="${entry.value}" maxFractionDigits="2"/> ms
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="col-md-6">
                <div class="monitor-card">
                    <h2>Real-Time System Log (Interceptor Audits)</h2>
                    <div class="log-terminal">
                        <c:forEach var="log" items="${logs}">
                            <div class="log-entry">
                                <span class="log-time">[${log.loggedAt}]</span>
                                <span class="text-success fw-bold">SUCCESS</span>
                                [${log.componentType}] Executed <span class="text-warning">${log.operationName}</span>
                                in <span class="log-ms">${log.executionTime}ms</span>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // 1. Line Chart Setup
    const ctxThroughput = document.getElementById('throughputChart').getContext('2d');
    new Chart(ctxThroughput, {
        type: 'line',
        data: {
            labels: ['10s ago', '8s ago', '6s ago', '4s ago', '2s ago', 'Now'],
            datasets: [{
                label: 'Throughput (req/s)',
                data: [12, 19, 3, 5, 2, 10],
                borderColor: '#06b6d4',
                backgroundColor: 'rgba(6, 182, 212, 0.1)',
                borderWidth: 2,
                tension: 0.4,
                fill: true
            }, {
                label: 'Latency (ms)',
                data: [0.5, 0.8, 1.2, 0.4, 0.9, 0.87],
                borderColor: '#f43f5e',
                backgroundColor: 'transparent',
                borderWidth: 2,
                tension: 0.4
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {legend: {labels: {color: '#94a3b8'}}},
            scales: {
                x: {grid: {color: 'rgba(255,255,255,0.05)'}, ticks: {color: '#64748b'}},
                y: {grid: {color: 'rgba(255,255,255,0.05)'}, ticks: {color: '#64748b'}}
            }
        }
    });


    const pCount = Number("${productCount}") || 10;
    const cCount = Number("${categoryCount}") || 5;
    const bCount = Number("${brandCount}") || 3;

    const ctxOps = document.getElementById('operationChart').getContext('2d');
    new Chart(ctxOps, {
        type: 'doughnut',
        data: {
            labels: ['Products', 'Categories', 'Brands'],
            datasets: [{
                data: [pCount, cCount, bCount],
                backgroundColor: ['#a855f7', '#06b6d4', '#10b981'],
                borderWidth: 0
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {legend: {position: 'bottom', labels: {color: '#94a3b8', padding: 20}}}
        }
    });
</script>

</body>
</html>