package lk.tmart.core.service;

import jakarta.ejb.Remote;

/**
 * Remote business interface for authentication logic.
 *
 * This interface lives in the `core` module so that both the `ejb` module
 * (which implements it) and the `web` module (which calls it) can compile
 * against it without the web tier depending on the EJB implementation jar.
 * This is the classic Java EE "business interface" separation pattern,
 * and it's exactly what your assignment's JNDI/Dependency Injection
 * critical analysis section is asking you to evaluate.
 */
@Remote
public interface AuthServiceRemote {

    /**
     * Registers a new user.
     * @return LoginResultDTO with success=true if registration succeeded,
     *         success=false with a message (e.g. "Email already registered") otherwise.
     */
    LoginResultDTO register(RegisterRequestDTO request);

    /**
     * Authenticates a user by email + raw password.
     * The bean hashes/compares internally — the raw password never touches
     * persistent storage.
     */
    LoginResultDTO login(String email, String rawPassword);
}
