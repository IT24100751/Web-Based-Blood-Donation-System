package com.example.blooddonatesystem.features.donor_management;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/donors")
public class DonorController {
    private static final Logger logger = LoggerFactory.getLogger(DonorController.class);
    
    private final DonorService donorService;
    
    @Autowired
    public DonorController(DonorService donorService) {
        this.donorService = donorService;
    }
    
    // Get all donors
    @GetMapping
    public ResponseEntity<?> getAllDonors() {
        try {
            List<DonorDTOS.GetDonorDTO> donors = donorService.getAllDonors();
            return ResponseEntity.ok(donors);
        } catch (Exception e) {
            logger.error("Error retrieving all donors", e);
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("error", "Failed to retrieve donors");
            errorResponse.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }
    
    // Get donor by ID
    @GetMapping("/{id}")
    public ResponseEntity<?> getDonorById(@PathVariable Long id) {
        try {
            DonorDTOS.GetDonorDTO donor = donorService.getDonorById(id);
            return ResponseEntity.ok(donor);
        } catch (Exception e) {
            logger.error("Error retrieving donor with id: {}", id, e);
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("error", "Failed to retrieve donor");
            errorResponse.put("message", e.getMessage());
            
            HttpStatus status = e.getMessage().contains("not found") ? 
                    HttpStatus.NOT_FOUND : HttpStatus.INTERNAL_SERVER_ERROR;
            
            return ResponseEntity.status(status).body(errorResponse);
        }
    }
    
    // Create new donor
    @PostMapping
    public ResponseEntity<?> createDonor(@RequestBody DonorDTOS.CreateDonorDTO createDonorDTO) {
        try {
            DonorDTOS.GetDonorDTO createdDonor = donorService.createDonor(createDonorDTO);
            return ResponseEntity.status(HttpStatus.CREATED).body(createdDonor);
        } catch (Exception e) {
            logger.error("Error creating donor", e);
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("error", "Failed to create donor");
            errorResponse.put("message", e.getMessage());
            
            HttpStatus status = e.getMessage().contains("already in use") ? 
                    HttpStatus.CONFLICT : HttpStatus.INTERNAL_SERVER_ERROR;
            
            return ResponseEntity.status(status).body(errorResponse);
        }
    }
    
    // Update donor
    @PutMapping("/{id}")
    public ResponseEntity<?> updateDonor(@PathVariable Long id, @RequestBody DonorDTOS.UpdateDonorDTO updateDonorDTO) {
        try {
            DonorDTOS.GetDonorDTO updatedDonor = donorService.updateDonor(id, updateDonorDTO);
            return ResponseEntity.ok(updatedDonor);
        } catch (Exception e) {
            logger.error("Error updating donor with id: {}", id, e);
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("error", "Failed to update donor");
            errorResponse.put("message", e.getMessage());
            
            HttpStatus status;
            if (e.getMessage().contains("not found")) {
                status = HttpStatus.NOT_FOUND;
            } else if (e.getMessage().contains("already in use")) {
                status = HttpStatus.CONFLICT;
            } else {
                status = HttpStatus.INTERNAL_SERVER_ERROR;
            }
            
            return ResponseEntity.status(status).body(errorResponse);
        }
    }
    
    // Reset password
    @PostMapping("/{id}/reset-password")
    public ResponseEntity<?> resetPassword(@PathVariable Long id, @RequestBody PasswordResetRequest request) {
        try {
            donorService.resetPassword(id, request.getNewPassword());
            Map<String, String> response = new HashMap<>();
            response.put("message", "Password reset successfully");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            logger.error("Error resetting password for donor with id: {}", id, e);
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("error", "Failed to reset password");
            errorResponse.put("message", e.getMessage());
            
            HttpStatus status = e.getMessage().contains("not found") ? 
                    HttpStatus.NOT_FOUND : HttpStatus.INTERNAL_SERVER_ERROR;
            
            return ResponseEntity.status(status).body(errorResponse);
        }
    }
    
    // Delete donor
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteDonor(@PathVariable Long id) {
        try {
            donorService.deleteDonor(id);
            Map<String, String> response = new HashMap<>();
            response.put("message", "Donor deleted successfully");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            logger.error("Error deleting donor with id: {}", id, e);
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("error", "Failed to delete donor");
            errorResponse.put("message", e.getMessage());
            
            HttpStatus status = e.getMessage().contains("not found") ? 
                    HttpStatus.NOT_FOUND : HttpStatus.INTERNAL_SERVER_ERROR;
            
            return ResponseEntity.status(status).body(errorResponse);
        }
    }
    
    // Login donor
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody DonorDTOS.LoginDonorDTO loginDonorDTO) {
        try {
            DonorDTOS.GetDonorDTO donor = donorService.login(loginDonorDTO);
            return ResponseEntity.ok(donor);
        } catch (Exception e) {
            logger.error("Error during donor login", e);
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("error", "Login failed");
            errorResponse.put("message", e.getMessage());
            
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(errorResponse);
        }
    }
    
    // Get donors by blood type
    @GetMapping("/blood-type/{bloodType}")
    public ResponseEntity<?> getDonorsByBloodType(@PathVariable String bloodType) {
        try {
            List<DonorDTOS.GetDonorDTO> donors = donorService.getDonorsByBloodType(bloodType);
            return ResponseEntity.ok(donors);
        } catch (Exception e) {
            logger.error("Error retrieving donors by blood type: {}", bloodType, e);
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("error", "Failed to retrieve donors by blood type");
            errorResponse.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }
    
    // Inner class for password reset request
    public static class PasswordResetRequest {
        private String newPassword;
        
        public PasswordResetRequest() {
        }
        
        public String getNewPassword() {
            return newPassword;
        }
        
        public void setNewPassword(String newPassword) {
            this.newPassword = newPassword;
        }
    }
}