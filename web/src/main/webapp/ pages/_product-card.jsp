
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<style>
    .product-card {
        background: rgba(30, 41, 59, 0.4);
        backdrop-filter: blur(8px);
        -webkit-backdrop-filter: blur(8px);
        border: 1px solid rgba(255, 255, 255, 0.05);
        border-radius: 12px;
        padding: 1rem;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        height: 100%;
        position: relative;
        overflow: hidden;
    }

    .product-card:hover {
        transform: translateY(-6px);
        background: rgba(30, 41, 59, 0.6);
        border-color: rgba(59, 130, 246, 0.3);
        box-shadow: 0 12px 20px -5px rgba(0, 0, 0, 0.5), 0 4px 12px rgba(37, 99, 235, 0.1);
    }

    .card-link {
        text-decoration: none;
        display: block;
        margin-bottom: 1rem;
    }

    .card-image-wrapper {
        width: 100%;
        height: 160px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 0.75rem;
        background: rgba(15, 23, 42, 0.3);
        border-radius: 8px;
        overflow: hidden;
    }

    .card-image {
        max-width: 100%;
        max-height: 100%;
        object-fit: contain;
        transition: transform 0.3s ease;
    }

    .product-card:hover .card-image {
        transform: scale(1.05);
    }

    .card-brand {
        font-size: 0.75rem;
        font-weight: 600;
        text-transform: uppercase;
        color: #60a5fa;
        letter-spacing: 0.05em;
        margin-bottom: 0.25rem;
    }

    .card-name {
        font-size: 0.9rem;
        font-weight: 500;
        color: #f1f5f9;
        line-height: 1.4;
        height: 40px; /* Force 2 lines max to keep alignment straight */
        overflow: hidden;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        margin-bottom: 0.5rem;
    }

    .card-price {
        font-size: 1.05rem;
        font-weight: 700;
        color: #ffffff;
    }

    .btn-add-cart {
        background: rgba(59, 130, 246, 0.1);
        border: 1px solid rgba(59, 130, 246, 0.3);
        color: #60a5fa;
        font-size: 0.85rem;
        font-weight: 600;
        padding: 0.5rem 1rem;
        border-radius: 8px;
        width: 100%;
        transition: all 0.2s ease;
    }

    .btn-add-cart:hover {
        background: #2563eb;
        border-color: #2563eb;
        color: #ffffff;
    }

    .badge-out-stock {
        background: rgba(239, 68, 68, 0.1);
        border: 1px solid rgba(239, 68, 68, 0.3);
        color: #f87171;
        font-size: 0.8rem;
        font-weight: 600;
        padding: 0.5rem;
        border-radius: 8px;
        text-align: center;
        display: block;
        width: 100%;
    }
</style>

<div class="product-card">
    <a href="${pageContext.request.contextPath}/product?id=${p.id}" class="card-link">
        <div class="card-image-wrapper">
            <img src="${pageContext.request.contextPath}/images/${p.imagePath}" alt="${p.name}" class="card-image">
        </div>
        <div class="card-brand">${p.brandName}</div>
        <div class="card-name">${p.name}</div>
        <div class="card-price">Rs. ${String.format("%.2f", p.price)}</div>
    </a>

    <div class="card-action-layer mt-auto">
        <c:choose>
            <c:when test="${p.inStock}">
                <form method="post" action="${pageContext.request.contextPath}/cart" class="card-add-form">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="pId" value="${p.id}">
                    <input type="hidden" name="qty" value="1">
                    <input type="hidden" name="redirectTo" value="${currentPageUrl}">
                    <button type="submit" class="btn-add-cart">
                        <i class="bi bi-cart-plus me-1"></i> Add to cart
                    </button>
                </form>
            </c:when>
            <c:otherwise>
                <span class="badge-out-stock"><i class="bi bi-exclamation-circle me-1"></i> Out of stock</span>
            </c:otherwise>
        </c:choose>
    </div>
</div>
