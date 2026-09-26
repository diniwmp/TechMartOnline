<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Invoice #${order.orderId} - TechMart Online</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #0b0f19;
            color: #f8fafc;
            overflow-x: hidden;
        }

        .navbar {
            background: rgba(15, 23, 42, 0.85) !important;
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
            padding: 0.85rem 0;
        }
        .navbar-brand {
            font-weight: 700;
            letter-spacing: -0.03em;
            color: #ffffff !important;
            text-decoration: none;
        }
        .nav-link {
            color: #94a3b8 !important;
            font-weight: 500;
        }

        .invoice-wrapper {
            background: rgba(17, 24, 39, 0.6);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 16px;
            padding: 3rem;
            margin-top: 2.5rem;
            margin-bottom: 4rem;
        }

        .invoice-title {
            font-size: 2.25rem;
            font-weight: 800;
            color: #ffffff;
            letter-spacing: -0.03em;
        }

        .info-label {
            color: #94a3b8;
            font-size: 0.85rem;
            font-weight: 500;
        }

        .info-value {
            color: #f1f5f9;
            font-weight: 600;
        }

        .invoice-table {
            width: 100%;
            border-collapse: collapse;
            margin: 2rem 0;
        }
        .invoice-table th {
            background: rgba(15, 23, 42, 0.6);
            color: #94a3b8;
            font-weight: 600;
            padding: 0.85rem 1rem;
            font-size: 0.85rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.08);
        }
        .invoice-table td {
            padding: 1rem;
            color: #e2e8f0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.04);
            vertical-align: middle;
        }
        .thumb {
            width: 40px;
            height: 40px;
            object-fit: contain;
            background: rgba(255, 255, 255, 0.02);
            border-radius: 6px;
            padding: 2px;
            border: 1px solid rgba(255, 255, 255, 0.05);
        }

        .invoice-summary {
            border-top: 1px solid rgba(255, 255, 255, 0.08);
            padding-top: 1.5rem;
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            gap: 0.5rem;
        }
        .summary-item {
            display: flex;
            justify-content: space-between;
            width: 280px;
            font-size: 0.95rem;
            color: #94a3b8;
        }
        .summary-item.grand-total {
            font-size: 1.35rem;
            font-weight: 700;
            color: #ffffff;
            border-top: 1px solid rgba(255, 255, 255, 0.05);
            padding-top: 0.75rem;
            margin-top: 0.25rem;
        }

        .btn-print-action {
            background: #2563eb;
            color: white;
            border: none;
            padding: 0.65rem 1.75rem;
            font-weight: 600;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.2);
            transition: all 0.2s;
        }
        .btn-print-action:hover {
            background: #1d4ed8;
            transform: translateY(-1px);
        }


        @media print {
            .no-print {
                display: none !important;
            }
            body {
                background: #ffffff !important;
                color: #000000 !important;
                font-size: 12px;
            }
            .invoice-wrapper {
                background: transparent !important;
                border: none !important;
                padding: 0 !important;
                margin: 0 !important;
                box-shadow: none !important;
            }
            .invoice-title, h1, h3, .info-value, .summary-item.grand-total {
                color: #000000 !important;
            }
            .info-label, .invoice-table th, .summary-item {
                color: #4b5563 !important;
            }
            .invoice-table th {
                background: #f3f4f6 !important;
                border-bottom: 2px solid #000000 !important;
            }
            .invoice-table td {
                color: #000000 !important;
                border-bottom: 1px solid #e5e7eb !important;
            }
            .invoice-summary {
                border-top: 2px solid #000000 !important;
            }
            .thumb {
                border: 1px solid #e5e7eb !important;
            }
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg sticky-top no-print">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/home">
            <i class="bi bi-cpu text-primary fs-3"></i> TechMart Online
        </a>
        <div class="ms-auto">
            <a href="${pageContext.request.contextPath}/profile" class="btn btn-sm btn-outline-secondary text-white border-opacity-10 rounded-pill px-3">
                <i class="bi bi-arrow-left me-1"></i> My Profile
            </a>
        </div>
    </div>
</nav>

<div class="container">

    <div class="invoice-wrapper shadow-lg animate__animated animate__fadeIn">

        <div class="row g-4 align-items-start justify-content-between border-bottom border-secondary border-opacity-10 pb-4">
            <div class="col-md-6">
                <div class="d-flex align-items-center gap-2 mb-2">
                    <i class="bi bi-cpu text-primary fs-2 no-print"></i>
                    <span class="fs-4 fw-bold text-white uppercase" style="letter-spacing: -0.02em;">TechMart Online (Pvt) Ltd</span>
                </div>
                <div class="text-secondary small">Trace Id Context: Colombo Tech Hub, Sri Lanka</div>
                <div class="text-secondary small">Support Reference: support@techmart.lk</div>
            </div>

            <div class="col-md-5 text-md-end mt-3 mt-md-0">
                <div class="invoice-title mb-1">INVOICE</div>
                <div class="small"><span class="info-label">Invoice Ref:</span> <span class="info-value">#${order.orderId}</span></div>
                <div class="small"><span class="info-label">Committed Date:</span> <span class="info-value">${order.orderDate}</span></div>
            </div>
        </div>

        <div class="row g-4 mt-2">
            <div class="col-md-6">
                <h3 class="fs-6 fw-bold text-secondary uppercase mb-3" style="letter-spacing: 0.05em;">Shipping Information</h3>
                <div class="fw-semibold text-white fs-5 mb-1">${order.shippingName}</div>
                <div class="text-secondary small mb-1"><i class="bi bi-telephone me-1"></i> ${order.shippingPhone}</div>
                <div class="text-secondary small"><i class="bi bi-geo-alt me-1"></i> ${order.shippingAddress}, ${order.shippingCity}, Sri Lanka</div>
            </div>

            <div class="col-md-5 text-md-end">
                <h3 class="fs-6 fw-bold text-secondary uppercase mb-3" style="letter-spacing: 0.05em;">Payment Audit States</h3>
                <div class="mb-2">
                    <span class="info-label me-2">Order Lifecycle:</span>
                    <span class="badge bg-primary bg-opacity-25 text-primary border border-primary border-opacity-50 px-2 py-0.5 small">${order.orderStatus}</span>
                </div>
                <div>
                    <span class="info-label me-2">Gateway Settlement:</span>
                    <span class="badge bg-success bg-opacity-25 text-success border border-success border-opacity-50 px-2 py-0.5 small">${order.paymentStatus}</span>
                </div>
            </div>
        </div>

        <div class="table-responsive">
            <table class="invoice-table">
                <thead>
                <tr>
                    <th style="width: 55%">Product Specification</th>
                    <th style="width: 10%" class="text-center">Qty</th>
                    <th style="width: 15%" class="text-end">Unit Price</th>
                    <th style="width: 20%" class="text-end">Line Total</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="item" items="${order.items}">
                    <tr>
                        <td>
                            <div class="d-flex align-items-center gap-2.5">
                                <img class="thumb no-print" src="${pageContext.request.contextPath}/images/${item.imagePath}" alt="${item.productName}">
                                <span class="fw-medium text-white-toggle">${item.productName}</span>
                            </div>
                        </td>
                        <td class="text-center fw-semibold text-secondary font-monospace">${item.qty}</td>
                        <td class="text-end text-secondary font-monospace">Rs. <fmt:formatNumber value="${item.unitPrice}" maxFractionDigits="2" minFractionDigits="2"/></td>
                        <td class="text-end fw-semibold text-white font-monospace">Rs. <fmt:formatNumber value="${item.unitPrice * item.qty}" maxFractionDigits="2" minFractionDigits="2"/></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="invoice-summary">
            <div class="summary-item">
                <span>Subtotal Baseline</span>
                <span class="font-monospace text-white-toggle">Rs. <fmt:formatNumber value="${order.subtotal}" maxFractionDigits="2" minFractionDigits="2"/></span>
            </div>
            <div class="summary-item">
                <span>Logistics Shipping Fee</span>
                <span class="font-monospace text-white-toggle">Rs. <fmt:formatNumber value="${order.shippingFee}" maxFractionDigits="2" minFractionDigits="2"/></span>
            </div>
            <div class="summary-item grand-total">
                <span>Grand Total</span>
                <span class="font-monospace text-primary">Rs. <fmt:formatNumber value="${order.totalAmount}" maxFractionDigits="2" minFractionDigits="2"/></span>
            </div>
        </div>

        <div class="text-start mt-4 border-top border-secondary border-opacity-10 pt-4 no-print">
            <button class="btn-print-action text-white" onclick="window.print()">
                <i class="bi bi-printer-fill me-2"></i> Download / Print Corporate Invoice
            </button>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
