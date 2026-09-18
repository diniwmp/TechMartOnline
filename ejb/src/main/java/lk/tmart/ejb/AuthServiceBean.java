package lk.tmart.ejb;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.NoResultException;
import lk.tmart.core.model.User;
import lk.tmart.core.model.UserRole;
import lk.tmart.core.service.AuthServiceRemote;
import lk.tmart.core.util.PasswordUtil;
import lk.tmart.core.util.ValidationUtil;

/**
 * Stateless Session Bean implementing authentication business logic.
 *
 * Why STATELESS (this is exactly the kind of justification your
 * "Session Bean Architecture Optimization" section is asking for):
 *  - Login and registration are single-request, no-conversation operations.
 *    There's no need to remember anything about the caller between calls.
 *  - The container pools and reuses Stateless bean instances across many
 *    clients, so this scales far better under TechMart's "10,000+ concurrent
 *    users" requirement than a Stateful bean would, which needs one
 *    dedicated instance per client session.
 *  - No passivation/activation lifecycle overhead (Stateless beans don't
 *    get passivated), so latency stays predictable -- important for the
 *    "sub-second response time" NFR.
 *
 * Contrast: a shopping CartBean (tracking items across multiple requests
 * for one shopper) is a much better fit for @Stateful, and a shared
 * application-wide counter/cache is a better fit for @Singleton.
 * That comparison is good material for your report.
 */
@Stateless
public class AuthServiceBean implements AuthServiceRemote {

    @PersistenceContext(unitName = "techmart-pu")
    private EntityManager em;

    @Override
    public LoginResultDTO register(RegisterRequestDTO request) {

        // --- basic validation first (fail fast, avoid unnecessary DB hit) ---
        if (!ValidationUtil.isValidEmail(request.getEmail())) {
            return LoginResultDTO.failure("Please enter a valid email address.");
        }
        if (!ValidationUtil.isNotBlank(request.getFirstName())
                || !ValidationUtil.isNotBlank(request.getLastName())) {
            return LoginResultDTO.failure("First name and last name are required.");
        }
        if (!ValidationUtil.isValidMobile(request.getMobile())) {
            return LoginResultDTO.failure("Please enter a valid mobile number.");
        }
        if (!ValidationUtil.isStrongEnoughPassword(request.getPassword())) {
            return LoginResultDTO.failure("Password must be at least 6 characters.");
        }

        // --- uniqueness check (email is the PK) ---
        User existing = em.find(User.class, request.getEmail().trim().toLowerCase());
        if (existing != null) {
            return LoginResultDTO.failure("An account with this email already exists.");
        }

        // --- look up the default CUSTOMER role ---
        UserRole customerRole;
        try {
            customerRole = em.createQuery(
                            "SELECT r FROM UserRole r WHERE r.value = :val", UserRole.class)
                    .setParameter("val", "CUSTOMER")
                    .getSingleResult();
        } catch (NoResultException e) {
            return LoginResultDTO.failure(
                    "Server configuration error: CUSTOMER role not found. Contact support.");
        }

        // --- hash password, persist ---
        String hashed = PasswordUtil.hash(request.getPassword());
        User newUser = new User(
                request.getEmail().trim().toLowerCase(),
                request.getFirstName().trim(),
                request.getLastName().trim(),
                request.getMobile().trim(),
                hashed,
                customerRole
        );

        em.persist(newUser);

        return LoginResultDTO.success(
                newUser.getEmail(), newUser.getFirstName(),
                newUser.getLastName(), customerRole.getValue());
    }

    @Override
    public LoginResultDTO login(String email, String rawPassword) {

        if (!ValidationUtil.isNotBlank(email) || !ValidationUtil.isNotBlank(rawPassword)) {
            return LoginResultDTO.failure("Email and password are required.");
        }

        User user = em.find(User.class, email.trim().toLowerCase());

        if (user == null) {
            // Same generic message as "wrong password" below --
            // never reveal whether the email exists (basic security practice).
            return LoginResultDTO.failure("Invalid email or password.");
        }

        boolean matches = PasswordUtil.verify(rawPassword, user.getPassword());
        if (!matches) {
            return LoginResultDTO.failure("Invalid email or password.");
        }

        return LoginResultDTO.success(
                user.getEmail(), user.getFirstName(),
                user.getLastName(), user.getUserRole().getValue());
    }
}
