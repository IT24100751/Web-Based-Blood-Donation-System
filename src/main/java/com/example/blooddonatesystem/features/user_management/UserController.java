package com.example.blooddonatesystem.features.user_management;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/users")
public class UserController {

    private final UserService userService;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    /**
     * Get all users
     * @return List of users
     */
    @GetMapping
    public ResponseEntity<?> getAllUsers() {
        try {
            List<UserDTOS.GetUserDTO> users = userService.getAllUsers();
            return ResponseEntity.ok(users);
        } catch (Exception e) {
            return ResponseEntity
                .status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body("Error retrieving users: " + e.getMessage());
        }
    }

    /**
     * Get user by ID
     * @param id User ID
     * @return User if found
     */
    @GetMapping("/{id}")
    public ResponseEntity<?> getUserById(@PathVariable Long id) {
        try {
            UserDTOS.GetUserDTO user = userService.getUserById(id);
            if (user != null) {
                return ResponseEntity.ok(user);
            }
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                .body("User not found with ID: " + id);
        } catch (Exception e) {
            return ResponseEntity
                .status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body("Error retrieving user: " + e.getMessage());
        }
    }

    /**
     * Create a new user
     * @param createUserDTO User data
     * @return Created user
     */
    @PostMapping
    public ResponseEntity<?> createUser(@RequestBody UserDTOS.CreateUserDTO createUserDTO) {
        try {
            UserDTOS.GetUserDTO createdUser = userService.createUser(createUserDTO);
            return new ResponseEntity<>(createdUser, HttpStatus.CREATED);
        } catch (RuntimeException e) {
            if (e.getMessage().contains("Email already exists")) {
                return ResponseEntity
                    .status(HttpStatus.CONFLICT)
                    .body("Email already exists");
            }
            return ResponseEntity
                .status(HttpStatus.BAD_REQUEST)
                .body("Error creating user: " + e.getMessage());
        } catch (Exception e) {
            return ResponseEntity
                .status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body("Error creating user: " + e.getMessage());
        }
    }

    /**
     * Update user
     * @param id User ID
     * @param updateUserDTO User data
     * @return Updated user
     */
    @PutMapping("/{id}")
    public ResponseEntity<?> updateUser(@PathVariable Long id, 
                                       @RequestBody UserDTOS.UpdateUserDTO updateUserDTO) {
        try {
            updateUserDTO.setId(id);
            UserDTOS.GetUserDTO updatedUser = userService.updateUser(updateUserDTO);
            return ResponseEntity.ok(updatedUser);
        } catch (RuntimeException e) {
            if (e.getMessage().contains("User not found")) {
                return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .body("User not found with ID: " + id);
            }
            return ResponseEntity
                .status(HttpStatus.BAD_REQUEST)
                .body("Error updating user: " + e.getMessage());
        } catch (Exception e) {
            return ResponseEntity
                .status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body("Error updating user: " + e.getMessage());
        }
    }

    /**
     * Reset user password
     * @param id User ID
     * @param passwordResetRequest Password reset data
     * @return Success/failure status
     */
    @PostMapping("/{id}/reset-password")
    public ResponseEntity<?> resetPassword(@PathVariable Long id, 
                                          @RequestBody PasswordResetRequest passwordResetRequest) {
        try {
            boolean success = userService.resetPassword(id, passwordResetRequest.getNewPassword());
            if (success) {
                return ResponseEntity.ok().body("Password reset successful");
            }
            return ResponseEntity
                .status(HttpStatus.NOT_FOUND)
                .body("User not found with ID: " + id);
        } catch (Exception e) {
            return ResponseEntity
                .status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body("Error resetting password: " + e.getMessage());
        }
    }

    /**
     * Delete user
     * @param id User ID
     * @return Success/failure status
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteUser(@PathVariable Long id) {
        try {
            boolean success = userService.deleteUser(id);
            if (success) {
                return ResponseEntity.ok().body("User deleted successfully");
            }
            return ResponseEntity
                .status(HttpStatus.NOT_FOUND)
                .body("User not found with ID: " + id);
        } catch (Exception e) {
            return ResponseEntity
                .status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body("Error deleting user: " + e.getMessage());
        }
    }

    /**
     * User login
     * @param loginUserDTO Login credentials
     * @return User if authentication successful
     */
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody UserDTOS.LoginUserDTO loginUserDTO) {
        try {
            UserDTOS.GetUserDTO user = userService.login(loginUserDTO);
            if (user != null) {
                return ResponseEntity.ok(user);
            }
            return ResponseEntity
                .status(HttpStatus.UNAUTHORIZED)
                .body("Invalid email or password");
        } catch (Exception e) {
            return ResponseEntity
                .status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body("Error during login: " + e.getMessage());
        }
    }

    /**
     * Password reset request class
     */
    public static class PasswordResetRequest {
        private String newPassword;

        public String getNewPassword() {
            return newPassword;
        }

        public void setNewPassword(String newPassword) {
            this.newPassword = newPassword;
        }
    }
}
