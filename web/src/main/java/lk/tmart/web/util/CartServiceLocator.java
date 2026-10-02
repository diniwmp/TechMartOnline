package lk.tmart.web.util;

import lk.tmart.core.service.CartServiceRemote;

import javax.naming.InitialContext;
import javax.naming.NamingException;

public class CartServiceLocator {


    private static final String JNDI =
            "java:global/ee-ear/ejb/CartBean!lk.tmart.core.service.CartServiceRemote";

    public static CartServiceRemote lookupAndInit(String userEmail) throws NamingException {
        InitialContext ctx = new InitialContext();
        CartServiceRemote cart = (CartServiceRemote) ctx.lookup(JNDI);
        cart.init(userEmail);
        return cart;
    }
}
