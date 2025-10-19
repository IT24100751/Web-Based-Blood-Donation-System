package com.example.blooddonatesystem.features.donor_management;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class DonorService {
    private static final Logger logger = LoggerFactory.getLogger(DonorService.class);
    
    private final DonorRepository donorRepository;
    
    @Autowired
    public DonorService(DonorRepository donorRepository) {
        this.donorRepository = donorRepository;
    }
    
    // Get all donors (non-deleted)
    public List<DonorDTOS.GetDonorDTO> getAllDonors() {
        try {
            List<DonorModel> donors = donorRepository.findAllNonDeleted();
            return donors.stream()
                    .map(DonorDTOS.GetDonorDTO::fromEntity)
                    .collect(Collectors.toList());
        } catch (Exception e) {
            logger.error("Error retrieving all donors", e);
            throw new RuntimeException("Failed to retrieve donors: " + e.getMessage());
        }
    }
    
    // Get donor by ID
    public DonorDTOS.GetDonorDTO getDonorById(Long id) {
        try {
            DonorModel donor = donorRepository.findById(id)
                    .orElseThrow(() -> new RuntimeException("Donor not found with id: " + id));
            
            if (donor.getDeleteStatus()) {
                throw new RuntimeException("Donor has been deleted");
            }
            
            return DonorDTOS.GetDonorDTO.fromEntity(donor);
        } catch (Exception e) {
            logger.error("Error retrieving donor with id: {}", id, e);
            throw new RuntimeException("Failed to retrieve donor: " + e.getMessage());
        }
    }
    
    // Create new donor
    public DonorDTOS.GetDonorDTO createDonor(DonorDTOS.CreateDonorDTO createDonorDTO) {
        try {
            // Check if email already exists
            if (donorRepository.findByEmail(createDonorDTO.getEmail()).isPresent()) {
                throw new RuntimeException("Email already in use");
            }
            
            // Create donor entity from DTO
            DonorModel donor = createDonorDTO.toEntity();
            
            // Save donor
            DonorModel savedDonor = donorRepository.save(donor);
            
            return DonorDTOS.GetDonorDTO.fromEntity(savedDonor);
        } catch (Exception e) {
            logger.error("Error creating donor", e);
            throw new RuntimeException("Failed to create donor: " + e.getMessage());
        }
    }
    
    // Update donor
    public DonorDTOS.GetDonorDTO updateDonor(Long id, DonorDTOS.UpdateDonorDTO updateDonorDTO) {
        try {
            DonorModel donor = donorRepository.findById(id)
                    .orElseThrow(() -> new RuntimeException("Donor not found with id: " + id));
            
            if (donor.getDeleteStatus()) {
                throw new RuntimeException("Cannot update deleted donor");
            }
            
            // Check if email is being changed and if it's already in use
            if (updateDonorDTO.getEmail() != null && 
                !updateDonorDTO.getEmail().equals(donor.getEmail()) && 
                donorRepository.findByEmail(updateDonorDTO.getEmail()).isPresent()) {
                throw new RuntimeException("Email already in use");
            }
            
            // Update donor entity from DTO
            updateDonorDTO.updateEntity(donor);
            
            // Save updated donor
            DonorModel updatedDonor = donorRepository.save(donor);
            
            return DonorDTOS.GetDonorDTO.fromEntity(updatedDonor);
        } catch (Exception e) {
            logger.error("Error updating donor with id: {}", id, e);
            throw new RuntimeException("Failed to update donor: " + e.getMessage());
        }
    }
    
    // Reset password
    public void resetPassword(Long id, String newPassword) {
        try {
            DonorModel donor = donorRepository.findById(id)
                    .orElseThrow(() -> new RuntimeException("Donor not found with id: " + id));
            
            if (donor.getDeleteStatus()) {
                throw new RuntimeException("Cannot reset password for deleted donor");
            }
            
            // Set the new password directly without encryption
            donor.setPassword(newPassword);
            
            // Save donor with new password
            donorRepository.save(donor);
        } catch (Exception e) {
            logger.error("Error resetting password for donor with id: {}", id, e);
            throw new RuntimeException("Failed to reset password: " + e.getMessage());
        }
    }
    
    // Delete donor (soft delete)
    public void deleteDonor(Long id) {
        try {
            DonorModel donor = donorRepository.findById(id)
                    .orElseThrow(() -> new RuntimeException("Donor not found with id: " + id));
            
            // Soft delete
            donor.setDeleteStatus(true);
            donorRepository.save(donor);
        } catch (Exception e) {
            logger.error("Error deleting donor with id: {}", id, e);
            throw new RuntimeException("Failed to delete donor: " + e.getMessage());
        }
    }
    
    // Login donor
    public DonorDTOS.GetDonorDTO login(DonorDTOS.LoginDonorDTO loginDonorDTO) {
        try {
            DonorModel donor = donorRepository.findByEmailAndDeleteStatusFalse(loginDonorDTO.getEmail())
                    .orElseThrow(() -> new RuntimeException("Invalid email or password"));
            
            // Verify password with direct comparison
            if (!loginDonorDTO.getPassword().equals(donor.getPassword())) {
                throw new RuntimeException("Invalid email or password");
            }
            
            return DonorDTOS.GetDonorDTO.fromEntity(donor);
        } catch (Exception e) {
            logger.error("Error during donor login", e);
            throw new RuntimeException("Login failed: " + e.getMessage());
        }
    }
    
    // Find donors by blood type
    public List<DonorDTOS.GetDonorDTO> getDonorsByBloodType(String bloodType) {
        try {
            List<DonorModel> donors = donorRepository.findByBloodTypeAndDeleteStatusFalse(bloodType);
            return donors.stream()
                    .map(DonorDTOS.GetDonorDTO::fromEntity)
                    .collect(Collectors.toList());
        } catch (Exception e) {
            logger.error("Error retrieving donors by blood type: {}", bloodType, e);
            throw new RuntimeException("Failed to retrieve donors by blood type: " + e.getMessage());
        }
    }
}