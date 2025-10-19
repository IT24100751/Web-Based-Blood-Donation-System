package com.example.blooddonatesystem.features.admin_management;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class AdminService {
    
    private static final Logger logger = LoggerFactory.getLogger(AdminService.class);
    
    private final AdminRepository adminRepository;
    
    @Autowired
    public AdminService(AdminRepository adminRepository) {
        this.adminRepository = adminRepository;
    }
    
    // Generate unique admin ID (ADMIN001, ADMIN002, etc.)
    private String generateAdminId() {
        try {
            long count = adminRepository.count() + 1;
            return String.format("ADMIN%03d", count);
        } catch (Exception e) {
            logger.error("Error generating admin ID", e);
            throw new RuntimeException("Failed to generate admin ID", e);
        }
    }
    
    // Get all admins
    public List<AdminDTOS.GetAdminDTO> getAllAdmins() {
        try {
            logger.info("Fetching all admins");
            return adminRepository.findAll().stream()
                    .map(AdminDTOS.GetAdminDTO::fromModel)
                    .collect(Collectors.toList());
        } catch (Exception e) {
            logger.error("Error fetching all admins", e);
            throw new RuntimeException("Failed to retrieve admins", e);
        }
    }
    
    // Get admin by ID
    public AdminDTOS.GetAdminDTO getAdminById(Long id) {
        try {
            logger.info("Fetching admin with ID: {}", id);
            AdminModel admin = adminRepository.findById(id)
                    .orElseThrow(() -> new RuntimeException("Admin not found with ID: " + id));
            return AdminDTOS.GetAdminDTO.fromModel(admin);
        } catch (Exception e) {
            logger.error("Error fetching admin with ID: {}", id, e);
            throw new RuntimeException("Failed to retrieve admin with ID: " + id, e);
        }
    }
    
    // Create new admin
    public AdminDTOS.GetAdminDTO createAdmin(AdminDTOS.CreateAdminDTO createDTO) {
        try {
            logger.info("Creating new admin with email: {}", createDTO.getEmail());
            
            // Check if email already exists
            if (adminRepository.existsByEmail(createDTO.getEmail())) {
                throw new RuntimeException("Email already exists: " + createDTO.getEmail());
            }
            
            // Generate admin ID
            String adminId = generateAdminId();
            
            // Create new admin
            AdminModel newAdmin = new AdminModel(
                    adminId,
                    createDTO.getFirstName(),
                    createDTO.getLastName(),
                    createDTO.getEmail(),
                    createDTO.getPassword() // No encryption as requested
            );
            
            AdminModel savedAdmin = adminRepository.save(newAdmin);
            return AdminDTOS.GetAdminDTO.fromModel(savedAdmin);
        } catch (Exception e) {
            logger.error("Error creating admin", e);
            throw new RuntimeException("Failed to create admin: " + e.getMessage(), e);
        }
    }
    
    // Update admin
    public AdminDTOS.GetAdminDTO updateAdmin(Long id, AdminDTOS.UpdateAdminDTO updateDTO) {
        try {
            logger.info("Updating admin with ID: {}", id);
            AdminModel admin = adminRepository.findById(id)
                    .orElseThrow(() -> new RuntimeException("Admin not found with ID: " + id));
            
            // Check if email is being changed and already exists
            if (updateDTO.getEmail() != null && !updateDTO.getEmail().equals(admin.getEmail()) && 
                adminRepository.existsByEmail(updateDTO.getEmail())) {
                throw new RuntimeException("Email already exists: " + updateDTO.getEmail());
            }
            
            updateDTO.applyToModel(admin);
            AdminModel updatedAdmin = adminRepository.save(admin);
            return AdminDTOS.GetAdminDTO.fromModel(updatedAdmin);
        } catch (Exception e) {
            logger.error("Error updating admin with ID: {}", id, e);
            throw new RuntimeException("Failed to update admin with ID: " + id + ": " + e.getMessage(), e);
        }
    }
    
    // Reset password
    public void resetPassword(Long id, String newPassword) {
        try {
            logger.info("Resetting password for admin with ID: {}", id);
            AdminModel admin = adminRepository.findById(id)
                    .orElseThrow(() -> new RuntimeException("Admin not found with ID: " + id));
            
            admin.setPassword(newPassword); // No encryption as requested
            adminRepository.save(admin);
        } catch (Exception e) {
            logger.error("Error resetting password for admin with ID: {}", id, e);
            throw new RuntimeException("Failed to reset password for admin with ID: " + id, e);
        }
    }
    
    // Delete admin
    public void deleteAdmin(Long id) {
        try {
            logger.info("Deleting admin with ID: {}", id);
            if (!adminRepository.existsById(id)) {
                throw new RuntimeException("Admin not found with ID: " + id);
            }
            adminRepository.deleteById(id);
        } catch (Exception e) {
            logger.error("Error deleting admin with ID: {}", id, e);
            throw new RuntimeException("Failed to delete admin with ID: " + id, e);
        }
    }
    
    // Login admin
    public AdminDTOS.GetAdminDTO login(AdminDTOS.LoginAdminDTO loginDTO) {
        try {
            logger.info("Attempting login for admin with email: {}", loginDTO.getEmail());
            AdminModel admin = adminRepository.findByEmail(loginDTO.getEmail())
                    .orElseThrow(() -> new RuntimeException("Invalid email or password"));
            
            // Direct password comparison (no encryption as requested)
            if (!loginDTO.getPassword().equals(admin.getPassword())) {
                throw new RuntimeException("Invalid email or password");
            }
            
            return AdminDTOS.GetAdminDTO.fromModel(admin);
        } catch (Exception e) {
            logger.error("Login failed for email: {}", loginDTO.getEmail(), e);
            throw new RuntimeException("Login failed: " + e.getMessage(), e);
        }
    }
}