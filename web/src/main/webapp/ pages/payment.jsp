<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment - TechMart Online</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script src="https://www.payhere.lk/lib/payhere.js"></script>
</head>
<body>
<nav class="navbar"><div class="logo">TechMart Online</div></nav>

<div class="page-section">
    <h2>Order #${order.orderId}</h2>
    <p>Total amount: Rs. ${amount}</p>
    <button id="payNowBtn" class="btn-checkout">Pay with PayHere</button>
</div>

<%

    String scheme = request.getScheme();
    String host = request.getServerName();
    int port = request.getServerPort();
    String contextPath = request.getContextPath();

    StringBuilder baseUrl = new StringBuilder();
    baseUrl.append(scheme).append("://").append(host);

    boolean isStandardPort = (scheme.equals("http") && port == 80)
            || (scheme.equals("https") && port == 443);
    if (!isStandardPort) {
        baseUrl.append(":").append(port);
    }
    baseUrl.append(contextPath);

    String notifyUrl = baseUrl + "/payhere/notify";
%>

<script>
    var payment = {
        "sandbox": true,
        "merchant_id": "${merchantId}",
        "return_url": "${pageContext.request.contextPath}/payhere/return?orderId=${order.orderId}",
        "cancel_url": "${pageContext.request.contextPath}/cart",
        "notify_url": "<%= notifyUrl %>",
        "order_id": "${order.orderId}",
        "items": "TechMart Online Order #${order.orderId}",
        "amount": "${amount}",
        "currency": "LKR",
        "hash": "${hash}",
        "first_name": "${order.shippingName}",
        "last_name": "",
        "email": "${userEmail}",
        "phone": "${order.shippingPhone}",
        "address": "${order.shippingAddress}",
        "city": "${order.shippingCity}",
        "country": "Sri Lanka"
    };

    payhere.onCompleted = function (orderId) {
        window.location.href = "${pageContext.request.contextPath}/payhere/return?orderId=" + orderId;
    };
    payhere.onDismissed = function () {
        alert("Payment was not completed.");
    };
    payhere.onError = function (error) {
        alert("Payment error: " + error);
    };

    document.getElementById('payNowBtn').addEventListener('click', function () {
        payhere.startPayment(payment);
    });
</script>
</body>
</html>
