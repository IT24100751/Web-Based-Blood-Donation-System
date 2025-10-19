package com.example.blooddonatesystem.features.admin_management;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/admins")
public class AdminController {

    private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
    
    private final AdminService adminService;
    
    @Autowired
    public AdminController(AdminService adminService) {
        this.adminService = adminService;
    }
    
    // Get all admins
    @GetMapping
    public ResponseEntity<?> getAllAdmins() {
        try {
            List<AdminDTOS.GetAdminDTO> admins = adminService.getAllAdmins();
            return ResponseEntity.ok(admins);
        } catch (Exception e) {
            logger.error("Error retrieving all admins", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Failed to retrieve admins: " + e.getMessage());
        }
    }
    
    // Get admin by ID
    @GetMapping("/{id}")
    public ResponseEntity<?> getAdminById(@PathVariable Long id) {
        try {
            AdminDTOS.GetAdminDTO admin = adminService.getAdminById(id);
            return ResponseEntity.ok(admin);
        } catch (RuntimeException e) {
            if (e.getMessage().contains("not found")) {
                logger.error("Admin not found with ID: {}", id);
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body("Admin not found with ID: " + id);
            }
            logger.error("Error retrieving admin with ID: {}", id, e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Failed to retrieve admin: " + e.getMessage());
        }
    }
    
    // Create new admin
    @PostMapping
    public ResponseEntity<?> createAdmin(@RequestBody AdminDTOS.CreateAdminDTO createDTO) {
        try {
            AdminDTOS.GetAdminDTO createdAdmin = adminService.createAdmin(createDTO);
            return ResponseEntity.status(HttpStatus.CREATED).body(createdAdmin);
        } catch (RuntimeException e) {
            if (e.getMessage().contains("already exists")) {
                logger.error("Email already exists: {}", createDTO.getEmail());
                return ResponseEntity.status(HttpStatus.CONFLICT)
                        .body(e.getMessage());
            }
            logger.error("Error creating admin", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Failed to create admin: " + e.getMessage());
        }
    }
    
    // Update admin
    @PutMapping("/{id}")
    public ResponseEntity<?> updateAdmin(@PathVariable Long id, @RequestBody AdminDTOS.UpdateAdminDTO updateDTO) {
        try {
            AdminDTOS.GetAdminDTO updatedAdmin = adminService.updateAdmin(id, updateDTO);
            return ResponseEntity.ok(updatedAdmin);
        } catch (RuntimeException e) {
            if (e.getMessage().contains("not found")) {
                logger.error("Admin not found with ID: {}", id);
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body("Admin not found with ID: " + id);
            }
            if (e.getMessage().contains("already exists")) {
                logger.error("Email already exists: {}", updateDTO.getEmail());
                return ResponseEntity.status(HttpStatus.CONFLICT)
                        .body(e.getMessage());
            }
            logger.error("Error updating admin with ID: {}", id, e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Failed to update admin: " + e.getMessage());
        }
    }
    
    // Reset password
    @PostMapping("/{id}/reset-password")
    public ResponseEntity<?> resetPassword(@PathVariable Long id, @RequestBody PasswordResetRequest request) {
        try {
            adminService.resetPassword(id, request.getNewPassword());
            return ResponseEntity.ok("Password reset successfully");
        } catch (RuntimeException e) {
            if (e.getMessage().contains("not found")) {
                logger.error("Admin not found with ID: {}", id);
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body("Admin not found with ID: " + id);
            }
            logger.error("Error resetting password for admin with ID: {}", id, e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Failed to reset password: " + e.getMessage());
        }
    }
    
    // Delete admin
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteAdmin(@PathVariable Long id) {
        try {
            adminService.deleteAdmin(id);
            return ResponseEntity.ok("Admin deleted successfully");
        } catch (RuntimeException e) {
            if (e.getMessage().contains("not found")) {
                logger.error("Admin not found with ID: {}", id);
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body("Admin not found with ID: " + id);
            }
            logger.error("Error deleting admin with ID: {}", id, e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Failed to delete admin: " + e.getMessage());
        }
    }
    
    // Login admin
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody AdminDTOS.LoginAdminDTO loginDTO) {
        try {
            AdminDTOS.GetAdminDTO admin = adminService.login(loginDTO);
            return ResponseEntity.ok(admin);
        } catch (RuntimeException e) {
            if (e.getMessage().contains("Invalid email or password")) {
                logger.error("Login failed for email: {}", loginDTO.getEmail());
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                        .body("Invalid email or password");
            }
            logger.error("Error during login", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Login failed: " + e.getMessage());
        }
    }
    
    // Inner class for password reset request
    public static class PasswordResetRequest {
        private String newPassword;
        
        public PasswordResetRequest() {
        }
        
        public PasswordResetRequest(String newPassword) {
            this.newPassword = newPassword;
        }
        
        public String getNewPassword() {
            return newPassword;
        }
        
        public void setNewPassword(String newPassword) {
            this.newPassword = newPassword;
        }
    }
}