package lk.tmart.ejb;

import jakarta.persistence.EntityManager;
import lk.tmart.core.dto.UserDTO;
import lk.tmart.core.model.User;
import lk.tmart.core.model.UserRole;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

class AuthServiceBeanTest {

    private EntityManager em;
    private AuthServiceBean authServiceBean;

    @BeforeEach
    void setUp() throws Exception {
        em = mock(EntityManager.class);
        authServiceBean = new AuthServiceBean();


        var field = AuthServiceBean.class.getDeclaredField("em");
        field.setAccessible(true);
        field.set(authServiceBean, em);
    }

    @Test
    void login_returnsUserDTO_whenCredentialsMatch() {
        User user = new User();
        user.setEmail("test@example.com");
        user.setPassword("password123");
        user.setFirstName("Test");
        user.setLastName("User");

        UserRole role = new UserRole();
        role.setValue("CUSTOMER");
        user.setUserRole(role);

        when(em.find(User.class, "test@example.com")).thenReturn(user);

        UserDTO result = authServiceBean.login("test@example.com", "password123");

        assertNotNull(result);
        assertEquals("test@example.com", result.getEmail());
        assertEquals("CUSTOMER", result.getRoleName());
    }

    @Test
    void login_returnsNull_whenPasswordIncorrect() {
        User user = new User();
        user.setEmail("test@example.com");
        user.setPassword("correctPassword");
        when(em.find(User.class, "test@example.com")).thenReturn(user);

        assertNull(authServiceBean.login("test@example.com", "wrongPassword"));
    }

    @Test
    void login_returnsNull_whenUserNotFound() {
        when(em.find(User.class, "missing@example.com")).thenReturn(null);
        assertNull(authServiceBean.login("missing@example.com", "anyPassword"));
    }

    @Test
    void register_succeedsAndReturnsUserDTO_whenCredentialsValid() throws Exception {
        when(em.find(User.class, "newuser@example.com")).thenReturn(null);

        UserRole role = new UserRole();
        role.setValue("CUSTOMER");
        when(em.find(UserRole.class, 2)).thenReturn(role);

        UserDTO dto = new UserDTO();
        dto.setEmail("newuser@example.com");
        dto.setFirstName("Nimal");
        dto.setLastName("Perera");
        dto.setMobile("0771234567");

        UserDTO result = authServiceBean.register(dto, "securePass123");

        assertNotNull(result);
        assertEquals("newuser@example.com", result.getEmail());
        assertEquals("Nimal", result.getFirstName());
        assertEquals("CUSTOMER", result.getRoleName());
        verify(em).persist(any(User.class));
    }

    @Test
    void register_throwsException_whenEmailAlreadyExists() {
        User existing = new User();
        existing.setEmail("test@example.com");
        when(em.find(User.class, "test@example.com")).thenReturn(existing);

        UserDTO dto = new UserDTO();
        dto.setEmail("test@example.com");

        Exception exception = assertThrows(Exception.class, () ->
                authServiceBean.register(dto, "somePassword"));

        assertTrue(exception.getMessage().contains("already registered"));
    }
}