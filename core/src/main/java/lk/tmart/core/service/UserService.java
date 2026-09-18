package lk.tmart.core.service;

import jakarta.ejb.Remote;

import java.util.List;

@Remote
public interface UserService {
    UserDTO getUserById(Long id);
    void addUser(UserDTO userDTO);
    void updateUser(UserDTO userDTO);
    void deleteUser(Long id);
    List<UserDTO> getUsers();
}
