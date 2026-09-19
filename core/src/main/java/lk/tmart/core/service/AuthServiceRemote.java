package lk.tmart.core.service;

import jakarta.ejb.Remote;
import lk.tmart.core.dto.UserDTO;

import java.util.List;

@Remote
public interface AuthServiceRemote {
    UserDTO register(UserDTO dto, String rawPassword) throws Exception;
    UserDTO login(String email, String rawPassword);
    UserDTO updateProfile(String email, String firstName, String lastName, String mobile);
    List<UserDTO> listAllUsers();
}