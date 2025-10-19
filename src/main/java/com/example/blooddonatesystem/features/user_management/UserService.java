package com.example.blooddonatesystem.features.user_management;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class UserService {

    private final UserRepository userRepository;

    @Autowired
    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    /**
     * Get all active users
     * @return List of GetUserDTO
     */
    public List<UserDTOS.GetUserDTO> getAllUsers() {
        return userRepository.findByDeleteStatusFalse()
                .stream()
                .map(UserDTOS.GetUserDTO::new)
                .collect(Collectors.toList());
    }

    /**
     * Get user by ID
     * @param id User ID
     * @return GetUserDTO if found, otherwise null
     */
    public UserDTOS.GetUserDTO getUserById(Long id) {
        return userRepository.findById(id)
                .filter(user -> !user.getDeleteStatus())
                .map(UserDTOS.GetUserDTO::new)
                .orElse(null);
    }

    /**
     * Create a new user
     * @param createUserDTO User data for creation
     * @return GetUserDTO of created user
     */
    public UserDTOS.GetUserDTO createUser(UserDTOS.CreateUserDTO createUserDTO) {
        // Check if email already exists
        if (userRepository.findByEmail(createUserDTO.getEmail()).isPresent()) {
            throw new RuntimeException("Email already exists");
        }

        // Hash the password
        UserModel userModel = createUserDTO.toUserModel();
        userModel.setPassword(BCrypt.hashpw(userModel.getPassword(), BCrypt.gensalt()));
        
        // Save the user
        UserModel savedUser = userRepository.save(userModel);
        return new UserDTOS.GetUserDTO(savedUser);
    }

    /**
     * Update user information (excluding password)
     * @param updateUserDTO User data for update
     * @return GetUserDTO of updated user
     */
    public UserDTOS.GetUserDTO updateUser(UserDTOS.UpdateUserDTO updateUserDTO) {
        // Find the user
        UserModel userModel = userRepository.findById(updateUserDTO.getId())
                .filter(user -> !user.getDeleteStatus())
                .orElseThrow(() -> new RuntimeException("User not found"));

        // Update user fields (password is not included in UpdateUserDTO)
        updateUserDTO.updateUserModel(userModel);
        
        // Save the updated user
        UserModel updatedUser = userRepository.save(userModel);
        return new UserDTOS.GetUserDTO(updatedUser);
    }

    /**
     * Reset user password
     * @param userId User ID
     * @param newPassword New password
     * @return true if password reset successful, false otherwise
     */
    public boolean resetPassword(Long userId, String newPassword) {
        // Find the user
        Optional<UserModel> userOptional = userRepository.findById(userId)
                .filter(user -> !user.getDeleteStatus());
        
        if (userOptional.isPresent()) {
            UserModel user = userOptional.get();
            // Hash the new password
            user.setPassword(BCrypt.hashpw(newPassword, BCrypt.gensalt()));
            userRepository.save(user);
            return true;
        }
        return false;
    }

    /**
     * Delete user (soft delete)
     * @param userId User ID
     * @return true if deletion successful, false otherwise
     */
    public boolean deleteUser(Long userId) {
        Optional<UserModel> userOptional = userRepository.findById(userId)
                .filter(user -> !user.getDeleteStatus());
        
        if (userOptional.isPresent()) {
            UserModel user = userOptional.get();
            user.setDeleteStatus(true);
            userRepository.save(user);
            return true;
        }
        return false;
    }

    /**
     * Authenticate user
     * @param loginUserDTO Login credentials
     * @return GetUserDTO if authentication successful, null otherwise
     */
    public UserDTOS.GetUserDTO login(UserDTOS.LoginUserDTO loginUserDTO) {
        return userRepository.findByEmailAndDeleteStatusFalse(loginUserDTO.getEmail())
                .filter(user -> BCrypt.checkpw(loginUserDTO.getPassword(), user.getPassword()))
                .map(UserDTOS.GetUserDTO::new)
                .orElse(null);
    }
}
