package lk.tmart.core.service;

import jakarta.ejb.Remote;
import lk.tmart.core.dto.UserDTO;

import java.util.List;

@Remote
public interface UserService {
    UserDTO getUserById(Long id);
    void addUser(UserDTO userDTO);
    void updateUser(UserDTO userDTO);
    void deleteUser(Long id);
    List<UserDTO> getUsers();
}
