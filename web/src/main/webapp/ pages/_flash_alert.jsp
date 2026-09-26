<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<c:if test="${not empty sessionScope.flashSuccess}">
    <div class="tm-flash tm-flash-success" id="tmFlashBanner">
        ✓ ${sessionScope.flashSuccess}
    </div>
    <c:remove var="flashSuccess" scope="session"/>
</c:if>

<c:if test="${not empty sessionScope.flashError}">
    <div class="tm-flash tm-flash-error" id="tmFlashBanner">
        ⚠ ${sessionScope.flashError}
    </div>
    <c:remove var="flashError" scope="session"/>
</c:if>

<script>
    (function () {
        var banner = document.getElementById('tmFlashBanner');
        if (banner) {
            setTimeout(function () {
                banner.classList.add('tm-flash-hide');
                setTimeout(function () { banner.remove(); }, 400);
            }, 3500);
        }
    })();
</script>
