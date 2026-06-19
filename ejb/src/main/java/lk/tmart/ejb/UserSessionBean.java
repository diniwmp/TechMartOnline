package lk.tmart.ejb;

import jakarta.ejb.Stateless;
import lk.tmart.core.dto.UserDTO;
import lk.tmart.core.service.UserService;

import java.util.List;

@Stateless
public class UserSessionBean implements UserService {
    @Override
    public UserDTO getUserById(Long id) {
        System.out.println("getUserById");

        return null;
    }

    @Override
    public void addUser(UserDTO userDTO) {
        System.out.println("addUser");

    }

    @Override
    public void updateUser(UserDTO userDTO) {
        System.out.println("updateUser");

    }

    @Override
    public void deleteUser(Long id) {
        System.out.println("deleteUser");

    }

    @Override
    public List<UserDTO> getUsers() {
        return List.of();
    }
}
