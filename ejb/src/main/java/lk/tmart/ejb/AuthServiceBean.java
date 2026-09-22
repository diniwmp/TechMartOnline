package lk.tmart.ejb;

import jakarta.ejb.Stateless;
import jakarta.interceptor.Interceptors;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lk.tmart.core.dto.UserDTO;
import lk.tmart.core.model.User;
import lk.tmart.core.model.UserRole;
import lk.tmart.core.service.AuthServiceRemote;
import lk.tmart.ejb.interceptor.PerformanceLoggingInterceptor;

import java.util.ArrayList;
import java.util.List;

@Stateless
@Interceptors(PerformanceLoggingInterceptor.class)
public class AuthServiceBean implements AuthServiceRemote {

    private static final int DEFAULT_ROLE_ID = 2;

    @PersistenceContext(unitName = "techmart-pu")
    private EntityManager em;

    @Override
    public UserDTO register(UserDTO dto, String rawPassword) throws Exception {
        User existing = em.find(User.class, dto.getEmail());
        if (existing != null) {
            throw new IllegalArgumentException("This email is already registered.");
        }

        UserRole role = em.find(UserRole.class, DEFAULT_ROLE_ID);

        User u = new User();
        u.setEmail(dto.getEmail());
        u.setFirstName(dto.getFirstName());
        u.setLastName(dto.getLastName());
        u.setMobile(dto.getMobile());
        u.setPassword(rawPassword);
        u.setUserRole(role);

        em.persist(u);
        return toDTO(u);
    }

    @Override
    public UserDTO login(String email, String rawPassword) {
        User u = em.find(User.class, email);
        if (u == null) return null;
        if (rawPassword == null || !rawPassword.equals(u.getPassword())) return null;
        return toDTO(u);
    }

    @Override
    public UserDTO updateProfile(String email, String firstName, String lastName, String mobile) {
        User u = em.find(User.class, email);
        if (u == null) return null;

        u.setFirstName(firstName);
        u.setLastName(lastName);
        u.setMobile(mobile);
        em.merge(u);

        return toDTO(u);
    }

    @Override
    public List<UserDTO> listAllUsers() {
        List<User> users = em.createQuery("SELECT u FROM User u ORDER BY u.email", User.class).getResultList();
        List<UserDTO> result = new ArrayList<>();
        for (User u : users) {
            result.add(toDTO(u));
        }
        return result;
    }

    private UserDTO toDTO(User u) {
        return new UserDTO(
                u.getEmail(),
                u.getFirstName(),
                u.getLastName(),
                u.getMobile(),
                u.getUserRole() != null ? u.getUserRole().getValue() : null
        );
    }
}