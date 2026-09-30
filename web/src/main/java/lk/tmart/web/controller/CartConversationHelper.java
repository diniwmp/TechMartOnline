package lk.tmart.web.controller;

import jakarta.servlet.http.HttpSession;
import lk.tmart.core.service.CartServiceRemote;

import javax.naming.InitialContext;
import javax.naming.NamingException;


final class CartConversationHelper {

    private static final String SESSION_KEY = "cartConversation";
    private static final String JNDI_NAME =
            "java:global/ee-ear/ejb/CartBean!lk.tmart.core.service.CartServiceRemote";

    private CartConversationHelper() {
    }

    static CartServiceRemote getCartFor(HttpSession session, String userEmail) throws NamingException {
        CartServiceRemote existing = (CartServiceRemote) session.getAttribute(SESSION_KEY);
        if (existing != null) {
            return existing;
        }

        InitialContext ctx = new InitialContext();
        CartServiceRemote cartService = (CartServiceRemote) ctx.lookup(JNDI_NAME);
        cartService.init(userEmail);

        session.setAttribute(SESSION_KEY, cartService);
        return cartService;
    }


    static void closeCartFor(HttpSession session) {
        CartServiceRemote existing = (CartServiceRemote) session.getAttribute(SESSION_KEY);
        if (existing != null) {
            try {
                existing.closeCart();
            } catch (Exception ignored) {
            }
            session.removeAttribute(SESSION_KEY);
        }
    }
}
